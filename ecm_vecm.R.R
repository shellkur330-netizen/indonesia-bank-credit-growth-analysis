
install.packages("readr")
install.packages("tseries")
install.packages("lmtest")
install.packages("urca")
install.packages("readxl")
install.packages("vars")

library(vars)
library(readxl)
library(readr)
library(tseries)
library(urca)
library(lmtest)

path_file <- "C:/Users/Janice Jayadi/Downloads/Data Gabungan Jurnal.xlsx"
data <- read_excel(path_file)
data_clean <- na.omit(data)

credit  <- data_clean$Credit
birate  <- data_clean$`BI Rate`
inflasi <- data_clean$`Data Inflasi`
ipi     <- data_clean$IPI

#uji stationeritas
library(tseries)
adf.test(credit)
adf.test(diff(credit))
adf.test(birate)
adf.test(diff(birate))
adf.test(inflasi)
adf.test(diff(inflasi))
adf.test(ipi)
adf.test(diff(ipi))

# Regresi Jangka Panjang
long_run_model <- lm(credit ~ birate + inflasi + ipi)
summary(long_run_model)

# Ambil residual
residual_ecm <- residuals(long_run_model)

# Uji stasioneritas residual (Harus stasioner agar bisa lanjut ECM)
adf.test(residual_ecm)

#ECM Jangka Pendek
# Membuat variabel difference
d_credit <- diff(credit)
d_birate <- diff(birate)
d_inflasi <- diff(inflasi)
d_ipi <- diff(ipi)

ect_lagged <- residual_ecm[-length(residual_ecm)]

# Model ECM
ecm_model <- lm(d_credit ~ d_birate + d_inflasi + d_ipi + ect_lagged)
summary(ecm_model)

dwtest(ecm_model)
bptest(ecm_model)

plot.ts(cbind(credit, birate, inflasi, ipi), main="Tren Variabel Ekonomi 2010-2023")

#metode VECM
data_vecm <- cbind(credit, birate, inflasi, ipi)

# 2. Tentukan Lag optimal pakai kriteria AIC
lag_select <- VARselect(data_vecm, lag.max = 8, type = "const")
k <- lag_select$selection[1] # Ambil lag terbaik

# 3. Jalankan uji kointegrasi Johansen
johansen_test <- ca.jo(data_vecm, type = "trace", ecdet = "const", K = k)
summary(johansen_test)

# 4. Estimasi VECM
vecm_model <- cajorls(johansen_test, r = 1) # r adalah jumlah kointegrasi
summary(vecm_model$rlm)

# Melihat respon Kredit terhadap shock dari variabel lain selama 12 bulan ke depan
var_from_vecm <- vec2var(johansen_test, r = 1)
irf_credit <- irf(var_from_vecm, impulse = "birate", response = "credit", 
                  n.ahead = 12, ortho = TRUE)
plot(irf_credit)

# Hitung kontribusi masing-masing variabel
fevd_hasil <- fevd(var_from_vecm, n.ahead = 10)
# Lihat kontribusi khusus untuk Credit
print(fevd_hasil$credit)

Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED94D9544
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580088; cv=none; b=CjRAA4FKPc4KQRsBpu9aap4+DjMlvYDs2y32XdxCZrmJtVsxZQ1zPc7atcQlYnPhlT8qta8RcFqXHwPBS/g2vK/7DoneFTowuDCSgDaTxz9Pr1oPu4bYeRGDlEUgG1nx7nN1ldqOSTNaokrBIJqzQ/BM/lqdGbvBllJaHn+Buw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580088; c=relaxed/simple;
	bh=iwDKG6ahLu03ZTpVgkhI8rsprMAFlZ0EjKbSWmFEPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYvyttvE4H+UQ9UREq4trq3jj6nkY9STO6WQPYwDo3uFuW8z0NrzBkieALQRrS7JU4kHsbD7nLn+fmn09gxxEjtE9+pAMpcaBEVy0LM0pAc8vMwi3dqWAWX+cJxawEGP2iYylT5QC7vaJFJLpTYVNMCdw6xt1Sly98zGzdbczYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkFhepWE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkFhepWE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49e73e541d7so5197555e9.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580075; x=1790184875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1iqGmORGiRLjddmmjFvHkR4msXAhMvLmPlXq2zOjXno=;
        b=dkFhepWEgwyU53DSz/jd8q7yWvo+jGTk37Cs9oDj3SUC+TLQ+UZ81z288AQoKpptqq
         0k+2YfDA3wWmHVjwHo6vxI9tNqqIncWybVnNXveZYfZ/rERI0Zcl6dfJ0HszQGuzZ0Os
         xxu0UpC9zDZvovwLZfYLGdZjDciPDD5M0nSTyPdd1VfWpRQOcTOSzxzFrAHiV7ov6vPB
         gFFMCtQuNqHfUU0zQN+rV0+4klqrM65BalHxdD/iSTUZk0p2TrYWFRfgWh5Hv0+0pC84
         ihr2AWq22EsK3mqvwD72vId9LDWsUhKn+hLsbhDDWpIaUTGZxeniZHTUA6ZKnprtckZK
         REfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580075; x=1790184875;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iqGmORGiRLjddmmjFvHkR4msXAhMvLmPlXq2zOjXno=;
        b=ta8KJMQTy4F2y9s1ok6RnO3jDhw/JY5/M5U4tyknAbUw86qFxpSOdfdSLiBce3DHjc
         VGVi13u2Ij6HbQEHRJvdAjeZFLz9YxQQKjlJ3xUA656IBPaimBzIrB87Y3gZgNAcQ0VZ
         aGlqsfD/m4eh9iu1y29NoDfiFADwv2qBSUbMJHwSy60m0fCKwRgpS11Do7atpPEu+eF+
         XYljbh4m0qvA5OMhTyoex22uEkcwRM8ZItSMOZlRPndjvE2HWMDUSWtte6hwu5cn1gcg
         E14ylDP5fTrG1kcq2ZVrEhOwyUZh/2J6nm3Vwk+ZgoKqLBMCzoPiS4lGbw/O3NoA558h
         jm8A==
X-Forwarded-Encrypted: i=1; AKwUvBxVukB9nhdyEKDm+rzRxpvi7GZUiHkUwes5jbCEifZ8moxLoFcWc4DhWc3d5SUV4KAh3241WDc=@vger.kernel.org
X-Gm-Message-State: AFuF++nCdjbO/cV5KwSZQqxn8sjP+0NLuhwzTCb1i983PtWOlPvpeahZ
	h1FxY6t1ZDxlnvlnjKtB14CTXCjFjLloPh5Gki2Vi68g1+Ndohw7gkO1mukE
X-Gm-Gg: AYBFou0kKZEoGArlWAGc6+yyDjJ6jXvm3iReRiQSjOgv4REhd4ETmgkxzYPfUNF2Pri
	KyzHDd18hAALXWIhaFNwgTN02XWZjd1XryKFIjuBhnNsyXt4MLazE/WR9oGLPxBg+2ZhRf/gaiz
	0/ekgo61P+wDb1Y24J6St6+gWsrUe4gAmIT3mHvcsu8HvbbAeXYvUNGiBSQQPcjEOHIeXCh8DzC
	bUUohh1fsOASp4lyGEPa6QYCNV/M/sWc7sOYTsuO9nh1lra3ckrl8XhpSsH/2ESMclo5nu+P598
	5mm1sfLGaO6xq1bYWms5sNntboeIyIyouIpKU1uGIic6s0FCUT6VY9K1cXr/gUONqboiFPnvtTl
	7ycnkTLsHitbhLCQQecHN4XkMUsfZ80CEi9KTncCS0dmqS4vr1SHjtx9GDkLiB4EjVQDT69ME1z
	rGGGdxPJ+kjNp6D+g/FqbjX1uL579hP2pRyflQI5Izjb8+Tuxn9JAd4QM6hcqrqHyEQ/UipaIwx
	3u5gYLaVQrQpiCry/ous5Jy8nuAAxosW+xojsyFsmVi8csJRUTQNI1lWPSfxaBvAemZpewi2rFx
	eHAAOmBKZqdEHl8=
X-Received: by 2002:a05:600c:81c5:b0:49d:28fc:d6a0 with SMTP id 5b1f17b1804b1-49fbd200256mr6225295e9.18.1789580075031;
        Wed, 16 Sep 2026 10:34:35 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:34 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W . Linville" <linville@tuxdriver.com>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next v4 1/8] wifi: ath9k: return an error from a failed multi-register read
Date: Wed, 16 Sep 2026 20:34:22 +0300
Message-ID: <20260916173429.403889-2-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ath9k_multi_regread() logs a failed or timed-out WMI read and still
copies its result buffer to the caller, so the caller gets
uninitialised stack data for every register it asked for. The MIB
counters in ath9k_hw_update_mibstats() then take arbitrary jumps, and
an EEPROM read at probe fails on the checksum rather than on the read.

Give the multi_read op a return value, return the WMI error from
ath9k_multi_regread(), and check it: skip the counter update and fail
the EEPROM fill when the read did not happen.

Fixes: 09a525d33870 ("ath9k_htc: Add multiple register read API")
Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 drivers/net/wireless/ath/ath.h                |  2 +-
 drivers/net/wireless/ath/ath9k/ani.c          |  4 +++-
 drivers/net/wireless/ath/ath9k/eeprom.c       | 10 +++++++---
 drivers/net/wireless/ath/ath9k/eeprom.h       |  2 +-
 drivers/net/wireless/ath/ath9k/eeprom_4k.c    |  4 +---
 drivers/net/wireless/ath/ath9k/eeprom_9287.c  |  7 +++----
 drivers/net/wireless/ath/ath9k/eeprom_def.c   |  5 ++---
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |  7 +++++--
 drivers/net/wireless/ath/ath9k/init.c         |  6 ++++--
 9 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index 34654f710d8a..d1af0b81768a 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -126,7 +126,7 @@ enum ath_cipher {
  */
 struct ath_ops {
 	unsigned int (*read)(void *, u32 reg_offset);
-	void (*multi_read)(void *, u32 *addr, u32 *val, u16 count);
+	int (*multi_read)(void *hw_priv, u32 *addr, u32 *val, u16 count);
 	void (*write)(void *, u32 val, u32 reg_offset);
 	void (*enable_write_buffer)(void *);
 	void (*write_flush) (void *);
diff --git a/drivers/net/wireless/ath/ath9k/ani.c b/drivers/net/wireless/ath/ath9k/ani.c
index 41d192709e8e..6d9f0ee26237 100644
--- a/drivers/net/wireless/ath/ath9k/ani.c
+++ b/drivers/net/wireless/ath/ath9k/ani.c
@@ -111,7 +111,9 @@ static void ath9k_hw_update_mibstats(struct ath_hw *ah,
 		       AR_FCS_FAIL, AR_BEACON_CNT};
 	u32 data[5];
 
-	REG_READ_MULTI(ah, &addr[0], &data[0], 5);
+	if (REG_READ_MULTI(ah, &addr[0], &data[0], 5))
+		return;
+
 	/* AR_RTS_OK */
 	stats->rts_good += data[0];
 	/* AR_RTS_FAIL */
diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index df58dc02e104..6bf86d017c13 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -76,7 +76,7 @@ bool ath9k_hw_get_lower_upper_index(u8 target, u8 *pList, u16 listSize,
 	return false;
 }
 
-void ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
+bool ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
 				  int eep_start_loc, int size)
 {
 	int i = 0, j, addr;
@@ -88,7 +88,8 @@ void ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
 			((addr + eep_start_loc) << AR5416_EEPROM_S);
 		i++;
 		if (i == 8) {
-			REG_READ_MULTI(ah, addrdata, data, i);
+			if (REG_READ_MULTI(ah, addrdata, data, i))
+				return false;
 
 			for (j = 0; j < i; j++) {
 				*eep_data = data[j];
@@ -99,13 +100,16 @@ void ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
 	}
 
 	if (i != 0) {
-		REG_READ_MULTI(ah, addrdata, data, i);
+		if (REG_READ_MULTI(ah, addrdata, data, i))
+			return false;
 
 		for (j = 0; j < i; j++) {
 			*eep_data = data[j];
 			eep_data++;
 		}
 	}
+
+	return true;
 }
 
 static bool ath9k_hw_nvram_read_array(u16 *blob, size_t blob_size,
diff --git a/drivers/net/wireless/ath/ath9k/eeprom.h b/drivers/net/wireless/ath/ath9k/eeprom.h
index f1cde43fcb55..dc5ad4a3e752 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/eeprom.h
@@ -680,7 +680,7 @@ bool ath9k_hw_nvram_read(struct ath_hw *ah, u32 off, u16 *data);
 int ath9k_hw_nvram_swap_data(struct ath_hw *ah, bool *swap_needed, int size);
 bool ath9k_hw_nvram_validate_checksum(struct ath_hw *ah, int size);
 bool ath9k_hw_nvram_check_version(struct ath_hw *ah, int version, int minrev);
-void ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
+bool ath9k_hw_usb_gen_fill_eeprom(struct ath_hw *ah, u16 *eep_data,
 				  int eep_start_loc, int size);
 void ath9k_hw_fill_vpd_table(u8 pwrMin, u8 pwrMax, u8 *pPwrList,
 			     u8 *pVpdList, u16 numIntercepts,
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_4k.c b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
index 3e16cfe059f3..d5a8275ceb03 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_4k.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
@@ -53,9 +53,7 @@ static bool __ath9k_hw_usb_4k_fill_eeprom(struct ath_hw *ah)
 {
 	u16 *eep_data = (u16 *)&ah->eeprom.map4k;
 
-	ath9k_hw_usb_gen_fill_eeprom(ah, eep_data, 64, SIZE_EEPROM_4K);
-
-	return true;
+	return ath9k_hw_usb_gen_fill_eeprom(ah, eep_data, 64, SIZE_EEPROM_4K);
 }
 
 static bool ath9k_hw_4k_fill_eeprom(struct ath_hw *ah)
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_9287.c b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
index c139ac49ccf6..73213416fc8c 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
@@ -55,10 +55,9 @@ static bool __ath9k_hw_usb_ar9287_fill_eeprom(struct ath_hw *ah)
 {
 	u16 *eep_data = (u16 *)&ah->eeprom.map9287;
 
-	ath9k_hw_usb_gen_fill_eeprom(ah, eep_data,
-				     AR9287_HTC_EEP_START_LOC,
-				     SIZE_EEPROM_AR9287);
-	return true;
+	return ath9k_hw_usb_gen_fill_eeprom(ah, eep_data,
+					    AR9287_HTC_EEP_START_LOC,
+					    SIZE_EEPROM_AR9287);
 }
 
 static bool ath9k_hw_ar9287_fill_eeprom(struct ath_hw *ah)
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 5ba467cb7425..085e544f7c4b 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -112,9 +112,8 @@ static bool __ath9k_hw_usb_def_fill_eeprom(struct ath_hw *ah)
 {
 	u16 *eep_data = (u16 *)&ah->eeprom.def;
 
-	ath9k_hw_usb_gen_fill_eeprom(ah, eep_data,
-				     0x100, SIZE_EEPROM_DEF);
-	return true;
+	return ath9k_hw_usb_gen_fill_eeprom(ah, eep_data,
+					    0x100, SIZE_EEPROM_DEF);
 }
 
 static bool ath9k_hw_def_fill_eeprom(struct ath_hw *ah)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 6de78ae85726..3798d3375158 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -252,8 +252,8 @@ static unsigned int ath9k_regread(void *hw_priv, u32 reg_offset)
 	return be32_to_cpu(val);
 }
 
-static void ath9k_multi_regread(void *hw_priv, u32 *addr,
-				u32 *val, u16 count)
+static int ath9k_multi_regread(void *hw_priv, u32 *addr,
+			       u32 *val, u16 count)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
@@ -273,11 +273,14 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 	if (unlikely(ret)) {
 		ath_dbg(common, WMI,
 			"Multiple REGISTER READ FAILED (count: %d)\n", count);
+		return ret;
 	}
 
 	for (i = 0; i < count; i++) {
 		val[i] = be32_to_cpu(tmpval[i]);
 	}
+
+	return 0;
 }
 
 static void ath9k_regwrite_multi(struct ath_common *common)
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 2f0c4ef86b7e..e425d355bf94 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -201,13 +201,15 @@ static unsigned int ath9k_ioread32(void *hw_priv, u32 reg_offset)
 	return val;
 }
 
-static void ath9k_multi_ioread32(void *hw_priv, u32 *addr,
-                                u32 *val, u16 count)
+static int ath9k_multi_ioread32(void *hw_priv, u32 *addr,
+				u32 *val, u16 count)
 {
 	int i;
 
 	for (i = 0; i < count; i++)
 		val[i] = ath9k_ioread32(hw_priv, addr[i]);
+
+	return 0;
 }
 
 
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424015;
	b=fDqn5NtiRsJHGc5zGg79m0X6dag4ghzUD5YjrHMW3PFArYWz3e2HR6sPEx7hOvloFFay
	 ICcDnjcYPHGRdEvGAujnqG0WOtJIDapGJyiKIvJfIR1BOH5mViITDuAC1Mfx9c9NfYFnM
	 Ob3KWekws8xb930ocH96qoJIiqUmmhQ9dS7BH+HxjpIQGOoamybFz001SQBa2kMSACd+q
	 4yvE+QUp7U0meLHIOgKtTSbioUSmRLd0CwjZOuFHApkki0NbM+IaS1G/rGs9F8Un5cnee
	 pj7m9BIDU3qRJkCOjA4elJ3d/1GNQx4j0pfjaetvl6oANKyafWhVr6f9rLhWLn4bExQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KcbrnnbeRkvyshvSAkYPGjx7mv5yPTqvBatwp6TQmLY=;
	b=IEjssRkAS4LkJkYTA4jeh7O2W2y+NX1J+oFfVtnfXrNNhsRJRGAsemyb7eNKlejgfQl+
	 lh+nuFxyiWTxk6IoXzysBGXKe1YSJDLH06e7RbmZXazou7HS0PtpSidqs90Gf96suVC8l
	 1V5Z15Pj++TPN0xWNC5LZOnEi3nH6yOYZk6CFCfssVowBk6X4qRLuk4w8lbPBgGdbsjAq
	 XMxuj3i3ID+C3di/ewtHBLa83g/TdSmQZhtEzYlavwMGOImDmPfZPydsbTkuEZ3s2AUdb
	 si2GrMtAsCBujnoPcMMzZJcdKh02kFktNFZKBnQEXuMNABHEImKyci2Fux2AuOEMAQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6GWAdAi;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704060774C5
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4704060774C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6GWAdAi
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so8440291fa.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424013; x=1793028813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KcbrnnbeRkvyshvSAkYPGjx7mv5yPTqvBatwp6TQmLY=;
        b=g6GWAdAi1yeXRfrYHKKs16zq3vHYV/zmqgZLAGzx2aU6qRmVmjoieGfwiEiKoaCD15
         3tB3rgbYKC9X31AjdDrMiR6au3KzBFfm7x/go1tY2ASzSQLmtX6q9Wq66y7YZLoDGOr6
         y/Wp0iOKXMyn9TDpeV/LgkgPUgCuikmPF8yTky5J+cjWda1EN1TlaPZI1P8TniOPvKtG
         r0CDG7kYwz7+jNXsbCf9BXCqbSAtu89kUlaycQLpoizY0ojN5AFyvWwDBsDEZOxMVoBa
         U6+aXOlq4Vby1amC3TvhObR1CzF6fIm3ZowSlUNQlcDNbvb7JlTbwk57P9uu4nY0T6Bi
         HdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424013; x=1793028813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcbrnnbeRkvyshvSAkYPGjx7mv5yPTqvBatwp6TQmLY=;
        b=kRbLHiPy67Gk+pMOxNPo671Jgql2GERewjgZTVy74OCzlamLEVe39PbpDDUwugvpgn
         UBCY7Ajr2jJF8ZyLKm6vKl3aa8uHkBCt7ha08l+9OKI2TtlGE+QxzlC2NZu7sXjvs1pZ
         06IIEdxWCRS9mL03z+YlG6spFbN1Kx3p2JFbXPYlftPoK9VWIlc77+T4XY/ns27IBsH8
         n7FKzMV/AJ3YuWp7a6otHfE88erRnxb1vH1h3jK5Svz8IfG9L/caSuZoZESHpbjjRyjY
         7Ek80ZhI1azL+WY0E0JEUH6alXM2F1f//Vv2MhTtsY/9gSzMXhv5eiu1SzgIN8EMfftl
         Jn1Q==
X-Forwarded-Encrypted: i=1; AKwUvByhTOOYTpPOdJ9llqLJQp8LcPmO73Wuk2rqcbQyEQcaANkGWD8G9XxCF2XGUYmTrGYFidoHcDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgx4pX7vkTQ5GDPEaZrjA2Tck6nrjHBMm8xOsbU4glDx4Gm8SJ
	xnLPQMnwqgsNYwSKImeAOeQz6dtTerSFtv/ADAh96oK1dlXFa2PGnNto
X-Gm-Gg: AYBFou1QO4inQTnbM3QIt3wwejGZp1OfphqPOyjWQKdbxvG8P3A3qeFGJwZEiODmlkd
	K/6JhNzZ96BHLAdjXROlE+9Yz1VlodsN8qTc7fY3XQLhT+ZEdsL0yYRtFOVYSXpNtTZvfmp1ZWD
	tnoXkrUdzGpqxpmRbB6aYKL92rHefLFL6Kp+1BCqW5rx5vxabgJMObgGVvhEGN75opUQ4Z3i4rl
	zIYLbhEm/FYg2hzRilPGhgdkvR9YQsmhdaCocBoZL2cq53kaccPZbEoMlmnc7vq64ce15yhWFvt
	Z5L1pDIcswts9LIzQqVWgJu4ttM/OWpVWpHrMRMxn2QcNOjijrKSqib6gunaCvkMTtzysy+74YS
	JvjRvjiB2mUIqiWbX/2jri1QXt1+TjIIEV99KdgiqWsOJGrxQWATtYShtxqYZBazjPJ+xygVnX5
	bWlapY369Pq3ocJ+iUBoOMfqlcHesbDdJdMohG1wL3dj5GJYqS5G3uCTXzhgfk7NxxWpJUAMbdo
	CgW8XZj8sdTpDJL1Ba/8l1dIcqi0ij8H+JPymznW8Png6tgl1RYu0Z21qAXzGFeBldqIkKhvXru
	SX4vjBuF6uAFMvB2Ag==
X-Received: by 2002:a2e:ac13:0:b0:3a9:9c1f:1b9e with SMTP id 38308e7fff4ca-3ab2927bad6mr19434391fa.4.1792424012906;
        Mon, 19 Oct 2026 08:33:32 -0700 (PDT)
Received: from yantra.. (nekmmqvd1y84bxeinum-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:da13:4805:c131:eb3e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab3c2ed29csm11870571fa.11.2026.10.19.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:33:30 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: pressure: dps310: wait for a new sample after a ratio change
Date: Mon, 19 Oct 2026 18:33:28 +0300
Message-ID: <20261019153328.80739-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After an oversampling ratio change, the sample waiting in the result
registers and the one being measured are both from the old ratio, but
are scaled with the new one. Pressure ratio 2 to 16 reads 192 kPa instead
of 103 kPa, and temperature is off by hundreds of degrees. Pressure is
also wrong after a temperature ratio change, as it is compensated with
the cached temperature.

Discard those two samples on a ratio change, and for temperature cache
the one after. The ratio write now blocks until then.

That wait can be longer than the 1/rate timeout, after which the driver
resets the chip and the ratio silently goes back to 1. Allow two periods.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Tested on a DPS310 on a BeagleBone Black. Applies with or without the
ZTS8032 series.

 drivers/iio/pressure/dps310.c | 51 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 00f6be126326..e6b27cf26cec 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -78,8 +78,8 @@
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
-/* Silently handle error in rate value here */
-#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
+/* A period plus a measurement time; silently handle error in rate value */
+#define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))
 
 #define DPS310_PRS_BASE		DPS310_PRS_B0
 #define DPS310_TMP_BASE		DPS310_TMP_B0
@@ -354,6 +354,18 @@ static int dps310_get_temp_precision(struct dps310_data *data, int *val)
 	return 0;
 }
 
+/*
+ * A sample measured before a ratio change would be scaled with the new one.
+ * Reading it clears its ready bit, so the next read waits for a new sample.
+ */
+static int dps310_drop_sample(struct dps310_data *data, unsigned int reg)
+	__must_hold(&data->lock)
+{
+	u8 val[3];
+
+	return regmap_bulk_read(data->regmap, reg, val, sizeof(val));
+}
+
 static int dps310_set_pres_precision(struct dps310_data *data, int val)
 	__must_hold(&data->lock)
 {
@@ -369,8 +381,12 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 	if (rc)
 		return rc;
 
-	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
-				  DPS310_PRS_PRC_BITS, ilog2(val));
+	rc = regmap_update_bits(data->regmap, DPS310_PRS_CFG,
+				DPS310_PRS_PRC_BITS, ilog2(val));
+	if (rc)
+		return rc;
+
+	return dps310_drop_sample(data, DPS310_PRS_BASE);
 }
 
 static int dps310_set_temp_precision(struct dps310_data *data, int val)
@@ -388,8 +404,12 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 	if (rc)
 		return rc;
 
-	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
-				  DPS310_TMP_PRC_BITS, ilog2(val));
+	rc = regmap_update_bits(data->regmap, DPS310_TMP_CFG,
+				DPS310_TMP_PRC_BITS, ilog2(val));
+	if (rc)
+		return rc;
+
+	return dps310_drop_sample(data, DPS310_TMP_BASE);
 }
 
 static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
@@ -651,6 +671,7 @@ static int dps310_write_raw(struct iio_dev *iio,
 			    int val2, long mask)
 {
 	struct dps310_data *data = iio_priv(iio);
+	int rc;
 
 	/* Reconfiguring mid-capture would change the values being captured */
 	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
@@ -677,10 +698,24 @@ static int dps310_write_raw(struct iio_dev *iio,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			return dps310_set_pres_precision(data, val);
+			rc = dps310_set_pres_precision(data, val);
+			if (rc)
+				return rc;
+
+			/* A measurement already running finishes at the old ratio */
+			return dps310_read_pres_raw_locked(data);
 
 		case IIO_TEMP:
-			return dps310_set_temp_precision(data, val);
+			rc = dps310_set_temp_precision(data, val);
+			if (rc)
+				return rc;
+
+			/* The next sample is the one cached for pressure compensation */
+			rc = dps310_read_temp_raw_locked(data);
+			if (rc)
+				return rc;
+
+			return dps310_read_temp_raw_locked(data);
 
 		default:
 			return -EINVAL;

base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.43.0


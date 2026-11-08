Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173036;
	b=UfLC4dqs9lp/RB1Vz80Hj71l3y3WhoBGW/4NpFYHcip0rfo225DLQrND6Vlz4nbRx4p4
	 Bm9be0J/GLZ4SbEuJ4Q6+hCXeuT2DyKh0UMXpTc3nXWDZeXwKWT+T0aAke9EneCSYe0mc
	 1gVRPctGL18lF4zHx/PPkyWHJKhCnQI2sOOiafAnQNPc4hqSDKX+AM9qs0RmxElN6DAHm
	 YgKIInYerUueNXZBJRM2dfBA5444272GSYlXNxofgF4SwinA5TB2DnR9oPhTQiocG6aVv
	 ZwDT35x88HNKtyvSsQmjMUTE2aFT/8IMN7us/mDU65rYfGA9XVJktvkOraVmLI0H2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=V99b1R97qH/1vch1IDRgvyZu2Doy5l4KvwZ7hr979kc=;
	b=fsGhLuYL5JKjpQNe3xEm045+QbLs3IQAkCXsnVOuBeQKTMSzqDZPlHbB7OZWKMnMwcag
	 YsrFk2yHyjRAiQB/qD/wA3c856dEefWdsiwe0KG2I47qo6ygfxDRST36detdY4W2+ucQC
	 p+RPAIIA9e+yd8U4i/03LT16kIcQpAFiRwDhWZcz2Qk1iIEro90m5gKEmfpBqedhakw4k
	 lc8Okzo0VTEBF0dW9G9lWW6mSTr8a3HR3C1YuRwSRyR0+4lVRZ5iCIAH3iKn22Q1jirtE
	 J4zjScNuAtEXPPcmMw8J9YYaqR8zuazGm7osmxMNTr0kozTiDGA3ELwzVvzV/XwrIMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+NzeIvt;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D1606A336
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245D1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+NzeIvt
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6deb848ddd7so173848eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173035; x=1794777835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V99b1R97qH/1vch1IDRgvyZu2Doy5l4KvwZ7hr979kc=;
        b=c+NzeIvtN5CpBoxOmvMnL1q5N37MXUnz3YsVvwCdNJoBEkkTdauZKzhQaWDoJ9dLQP
         RbjEyrcbCsSeBcDBfQfH86dMtBunEqVH3U6YIaOuV7Ez9mqd+R2M5ryh+6mHQyaN+jP5
         C1uguHgO4U6hPbTFtV9b7V8yMPd8hikwxDpR0M2VKFfmQpIiE9qJ939uMSf/h9Rpirja
         VbVpC9TU2CPLi8JEwmU3WNpyzc1rBMM4jowg8gWD3n1fS/dDFwQgUrhrpnNnren8ve0F
         W/RbECINKa6wstr9TFL0scqjePeTlleN63U7X3MdTCCobzD9wBlesPurt/dwDPiFOo5O
         /gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173035; x=1794777835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V99b1R97qH/1vch1IDRgvyZu2Doy5l4KvwZ7hr979kc=;
        b=rTCZ3W8+5vKqm+IrKd3O4jrDMUJYiku9E7KUdztGgLzBJB3mkebsNY40fmL7xJKSr5
         3rXJeMQRLb0jF8yag1pUl1MHhubVsa1gu7kT/zXrYMkwfr2WVaRfm98j0MzGXR5lcbtY
         5oujQaVK/KzyK8wAyp5olvHJoT4nb+fx6+2F8zcdzZFO41Z7ZuGC8x9c3k4SAGyi7lQU
         aB56rvBTBtAKBzBlJ2GhkUGzw185iDxxz1Nzd1g6kIqw+rmKgU6TViTQ02oQi+0V2Oaw
         9HLd95zv5m4CRa6gna9nZtNgQ8tJyAmB6exAUS6wwM5XcAZbBcCKZtdrDr9g7oxS4J0t
         doEw==
X-Forwarded-Encrypted: i=1; AL+hErGFWa13A7R4RwbJoE+Ow6iso4ZUzjfhUTJmK0YFYrHOqh/piQQUGkQTXzWCEBURdlDZ9pmzoH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JLx8gU3dUKAJ7eCLkoadk4p4o2//8pvGLbgTdeQWaf/E2CsGl
	FrXi/RarD5HT3oEGaS48lBR9+8I+jQ2QLOs41xgdnmlzqqGhWFP/HUalhCFN3w==
X-Gm-Gg: AYBFou10U5k9PU4v9yLiSRt7Ne6Ks8ImC8W4OrHaCiaaDygkunh2GewrFq6RR0PV1sU
	xBM7Ufp9NS+w8Nkz/snkIjoLrP+RpvbP2g0DuHUEPhlME01mSWFP16/WUsFD5cAdLvTa39e+VBj
	9k5PyJQeiftS6RCzrli6nPCrgkQieGxrvSv330oIz/o+cejoCfpy2nagnrolBOM5ZvHt0idk9sN
	XXuhFFPalcDh9eJZnnPCwuysF2tywOgDuO5qx1BGoC1YMRO7U57R/CZh4/zajg7cgw9Ox+mjX1B
	d8JGAdYHLksL/PfmKZV/v9L7ISRSEhLPIQ+Zgg0hiabtGHJrg3Bw2bL2uE00yGeaYIukU+3b4gp
	V/QPEt18xnga4X4A+Vq1IPW01sHXIkDgav5THwMehIeBUBuH8bPC1de4mRLo16ZMZIVjPHCputj
	uXGlHGx5mHCh516L9JlpczF4kpzKhvbzmlaDp1rN1LPCy5mVpONCj8l9gcGqVTdPJU49JGR+pVZ
	HFBvanAPEcruECIHs+jLs/88eFxso9m54TCweeZ9+cfDyhHkX2pWLojjTd7NE4hqR47NBnsnN8n
	DwyT3hNl3EIc20GmI4vegj8csPCUTPmiM66unsRDv7v+fLclg8Pi7VbCBQbHYDc8omeNyi66byU
	4sxvHLIYlmMXsZ13SHpyu1zrKTwKAORkBy9D8YF18tX9bW5gWQUGlg3lXMfcXovBWOz+O3+d7pT
	f9e5Mcwp77tSZJwknMruF/ghmuY3zYEePApyBOHqcx3DtO1ZVFlks=
X-Received: by 2002:a05:6820:570a:10b0:702:f7c2:1937 with SMTP id 006d021491bc7-7170f35c361mr769608eaf.83.1794173035037;
        Sun, 08 Nov 2026 13:23:55 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1908138eaf.12.2026.11.08.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:23:54 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:23:22 -0700
Subject: [PATCH 1/2] mtd: rawnand: macronix: serialize OTP access with NAND
 operations
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-rawnand-operation-locking-v1-v1-1-565010fc5f8b@gmail.com>
References: <20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com>
In-Reply-To: <20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The Macronix OTP callbacks select a target and issue feature and page
commands without taking the chip or controller locks. Normal NAND I/O
can interleave with these commands, use a different target or access
pages while OTP mode is enabled. OTP I/O can also run while the chip
is suspended.

Make the existing NAND serialization helpers available within the raw
NAND core and hold them across the entire OTP transaction, including
restoring normal mode and deselecting the target. This uses the same
lock ordering and suspend handling as normal NAND I/O.

Fixes: e87161321a40 ("mtd: rawnand: macronix: OTP access for MX30LFxG18AC")
Cc: stable@vger.kernel.org
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/internals.h     | 2 ++
 drivers/mtd/nand/raw/nand_base.c     | 4 ++--
 drivers/mtd/nand/raw/nand_macronix.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index b8b29341b88c..2668f527e637 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -81,6 +81,8 @@ extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 extern const struct mtd_pairing_scheme dist3_pairing_scheme;
 
 /* Core functions */
+void nand_get_device(struct nand_chip *chip);
+void nand_release_device(struct nand_chip *chip);
 const struct nand_manufacturer_desc *nand_get_manufacturer_desc(u8 id);
 int nand_bbm_get_next_page(struct nand_chip *chip, int page);
 int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a5b278ab9384..f125c529c62d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
  *
  * Release chip lock and wake up anyone waiting on the device.
  */
-static void nand_release_device(struct nand_chip *chip)
+void nand_release_device(struct nand_chip *chip)
 {
 	/* Release the controller and the chip */
 	mutex_unlock(&chip->controller->lock);
@@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  *
  * Lock the device and its controller for exclusive access
  */
-static void nand_get_device(struct nand_chip *chip)
+void nand_get_device(struct nand_chip *chip)
 {
 	/* Wait until the device is resumed. */
 	while (1) {
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 03237310852c..4fe7036ae992 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -380,6 +380,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 	int ret;
 
 	nand = mtd_to_nand(mtd);
+	nand_get_device(nand);
 	nand_select_target(nand, 0);
 
 	ret = macronix_30lfxg18ac_otp_enable(nand);
@@ -426,6 +427,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 			write ? "write" : "read");
 
 	nand_deselect_target(nand);
+	nand_release_device(nand);
 
 	return ret;
 }

-- 
2.53.0


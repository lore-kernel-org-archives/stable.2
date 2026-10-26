Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056154;
	b=0jIsb8V/jOb8/SrOebvEnoqajhDdWJnpjcwUnv47vxn4yNZdFB7oTy6yOqkgPhCU54Hi
	 Gb5yqe0SwFCB9rnGysY/f4r5IIjCSLE6bUDAJdISVbz4e9UF481K3dfnDx7HOTdUmXYBd
	 4QYTIQwLue8gqnGR28m+DSCLtJEg0cZH60h4+4r8nc0hFiSFXVZLc3Igvx6bB9XbS/GpO
	 OKVxLfAMiYo3f3P+U7KemYZYr7NfTt3mFMXHFTXUpkR9hNLncICjxNujscT0t3uPVQ+Nm
	 IBP6utZzAnXT/nMYqpP0zBBQbPBL7v5n15GVji+iD4/fVknZv4iTJoQMgsoQQ3YE3QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
	b=bCU7Cn21TMF23LJl7qTsU7HxGoibzYaW/NV6HjYJRosFi6kPNReI02Bg2BtsSTBjv3ev
	 QsqVuJ0GMbV+50MNe8GoTX9FPAawb4b/L9T7sAjcYCOnX78+p2d2pp88TRHMKxQ2Q4oXL
	 TMrHNV8oHPmwxIHiXhmEUSxvGJBnu7W0sSD5yjrjHXIPYU4DSbXadb8xa0ooQxfFaD5Id
	 VzTQShFKAP9AvQl1uFrKbb9ynfr6gufP94xdO/hg7RqvGtEuFNhn854wIcOaZlGndqrOx
	 MgbJqy8w1SoAzEnP67ScwpDPtp3ZbXU1kHOO+o4czlDLkZQbnFvGvf1qVPK05ctzfFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fkbUb/56";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763F606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7763F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fkbUb/56
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso259145f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793056153; x=1793660953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
        b=fkbUb/56Bl74RQSphNz0p8W+Mm2Ev/DD+y4zNjH64dRcg/FKJBexRdR1kcS3oX10Vw
         bVZ0CfGuyq2Yd4JtIObFLCtxnUGssJ+dBDtwpsPMna2aUh0pVgFp6ytjfYSV9Tz1Nwe6
         gi2f5XdZAg2vT5gwASgzLqAEFDwE6x3mpfWFMaSVFz6iJceK9eDMaTBmqmlGyM+Z8JSd
         f3hGAFFJfFw3QrW4ve1JsE3v81nNwFkK/C/kYdGK9N1q74KO3BuDAKzkWtt8XySaW7xs
         mMty9CwigLU0wvj7vBIOeKcaOeJqgnUsFp32eFvrPsDG+Mw0ErwCwU7crwsBGOPt0ryv
         MzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793056153; x=1793660953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
        b=ReLdlqVBGSuhRuVb1TlBFK81105DECo+HB64HcQp4q++nxZ3xpI4qJ7zBgj7xrnf5O
         7r6NvCn58VeJpYl+DjUG4yvdWD5Q0OuiQxr0K5jFCuPln+xS91+qE/cHHqbvIV2ZAA1W
         +DmgZWShdWJCalUK7XVA/slJnFIBrkx+oMcXciEEKmnXq03zlOQPUnyjmiIbOYZRwW9X
         bayGbq13AUq7y0dsMumkFc85gLCwnBbOxR9QsJ8nIqTTxpyJg/YBuinpgi1lsMcUBgMa
         wPlASNl2Y8tT0X1ddP+ddW5KeDO0EQN/MmwfoxkCKu4/8XeWbbJEq0PHqQ78REVFJcag
         JeMg==
X-Forwarded-Encrypted: i=1; AKwUvBzBRtN+ynZxAkGnwSzV/asg3ZyT4XcWrBwXlH0cfFKmSoLk6GpIhPHEswVBA14BhRqDFEqKkFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyGr1X4mTH844Y7vV14hy2iH2FMouVa8QkTfuvY4TheqrsbD6b
	xqY4u3KQ4U85E8MAzd59aHCfrzzHbjeWSYG67u24RYYFG00AnF+SFTA=
X-Gm-Gg: AYBFou1khcAkKMHN/2odPAiI7yAdYq48nye4M3HaZ9x8mkuMQetUbY0eO31N8lJb4Zk
	BAY8oDUoaJtBdsJont0uWKnbyh7lMaJjaUAVfmd40yd4WcPdU6xQXkptnfhEcDxYBMYDIpH016l
	HHb4WxSV6p8ttLNp0P2h6Z2Kx4hyzeVQMyX2k9zXKZh9vjIHZwX1S+yRMzpcXh9pujL6TaxQr4c
	tAurFh14kflxX17DLx90bJIyct+78hKw3xSJD2qopciUP2S2uxwL6KUiE96XAx/imjJhnxwyWzr
	LzvZWvWTQ+QrzFHjfQZ/lX8GnZ4Qs7+qqQZBtVgHlGNV3Rm2Eqb48lC0BsJUfoVxicUtR9CYWrM
	jxvlUQe08xQ8GnvwYStHhDeGwmSKP4XxYrRCCni/fbmUeIKRs3I4UxQuhcYPBcO/EtodwFeTTMr
	qAi8OHtRBjCzTSLT7azPbSfEx5RdH6Gp725yRBmwznzJDySYp12sR2hFRlEKTlVjrPYYptE7cO8
	Y/7oO6LDWSyXHQ9b7OQWm6SvZwwwmfscQTucw==
X-Received: by 2002:a05:600c:45c4:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a7bfec4e49mr19489675e9.2.1793056152703;
        Mon, 26 Oct 2026 16:09:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm229425455e9.5.2026.10.26.16.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:09:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Mon, 26 Oct 2026 23:09:10 +0000
Message-ID: <20261026230910.2569782-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
times to read channel configuration but does not validate the returned
object type or array bounds:

  1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
     firmware returns a different type, accessing rez->package.count
     and rez->package.elements on a non-package object produces
     unpredictable values.

  2. The loop bounds use rez->package.count directly without capping
     to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
     than expected causes writes past the fixed-size labels[],
     shunts[], and active_channels[] arrays.

  3. The bipolar and sample rate DSM calls access elements[0] without
     verifying package.count >= 1.

Add ACPI_TYPE_PACKAGE validation after each acpi_evaluate_dsm() call,
cap loop iterations to PAC1934_MAX_NUM_CHANNELS, and verify package
count >= 1 before accessing elements[0].

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/adc/pac1934.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c4405..43c4705c27be7 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1101,8 +1101,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	for (i = 0; i + 1 < rez->package.count &&
+	     i / 2 < PAC1934_MAX_NUM_CHANNELS; i += 2) {
 		idx = i / 2;
 		info->labels[idx] =
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
@@ -1130,7 +1135,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
-	for (i = 0; i < rez->package.count; i++) {
+	if (rez->type != ACPI_TYPE_PACKAGE) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rez->package.count &&
+	     i < PAC1934_MAX_NUM_CHANNELS; i++) {
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1141,6 +1152,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	bi_dir_mask = rez->package.elements[0].integer.value;
 	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
@@ -1153,6 +1168,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	info->sample_rate_value = rez->package.elements[0].integer.value;
 
-- 
2.47.3


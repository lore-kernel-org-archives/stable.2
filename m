Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194A38DC44
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436149; cv=none; b=EAZ4e7RpIrsRrxHCbc/18f/Lo47LOuz/WRb8s8/NjPxKeFNCZxmSIbO22P+rZVllKN9P+9CqGZYtbENbMxmg4VCtVc0RGrA9vtXaGRS391fhn8if2xv2DbiZLbBAhu1W8KayFR0yNiFIBTFYCH3HHBQPvlOFXIYDFFUlTQPGg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436149; c=relaxed/simple;
	bh=6Ks+xsuYG7cTmaDMBguFljJXWFMHILbuZCCXEhp3hz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izgluP5mh3J14pv3j/+Ctjmff2bFCWy2ZJ5HibEgAffn2ifk/bG4EVh/dUR5eRAsrERKd/k+DGrkR0nrcxp18H9KOaCO8Jh7JIiT1FcVZQW0xKv29jo89P2R1Uig0YvmSZQ5Lh+Hr4GoMwrDYPmqQbOTTUvEWpxhLUbRO1195+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYRZXE2Y; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYRZXE2Y"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so25234281cf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436146; x=1790040946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYSdJ3BpaBA99mybiSOcxyeplaGMmUigodcgqfqpRMM=;
        b=YYRZXE2YfGN6AWFt47nNnux8MA6K+niA4xbntiuOuNcsUQL3TNCtm+XlCv5Vxe+QKs
         /anhC+UE2x2kkpT+mK8BATKxCOoHBgYzYrb5nxQgqv3839HBKAn880usg3nkl2LGrD6N
         MAuTolgIkq2O9dr3u0aR2ntTql6oSYyyIo7eioVXB6kj3+ACfCHAQ2Nku8kvhT4CPhQz
         p8QgZ4zg5BAxdTYsssXSNloSAW4Z3A8etBDfbmaKcxykr7hK+Dg13xBfFyyHDESMMkSE
         hgjSfenwmIiaOmDL3TNA1yshuqfJCtVwAAYrH8aBzYChaHSI4uigN4qTuUaF10DLQ4jQ
         bUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436146; x=1790040946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYSdJ3BpaBA99mybiSOcxyeplaGMmUigodcgqfqpRMM=;
        b=iOFzyiWkbzcn42n7QEeFz57LEGpg0g+zJXI999Kw1hvVlis38dLOcW9H58WDdyTL2Z
         g/4fIsBAhgFlMg7tQxFVSks/EXHkH4V9Pi9s1Ou2KfkJ8SAHCiI8L8mui+vW7uZG94QE
         mcWkAt8v1W99uYWKet91lEjMCS/jVqyr8qdfcU/ZyBPrUXEzyd4aIuc1d4v6DUHHABIy
         X728Nszgovp6qAp4AP6m+Krfks0JGjOWSn7DO/Y6J7hZoHM8cRovCsh783D08VDnwX/m
         7d8x6xXtj9woHLsbI8DQEHLPi6FMSj6V/xRkyDmaog+WrY4qU0qSGtz/2OjbR4a2pQAp
         cL6w==
X-Forwarded-Encrypted: i=1; AKwUvBxwkuGVLVk3il3sBfBu/8R2yYHIJLL2P5Bh/jAlJJV6W4ZwEe84FFTHZFVyh8zzjkFLTPCvqSE=@vger.kernel.org
X-Gm-Message-State: AFuF++kLPyMXvdp6NVTYtP9ynD70dTi6eqdw/HmUoATPK8Cni8fBqBm2
	5yBokOF7dlsm1B8rAllFX8qKCn81v8W3u2HdCuHiwu8HbneY83F++A4=
X-Gm-Gg: AYBFou1x/TIpiJHL7PMnx1FUroam/N9bPrvGoal1tddlF3NCzfU5BEq1iNAw0m+3VCi
	QXpYda1YteDFuGUtasI743pnQSe233OxrEdxqGmkMHWudJEOvq3iHtf9/ppGJJ7D+/YouBoC8y1
	Kx/7OGUGxgdEHMbyMj3VIicnCR9fg+QXYd5aUZAVSLV+ERwzCoJMDHwY73xdnBaGZ/8eIQ52HKD
	mhpn6ZRKeantSRiRh1p0z6HSLNJzhM4LADObK+C/Kfy9kly7p6jzMGw0tmQryXZJ+mXT7tzoXZK
	/mjgPcnTbRoUdMhT44VZ7q5PUYWxf3sHPusc9fKu35hQnKMNjjZa96hfyjv/R3KNpQwBigxMbKI
	Zl5Sj4FuVhR2oMPtjb4G4q9ZBjaMlcVZ5nyScDq+a952ua6k3zHur6tgWKSMMBJxlXePKw///ud
	H4qfwPit+z/j6+dGMi8Dcgwbda1uTTLl20lD1zNSDNZ8e04utQGRFwwZWyMPOEii5HloUp8dbDJ
	N6Bshm337aHRgQCMYO+m5E8zkn36xuLkVxdCnNO+alDoGHmdGBnAqUmettnJNA2GDHNPPs4Us+2
	gRpEGv9BgMk+NlRb20eMrdCjrB49Gm8+9wKd4YkLSr/DJR4Nz4zUmTqS5g7ySX+7p0cAIw==
X-Received: by 2002:ac8:5a51:0:b0:530:e1b1:eaeb with SMTP id d75a77b69052e-5310cf60669mr78434021cf.21.1789436145940;
        Mon, 14 Sep 2026 18:35:45 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530f9b99fc7sm66059601cf.30.2026.09.14.18.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:35:44 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: "Arvind R." <arvino55@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/i82975x: Balance PCI ownership on probe and module exit
Date: Mon, 14 Sep 2026 21:35:37 -0400
Message-ID: <20260915013537.71211-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i82975x_init_one() leaves its PCI enable reference behind on failure
and removal. Also, the fallback probe is never removed at module exit:
i82975x_registered is initialized to one and never changed.

Balance PCI enablement and track successful fallback initialization so
module exit removes controllers that are not bound to the PCI driver.
Only remember a normally probed device after successful initialization,
and release the saved device reference on both normal and fallback exit.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 420390f06a5a ("drivers/edac: new i82975x driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/edac/i82975x_edac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -233,7 +233,7 @@ static struct pci_dev *mci_pdev;
 					 * already registered driver
 					 */
 
-static int i82975x_registered = 1;
+static bool i82975x_fallback;
 
 static void i82975x_get_error_info(struct mem_ctl_info *mci,
 		struct i82975x_error_info *info)
@@ -597,6 +597,10 @@ static int i82975x_init_one(struct pci_dev *pdev,
 		return -EIO;
 
 	rc = i82975x_probe1(pdev, ent->driver_data);
+	if (rc) {
+		pci_disable_device(pdev);
+		return rc;
+	}
 
 	if (mci_pdev == NULL)
 		mci_pdev = pci_dev_get(pdev);
@@ -620,6 +624,7 @@ static void i82975x_remove_one(struct pci_dev *pdev)
 		iounmap( pvt->mch_window );
 
 	edac_mc_free(mci);
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id i82975x_pci_tbl[] = {
@@ -670,6 +675,7 @@ static int __init i82975x_init(void)
 			pci_rc = -ENODEV;
 			goto fail1;
 		}
+		i82975x_fallback = true;
 	}
 
 	return 0;
@@ -688,10 +694,9 @@ static void __exit i82975x_exit(void)
 
 	pci_unregister_driver(&i82975x_driver);
 
-	if (!i82975x_registered) {
+	if (i82975x_fallback)
 		i82975x_remove_one(mci_pdev);
-		pci_dev_put(mci_pdev);
-	}
+	pci_dev_put(mci_pdev);
 }
 
 module_init(i82975x_init);
-- 
2.51.0

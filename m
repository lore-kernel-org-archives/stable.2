Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CB349CD0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546761; cv=none; b=qBQM311ehSh5X9rg3sH6plYKVLEuGuFDBpiTTaYDqEamiUB3pe99ieo+WeXEl/bkfxBOeriPhNx0jsYPYM5JwG/jmNQhEZ2PW75XijKhaQMsqKhIWrZuf15UxcIYpQ0bKJteT0NrrlWDcba6AlSpO13i9Rt5vH7/xHrrI2C5FFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546761; c=relaxed/simple;
	bh=MK/EvtItOpT/zgPL5nusrcrvyqvBtj5dEqAmbXtdchU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxFXmDqyGuAsxkFkITgKukLxgCCcBEOB+XXzdiGAu+UuZ+373/6WWrc37ukkl/4mg2ucnhwy2q0IVV6h5AmkNUfQLc3VaL9q1NKhKJI9QT4MFIA2msmVWiCHUajuktP3wtGq/OfsQs5jlNiuMELBf6Ysydf/CKUsqATq1PsJLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=ZzYLsrOX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="ZzYLsrOX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caea3f742bso120013885ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784546755; x=1785151555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/f8DL2vIooznsDdQVfwxZs99v9VD407+Uz6ZGQECJlg=;
        b=ZzYLsrOXWgI/t//OcBM7IkjVk2+QfSAjpGf/m+fqZDmpYtlSde23k8bDD595O87kYt
         1H19npplrfZ3NUqikX3L/Qe4EGekvIr61wL233x6+CLNcquvu6x2lgbxIjmAuxm69Sy0
         l4jA3p6So6xb/THoiH3tRwLa2jMr65g3SvyGML0oad9KpszwU7UnjabiTVAj3J2QdPMn
         9lQDN53iCeFoBFFc4ROSAu3Cx1HSCun4O52k7T/c1OnQafofphegl+oIi38vxq2Ss5T0
         0l/VdT/PMrNRrGnvsmD+FIlcKwSNl300h1vNUasaPMKuqm6Wfp82gWwr459GnGL8ZKiN
         vvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546755; x=1785151555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/f8DL2vIooznsDdQVfwxZs99v9VD407+Uz6ZGQECJlg=;
        b=NP8eDAETmxkaJVZsA3fUCdl8a6IqWoq3/z7up40GOcSDfa0jN9T2PNjQEIwpl6I5ss
         P2cdpGXqzAZN6dZ35bYsAZLuIXzhdJkds85ST1oLmoTTx/cdJ0lX5Sp4SDUlQPFI4GIA
         bnqM+ormbIIj5JoqHASvZGOqRS4MOmuaewfkhBYs9Ypv1xr+r512YgQW2DMYsdOZsNz2
         ZxjPPkzQzjkb4snfSSaG9o8HrkYVfw87fLotrpNou0t2Y89nRITLpshP5rk6k0XFKe8y
         ILApAwvGR+v7o0tzwgziQaEWrkUyq+h5ITBuP88rs3mM8o9BXa3S/y3iEiqktsKsNMv5
         FOPA==
X-Forwarded-Encrypted: i=1; AHgh+RpzYfEiujjPYs1jTaw4vpRxcU+cjEwLCOibOJ22XCFUAZALTOk0rS43mX36AIfXOQM5wymJKU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLtC6SiEAN+R4qebxGAnoeFDHnqK6++1lbOv7Cli/9Py4BDYh
	ac48MhyJcnxW0XyMXrCrKd18JI+HgB3Pic6dQAtcfjmiZqNo/sHgExOM7nDMSVXy4EZ5X3B5ez2
	Y+JIJMzs=
X-Gm-Gg: AR+sD119UziQUVKwVAtXkFBkEt+DjtYYZdhJ4RPK9eU86HGRMSl4ivTDRMaAfmaubDC
	Fcwa6FYDBs2lY1/FQ0J8k3o/W6TCdFRt4LxZVMsNJ9hBIlWscoekhvx64B4eV5X3HM1CpEYbJZv
	RFxr2mx+sPxpKmGBzPy2ehbONfHxtTIoLaCLFwfFeCzfQadxHgS2gOjXSxBez9XEO4wFiTaMHwe
	1mMz5cBqa2ooh39rjY0RI6mMAGHWFT33jCtALG0Qmb/fvJKkCh9adPGA13iE/tfTEQqqAwWLDwl
	hs5XF1t3m5vh0JcPAbhVcnsT407MzXx9DoILHcBqPlako8d3i5THgnxaJpsyUfrTW7y2QRxu5VO
	si4uT6sB3e1qbDRZOJQ5O/OqxXK33L0hOG/tC6GMMyIkAYwyKY5tzVEOdm+N3WIV3DfmC1OhdE9
	jgPcp0ggwDC2MyGX6SnGknQZNfqe6KQ21LfZMbrFQb4Ahnq/Bw+trunXw5xYBOu3n9LzDoOt2ag
	iJOtJeoPMiqlbU3zUO1A1Nhkb1HiLN4
X-Received: by 2002:a17:90b:4a08:b0:380:9157:d6c with SMTP id 98e67ed59e1d1-38e4b41043cmr15033493a91.10.1784546755329;
        Mon, 20 Jul 2026 04:25:55 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13ce2de31a7sm30620268c88.15.2026.07.20.04.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:25:54 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: lee@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gustavo@embeddedor.com,
	stable@vger.kernel.org
Subject: [PATCH] mfd: sm501: Fix potential memory leak in sm501_register_gpio_i2c_instance()
Date: Mon, 20 Jul 2026 16:55:31 +0530
Message-ID: <20260720112533.70538-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for pdev in sm501_create_subdev() is not freed in
an error path in sm501_register_gpio_i2c_instance(). Fix that by
releasing the platform dev in the error path.

Fixes: ae7b8eda27b3 ("mfd: sm501: Fix potential NULL pointer dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/mfd/sm501.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b5bda477ebfc..49c6b21a44e8 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1103,8 +1103,10 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	/* Create a gpiod lookup using gpiochip-local offsets */
 	lookup = devm_kzalloc(&pdev->dev, struct_size(lookup, table, 3),
 			      GFP_KERNEL);
-	if (!lookup)
+	if (!lookup) {
+		platform_device_put(pdev);
 		return -ENOMEM;
+	}
 
 	lookup->dev_id = "i2c-gpio";
 	lookup->table[0] = (struct gpiod_lookup)
-- 
2.43.0


Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B749BD87
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560282; cv=none; b=TjlQNu71AVyV65Qj+wJRIERjYtgtiImm26DhVaD4Z9Y/lM+fnaHDq1u1eQJiIsOcho01dlR5fWJt2xKDlWOjszArZrfQ/NdQI5sZVRu75SUevsrvv4AXSBsypTiDrYw6/4dURrZ3DRcjR5diyxGBPvMtgClgIfaYfmMVvKM0i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560282; c=relaxed/simple;
	bh=3zmL3ewY1kdparMjXtYd5YfgrB/htIhzolzkpwgWTug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbv5IUrzREupNYtHDRa5P0Viz3oQHDeaFqZb9lDUdb42glot1jeUIDCGKRoJNBtzhiwVQdgmxS90z2Io6rJF7iBxSGsEIoW6/lY6EWMayUBJzhat66vAmLBz63RzEZ6y/dWDbVFmjeFBLgnppEjRZlUIlfl3CEeHCWI3rUQS2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sN+p7ZKp; arc=none smtp.client-ip=74.125.230.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN+p7ZKp"
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3a49bfe419aso14248681fa.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789560273; x=1790165073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmdeb4lnNoJH7OwXB9Rluaec5aBqbfZHRKlp2w9jCKQ=;
        b=sN+p7ZKp9bCgL7VATsMW94k9bC1dZX8SmkLo5Oiq+Br5hgeHG1nkXECrtZKy0URCsj
         9RuV0QurShCZTjz8Ros9NwKAQBjCiS/YXdQQw/qykGEBfXf3K+R8PFuLfkoa6+D1t7L9
         uLYSlAX+ThTLLZhZFcR5hU6TRL0u/OZL/ndyXsVOiqWZL5a3dR+OEAr8S4hO42ACp0sV
         Jip2Na1rOBw+R7kdv9EDiF55eWBOlMdGcLMFnqrkVeFjKqDpFr3XvS/l2Ks0RUcU6Lsw
         Cb6mSZoqdoJF1o9Wr0jk4zCKlM7r7w2gc8/p/0bfaFcCz86T0OtHhm5iqZSecRU7/7l8
         2U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789560273; x=1790165073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmdeb4lnNoJH7OwXB9Rluaec5aBqbfZHRKlp2w9jCKQ=;
        b=joRk33DCWgal7tguuYkSnSHcrjyvC2MOM/Ks1mYZ4nrnw2fqvIhR9mpA0Nqgg8sA6L
         PHSBEacUxm9CExxo4mYY3me3ZBcYxF8YL/7CGJ5ctyD9cA/arRfEagN5MDHSpDG8mDtJ
         ZfwdYzYjWTZUEldOrTj1thW+qq6DHaPkaseEbMi3kj5gpvUx7ksyJTN6Y80HFil1+ru0
         u3Igaf7N2cbyZyvW7wC83PMTbiJSsBcl/jnFSkBXQdrmszRrQ6W3UiZNAUEqp44ezfQl
         fOB8ZFiCRPsdHkGS8Qb9pL0JuGrwSbDT1NfLc89zUQbccyHaIJQiXdK/PPycyrhEgu6q
         5buw==
X-Gm-Message-State: AFuF++ntvdKiTx1uEiuGXzBGPa0pcvP+NVKAu+1IvyyJ4cCN5NdnE8Uv
	Wcw6IRlLf5Ay9/gjBj8uWHQoCP4JroAAeouKHJCRSFsdy5SqtLyKxGxQHfQbRgGF
X-Gm-Gg: AYBFou0F7YHLMYSE2GjtOG5L2J7bK7eZV9Fwwlerd6DaE+vjk6Gcuf8O+OlfXuD3w1Z
	HEwuZx3aMZew+/h+vGP/rBHDHmSv2mTyOAq7Gifo0qew/1pKMWKblrQImg4QiDGeyJssl0xKWL6
	XCM67YDskXRoryVQ/Wd4qHsSodIEKMrGDudkl+opxq2FLkOcER5E7IvCvse9o7CmoKZVPJlsIwS
	xc0iaf5PLnBofJm+LCdP5bpCEHGXUnWHQYLWxp2md4r7HwL4pQdXU8e2FvOnJ8qQ03AkXKngPoT
	g7jYfLiurdQpg7na+miQq3f1LfPwG/fq3Jh5LGGUxH8vkAwnXyHsOcgW1SzqIgtBakHTvEPAkI7
	KL4PJlreyz5DjL0Hdh6ayVPW2aijPXvPJxMvk1Yl5bt1VzldJrJ/oprj5dW/af+4hawhL3X5AO0
	xw76YFsrIMfc5sZb/LgLm9HSnjjAVdar33l/MNH9g823sVHjs03wvSUd8WQ0EkJQWChGCtC033Y
	kPg8WYeap8h+YFE
X-Received: by 2002:a05:651c:41d6:b0:3a5:b0a5:3ff2 with SMTP id 38308e7fff4ca-3a5dca291e4mr10260111fa.12.1789560273060;
        Wed, 16 Sep 2026 05:04:33 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5dafee366sm5974541fa.42.2026.09.16.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:04:32 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 5.15] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Wed, 16 Sep 2026 15:04:06 +0300
Message-ID: <20260916120408.145211-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

commit 11d7cfe0c119691b2dafbb699bbca90258c678aa upstream.

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260521142153.2957432-3-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-72147

 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2c1c5fa4e9f2..84d5a1d1b2a8 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -151,6 +151,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
+	if (!pdata)
+		return -ENODEV;
+
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
-- 
2.53.0


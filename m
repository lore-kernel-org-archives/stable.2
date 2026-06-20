Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B034374A00
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938377; cv=none; b=Fo+ng6GIIfaikVNkFv7f0PdYoQie0qLAF102QStgPhxUvmkhMA+Fq8HBvCsS3MhOT/thPI1b7w2eMkl4SmyhmsdFDCwxB400D8XqZIJq5Opg4PnSXRKOGfyDui5VmwTvcUESfngq4N7XteIvwntzhTnfpANhCdHhi/gVYfbU5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938377; c=relaxed/simple;
	bh=2s0xvYMHNV3vbXplIoTi8wVcJPWVN0juzhUkxxloMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBEHYZsl5wSr5axLaexbgwCKOG7lcybaNTcV8tp43BHZfPuR4GnuY2pEEsSTHAoFYBdo6pqMHJro8TgXkevE/UkAzD4sZSZ1C1vAJfb7e7upEuEnoMihCHx6Bj7jEinwOzR03HJNyG83YXUsLgkG8MuKtJP5cqMDe3/NxlnOtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bFe+nWEH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="bFe+nWEH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1542120a91.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 23:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781938376; x=1782543176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWrAPVVPXK8Wz+6M4TACvlC6LCQEyIdcBgZX+P4A3lE=;
        b=bFe+nWEHP7aOT3AeyhgdemqrxcPwj0FRayHCIXuV9j6oqE9BjlcoBA++NhlqEo/WXj
         atrjp0qgFxzGoXX1JjfpW9e85gMfMkuyi/SgFIcr+ObQrDFBtcGLWFZXS6cRtfRp5s9y
         cq/Madx0greD0+TGCHiZBR9fyY+/IVoppCaTuolv0AlmPo7CbGtbkunoeJD700LJEskX
         1cX++k9mwqDtelhmPqstrQVjOCKPXrJ3Amos25T3Ffmyq2aGWLeyrJ5cYhFEWT3s8nFo
         /vTKnOxG9KCtsYagCMzvvDHudlnun4CWdAgh9nv4LfEqT68Ddd3V8ls1KdtcE6bA2sBS
         ZD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938376; x=1782543176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWrAPVVPXK8Wz+6M4TACvlC6LCQEyIdcBgZX+P4A3lE=;
        b=psLT509bqE5NGSJJTsaVCfGAV/Ckp4l3vglRPzXt1fdM9hyn/1YGP7v6dR8YSGDHHm
         bcgFe4eld8NooUNVH+oWUt93Drj6hO4yAPDRvyrVKx0ASua+504yWG4vw4bBE21UX32H
         Ge5iX12nCiWss7dIjw7r4ibOnvXDtRNba+IR67GrhkIjTp58IVtTx9ldnWO3mSHO9iqF
         R+RLoqIOUE4X5fzG6PoWn788JDAIpD1ZGwlAGSVc8VjsgmNbZNkG5/eAGQK890pr8nc1
         L/w05jUWLGhbxenu2Jq9Fud0r7aU/RFUMJkB606GvL+Oo34Jm4H7hdsAc5/JCjYqt9Tn
         GMUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IE/rVQvNG5ByBd9o/BvLTDAC4qf5ERPQ7tdHe12hZqJaoP6tlfHCRbxooGZzVsPswveYd1gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYe8kuNd7ZdFXJBebXxQCOAKLjoGy6DY457tk8m4Uuo7bAt43
	bCO7gUpy3gaTyAq8WFJbVue6I6Xza2gb2qBnlPr3dtHXwkpRH/IJUry3TCsL56Dip/I=
X-Gm-Gg: AfdE7ckNnkw1viyxVEDZxCsi7gptTy0WF3UkB3d51X5fWRbQPUl6PbqoJ7dnSaKStiz
	YslKGVtk2/ILeHErivPCGY8lL2QZtZvVa+xj+XTBD+/yAWNY0l2/lG+UkHBOE5XQ76wEI7Ldmaa
	3qFBeTc1j4ojDZq6mNoyJ/b00tWv0b1++RGbrzjd4RYfABjTPeSx5Nt7HHclQ7D/aaRJyzt4Fes
	rH14Z86pAbkFci6UF7QHf5Dn1pNy6kW1cxvFI5KCYcPTLoi/MX9GgaoHqA0V32RIO0JkorI1bCU
	uJSwenpatYbvcYtoQ3H4/Z4nMf0q0dbCc60DD3VKsfDWls6BjC9ecF8kxmaPlcqC7rUMoHL+PBp
	8/lHCSdVohqeOBfodlcGqacwmZ2m5EnRA1GjOIVYtHl0IVlVb+NSm5S0KCxQOac5SNZmU6AFf+M
	DfaoAFynlce3mhDOYNsCuK9TtT0za4gGpcP5XYYEIP11ngKy36nK3E1kNCwmc93ygCjLJC+ar3V
	lMj0M2dmyQ6xriQnstqdWbCWDFrYf8EDYfAdlJx4Un4TPQ=
X-Received: by 2002:a17:90b:4b81:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-37d18637020mr5382239a91.0.1781938375682;
        Fri, 19 Jun 2026 23:52:55 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37d1536b541sm4428857a91.1.2026.06.19.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:52:55 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
Date: Sat, 20 Jun 2026 12:22:39 +0530
Message-ID: <20260620065242.93798-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated in the ipw2100_alloc_device() function is not freed
in some of the error paths in ipw2100_pci_init_one(). Fix that by
converting the direct return into a goto to the error path return.

The error path when pci_enable_device() fails cannot jump to fail, since
at this point priv is not set, so perform error handling inline.

Cc: stable@vger.kernel.org
Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Converted the added goto fail statement into an inline error handling
  when pci_enable_device() fails, because Sashiko pointed out that there
  could be a null pointer dereference as the priv is only set after, but
  is dereferenced in the 'fail' error path.

Link to v1: https://patchwork.kernel.org/project/linux-wireless/patch/20260620055558.75740-1-nihaal@cse.iitm.ac.in/

 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index c11428485dcc..2b8a23865bfb 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6157,6 +6157,8 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_enable_device.\n");
+		free_libipw(dev, 0);
+		pci_iounmap(pci_dev, ioaddr);
 		return err;
 	}
 
@@ -6169,16 +6171,14 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_set_dma_mask.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	err = pci_request_regions(pci_dev, DRV_NAME);
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_request_regions.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	/* We disable the RETRY_TIMEOUT register (0x41) to keep
-- 
2.43.0


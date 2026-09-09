Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FE58124E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971212; cv=none; b=SqD5GDpKh17urEnRhS0xYRfzhEvam2QI2t9TOotoTz9FBI1bzhHmjqVVc8nbW9ZNXKzsIkBEO9TY5aSNg9dFMLxUH59do0mUyXzfBNtTrw7DiJJtmYHkPcGU7xujE2XeW9VxwBbhxXq5t7f5vf/ZE2uNN4R1InUVtDi3vtxMXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971212; c=relaxed/simple;
	bh=YoFQYBT8jhnUk2kw0Ly7AeXpFxhAvQe6Pyl+Q6juTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJQBwdGPSI4gbC/zp3zqb+8RlTJ9pFsIABwUupULvgQECBX0Kk8mfV2z0BSBL82dPZTu0dk0jsSnit3x3U9IWtAFlFIw4oGpsR93L6Ehww0hmbnXOoRzCuhzx2n9N7RD7W7XTcr8nf43xRN1pHMYFtXfIyvYFhu/ZDOgvJcetsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhofNE72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhofNE72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A81F000FF;
	Wed,  9 Sep 2026 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971211;
	bh=bK3NfeBEQpwYrxZi92h2YcY56YmcYXNH9ICtsmhHdbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhofNE72a+WFNGxxnATU1e20cMThiJo/OvdYgAIGs92wFd9Hr77Ko9T4vg09YdKMh
	 5BoUa73lngWOYvtsrncOIB63InxIiaicEJd6m+UqKi66gs33C0NOI6XOZvuR/tlloJ
	 5WO7nQwJB8R1FOn+mOVfhK+58Nhh2m7U7uGRN3pMqKhdIERXO7qoV6tiV276sUV6Lx
	 Xv+2LUrONWJ5vwy0el83eFLVSdNBpwzAgIzk/BcRp8jmSkKPJSG6Ear85UaIv9dEd5
	 FSED35nNll4r+mm6+reQPUXOvbFSwbsvwMTUQox/ArWPuudmUQzaAwKEdqjeu+C96s
	 n1Vwy015tKrgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] PCI/AER: Simplify add_error_device()
Date: Wed,  9 Sep 2026 12:26:43 -0400
Message-ID: <20260909162644.2981443-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162644.2981443-1-sashal@kernel.org>
References: <2026090327-shy-dealmaker-b70c@gregkh>
 <20260909162644.2981443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit d72bae423004aa7b4d94c34a7fd0b48b64305a08 ]

Return -ENOSPC error early so the usual path through add_error_device() is
the straightline code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250522232339.1525671-18-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7b7fa00666f4c..81b8cdacae533 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -810,12 +810,15 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
-	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
-		e_info->error_dev_num++;
-		return 0;
-	}
-	return -ENOSPC;
+	int i = e_info->error_dev_num;
+
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return -ENOSPC;
+
+	e_info->dev[i] = pci_dev_get(dev);
+	e_info->error_dev_num++;
+
+	return 0;
 }
 
 /**
-- 
2.53.0


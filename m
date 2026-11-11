Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386937;
	b=Ut/lr3VIZvu7pKt3Yvm0CyaY2VKHAIPv2D4wL6KewbU0kvs/DKYWlX3zvsVOdj8cBBZG
	 VZqsSc9NhmJ8lQcJMlwwoN2Gi6+qXasOzAKW1Hgxo3sL2peoHoNSn6Ud3rWj+LwaSpyFf
	 h2fsypDM+5oTbl572lyKXwSr7urwSR8+yGDKQzJMev4e0OAQ2IRwpvUCsrJPXf/k/yJly
	 jiTkhFt6WxX90Eg6QTW1l3wMbe7IX5kP6aceH+vwYWhs47KJoj9FGYIJ2NsdGQiSmhPzX
	 jrIi0TPdNYxeRrHDpCUBxTeL2reM/vGmFSuWX6SqXKaWrfhNsJPElXHl3Tyn+FJh5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XP4Wu7nT+ir3/JSpOzG3VpzBBZM0vfK9214Nh0VjCjQ=;
	b=gIzwtveWbklmTjjZSPIcmNLe/BKWIJVvLrUE/+Ti9XcgvDAifBzAXjbfj2KaHWbg6dUz
	 EUp7aB2H5HUvU2azwfThlTX4e0NQZCFf/Q3+XXoDIit3/OVXNiMRuW1VNIbnRx8sC+MNM
	 Y/dOKOw4u9qtqGXKa4aMS6h+r4cGdmefWaBLe0tU2HrnlIvjK/ovzNY/yVVrnCnFoze6p
	 Mo8Pu4h8MeNd0JH5UYInxOJwRWfgmr/YNbtKmbhwobXpVJw26kubuxNmjSIweaZg7b7rO
	 GbYMLSkFMxWdBL4I+8NoJI7RURRsywCO6wmrmw4lhGdUHPZnhMmMwlm6JmNmK3X5owQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lkXxAzOL;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73504606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73504606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lkXxAzOL
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05b68f851so2384311b3a.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794386937; x=1794991737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XP4Wu7nT+ir3/JSpOzG3VpzBBZM0vfK9214Nh0VjCjQ=;
        b=lkXxAzOLGDcJQOYArOxY0/H4cx1atoR09E0e4P1pDXqIWRlrNlSMsw+R269b2d6aMS
         16AfD0Bn1upsZYShZ+3FkTBKAWiA69+AA9xs5F9C1PqLoD2LQqHdGvvME3CzgYTAT+9B
         7U1xyDYpowZAxIVwBftdRX4o58zWVA6CoYMCWF06UEnGY6M/MMqIywSxrbrnTjuk5NEE
         UDJKImRpLM7WRiuztp7MfK4KRHDxVVyxpttnzQKSS0u9L7kwNwaBrPIoY/YKWw0l1eFM
         Ie5mMldX3Qi2EBa5qT9FlnSueX0gSxUm+5ZDjyFXTrfhKamMtRXwUgVOhy7S0E7HGTni
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386937; x=1794991737;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP4Wu7nT+ir3/JSpOzG3VpzBBZM0vfK9214Nh0VjCjQ=;
        b=VcwStBgxx8q7p6uAJKuCuuVKeqtri2p9mit7wrws+vNP7Q8CQ4CpscG1VxsRSha5Zs
         w1W/KNXdTHloWEo1V6n5lFTmw1C3ECOenIz8tcqaLuhIeimpvgxyHEHCleS32qFeyMlR
         J7hNa/uKPqawhXH4B18kpA1XvSG0kNUTUPxuoC9ODum9xwUabbzF3S5OvkSphuOj4lLc
         Dy9GhSZzUH7fSPzLkDM0QnXY6YZkPPAAJfrrmu8jKl4gl3tYX+vZ4LmN97PiEvTIT0Gi
         t8Dv0yWegF45LGb3//Ro77Mf6t7nElghrwgXSler7TxhTRdlZ+lLWKME5j4AWHWZlb8G
         wiEQ==
X-Forwarded-Encrypted: i=1; AL+hErFaN5onyfN6V8W41RFmGk4cMJzMAYinvYxJCN5URiM0WUBvWd/B9lo+9tp+ZypJK04ITcWRNpk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wcTl7doZWA7e6OnjdvsQu/yCHQqtjjuKtvq0fuVQJyVwPBJYp
	wuqeois+n2Dy0Azcgb6qQlr4cUfFI+BXLh5e8ND6mAi6hpaP0W46LluPHqUQjd92xQTgl0QHmKW
	d/Aj46Dfv9q9c5Kdc4IrV2A==
X-Received: from pfn18.prod.google.com ([2002:a05:6a00:a212:b0:89f:afc:76b5])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9cc8:b0:3e1:6f0a:cf2f with SMTP id adf61e73a8af0-3f2febde39amr1339727637.28.1794386936537;
 Wed, 11 Nov 2026 00:48:56 -0800 (PST)
Date: Wed, 11 Nov 2026 16:48:53 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111084853.3530107-1-stanleyjhu@google.com>
Subject: [PATCH] scsi: ufs: ufs-pci: Check hba->vops in system PM callbacks
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	sangram kumar yerra <sangram.k.y@intel.com>, 
	Rajeshkumar Sambandham <Rajeshkumar.Sambandham@amd.com>, Stanley Jhu <stanleyjhu@google.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_pci_tbl[] defines the Samsung 0xC00C and AMD 0x1B29 PCI IDs
with .driver_data set to 0, so ufshcd_pci_probe() leaves hba->vops
NULL. Both ufshcd_pci_suspend_prepare() and
ufshcd_pci_resume_complete() dereference hba->vops->name without
checking hba->vops:

1. System suspend on an AMD 0x1B29 or Samsung 0xC00C host enters the
   PM prepare phase and calls ufshcd_pci_suspend_prepare().
2. ufshcd_pci_suspend_prepare() evaluates
   strcmp(hba->vops->name, "intel-pci"), dereferences NULL, and
   triggers a kernel oops in the suspending task.

Check that hba->vops is non-NULL before reading hba->vops->name in
both callbacks so hosts without variant operations use the generic
ufshcd_suspend_prepare() and ufshcd_resume_complete() paths.

Fixes: bb44826c3bdb ("scsi: ufs: ufs-pci: Fix S0ix/S3 for Intel controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/host/ufshcd-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 668b57403e62..f9abbbc436f4 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -644,7 +644,7 @@ static int ufshcd_pci_suspend_prepare(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	if (!strcmp(hba->vops->name, "intel-pci"))
+	if (hba->vops && !strcmp(hba->vops->name, "intel-pci"))
 		return ufs_intel_suspend_prepare(dev);
 
 	return ufshcd_suspend_prepare(dev);
@@ -654,7 +654,7 @@ static void ufshcd_pci_resume_complete(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	if (!strcmp(hba->vops->name, "intel-pci")) {
+	if (hba->vops && !strcmp(hba->vops->name, "intel-pci")) {
 		ufs_intel_resume_complete(dev);
 		return;
 	}
-- 
2.56.0.506.g506a7eabc5-goog


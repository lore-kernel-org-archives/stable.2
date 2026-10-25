Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892093;
	b=i1gU+tOkP4WkGM5O0YflIjNs/hschGf96Xr/R4m2r9nNcnzxZT3TkUI90YrHO6TsOhGn
	 bl0lwhnnZ+T9WlN1seMSw04LN/JobA1jADP8ozNPtRyHt5VDiYqFBQbqd86u5Q6Z/Xhew
	 JHPILOqTWOWzvcPRjs509WG/dsl65Ffi5JEhmD3vhBzZ+oNbSDgVWn2tnRgVvxYxOk2HO
	 G6o3/KE1U/AzbZSJVF40PBrsfbF8oBFMXkD4pg/iInuUEkrMeANIGbvhr4MOEG8ihnSny
	 +vMyUGMrvGAa34SmbWCOd9eLyvfETmJLwPJND+uN1CaR1wN+u9STTrKvqcQlX7fZsRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TYSiwMwmay2OMU5hIoROJC2gk9HspYKqZIDwCmXW3lI=;
	b=ypCUVUayH5EBqmMQwWK6z44TBMfeJ5YS+CcWhi7jCqD62SxJ9PQOQcegokqsXRKF3LRc
	 LhOCbUwcjbQeWrhNn9mY7OR+gPeFlCBeXe0v5GNuD2eSSZpaDlV1jyrn2Vv+PxWaFQp97
	 iNu/RIJ4Cimhvq19wUldaUzdYVyOEOYG1WnixgqYe2i9Mv1yXDwv8pqaNrPpLxpLVi8yl
	 ozq8b/zyuE5G7hV5zPUdKla96cvrDE+GtX4AOudZlccKsH0cGCRdBLXX8QaHcXnqz7AT2
	 vlg4Racjm9Lo91PqTIq0+M1TWqYtLxkzcK8SpThTUNSUfZL1DPXTA05gq04mGGhB8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=F4N0ZchE;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B14606A32E
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B14606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=F4N0ZchE
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7d2ff0087so1244928a12.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792892092; x=1793496892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYSiwMwmay2OMU5hIoROJC2gk9HspYKqZIDwCmXW3lI=;
        b=F4N0ZchEUtxLDkRuysvRWHNjVkT2Cdxb8qW5SaGA/D9l4XU8KggToSVVBaSYhL508c
         TgmDNkOW+NBil9p+ujKNfzwIi4cXt7r+1z+EGNP9Kk1HSd3Ys7r23PQUpdS6f9qMKgSR
         1ABxqpuAlGG934lYJx4gRYywisYUHOURssZBBKBL+kl9vWMZcuC+RHIvqr5RgdkcDswa
         kna2JQfGpqIC6gr1Nm24g5Pei/liKP1UUhcSx9uJ28ig22n7YogAC5duqRgs9yx/eSAX
         nMz+N450hX6FEMzmbXHzR6jERiwO5mYc65LwLeQfKcqksJt18lRMVmST+xVDLBIkgrjt
         lbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892092; x=1793496892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYSiwMwmay2OMU5hIoROJC2gk9HspYKqZIDwCmXW3lI=;
        b=p97gVTm6v7klq3RxEIUhC06u+Zz2apvQeJni98Ha/cI9WcKJRhBgjBXImPGFLM75to
         zHls7PmxFNty5ArtXb5WOYJ+qIg2YlQxv7qS1IYmKa42iUZGmGzpScyldDVAtR4FvW3J
         ZF7OzWXdAtF0RyLg8aQcddmk8wDBtUf0wfd2KzjU45I/nMMitc+VEjpPMiWpAuRewp0A
         O+pd/LtTwD0i207s+XYFsnOKph0H56Ro6UjC2ASejJbYvzGhpYw6dO58OL5yFJwzos/N
         vqO5mTTbViMhEE4acAjAm/o+Aq5xpq2GgXSA5JPp1YxwbNwE3LvHn7n5nTp4yiLKKa9Y
         77sA==
X-Forwarded-Encrypted: i=1; AKwUvBxYHhLmtSsF7oOF4uTMS4r+Ql279ka4iMVajAWK6rTqH3BlncLPMA3gwU9y8sEpCcxQ6cLjJ3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Bi1/0PR1bdVZCVt7QwrLXkAGYTb4ziRbao2u7eDqJ0fH4v+s
	phH+VbBABIicdYfM/gQuFlBnzFSA/gZONnJEfxERIVSBcM1Jq7dtbGQ+yjncnx1EP9S3rsS8/nk
	0v82Akf88plleaTTmbbu+Fg==
X-Received: from pfblb14.prod.google.com ([2002:a05:6a00:4f0e:b0:899:4601:80d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94fb:b0:899:394d:2976 with SMTP id d2e1a72fcca58-8a3689aa5ddmr2517554b3a.39.1792892091847;
 Sat, 24 Oct 2026 18:34:51 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:34:43 +0800
In-Reply-To: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025013446.345974-3-stanleyjhu@google.com>
Subject: [PATCH 2/5] scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_clkscale_enable_store() and ufshcd_auto_hibern8_update() call
ufshcd_rpm_get_sync() without checking its return value:

1. Runtime resume of the UFS device W-LUN fails and leaves the W-LUN in
   RPM_SUSPENDED, or a prior runtime suspend error latches
   power.runtime_error, or runtime PM is disabled while suspended so
   !pm_runtime_suspended() still evaluates to true.
2. ufshcd_rpm_get_sync() returns a negative errno and leaves
   power.usage_count incremented.
3. Both functions proceed as if the host were active, scaling clocks or
   writing REG_AUTO_HIBERNATE_IDLE_TIMER while the controller or link
   is still suspended.

Add ufshcd_rpm_resume_and_get() wrapping pm_runtime_resume_and_get() so
failed resumes drop the usage reference automatically, and return early
in ufshcd_clkscale_enable_store() and ufshcd_auto_hibern8_update() when
it fails.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd-priv.h | 5 +++++
 drivers/ufs/core/ufshcd.c      | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index e55c2a02c1f5..99f654b79035 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -388,6 +388,11 @@ static inline int ufshcd_rpm_get_sync(struct ufs_hba *hba)
 	return pm_runtime_get_sync(&hba->ufs_device_wlun->sdev_gendev);
 }
 
+static inline int ufshcd_rpm_resume_and_get(struct ufs_hba *hba)
+{
+	return pm_runtime_resume_and_get(&hba->ufs_device_wlun->sdev_gendev);
+}
+
 static inline int ufshcd_rpm_get_if_active(struct ufs_hba *hba)
 {
 	return pm_runtime_get_if_active(&hba->ufs_device_wlun->sdev_gendev);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5193be703752..2d73dc7d68a9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1864,7 +1864,9 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	if (value == hba->clk_scaling.is_enabled)
 		goto out;
 
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err)
+		goto out;
 	ufshcd_hold(hba);
 
 	hba->clk_scaling.is_enabled = value;
@@ -4792,7 +4794,8 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 
 	WRITE_ONCE(hba->ahit, ahit);
 	if (!pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
-		ufshcd_rpm_get_sync(hba);
+		if (ufshcd_rpm_resume_and_get(hba))
+			return;
 		ufshcd_hold(hba);
 		/*
 		 * Serialize with the host driver's AHIT control. Skip the
-- 
2.56.0.307.g5fe7bd680c-goog


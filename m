Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51733372EC2
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926155; cv=none; b=BuQ9Nw8CAfngofVbwqUyd696Fk0lX9qGst7g7S26HgQAY35+zRKWG435QDRdd2Gs3+NoiDiXAD72x8g8TSGeJSjOz26+rCPL07hUPRzxxHa7/lS2P97D1X+B/3suFJltXFtH5J/jwQdJRwYDhNQcYtClkqNlmfZjPR5RSYD0Pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926155; c=relaxed/simple;
	bh=oEd6cnkf0tY+dYsvh6YqBxKM3Uclyl17F0aXLYbM/cA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type; b=P9dc0WOglqXM0Z/kC+rzOuVAUWAV4J5WmFY519MXkG6bi820DnEB2v0xLqJq3ARyRtMoawoiED7Fiy2D7oInYcJVy98Kbw2clnSCzmwRAcrF/L2rscLwE3cmrM5gR7v3DPUXlDPi1jU0COhmidPdekwbM2LbqTyCKU3Dps68CCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL/AoUek; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL/AoUek"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso7682045ad.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926153; x=1783530953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kXHKpeSyKt3/ctGA9pi3psIMZ/frqZMmTniR+Nhu24E=;
        b=dL/AoUekAlOma8pyu8erDyDC4NqtY4NglIpKhNYxij0DFRLuTbcjT+sceBVzeRcJ6P
         DGGflfsatXe+nJW7hFK9UD3nYC/aEdOnaNVZqe2p8DmNLL3oKOLbrM8C/aCBNHFuLtnk
         uSOfuDZ5zCiKGfGYJw1+UBZElnH8DQkcm0H7Bel0gDR1YWBj8vFeZSthdU2RKjI/z4rQ
         NHuMQWwC2ELwlI85mee4y++Rxxq8TmIGMWm+Bv2JA1ILY7CbZOreF7SmknzQCHxbS585
         eLeqp29Tv0E/LL9og2Bd5PDKgC8NrCVSYCTg8nnKD8SAQQoeTEOTwVXGBz6gHSxFY7mf
         ZyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926153; x=1783530953;
        h=content-transfer-encoding:mime-version:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXHKpeSyKt3/ctGA9pi3psIMZ/frqZMmTniR+Nhu24E=;
        b=GQy5VlPe0t2n9ScY/344m+1PAyXO1yuJ20Z0O8lKSTF84BvP2/YUdBpweE1CwLbAQo
         aBJiB8WBmvqPPPrs8QcIYDBOT9VXirCnZcLcUMh+3IIDVzshHg83WP8HBiq0xxQha5v1
         eYwxf3urdhGma/fTfDNtXhWy4gM6oZXjDl59+G4pEgnjrc2yBVQB4LUazjz/F6/dAryz
         g/qubAZhZR4p7fvLCFpliVSe/ibx2+zTiLvuQkn2csxwSq7Zb3XgIalZbi/ub74xW4Ri
         YW8DGxzbXm9hv59GAPIfDRdtw7S4wXTM8kTX5Fi+h78mfyqFG448SNJ0EGDMBXPa50m5
         Qt/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpoCcrzYvkSaxdHssuZkgmb6aCRDCOLBTy8dew34rq1bIbqGCKhrrVnXR0q2OKCkBrbkYSjcBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkrv8St5aPMTPKm1ED/2NAO1WpuUlSRKBresWj+rKvQVR8WtLW
	UvW17HDw94PzEf9ehrsLHvv+Anc9GLalkbUR2WSSiLBI0Rb++rAedzS0
X-Gm-Gg: AfdE7ck76wZtEHIiTf7qoUmNoaU8g4fRcbgKsZNoo304eOUNR6OXVQyAxuK7wb4Fbuu
	QxLbPKUkecBJ4IVzj666WwmT0+HUGDBl6gv6kCy3CxZa3z1jZVtF0DNLTKlXNKU9v08htOcO9Ro
	Rkq775hqdyxC9uZcp0VGDzVCabgblklHzznYO2XpaACl+4Rk6xGqpkjGRdJm3avf4gPzbN4Q2HQ
	eyMM6Sl1/RoJtUeTQ60K05xz1SJ+wFXnK6vioLNNaH38A+0YK6eJjildiFSLxkcI1IgDOxw9AxS
	WwejZgoYAg3uy3gZezbgr9AJtjmDmtllVtOq/fAot01Y66IVVz7AW5WiJAaPcjOTyKTOonzvJrR
	7RA65iE6y7WVV7PE0CDimp+PffhuOcPUdbvPY06nLxCvGC8LYzdDTX8vnDofOBpXm7pijShs10m
	wor6Dsx5lnrwEoKUMQTvee00QlpIM9NrytM5ZpMEwVrQTMleD016Ej9CY8J/S5J01WlozGCz3Fd
	GHWuNeVoPApw3MiCxEx
X-Received: by 2002:a17:903:3c50:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2ca7e654686mr28663675ad.3.1782926153257;
        Wed, 01 Jul 2026 10:15:53 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([2407:1400:aa40:6780:6462:8b0c:2576:642b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa38fc5sm1121895ad.4.2026.07.01.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:15:52 -0700 (PDT)
Message-ID: <6a454b48.6a8fa39a.27019b.984b@mx.google.com>
Date: Wed, 01 Jul 2026 10:15:52 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] accel/rocket: initialize job domain before cleanup paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rocket_ioctl_submit_job() releases rjob through rocket_job_put() on
allocation error paths. rocket_job_cleanup() unconditionally calls
rocket_iommu_domain_put(job->domain), but job->domain is assigned only
after task copying and BO lookups. A failure before that assignment can
therefore clean up a job with a NULL domain pointer.

Take the per-file domain reference before the first error path can release
rjob. Also clear rjob->tasks after freeing it in rocket_copy_tasks(), so
the common cleanup path cannot free the task array again after a task-copy
error.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f960cc..2b7222afc197 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -102,6 +102,7 @@ rocket_copy_tasks(struct drm_device *dev,
 
 fail:
 	kvfree(rjob->tasks);
+	rjob->tasks = NULL;
 	return ret;
 }
 
@@ -548,6 +549,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	kref_init(&rjob->refcount);
 
 	rjob->rdev = rdev;
+	rjob->domain = rocket_iommu_domain_get(file_priv);
 
 	ret = drm_sched_job_init(&rjob->base,
 				 &file_priv->sched_entity,
@@ -573,8 +575,6 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 
 	rjob->out_bo_count = job->out_bo_handle_count;
 
-	rjob->domain = rocket_iommu_domain_get(file_priv);
-
 	ret = rocket_job_push(rjob);
 	if (ret)
 		goto out_cleanup_job;

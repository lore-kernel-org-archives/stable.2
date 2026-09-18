Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9854E5350
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731846; cv=none; b=LgjEXFuGmtBoOl5c6BjDosoeXeK16gfdDWuHBqzgyZ7CfnxegwKjJNWjS+t0SQhqCHQ1YkdQm3uSMfpbLlKYeutKEaxLrsRsEVS5448l3WUnppWAPxBGdVs1+uZ372nsnwRogcAAwNw0gJjfev/35le0G7bk9G5zNQltOC1Et10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731846; c=relaxed/simple;
	bh=TLmFSaGZ6YlfSIeQ9CJTEgY2bTQ6Uc8e6Zt8WOBkoCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqKxfBoRjGqSpNXKVR9DMv2iGERqsVFLYEeo/cJkiMzq7yC9VN2OiahpfwC4Q7zwNlKfhe1J+w1T3A2z8VScQlhuvLlvTqvO5gSnfdRHqZeSIwAKRiM/b6qVcjCz+XGei4mZ9cn0/+iywTtap5F65FnNJkTQjhazuvhJaV+dQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGmqb0Yu; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGmqb0Yu"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc4c3304833so401835a12.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731843; x=1790336643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQcaFZ1+zYaV5pEknG6YG0muENfu4eg72I6eX4kOQzo=;
        b=CGmqb0Yu65zzdUUzUmepcbz+tf4FhYM3HJtqx084QCUciqeCp8jhRZ416E0YoVkoeW
         MQbCuxMsY0cvVmcoN/S5Ltaiud5mPwFKE0fFGIOKfQTFd24OWrUVXaYNjQPy+6PA5CKj
         qk+1+Tt1Cgz3KMu796UomgACMFPG2te2UBEyJR484q/rJYpmPvUhRsWFI3Rc5RatVbyk
         t1OIGtk2eHNErNehHqSzUSe6aOSl4E6kPDQ+JRgF57iy735wATgssIGyqEWRukdrk1gh
         Eg8e7uH00h/5ES2inb1IPYAqltIxuF2LLvYAQSLgyYdqdRS+jDzWGTE4TvrUSR2sI+Oa
         s/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731843; x=1790336643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQcaFZ1+zYaV5pEknG6YG0muENfu4eg72I6eX4kOQzo=;
        b=eIlKASshC+Reke8HTWB14jWSZjdNdCu+XT72s+9RJJHtzA8bHXwxNw/ZcmXWg5S5pt
         VxVfnWrqedPdpgzZ9e+hhWUQmUi/nT2Ho8xd1L2dPiGI66D1IgqtseEa1YBKITVrBBjL
         5l5ZR5paCQTeh4t0/5KcfFdamN1xpJqTUc/VPVbK0dEHKCTS36EvlJShNDiu0napld4I
         AtF0LAN34xPnXWln2lRUNpPLvMSaK+UsQrUz3YVIaKH9euf4y6ipFs3lX4elFA/kl/zu
         cWPiB4GlNVF32zkph8pfrKDGVFiSZY2lj2qcUWe3wc+bEf08QkoP1Dr7K/Oh5nVnUItl
         Cbeg==
X-Forwarded-Encrypted: i=1; AKwUvBwMEQ7C238euTrH+QAKF+YZwjfZo7YNiAcgxqE8UZ5Nd8HuCYkv9MZmTnOX5DAJnIGFezu4kqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kfxeyUB5AGmk5PfEQA2ROsqrxMAcbM2loSqYgpnwJWVp/QWcRA
	ZTDEJ2Zv/D53mpFN8HkxewkFrfbgX3+7ApFvO7O0RJwPOth/alC+49jC
X-Gm-Gg: AYBFou0ZlEq2FZLCgHuImsL+59aPtogGvXUMNq8WBheHY0wKizA7aMrb9oz9zqQ4Cer
	CdI7eQyJ1SOyrZ9iJkoHXuhacyASSixazRt7+9WboZE9ISwa9ah+zAOSVY68pPoCVXHNJV7yJcw
	+t8tJsmMGulCPWdjbTR81hc+FKR3J25Sl4SY21z+sDUImDgPEtYfkuPt6nqHLT26OMhXRnxT8uB
	qBaqWcfTkSssG9N7BhPsyDaIQZcQWtBP/GkWohvZvpnoGI//Y2GkKsWmC84Cr177Av69oPNDpFp
	f1bCh7pJz52FL6Cp46SOKVeMePYoHakApMMQgr2xKaELfujWA8SG1X5RQbkPf3XNSsoJI1NAHNX
	zpraHpgVq2UO9C7pzMVqt2YdOvzmwgPHt0z+DqXSrAHzQ5D3Tn8exZ0zgajZpLwwwT31BK3GzCs
	ue7vOLyslfk6qhFwa0C/IcgWdHR2qmnm1oc2tg57gy6K31vn/TWr2yzQnVflQg1u7ZmkkphA5Lf
	VXTfgmMFqA=
X-Received: by 2002:a05:6a21:9204:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3dd8c3fd351mr4731985637.1.1789731843082;
        Fri, 18 Sep 2026 04:44:03 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce02b063sm3404520c88.9.2026.09.18.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:44:02 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 1/1] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Fri, 18 Sep 2026 19:43:54 +0800
Message-ID: <20260918114354.3660102-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918114354.3660102-1-ndaugoing@gmail.com>
References: <20260918114354.3660102-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 907c3eb18e0b ("xen-blkfront: convert to blk-mq APIs")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 drivers/block/xen-blkfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..e70b78ca4df2 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1210,6 +1210,10 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1292,10 +1296,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	/* Free resources associated with old device channel. */
 	xenbus_teardown_ring((void **)&rinfo->ring.sring, info->nr_ring_pages,
 			     rinfo->ring_ref);
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)
-- 
2.53.0


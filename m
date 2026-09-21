Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA348EC88
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989281; cv=none; b=pk23x/n538DkVJ4xHPdLcDtqnrS6PdvMdt4vnbFBTqiJc7sphMMtm5yocaYSkch7avAcHOpVKbAE2Anck1rThPbWoR4PIkMaKCIYp5vhtYiIwx473obBz0qB4JhNuY6QLHzpRL/M8aWQFMVAhNwej52Cmf2ObkAmQH2Qs7T5fF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989281; c=relaxed/simple;
	bh=fLdKnRFefQ7xNBf+MaSnVN+wrnJPV8J62ru1s6a3Yfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNNvfVJcN0cw2oxYBjayFDQYHLZxh+kAUCVtmxG7TLoinE7VNkl/9G3sT3UZJMp55qVsd3uZF/kkoYkwVG+Bbkfl9T7IDGK4KZ8VMa1D8R7pNwOAAKXcTQpEKhIAJF5N2qLFRvioKfASz2/696BjV1E7dweXdXXcWlC3R+KR2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK7Jzu0k; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK7Jzu0k"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so1816590b3a.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989278; x=1790594078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XG6ZJcQO7Cvak2rHk7+0ID/dwXbMAp8I99Tm0qAbV6Y=;
        b=eK7Jzu0kSUPN+6t0UVG/JeJbZqfOMa0Mi+Gmimp0zGUGhGViVjsqJOYoz1ShYFxvwO
         t9GRc42I3GJgXMYFfYOHBibCQpULEEJIG3haTcnDIHajcVtwJrrrwkB62V2ICtXgOmx+
         ndo4H7ULIiGy/CP3tm+MEbDCyN+RhzkqMRJgeRBerYOOJozgq2g9nJr09wGS5zREo6jn
         Ns3P4qJfwI8+elD73RTKNgi+VhwFyzHGV5Y37Q6cDpy+pqhDghzmryeXtlWxG/Wi7MHw
         V4hrTIdlRzRw51ICJv4rLgX+uqqNZt4CiCu2OG9N1wMTeNEm6H0Mr9JHZOwDGCrFbzP+
         NKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989278; x=1790594078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XG6ZJcQO7Cvak2rHk7+0ID/dwXbMAp8I99Tm0qAbV6Y=;
        b=cddD2eZHlyarWfCdFN3MI6r8G7dMYVN7FzHfCu9sOzPrlHSvHA10Lav0Agl5dQd/Bu
         Uj5W7KpBTRklfiuHtTxxVzVoPz1QhF6yTSMEuiwjSIryG7AqmA6QLtqhxZO985oCqQHQ
         vVJU1zwTEzROKkPLKsi4MfoB7/seNOTH0syFZzKl7tR5k8zHaGQHlxiE32mr9EY37KHB
         rbJC+4VSnLcQy6lNJJoFQIuFhrbbeTZ2Xk1N21gh0IvMacKyGIX3POfVZgvcUTsEH3Df
         RuUv2pNUzy6c4j8egzwRd8JknEDhbnTPV6UtYdxAIgbuxosMqgiZ+CfHQDYjsiT0baKr
         ZUOw==
X-Gm-Message-State: AFuF++kbgKsrajks4o84TXYx6/k04ZOMaFZBAsL5gmAv2iky+7wiw8Yj
	sco6DjOIxSCZ/rUzorS8UsU4jAymCK/LAGiTIHh5f+S+NKESj83xhG0v
X-Gm-Gg: AYBFou0lugIccfhJn0yBEuCUTC/m7R3pJaapHXbRn272GC3KbOUobZs/oOvBJGg0g4F
	EM4gVyYiLswsc7fH63QaY+r5X1VXqTRRuH7CdWd7EHrKhNPWUphYukLNRb6iq6tAl+clTjTKxZ4
	WnmIPTfVLQACQUwm6YKEyRD7qGEhDxzymTvPn1hq+0ZJ2Vy3d8YO91txd//iFFzHbQThfncQXf8
	KpTMR0eAY5Dp63GkqHIHRJrFxCB96kyOgAUgMQE7mrzKf45pUH1iGBdIPvZu0nroOfJoOoZeapG
	4ETf8xw766G8NZfVPClaLuYxbJttKuTBXPr0RiDtqHtlmkZ6lo2VkuiKjCc1lAISTAQ+nQY62Qy
	Jyf6EKZidaPltBa27u4OF5zvAEIv96fO0xU0Ph4uacS9JIQPh1G7adg/CPsJSzsDrZUmbVDmvdE
	tDeTi3HKqUw/mSJ9YJDDIM2pgHUUFvJ5YYLt4/ZL7U3w+PgFga42fS+g==
X-Received: by 2002:aa7:88c3:0:b0:878:3783:8a4b with SMTP id d2e1a72fcca58-87837839351mr7344642b3a.51.1789989277939;
        Mon, 21 Sep 2026 04:14:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe201sm3112714b3a.18.2026.09.21.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:14:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Peng Ma <peng.ma@nxp.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
Date: Mon, 21 Sep 2026 19:14:24 +0800
Message-ID: <20260921111424.378477-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa2_qdma_setup() allocates priv->ppriv, but failures after the
allocation can return from the function without releasing it. The
existing probe cleanup for priv->ppriv is only reached when a later
initialization step fails.

The normal remove path does not release priv->ppriv either, causing the
allocation to be leaked when the driver is unbound.

Since dpaa2_qdma_setup() is only called from probe, allocate priv->ppriv
with devm_kcalloc(). This automatically releases the memory on probe
failure and driver removal. Remove the now redundant manual cleanup from
the probe error path.

Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Use devm_kcalloc() for priv->ppriv, as suggested by Frank Li.
  - Remove the now redundant manual cleanup from the probe error path.
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index bf771251264d..d6843da29122 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -353,7 +353,8 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 	}
 
 	priv->num_pairs = min(priv->dpdmai_attr.num_of_priorities, prio_def);
-	ppriv = kzalloc_objs(*ppriv, priv->num_pairs);
+	ppriv = devm_kcalloc(dev, priv->num_pairs, sizeof(*ppriv),
+			     GFP_KERNEL);
 	if (!ppriv) {
 		err = -ENOMEM;
 		goto exit;
@@ -757,7 +758,6 @@ static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
 	dpaa2_dpmai_store_free(priv);
 	dpaa2_dpdmai_dpio_free(priv);
 err_dpio_setup:
-	kfree(priv->ppriv);
 	dpdmai_close(priv->mc_io, 0, dpdmai_dev->mc_handle);
 err_dpdmai_setup:
 	fsl_mc_portal_free(priv->mc_io);
-- 
2.43.0


Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919F39A076
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426392; cv=none; b=kk0vwHBRToENFEL6MZKRmC/askn5BqlBbVKLRyfJj7cwYcpU7PoxCofgfpJIxYaNLSIF8FIBT78ZRtWlXP0C2pxDp0cVeAttcuw7LVZcPkq49GAq4d6lg1L3/zSFSLeu7ivuYZMdzO7Rw94fTAZr+z4HMLxhevDyYnRqjp5MqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426392; c=relaxed/simple;
	bh=H3E2VUOeSZ6d9yGEwVnxSBk+sMS7hg6UAIMW1iNHWqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jepfTNZJNaNX6fQtCh9DnzaL012VlXz1ETl5mQkxHYts3ZgrIlshUj8dpSGO9k5IEgma4FGgJe1gkyvE3It2M/ylcCA/7aXuzPWH8vR9LAKGCc+ZhImhb9p/MLHl16oTBFW5dfdDljGxsR9k7e/gxmeCmD+Sv8uLJEt3LEedP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoKrKgi2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoKrKgi2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so8943405e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780426389; x=1781031189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Gw+lAJx26MHPvNsPTjwzTfgQLbZfxxh2FfWY9yR8kc=;
        b=YoKrKgi2gL0GoKzGaw1/LKp2N4iM969WiOOGpWpwLfYIoS299ryQPs9onU9Wj6ptXL
         fgFMBLoQ/q8JKeCKEw+zQmVHBj979uDGvdOLYMQ+cotDjYR97Hw4chTn97l5j9m9hb5L
         SSvMWZ3CxZZ2qRe4u4wpKayeY50RncKJ7ezF2cDEfvzIvh4nAFehP6ofoq2VgHUBiMpm
         ZQFkp7TKL86Lr4p5UtqlQLnRVj7nbIQehFbbkjLcrMIUosBylJ8imN48wFMniSx8RBPy
         CUdeZ7Rkpmyhe45TePng5CIRdS+UsrRXaiUtBwKuf6zJUjyV4v/eFT2B5lBvr/XAN/lT
         aeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426389; x=1781031189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Gw+lAJx26MHPvNsPTjwzTfgQLbZfxxh2FfWY9yR8kc=;
        b=tZWlfkqclqB+xBGIlAJ4JbTx5tVjSES+F/+CTw2hncIgJU4kzGi5w5EYTxCZ+Pt576
         5D0ondKW++zZ610KEENKpRbmXpSly8EOpRjdIm5NEb7iVLwFMhW5mcw7tZrcOo6lM+3p
         rpsvQFgM1wlShcuG3UpQ1Z9Z6dRu/TTxxe+VRCI3R0U9KctH4pXBX4JAwKn7rW0S37s/
         nWaBtNiSoFwPOJkypN23FpblAX5KQcwUaXjDJ/4RcA1OM2mWbjS4RSKAU5P6gEOwQ99B
         pZjzce9e1Kjz3ADZnCe5iJHLqHQqdLNrkjX8KO4BGX7lAZh0JjHRtWy+0COfcXYefNO4
         oHWw==
X-Forwarded-Encrypted: i=1; AFNElJ/oTL0SNibTAGiO8lP4R57MtRLbyHFiBORC3zcC9pBDmXz0QJ+Ifh6lAAZbZSVkKJ3VBujnTXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/gh5dUwEsA4HufinJSN1as8hCaMywmH90eB4ohKpuS4DG2aN
	pDXHKAHl29+avyMjSrgmuAMY+mSTdMS7FFphZ3XUBjMdyRb7VzWUKylM
X-Gm-Gg: Acq92OEzbjQUhktv/yREs0KtZRp66GD+MukF4FOjVMIw3l7mW3o4yl0TFQxKmGy30fx
	LHiGSsSLRA9yGfM7pG0iitcBMaFhfz/8PYfrdoj1e+cq18RhrSkEloJsu0jaZ0EgLwhqbyJHvfM
	BgUeL6fAYKfVZbwYr+4ABqkzKpfDGvxxf5x0hYHJGpE/xVvWbfniD10Cjq+DTLUq24pvAmOO6l7
	r3WwDmFvsppxTv4s0+w4NoyTmrVibNpzDUeSn+ifqyPuSdFDfJJPiaEPSwQ8n5Pc0eirr4gNiv4
	/+m2AL10Nr8v9UC0x5L+G3ybHSKeCIEupzPwOudGemZGj0btpEATfHeAcTTGvH7FE8G61+jlWbc
	ShYB65Xmt/FhPMqPQVtfCs0YOZUCgrsOJaf/GZmsbAUPQO70swwBBhbXdZYsGLaXLwQ8Vx6uTCA
	d/yUrA81erdpuktrpGWFwg2p7iKQBELytVMGkV+5pKFHKOa5WBvS9Xrq37ais+5kHwEFInWnCqD
	hO5N6KSnTsA/05ng5+CSA==
X-Received: by 2002:a05:600c:5247:b0:48f:e245:394e with SMTP id 5b1f17b1804b1-490b60f6453mr702585e9.27.1780426388995;
        Tue, 02 Jun 2026 11:53:08 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm1356023f8f.5.2026.06.02.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:53:08 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nayden Kanchev <nayden.kanchev@arm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] media: mali-c55: fix dropped last AEC histogram zone weight
Date: Tue,  2 Jun 2026 19:53:05 +0100
Message-ID: <20260602185305.30759-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 15x15 AEC histogram metering grid has 225 per-zone weights, packed
by userspace as a u8 array. The driver writes the first 56 registers
(zones 0 through 223) in a loop, then handles the final register on its
own to keep static analysers from flagging the array access.

That separate path computes the address and value for the 225th weight
(the bottom-right zone) but never issues the register write, so the zone
keeps its stale or default weight. Any non-default weight userspace sets
for the last zone is silently ignored, skewing auto-exposure metering.
Both the AEXP_HIST_WEIGHTS and AEXP_IHIST_WEIGHTS blocks are affected as
they share this handler.

Issue the missing write, masking the value as the loop does.

Fixes: 01535ea08674 ("media: platform: Add mali-c55 parameters video node")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
index de0e9d898db7..33e2232ec8f5 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -212,6 +212,7 @@ mali_c55_params_aexp_hist_weights(struct mali_c55 *mali_c55,
 
 	val = params->zone_weights[MALI_C55_MAX_ZONES - 1];
 	addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * 56);
+	mali_c55_ctx_write(mali_c55, addr, val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);
 }
 
 static void mali_c55_params_digital_gain(struct mali_c55 *mali_c55,
-- 
2.53.0


Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A68383310
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442659; cv=none; b=FRuAoEzd7PJABR8KLj1gtvewmGAtbM3BeVBmNF/kbmDwCSdOp01JM95ceZRULfke+Z+v40o5BSn6EUheFdutDQ2j9baXyy3HxWgwOYs66lNXnCR1hEfCWKaZvc2URLARm0hKzAV5nrDLYv+ee5ey8BbWkYHCldTSg1bKoyWjRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442659; c=relaxed/simple;
	bh=1Ijmd4NtwbrxYG0QbmrAlqjExMAyCe44/2dJ1XZKKMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQx9RAMejhMiaDcXfsQ9FZPdgmT7cD1FmYu0yc0EkrehCegeUvumu6dBjDhvu349b8ZB9aj0VCVmqVOFvG5yHOA9NnRZvBmZ/8DFbqxTNvNrP6BbXVp6331TMnrVyHvDPK1Gb5XgqxQ0506uNDi0dr9oN61aEUHDI5kaInKu7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedlinux.blog; spf=pass smtp.mailfrom=embeddedlinux.blog; dkim=pass (2048-bit key) header.d=embeddedlinux.blog header.i=@embeddedlinux.blog header.b=L2IgYw6v; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedlinux.blog
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedlinux.blog
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedlinux.blog header.i=@embeddedlinux.blog header.b="L2IgYw6v"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3a0cb6b922eso492249a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedlinux.blog; s=google; t=1790442657; x=1791047457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0/79LdVzvZe+TAFF8pS9QgkNB/YVyvKTl0/c5RoqxI=;
        b=L2IgYw6vW8xHZseT0u/BrE3tqC4C62lAdDxT4lMSuILCnmhBEqEt27ypHi8rQK06Bk
         HrGUp/4oC/m+yslwIFGAZ61FvvFcG4x/j8nNqswfdNntkD+SZeOuYbfqdTFwhQFhcwBS
         eyiC/tiqTH6ZbdhgovRXypAlRDXHc9gLJ1DHu1Y0z/DWo+KnWzqWTgyhSw5Jc4oacw10
         7OxnMUgyln/RK4UAJm6q4826RGyhM5HNpptyeiXBq7LYWYZKA9du4wbwFGxVGlZLf0ww
         yWnkOlDAEmuWOkauwgJRnuERCrKY4S5zwoOrJjANH/ur9puem4Ap8MbxfFYMQQA3Veg7
         /s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442657; x=1791047457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0/79LdVzvZe+TAFF8pS9QgkNB/YVyvKTl0/c5RoqxI=;
        b=CJ75alxQ+rhxdqcn4zV+4cafUOIMEN9svmk7kyeS6wgwbsq8V40Uue/pXZlUGXYxzX
         nrymuxskyeXrJ4vybdQDlFqCeP2Y8cuiVJ+cjDXOGSU/TWpIs2gtP/5c6tFoa7XMNn//
         Bdy+vqwpC4aEIdkBd8kmyDSZTFWljr1cq+k1rCvJ+TGu2c5/r/2BBVRp1DQYBpR0cwrE
         YDMnfHMgS+i8/hPntUpJLTRH52Fe6SJuGl5zN/F6ANTZMm5jmUPnzweu9BbQOaGoQgvN
         efadmwJbraxSdo98kAxVkIKR12I4WzkX8Vc2yTmBog6PTcu5IJX0Qh/j12N1AkctuB7o
         TGTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/zNNZRYEltF7dSiqxm1T4GQs6Oac1CJ24HDrQUrpBnoN3ndzGpcSVyf+nWvYz5Ve8ZPawFgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7gJhPDHg/iVcIw84EpyRPuTJINFUmuQ7xtvI05oem1a9/cpTY
	OwYNxFc9NP67lJlZgc7oy0S/sDmkU9bEHIc9E33jrCIt2CoQFEYliXc2lbdq5rTHszo6
X-Gm-Gg: AYBFou2mjURoZoOejFzJEDZ39HN9ohz3lPQugHaJf535esPQjcbo0WuLV6yZaOuK/os
	vf0TFvvXmVro4lyJ6L8pfcWoQ3WVS+PoWjtMgXJS4g86shoYMqrbU2VfX/JbjFyDW2HzBbc86H/
	sSkGpJgT9GctgaFwGy4qHbh6Yen2t9ONMiuKXdeIJxuf+BWH2kU0uVXMH+vcHYlnEse/UerrYFw
	EGsSyw1rrE82mWXy4yZkF2idxKmIK4OfyN6gZSCzgIs5ik/SZ3oQfUD+WtG8dkel0WLxDorJXlR
	8IkIiOUcAbAtEMex2nWrz/s8cizNzCfMHswpoRHkdP6dC2T0QXlyJ/uaJCY7VXMkZ13ZDJy90Br
	FooklB0srnpW35OVUgmFE4WfAxrqYSlANEhR9pUNxQ93z4ZKcd8Q0YaCO2xno0Th5ozxJ5l/zrB
	XmU1jSKIQmSb6vUdbhJCi04VCBYAFN9HemZgYlN3PNLfXi1Uju6Ipz8KbCbHDnE3T+Lg==
X-Received: by 2002:a17:90b:4c42:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-3a098bb66d1mr8321977a91.31.1790442656808;
        Sat, 26 Sep 2026 10:10:56 -0700 (PDT)
Received: from ltu.. ([171.245.4.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c7435sm17467136a91.11.2026.09.26.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:10:55 -0700 (PDT)
From: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Chengfeng Ye <dg573847474@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tien.nguyenminh@embeddedlinux.blog,
	stable@vger.kernel.org
Subject: [PATCH v3] dmaengine: sun6i: Fix potential deadlock on &sdev->lock
Date: Sun, 27 Sep 2026 00:10:49 +0700
Message-Id: <20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <dg573847474@gmail.com>

As &sdev->lock is taken by the tasklet sun6i_dma_tasklet() in softirq
context, other users of the lock in process context should disable
interrupts, otherwise the tasklet can preempt a holder of the lock on
the same CPU and deadlock. sun6i_dma_terminate_all() and
sun6i_dma_pause() take it without disabling interrupts.

This was found by an experimental static analysis tool for irq-related
deadlocks. Lockdep reports it too on an Allwinner T113, where the lock
is also taken inside the HARDIRQ-safe vc->lock:

  [  299.389380] WARNING: possible irq lock inversion dependency detected
  [  299.411196] c7109568 (&sdc->lock){+.-.}-{3:3}, at: sun6i_dma_terminate_all+0x40/0x2c4
  [  299.419137] but this lock was taken by another, HARDIRQ-safe lock in the past:
  [  299.426398]  (&vc->lock){-.-.}-{3:3}

Use spin_lock_irqsave() in both places, as
sun6i_dma_free_chan_resources() already does.

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
[tien: rebased, added the lockdep report from a T113, Fixes and Cc stable]
Signed-off-by: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
---
I ran into this on a MangoPi MQ-Dual (Allwinner T113-S3): with lockdep
on, stopping dmatest set off the report above in
sun6i_dma_terminate_all(), and a small test module set it off in
sun6i_dma_pause(). While looking for a fix I found Chengfeng's v2 from
2023. It never got a review and no longer applies, so I rebased it on
dmaengine next and added the lockdep report, a Fixes tag and Cc stable.
Chengfeng, I hope you don't mind me picking it up.

With it, lockdep stays quiet on both paths on 7.3-rc4, and dmatest on
four channels passes while another channel is paused, resumed and
terminated in a loop.

v2: https://lore.kernel.org/20230726051727.64088-1-dg573847474@gmail.com

 drivers/dma/sun6i-dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5ad9d01cf..aee32363c 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -887,6 +887,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
 	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
 	struct sun6i_pchan *pchan = vchan->phy;
+	unsigned long flags;
 
 	dev_dbg(dmaengine_chan_dev(chan), "vchan %p: pause\n", &vchan->vc);
 
@@ -894,9 +895,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 		writel(DMA_CHAN_PAUSE_PAUSE,
 		       pchan->base + DMA_CHAN_PAUSE);
 	} else {
-		spin_lock(&sdev->lock);
+		spin_lock_irqsave(&sdev->lock, flags);
 		list_del_init(&vchan->node);
-		spin_unlock(&sdev->lock);
+		spin_unlock_irqrestore(&sdev->lock, flags);
 	}
 
 	return 0;
@@ -935,9 +936,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock(&sdev->lock);
+	spin_lock_irqsave(&sdev->lock, flags);
 	list_del_init(&vchan->node);
-	spin_unlock(&sdev->lock);
+	spin_unlock_irqrestore(&sdev->lock, flags);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 

base-commit: 0a8dda0a15d3926422d286567f945a05328a4ac6
-- 
2.34.1


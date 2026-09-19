Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0235C69D
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807673; cv=none; b=b7y+YniTt4g0q88JXf/Ea9Mkm5PljXeseZpElL8qlTrkMwNbSOruyyVxzLqT212NKupH1J9DORhH7dNZS/yTWrVII0iuEJNnewHQX9g5zxRA2CnpV6XYy1vnf0VhiK6Eg6IC/wTZNF4FgH6SJWBazMLhzIP+sW2BbiK/IDaQUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807673; c=relaxed/simple;
	bh=DYAShckXomVDJr3XAdzG+ca5X7Lx2QNQjGhHsqoCEaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYjvbhjWtJU76legre9kkR59bZTTCrN6ccxiy/1S2Os0aAtEB3bHDlHBFCh1FKYnJF6v3icJgZwXAJT8aCDnoBSHgIix2RXkzjK9UaOlhQgYL05Bxwc8HrweMopwst5C925AScmXbnR0GX53waMhkbhDpZn4ziMeFFh5iqZuVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT9aGyZ7; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT9aGyZ7"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b355ffso961029b3a.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807670; x=1790412470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgdoQnywZtJ2LcW7ra2+q0vZEMEzGxqganpX19bHuVg=;
        b=nT9aGyZ7mLzLt4zAdQXFH9vdGQ+qW+rvoxcLUtfMvUycBvW84mBjowkk5Qv/gb54pf
         mmu2rBkDdTB3elTiivIvmQfzPYbFe+mR44xa6rhMzgU1EyEp0yJYMB1ytAiXJOCvDyBk
         RSTedzdoCyLF3li7YyJxMIKg4MLx05jsH0ueGLDyMYedtt7o4DpGNAvNCI0rcpPgp9oZ
         Rb6+D+c6+oMYmoBumupfn/aw1TffPEi69Qas8mRycSOFvNUXAgVH+woGO2oj+cwoU2Z6
         8b7IgGK4/3Zwfistzwb7kf++uZUxHGLdGdmQ3Ia+2zaH2DjEw3FJ79DNSlUDetr1kOuu
         E91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807670; x=1790412470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgdoQnywZtJ2LcW7ra2+q0vZEMEzGxqganpX19bHuVg=;
        b=wQSV1aiD1TGSrJAt85cpMy8cHhU3e2uKaMHuIYshnIBGq9CEBNIhujBYhz78OJjWxt
         So+X4vaD8+cSECKbtdJurmA2eFFVWKgL35fAEQWwmKZ1FG3Z5BWw9CwpuZJAwSRmOoC+
         D9VfcxbTREoIiZPyFiZ8bz8h8h6yvWaB7hPO33EbzDJUQgZ3MMOTNmF5dRAkvAp3J6Xy
         MpO8+gxL623FYYFeC4fdDR678by8y82rGtemOEL1RiLrv3RmmzNqnB4jEm6PlDUfi0eX
         m3ndU71fu6h84YYQx3GSTfnuWveYHb03akxq6CA619yLTW8MdxCmD19/fqPIcbjPq7bV
         ofPg==
X-Forwarded-Encrypted: i=1; AKwUvBz4iPFBSbHNRZG0M0E35e5HfkUkvwoNpeA5pY+AUU8q5yoYzDhHjhSt3dtUoBhHP3fkZKijqeA=@vger.kernel.org
X-Gm-Message-State: AFuF++kzk/KX33N2iYVoVoh5moqok2114OmPtcNo4xM8lbuuRy5kplNy
	6gACUQ/GIrfH+7UMGELxq51rdZACaTUG0z3PXKxz/wEMZvRRgPdWTshCHjRhQijXtFo=
X-Gm-Gg: AYBFou3t4xC020eMP6bZOZDm2Z3/g7gNArqIrc5LX3SwQLlE0HuIeRBa3tuwx/JeSvI
	S9QJy+mMUktVcAMQOg9lxAzyQmkVXfMlIaF2LWGHQmPra+tDlGjGuTCXm06WjLZ2lV9fWMhx1sf
	OntW7huRYyzrmhsAhXzKyIL6Q+ySKJ49VKTptjdp4AiGkbs/0nte1d3G5aeCzj+akBHXNiybtpg
	467BqSAbjK4PLVmwoq4Xl/8ITgPZObRgA1knw1say9YeaneNhGwxuQSUJJfoe6vh//GWBX/1xdf
	HbqsiyMDDmmzpFNCSyKd3dxjOcNdzV6hYbBo9IaQeQNZlT59OBZdvC+f+sYADU3eMnAI/qL2td2
	iqTE2z34i+1GyEaiHI+PtqinlthmBe/FasTVTaZoTwo7PhvSc9KrbTW7W4dNGRVVqPJWsp9+bIG
	T0khYMp5YnntPEslvKmtOAk8QnRHQHS3NBOLmX+bRX3Nl6BQYGP81txoxBGQCjUGVLlYQ/3Xeky
	OEUZQ1rezD0cVHhTA==
X-Received: by 2002:a05:6a20:6f90:b0:3dd:a195:dd5b with SMTP id adf61e73a8af0-3dda195e52dmr2980024637.61.1789807669769;
        Sat, 19 Sep 2026 01:47:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:1a32:5e90:b876:a980:6e09:6daf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8eae3sm737021a12.14.2026.09.19.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:47:49 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: restart the next queued transfer after completion
Date: Sat, 19 Sep 2026 16:47:32 +0800
Message-Id: <20260919084732.502247-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 333e11bf47fa ("Avoid hw_desc array overrun in dw-axi-dmac") removed
the axi_chan_start_first_queued() call from the non-cyclic completion path,
after observing that a descriptor started there could be dropped by the
non-idle check in axi_chan_block_xfer_start() because the channel has not
fully stopped yet when the transfer-complete interrupt arrives.

That removes more than the race: with more than one descriptor issued on
a channel, the first completion now leaves the remaining descriptors
queued forever - nothing starts them and no further interrupt arrives,
so their callbacks never run.

Fix it by waiting for the channel to actually go idle after the
completion and error paths disable it, restore the start of the next
queued descriptor in the non-cyclic completion path, and skip the start
attempt from issue_pending() while the channel is still busy.

Fixes: 333e11bf47fa ("Avoid hw_desc array overrun in dw-axi-dmac")
Cc: stable@vger.kernel.org
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index eebed2474210..f3d89f5cc12a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -263,6 +263,26 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 		return !!(val & (BIT(chan->id) << DMAC_CHAN_EN_SHIFT));
 }
 
+static int axi_chan_wait_idle(struct axi_dma_chan *chan)
+{
+	unsigned int timeout = 50; /* 50 x 2us = 100us */
+
+	/*
+	 * Writing the channel-disable bit is asynchronous: the hardware
+	 * finishes the current burst, flushes the FIFO and only then
+	 * clears the enable bit. Wait until the channel is really idle
+	 * before (re)starting a transfer, otherwise the non-idle check
+	 * in axi_chan_block_xfer_start() would silently drop it.
+	 */
+	while (axi_chan_is_hw_enable(chan)) {
+		if (!--timeout)
+			return -ETIMEDOUT;
+		udelay(2);
+	}
+
+	return 0;
+}
+
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
 	int ret;
@@ -501,7 +521,7 @@ static void dma_chan_issue_pending(struct dma_chan *dchan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc))
+	if (vchan_issue_pending(&chan->vc) && !axi_chan_is_hw_enable(chan))
 		axi_chan_start_first_queued(chan);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
@@ -1067,6 +1087,9 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
 	axi_chan_disable(chan);
+	if (axi_chan_wait_idle(chan))
+		dev_warn(chan2dev(chan), "%s failed to go idle\n",
+			 axi_chan_name(chan));
 
 	/* The bad descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
@@ -1108,6 +1131,9 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		dev_err(chan2dev(chan), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
 			axi_chan_name(chan));
 		axi_chan_disable(chan);
+		if (axi_chan_wait_idle(chan))
+			dev_warn(chan2dev(chan), "%s failed to go idle\n",
+				 axi_chan_name(chan));
 	}
 
 	/* The completed descriptor currently is in the head of vc list */
@@ -1141,6 +1167,9 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
+
+		/* Restart the next queued descriptor, if any */
+		axi_chan_start_first_queued(chan);
 	}
 
 out:
-- 
2.34.1


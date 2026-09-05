Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB33451CD
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788589747; cv=none; b=fckH7vdjPvwVM3iXCt3o6Tx3Vbbj0+qgz1cZ0rGddYHC/QieISns+OR17LY8OXZFNrIJe7gtpXs7vr4mSy3Ze/Eo9Wvy+uOqyiNReW7NfyLvfYQZ87FodREvWlwmTwOXWCWeCWbb47c7Pd9CACLQPfrP26tkX5K+WjQGyj/IxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788589747; c=relaxed/simple;
	bh=hdfmlvBCHG94nOK1kTFtZiYtegNR1ypidelCpy0e/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbax/y4fybZiexGU483+HLWRTTuQAX3zQIciUgOqN0vn74qEhOAZ75dsp38GRnz8N9WwJQ6gg4vgl9BIqu5r5umJvyr/ScgJl7Qg9eRkH6prqo4xnpIFQz40eWflfTuFC3+uFb8bqjxN58EWDtt0a8W8vGzuj6KT5A6s3OpWPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSjVVmgE; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSjVVmgE"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451a49abd8aso1834600fac.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788589744; x=1789194544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmCI/5FNN55F8kGIHxPRLlIa26llF9VdD81iCD4sFhM=;
        b=GSjVVmgE1BVH4vUnNiLSj/5j9Y01oZqE0GyeFfyNlCmx9DnnYOg1AUQuggxovoSSBQ
         ZzYHWcRxoNXcvwCtAX/UyolQeDTp7Mk4S2BTHnGzsJJGEnjUhizuyEDaBxRDbCJ3haPb
         93spp0kILp9sjem9gre88pIwUidctIoJTnkZDYe8vCtbWfbvPuxb06Rwgg5MoUxaFETc
         QKL6rdvZ7oeJfJgc5NkgrTu5wsQ4IX7dKAnI1cERJOvIaVJ6Nt4HwIo3TPMXOjnYPeNs
         8AbCcf23ErzCDayQpCy6bUHLZhjYIr7pnDUmwl9vKWSIavoVkRYoB9azpPxgPrcsGjYD
         sGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788589744; x=1789194544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmCI/5FNN55F8kGIHxPRLlIa26llF9VdD81iCD4sFhM=;
        b=T+qMjMsGWemT90UbBIfuORYdot+y7xAL122UNa+W0FqaiWcq/mR0lQZf0zDz37upjz
         JBF6ptsx6MGmCr3GHrY99aKhaAllzvHUxYinxWnm7UhgI4tmINCqISe+hckPuRUPVa4E
         owLAgaoplw+TM9Z7H0wnSDOxl/llpxAfihFvPpSqvjHcz59PTL4g5SYda638mhdpFAlN
         p7uG4xF22TOJkxr/RS57l5vArY0LzfLGDHk0h2qMfKdMThWCCPArjQeAORe/1/bD+aDI
         TOu+GeStoZjNtOLPvYyNZK08OJd/pifvzoxqmabbP+HjEYcNwClaqJPeo0YlYVXd/SQE
         0VGg==
X-Forwarded-Encrypted: i=1; AKwUvBzSIVuwZRy03SCfQd3+glFNDOOHKfBh0FQjKvLcB0ahJmX3zzLSc4rDhORmnPyR8IfQztXTYrc=@vger.kernel.org
X-Gm-Message-State: AFuF++miLxJMwYBM+MNTnt4hDCXkaTleHFrDgtDVqEiMPE4MOUTJb5o8
	KsCOk5d8EDyogreBNCPmNAlMoMUUGP4HlC1cA772VGjGZCWGa+456TZR
X-Gm-Gg: AYBFou0oGUghLh2ExrVjGYBRRRCSloGYkhznWdeCxHrF+8J1Oepd4V3nNoY5lnBHv7O
	D72JXfimdTrVJ5NY4z3njs/Ulg5bU/C82Y/BuVTpVqnqV41dfhoIJ/yBJoIhRuJH4KfhfxV/EQ3
	awAUqSjdZHEa33sTtbY2EOYyo5uQIfs9YzSPlUqZeBNlDuwXe8cifWpdTnkJYhVPi7cHwxftl6I
	1j3lalM0wm0t6btdHZZaUYd1ceJdsFdw189GHIZs9wpUYerOg3J+jQFJJP66cujIUCt7uXT/hzZ
	19WreTP8dcZTsyTz4xr1wQhpEn16B8mEcuDbG+/F5ZteznL29919f1nS0dn/9+C/3B5lNL6RHQa
	PLZDRavMhrrd3BplOWrXwspRvdL8suTnEgzrTLEfLrKRO15+Ilp63D9HalHioMzyML00q22lqdQ
	vQNWOOQr8IzXee5ezlUYX3Rd3dUxy00GJMjZzHI8txLGDwlsmT3hgbuWP9ks9sNnkROng53RBNc
	Q==
X-Received: by 2002:a05:6871:213:b0:475:e066:7714 with SMTP id 586e51a60fabf-475e0669518mr4594311fac.27.1788589744512;
        Fri, 04 Sep 2026 23:29:04 -0700 (PDT)
Received: from cachyos-x8664 ([177.245.224.138])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554d7bde7sm3881145fac.16.2026.09.04.23.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 23:29:03 -0700 (PDT)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>,
	stable@vger.kernel.org,
	"Claude Opus 4.8" <noreply@anthropic.com>
Subject: [PATCH] dmaengine: loongson2-apb-cmc: fix descriptor leak in prep_slave_sg()
Date: Sat,  5 Sep 2026 00:28:33 -0600
Message-ID: <20260905062833.272484-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loongson2_cmc_dma_prep_slave_sg() allocates the descriptor with
kzalloc_flex() before iterating over the scatterlist. If
loongson2_cmc_dma_set_xfer_param() fails inside the loop, the function
returns ERR_PTR(ret) without freeing the descriptor. At this point the
descriptor has not been handed to vchan_tx_prep() yet, so nothing else
will ever free it, leaking it on every failed ->device_prep_slave_sg()
call (e.g. an unsupported transfer direction or bus width).

The neighbouring error path for the num_items check already frees the
descriptor before returning; do the same on the set_xfer_param() failure
path.

Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Link: https://lore.kernel.org/all/20260818094957.7D2221F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Co-authored-by: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_012bUV3WshMSfTq61n1cgh1i
---
 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542edc85..60eb4d961610 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -404,8 +404,10 @@ loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
-		if (ret)
+		if (ret) {
+			kfree(desc);
 			return ERR_PTR(ret);
+		}
 
 		num_items = DIV_ROUND_UP(sg_dma_len(sg), buswidth);
 		if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
-- 
2.55.0


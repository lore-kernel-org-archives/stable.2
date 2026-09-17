Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F131328E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607611; cv=none; b=KWwBDckQA4V7K3hhqCYNzWOQXiyAQFBTnmNEoa9LBwn58quu68i0VotKLJpwIq88+V2Gk5jux0P0mu79IVqj7CmUKxBKlVX/DNVkNqDIKfWC6kUXAteYtOrLLEa0VAdh6ugg1G2HoRQguxCSVleOOtE+ePeDAoWuVpG943YCUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607611; c=relaxed/simple;
	bh=cukfPYsn4d5vNMPkMzrHZD+jQu64Um+b6vTCAWSjTIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhG++DkiGR9277mAecKKckoUwwrDydmv1js8eEWsh8mE5qG4Nw3d76zf40rMAwh3lyjUQj6+jpB0tqnUBIvqwEWOeYMzsrhcDRFTD0KAo7FqqC8N90IdsEu/RGSIdjaFxIpuZ7jV3pUZ0RClbCapjRb4PmgUAoslBbjTLtHvT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaLl3rFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaLl3rFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459851F00899;
	Thu, 17 Sep 2026 01:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607604;
	bh=z62lA1gpm+V8am38wdvMouk3JZ/jrXQjEMHDgZj04cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eaLl3rFVVR6sMZ0i6aBU+X+zcRrKtaJuG1tbDVbHbV1mNAL4PTGci5p9uu2ruqK1t
	 mTDNzdo8K0iLf8Mg2x7c6P+mDG8bsDvj/0BcpscqWnDK1NIRqZywTz1oxWTwy9WwdT
	 GBFfxZihJ+EZFTq8x8sqp5BAFUh2fRjM6z53H9s5VwJZ7vpFLylyFDr1ym1YLierTz
	 njvAnutm8evKCT9U2b9ElAZWvFawWqKGOLQXxZy4/SZH3+8SN24mvz8te0wa8+sB/r
	 8n2n8F6JyXaCw8xg5Y6Z+VtoT8lvTTHWYIwRmxF7i7l2cgjhy5vgRl6u3raui5fQmw
	 WKcZ6QMxCxyCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] net: macb: Replace open-coded implementation with napi_schedule()
Date: Wed, 16 Sep 2026 21:13:18 -0400
Message-ID: <20260917011322.3531179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091646-swoop-cubical-81ce@gregkh>
References: <2026091646-swoop-cubical-81ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit dc3bd465ea36af7fd6f9197c05353effc616145c ]

The driver currently duplicates the logic of napi_schedule() primarily
to include additional debug information. However, these debug details
are not essential for a specific driver and can be effectively obtained
through existing tracepoints in the networking core, such as
/sys/kernel/tracing/events/napi/napi_poll. Therefore, this patch
replaces the open-coded implementation with napi_schedule() to
simplify the driver's code.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Link: https://patch.msgid.link/20260402-macb-irq-v2-1-942d98ab1154@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 513a1267a6ef7..6099084143746 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1964,10 +1964,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
-			if (napi_schedule_prep(&queue->napi_rx)) {
-				netdev_vdbg(bp->dev, "scheduling RX softirq\n");
-				__napi_schedule(&queue->napi_rx);
-			}
+			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -1982,10 +1979,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				wmb(); // ensure softirq can see update
 			}
 
-			if (napi_schedule_prep(&queue->napi_tx)) {
-				netdev_vdbg(bp->dev, "scheduling TX softirq\n");
-				__napi_schedule(&queue->napi_tx);
-			}
+			napi_schedule(&queue->napi_tx);
 		}
 
 		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
-- 
2.53.0


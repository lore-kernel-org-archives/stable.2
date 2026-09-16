Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1A4F7999
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602822; cv=none; b=LWMknpG5CoWqkYa0hvXuc3StxzzftXYM3ooCZ7uO2nsZv4MxeQ2bwzTu9hYOxbK9GA1ftvUXofVEpnnopa+n2nXz11NsTZH4ocCZJAvWJUrMSo3DpUN6oMAexpzRy+ygvvYKwB4YrC/DYz6Dx08mmLPChFHmVmmF538q+lwTbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602822; c=relaxed/simple;
	bh=bA4O6jmlWVBrVzPYqqCHL81zSBBlCRgcWquW2B7bs2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4zOFqnvoAPlcbLCGr1Gb2P0Hixgva+pt7fe9zPY964VutCPcwg9i+g07Jb0tIrdMh54+/3/xNfBj6IdFqlQfsQs2pe3npkjZocCJqU3pIN0MxbPRO2fMP0HwLzkQhh5WS3ZVPG9ePQ9tbVdPQK6I4MkcQ3Use4hqYQWOnfS5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH+VhEn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH+VhEn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9231F000FF;
	Wed, 16 Sep 2026 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602820;
	bh=4VbqiXy2+H/v3PqtRHY6c31zJlFvMXdRBrlxTwjRNqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nH+VhEn5kbwCDi2WlWyDgm4zTyDcF/rWUsrM7JNNEG0Xq5me7GpdWcemaB6u5IMBu
	 RssRdKr77CQogFAZxBMhuQ6UI27QOOSlH8++1SGMWSfbVvI32/diEyiBV4gcm9mJDc
	 l91+6NTplqg9YTnk6zzGYdvH54i5NnPGcJyZwZYyAPisAg2dMU8+roDNItMWX1dS9t
	 ya5g2iDIi+oJLCXQr4QuTTyg2hnYM/etC8J/gSoj9/lEomoxSwcpr3r4O3MDaMw4la
	 2M+q1HIHcWX+kjdS5IYucdlstBmGJJpt6vcOJkcWqV2FSOXEFHHMsY1/6fEO1hU3kz
	 hmxw0OnATntkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] net: macb: Replace open-coded implementation with napi_schedule()
Date: Wed, 16 Sep 2026 19:53:35 -0400
Message-ID: <20260916235338.3313589-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091642-wasting-vagueness-0a57@gregkh>
References: <2026091642-wasting-vagueness-0a57@gregkh>
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
index a6540ef210448..71db2927b79ea 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2008,10 +2008,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
-			if (napi_schedule_prep(&queue->napi_rx)) {
-				netdev_vdbg(bp->dev, "scheduling RX softirq\n");
-				__napi_schedule(&queue->napi_rx);
-			}
+			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -2026,10 +2023,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AE314A9E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604760; cv=none; b=i7LN+JhyKmxR8RCnSMo2AaQ9HidLw+4CEfzWD+8ZqOjJn+IuCTmnHdFKB9oIHEGOOAnSYE6o2s4CpYII/LhsZK9lx2uEX/3RyHQnBTZroHhJ4ikf8spMb2VRvcs+kbD7WhOsPR3DaGkVEZhXT6EK3abFr2Bqm4sVnjvpwdlvjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604760; c=relaxed/simple;
	bh=LQ1ZYHbCZNb175ZWsT/XVwwKqqvWk3jqPhaXhVGmZLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8QPxalMt0oSB9y6MFYqTuBTSCfIsYHxjppH0HXfG/PJpi58HEURlpmxuXybSV+bE+XdWWCLM7J8IT9WNZlzlB70bZwwWvH5GkTMmUn0yw1Ap+jeM94U2aHgxpVzYoewCiKsBdhkjo5RmHx9QImRkYcacPxmd2HTQGjC0ShP5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n18WOkUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n18WOkUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B764B1F00898;
	Thu, 17 Sep 2026 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604759;
	bh=nP8miel7tShigDJ8t1MU4hzGShlEfCpcRA0ZxX96L7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n18WOkUMxpMmKRVc89uWp66Mbt5ppi5aB2wmq1kzKamsqxDhEAKdy5CjA3a74EYcl
	 pgD85doi4jjUD92Mzm2JLA3/MX4WRHLlf88T/tm8iVmi8Km1QQhrfGLpSbi/z5q6WZ
	 jxHH4PxyZgCVjXdLKy89/uF5pEFBIdWiPKifNKs54hJvyMUrvk8LCuJxDQuuAFIJS/
	 B+BnNFs0KzcM93VInzdu/GROPZOP1x0fxmDpLvsrwfXnPny3lKdnzOQSK7qXeh1xzz
	 Q8d8Slc0lk0GADJMIcfurnahpTnRxZH8zJpu0sfUs/fFikrSNAwBPSirgVjS8WPpPP
	 FFMy5biFWxAwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] net: macb: Replace open-coded implementation with napi_schedule()
Date: Wed, 16 Sep 2026 20:25:54 -0400
Message-ID: <20260917002557.3379520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091645-winnings-facsimile-bba7@gregkh>
References: <2026091645-winnings-facsimile-bba7@gregkh>
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
index 399a41a3962f7..249fd168c89d4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2020,10 +2020,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
-			if (napi_schedule_prep(&queue->napi_rx)) {
-				netdev_vdbg(bp->dev, "scheduling RX softirq\n");
-				__napi_schedule(&queue->napi_rx);
-			}
+			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -2038,10 +2035,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61124C06A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604360; cv=none; b=Gnz8NBAXiwG9ypfSupZeNzRLS2QCfW0SG9WbNppQmp2FVoq+3hQ4JCOLqsAcBrvVNxOo9YVmnMgDQAKwA8HgU57RO6D2DZ0fbxCcqnF6w4kWs0788zmA/NaENqGdxIJ0I8v0ZYBLnYJBAacg1GFFc4f9FLGG7jmCBI18rHlLYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604360; c=relaxed/simple;
	bh=MKt37zu3pOn/uQa3gKn94j/nJMeiklancC3s/vMtGYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adfRy0GLCffHK9EFVvUv7/xLFJmsbLUzb+F+ZR9VGyGwi8LRdG4SAa4VZ0Yg5puemcqJd5R0PQQkWb/LgsQxrY4rHol4/9DW1B5tmGxvi3rbVXzTdeJ33liAS+d7EEIezq6RcoeKGWedcmqBnmGkXKeBtuPUYnlaYQpmJPIXHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6jlhIaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6jlhIaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B2C1F00893;
	Thu, 17 Sep 2026 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604359;
	bh=Sf2bTO8bByuBw2kVwm74eH8xur/IZCtrlRKxyQUFwf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6jlhIaRtr0gd6/cB9XoClcqbKqNFjsh+DPVUpAAm6MbxM202kNHXlmrg+Ne/5t6F
	 rGBvwM/eeTzg0b+IMq6XuxcG5idNSdloy7FTHHCms9Gz1cyqH638eYgi/z/d3SFf16
	 fnEwU3Uh5YrX4H6SJnACUBoGrlFG2l6jOfcuxyVgq96Vz/I7JtPL0pG47Ar/s44lWo
	 00qsv3X5gxMRSrWsDlgOmsDexRiZ8qXxH7eb6dE3xVAxRblvWhuEiZEg6QkDTYokTM
	 9Eo41W/TgT4jTXul9LUXZSVOmHC08w0pgP757Pauk/fmZFUy0MfgifI7ifJCmRUb0B
	 1uGeahzd6kj1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] net: macb: Replace open-coded implementation with napi_schedule()
Date: Wed, 16 Sep 2026 20:19:14 -0400
Message-ID: <20260917001917.3360958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091643-urethane-talon-e5b2@gregkh>
References: <2026091643-urethane-talon-e5b2@gregkh>
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
index 67b16aca565ce..3665f5716a11a 100644
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


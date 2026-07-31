Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A719E968
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479665; cv=none; b=SnafXLqFUlLixA/ZC8rF5o5VY73qgb1a4cy4fdJLM6cE58GF75Mf2bNcetemzB1YcTAWg/dvSJEbnuU0UUVAzcxEH1gjJKmo14OAvlJoLlaTQ4PuS2fqWjiWNguBOXlPt3mwUvvrK/n7QIA9gxKvv1ly3I2FgVnyWUulsru4OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479665; c=relaxed/simple;
	bh=OxImi+46iryD/kp/uA/7rTnSSDEgpr+ouftle4OpeF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJN8WamEhADhXWQ2dnlPkkNF39K1iSy7AiVcqxMIX8euPs7wKyQ3YDebbCsE7bnayf9NRxC3dmh9Z0Q19RTK12YKqax1Prho+DqAYQ3AoFQuFDB+GClx2Iceld3EPnYW+/QEiYBeMfPgjjfRlkIn8Elei/z00LrEtrDHW/UWvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KV5fHo5S; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KV5fHo5S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785479651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+NQlPvqc8x6VIxdmDBlVcbYmrkD68QXxW4eEQ79TQI8=;
	b=KV5fHo5SA0jzfjZJL02zFDSJJSBMbwd2C1Zt4aO/ct1VQhYiQxYSlSNaO/XfA/5sXGnGWu
	l9+VMEJB+ksiZpooR0mKq1K+N8x6U2AzRJb3RN3m6M68SZDR1yhfF+tI0fHu/K6T0l1EIV
	yfYYlJ7Jy0/dV0Es5F57QGDTXJaRmd4=
From: xuanqiang.luo@linux.dev
To: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] net: ravb: fix use-after-free in ravb_get_ts_info
Date: Fri, 31 Jul 2026 14:32:54 +0800
Message-ID: <20260731063254.71260-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PHC is registered by ravb_open() and unregistered by ravb_close().
However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
clock. Since the netdev remains registered after ndo_stop, get_ts_info
can still pass the dangling pointer to ptp_clock_index(), resulting in a
use-after-free.

Clear the pointer after unregistering the clock and only query the index
while a clock is registered.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
I don't have access to RAVB hardware to reproduce the issue. To aid
review, see the similar PHC lifetime fix merged as commit 8da13e6d63c1
("net: macb: fix use-after-free access to PTP clock").

 drivers/net/ethernet/renesas/ravb_main.c | 3 ++-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0f..3a9d9f8718216 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		if (priv->ptp.clock)
+			info->phc_index = ptp_clock_index(priv->ptp.clock);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 226c6c0ab945b..fc8c601ed3a5e 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -337,5 +337,8 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	if (priv->ptp.clock) {
+		ptp_clock_unregister(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+	}
 }
-- 
2.43.0

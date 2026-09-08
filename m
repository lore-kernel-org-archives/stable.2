Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895A331EB3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835104; cv=none; b=j2kqkMHDipnFiEDS6t/NLYXXvT0JSORw1HnY7x/eVb0uh7zTxYqYhB7JD5CdbPhd05TPzNLeIo4VxlcwmSE3z/D8vRECXj/281aLAKEpxjYV/COLJOghALx7EFgTV3qgnvAhwmgDpM3+f9Lq/1pg52iS6tI3QzSSpF48TWDNTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835104; c=relaxed/simple;
	bh=YFk8ijcB8bITxXkCpEHcDU++XgwznV4djJXfOVSeN0M=;
	h=Date:Mime-Version:To:From:In-Reply-To:Cc:Message-Id:Content-Type:
	 References:Subject; b=Ee82HeYHk/hUO2OhvsZNpQM7NxPrD96g3P8q1aiJi5XtX8oyvB7dj9mlFsju8ZzeBzY3cThBCzbrEIPIE29MAlWey/xzF9JumRdb5AqmBOn7m+pPTyD5GJCn5hvfl5RW/JJsPIP8l3uxmt3bBoFNY+jZwrOdKptr6MTcR/qbzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=1qrk53/C; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="1qrk53/C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788835098; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JuHLfjAtbzVg6yDfxoJ2zvQ9bI5H2+ld+xQJ8ev3rsQ=;
 b=1qrk53/CQWNZ5ImCp9nbQMc3IPrEfCF7hBKPEexPhyP4wy3wKB6oK7442ao+fF/+7Jm6J9
 qN2+bdrArwxpFFDhUxl1W27JViYvkjroSwXdpxUYUy7GP3FQ0e+AA+D5htCZ1WYLvmsOH5
 4mlMq3qx+41acFvPGNaxlodrNYVS8m3HgUwTApaY/OO1kQjPDSiiLL4qMbArY6eZaOk0tW
 LKdz0qI/XQvSI1yu/8rqsnNvZicTJeKHaPucesx0d7Ptppho/3WGrMf1wXq0BGF5KyE8Gd
 gl+4zvoGpEd3ug0ZLUW/W50oeGmRhUxVJpjftehUt2+yMCHOh3XkEAQN8csRVw==
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Sep 2026 10:37:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.30]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 10:38:03 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>
From: "Shengzhuo Wei" <me@cherr.cc>
X-Mailer: b4 0.16.0
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260908-fec-ptp-pps-event-uaf-v2-1-2a1d57121ade@cherr.cc>
Content-Type: text/plain; charset=UTF-8
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
Subject: [PATCH net v2 1/2] net: fec: stop the PTP clock after the netdev is unregistered
X-Lms-Return-Path: <lba+26a9f750d+d9033c+vger.kernel.org+me@cherr.cc>

fec_drv_remove() unregisters the PTP clock before unregistering the
netdev. A concurrent ethtool -T can therefore pass a freed PTP clock
to ptp_clock_index() through fec_enet_get_ts_info().

Move fec_ptp_stop() after unregister_netdev(), which drains the
ethtool callbacks before the PTP clock is torn down.

Leave the probe error path unchanged, since the netdev has not been
registered there.

Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
Cc: stable@vger.kernel.org
Suggested-by: Wei Fang <wei.fang@nxp.com>
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..a29c8ddbbf34 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5500,9 +5500,9 @@ fec_drv_remove(struct platform_device *pdev)
 			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
+	unregister_netdev(ndev);
 	if (fep->bufdesc_ex)
 		fec_ptp_stop(pdev);
-	unregister_netdev(ndev);
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);

-- 
2.47.3

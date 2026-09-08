Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2E584960
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885245; cv=none; b=B2JFETpb3U4dsZ5dgf2ha6cbXMyMKvLnM8mai7uvhJsVt5NsB3RqbRRl+gGkqAV0jhWbBFlXukP4u3bXfy/nCucqKvJRdPjgkKnmgmhwNl8IYegYb512hd+vkelH/OXN76VLF/NSTLz1vMp0YDwTvUQlnkzWyO9asGYAqNzoDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885245; c=relaxed/simple;
	bh=YFk8ijcB8bITxXkCpEHcDU++XgwznV4djJXfOVSeN0M=;
	h=Subject:Message-Id:References:Mime-Version:Content-Type:To:From:
	 Date:In-Reply-To:Cc; b=qwjtHP7lXh2q3s1AvfOgCZRSnYcBrlqvmHZRYikNdPg58kZ1qETPPlq+Xszoy4PHwLuAp8Zq3t3u9al5kD1xi47CF2C9jVvi20ttY/xC3GcnSQniIZw181cUUGyT+lmOGgb/fxxWc1qgeie6tHPOztrBrFV8BHu1b+Qe2LpEbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Pe1EsDES; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Pe1EsDES"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788885232; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JuHLfjAtbzVg6yDfxoJ2zvQ9bI5H2+ld+xQJ8ev3rsQ=;
 b=Pe1EsDESVpoGmfwsSVlnnkj9eknZ4zgJW86MSu+r8dXoSAgsePP8uZrvdn0NzL6SkjJMot
 a49Q4gH1ghlKpqpcnI2VXvZ8vogw71Q+43MSWZ1Xf7R4kRREs+RTJiYaIFiwcFrxIJjk7C
 viBz6MOvVDMJ7dFhncvYknaaMYWEm/YfRdVodow/ukbiWnN0vmJe0suuKJjmYSboc/bXuC
 VZKWYWOBFFjo0y688KKjqjuhw0ZFkKi8Ne8JymgBsTu82DEk8kf4QlycKnedxBwqzF6Kwc
 3ylIU7/lcX3plHUGcBnPI3cLwrHoEEqdKn5rjr5JkNzEOVeH7qvHdUJIBKeU/w==
X-Lms-Return-Path: <lba+26aa038ee+db1a28+vger.kernel.org+me@cherr.cc>
Subject: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev is unregistered
Message-Id: <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
Content-Transfer-Encoding: 7bit
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.75]) by smtp.feishu.cn with ESMTPS; Wed, 09 Sep 2026 00:33:49 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.16.0
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
Date: Wed, 09 Sep 2026 00:33:44 +0800
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>

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

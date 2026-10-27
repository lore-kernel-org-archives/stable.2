Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084070;
	b=UK/LW8XS5UWvah7D/FynYrerh3QOtctvsIw4q1ITGeg2TC+Uj3CKh8hLTQsz6DA2PcrS
	 zbMvHM9UWo3aFUWtPzLuktJr6E7KsnMKlGaARRFTzDZDkMWcMvN9vLX6m7egdmKVrZLvJ
	 Xh3m627H1yZV3bR9/2wkUSBPbOF4xmysdUAOhm+pyO8XL9sRuzz2GneeNRM6bJbNeT8q6
	 gBUW/oT5hw/vNH7k+/pQPhbs51AT7HeLnU5nI9HAb1G0cQWC3lOq9umgc+n7ok8Tax/j3
	 fiTXqGi4fos9LWELPw2vKEV2mBJu3VQvmB0UiJnaLnt/vrVOzPVIG0BG+fVy4q/opQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084070;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m+puS7JhUR3N+2LDCaTjwfHdf5tGVjr3uKk3ostEBEw=;
	b=vtYvlRr4KYqbYYjCjzTVqIwXrppzwJ1aJ0oyLo+BiMNS535dqWJLwscq24kLj0Iv0J/1
	 outE55bRaWB6aBrVWNkAlpJHAQm7UJiVWhAEKTK35OHXPJswx0X6zPSZw3c97r4h84/ia
	 OzAtZmiY5lv1ZYoxNmS8+RTjMFBzSAobbb3ky40JlIl7O/YsVFe8KIDEgoufCxjvv5QRn
	 Q1oTVmcY5bkZJ4ilcWaWiu4cpjl1brO8Q/muviE8WC6rU/XjkyVi2B29QijKurTWhje/U
	 PLfnycWR2HkPLMgHkgXM95pJK2pPQtOXLfKdjK9MVQ61KLSE7UYmm1xqH5WAKn5i4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=D+jzEKdC;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766D606A32D;
	Tue, 27 Oct 2026 06:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4766D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=D+jzEKdC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793084060; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m+puS7JhUR3N+2LDCaTjwfHdf5tGVjr3uKk3ostEBEw=;
	b=D+jzEKdCPo+6iZ8G1bh47Dxg4zfuBKsvigmpybV2fuOwCjmALG64jX9a66sSWvPkLWI0SmoWx4vF7epdYkeKCYVNyst7QMFQTBcQFdO1lJeebAoIRiXYIXeAaf1jaquMTEc5eCWyHtWgzlUcpXwWxNPduAvUsQpBLIY2t5AYlFj82ezKGSkj/v/fx6t0SdGcfb7EyxRpeNW68g4chFaXrDC+BjmzFEJV6N2n1yIOnQYOif264WnObVjJCNDOg/5f1qg9Ix26mgLnuEeLwngNoILsQcfs1GwU5/P174FM+NxZghvfib4QrkWDPyBT8WSnn96qpBVfLS7HPCwHgh2wZw==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436264|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00725632-0.00128444-0.991459;FP=9833308562132599439|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jqWjvoz_1793084059;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jqWjvoz_1793084059 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 14:54:19 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	kernel@pengutronix.de,
	haibo.chen@oss.nxp.com,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH v8 2/2] can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down
Date: Tue, 27 Oct 2026 14:50:12 +0800
Message-ID: <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The automatic TDCV readback calls into the driver via do_get_auto_tdcv().
Some drivers, such as xcan_get_auto_tdcv(), read controller registers
without taking a runtime PM reference, so calling this while the
interface is down can touch registers whose clocks are gated.

Gate do_get_auto_tdcv() on netif_running() in can_tdc_fill_info() and
adjust can_tdc_get_size() and can_data_bittiming_get_size() so that only
the automatic TDCV size is skipped when the interface is down. The other
TDC parameters are still reported, as they are meaningful while the
interface is down.

This is a defensive hardening based on code inspection; the automatic
TDCV path has not been triggered on hardware.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v8:
 - Split out of the berr-counter patch so that the stable backport only
   carries the hardware-tested change.
---
 drivers/net/can/dev/netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index b958c04d53db..613beee9e936 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -720,8 +720,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
-			       u32 tdc_flags)
+static size_t can_tdc_get_size(const struct net_device *dev,
+				 struct data_bittiming_params *dbt_params,
+			     u32 tdc_flags)
 {
 	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
 	size_t size;
@@ -742,7 +743,8 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	}
 
 	if (tdc_flags) {
-		if (tdc_manual || dbt_params->do_get_auto_tdcv)
+		if (tdc_manual ||
+		    (dbt_params->do_get_auto_tdcv && netif_running(dev)))
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
 		if (dbt_params->tdc_const->tdcf_max)
@@ -752,7 +754,8 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	return size;
 }
 
-static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
+static size_t can_data_bittiming_get_size(const struct net_device *dev,
+					  struct data_bittiming_params *dbt_params,
 					  u32 tdc_flags)
 {
 	size_t size = 0;
@@ -764,7 +767,7 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
 	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_{,XL}_DATA_BITRATE_CONST */
 		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
 				       dbt_params->data_bitrate_const_cnt);
-	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
+	size += can_tdc_get_size(dev, dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
 
 	return size;
 }
@@ -825,10 +828,10 @@ static size_t can_get_size(const struct net_device *dev)
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
-	size += can_data_bittiming_get_size(&priv->fd,
+	size += can_data_bittiming_get_size(dev, &priv->fd,
 					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 
-	size += can_data_bittiming_get_size(&priv->xl,
+	size += can_data_bittiming_get_size(dev, &priv->xl,
 					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
 	size += can_pwm_get_size(priv->xl.pwm_const,		/* IFLA_CAN_XL_PWM */
 				 priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
@@ -910,7 +913,7 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (dbt_params->do_get_auto_tdcv) {
+		} else if (dbt_params->do_get_auto_tdcv && netif_running(dev)) {
 			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
-- 
2.47.3


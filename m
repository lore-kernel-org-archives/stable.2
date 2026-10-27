Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084071;
	b=HnYrwoI8+kr7Mads5W78gDJiexJcCR/LPOUvQJY9MkqaB+edS0a/1z9LImtDIbYcBiO8
	 79Bm0R4qZ76WPnHxL+aLzJYTLARN5km2xprviZkzmHhDtDSRcQs4MCo7eqiVdtTJge/P0
	 wuFMYuGckv4WstkwBs/zTJ94uhy0nEDl4i0KMyOaZMszKhPvgHPlY46Agg8B97DgWt8Bs
	 yjbo6PbzmxI6FR+Gfq4uwawFsm+ghh3Rz50WWWXY5PGcYGp9edjwqKkwi1Akh2EPUJjxD
	 Q+T/tGiJfJQcjAb3VEdjhgLMHYfMnoM+Qb9icuDoCWN4/+WTt/xi0hZaiHkJ41WkNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084071;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YrOHwr2cBOrKGm18bmWaUo32ETpL71CCu8ZjYKcsUSw=;
	b=Y9yw0re5OrqnEbG/MO9fG6AEf04VRkrLr7dEfsrno/kbuUwyiT4AmxNVl/PDe1MP7ubR
	 3C2xoRFnefcPIvaEMf343p+4bOjHhB/NpVJ2Lei2hemzRCay+z1Yuy6wK864g2VBVhwuA
	 dTpJACg5QY1BfzPWPSl5DmhE/lJzQmDg1RtakfoRxYavEEXNDGvAFw6uxyBaxNDssaBvb
	 1mVH6kwU5LByXXomH6b3x5RRGYk+jxl9gQ4P7jo53NtD/KH7zXyKX87VyzfklX/4oktdf
	 OXqQJHeNxlgVnwa3GEBeaa54VLLYs+v0CQmYk108UMugDh7PEjzd4G/h27y2tbtp0Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Wk5P6q9e;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D0606A32A;
	Tue, 27 Oct 2026 06:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Wk5P6q9e
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793084059; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YrOHwr2cBOrKGm18bmWaUo32ETpL71CCu8ZjYKcsUSw=;
	b=Wk5P6q9eUxyIVuAI8yo2sGK/lTGTo9l4726PmFzJS7QtquNw/58guZNZ35B9x1fJfi8aU3Z8vDows9+2kxYpnjzpVG6qQS6bcANBF9MlwD+fZwkg/qhnl3PKFIKiJbXyxtNpiFKB1F8Zt56DhPDvvm+g8Cuee4x7MW/1BQx4hcLrG5H0AMrfCqLQnm00G6Icy3BSsNefm+XKgaxbesfd7IKz4VYQ+rDImEi+EQjU8AsIFkB/66dDa5IG+wwYVx/oXDXTi/yUnisBsbmc0xAFvZAq47NsOieXqLohhpInkIFPU/VJx0S8/uKnnLyugCqlHsmTjtbpwZYz0qZh+DcmsA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07478032|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0924047-0.00429912-0.903296;FP=13982794750684426156|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jqWjvoC_1793084058;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jqWjvoC_1793084058 cluster:ay29)
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
Subject: [PATCH v8 1/2] can: dev: can_fill_info(): don't wake up controller if interface is down
Date: Tue, 27 Oct 2026 14:50:11 +0800
Message-ID: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
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

If the interface is down, the CAN controller might be powered down and
its clocks gated. Don't call do_get_berr_counter() to read the bus error
counters if the interface is down, and adjust can_get_size() to match.

This removes one trigger for a synchronous external abort seen on
i.MX8QXP when "ip link show" is run on a flexcan interface that was
never brought up. The underlying cause is platform-specific: on i.MX8QXP
the CAN clocks are gated through the SCU LPCG and the subsystem shares
the IMX_SC_R_CAN_0 power domain, and there is a window after
pm_runtime_resume_and_get() returns where the clock has not reached the
module yet. This patch avoids the netlink query path while the interface
is down, but does not root-cause the LPCG window itself.

As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
interfaces. Userspace must treat the attribute as optional.

The issue was triggered on an i.MX8QXP board by running "ip link show"
without ever bringing the interface up:

    Internal error: synchronous external abort: 0000000096000210

    pc : flexcan_read_le+0x0/0x18
    lr : flexcan_get_berr_counter+0x4c/0x8c
    Call trace:
     flexcan_read_le+0x0/0x18
     flexcan_get_berr_counter+0x4c/0x8c
     can_fill_info+0x1f8/0x434
     rtnl_fill_ifinfo+0x8fc/0xbb4
     rtnl_dump_ifinfo+0x364/0x448

This is the same class of problem fixed for m_can in
commit 91a55c72a821 ("can: m_can: m_can_get_berr_counter(): don't
wake up controller if interface is down").

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v8:
 - Split the TDCV gating into a separate net-next-only patch.
 - Drop the "generic logic problem that exists on all platforms"
   wording. This patch removes one trigger, it is not a root-cause fix
   for the i.MX8QXP LPCG clock window.
 - The Fixes: tag points to ec56acfef2af1 because this patch supersedes
   the down-interface readback behavior it introduced, not because that
   commit was buggy.
---
 drivers/net/can/dev/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..b958c04d53db 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -812,7 +812,7 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
-	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+	if (priv->do_get_berr_counter && netif_running(dev))	/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
@@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 
-	    (priv->do_get_berr_counter &&
+	    (priv->do_get_berr_counter && netif_running(dev) &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-- 
2.47.3


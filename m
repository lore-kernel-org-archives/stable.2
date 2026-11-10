Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274071;
	b=NQBGcYg9G5cQu5nvd195pW0GBOgHsaZ+D3+4JunNdg17DLZiZID4CU4Q1SdMQMAaPkbV
	 B9MAEW+fMxaGf39DMhPnLW0CgapKHOeS/fTj5BP/zMw/VZRLL3/+jNelJnfgbe2I8Dncg
	 xt/1JZTuEJrG+DQphtNyCRL0ZaAj7DAyDVtBJKYTis1kqx8ailu5b1l7KcMMCNvucpzCX
	 kTDvDjEhtGgdS9N7+ecUcBMmWpbN5cHrxVVmW78WK0DZHA0lNFxhny58aLKGkugnIQwjI
	 o37FgxcYHkfuCr6XnzLwnXUi5kZZHsGrIl1R/s1hz7eM3/wBSkku3olHBW6U/Hqxuew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3t2KbI6sdXI8aX+8k2s9/zRfRiBzhlILYhlti6uP4I8=;
	b=1FLuiOC7Glm7hGv2J4HSwhqTvP0Vv5TNnw3phl8hhonDgFS/o1jLUwDPZfPcSmdnjYi5
	 DP8r4qhUCyWp4e6SWtXvddRmRvq4TdyJMR8uviDlcvMBLKEpUoIK3WgsXVtqFIvB/1z9+
	 yGPVrr0fvr5rGWnuu1937D7kOw2tSv1Q94GbfjiMJH1ttPDgghFaK+SXDW8CIw/73ZsLN
	 /DMzfqxz70g9gk04MthgH1vSBybfXAxZNGSbxX/YsZon8h6dYQSDS02uDJ2Q7E1J3hTXM
	 ZtXovQuWPTSyhQ/27KWOzpa+9yapRt1PzmFtN8VAGt1jFFsGMe44lPx7kYSx5OPgWtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlXfGTiU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlXfGTiU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D2C1F0089F;
	Tue, 10 Nov 2026 01:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274070;
	bh=3t2KbI6sdXI8aX+8k2s9/zRfRiBzhlILYhlti6uP4I8=;
	h=From:To:Cc:Subject:Date;
	b=UlXfGTiUurZyyL1i7I8hQRpV2WJmntqnphkxjDLnhZNKdWLQAlqGUNm0bBmEIw+vL
	 PQVD6pJ5kXO7AJgf06TjqGVg7lc5NM0w/OUfHuXPPrhv9hj0Br6bdT+H3/VSOvgGzD
	 gdky2nGwxl29ufA9ghSJk0HMbFF/XbP7NipulCokVzcIOxIrMYZDY1Lfq80UsrJc3+
	 O34Yf1dVUzAczAbFjfI0UkRDMVPBvgGMQrGDu5u3V5GEh70YqMK9+2xXmqAswDGwCs
	 WyUQOTfGl2Qukau+IE85YH/LFRVimQO7dN1DH/qzmWoTvWc+UrWrNd0vZBaNjTNHIP
	 jPw944hjy3jsQ==
From: Sasha Levin <sashal@kernel.org>
To: chunyuzhiqiang@yinhe.ht,
	mailhol@kernel.org,
	mkl@pengutronix.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] can: dev: can_fill_info(): don't wake up controller if interface is down" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:48 -0500
Message-ID: <20261109202748-failed-5.10-75332c410c81@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 75332c410c8190d61499001c5516af977ca426c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202748-failed-5.10-75332c410c81@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 75332c410c8190d61499001c5516af977ca426c3 Mon Sep 17 00:00:00 2001
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Date: Tue, 27 Oct 2026 14:50:11 +0800
Subject: [PATCH] can: dev: can_fill_info(): don't wake up controller if
 interface is down

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
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20261027065012.191348-1-chunyuzhiqiang@yinhe.ht
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f55..b958c04d53db6 100644
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
2.53.0





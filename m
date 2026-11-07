Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046322;
	b=W1AeeZZI59s098jwm0uay/1KCx5hbrsBpQMZOOSuLzR2lYwqah0AE9TMwbNWuWmamtWV
	 YM6CfwGGSV5arlFv+TYikmChBn3hMjaG3CbNuhnsMiWJPGAsXXXyxjkfgfaMpOxzV17hM
	 ZuHm2lJY3V0hANENNUnq9wVAfTT0GAyPLWRNbGemE/z1wKcRZM7GqzAP38Gp/5piD2FL8
	 oWdVqAQWg0tgnUEAgTKCrguStLgab3tixhecjk5Z/YnWYrLTx7i6gfTMT+fJ1mi7FNcSH
	 5yizGkBtMIvdykFDJOPrk0BnOF6hy6qrXKXMrIq62h/753Ai79kI4J5KhZUydwxDKcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3wxc9ZmiLh69lk+3qFpazaiXknnUxY2PpUY8hKRsM5A=;
	b=TPsgQUypMh+oZz5kbUNSDyPiPCnOb+/NvJUZP10is4fe1yU0l3LyfTTivecBMQQHxu+b
	 /sGlRTxjKdwyMGhVoSLWz39mRcAKnG6LsQ/7s31cU84XqqZbSO/UxyQYwZpmF3MbZK5i1
	 7zPaAFEX14sSp0sQbvMwF9o/kcm6Ek5pSgjtyziG+3f+XnyIfHf2AllGxxOjV7xuDhl1e
	 l22N/v9WKzXFkfcKpq/5bPI/L35zijLKMK7OxQp8G9oJYZobyft8dKIOHD18wmoWa7WOt
	 RB4M/QGHEmSbBt/OGx/IvuFjViqZQbZq6HOjA3HhQizKdv6BYBR4LbQ8ainw2fKVRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lm0+BRUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94681606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lm0+BRUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E911F0089F;
	Sat,  7 Nov 2026 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046322;
	bh=3wxc9ZmiLh69lk+3qFpazaiXknnUxY2PpUY8hKRsM5A=;
	h=From:To:Cc:Subject:Date;
	b=lm0+BRUWFjTWpNyEj/amJll4BNgI5g5c8QYwurJ7VA9l0ASghFgU78eQwT4fX4Ouo
	 zSi+qHU9hRh9dG0jQyHyBdGQWSOFy3JFz3YUZYFzx+S0OQP0P6OuH5DuGjziQ6RTNS
	 44QntvzvYh6i1o5g2L3HBBw+jRy8qH6sPRyxpTDr/2V8GOre4pzqWhiAh0ehN1sQbg
	 wQ+CazXPBM1CdZg7TBhoFYH0CP99czKomKScAbSOK6G59WCaFmz7p8g8XVBzPKuZFx
	 mce8R3SmKYLl4Eq9LRSs7WGexC/iVC/VPz8UvVmYlgfLcYi6H4Hx6UxAvqkm2nBUAq
	 li4KYnbNMOgAg==
From: Sasha Levin <sashal@kernel.org>
To: yun.zhou@windriver.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:00 -0500
Message-ID: <20261107051200-failed-6.18-2d36ec73836e@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2d36ec73836e83175deb467fd494c61006107e5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051200-failed-6.18-2d36ec73836e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2d36ec73836e83175deb467fd494c61006107e5d Mon Sep 17 00:00:00 2001
From: Yun Zhou <yun.zhou@windriver.com>
Date: Thu, 8 Oct 2026 17:38:24 +0800
Subject: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock

The ERSPAN xmit path re-enters the network stack, causing nested
acquisition of _xmit_lock on the underlay device while already holding
the ERSPAN device's _xmit_lock, creating an ABBA deadlock. This happens
for both IPv4 ERSPAN (erspan_xmit() -> ip_tunnel_xmit()) and IPv6 ERSPAN
(ip6erspan_tunnel_xmit() -> ip6_tnl_xmit()):

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

  sch_direct_xmit [lock erspan] -> ip6erspan_tunnel_xmit -> ip6_tnl_xmit ->
  ip6_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as the ERSPAN xmit path has no shared mutable state: o_seqno
is atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
o_flags is no longer modified in the xmit path since commit 9958e69b9893
("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
GRETAP, the sibling device with identical xmit structure, already sets
lltx.

Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org # 9958e69b9893 ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261008093824.119453-1-yun.zhou@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/ip_gre.c  | 1 +
 net/ipv6/ip6_gre.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e4878e9aa6367..149a4e83b6925 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1367,6 +1367,7 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 04f7c70b7320e..3429543ec77e7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1864,6 +1864,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 		dev->mtu -= 8;
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
-- 
2.53.0





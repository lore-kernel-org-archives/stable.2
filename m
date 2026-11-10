Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303123;
	b=UPP6zzdeyo77WMAe0zXyhoDdLWBAe3pjA+OCd7+mBBhGzajEBZ6k/+AUz+kdz8c8GSnm
	 r+5j+Y5n3uclJ89ZcRuQk8Zd4OrQID7n+5xoF3emwTxkPmPDjmZRkq2aq8TIOIoIyJ7KQ
	 LlifHZrWx40Mz2kvT0bQEAzrMGRwd1LwfwKZivnilBV+XAMxW+orsa7IFnf8OufXymwey
	 ftBXP01PR9xILUWSeTXvSaiENMICN7PFDwjHA0cou08uijP7aWzjqrByuuN3J3wkjfzqW
	 ZoVz/k/v3r8m7aEFWUozMjEiW/Sq5RqiAsMz6jW1XO0E+K38aY8ML3/Du4zmAKjyvCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303123;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=oJI6oss0xH3OstOWRD7XS5gf1pugk84YsufQhXrpkNQ=;
	b=ln5CaF0d7HZ/RoGn2D6csf0XCbKzIv4fUWyjrlNw4Pf8vJB+p/iMG1ETKddWPCPAWqVk
	 1yQRXMkvWPLl8+MxIt0dYMHJbyT8EghQOfD24X+CN4wZjhj3CthAMzKf9hj8TYL+EW6oB
	 N1kin78vzBz9G6ESvzAIUSHU35UB+Zq0jX1rTDlvk8ue0gKwF0LaVCUyYctiDD1F1AU+D
	 vr6LzbaIMIFk8tvIZZPnV+e5O+pz/g9fXm+cyHdVcpV0RL2YZzJq6VW4HqB8yCaz1MM/D
	 qYHkOuJ0ydKFqziRa4EmfkyLKoBpyLTY/shQF+t9IR+Wa+18Kel3F/z4LLSsQ+tpDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b="XOgws/bB";
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46B606CF8B;
	Tue, 10 Nov 2026 09:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B46B606CF8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=XOgws/bB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794303112;
	bh=uenKw59VxCtFuBnetHvedvizKcgHBESDC9ZUrZ0EMJU=;
	h=From:To:Cc:Subject:Date:From;
	b=XOgws/bBYaw/z4yO4YwbKXHVziva2wjSQCx++YpL8PH0uPJCfrEtGJeY4hUg6vAx9
	 x1xNCR4FP8D7JFOF4TH1MG6EIbs7MDiBGwQld2lBVZGIMTnkagS1d35lnLCq3jgGpW
	 X0gabB/swIaoSuOTxEPMa5jB3Bh8dk0LyhD3AS+q3iCGXvpgLH/IVWcpCeZl21ybEQ
	 k88PMjiSq2g+gnC3Uhd5hkwFlkCjtqm48fPMTRW0M11qCga7vuYRlvCuBedwdnQT0m
	 1ETFPdEHj8BGOpsEwB4+VZATRV4QvWCk6/m5pyvoHGFheDSBlMsSAc0XeSGXWVV4+y
	 zAlCIwvjuCq3A==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id E8ECD1FA63;
	Tue, 10 Nov 2026 12:31:52 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue, 10 Nov 2026 12:31:50 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.16.187])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jP1d2284sz2DS;
	Tue, 10 Nov 2026 12:31:50 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] ip6_gre: remove obsolete ERSPAN PMTU update
Date: Tue, 10 Nov 2026 12:30:26 +0300
Message-ID: <20261110093028.1346-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/10 08:55:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207361 [Nov 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/10 08:49:00 #28832117
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/10 08:56:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Daehyeon Ko <4ncienth@gmail.com>

commit 8bc60db48e8cba35488bbd6e1f94aa990afa275a upstream.

A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
and mirred can redirect it to a native ip6erspan device. The legacy PMTU
update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
Since it has no output device, dst_dev(dst)->mtu dereferences NULL.

On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
self-created user and network namespaces to trigger:

  KASAN: null-ptr-deref
  RIP: ip6erspan_tunnel_xmit+0x10fc/0x2cc0
  Kernel panic - not syncing: Fatal exception in interrupt

The update is obsolete. Commit fe1a4ca0a2b7 ("ip6_gre: process toobig
in a better way") changed IPv6 GRE Too Big handling to update the
underlay route and removed the equivalent block from __gre6_xmit().
ip6_tnl_xmit() then propagates the underlay PMTU to the overlay route.

Remove the stale ERSPAN copy and its now-unused dst variable. This
eliminates the metadata-dst dereference and keeps ERSPAN aligned with
IPv6 GRE PMTU handling.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261002033058.358137-1-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[mdmitrichenko: Remove the older PMTU block using dst->dev->mtu
 directly, along with its now-unused dst variable.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-99041

 net/ipv6/ip6_gre.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 0c7211540402..296900b0c65d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -917,7 +917,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	struct net_device_stats *stats;
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1050,10 +1049,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* Push GRE header. */
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
-
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
-- 
2.43.0


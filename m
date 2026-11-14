Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660974;
	b=V7j4nhUMtVQJZjhcFAcuK9/9Gujmm9J70QAvuBkZTS2oZFPpKWdTOPAjNOpLoloonXZu
	 McBmtWBLNiNe+REd3dUoBL5wZkH7WppRCrw3Qn7+5tPbKX09EQ5KgkH+4i3lopxYUgbIV
	 DKFv1LJHjBKpw4YfoB0nkpzRXJ8QI0zxz5mje6/zISqLNtirwtXhprdcRLZPKMKecDMva
	 8XkCZJ6lHK51+vQlySkwZbEKQ8hWj1DP4crRTohNhPcfr9xh18towNHxLB2tuwVvDl2n6
	 eDGM/O+XRRY9Gug2Ykiu0mYMstWDmPDyUqLBxvfCrA6/3JF5R0gzXVeb/zt2Ji59HqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qwj16+X92OdYAGNxs/Vl6la6Mew3rTAyjN2yfxuPiQg=;
	b=Dq7IBFnJJp7jPMa0LSCIKV+T+2avl14rj/W51icFsRbBqAhN0jQo/wdS2hijcDakfjbD
	 8C+k7irokpmXzbqZ4TBA5B+UKCUoIMazG/Rx5agH8mEslJi+/GZc5oK2k2iePPBHP2urq
	 kA/i/+VMM2dnosp/mK9wi+pgkGCberAAJqTYl/41/N+Atal/vgy+VOl4oqfqK0ukaALh4
	 okhU/SEHLwZglizRsRSu0rNIw6KsyIl8TeZE12ObuhqagOOkokoelBAFc896amHrOPB+2
	 cR2NUk5kjVcgRzjX/T1yfi6enSO65/yqEgl3l7BOkARXloDpZazcmaAYBLXEZC8XluQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=NICbofQR;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAE606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CBAE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=NICbofQR
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2280545a91.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794660974; x=1795265774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qwj16+X92OdYAGNxs/Vl6la6Mew3rTAyjN2yfxuPiQg=;
        b=NICbofQRsUoCCo0rtelZz8jSPL5MoUVsfXwtBkORVxRXVaNBLXDkdU/fKNqtO5PzU4
         KPlMLe+WRz6W3taJeYFH8NUIKOxcrlJdzyxd7SNbBacuxGci52/ERqLnkpd9tBSbcqP+
         dqIccPke+VaM2vOKGM5C14YDI+613R8DdS+rgv56ZsKn8kuDE3+PRusP0Wk/yR8UOAw6
         aothGZYHAhaljJov2ywLuIXZA2EJjSZzRcvHr5D8AKFUM8tZjTmYqWmHJ9bHYMq2zhs7
         iHHdTfSmoLVzPGXDLjyP4xj+R9DVAJzc/7QfzJyuhdttCNobUEfEuH/Kv2IHDEwWMCqP
         JINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660974; x=1795265774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qwj16+X92OdYAGNxs/Vl6la6Mew3rTAyjN2yfxuPiQg=;
        b=rwx1vPeA4/Ldh1Z3qN+Tzl10hHo8NsgcOjHZdYB15x7X5H1c7+kqoADoX9QI4mf/hw
         6OmuHLzP5l1ILBjAEHdScmQYGpERfRMQq6JxEr4oSD3jpVAfEnIVLsh9ZfVVpaKaVeO4
         9L7DrxKRLNnHGv2cRnHihD8blBg1NsDQ3B3oFO3bwabPLqU7VBWuPUJ+iDieQDrhDex4
         6XphA8SiquYqKglFzfp+TpEnD+SopfyqM9yWCNU82dXYxRBUcWiJol4swdNL8pF2feTA
         LiCSe9WAqXuEwcHTs15aYjHjjJnC3hFbbyta66l3tqNG4MNEQxgsyiXsHsppk8rYNF1H
         8vzg==
X-Forwarded-Encrypted: i=1; AL+hErEwHPfBnLqfa2e88UfyB3+7XpbpLkdUP6ziBCFjEbSVfrZ6FuR9GRxrZR/auNnyyyBWnsh1VkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kV1yFPfrdv4RTPd6yBQTkUSqM3arKWbEf9U7g2qBFhzdEXLPh
	ztWwmOjw/Kof6JIGbuq9fEOR/0n/uQ0pzhg4s1TB06C+6WNhWg8Wzazj2KOXFAG7+hM=
X-Gm-Gg: AYBFou1icpSPEQAJ4qCTnL/r5DNbbflZAlNrU/Mj5HwYJ2dHDvmeuG4SxTTjIFu6lSU
	cHcxkuHKTMoRK2aPivAFw55poBK7unEBGuBYWPHK/M9rWrvJmRpsHO5Vr/vpHr9/IgnLD+prkJa
	0w78RMzHbUWYkaT9uOq+ZUZzcPVHdcWlgvxfCZj7l3g5g1ARjbVcS1hAjP5KoN8PFOY64xtqjjk
	zfUUuewi7glz5scHj0d1gA5AOmgc6sEWbWTCOQMSDKV1zyzXV/MmxoPfnUi//z4wsJ891BvO5gD
	ZxEJivtlneC3ntvXgsi70ssrn2Eo5FvKdBDyiTBTvroMVLmwjOD+RGj49+XY+MRvaihvF82cTHg
	LlAyg8Ev8TpS3z4731XZ8dFWEFT1g821qv9hPS6c5CUSG+bgWcpYm46Ef0b36MEXSkw3V+PTVSl
	eeD/y3feYQdZ8k7mCJFxK3H5iSrSQh4jWgv3h4JWAJmvDnbTDpprxfnWhO4OPGDqrgz5AypaJiD
	eR0IeO37YB2yUkMluJ20VGFm76YsHMQVD+FAXrXp1b3iDEP5AO+lUwIQ+55OcoMDymmFkzo530o
	oDB/UZbhNMEW55wGJSujjA3Bjg61YbD6Y13D5LE=
X-Received: by 2002:a17:90b:2c8d:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3b1b0d8a4d0mr5854784a91.64.1794660973616;
        Sat, 14 Nov 2026 04:56:13 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c800esm2332710a12.29.2026.11.14.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:56:13 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm6: gate the local error on the frame's own socket
Date: Sat, 14 Nov 2026 19:55:52 +0700
Message-ID: <20261114125552.1319352-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
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

__xfrm6_output() decides to report a too big frame as a local error by
looking at its sk argument, but xfrm_local_error() reports to skb->sk
and dereferences it unchecked.  The two differ for a UDP tunnel: vxlan,
geneve and other udp_tunnel6_xmit_skb() users pass the tunnel socket as
sk, while a frame they forward has no skb->sk.  When such a frame takes
an IPv6 tunnel mode xfrm bundle and exceeds its MTU, xfrm_local_error()
oopses on skb->sk->sk_family in softirq context:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:xfrm_local_error+0x92/0x190
  Call Trace:
   <IRQ>
   xfrm6_output+0x599/0xae0
   udp_tunnel6_xmit_skb+0x713/0xd90
   vxlan_xmit_one+0x1ebc/0x3490
   vxlan_xmit+0x1369/0x6540
   dev_hard_start_xmit+0xe3/0x5b0
   __dev_queue_xmit+0x18e7/0x3550
   ip6_output+0x360/0xec0
   ip6_forward+0x1573/0x35c0

Commit 1620c88887b1 ("xfrm: Fix the usage of skb->sk") changed this
test from skb->sk to sk.  Test skb_to_full_sk(skb) instead, as
xfrm6_tunnel_check_size() already does; commit 6973a21ee73c
("ipv6: xfrm: use full sockets in local error paths") made the IPv6
callees use full sockets the same way.

A frame without a socket then goes to ip6_fragment(), which sends an
ICMPv6 Packet Too Big to the source address of the outer header, the
local tunnel endpoint, and drops the frame, as before 1620c88887b1.  A
caller that passes a NULL sk while skb->sk is set, such as
ip6tunnel_xmit(NULL, ...) in ip6_tunnel.c, takes the local error path
again, also as before that commit.

Fixes: 1620c88887b1 ("xfrm: Fix the usage of skb->sk")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---

Notes:
    Tested in virtme-ng on 7e1392a42ea2 (v7.4-rc2+) with KASAN: vxlan over
    an IPv6 ESP tunnel, a forwarded frame above the bundle MTU.
    Unpatched: the oops above.
    Patched: no oops in 3 runs.  A separate run with nstat in the
    forwarding netns shows Ip6FragFails 0->2, Icmp6OutPktTooBigs 0->2 and
    Ip6FragCreates 0->0.
    The reproducer script is available on request.
    
    Not changed here:
    - The xfrm6_local_dontfrag(sk) test in the same function still uses the
      argument.  Its callee xfrm6_local_rxpmtu() returns on a NULL skb->sk
      since 6973a21ee73c, so that mismatch does not oops.
    - iptfs_is_too_big() has the same sk vs skb->sk mismatch (IPv6 oops,
      IPv4 silent drop).  It is left for a separate patch; it was already
      pointed out in two reviews:
      https://lore.kernel.org/r/20260908224856.1591189-1-kuba@kernel.org
      https://lore.kernel.org/r/179369310739.488856.16665150928122536725@kernel.org

 net/ipv6/xfrm6_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 44b221a09a0c..54fcf4b43091 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -95,7 +95,10 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	} else if (toobig && xfrm6_noneed_fragment(skb)) {
 		skb->ignore_df = 1;
 		goto skip_frag;
-	} else if (!skb->ignore_df && toobig && sk) {
+	} else if (!skb->ignore_df && toobig && skb_to_full_sk(skb)) {
+		/* xfrm_local_error() reports to skb->sk; a forwarded frame
+		 * sent through a UDP tunnel has none, sk is the tunnel's.
+		 */
 		xfrm_local_error(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.52.0


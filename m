Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430564;
	b=a/PJF4fEyHColIseIGrXFs8u+PA4HEoUw3lu6Au88EHjyrGmL603WfKR18De85AVtt/D
	 zP5mEkz0q8OgX0K04/4seEV2Zlj3wURJ5cAij/EwkxHIQzjQqlWlXtnJ7aZMQTae/0L+a
	 MBxbJRVcq9qCdihfDdpfnitVsVWNlOwb4N1Iv3/t6Qy0Ze37ahpt5KfmTLfQ2qj3e9q3X
	 uHS/6BniKY53RMMD0boePQdDckYtTh13VxgESFXTI6Hhlu2wGpYVKkuXSjw37oOuSCPwa
	 grvkfhKI4mo9M985tG5QcGk1s8ojIsfIeS8W+q8crVNxF0ZYkvzEVyF77IqgzaExSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cwt87uUsOrwu5RSttuWdxqXXfcvorQyjbx6LQp+7f0U=;
	b=DRh7RncpI8xcodySTJNz5o5BWfkLD39jUxV4F3is9uJKk/zeXyQBdfcpWCntVtRcCtvj
	 PYnkB3fn51wY7HUvAHq2B8RtGaEkFbdRASamdCnMUH47EzVxhzQSOl327X1xVeOLVDObT
	 +VacWtCLys4jG3YYUrPwqmd/56ibakmVIRYsO8z7ib+AQt4kjSCAPxOXRbCrwhKx5tF9l
	 jeaE16/obm0b/hMQbZNIxlRpKJ0MLRREdZYOgIaXqliImsxLSr0eM3gHpXCm8f1SvEH1L
	 v/MOM4392WEfG/D88FQS+8FFdqTHkDncGNOr2C0L06cufyq4yXdwABBJA+nlvJCZUCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=IEmaKJxH;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E838606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E838606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=IEmaKJxH
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070781f63so1352946b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795430563; x=1796035363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwt87uUsOrwu5RSttuWdxqXXfcvorQyjbx6LQp+7f0U=;
        b=IEmaKJxHZzoh9SFERTTYfh5haKVCSycuxx/K3Ey6NAOHkrV0/w8s3j2r4Zuso6UDYQ
         8HsqcBTDXwaB9sTsJFNltvTKYv/BiJn89DGCt+4H19Y+QeELW6PPeyfDzAaRSS+sC/yJ
         MXQNPlX1tVbfCx4wHsfut5FDjb+qTassJhLITBv+K6EjJ1HDENme/sUZHtKZYSZaKnnv
         mSOzcM2GBXVSQFch/LEqN245ZqjzSdWerZzedMrKS0X6+4XWz1+dKcghq6mGkFFzhoS4
         wFFVOhWGxzdRZ0r3VBKyIzOr25FMeazd14E4lgZncWqYRj8Y3f1LEbouqxSYukwgt06x
         y+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430563; x=1796035363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwt87uUsOrwu5RSttuWdxqXXfcvorQyjbx6LQp+7f0U=;
        b=1qI80iJeGc/7CzgAGS8+fLj68WziMbSE9y3wPywXS8kC+695rzAC3KfX9H3Wkw3+Tf
         qvaMslkFQfgSS5fmdOV1YttN04hNRxFYCSn0E6uz4i8iocQdB4zqEf8W46i31VQKVZ9X
         VNiYZ/XaZBnOqz7j1PFl4LYZ8ThS9goZAty5n5jvOY8FrVXrB6R3nf9gANONYyO5c47y
         7qUjQKGQltS9g4DYn5f1AOQADANvoGT81YR9s3+QxGBzLpmvjwi/+HOp0sgujPbHpFQj
         ZbUoGSWBZuSHWxvvqLnOhSdYCj9SUHHw/LwhqIXZ+GZBxaYqnY/TdnMb7ILjLH5bkvr7
         4oiw==
X-Forwarded-Encrypted: i=1; AL+hErFTJV8xrT/954Um8+rkb5pPuxH7Dur+dGMl2BfbdLDOmZ52tOC9ykZ6M0JTIKOBaXz2HU9Nrxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HwvXN6ZuMq3LhZMYFOcNE80a7LF9sKAtD5vvPcKoaouH47aT4
	Sla1WUA5KVnFhxx0Q2X/hIlHp3wuF6G3XL6KzTJnAGEeX3V5S8hiN1s3YGOLWkN/uHA=
X-Gm-Gg: AZFdTZftBkeyCLyxRGWHV68IeVRfBP+RwxFA7SBxiSLlIzOAr5B1qqItIsfilXyI00Z
	rzIklKa2UCIdFWBXwKyhbVn/BfBoP1at9i0i0yHtpSYb8qQAIOPZoe1Ym2eA44fQlOjbGIjZ4FT
	YPiYVjhL3FYGZxVrb80y3AlVONSPWWSfmT6VCxiSB48GJ58CGW5IX8ZC6V0rUxvxkacRclC3mVM
	HW4wRelWE6r2Ps8S/oDiC382WPjnszJobkXx+3XTLZCNJbyGQFs3srMbKBJgIUbfcHnyvafGBKO
	KQ+5ZiX1UDWw/XDqwitlZCytmWIqy7fPoOqiUWGoT43GeHFXcwnQDa5fp5LdGSmJr3q7JRqU0LG
	rinhtvd+Gpsgr6W96MjwC6fikWHS4uNzYs70W9mk9CcmMj5l+ogYhcy9nu6GPoREBUllt3CTo1x
	1G/1DyIp/EA3JD61xllq2Zg5WvzYnOSkB8keQui94aaRWgBmxYioWI0BsthdiSQUR4TOf4fD+XV
	g12FzfNB+LjbYeT2UvMJujFnVwfZM9A/9w74crode8rDUwJ2jY30tOKh+F2F+EPCutEOubb6ViN
	pabv1IKMRXeGoBinN9v6G2AuIxhknw38AzyU
X-Received: by 2002:a05:6a20:4308:b0:3eb:b2ce:7b4f with SMTP id adf61e73a8af0-4014c34fdfemr11751808637.68.1795430562727;
        Mon, 23 Nov 2026 02:42:42 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde84cd5ed8sm2283731a12.10.2026.11.23.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:42:42 -0800 (PST)
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
Subject: [PATCH ipsec v2] xfrm: use the frame's own socket in the too big checks
Date: Mon, 23 Nov 2026 17:42:36 +0700
Message-ID: <20261123104236.4179425-1-rmustafin@cloudlinux.com>
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

__xfrm6_output() decides how to report a too big frame by looking at
its sk argument, but xfrm_local_error() reports to skb->sk and
dereferences it unchecked.  The two differ for a UDP tunnel: vxlan,
geneve and other udp_tunnel6_xmit_skb() users pass the tunnel socket as
sk, while a frame they forward has no skb->sk.  When such a frame takes
an IPv6 tunnel mode xfrm bundle and exceeds its MTU, xfrm_local_error()
oopses:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
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

Commit 1620c88887b1 ("xfrm: Fix the usage of skb->sk") changed both the
IPV6_DONTFRAG test and the local error test from skb->sk to sk.  Test
skb_to_full_sk(skb) in both, as xfrm6_tunnel_check_size() does.

A frame without a socket then goes to ip6_fragment(), which sends an
ICMPv6 Packet Too Big, also when the tunnel socket sets IPV6_DONTFRAG,
where it was dropped silently.  For callers that pass a NULL sk, such as
ip6_tunnel, the error goes to skb->sk again, as before 1620c88887b1, and
a request or timewait socket that vrf passes as sk is no longer read as
a full socket.

Fixes: 1620c88887b1 ("xfrm: Fix the usage of skb->sk")
Cc: stable@vger.kernel.org
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---

Notes:
    v2: also use skb_to_full_sk(skb) for the IPV6_DONTFRAG test, as the
    review of v1 suggested; drop the code comment.
    v1: https://lore.kernel.org/all/20261114125552.1319352-1-rmustafin@cloudlinux.com/
    
    Tested with KASAN on 7e1392a42ea2: a frame forwarded through vxlan over
    IPv6 ESP oopses without the patch and not with it.  Through ip6ip6 over
    the same ESP tunnel, a too big frame is dropped as before; ping now gets
    EMSGSIZE on its error queue instead of a Packet Too Big.
    
    Not touched here:
    - iptfs_is_too_big() has the same mismatch (IPv6 oops, IPv4 silent drop);
      it was pointed out in two reviews:
      https://lore.kernel.org/all/20260908224856.1591189-1-kuba@kernel.org/
      https://lore.kernel.org/all/179369310739.488856.16665150928122536725@kernel.org/
    - skb_to_full_sk() can read a freed listener when a bpf syncookie request
      socket is redirected and queued; the bpf_sk_assign series handles it:
      https://lore.kernel.org/all/20261119142231.2612515-2-razor@blackwall.org/

 net/ipv6/xfrm6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 44b221a09a0c..d38311645908 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -88,14 +88,14 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	toobig = skb->len > mtu && !skb_is_gso(skb);
 
-	if (toobig && xfrm6_local_dontfrag(sk)) {
+	if (toobig && xfrm6_local_dontfrag(skb_to_full_sk(skb))) {
 		xfrm6_local_rxpmtu(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (toobig && xfrm6_noneed_fragment(skb)) {
 		skb->ignore_df = 1;
 		goto skip_frag;
-	} else if (!skb->ignore_df && toobig && sk) {
+	} else if (!skb->ignore_df && toobig && skb_to_full_sk(skb)) {
 		xfrm_local_error(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
-- 
2.52.0


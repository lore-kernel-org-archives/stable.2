Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577938;
	b=F8jXbJxnrumMyWND223j9lSfrVXDro6kPRjEfoh/MX7MJcMeSQ8S0LH1Yi12hWcM0VHE
	 YHF1pd6YktyA1fMW2xDwBxEcQgVFAh7tC0ippSYswW9RITywKTZFUwufhzhbPWVgYPqp5
	 dI9BxfdflsIV4xsPiQS+8CtOL1W8Fo+C/PQr/mxBAnCCNg6tfR5WWJHtTF2RiQxmNzxoX
	 /RW+RoG2KVHVsYFBiYBhLo9yTser6k8JZFhvRDHQhoiXc7RjuZ7zcqRqe6UcLKnWNB11l
	 P/hMoboTbDY9kETzvJqnO5kJCYJ/bwj8j6olEUsuhR72HEQ2aAEugitKMBJNNot6xPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
	b=11TI0td2gMd5E0TGKwSxbdbz2w0tKJc6NOS0O8wz9P2TKMzt8mCDjfE80aXXYFcoGuxe
	 VNiHad6yxTYq3FOeBurAyY3uqQP2t4nSoX7HCwMZlzOYWfWvHPD2A3GRReKsKauoz3TGn
	 3VWfvvX6ohGtRyt0Hp/FOZHRodZ6UBsMISQQ4Gxc5XseJDJsO5pynn22ddT5IqRUtCKiC
	 hq1Z0SocrIw43SqmJVgjczKJmmR0TV/v6UAg84u4gTXlO+qTa0tnkmp9/5qe+nCNmritn
	 NprSWyZpYYfaVOOvINe9pVPZ6nFiKkSBv56WOVPWHn3O65yW5kfbahcAT9VZxOV5/Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8kEaLiU;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54904606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54904606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8kEaLiU
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so304818b3a.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577938; x=1793182738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
        b=B8kEaLiUxkpxiMfQSnOfY+QhJSPcwtTpmbu/SjZuk0nFfFUvBk+tMS5qjp+M52ZJgm
         lq3sAYheGMYLBGVbGJqMbo4NMzv2poTwpjvV47l/DF5YHfW68gR6dD3bL9gKXrTsUoVG
         z5pWCcK9EiMvTbu5Nb5ajTTMkCVWi9L+K1GMZkYNdQISskOcpZTMvGw1EK2/9Q9gCbXn
         7iaCiKYZa0T83YtCyJ7wyKr4r7S4CrXjRq1N6KiKKOJwEYK/npgvHYcMWIQHBtCU7BNe
         6SqVBZKoBVJllfuYaMFeni6L/si4kuREeLXOA9SXBTPFjVIo/8N6imeMn9GPX5ZWumUn
         XXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577938; x=1793182738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8Rp8y151YKhC3Th2dmfVvjGR6W65rHia14bPEdg4iA=;
        b=xiJVTBhls6Uv5Kk3R4j9bxuzggeJxOsOtHUKPZ7UE0FdAqP8sb31MWDBGmLRHXdtnw
         mf6my2K5Z1FhiJbroxEc8kkX8rSLFreEyyO61Zw4KX+7GBkNvst4xa+hgAdpe8WNydlS
         aFJFrHts74KYxcl2WFD2k6d6gCzztYll+BBWwf+6AbKfdfrPeF/hltf5cyBv0jOmVmAz
         8q2ABKBo4rnqIdH3REpCNJ0KyqoUtMvaTK4e4Fe11wmuC9kQjxc5nTN7mpRt4iVFh1fb
         OhnYGfHoWoZyqH/+I91VquPhRuAOgN6FC5ckdPdI7OrG5YO0Xu6k7jfD/icH5V4W8ETs
         jTbw==
X-Forwarded-Encrypted: i=1; AKwUvBy2rrCw7riBmxZUT0RV3C/tjgnLpTs1rHIJa5nsWNxcnG8VObCAMdwj55tpChWKHEO8aqGz3wA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVGpcEVQUFMgchgxGKgSuLPwREwOEwoos8rFxZRvZ3l6zGfl5C
	iPseKjW7We3getRV6h/7F+xUcrYfA7qj6K7EXaPrwo6z2ZFyjxCpfX74
X-Gm-Gg: AYBFou0wws9kJnAyQrlk2miPZ1keNisMSw0JiDwV5qB1+s8c0q77DS+EXkepcyyO+mW
	ay8vDPU1tronrAuP84IesYWkfQ4eD0VG5eU4t8ncH6nDW7SG+arEg5hhhYdu0CNZs6uwh1J1I05
	mKhtOj1duoutkWhM1s2uMmyKzj7QKERGoa41U4ic1KvD4raYkZkCtKSQPk22+d6a47Y7WSu9VoQ
	4tS1yxZR4IqMtG8Ij2PfbmX+/slTyjiBpnca05ZMUYMb6BO2zJ3jf46A+e9xx1U+l79n6EuxLth
	xRqBXcMite7Vf6bEKhDFEoEneAzcym0NMrgsUrOBvHiTd2iFlboQ4Up4CaAvCA6Q6w4Fi1I6cBI
	BMvSnO43uFdtUg40TUdCucSWNkcvQUzNuApKVfKcyn70zHpunz6/bW16xEhQt+Sdsm9sKJIDelr
	WCa/k5t23uoVxfEohKpDINVDPkHT1NvTbE8sv7UOuYJU9WkzNWeJWylPBV90VBt21Vey3e3w2t8
	tbmgmtjuUJf1b97HLcyhSO/Temkf3vvY75bRUd1D1iUauaqOPYNwXvz1d/xVBdBNMgAYqY=
X-Received: by 2002:a05:6a00:3313:b0:8a0:76ea:36d5 with SMTP id d2e1a72fcca58-8a089d26b1amr947051b3a.0.1792577937590;
        Wed, 21 Oct 2026 03:18:57 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08960fa88sm693011b3a.53.2026.10.21.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:18:57 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm4: use a full socket for local errors
Date: Wed, 21 Oct 2026 18:18:37 +0800
Message-ID: <20261021101839.3797779-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
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

xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
by TCP_NEW_SYN_RECV request sockets.

When IP-TFS rejects such an skb because it exceeds its payload MTU, the
local error path treats the request socket as a struct inet_sock. KASAN
reports a slab-out-of-bounds read in ip_local_error() beyond the
request_sock_TCP allocation.

Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
state or reporting the error. This maps a request socket to its listener
and rejects sockets that cannot be used as full sockets, matching what
commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
did for xfrm6_local_error().

Fixes: b00897b881f7 ("xfrm4: Don't call icmp_send on local error")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/ipv4/xfrm4_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..cf6be50485d1 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -39,8 +39,11 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
 {
 	struct iphdr *hdr;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
-		       inet_sk(skb->sk)->inet_dport, mtu);
+	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
 }
-- 
2.43.7


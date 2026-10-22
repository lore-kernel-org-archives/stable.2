Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660954;
	b=w4YUPb2IuRrZDywL9u4GsC80J90bMj49D4/ZIb4zy8lJ4DJyV32MCLQ6HT/8hGgnFY4d
	 ZMAtJKTMxDffnX1MIEKZRW83837b4IrwrWUEnm3PiK+lVRvd2kOvAXThLNZkZ6vuYQfOV
	 b9b1rSSsLMXeEVWiJhpHZy2kvWDs7yV/AuAU5HqZAAEzPoPwZJNay3MwmCNXb/1X2oODj
	 GxBuzmi9NRqPOQCaHKoLp15QBd+BLN1JLEo1LuUtxnHmYGA7piZh73uwKfTbfsfrvnHGw
	 yOs1mVryzWSs623Zzb3bafWY7WUxLiKwQbuXvrXkhN0LgLQvbvkhpKkhaORIdxQ+LTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
	b=um/+0ZEMWqI6z/uIRItAcZhvZercdJnmildA5JH7SkCxyUpJZ5nBvhxnNX+zO4NfAcHU
	 g9A4xvwwu9Ej772vrFUtI9jKVRTvesRWiR0NfVY8EB/8Pp3rlmUEO1ywgNVyvgcnLcms0
	 M9XBLakuVa9dKb1+3St4qAj3lcgQObfpxFSm4FFabOWHmUXln21WFNDltWpGv/lwfjZ1h
	 oVqGVHkqYSXHUqeppTUuxm0TcHMcRVvtAgBjZ6FeHmlqtxO8/0hdGDfI4O85cHSQeG6OU
	 KFkogij4ywgW2Goj1JlR66Oe7XdsbcEv/HOQdWdA/pNQA1vu8AT4i8CDSugqjrkcz9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wLkHg8e1;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD9606A339
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2BD9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wLkHg8e1
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e635220b4so145640785a.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660953; x=1793265753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
        b=wLkHg8e1uDIj3B6f48nDMwfgxTRSqVRBZ2aJS52EMJ3sCjo+Mk1+qz8N9C+ifyz4/E
         yguykozGkdr22K8IeyHzX0/kjVAA4LXOowbF8x42g4iMTWCQyEn5TUkkuTiupR3H6x71
         RFohGwA4pYV4a4ALbnwwZS8Hxg0EGLpS5nCaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660953; x=1793265753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
        b=nfCk5t09Vy94SCm48XqxpIVqH/3mfLon0js5YPMZUhOP+vyGaloREiS9deKGebdjOB
         uMfJFOkJO0c358ssmxFMjWuU4aeSnUeuxfXcMLXkKWgtl2moalfSGx80rVRyUCFDNTQh
         ysRK3eWYT5MdpIs4cZvnzKGvnQ1g5L36AOLXqeMB9x7PLt6gVjg0gwXrHpts/Xnzr1sx
         hG9WPvpwLKkfvyfb0PAznGWWrQASDHbAyF4mGYpeRNBlAiRjPVDknrBs/cCRYj2Ugqad
         Pqghr9tm6gNRMTR/3N5YfEy7BByiKk/vEcfQkVTTP50FlYR+NMMbiDEKy7z5Tm6iT99F
         qMxw==
X-Forwarded-Encrypted: i=1; AKwUvBxp25xhLOmxUQ/q2clBK1DcdttFVl6NMfmBb706/AP1rhcq+HKUent90rlLGGzScQ9U0P0QrVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkJF3hmS5Br7BWgy0XsEpSkVCU22Bdp/Vn2JltSMRqEbrDBKGB
	60FK7FZB+O1ZT9zRQXfzM8HM5Unx4Afvrp2kSm9QCN+ioW9IcUSGQZv52JMVOykgcw==
X-Gm-Gg: AYBFou3KzLL9ozklxZgXuD70OfYQJhtwPS2cqba/hkyySy3Uum+DCp9Mya6o02D6UL/
	ug/r9PBRIrqlYZ/fHhOB79KUndmibrZnbE67a2gPqJ9U9XQpPzLSZO3DmsOr2uSpKO2TADDpo89
	BixiQqAp+knrZUfIOGEH+pzw0gtEjBfpiC/BlqQraTohb/JTO70u1zKlTpHUjSO/LhCoIUqfqZr
	ipgASlOTx/S72yQLs+FEZQAL5XxKGodlnUxUIbLBhIu5FVDGVouiFVUv8h1QqMtQWze+3zWGqnl
	86SbQ/r/pP79o4ZhZopTidBsJLktnOPoGEIuYzoiBE2WkHeEYZuaX9mQB3bQZOFd/bMKzSkPfIj
	euRsdk7WKsJzWE9Ncx+f6XeHztdRDzFSULtxDFN2SZkQ+tb8mF4e7Vp3o62cg784ELwrnzgaJKM
	eFZWdSoWfNQc3QwA7R4pRV+yVCXQLcrNXySqowQdLPSwl4t1VrLjkODUuiBBbR6Iiroiv0iz7eX
	y8CCs6LlxMaquDrAkVFglyROUFu6kfDjbsQrQeZGYobXaU8eV3FHfCzfk4JaiXutEx7NfjDBUK4
	jbU2Lk76eCIULB2H4F7/ZQuDSEQNje3jXSCRbrsc9TOFlc4=
X-Received: by 2002:a05:620a:438c:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-93f57f7fea9mr895797885a.61.1792660952636;
        Thu, 22 Oct 2026 02:22:32 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
Date: Thu, 22 Oct 2026 05:22:20 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
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

The issue:
A TUN skb can be redirected by tc mirred to an Ethernet xmit path, which
calls eth_type_trans() and needs a full Ethernet header in the linear
area.  tun_get_user() currently validates len and the GSO header length
only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len to
1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected packet
then BUGs in eth_type_trans().

The Fix:
Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, where
hdr_len is only an allocation/copy hint when GSO and checksum offload are
off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting the
write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchanged.
This preserves valid no-offload TUN writes with hints below ETH_HLEN while
guaranteeing at least ETH_HLEN linear bytes for the redirected consumer.

The maximum receive headroom advertised through tun_set_headroom() must
reserve the same linear minimum.  A large upper-device needed_headroom
(for example an L2 netkit port behind a VLAN in an OVS datapath) otherwise
caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_HLEN
for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.

Conditions to recreate the bug (repro available):
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach ingress mirred egress redirect dev lo;
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
Unfixed kernel will panic in eth_type_trans via loopback_xmit.
In a fixed kernel the write is accepted with hdr_len clamped to ETH_HLEN and the
packet is forwarded without a BUG.
- no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-shaped
  packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
- high headroom: create an L2 netkit pair with headroom 4096, put a VLAN
  over it, and add both the VLAN and the TUN to one OVS datapath so the
  TUN receive headroom is raised to 4100.  The same hdr_len=1 jumbo must
  keep at least ETH_HLEN linear bytes; without the setter reservation it
  still BUGs.

Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/tun.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..1e235c2f0aee 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device *dev, int new_hr)
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		max_headroom -= ETH_HLEN + NET_IP_ALIGN;
 	else
-		max_headroom -= 1;
+		max_headroom -= ETH_HLEN;
 
 	tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
 }
@@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		align += NET_IP_ALIGN;
 		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
+	} else {
+		if (unlikely(len < ETH_HLEN))
+			return -EINVAL;
+		if (hdr_len)
+			hdr_len = max_t(int, hdr_len, ETH_HLEN);
 	}
 
 	good_linear = SKB_MAX_HEAD(align);
-- 
2.43.0


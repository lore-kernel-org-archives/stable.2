Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852131;
	b=dbUkoONo5dp4qYCCzMVEJnoctOCpRR/0YcM1WTaL6QOM4YVH1McKGsYQlOLacPBfXVF7
	 Ln2SCnlpljl9Olp6mIIlxzbCUKMQ/Ev4nb3TQQcybML2le2VG8hCnlDf1uvj5tCOkfP99
	 SxPg7Zkz0Q+8J+o6BqR9f0IPwmuAngJuYbPcvPe9hB3DTT8QdF2DllYSnhcZUPoTT94ex
	 W4z2ZtkhfXKMXncuR3irE71Iz8KPK4TEXBVrEHYkok8CJH4FA9J07RPKBhXwQRbj7Pat1
	 bFowEod1sDrrAuvZ4dbXdfhuAIN/gvyJah+MhgZOf57bzoK/d9/b0XiYOTJ6owUdyqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
	b=iIOUhIfLLYoMzurm089e0sGpPFeGTmOVvlIC/fqC3VlYV134lAZFZ8/ym4ucyiC2kGKI
	 otGWLW641rxMZpK2W0MVtb64UO1diSj/mTv4a9MguDKusG0/QhBvsJVXV86LH699r2MCx
	 Sffo7+VlSE/7V0QkNYqWepDF8y1WutWJQD1ToPOkdvhWTrtl9LikFoeMF9Uk2WjsSDjeW
	 kRCzoxxWJtll1LSY7LokMaofLLaMt03OYZFHhgj7fhKiYESi0nJjh+uLzRJ9uZGyFmORY
	 lxYj1zBlpkdqkLoPLllWE/ldu3X/edMBYmcfNA1NXDhOXQIMRDQwMOr8jZsUGd4hTCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+6IWIWv;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A2606A331
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2A2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+6IWIWv
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso14751386d6.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852130; x=1793456930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
        b=c+6IWIWvoV0juEB8eR2KxeLBOtkF34gPKQDPfiG0RNV4FRwivieadp/Y7RBMjRwNJz
         q7Jt0HJn013aJCqhnkSjD+9kh7IywgtEpnuC2hWiTwBFSQ2vmV9pixoS4+IkuR/27Mdt
         i8fNuB3cBdcCp4ywu5yzW1/rJvZFW/UxEisok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852130; x=1793456930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2EUS/g+TmWUynwL0bo6Y5RIYTXHaFvkE1EYzksbXCo=;
        b=0P3RvnO4Zbc9OAQD9bzKyNQCN6VQv0bOvIkdxCA9BB5IVnZDZ3Ja8RGbxvdWZKtLNA
         x0x2wvHh/GR8ufvBW3qA609weGjitbXTLy2lIX+tdyhtfIXCKA4rFs2rF5EyxkLJJYwB
         fE+RzLLUdl0Rl1qEoIt2Ivh0d+l1ahlPCSQUDiMfjQfyMqt/gWku7JLHgeiwsslAx+w+
         eijIkMdzCvwog3JeYI/7J4+K1h/FH6rnNA7g3j79C8/YQlQLfpNNPNlphUFsbjGZwj1P
         NbnTbooblPkRd4+Fyg6M4Mwhq/HIaNjzTWwJRRDL1t/QyMrRlNsDJoe0oKETv9ObbPDg
         aJVg==
X-Forwarded-Encrypted: i=1; AKwUvBw61NY4wc4IHECYep3YNv/wXAjcWynicKiyPcB/RgSmbaJ3R5+L1DeYQbUTnmdAoozDS4e0V9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDkiyHnSzDJDXKDO5w1fRR8Wz4gHV8M3fVH4cm7rgyefiUgjKz
	yoH1gDaGDCR8D1LCLIpVMPOuxozz7tu3yS21y2iya7rRzOsX/P7ah8PYJOp04TW8bg==
X-Gm-Gg: AYBFou3SjXQWE89L2394gRC5we23WjjCFT4/Xb2qOxGkKqyQX83FTMhqgOas7/soO/t
	f2JEA+o1mdz5XBvK38UwERuKurp2YO3XPFNJBBwiAJ3V/MM7GTFg477ZEWPIs+euD2pIMzF4WX7
	QfdY/fWtXViec69YfM7iQkEq+N9bJREXhUtKw9t5vBg/sg1E1nKmgaE19I192bRbYY6LDR+ipRJ
	Hw1iDwXSxEVnXJ3X72raN980vaum2r4u5wVJYn/S1heC7s4zcLruYrOM/bGW8o2pT/9mYZvM9q7
	ef1UKVjK5EobE3xza6bjUSM8Elq1YHqJ/CgSmc9/KCFBfQeE0MMYRdbWRElOV1NrssLFkUFPXUx
	HFd0Bre6u9a7BFM3RQGtZJMYT+909Dw0hJAkv1iX9FsXg8KgieqAbbdGFqLm65pT2mwDgio0p4D
	XeswvntPocab86Lvn8FCXqIIjlzK8DIGYHPa91nAMxDVvELlt+q5o+azKlRl+rhSBRFcaArj5Be
	S81juqYcMgHqylrG3CAdslFcXz/9sO7r64FaFgYW3qCguPohZZZ7U/W7fv7baZSP+J/ghJ4ZX99
	MSg2Wv1Da4U7Ve7a1tlBXz54DPHMjWN+jDZwVXOsSQ==
X-Received: by 2002:a05:6214:2467:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91c48e40138mr33470466d6.18.1792852129746;
        Sat, 24 Oct 2026 07:28:49 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/6] net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
Date: Sat, 24 Oct 2026 10:28:36 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
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
act_vlan POP_ETH removes the outer Ethernet header and leaves the inner
Ethernet header at the head of the packet.  A non-linear skb can have the
inner header in a page fragment, so a following eth_type_trans() may find
less than ETH_HLEN bytes in the linear area and BUG in __skb_pull().

The Fix:
Pull the inner Ethernet header into the linear area after skb_eth_pop():
drop the packet only when pskb_may_pull(skb, ETH_HLEN) fails.  This keeps
valid non-linear packets whose inner header sits in frags.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.38722ee638a21@gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Eric Dumazet's Reviewed-by.  act_mpls makes its
    pull unconditional and act_mirred drops the skb_network_offset()
    condition; see those patches.

v1 -> v2:
  - pull the inner Ethernet header with pskb_may_pull() and drop only
    when the packet is too short;
  - keep the OVS TEB and NSH members and restore their Reviewed-by
    trailers;
  - replace the TUN patch with the act_mirred consumer guard and add
    the act_ife egress fix.
---
 net/sched/act_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..bca95e0bbf64 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH_ETH:
 		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
-- 
2.43.0


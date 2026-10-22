Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660951;
	b=1gSfYHt6UgmJLTOI+exSr5AVvZho4zrDdt77abnjEAai5nkTmdJLCjrL5R/2yBlmktdZ
	 PN95aItW8AiEo2VzwafanQK138u4hdEbu2w0FhkBqtgueN+iRV/cpfYu15VTcGnwyU542
	 MaDzz9dYB19USvgh8tSXs2w+cm2Qn8wsAhvpyK3xR2GRDCDzGJIAY6TET7pAkEj3L8QX9
	 dH3KDcsdZjpzgveieQIcYsD6iPvciqcMj31Gf++9GtPGXWKPAs2J7aCVN5gs9XidQQYh5
	 u+sQJYkokXYd95RQYPfiNq3Ne5eWZpr1aph2iO8Mx34MszNk59QynLKlbQ9BN+/xMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
	b=I6jPv/8CpcmcmHlSy5m3g03OS13zx+1/c0Y7uDDppnVztC/ZT3bhT+K5XF+i5kOBvxmS
	 HAP6ZPArtOupws26wRNG2W+3/kSaLupWVEMaeDacUF2LXoXsQFkLdrhxn8m56OvwoHl3M
	 rz48EVicy2VKyW2ds4lucVhrw3cRVP9Ud+AZvT+2xFPNnnGXSS8nTV0qx+1bStUlDH7Zp
	 wmhg8afrZ2GGx73VXLfMLiE2n+VTI+72Sl9fz36BlPQ+UFGlQcOoW4rahq9uAaiT/vb55
	 w/iGmd6nACXRRNFv/KyP6EHEfTORpY5F5ixsBLBsnHI+F5tv4+6IfuwLgovXCmfk45g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dPxWFIdc;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76489606A325
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76489606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dPxWFIdc
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533861a59b8so19243171cf.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660949; x=1793265749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
        b=dPxWFIdcC9xf1UkmEEILwYbOGS3DT4ZZjIpkMUSV9aBIPqT8XdKKGip+5aIKxEYgCM
         zC05Cum86WM3BB/g6uwptXmDR12HkP6YM00bKe08Hpj29+E1jMlKSGYRnnELp8Df2ow6
         f/xcnU5Bqs5LASaR9Z6t3IQq0VaM82SatTgN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660949; x=1793265749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAwFyiGlL69edCRWnCYWnDbLZUd+/qfHv9HYgOhIe7I=;
        b=PRMaeUEG8lnWCcez7MOnZW6cc80JEs1LEk/xSzjdWmWSJ4qkKkmcuX5JPXflQclVLZ
         KknPP4eahExO8c1DcIldQ9fNnDVKYEOd0RrJEvUXxcsLxGnvMdO2KqgF+xwDX5+uMWMz
         mXE3+gQT53/OdFTYPeLfJ/EnoTGszaa6En1QJe8vZg3z7SMCtaAS3ovDMJW3VQJZQGyr
         cK3EFHbOl/TLVG8u5uVUcKIuTYhv+UCbOekMYmA2sYkE2thBWWCNmuPhoX1D0pTKaFgp
         5KJpDI5/oG/9e4FFQNEIUCW5sZRZUQicuHPE71fcu5F0OGozDWOQNkR3VSdqIiVGQ1hl
         +hgg==
X-Forwarded-Encrypted: i=1; AKwUvBxgMbYh/LLTv0pzIUW6GExGFuCsxcVahobag6DeZz2CVVg+m0IItiA5o2ata144gJlLCW+swEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4OiTthhQpIrZbc3y+jTWoT1SFQjRSj0tUPAZWKFY+H8SlyoPu
	HhfNbOZpPqWsJpuYFONyrFhzmQ+/W5Mkq6wEe+PBE1G5faxvmXZT/H1D9MP28gozIg==
X-Gm-Gg: AYBFou0JPqDd64LQ6s0u3bX/NUtLEvbhljf6kB5PJYhlOLuKbUEnPjpRljwa3HxpRGt
	rcywjAPFpjCkcPQeLRa6zumPlQCOXTNacvB7gk3p15NuqqbRVH/m2evtAfeNz/xAmvJzJAM6VU7
	GnwLYksUBjbkm7X7A7lfu8Z4AQgREhK4Il+gZNvVvQmOQH4AGpBSJE+OzApfWr59iC28UXfJEQr
	2qXH6g5vQFxYddajQm7B83F/CTklgv5FbpX3X+H4otXFIWfTxr/vYk2eQR2Tsv1nnOCohrhGwT3
	+ltw8FlE5kho/XyxYYuuwmoJKAG4MW8dJyUnE8dSq/qvrimxle1Swtm5pLOrJVRRkKTSVBjRux/
	SoZ/fRq62ZvpKz3DlnOEtGg43KadljrDR8YD6q+xL+0A+YuB2GPbo6IH9oE1Gkr5LlgXhB0m7XM
	gCJ1qsuxPUK1BO+jbqKRKGr670z1co01u9n9jSxnRPvY+DzwmqoRynIvNjGNSwYCH+QIsfQinHA
	9oi9OfX3swcajd6PCijI4UNaRF7edbmTfs0JrIFzjc5UO4LsourzLEH7Y0k5FS3NE3rxpAF/ipE
	Zj23CqpKPud7+lNqR8IlueU3zQ==
X-Received: by 2002:a05:620a:44d0:b0:93f:1af1:7952 with SMTP id af79cd13be357-93f57e5e325mr843876485a.4.1792660949345;
        Thu, 22 Oct 2026 02:22:29 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:28 -0700 (PDT)
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
Subject: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet headers after POP_ETH
Date: Thu, 22 Oct 2026 05:22:18 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
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
act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
is redirected to an Ethernet device.

The Fix:
Drop the packet at the producer boundary when skb_headlen() is shorter
than ETH_HLEN after skb_eth_pop().

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / inner-eth frame.
- The pop leaves skb_headlen(skb) < ETH_HLEN; a following
  eth_type_trans() can BUG in __skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..ddf03b08bfe8 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
+		if (unlikely(skb_headlen(skb) < ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH_ETH:
 		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
-- 
2.43.0


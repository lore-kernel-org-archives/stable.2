Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756770;
	b=cbHFAdzc63Uf05S/EFSvxviCAhcqFZl1Q5hAjgXOeHlMyWZV+OJOteAHf4sjXXZWgbIM
	 pkJbVFSjadJzkLYtvEAyc1aewuZCAyLDu8IMmPgb6g4DjBDXIHmOjO0Kltbt1UcCReRwo
	 w1SftnaeLGkdDw2WpM9UNnYS5uVJEvzgx0PMTP72l2A61H+5mBJVgujf+G9sCmwiy+aap
	 tsRFLdcbDg5BkjtN2lKdCbiLxG9ZbfrN/hT4KAdQHMf7x7OgSOtyQwfb9zQRMnZy23V9h
	 GjTv9TnWau1CVjMKV+VQfzo4m/2pfvqSwRGsH3IZjgjEudtm2Nxu1rZfui/mkZqSMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
	b=i4CA9g48DcjmRa6uNo67Lg+GEJNIksFBlKdbc0zCbgIwCfUSDJe4Z4faKX3wUebDhWE2
	 c0rzp0g646FQAA0GNIi8Rb0yyro+hUjmwHT4kpGxmqxaxAy1aGLm2nQQtSlUITF0j6dGa
	 a5/GhFuG+doYSBDwXZ3JSqFAXlwV4TZ4/qcFj6xZIaHdN81irVIMj0Rh5iV8WIdVLU8cr
	 86rsttatbeaKwfj4wKDq/DUmT5hBWpxzWzOvTMFr51b3PsBr6A7U87SYZqONeCABnpXnn
	 q5QpizcNg5pDVegOSpbN1RsQarrz8K962nBFSkb3sp1kCa44dyoigSeaFGr/RjiVYGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pGPmKnWy;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4784606A320
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4784606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pGPmKnWy
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b83459526so10117536d6.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756768; x=1793361568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
        b=pGPmKnWyvRQOVI9PPuMMhx8N+Djpk3zwdlpMRV5GEQesgvmNtwHvVAVyPaJ6uJjVXY
         SGf+UifQ2M0Sk9kCLxSY9l0/ioJ0hRPu7/FUGcx5L6SNBZNSrniKdIZ05tWnlEeoTmdX
         K4Ia3U86i5MCV9fSa/zOoy0JG2LJOFFw6XwJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756768; x=1793361568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DT0mSqAbYVaCte+J8d0YAsmxoXU9xn+dv8jMhDaEL28=;
        b=v9uYu/wSFm1JtcrSa+9CzTRUrBhLCDtjJge+mcFjOuQFzXZF1MfTp6xmiF8fn9VBnQ
         c+I9FiOrqFIKAKY590aC9pCFBPHGpQxa4Ud7H9VkZsNlUMu4HlVcS4UZxjswWdIEXXgl
         rGrFojX1eHDvPe9Cd1TOxwb/RBHppmx0u1o1ZOknxZltwyYAqr/+0zM61fCr42Tc1/QQ
         XhaHF7X7GqMmGtH5JVPVbrF2tFxBcWvyO2nqkMRdG8Ia5aAmEV5Fc6om922O9hI+qcYj
         rAWfLsHqqo5m14p+WAsM1vQeRtrk2rYglh3LDUDRD8uxBscy1FJLVJkWCp/untKuZ2NP
         Iekg==
X-Forwarded-Encrypted: i=1; AKwUvBytWcFJty+E/+g5ixkfi2CJqp9Wmwb/AwgKeG+k3e5a9MTr91+kaHgcEn5CzmXIqyRLerowfSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW2owYCaw34WjpFCrGMDdcAf2FgeWAMhVJzsst4TvN/vraV76q
	7PIP0y00QewbyeIYvTTz3GfnvUyLU7P5iX43tVxiCSAiMwbKmgpm6CVDnu2t7y6xGA==
X-Gm-Gg: AYBFou23qA/5JNmy4YuDbFUKKOSKHQz8L6mGw5P3Wh+s5uuuYFUz5nNXL+MdnJZOKdG
	vvny46de+IXi+L9LrvY9rIrjCQ+4enr6/Oukr7gCCSEgJ3k3ylF28xpXqkMDktN0+B2TKNQnYnU
	L0GTMw1kzmCIQKGHXkxRce/aeLLDWkiCC/4gPkqS4IFSV7lKmBH9sR8cLlkb0+eedU2FZNFxwGS
	HtQdyEzme6KKyBjl9uO3oz0TyDOzk5/+4sxkYcZCRpQn6V8KqRdl3SiMXUyDIzfMdhwC6D4nwpa
	rH6brXP8X1atSzmmFI9SxdUMupnWYiayQCkdRR3fzbzL2eq4BzroJdJBvAjeqx9/v7ConsTMWif
	5DguOWSvT4+DdOmYs4FogckAWb+8eEtg5HiUjlLlsq/mtjKKz0+NCY52oUpXvJXgEjcelnD9Icl
	6tQJnpZoK78k6udn8CXSPFY50Ox8qR3/jLveehS9tzjz1dBf8Awh5FS7VUOYCBw67VeL3tp/miz
	I7gbgrIbEY0OCBLEnKQ7Cn4wYdhRTAjztzB1oMXDkuBxkvoNpUxV0giUCZV7oP1T+Y3f+AsD7Z/
	03QG1W+YFFUCKx0jDl+M7z13L40d+04ztlXcWlCcmUiMZ0Ji2k5Pbb5mdt7fkjY=
X-Received: by 2002:ad4:5dce:0:b0:914:501c:6d08 with SMTP id 6a1803df08f44-91c3a8284b1mr23019456d6.14.1792756768360;
        Fri, 23 Oct 2026 04:59:28 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:27 -0700 (PDT)
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
Subject: [PATCH net v2 1/6] net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
Date: Fri, 23 Oct 2026 07:59:16 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
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
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
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



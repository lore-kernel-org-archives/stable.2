Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852138;
	b=l/580dmpTvseiIMvrI71y0B078Jolp08FNO2z+z0C3h4ZB1bg86guZbFHKMpgJdZFtH/
	 sVnvmHZU7tJthBl79jTlpuH+ctss59wfa34ph4qPmIup6OY1tJy3KlAqqxozL5Mjr+wbv
	 bxN7ImRvIz2Oap86+5yf7XbftY8hDiAYzkuaov9m412lpbAWzMeY9GDPpOXUbrzc/4g2d
	 5xlU8FAGzP0L78WR1CFAu4ZUVmknNfEKKj1MAalAwAERsJ0cMiWC6DJPmMerBjZA0UX7B
	 aHwLtRJkc3hD++9dltcHsoYg8bnNB2P27Euhcj/uOQJ7I6LE9BoNa6/YuSqdmZF2tMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
	b=it0JpdAH+59xcKuZG3vkoXobYI+dLiJP1GHRG5RHMpyZp9TGCzdAUMJNGkKMEWRLmGoo
	 zZTW/kXMt4wjdWabelJAHQv5htVZ1J+P9EwxIitk5VXXksyL1leBfuCqP5eCzhWZQYMqR
	 On/+xbv5uw0z2EqmUSBkAKc8QH31rfYf46GwnJHt1e3/KWoSZgdZ530j5LlCDwTVTVb77
	 INmj76+g7H0g223CBeUuVs1HH3d/AHXYp85dHUqKEPLVdwkA+KxfLjMVYuVKUVWotzliM
	 aHSTkeCJPHfs9SKobCw7GA1yqH6FHBmVVOWwRS4C6oIZrgcPXrKyhpSGhkiBw5MNkSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EvLJFVSP;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3860A260B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A3860A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EvLJFVSP
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b8b456dbeso20597826d6.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852131; x=1793456931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
        b=EvLJFVSPTQffcppTJz0jaei/0P9Zk8/CWj9KnjzCJprqTxxeB2RtoWzIUS++YIILy9
         jdFJ7SLbK4J9xMbH5bIK7tv2p4tMqRUQgAeCPvqYNszxUWOUbA5T8gt80Jn8fAz/FpSi
         kw5StGFMahVd2Oo9kD4c33uglz3XoGW34SBwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852131; x=1793456931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ai24WEl5RPn/XvUk05mE4pUqYbTqasZdMRowqTpHdk4=;
        b=nnlgo3T3wfvjncoWAdv/l9NX1j1yuY2RKMUT1EgFb1lWhSuxBCd1SgEpjFeIaOglOk
         z2iIP/OiCLqNo8owkxRK/LcOMPQwiV3b2kE7VjaVhRoByo1Dop0rOR28/UB8oPMFlmcg
         G5q9nGNlbZDfRJqEw7zJaetEnflV5Rgw+eDrtdkYtNVbhHzdjS8Pgr+/k0k5MxeDCzXq
         FD8jWukgLhu8VQhpdkeHq9+291KItLKc1UnBketlZ6mHaxEEfCQkDHU9n776JS2rVIUC
         UBJnJGSmcipeFQUkmlsB8+JZCmE6O8NmvHrQpArSj/MV5d3aP9WRZ8RIrqW4QzBMPQ6l
         +cjA==
X-Forwarded-Encrypted: i=1; AKwUvBxopZLaZRMAhNggOEUFfyjkPPY+FsI1JkwMXdbinWbaXc194CeZ3PFIBgEAorwgm2ONCb1BGgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUz/ll+KRp3+lLpurLQ6pXdiafGLLvKLpIefXosauOgG6OUfHD
	+qNR3hzdtCwp55U998P+E/TqGMU3oKkC7D7RsZwg61CsofIm4CVYpaNTp/S7IgkANw==
X-Gm-Gg: AYBFou0xtBAm62nh6xe3r93MPBj3aam3A2rtzXlpMPPAbEgL/EP4Wmx3tuV6w5WA4qQ
	MyVWvQDkOJGCuuvggA2K9B/zZUfnpP+J0Iew3Ag3SIptdhOGSnr6BQJYAj36q0rQ0dSd8134PUB
	wyQ3oaIux3iIwNXG8tktBKWZh6261xveyjcVgXfKv2kk74c1c7YqWzoCAZ94MVYFa9j+mFjfrfd
	59j2r94G6UdKSPbre9dLAHeCioiPhK+eykM364e8nUzkQIchbiqBAAA/fMQrHYBi1BYXk2T0a2N
	brJVV8MtP9cjb9DIOJ0PhXliw/T1NKZPhGRULKYvLH40/PsuBFNvqqz9sWFISTOOF8u06q57M1/
	6LeQwDG1lGs4PCWi7fmUDGZ4PbaALDPnG7h6/NhTtZ3Q006qc/muMOGcyS7fk+lTvLcaVOH+ojN
	XEQmWiwGWwWNey2CApIDJFvftLPhicMnVpiSRe6We0z71QKcCQwxzvPVb5Fbu3dVWtQOrGwejJi
	3KyJgVW+jeqai7VszjpiSDQztQ5L0gEqrP8+bza9B8wc8/0yAR57k9y5MWniqjVRgxjZRxzvFKF
	Odt/owfBLfElS/Me6cGcyTCX5euTlpVmMNeYbSKUsg==
X-Received: by 2002:a05:6214:dc5:b0:91b:ecfa:df3a with SMTP id 6a1803df08f44-91c48eb32d1mr31114106d6.50.1792852131533;
        Sat, 24 Oct 2026 07:28:51 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Vega <vega@nebusec.ai>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet header after POP
Date: Sat, 24 Oct 2026 10:28:37 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
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
When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
the inner Ethernet header in a page fragment after skb_mpls_pop(), either
on an L3 device (mac_len == 0) or chained after act_vlan POP_ETH.  A
following eth_type_trans() can then BUG in __skb_pull().

The Fix:
After the pop, pull the inner Ethernet header into the linear area only
when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
header and must not be required to carry one.  The pull is a no-op when
the header is already linear.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth action mpls pop protocol teb
  (chained), or on an L3 device where mac_len == 0.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - drop the pre-pop mac_len gate.  The pull is a no-op when the header
    is already linear, so the gate only avoided a cheap call (Willem de
    Bruijn).
  - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
    etc.; those inner protocols have no Ethernet header and must not be
    required to carry one (Willem de Bruijn).
---
 net/sched/act_mpls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..35a6d27f76a4 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -79,6 +79,9 @@
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (p->tcfm_proto == htons(ETH_P_TEB) &&
+		    !pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0

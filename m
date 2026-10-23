Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756772;
	b=Tt/QRr1voSxuXnYGMXwWaFiN1aATzBPyz2DCCFg0nv3HCtamp3EocZd9TH8PQsClzTEU
	 kiw2cPB46l3ghd5xzPAG4kfnPydYzqR6/GWleMgrOjKqVMqD1ROc/roATCGXHcHNx/fKW
	 pqBuKT9PS/0/iHUmTRXfkD1a+efgU6ooilal/jmBDhrImxJ2ZCAXkHJs353iL4VEVOL7G
	 0cUMasA+qTC+2NIbeW4n56aWVLt3m8RPAxAuFphzAyMXrZBQ+ZeWM0A0d6VjXpEup96TL
	 aQi+msWr9PGFwuDGa8k2oV3m/lxYQRDC3h/358i3ZzB6y2kH85rWe4MHixDjMtycWug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
	b=T1PRrA5myJapIfs9DLM0J/k6/42ncH3kRTw/0DnH9vOm7BqGDWKlulWIH6OL2Q545nnv
	 SGAmXrTM0g2D9eHf3QSBJwMlbXQPdjKVBP0DZyPNSxY+elkrkVXslE3HYf0Q11laxGyZH
	 h1MwfbuzGC4z1VPNaPo8uG2GxekIQywJXRMFzG3nwJ+5C/CRKJhVpQX1DRJTYAYGlidzi
	 JEoUZNZXD8omdlAZHEGm81rSy6h6L+b9zJH1hYNT8rHCxsScGb3QouwtM/gJRbGadMWvv
	 hjAcNZKHfz/gXv3nsO8M7BWnXmhq7+fyl0LD0QLjb3GI4ydyUZZnSk1jcwQdz+TDUeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WlBDFEvX;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE31606A325
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE31606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WlBDFEvX
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c162febb9so6402516d6.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756771; x=1793361571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
        b=WlBDFEvXmxoV1xS/mbyhTXLZEkaxwQ3qDv5DGJy8z2ZxD+99NiUCgwWhw3AzC8Ov97
         4jaJWgo9gobODLM9xSnvRYd/XYG95jDCCFY4TesUPnGWfd3KynBrsnhk74c54jo2PlDF
         Q6TIVvOgvAuqktjmSDw3kdx7F0y+QaY0TaHN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756771; x=1793361571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i7GpuJr4ODC5HZ+Y0j28aF5sIN7ZcXFv71PRMGw+8g=;
        b=f6mNpxrHSTStJTxWKNEyyonfMu38xwSKVa0V+gbumD+XBKXe/Vk4w/CJ+S4d61LT5b
         y3MuS9Gv9+HM996sGdZWwPwGsnhE4BpncYEG1rVP6N2TqFBpeQwime/yiFXMz3ShPQVq
         vGEBpfMnwOdzPlM9Wie3Xf4UZHAH9L+t6O7zUgIjCLKbQWEUD6Ovglg1AJcwrKDp3bJK
         rtZBnufXP8lC+w82HTxamzsdQmxJpHXKCkiCfwRVI29STxcM+Xcs3ASRZ4mxHE7T7cFa
         o188GFBEm0Ve+ocweDiiNrfwUq2yj+wVWVxDHK9dk2dnumIU/alVa6WU3IFOWOVy6IEF
         NsIw==
X-Forwarded-Encrypted: i=1; AKwUvBzJyXLvzgP+xIs1GWnXYWQH32hhzQx+0keGsTRsFM1Pqn5lWg06N1bKwcSBh6eG8rw4rxUP0QY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlOXf3/b5toHXa6mvPGh6NTWhRL9Ew1W+9J1ggu+0a6kHGxvLT
	i4TP1dCpz1qaux69Q9RK6vOq2vj3RY0HaaBWQLXttAAT9VPXpi7hx6WOl1/419N9Zw==
X-Gm-Gg: AYBFou1Jnys7UyPuZ6Y9TPKEYi2SO2sYGVTvWa5vMDdXyT1JrDoTNMsFc/lYUSvtAco
	hPvRD0MpwUVKoPPtDf1K6rqHZJ32xA631KRX9oEDnDf5xeNBiQ7fvBMLDxTxMh65gpsUmmNTvp2
	b4dXhBJ6JOnYOBVzXO7iZn3Lr6t6nxh6o1LC4hExEj0owtFDZn5TJ5rPNxN57Bd1tyfWqKf6ys8
	316zzcNiOWQ2w9R9SDB0iQS/61eKzZletOaLG6xDtUniN6/UX6BhTqloM+Xt/z9im7VyMZlKSWk
	COdp59P0L+AJAyVHWW0384IuHScECjfOgVyTk1blB5hpezP/Lu2DgaHSohFcIvq3O1n+dd3rjwM
	HCywKAKiczG5EG1Im+JV6v20+IGVrybWSxm69xNoaVkP5Y6BkZ4YIqrmY3CPZz1mqoMNDiWXPa/
	1Mg+ozQrEdGMJI2C7gTrXYcu0EpF1mHfYgUjkYqknomIq4q672DuU7l9GishduNGhxE0IeZhAeg
	ltWk/F1UTF6wnJ5jgJhek7mIUkRTPQ12umG0kl2Ndc5WIdPUZSHsbf7TKe4AKE8vG6dAp5r162b
	N7vPvTiu7CxJgxfLOEJMZbI42eW2lu6SZXM9UPSl6w==
X-Received: by 2002:a05:6214:3f84:b0:90e:8be9:c384 with SMTP id 6a1803df08f44-91c3a8a97f6mr21514976d6.27.1792756770125;
        Fri, 23 Oct 2026 04:59:30 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:29 -0700 (PDT)
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
	John Hurley <john.hurley@netronome.com>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet header after POP
Date: Fri, 23 Oct 2026 07:59:17 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
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
act_mpls POP can leave the inner Ethernet header in a page fragment after
skb_mpls_pop(), either on an L3 device (mac_len == 0) or chained after
act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
__skb_pull().

The Fix:
After the pop, if the original MAC header is shorter than ETH_HLEN, pull
the inner Ethernet header into the linear area and drop only when
pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when the
skb was not MPLS, so no separate state is needed.

Conditions to recreate the bug:
- egress tc filter on lo: action vlan pop_eth action mpls pop
  (chained), or on an L3 device where mac_len == 0.
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The inner header is in page frags; a following eth_type_trans() can BUG
  in __skb_pull().

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mpls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..5363bca892fb 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190461;
	b=EKAup93L1IUnscaoOE/SflqeLkP19/HDEdc/mQ6R7PN4raaALqWqvUxxrdF4IlI8wM5Z
	 X+E3zaLVy8e0XiaIc/ysctX6b2Fr2gFems7XI1QszP+rVN63YzKrqz8odK948Ut7mfvmx
	 pPQshwTY43deAJCMAdKrlCnviltBcAEeq7X6yljwzU51mRndOSucbPr+76X1arkAcoE1e
	 9MN2rtCfmiiryHHdh4TCSCJzv2y+Si9VHk6kySkNiTbv8ZP63m4yybU7RAvH/Gh0n2Ztu
	 R75NXA3UxPtfwXR/JXznudX0q93VfbALmr4N4dchZq5QH7ugaS+KX3pllvBMKyAkdhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2mAQAxNJCmgorWtFYC1x4ukB0tp8HVcxnxU1mYBs9GQ=;
	b=HGSGaACXNumUDuwZLLVjqUh/Bxd1KMipoY/BbpRVbH1YOZg+vkALFqhF9RmYQ3SSNDyP
	 Tt/ARUX6F69vQ9/4VhbBKnogL8MrwHPAyyBN92uimuTYnmCfmKSEHYrGvZQH8kCh7MWHE
	 Fo/51HrqRqt627K3k+Roffzr6Q8CREVDNjBwN9eOSiVv2lM6xZEhWch9od3hShQ+4VScs
	 1Rd3etiLe4em50PAk3thhaCMVQ4Ih6o8HECE8VJNcDqGHgK0MbM7MQvL+039PfQz85Ld4
	 +oz/sIyxopXMpRSllZ8C8iws1rByOrDkr7f126HhKF40F5Jn5kh0RxAihKsi44MlZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ds59fc6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A04606A33B;
	Wed, 28 Oct 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ds59fc6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91D31F01825;
	Wed, 28 Oct 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190460;
	bh=2mAQAxNJCmgorWtFYC1x4ukB0tp8HVcxnxU1mYBs9GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ds59fc6MMWMglh7fRHbOyulLCFSPawR9uXMzqF1bcvtJFAwG4FWblMy8HZbAa+pNU
	 W7J71hBfoR6quXsArwfh67ZURocLjUl9qVsT11Ob+6xmASSXwI3hhWuzepN3qiHETT
	 fYvqkWxCLLE9OM49er6vfM13uzJBzGyiczmeS7I4510DI5EUcAvoG9q1zPwBIc1qBe
	 NmO0gOBVmsE6v2L6UBeNndulSGmS4BAHkSsbRpR7GjvsgeL0n0woMwO5blewQiFZtR
	 VQp/2h7ghB27H87LiKQb7s1xSriLV98KQtwnh+C5Wb6eB6mbX1iS3igSaUab8x49fz
	 nRPc+MSV8xPHw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net v2 5/5] net/sched: act_ife: do not consume the inner header on egress
Date: Wed, 28 Oct 2026 13:27:03 +0100
Message-ID: <20261028122703.2093730-6-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028122703.2093730-1-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
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

From: Jamal Hadi Salim <jhs@mojatatu.com>

The issue:
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header, and the
device receives an skb whose data points to the L3 header:

- loopback_xmit() parses L3 data as Ethernet: the "ethertype" comes
  from the inner IPv4 source address, and the decapsulated packet is
  dropped or misparsed.
- a real NIC transmits the frame without its Ethernet header.

(The __skb_pull() BUG this used to trigger in loopback_xmit() when the
remaining linear area was short is handled by "loopback: use
eth_type_trans_careful()".)

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet + a valid IPv4 ICMP echo request to a local address;
- before this patch, no echo is received; after it, the echo is
  delivered and answered.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
[edumazet: reworded changelog, the crash is now handled in loopback]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece40d8cae6c96af86e2ea65be476bc..3946a9589bb8fcd296e6f1f9234c00238df4d954 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -769,6 +769,10 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
+	if (!skb_at_tc_ingress(skb)) {
+		skb_push(skb, ETH_HLEN);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 }
-- 
2.53.0


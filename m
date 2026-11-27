Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791297;
	b=c1BMyOvuUawB+LaDccJk7OMu3isznBwPBwczdkT8KiTfJLtYHpug8B4HAfca3CltdkxT
	 1yVD/99F1z7V1JnlLC6eMo8ifj/K3Xpz8rdBP6XcdcYXLXNm452ZwyDuBY/CYMN5AHojL
	 w6KK8GHXV/cW58L0FqHVQ2gsWiVWQVFts3FJo/Fgy1duWAgfP2RYB58fwSlPUKNKk1f2L
	 IZ720WM1bneUD1l6G0nlUgvJnsFOS0dTNBklFovBpPnbVXndywo+o0dLNmOxOEhuLIFi8
	 g7keab5YhDAma/Avij1ByBpcIelRcZpY/WfOtxtFYhY/PvKYFY8+nVUZVTC34+kJCjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791297;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eNFkAjbno4y7Z/1VpALLdqH9oGcJ8uDjkukkNGlh2vM=;
	b=Ky+B3kMLQvGg1dSxmj36UuOQuKlg/RjOSUuWXIgB7TQx88A0+D+IdxgPA/oZN2W2Cc18
	 F3Bnjzz13jpK0LXE0iGbRKudb5TTfJN0OUlaQqZMJ/P9jtJzAfaOiGp26or7NE2vwfwzm
	 QQvAa01nNATSMN7QjdjwoHfIEbRz0UzSK3ZhgMn1VvQQM+HDrcTRUtv3TOktVvr/TDDGm
	 Vh5lIalag3GO2YN9iv7RuRUNTf4rWmn1MjFRZ0feLZU3W6j99wgBbXkOoS70AV1i3lFTL
	 eCtAZ3iDbhK3ZaPSxk55uZrYLzASZn3DaMOr5MTQ6jDKIByO3ipVNeFepoMOrMT7cxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=5AoykTeX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H8iLryRY;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C9606A326
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=5AoykTeX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H8iLryRY
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A307E7A0547
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:54:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 27 Nov 2026 09:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795791295;
	 x=1795877695; bh=eNFkAjbno4y7Z/1VpALLdqH9oGcJ8uDjkukkNGlh2vM=; b=
	5AoykTeXULIFpI5NyCwtiNBNheKRaweLOBZtB9KG/YmIoMlNI7MlCplnwE/tCXO0
	NzRXPHfVhtG8ClMyNP6PhK2YJul9jmjlbYlUPLB1T2EB4Zp63HfTB262vkzQnFwX
	hpKNC/JN5IZJD0vquz1g9td9/M+IxgwIeANa0u5N9Yl0L2FxmewnAZ1mMQQl5syW
	vJ77vh1OJeREItW6Y33GOl5aEP0JcpnGWU2W5QM5btmGTXAW3fHfW8S7YmMMQxlr
	T1ijaqskOVE1WPLk/3zq3dvOYcXF3+OnGXnyBf+Y7J8R5Ib4s0++ZZ8Y2Iqhz8vA
	mJBgJRAueXa1DsFag/S70A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795791295; x=
	1795877695; bh=eNFkAjbno4y7Z/1VpALLdqH9oGcJ8uDjkukkNGlh2vM=; b=H
	8iLryRYYKh5Lthdwc8QCmcklVZprJ4Mcm+tl8Y0RF/0I8obP1W/JjKm/W8G/MmMR
	Q7VWslKpiSQfVwmFNHykUeypHSYAXeWYOYdrRe5h7iGO45ZLCcVK166uwRzq2RN/
	/cbMokHgawO7bdHl13EfbK+X6EoEAan0RSimp0HEYY218U6jnJcyffH9/4fKRoX3
	A8MVh7VQjNkZvxueRH/UTV1AuihGKExjd5YCfsheqoo0HZgTgakAlR40dTRmwKrr
	iAFJsH9q4K0JGv1QTRwuj4shlxm0WphNIwmidrPb+pA39mNiRM17srSWaaAPCwVK
	9+z/tWROxIY/BrIZhqxGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795791295; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iFUoMbCmpZjuMI8nS9JcI4e7Fw45TS8AbWWs+VvhvgwaK6n
	+Uw/11OUOwJfmV1DfCZKtm8l1qvEnWVysD5/tsJSz8uvW0VCqDkcBptVh9eo9Rmg
	ivbatefZ63UJYqWwo7HLg7FvbVfn1revSIVTJWm9pV+ec3D6EW15sl261a+TAtr2
	emp4a6E2aht8BtCxw8DbqARjAHMFrcKKEmVoqvH4QiAkg+wk6jeF9cMCU4gCqZMy
	rDfcdUff9C4T6FqTyQnivrs+f+VfuIcdLnNiWqm1OSEzg4tb3cqv6vw9+8Otvd7d
	6JoT036+IJah8fIGbdUbXdDa+Nh+Sq/I5x0s6lw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:O14HFgpzUonUGo4e6PrJ4suNs4Uf5oW6C0zb08xd65U=:qaHIQtuqg3n9qIJ+pTBEy2rVuOu0BJtV7WWeWIM3Pws=;
X-ME-Sender: <xms:v5kJa-1ksjSZJXgxKX39vvaBIlbDUV2eszoDZ-vaeSodRE-bMEY65Q>
    <xme:v5kJa3FeICDI_Lk_L8-EuQM7J0X46fSd7tHGqs-n8Ftxbtfu81Z1-rDcpCwW7FMsR
    o362VvTtHnC3Q7cmuTmBDWhNyOMJhfjRjMudQUflfdu-MaKG2fpUQt9>
X-ME-Received: <xmr:v5kJaxsljmQPTr_5jzoT2WZ9Qju9-r6hGP9ZrBhRHK4Fumrucz3637FPyw9DaZepOc7gfIfBSh96mK6lj6A-rR31bJOmyEds4q605g>
X-ME-Proxy-Cause: dmFkZTE6wGz8p24jHZ3rEI902l77ZyG0g8gNE43p/5HzTHLBTylrDK1kkx3q1aPuyMR0ew
    glFFO4pj4z8kZxTmMJmq/j+0yGC5mG/xYN2BO4b2V1HsAzSiBqqQxrrtyzZkmPTwrjPsZl
    Ut8d1GMmMQGKiKMc/rGSZ0KEAmu5p4ue1g470HupOW1N1kk+sYEMyIOl0XYra5YuccOJVC
    syJ+eFolKlvYjmqlvDyV6KP4qgQblyiEcHX3uKDPn2DX1U62J5KkdKNdjuMWGExBwPMM9G
    S5yZ00iZfWH9LxyhzrGATCoFj4/WY8/rKc/9dHjUN2442FbSVgJLvx71jNQ77xegM7FHJE
    s5Z7+btH2ZHAoU1w53PoPzJ81z7rlbdC8/bCQ9cbxgRRVkLAW3No4WmHTT7r0Q4AzHK/d6
    w5K3omrhBOWphYw/U4ZDOrvn7xws46SQJcJ5V9lUd68RHVGJsgXecdy0xI2JEcdO2ExK7K
    BiPeow2bjPenRw60JHTVjYnvoaaZMPf5rmiEIc+bNBgoInbM8PnE39cR7zndQXYdaMMvCu
    NRhVdIQxwNrSX9De/5d1Lr8VeBPyJjYcIjsPIQhvOnnPetZCJZkn0ZGdtTgA/M+mxnqnbC
    wsPnoX18jjXkA0uGFhiAmhDqWThaWOPYZyoEmgjW16kc92jNvn7BEbrTfH5w
X-ME-Proxy: <xmx:v5kJayofMudQfZnZ8F1x5S_tJ0--LT5u6l_JiQsX7JBb5Ojvkg1TIw>
    <xmx:v5kJawXDiSjsXPiTEdt8OH3VYUMCbG541-lRmu9aNxqp1kfN_Ctcqw>
    <xmx:v5kJay0N84h-7sYTyZzhHElDjc6QanLl_6GWa3-SuMK53E7MU1XTeA>
    <xmx:v5kJa9tNHdD_ys-hr9_MEmr-d0_UUKgPnuwc_Uzq1CbjXyqhx7Dd2g>
    <xmx:v5kJa5xc4jfgqHsAAmZBu4ZWCqlUDiiSsAFZb8oIeQNXWUm_7FQvOP2D>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 09:54:54 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 27 Nov 2026 15:54:41 +0100
Subject: [PATCH v3 3/3] net: atlantic: AQC113: Fix
 hw_atl2_hw_packet_filter_set for L2 filter base index > 0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-3-b5efbc124dcc@jannau.net>
References: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-0-b5efbc124dcc@jannau.net>
In-Reply-To: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-0-b5efbc124dcc@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4392; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=qaHIQtuqg3n9qIJ+pTBEy2rVuOu0BJtV7WWeWIM3Pws=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmzOmRvn+pT9enRbUWCfyr4bpzWWb5152Yxh49ZLgQku7
 0XuO6jc6ihlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjARb1NGho8nZ9jUf3Uz+3w5
 z0Hf5FXb8w/1Pi/PzWYy92v91iYfNpvhf5ZLAvu+G13LZ1vO7eTV9ZsRbX9as3Mnk8nS6Getl2v
 WsQAA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

hw_atl2_hw_packet_filter_set() wraps hw_atl_b0_hw_packet_filter_set()
which has no concept of `l2_filters_base_index` and enables/disables
filters from `HW_ATL_B0_MAC_MIN` (1) to `HW_ATL_B0_MAC_MAX` (33). After
commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") this may result in disabling filters set in
hw_atl2.c including the l2 filter for the MAC address. This results in
broken networking on Apple silicon systems with AQC113. The firmware in
this systems report `l2_filters_base_index = 9`.
Copy the formerly wrapped `hw_atl_b0_hw_packet_filter_set()` and modify
it to handle this additional complexity on atl2 hardware.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  4 +--
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h  |  3 --
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   | 36 +++++++++++++++++++++-
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 639ec472aa0d..608ebad669c5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1038,8 +1038,8 @@ int hw_atl_b0_hw_irq_read(struct aq_hw_s *self, u64 *mask)
 
 #define IS_FILTER_ENABLED(_F_) ((packet_filter & (_F_)) ? 1U : 0U)
 
-int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
-				   unsigned int packet_filter)
+static int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
+					  unsigned int packet_filter)
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	unsigned int i = 0U;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
index 5298846dd9f7..35c43762c35a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
@@ -69,7 +69,4 @@ int hw_atl_b0_hw_irq_enable(struct aq_hw_s *self, u64 mask);
 int hw_atl_b0_hw_irq_disable(struct aq_hw_s *self, u64 mask);
 int hw_atl_b0_hw_irq_read(struct aq_hw_s *self, u64 *mask);
 
-int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
-				   unsigned int packet_filter);
-
 #endif /* HW_ATL_B0_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 0b5a5bc420e9..89841612be16 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,9 +759,43 @@ static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
 static int hw_atl2_hw_packet_filter_set(struct aq_hw_s *self,
 					unsigned int packet_filter)
 {
+	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
+	struct hw_atl2_priv *priv = self->priv;
+	u32 base_location = priv->l2_filters_base_index + 1;
+	unsigned int num_l2_filters = min_t(unsigned int,
+					    HW_ATL2_MAC_MAX - base_location,
+					    priv->l2_filter_count - 1);
+	unsigned int i = 0U;
+	u32 vlan_promisc;
+	u32 l2_promisc;
+
 	hw_atl2_hw_new_rx_filter_promisc(self, IS_FILTER_ENABLED(IFF_PROMISC));
 
-	return hw_atl_b0_hw_packet_filter_set(self, packet_filter);
+	l2_promisc = IS_FILTER_ENABLED(IFF_PROMISC) ||
+		     !!(cfg->priv_flags & BIT(AQ_HW_LOOPBACK_DMA_NET));
+	vlan_promisc = l2_promisc || cfg->is_vlan_force_promisc;
+
+	hw_atl_rpfl2promiscuous_mode_en_set(self, l2_promisc);
+
+	hw_atl_rpf_vlan_prom_mode_en_set(self, vlan_promisc);
+
+	hw_atl_rpfl2multicast_flr_en_set(self,
+					 IS_FILTER_ENABLED(IFF_ALLMULTI) &&
+					 IS_FILTER_ENABLED(IFF_MULTICAST), 0);
+
+	hw_atl_rpfl2_accept_all_mc_packets_set(self,
+					       IS_FILTER_ENABLED(IFF_ALLMULTI) &&
+					       IS_FILTER_ENABLED(IFF_MULTICAST));
+
+	hw_atl_rpfl2broadcast_en_set(self, IS_FILTER_ENABLED(IFF_BROADCAST));
+
+	for (i = 0; i < num_l2_filters; ++i)
+		hw_atl_rpfl2_uc_flr_en_set(self,
+					   (cfg->is_mc_list_enabled &&
+					    (i <= cfg->mc_list_count)) ?
+					   1U : 0U, base_location + i);
+
+	return aq_hw_err_from_flags(self);
 }
 
 #undef IS_FILTER_ENABLED

-- 
2.56.1


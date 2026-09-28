Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E525012B0;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624008; cv=pass; b=SOXy6Iq3QrzC3zsa81+g+oX1kX5e5FoFVaCPEkzBvOifE8dzTlE275kx4OLhlEcigHSAHUDQer3vTOdVTl2K5cVYGpCf6zQwEABnp2KQJySXkkZvjQ4zos33FLcNEVmk+IQHVb0RZECcvQcvu6lSukfm4g6nPs9r0QD2XFOuqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624008; c=relaxed/simple;
	bh=UaRDfuAxSLeSFWSCwC4/ZIYOREY8EbdslQc6t+vAk1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlEzOAMikx0ITLsUtLPDltNaLO85/UBy4zdGZSdnU8um/JGs0y45Zxu9NF73413ZnQWt0RBUL9eLM1h068IRdAnhtPURtv+9UqOi7hQ5sCNwTQo0QrDarUIu9hQrpe+Jk0gSOSuxxed8eUirCVVcP7mfxOJwvHp5kqeloBoBMWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=O8lZrPID; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="O8lZrPID"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C335F201F19;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdQspi4ZnUaFM/twRaVX6FV/Ko0c102leBwxjqJazdg=;
	b=O8lZrPIDKUbAIgqiRQ8DlM/ZN9D5CcGYXMCRivwt0UstNFna1GzhKZsv5k2hVFG6BAUcQS
	2zl2jThZxvHx6tYDaKQwltQ4fLHDEtWCHiZGNzOoXIvHRIhE1KrJ7Oskf3ZB5d2Mf9gjjl
	LHc+E9aj+Gsx9idf6HlBhryNEEMENSL9k3FG3PBq6K5Tz4k/tD30q+KX7ILPYZV4CDqrwg
	lMliXjz17BQ0KVFlA9lhaLo81H/G9NdD18/rxUg9awtXEBoX/t9i8MXYMLKWlwGF6aVGtO
	k9eOuWLYXGVgVpaa4BKga+6isZPP1lxuB8ft7utkJXtgCjkrlQ1AVzvbUNzXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdQspi4ZnUaFM/twRaVX6FV/Ko0c102leBwxjqJazdg=;
	b=gnEC5KtATAnnVgi/zCoFurG621qKRk2FUsoPOgixOgE1sBL0futeZQVpUJioBDd+jRExcz
	8nO2sjvyRnu5eqifwVy5cHSTygaFBxTAf6R3M1VngoV5gfVGI7Xc3TJpY74YKyRCRy3S1r
	pEVwrRH738PWHDgYt1l3oaicsUiCCuaCpfdOVfMa9pWGOy7itvb6incEi4U4OgkenY+ZLW
	TI66e56s2UjsIfyso9YNAjkLl0jg0B1caKwhf06311sRmBYgSrOFS6zS4mzKfDome344QP
	MwJwrEEUYKR5kU3KzBLVXfEELUB8bsAuhICS8l9+IN7CFd+IKpSnwPywhJX8nQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=FAwe3ngpRnzlaLTtE8OJAeA5Y68MIi94YtyvyeKGtjmb5bxf3un8HOrhElCdpvmexHVofF
	m8Nk5srzaBCQ/m09WxyY1ODimLPciPIojK07OrWU8wJHXlDJ5+anPntuRc30RMk0PIHW53
	83I6DnYpoohctin23VCtiZuuJ3vz4/TRLCbU333OWaPez+jgPG0h/lGCrnp2xWYiPUjvhQ
	h+4yOxrnceT3ZUgpksNJChLvs05FXLzPSUMq5AtM9Z8nEwIzhh0XqczJ8JgfQNAABfvFjC
	vYFEY9mx2ZL9pjoWfoxDopPI81ipV6V8DLs0VlKWa/JAu5T/9p7ARzNR4Z0g3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5x-1q;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B7565B154B;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/22] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Mon, 28 Sep 2026 20:45:11 +0200
Message-ID: <20260928193312.553632-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() consumes the skb on all paths except when the echo
index is out of bounds. This leaves ownership with the caller on -EINVAL,
unlike the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: `can_skb_init_valid()` directly modifies `skb->data` without checking if
   the SKB is cloned or shared. Is this violating SKB shared buffer rules and
   causing data corruption?

A: The finding about can_skb_init_valid() modifying skb->data on a
   potentially shared buffer is not relevant for this (correct) patch.

   The FDF-flag write in can_skb_init_valid() only matters for PF_PACKET
   use: PF_CAN allocators already set CANFD_FDF. The write exists to
   normalize frames for PF_PACKET observers (tcpdump/Wireshark) so they can
   distinguish classic CAN from CAN FD at the netdev level, and to
   compensate for PF_PACKET senders that omit the bit. That normalization
   is functionally required.

   The shared-buffer concern only becomes realistic through a specific
   chain: a PF_PACKET sender injects a CANFD-sized frame, the CAN driver's
   loopback puts an echo skb back into can_rcv(), and cgw (without
   modfuncs) clones it for forwarding to another interface. Only on that
   second can_skb_init_valid() call is the skb cloned. By then the bit was
   already set on the exclusive skb during the initial xmit path, so the
   flags |= CANFD_FDF write is strictly idempotent for any parallel
   consumer of the shared buffer - no memory-safety or
   information-disclosure consequence. It's a formal violation of the skb
   sharing rules without an observable effect, so the current code can stay
   as-is.

Link: https://lore.kernel.org/all/54a3cc01-abcf-4a33-b932-39bb1f68cdd5@hartkopp.net/
[mkl: convert Oliver's mail to FAQ section]
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index d1f797d3778d..f414b75b5c0d 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -55,6 +55,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 
-- 
2.53.0


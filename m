Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0D379C21;
	Thu, 15 Oct 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029228; cv=pass; b=OjIOr+qCwgNzsEQYEbOzcVEd9JjTZcsQm3Siob7+sltWo4CcL1NOkoXXqiHyD06jl4PbHX5W8xh/8MJbAgmTX3HOnCkbT2CJxz7UaPTuMuM10C3LIVpWVunOlGFE+JXuXhrrG/h3caEYfDl93zn4y18HcyMC9QwDLHutIFAlXho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029228; c=relaxed/simple;
	bh=g2FMKl/lBmFvFo3Km5VSg4ir60Zngr53bIY6J485DyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLUp9GDbV6gTcGBjD7gjAKkgbPZRFjRpVD+smZjcQnQkcyQirzioDIVmefhAptof7LB59SfTofHn8Z6jbLtxWNIO85fgfwIJm6NMfz7+BkJAO8BaGYFaWWbMBagtv0t/QOC/K2dWcVsLlwitiKznk8aSyMt8RI7iXjUO6u6rw30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=c5eFi2MM; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="c5eFi2MM"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9E8A92027D5;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=c5eFi2MMyUKAgzisLIgwDsPEWPoMEGL7ZVO+1WDsqJY1Fzpb2O65pauq0wFRLROhW8LrJ0
	gIhnmDz7bnZMXXypT5QAPgWYPA7+EgmgdTGt+VqaJ20dQUgxoERd4jQX3a10Oj4umqrVcn
	LjCY5MNxKwivbfwbhaPgnm84t+D9UAreroWfgRB0UvFYTdGx7tDmUB9SQEjFBfmp2Rf70U
	10QNLmZoudswF5nCHTKm1UQO4eWKmPeiKyGHZV+8GWou9zE49kGX0jDd6ECG6QtML4Cb98
	83YmsSJ23kl+skZt+5p0PKMXgouIxcYktJYRSO97Lym5cqsSCSO2fm4klCtaMw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=cQoVqn11Z7NzENd3FJYvjXwsqJHMajko74pUs3j9R3WLhmdePlQVNahmnimRQ2JPsk0u07
	CBCr/XJ2LFy8knulTpfampZVeir6fK+bKqgLiwsL7wKs8XlcbrlHUIlEDJ7qdl2Ry928uA
	xVolCNYVo6Q7O1D8Tehvzy+a1VYfI97VVjeLLSu35FaZ77Zjwx/rMu8CO7qtIHo60Cr8WG
	I+pq/ZCHFDFGqkCIsnHGrdg9sJLd8uNKzLNjwoXy/HZqwRbmDDu0THJl1bmhsAPLflkfJL
	RlNJnfDGoDKFJ5pxhYx4SFK9O5id7khwsTRvhtMadNZMEYWgz8+NGi+w1iVt9g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=GQ+k3tnLBoO3lulV8olDG6qZmvf1EfyYgvc5BnMLPW7zYA+jxPutnbhjaf3vlb0ucKJwBc
	/f9RO6RXHXXu9B0BNfo603WTu3CJlStmoPyLqReRK/n2lclEfwBduSChQNeeVd9zEbFxdp
	p0z95joVKgljVs8cgV62lFzomLSdc5YhRlb73nQWmDumBevlj2HbpM7qSuztaC8No248uB
	4hABhdJX/6zsHXu527XAw9kqHMYAjdj5whX2sAK6AslSyflZnSvtu+oJUX9nPrQgMhSWIq
	+quh0mOI5McDyFZooG6CKi8jF2Bm3Kr3/8WEsfoKebYmuwP1HkMeDgJrWKGzfQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqR-1k;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4AFBF5C4781;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
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
Subject: [PATCH net-next 14/37] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Thu, 15 Oct 2026 03:40:12 +0200
Message-ID: <20261015015336.816543-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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
index 3e36c0368bae..738d5968dfa6 100644
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


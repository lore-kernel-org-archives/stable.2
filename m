Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661954;
	b=CQLP4i4zRrPLRlGg4e/BkJDxhWeplo1ijc+tXh7XRdbC4HCaob6rRjEF6EScn1wfYYBb
	 0JDz1RplBPPDNsUD1Bbj7idUer7mz7r1iPVjmDju5rKeFXud5uyrKOpqJ9Q6NreaD8DsJ
	 VALTBnrTjJRtiFbM3bZJ8DJaneQji3pbh3bliumyEhQfRGYZU0dFnCnq+v3qPxL5W2+1N
	 KdmIijgJURORwxrUm/ZqTU+Fnc1w4wCH39N4tCLz5zpYxzlg8EFgSjBlZdAoToE3URDXx
	 iPnOSHsGnz3+GZXfEfUf7dgMRCutRS2P/eeBJemH+nLf33S14ng9+PLF9oifJ2yEYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661954;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=MPcn+B07MjwWl48U+6kkKYJpZBnSouBnLfdeIiveW/8=;
	b=f5UMb4lfBHqJEVk6RiDSPy86ZglyRdNDb5oym1bl6mWjDJUm0TC/02hg3ZKBZJy1pB8p
	 8Npls6HtR49M6Mb9gRqwxbCQK1QeBrde+g6yZsNIy1LKLMu1kT6pakXgFx73DsHs2ltA+
	 EIyyzybAzCjwe4wMPy2pNv/8tNr3C/X4KKCT7eG3nPud79nyciH48QJcWzYVQz3MY6oKn
	 tTdx6Z6BBQNxx0X5udR/5jCFclrdTQo7+JfUjTyPlKRYt4o7sonEKb6ptSC/bVMdI0nGI
	 KIUS7o5pbRmG2A0JXGHMbTHK9DW2ITgVZaDwDxdS2QH3Vww5NhAQ5690cGebZd8SyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=G4WJWQWD;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223660A263E;
	Thu, 22 Oct 2026 09:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3223660A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=G4WJWQWD
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9LhF6B16zKnBg;
	Thu, 22 Oct 2026 11:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPcn+B07MjwWl48U+6kkKYJpZBnSouBnLfdeIiveW/8=;
	b=G4WJWQWDvKAsQWTzxrl8MTsoYJfSimjLY5MhS2DEc6Um0cQbxJJz7wCEyQiYZRsWjmir1e
	WFFZcTV4gF4H9jq++utgBCHhJEljcgwor5RvDxi49NVV/bE8iuk9OxU6n3NG18AT3mWQ4E
	tc/Fjw9ROrNdp9A7RlLJwpUbc9pwjry0OJN3DVdUZS9DWAxl7thnP1MDAZ1R3zd4kvVPXQ
	oC0fpnzoNykME7ePzh9Jw5FfggHm2V7kSW3ZXlk/l8ZcYbqV8J9JF7EUqM124kJJCCSjqk
	pztI7jrtfbAYgBVGRLgjtp9Qwv9cJ6E002ZZJ7svfZyHA4utMuzG7sT/by7Vzg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:50 +0200
Subject: [PATCH RFC net 5/6] net: macb: kick the transmitter on link-up
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
Message-Id: <20261022-std-macb-v14-send-v1-5-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
In-Reply-To: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=1899;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=5Z0ud4WyrI5qwf7Qm11+ThFk+cekJfz3YuSCjzXymPE=;
 b=DnlqritolN55nKpIS1HTsRk7AASRMQdpivNIZrQvkarLc+rCw8l1/4WhsoznSPM36Ah6tjfvg
 roI9dIsIpvGAzKBETuWEh5PE7K3BW9yHZScF0F5Apqj3EJ3xqJi2Qqh
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9LhF6B16zKnBg

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Write TSTART in macb_mac_link_up() for every queue that still has
frames outstanding once transmit has been re-enabled.

Frames queued before a link-down stay in the ring, and setting NCR.TE
does not start the transmitter; the driver relies on the next
macb_start_xmit() to write TSTART. If BQL stopped the queue before the
link went down, that transmit never comes and the queue stays idle
until the netdev watchdog fires.

Like the rotation, the kick is skipped on the at91rm9200 EMAC, which
uses its own TX path.

Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6e7ead23d0b7..3dfc7ffdd598 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -903,6 +903,8 @@ static void gem_shuffle_tx_rings(struct macb *bp)
 		gem_shuffle_tx_one_ring(queue);
 }
 
+static void macb_tx_restart(struct macb_queue *queue);
+
 static void macb_mac_link_up(struct phylink_config *config,
 			     struct phy_device *phydev,
 			     unsigned int mode, phy_interface_t interface,
@@ -969,6 +971,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 	spin_unlock_irqrestore(&bp->lock, flags);
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+		/* With BQL holding a queue stopped no xmit would issue TSTART */
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			macb_tx_restart(queue);
+
 		/* Reap the frames completed while link-down had TCOMP masked */
 		local_bh_disable();
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)

-- 
2.56.0


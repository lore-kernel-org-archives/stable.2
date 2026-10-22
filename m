Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661956;
	b=usjBdMlGQ3K5F9fk2bvh+tMup2hUx/2yS8eOfZkq6JoMFua30IeLHhW/6H2Q63Rk0n/U
	 oFn/JnKA4g4af5alINuHRlBZyMLq7y3qJDox3ctnxhgt724hUYL1hGfGne5c91F+BVMjs
	 wTn5PeHaTbeTUSheT2KX8wgGcqrk/vmV/eXq6jtUTLcPkItTikntYOv4m1wC9CtjAS7h+
	 KRe2S9wmymUJyouNlI+v2XZuHgzS3QhbnTQt4HYrMgy8gf1c2rSCWmfT4KIhRMrYvY0MD
	 9chq0aAdf6ZBt14OlpuRjsz5juz2Z/hnfMgZnPuucQeSQgEoqVZgsXCN0a9O5NSC7QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661956;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=kzmCI/l9V2ma8jVCxH+Cwual/NZUn9FFJRGkBx38n0g=;
	b=tT29hx6NzrtdTgpwhq4Z0/J0/QItaYml7o/AO67sIOVmeV9OlzgFNXX5hQ4y8MbqXRB3
	 pY4rRyWD+3AbHZs4R0l5p8gNRF66iOZzcuhDUNaHxZvSuoTlCiKy+BCkxiNedIJz3Lxf7
	 tLW9FOVieSLLMKqMWikaS5UqRlCSBud+xSwwCzV0wa+kEoTbrbsiPDcMTTeIMOUi1iUIS
	 n4FVZ2z9ydBy4jM7WMewBAX4x76hgv3YPnAqV1q8B7kjd3WJ19l4skeD9GrVaW9xNEM1v
	 qYou7uPO7R9vN+sJba6TOdPn+zFmDPI8/gG+7VkHmRJfPJPGlUWwxAg/kqWCuw43Y9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=TjmXI+Pk;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248D60A260A;
	Thu, 22 Oct 2026 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5248D60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=TjmXI+Pk
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j9LhB0hqdzMlCj;
	Thu, 22 Oct 2026 11:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzmCI/l9V2ma8jVCxH+Cwual/NZUn9FFJRGkBx38n0g=;
	b=TjmXI+Pkz2CvANQ6hct5or+XJz5wZZnOkel6pZJIq5+UmFnuH0FFyU0QswFVE021Wxcl5f
	xkemRv7doI3s4hylzTw7byq9vrY3laeXnvWPALea4V5+U7MvW4pIV/6Onwcwi3/gHjtQ2V
	+eUF0piYxI50TnOMjWKGRiXIzziFG946yfBMEGcF4O3UC6NqzxR99cHkCDF4kHwBN5qhbh
	0FGGO8C/A3wfJRNQNRblRh2N4CtMijfGvd07yTNfj7Ks2LdxGPfmXbctNMhTRY9Ivcw+WP
	hbiF3rgL+TyJaL0aKxdK4wyxNRoMKNoHa7vHGBcLwYrsVA9fMxMZJnuYDOQ8Qg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:48 +0200
Subject: [PATCH RFC net 3/6] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
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
Message-Id: <20261022-std-macb-v14-send-v1-3-9187bc545bf6@beckhoff.com>
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
 Andrea della Porta <andrea.porta@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=3260;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=Ry/7hRqGEZyq9b5C9wqUyTj2TzGBoxi3BglkG+4sBZg=;
 b=jFz2xGBPYsaKcJ/gPvFOuLGhNBL3/dpQNRNCmZQSLwMgDcU66Y9rnelgoPvvGP4x+RpMYHhK9
 bE1PcFle6uNC+JClpnQiO/ea0iXbqZiTXz9L1Tzj0iQfkqwZpBPFNii
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9LhB0hqdzMlCj

From: Christian Taedcke <christian.taedcke@weidmueller.com>

macb_interrupt() defers TX completion handling to NAPI, but when it
schedules the poll it only masks TCOMP, even though TXUBR is enabled
alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
left unmasked while responsibility for handling it has been deferred
to NAPI.

Unlike an edge event, TXUBR is a persistent condition: the controller
keeps it asserted for as long as the transmitter reads a buffer
descriptor whose used bit is set. Leaving a level-triggered source
enabled while NAPI owns its processing means the interrupt refires
immediately after the handler returns, before the poll has had a
chance to clear the underlying condition. This turns into a hard
interrupt storm that pegs a CPU in the (threaded) MAC IRQ handler and,
on PREEMPT_RT, triggers RT throttling ("sched: RT throttling
activated"), taking the network interface down.

Several situations can keep the used-bit read asserted across a poll -
for example unreaped completed descriptors still sitting at tx_tail,
or a transmit restart racing with macb_start_xmit(). The specific
trigger does not matter: as long as the source stays unmasked, any
persistent assertion is enough to storm, so the interrupt handling
itself must be made self-limiting.

Mask TXUBR together with TCOMP in the IDR write when scheduling the TX
NAPI, and re-enable both from the napi_complete path in
macb_tx_poll(), making the TX interrupt mask/unmask symmetric and
consistent with how the driver already treats every other
NAPI-serviced source. The pending TXUBR is still recorded in
queue->txubr_pending before masking and acted on by macb_tx_restart(),
so no event is lost. A persistent TXUBR now degrades to NAPI-paced
polling instead of a CPU-pegging hard interrupt storm.

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 97494933eb1e..14c8299cb7f3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1979,7 +1979,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		    (unsigned int)(queue - bp->queues), work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
-		queue_writel(queue, IER, MACB_BIT(TCOMP));
+		queue_writel(queue, IER, MACB_BIT(TCOMP) | MACB_BIT(TXUBR));
 
 		/* Packet completions only seem to propagate to raise
 		 * interrupts when interrupts are enabled at the time, so if
@@ -2174,7 +2174,8 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & (MACB_BIT(TCOMP) |
 			      MACB_BIT(TXUBR))) {
-			queue_writel(queue, IDR, MACB_BIT(TCOMP));
+			queue_writel(queue, IDR, MACB_BIT(TCOMP) |
+						 MACB_BIT(TXUBR));
 			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
 							MACB_BIT(TXUBR));
 			if (status & MACB_BIT(TXUBR)) {

-- 
2.56.0


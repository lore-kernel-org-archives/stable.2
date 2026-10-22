Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661948;
	b=G4JGlbzmpaQvd/CKQ5rPZFaW2hwfJycS73A9SGxN7XyFnFH+nD916gDqI6dG0Ln07jlk
	 FzOrz9FeiGpHBw1Ztx0SXbpOb1lD0Hm5aFhgIRh9DuEwBjol35ehII1Yvdy3HnsmiokRi
	 qBh5RQfOqPPYpXyfgeBguvZrb7J2/r0s7oSPDMsid82w3lGcDcjmc0CSJwLI3eWU8/CNU
	 Y3DNzKkkvVRZXDa5m6BukqZdYysaR6aKiys6ODDcxEUytKjvZvUEYDKKuHt7ENoBj3FHP
	 6XoS0NpJjTBHeTHK20AgV3KJlwfc4P5r6YAoO3TJznaowfNQadkYXxniqIVdRD7Q9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661948;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=DQQ6Ux9jXPPYVl3eL1qiITspn2MEQEJ2iHgUWM8g/LM=;
	b=M+wxwN9jTrnjN9C1yRG5VPWUNqBTSpvf7jxK2XWZxXZBj14YIbY7mXME2PmsujGxC/sy
	 W8Wzukk4O5nUCcJ7R1nAqwIYW//1dW8T5SXWJxJflZ/TpH0zBB6bFwV+E4ylbSwuQIqHt
	 3n0ZeFX92w7MJsgzUCtWBMeotWkNdOXXNZwm6WLEWzok2QNr16ZsRJY/foWIgvAmUPeEH
	 9QNi1TUhYN+tYvxecufscYepR/kPz2RGjYEXWf70MRSJzhbE3eufv/wk690RuRvuokEPE
	 xtV0vd6Ko2T5Zz+wY7+d9pr7AWD9EAXPf4FD8dNlakt2CUkF4i11M+iEAPNFdxPkkCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=UymfAfX9;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C1606A319;
	Thu, 22 Oct 2026 09:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980C1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=UymfAfX9
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9Lh82CL3zKn28;
	Thu, 22 Oct 2026 11:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQQ6Ux9jXPPYVl3eL1qiITspn2MEQEJ2iHgUWM8g/LM=;
	b=UymfAfX9PRzbKHIOEPe/VKBMbOH0baGrQoa6B9xchnZupYAkYr9RAX/JVh4EseZlkAV9z4
	i7YyV+7XK8u9QhfMnPx8Yc/lsLWZnrPJd67dI9iLJIHsPHrh7HiPmziDAIzl0Y90EaenOB
	nom3lTwZBJlbizxYu+Te+LhpeKpyju0qfOaT36QgO8nVTCe269M1ACwmTo4uV4mzuVPAp1
	EMpMhMCExjNLXe+YCXtltHwBiaKerqrTTeAwqreDQrz4GJPP98YI8pLCWpbMrxe252DMEs
	59bvoZFl0I4VJsG1EfWszJPlUaxHCe56kS4JfpImkiQvH2+7ZSg/N0r4phBkWA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:47 +0200
Subject: [PATCH RFC net 2/6] net: macb: reprogram TBQP after shuffling the
 TX ring on link-up
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
Message-Id: <20261022-std-macb-v14-send-v1-2-9187bc545bf6@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=2872;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=PVXdyWnGxC/U+cT1+etV6P/qyYxZAkjmK8bSnBlzMjM=;
 b=kGrSYFlMrLIcORqZZ7UPZaFYiwTWg0ekvlY8Sc8NpclG7BoxG6ZCvoDzUfwV/p+9DcW++/3XW
 Ac8pCcKPAU3AaYJ1Q7okRvv49oTE+lJDYYAZR7sF1oiggbWQKLRAsqV
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9Lh82CL3zKn28

From: Christian Taedcke <christian.taedcke@weidmueller.com>

gem_shuffle_tx_one_ring() rotates the software TX ring so that the
tail sits at index 0 and resets queue->tx_tail to 0, but it never
reprograms the hardware transmit buffer queue pointer (TBQP). Other
paths that reset tx_tail to the ring base (macb_init_buffers() and
macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
path does not, leaving TBQP pointing at a stale descriptor.

gem_shuffle_tx_rings() runs on every link-up from
macb_mac_link_up(). After a few link up/down flaps that leave
un-completed descriptors in the ring, the stale TBQP keeps pointing at
a descriptor whose used bit is set. When TX is re-enabled on link-up,
the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
0) and macb_tx_restart() re-issues TSTART, which makes the controller
read the same used descriptor again and re-assert TXUBR. As the MAC
interrupt is level-triggered, it never deasserts and one CPU is pegged
at 100% in the threaded handler, eventually triggering "sched: RT
throttling activated" and a dead network interface.

Fix it by reprogramming TBQP to the ring base on every path of
gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
macb_tx_error_task(). The early return for an already-aligned tail is
left untouched as TBQP is already consistent there. This is safe
because the shuffle runs from macb_mac_link_up() while TE is still
disabled, so the transmitter is halted.

Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4b5037867537..97494933eb1e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -823,7 +823,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	if (!count) {
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
-		goto unlock;
+		goto reset_hw_ptr;
 	}
 
 	shift = tail % ring_size;
@@ -872,6 +872,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
+reset_hw_ptr:
+	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
+	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
+	 * to write directly here as TX is still disabled (called from
+	 * macb_mac_link_up() before TE is set).
+	 */
+	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }

-- 
2.56.0


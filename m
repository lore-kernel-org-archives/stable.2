Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A93750CF;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346551; cv=none; b=DlpaOoGaAYtb5wB4X5qN1eoJemNu0OGES9ARkcVEfr85tbFgFYr7SndZ5QAL0A7N/LEYdpkx1CbCnLMTlbVfp1aQlGrYCNj+PZ3C16zW98sRSP5W6YsDNFj08oyCmFvEjNpPvIe9VyXTFmRr/NEYgkKQzG1lLRW68QXNEiuSnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346551; c=relaxed/simple;
	bh=jDQaGuHJa9ycuFv2OnHwG9zQdfvsyWvNp9UmIOQhU60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlZihpzwGx81X9JU9RMTL5yx8d6VyiF2EPWvZ+oHpGiC+BTb/+aLHQlxdhcNxmpks3Ohu4lnwgzBwJaIC6CmQ1Gum3n1BR/yzCsnOgSd0arpgVcCj4PUhAlzcr9Ll/zQMGi2pAMzSWZxtZs8qki958oKYq9cxOtYtUwGW3uEP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGymLJEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGymLJEy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A350C2BCF5;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783346551;
	bh=jDQaGuHJa9ycuFv2OnHwG9zQdfvsyWvNp9UmIOQhU60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rGymLJEyswmCbmSytPwKnXtg1U9IjmLQ0j4/DD4hwnmT0GSwtcC3TXVZn7sNEbT+1
	 BNEf1XubPRGCAO0OgHiFy2KXfIW1oFDRtLhqyPnoYxtF4+3VNqpJEpaGfi0M+0vfNq
	 PdgusVWb3Wd0cYUUc4DC/+/McqZ8O8U2ZHjZ2YB+3FxnV6Eb9XnK4Pn66Vn3iWHhBX
	 WETV5SgjGuTx8BxkJAYDF7qGHJ5EltKh3jDojZJ9uIYs53nctV7l/ts4A2DG1+LqPO
	 ORh01879L0XX48WHgYemoX75Iwk4ggWkb9wI8Y8/N6RuS8Zltcs1G+TPViIOO5RPK3
	 5/F90+NQN88uA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49387C44501;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Date: Mon, 06 Jul 2026 16:02:14 +0200
Subject: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
To: christian.taedcke-oss@weidmueller.com, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Robert Hancock <robert.hancock@calian.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783346550; l=2872;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=H15tV2WNXlEeiA35QduT20PmtQLsXi8wSQpnaTH6KQM=;
 b=eQ8abbcaQIhIYzqDk1BVu0/b83QpqD0j2q+jiInsufeXTYDW8TEKd1RH0P/Z47bctMT9ExMBR
 cbEM6cfeVQWDe/eoMsQ1Wmjj6GYgIEMTvVArsiqF+sJdsh+NYrqBNfj
X-Developer-Key: i=christian.taedcke@weidmueller.com; a=ed25519;
 pk=fVCoBhFV3uMogA2nxIOU/rynNY+O2TDJgWvWjR06TrQ=
X-Endpoint-Received: by B4 Relay for
 christian.taedcke@weidmueller.com/20260702 with auth_id=847
X-Original-From: Christian Taedcke <christian.taedcke@weidmueller.com>
Reply-To: christian.taedcke@weidmueller.com

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
index fd282a1700fb..b11cb8f068b7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	if (!count) {
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
-		goto unlock;
+		goto reset_hw_ptr;
 	}
 
 	shift = tail % ring_size;
@@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
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
2.54.0



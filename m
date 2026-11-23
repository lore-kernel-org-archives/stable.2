Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427756;
	b=orh/HpU0EG84vpFTAtREBG9x6UV5gmtm0rSvEF5M7Qmb+VUnJpkD8DI9z52v5wY5/+Qf
	 RP2sFfrN/AwveA23TrcQ3Z8B+qeX10G4ZPXo4NQIo1yiY0bi+8xmNOow5i/3ZW2sVP10A
	 3HGVRl7O1BIRQapvDesw1AZLkGhhlPeNZSe5PjKAIKN4RI3a9MtPlUyqN2JbFKKIsGfsh
	 nOccoalQbjZLKLpF4z4xsulHBp6oUF5JBgRLPE5hXuBXtVWrmyzQZVfwy9DQt0ZmctT5e
	 Sh3pCAUtYBF9bJfo9Mf1AeLgbCdJrgrKZtjI6f0ao9Mt1uI52h33bEo+RkxqkJruTKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427756;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=bEpIf88Bd6lcTR9zfzufaNRnF9usrLgoYrUbzb2lfhE=;
	b=H5uIilLLHIn6q7sBbX7uatnzQHZO1BWloi0PdnZuRH5ayNfIHAfygsHxN8sgzPMZi9V+
	 ytf+iubHNrEh3RXgYI6VylvM807AwjWLkTi4Lm5/GZ2ePird7VcXkVeeErADcQbHdVGvH
	 DWL8GDFzb7CK/q/pkWBrGqXLPzygeq/0ag8GaXcNPw3hvuSmaobLO21meFXAz6qxxj43k
	 RgtFEsBOriiyDAJuTtENT6VTm1F3KFpM17OASoZeyU4NdUs9F5po6/F3I9DgQUtQi+/1X
	 3vptzhsvf/2UDGtUVqBdDpepMhoZV9OBpJ8G+LvqMKvZQYMoSnHQU4KDNx2iPRy2sBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Y9ysuHnt;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F4606A33E;
	Mon, 23 Nov 2026 09:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E0F4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Y9ysuHnt
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jY1Xm5C9dzMlgh;
	Mon, 23 Nov 2026 10:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795427752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEpIf88Bd6lcTR9zfzufaNRnF9usrLgoYrUbzb2lfhE=;
	b=Y9ysuHntcZr/WuV1FN7G9XOKaV9MwE9QBnxdAjOysKRf7VwR6PJxOwLKxUxpnj/7x8pBIK
	46JMRw1jfqooqNjoTNACt6vM/DtzHd5a9R8ogsc5xpZXby2xbfRxLa6p8BHBb2rP4cj1ta
	xflqulWQ7fj7Dtz20GqogRZWC/oGDqwfykV5CcGWmAcgwSqqlC4YASyRfI7OZaYFBt8EGC
	XYOfVxmUlfnugzA2QOwQCJ8wlLN86jI3L9W01ctUiDkHthslKrBicfR1xEg94mcS4qlm2n
	h0FVop07MPGcqBQs0Lv+ybypsMyZr+K3kKrV8S1bQyDsY+6nkthVM4HWLkYD0A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:17 +0100
Subject: [PATCH iwl-net 3/5] igb: let dev_watchdog reset the adapter after
 a Tx hang
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
Message-Id: <20261123-e1000e-tx-hang-v1-3-ecb4309942f1@beckhoff.com>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
In-Reply-To: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2327;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=kUAgDpH1g5eruMkTh7j/zlD+tdNUXEhJeF4Te0NE57c=;
 b=7q9oPPB6+vOKUJdNZ/0FO9hSkalrOkgPaS/zyYRT1rxRiLlwOTPyi4s0eVSZyGv5KcFpcRD3v
 5/b1b2sdH2tCwKsEVw/OL5SezW6Xa45sNKMQDXtZprZxLD14L6Hwsrk
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xm5C9dzMlgh

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Like e1000e, igb stops the queue on every Tx hang report and relies on
dev_watchdog() to reset the adapter. Since commit 95ecba62e2fd ("net:
fix races in netdev_tx_sent_queue()/dev_watchdog()") every stop also
writes trans_start, so the watchdog timeout can't expire as long as the
hang is reported again in time.

Until commit a22ed15c99a0 ("igb: Get rid of spurious interrupts") the
igb watchdog forced an interrupt every two seconds, so the hang was
reported every two seconds and the adapter was never reset. Since then
a report needs an interrupt from traffic, and the adapter is reset only
if a stopped queue sees none for 5 s.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested on an
I210 with the Tx queues disabled through TXDCTL and that commit
reverted: without this change Tx never recovered in 8 of 8 tries, with
it the watchdog reset the adapter after 15 s in 8 of 8. With unmodified
interrupt handling Tx recovered with and without this change.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 131df3e09ba1..0aca2e70087a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8484,8 +8484,15 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 				tx_buffer->next_to_watch,
 				jiffies,
 				tx_buffer->next_to_watch->wb.status);
-			netif_stop_subqueue(tx_ring->netdev,
-					    tx_ring->queue_index);
+			/* The hang is reported again on every watchdog run,
+			 * but stop the queue only once: stopping it again
+			 * would also restart the Tx timeout, so dev_watchdog()
+			 * would never reset the adapter.
+			 */
+			if (!__netif_subqueue_stopped(tx_ring->netdev,
+						      tx_ring->queue_index))
+				netif_stop_subqueue(tx_ring->netdev,
+						    tx_ring->queue_index);
 
 			/* we are about to reset, no point in enabling stuff */
 			return true;

-- 
2.56.1


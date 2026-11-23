Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427762;
	b=Yx7V1/kVZ+YAvv9WW7NSriqhaNY3wGc3g3jHd9aQL1b3ehXq2emCTL0AoH+VFVjOJ4Po
	 YpBswHotqKF15NY8n6Q8QiWQzgdX3PZJv6A0JoUI/ZBha1zVKJpDp0lRAGoi6GZBnVdme
	 104yPdwkpLU6Zc+YHSxEew8TlQbDpXqP+78f7LIQnPvPnNTqedG1nLwMZ8w7igyNi/x4s
	 rmiLYPg/b41SSlwPNbGloMhrO7CJUWG+Pn9SFS9KOlIfkuSKu4RS6ukE36JlNkdTg6cHe
	 SJoavB7696QyIHYMsoMi+AFPNx6bz+ZpfSBvYvCRM6fSVowbqxHUU60fL5ScOpOkYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427762;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=QmVkY0D1iugOAnFAYa2JnBEt+O5w2UV3yLDwM6Do3wo=;
	b=iWwuI1dsbRN4F/47iuxn2zoOhhn04enuSbSPOaV+f84iLhWUMG1TZN4Hfoa5/mFtd6Pe
	 TAC7eDgb/qQvK5jmXGURRCYuJg8DzZfJFg4CrHd7pLdonNpTt7sImEfvIdxm6yxzL1Iwv
	 f125lljWk3i2074Jny+7zMBSFaeRIojZ5SzceoHbHC702QZsn7MUltsIYNsXxAEMr6x8R
	 5/rF1fOjYqGtIc9+HnEDmniFHd6hPOJweOzjaNuln07MIzrv7s5dtn6c41omwJlHsG8s4
	 kaBXLzLKoXvO0uZvoyh2Itwb15AI21E4byDN9tOOccaVbVU5v3VCxwNnedsPmmgxdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b="NM0GSes/";
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA33606A686;
	Mon, 23 Nov 2026 09:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA33606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=NM0GSes/
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jY1Xn55VLz8v21;
	Mon, 23 Nov 2026 10:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795427753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmVkY0D1iugOAnFAYa2JnBEt+O5w2UV3yLDwM6Do3wo=;
	b=NM0GSes//QXNxRW0kJJIfeWJbCEiU5+Bzsov5kmja9Mn1ntPLZHYOeOprqoGpVuXHEhOUS
	8BaWS1zjyuePum3Ip7KHbjCVAsTJr+Tiowj59GQEmDprmZnfJgRZb/fmr8/ZmQSHn1/IP7
	pl8lRwW9TGIxDdJUeR/39FH1eJBgIlwnFJMKevHZQGvrwr6tLrpU0UB8JAmIRDFl5ijCu9
	KxiKiYZj58KpUZ5/+/LoF5li85zAOzj4RIsyGePiA2XlV+CPHzRIYh5vULRDCmpKavuKOS
	ACBX2UwdNenb6kTx7DqPMzxpkgrnXFpUy1Q/i/VE6LZlGlVpShJD3eMqgYvmOA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:18 +0100
Subject: [PATCH iwl-net 4/5] igc: let dev_watchdog reset the adapter after
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
Message-Id: <20261123-e1000e-tx-hang-v1-4-ecb4309942f1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2381;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=4g3DPsLitWHXFohTOuhHku+cbWck24n8+SNlkObQQIY=;
 b=5LDOPqcYvOa34lnT0z+fdHRrcuGJNdYPI18Z7XLjpbHMsow1VF2k6vtSBKoXoSQQL7fai7d6V
 DHCBPkgjeVmBxYqCZX4Alketx9gPPVCRPK0Ebtwy8kJOxxNfGKOHSJT
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xn55VLz8v21

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Like e1000e and igb, igc stops the queue on every Tx hang report and
relies on dev_watchdog() to reset the adapter. Since commit
95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
every stop also writes trans_start, so the watchdog timeout can't
expire as long as the hang is reported again in time.

Since commit 8dcf2c212078 ("igc: Get rid of spurious interrupts") a
report needs an interrupt from traffic, and the adapter is reset only
if a stopped queue sees none for 5 s. The 6.1 and 6.6 stable trees have
the first commit but not the second: there the igc watchdog forces an
interrupt every two seconds and the adapter is never reset.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested on an
I226-IT with the Tx queues disabled through TXDCTL and the second
commit reverted: without this change Tx never recovered in 8 of 8
tries, with it the watchdog reset the adapter after 14 to 17 s in 8 of
8. With unmodified interrupt handling Tx recovered with and without
this change.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..a2d383f79a29 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3281,8 +3281,15 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
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


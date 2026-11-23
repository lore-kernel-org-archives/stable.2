Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427758;
	b=VDWbu8o2fQzXqJe/BD1ERgUrTM1VCcaYzkjW29vG/mMPYNwHyYZO5NZtf8CvIxguXPst
	 reJK9l9j48TiJImZpRfVlmTMNPFZU/PMiDxtrr3sWfC2eZDFX2fTn8qxoHlT/cGjmJfHj
	 6J5ueFIa+5a7tI7mKEfCQZ2q/Nw+4EzQcsxrcaxzyyoFT4PdmgoSaBizn5RKjp+ILFQEK
	 4g9oD4/jMBTmY24IBLp41ESitF/kx29KlUbgMh1SMEtpJLr0sp6qknXiqIm8qMWl65Zv8
	 QpHUhoyXFZfEX0SeqUu1e19KtgRBTw8rmxUr6eO7D+3zG9btegNrJYXUvlQ52fja2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427758;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=kgQy8kI1WAfae3VeBA1HoTkyi/BnDiuRcwu0gm5ZbYo=;
	b=ewlB+ueJ29G3xw6w8XyAoM+vLLsPqMdFxYqbFwGPwFu8hbbaSXgxyWHd4GA/uURqsfyP
	 wySALHqoskgpfppBvMKrEE0RvcaFHT/e8CswcC1VKNLHC/lwRXgA0kejpUeiDolw+ROQU
	 cb8vOqe5Ju6CsbwUUQ/7vMJ8FIbNqy4nn7OB8xUbz0+b3BEr8SFhuKHFrtKD7Z1kD9ECM
	 +yZwkmgIl//IpXa+/SpWEcH63QcNM8MOsIvyj10ONhPMGeYHOrQRtx3hDD5ydrEhOen6s
	 c/rJl/1gnA5/sFGaoDhq1M0cRldBuNtBLOrxZFl7h6LaNNZCctUh5hM/UQXgB2R7aYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=kQ9ePvJu;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257D606A321;
	Mon, 23 Nov 2026 09:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0257D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=kQ9ePvJu
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jY1Xp4gJqzKnkf;
	Mon, 23 Nov 2026 10:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795427754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgQy8kI1WAfae3VeBA1HoTkyi/BnDiuRcwu0gm5ZbYo=;
	b=kQ9ePvJuOv4+8u5xfnd15Upcs/9of1EYYOnR1r4tnas5mGT01hAxFMWTnBxlS6vBsSNQhp
	0Jyvl3NpCfEXe+tzcwJqFFVTOGn+ZacG1x68wQWcFDCqWCZ2lK8s4MRqZCTgqw8HuZ8bzA
	Jc28baNLetkuXi7wMHh39xUvKOpQKfYbCeAjTQIB+FSY/lPJBwwC85kFxXDjgyjkgc2R3m
	Jvsfzol1NzL99UkwV3VuyaxkvJDbzc5618oFwqdyeBGgK23Thht/NK2ZxvwA9wosi2Wz0M
	0IeSnIBF4wd9aoJnDJXsxjgfSiO3L3pdwklSl+/1eiUvWVG6OjK8tpwUUhEx8A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:19 +0100
Subject: [PATCH iwl-net 5/5] e1000: let dev_watchdog reset the adapter
 after a Tx hang
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
Message-Id: <20261123-e1000e-tx-hang-v1-5-ecb4309942f1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=1831;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=tAhjnxZ+dbvOeKDQs3b/TeBRTCKUgjX/tmh/fwujHm0=;
 b=jW9mhcUt1h/dP1vcV4WUmINwKwO6sAH882FpC4dHyMNKa8cwE9uOQtPQmQFNmu2rEmOPGKFAO
 uNn/aed9jA2BSYXXPHsn2AMHZl6nOp69jgYc6L9zzcxUYosANFLVNqe
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xp4gJqzKnkf

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Like e1000e, e1000 stops the queue on every Tx hang report and relies
on dev_watchdog() to reset the adapter. Its watchdog forces an
interrupt every two seconds, so the hang is reported every two seconds.
Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") every stop also writes
trans_start, so the 5 s watchdog timeout never expires and the adapter
is never reset.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested in
QEMU (e1000) with TCTL.EN cleared to stall Tx: without this change the
device never recovered, with it the watchdog reset it after about 10 s,
in 3 of 3 runs each. Not tested on hardware.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7e279b739b8..4858c0a8c7b2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3925,7 +3925,14 @@ static bool e1000_clean_tx_irq(struct e1000_adapter *adapter,
 				jiffies,
 				eop_desc->upper.fields.status);
 			e1000_dump(adapter);
-			netif_stop_queue(netdev);
+
+			/* The hang is reported again on every watchdog run,
+			 * but stop the queue only once: stopping it again
+			 * would also restart the Tx timeout, so dev_watchdog()
+			 * would never reset the adapter.
+			 */
+			if (!netif_queue_stopped(netdev))
+				netif_stop_queue(netdev);
 		}
 	}
 	adapter->total_tx_bytes += total_tx_bytes;

-- 
2.56.1


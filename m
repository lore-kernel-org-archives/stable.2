Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427761;
	b=UlWtxRkwJgCWoxJkV7m5+PjjbMuIMt56sjeR+LMBMgJ0bTUx5aPwTtXA3uK1zH7RemdG
	 gJe1InL0QG91yFm8X0MenQ75c7VjF1RXQ0RRBnu23tSHMwKvlJTpaSyu6gSS/nX6/CQAI
	 nVye5usaqmHK/XKEZkO7wQdC6Ql4e+OHSHKFTIzpY/2xlPpH1ENB04r11VNj7G8ZsFDL6
	 wZRIcEUZjZyeusjlXwC65FmghcHNa/mk4mJ1ya3i3XPnm9mAGeG8Mm1lZMPUMcvALh9SI
	 WJXxbVfCh1qDQ7u0przMHNQYVxEMbBbzOGUq4e6jAuCpij9iLNtjlZVhvx9bLv3Zybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427761;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=WL5R4iHTKyqUmYt+PndBZojbg2VKGSQ09Viuh54Sxo0=;
	b=Nco3ObwsGGwKHAret+0towvJ29hlo2fLAsXHL7iGLLU0dGs5O5Ll1Vzi0LDJybI0FqoX
	 NHAk+lHpRmqs/H0f2N7JXhfvUXDD4vgcw4QCx9P0TJscgWFBdocRjRcDyUppqDnALHDEG
	 SgfvuWE59RO2folqZe690CLUwIU3+gpOUOL2kSkMGPfnfnpwuBqNysihU/IZxLeOTHOeu
	 LLmO5Yw9bIX0TAKwS2Cn936ZMgjw2tBzr3enB6dDf56yUN1DLc+ecroC+U0UZmYLXOHUF
	 OulDHGWwmPElgJYzYi1rfjwovz58HZ7pFr01WQChBXX14Um2NjfKmuRN52KF7qnKiAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=amWI9P9X;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B0606A32E;
	Mon, 23 Nov 2026 09:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681B0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=amWI9P9X
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jY1Xl4knzz8v0b;
	Mon, 23 Nov 2026 10:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795427751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL5R4iHTKyqUmYt+PndBZojbg2VKGSQ09Viuh54Sxo0=;
	b=amWI9P9XuEyeCuBwnxQIFyoi8ncYSw9TlWJVNEAlyfqXk/vVFocfMitycX1MHOHQSTnH90
	IbcrvlccZYxu/4tTCr6J9w+qCqFNOF/rmE5G4zkqSi/7PdddDfKHNW26PyYcYgyRdVIlZx
	3R9DMnvPmIyPgLWs91mZ6JiqxkCevV3z3gIAJID090LgsMupNIhngFno5W+qgqmGGmA5HW
	MKJ3DEPwutcOI3X920jamimsLQKaM2NKvOrNYrgKm7yldQTWsvYhucUkQL3TI4gOHzhGTe
	49DEKSE9OiJShNDzXV1I0Md2TEECpUPVzDoU8BUe6jAsmuMuLq5Txfg2GsXuLw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:16 +0100
Subject: [PATCH iwl-net 2/5] e1000e: let dev_watchdog reset the adapter
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
Message-Id: <20261123-e1000e-tx-hang-v1-2-ecb4309942f1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2275;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=0TafWYGRwlZ53tYl0ky61zeXbqbv+riYcpx3ZxKtx6w=;
 b=AOYdFSIbp+BieMI2SYWa9+otd1iG7wrUjUfS5Aa7sESWLnTnqn3ubS/nN6QrMWA23l4RwSq8k
 DuFNoqKi3WwDOP34ESb54sDs8oBwhlGmc7oddZLtq/HDa5NsJD1VcXt
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xl4knzz8v0b

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

When e1000e detects a Tx hang it stops the queue and relies on
dev_watchdog() to call e1000_tx_timeout(), which resets the adapter.
While the hang lasts it is reported every two seconds, and every report
stops the queue again. Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") netif_tx_stop_queue() also
writes trans_start, so the 5 s watchdog timeout never expires and a
hung adapter stays offline until the link is cycled by hand.

This was observed on a laptop with an I219-LM (8086:550a) running
v6.19: a Tx hang lasted 104 minutes, with 3120 hang reports and no
"NETDEV WATCHDOG" message, until the link was set down and up.

Stop the queue only if it isn't stopped yet. netif_tx_stop_queue() has
to write trans_start to close the race that commit fixed, so it is
left as it is.

Tested with error injection: setting CTRL.GIO_MASTER_DISABLE stalls
Tx. With this change, I219-LM devices (8086:15b7 and 8086:15f9) were
reachable again after 11 to 17 s in 24 of 24 tries. Without it, an
8086:15b7 device stayed offline in 8 of 8.

igb, igc and e1000 stop the queue in the same way and get the same
change in the following patches.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c..e916eba19fe0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1144,8 +1144,12 @@ static void e1000_print_hw_hang(struct work_struct *work)
 		return;
 	}
 
-	/* Real hang detected */
-	netif_stop_queue(netdev);
+	/* Real hang detected. The hang is reported every two seconds, but
+	 * stop the queue only once: stopping it again would also restart
+	 * the Tx timeout, so dev_watchdog() would never reset the adapter.
+	 */
+	if (!netif_queue_stopped(netdev))
+		netif_stop_queue(netdev);
 
 	e1e_rphy(hw, MII_BMSR, &phy_status);
 	e1e_rphy(hw, MII_STAT1000, &phy_1000t_status);

-- 
2.56.1


Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C83AD51E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882407; cv=pass; b=WwybKRzkKeuhgWsaNA4jU2ikvpHJimgKhCORLeoEseoN85NdzRHBfXPxPKf/Zr/5IzgxxhGn0HsqGfJa303wpd0LPLhtmLeyhQWbJMp2i99EZqxD8MmnVukOlWBwVaIBJVJoKhmlPjwO/kMEyJdTKN7KX9TpGVQu1I0HzFztEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882407; c=relaxed/simple;
	bh=eLw9MObynlKnsBj5IMC3FJiovAkRI0YjCd7w10Ftek0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlEMiG6AgbyAEOMAXhgQT3fOPHXOMpqy6ErUH4/kc1rJFdV7GK/7qF/vRz1UvIFW8u/9izI9Cyg8J+TsyNMyUh4MIBStlOwuXKO7M38QLK4MxbXUY6TFnuGqA+EcEFR0r+Ph8xAEQbMCKpHP9nfx3JHJJ2PyczC+9WGFVF3dd/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZXgeHt/t; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UsuQzJOg; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZXgeHt/t";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UsuQzJOg"
ARC-Seal: i=1; a=rsa-sha256; t=1784882402; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oqvQseAX+Denc+E1myZHMvID8Bz2+FRj3Cujgdeh2Pj/knVf4ZxlxR87aBGGcTqCJR
    6X0M3ditaYCyZO57kWVZ7hXQ7F4wT9Mzquf9vSCEFs5BIFdzvO3OnTWdBhShDaea7M1a
    BYbzO1OE23/E2vFaKcezQfzDXdvrxrzFZeZEN8nwlgKf8y+BeeGt83VTx0ihEU7BdMtX
    yUZHecAtImJbDcfirEVw+nZ87UmeQ0KMYt9oqHcS21q/vy5GQpZtS7Lc9gxvYKLCRcmU
    2masoFujH/r0cW2XfpBmtflUm7xnLLgnvf1k7eMDfIf5SdpxYnoagz1WWKSLzaQqshly
    g6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=j0AjP775YPPijilYmt2EB1E5z0jRdpe6h0P1NlI7uRzN9dTd4OBPhkaDtHgYxmf9ZY
    AHLgjPbPUuEWVT2+M1vsTx1irU0cH2WemYkJmQydapunlO06dEDoBG9dQBvc5B0zQetj
    ij/Jz4hz46KYWi6gULaEYoYinQNlB8ABEU0AVNx3fwrMKYKX+TgrE9hPSL3WNKukTZDU
    Ev3gUKcF7s/OFGvXs+OkjZXb6sYjSgPVYPHrh6gZcVTnOmnvM0CkDNVoqVDKLNDBF5NF
    SBuWRs3PA1U2ZfIxpau+ObpFDQiFEm51HcdIhJJ1nfzhJUe+i3CNdcJkW5ZVMP78blzH
    oqfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=ZXgeHt/trRPv4Ovx6KSXtvdBSfbNccAzd6SPx4o+7LEzKXM2Fpz+YOgIEIFt+F9oNt
    UqK6V0NX5mjR18FY0LTP3tpMdvplREPKLm5PDmwZ1BpW5P2Z0Pnug7QeF3Vme8+zXurC
    NlbjECX61Klgjua6TzzhaG2V8f4ArGFPuY3HFiSBDVkHNMtuX1wrhV1gwOaCXpovdgAB
    ZimUbDVj84yI5CApfVJYZ5yxaNWiSiBKT6HFJELzFdWTeaWZNt2ZcevAuf3rCJaoV4sF
    a3ntMepZKeRXuMCYOkBqde5G1p9ayJfZU2nl5Qyl5FrfNAfE04B1XsRwbmKluORl8SJp
    r1rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882402;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=UsuQzJOgmBpdpzO6ricPTIb3WgsDbH0LFDtK67iX0a0bdbQ+Wz224dmtsxeQeDKV9i
    o65p38cKKPMzvPeyNjAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e2rVF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:39:53 +0200
Message-ID: <20260724083954.12817-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072057-sulphuric-stumble-eadc@gregkh>
References: <2026072057-sulphuric-stumble-eadc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 58fd6cbc8541216af1d7ed272ea7ac2b66d50fd8 upstream.

For an rx op subscribed on all interfaces (ifindex == 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

op->rx_stamp and op->rx_ifindex were written before bcm_rx_update_lock was
taken, allowing concurrent writers to race each other - including a torn
store of the 64-bit rx_stamp on 32-bit platforms.

Beyond a torn store bcm_send_to_user() must report the timestamp/ifindex
of the very same frame whose content it is delivering. So the assignment
is placed in the same unbroken bcm_rx_update_lock section as the content
comparison.

As a side effect, the RTR-request frame feature (which never reach
bcm_send_to_user()) no longer updates rx_stamp/rx_ifindex, since only
the notification path needs them.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 993fbcc..d317531 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -761,11 +761,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -789,6 +784,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	 */
 	bcm_update_rx_stats(op);
 
+	/* save rx timestamp and originator for recvfrom() under lock.
+	 * For an op subscribed on all interfaces (ifindex == 0)
+	 * bcm_rx_handler() can run concurrently on different CPUs so
+	 * the CAN content and the meta data must be bundled correctly.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe);
-- 
2.43.0


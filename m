Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5642125E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888667; cv=pass; b=aaGFJP9y2ER1K065nuhtPIIsAIXGsIy3BwYp240HKWEosRjJmstf6dQmdoqln2aImcm3WmY5kq4NF5v6tXtgW3VtShcFpsSPk0YdB+69HfCJzgP8XZkTruRGjarm22OU7Dt0mejGG+za0AVDjrw7E/PQAMyxUdaXCY9A9a9blso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888667; c=relaxed/simple;
	bh=eLw9MObynlKnsBj5IMC3FJiovAkRI0YjCd7w10Ftek0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBi6ExwC4VvUZwrTF2Jduq4EygWfeXU3mgAtgfR54a8/sFIcI9brCpc85zQDNdffTZlinb+4PsjnFSFAIHMvABKK/xVsahj99josB/rdKjLZaG3qT8/q+GUiNPLY3mwJ/+mr5EotE5nP2p5LiQg5CCBgELsSxhFGvoyNkI5WnXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZhX0AG3j; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RWrzfI3n; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZhX0AG3j";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RWrzfI3n"
ARC-Seal: i=1; a=rsa-sha256; t=1784888661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XJlsa+DqE1aHpQNUEeL3Of/AyEs203xP42KCw7D6gE7nV4/ofJD7oBrrB/QFeBqNlT
    RzxKOwO2eFzUpp250YNs3m3L5Jg8Vf0dK980bdcmpNev22BhyfsMHDazstYTqHgRTZTp
    2Bb5uAOpxChRD5QvmD6EtuToqefvthO3oXQmkWTTbxiOZqIYTpQMcyyevpfwT7gQaj9U
    7EFP17+tSMHFV6m8SbU+sM8qrQCKW5+qziYhIe30kKK2U0mUCyBv4j2BEgX3Vnzt+a2y
    RN8/6BxYFhJYf/cjzoct3+/BPT8L2STDe7yXqaEj3Li2KAv7juyt8RczPumItygVcR2U
    3OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=JE/PJME6+ZCZNX7E9aJJH+b7ErjHrrt08Rv3ee3gFUTBEDEgx88PNqhm57jQsOalll
    BqBL3p1EsAAm5RJgAbG8kx4HgnNH6LBrRyEzaITvByBhXkTerGeyVWZjsKiYLxMRSGVC
    5JjW+Q7TlP/5zjTBY2vuN+xs0kO53ocAMebfW3NQAiKya8BY/ArJ4dkhC5DOMtqfv/Rq
    oHx+N0aG0QuVnk8jhybdjQ0S1Smn83/y9D3b+FeNRxjv2XPDw8Spp3qCWiDPDhApOWDA
    S50kiKfa5svPXHP6XjG8m1M23KEJ/3qQmA1HCo3FAYXKizYeA6Ww0F4+SBQIX3bw7ypC
    yw8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=ZhX0AG3jpUdeS4xtgrxLH5JEy0WUycKIQ1pP/Nd0ClUJGMNGpfBDfNgrBJw4qdvsJc
    vOl249riXG7BMYp0cRQJUx8naLBbp4G+2BFTNgfAbJIshps5q3M9Kw3qaAbnzpI9/MdU
    sRsQEVsM0VIkzK++VGhy9ekrOGTEr148GmKHcwtyWYMkp3dAI7Zy7l8utvt8KiRFQEKW
    j61K9s02Glt3+zLxwEfROgFMn6urEbhBTT0Ep/U0p8ftFwS/bSHqochObdDo86pwYnPz
    lW/uhZkIt/LIxK02seiwkJc5WrhzSpQvpHRBFwU7/n3Ml0qK2To3qMc5q9+dU4rRleGV
    pL0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0cbN3hjiOGvQQDLyl1rjYXBnBnQbIb3CueXW/zsBbck=;
    b=RWrzfI3nqOf7Ucqi72/2R2TkFchK8wtGZjrL+u1D8XJCk+XunfDcIEHSSHk5QVwHTX
    1NpikLL3X5sr66YXKlAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOLtIe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:21 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 12:24:09 +0200
Message-ID: <20260724102410.16731-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102410.16731-1-socketcan@hartkopp.net>
References: <2026072011-untruth-wrongly-ed18@gregkh>
 <20260724102410.16731-1-socketcan@hartkopp.net>
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


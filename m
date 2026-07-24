Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7A363C50
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882164; cv=pass; b=N1bv7FfxuLzquSrplPjgeuXyJo/fIwkJWviDKPJhmmfnb1kZmifSaApNGDSrOR5P8iZmJfMm6hbc1jtsNmBKK7XLqBkgFntxZ0pYNg01swE99KzTusam4zd50Ra/ufGQ3o1rtiWT1M17dqQsUz7FRp5pLvZ+nIrHZaOlRtzxTBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882164; c=relaxed/simple;
	bh=v2jp7AXtDa6VU1cP9KrBfSscEB1UfiwBQh9OUbehQkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+iv/Qa1TmIhcdm4Ht/XJDUGA7i5pUQPDn4gNK783uxi/+wmnh5OSpRtG9k08ybZItrArT7HIwFazpPusvhTwvkiC1nkH5zSFc4Kr/ErZ3k5peReru4CuKvSUs/EqImy6RVYxvAou9tJ9YsdJRQNBn16CYdrZ/Lj4gXb/EmEL/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cm653R86; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Fi/JFRqP; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cm653R86";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Fi/JFRqP"
ARC-Seal: i=1; a=rsa-sha256; t=1784882147; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tbdSsZyS9Szw3r9Ru9aWV35Y/yy6LXgvEN7gO8UwNZLtUhvKRZ4p5MYptsfQPa8b3A
    TdVDMYeDxwLZFZkPKedibWT2mYq0IrRmilxMSN8WATgusmoJ17RST/HGqYF2ABNd0h2l
    B5aGN0+8/3EhoIydpP/MkQvsZngI+/JTom00KHvfnhC9fkllb71HWPAvDjL3VADIyy0r
    /h7+p0Vm0kun2Ck1HGuL0yrp1/w2nHYJBd4aTZoY4vMwaU3ADuNSRyUANVXf2z0eXNBu
    mG5fF73YatubdrEbN0GgLyYl9cGEiFzO3V7aYH4fH31tRq2oBq36EPhnVk5bcqjwWvUb
    F7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882147;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=i7fFKG5+b+hbxZv1vq08ePSnIu3Uesuz/JrcHgzNN8q7eVCEV9XfmIeo4924AMNkJ2
    XLJ5VKBBj3C1qN4Cr2U3cgcnQjTzZ7JjHRUOKuD9SNXqQG44JeicyN39kxp8TD9B+xgS
    XvNK5H5Nodge5QS6rQJ/FaYSjXl7aRVSx2PfOj+Y8QV/bvv1S5hldQgM9G7th8alOqVR
    0sA8AON4IYM4asuZyXJHObsc7k+U/7nzV8dhN3RvmJlirnKk20/c4gD720zR4n7FZSfj
    /2XUeAH3wbQUu/Qehp/k4QTKE/M+kYI8vXatCkti9rpk2CilGIkzeqtNLCg1948nX8WO
    0YSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882147;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=cm653R86g6rg6VlwNL9qrOS4GzACYWOMV6DG82cWkgAJ7avSWxQF/n/Imyqk5c2YWa
    MBQATphUefV0rJnbs0h9cwm/jaKXuqhy8JVJRCz2oVu251eSIuK160X6n9HZSurEpACI
    GLVDqOcmJyKzOlhr379r4lYHE88x9oRSjhFPe9uXPeo7tSa7I0xQPW9COpf/cybBoFoR
    Xy+hWDJN/FoQvVYThyYe7C/3oj0evIg01VPq2dKHN0ydL6UxzLTuSk9WsHjQ5nMlqYkE
    MenmFM0Ij3a7NKwI5y8pbpADR2/d7wQ6qHltZ6XF8fwx7dV9Mw0kd1Q6IQB97SM41UUe
    zi1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882147;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eiL/Og5AVfnNdySZXC53uQLfrHKrauHVEQve/4SaWAY=;
    b=Fi/JFRqP/h9oHuLCrMt8FiJ3ltsPcAbXbQFz0zDrRKBIneTP3qwM9rVDSosltaX89d
    hW26ZyeLQrQL/NkogIAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8ZlrM8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:35:47 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
Date: Fri, 24 Jul 2026 10:35:33 +0200
Message-ID: <20260724083534.12119-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-proxy-lubricant-2d2b@gregkh>
References: <2026072058-proxy-lubricant-2d2b@gregkh>
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
index c28256c..95eb791 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -756,11 +756,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -784,6 +779,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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


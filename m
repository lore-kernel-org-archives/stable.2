Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63E432E77
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560465; cv=none; b=h6D1vZ3hGWzkl4e1Yk2Yu5TAh9QddlLqiM8ECk1YDgSnDscroe7GtHCEWu1Scy5nvc6wxDF4FNbFaP7KC6ch3ALnno7mxdVvT+oGzIUJq7+b9rtfDCrvNHQXQs8lmbO7UPWw/KKEcOit9Z9DwLR89JgTj1nMgZkhPQZFi82kPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560465; c=relaxed/simple;
	bh=6EqqOR6LzFGuM1QJaGQIdGjAPWvVVFAOWQWTTCjHmZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ce3K0pie/R8OEXho3m9Wp5gogmnIjKI+VkOqHlLc81c/naKXumC9Jsn6ED/27RugDsJyTPJhFfdADYPkX/SwalZ8VdtT3ZF7mPaqv57hvbcAcfj5ixBLYTqCZfGXqWGda/EjKZJ08pfXH9iYeZEV2BHXgpnejbQ/fRCsQjqzJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyJIQ4z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyJIQ4z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53051F000E9;
	Mon, 20 Jul 2026 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560464;
	bh=2zx/vE8/KhsCNcPHnW5eVgJFXXeAUvvioq5liLLgz/o=;
	h=Subject:To:Cc:From:Date;
	b=wyJIQ4z6OPW7uZohGrcuESV/s6hTzOaPmcaz3ol4yjmYDH9AeTUAVme12+WNYOidV
	 wmoSsyTgr/jQiBksGntAbqH37UKGz1jVRA352CzfnGEF5SE4l63pKlo4AslnIQoKXM
	 n64o1rT8KFoMqo/dx5UF/HU4NtHve6KdFKUSg/oY=
Subject: FAILED: patch "[PATCH] can: bcm: fix data race on rx_stamp/rx_ifindex in" failed to apply to 6.6-stable tree
To: socketcan@hartkopp.net,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:13:57 +0200
Message-ID: <2026072057-sulphuric-stumble-eadc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 58fd6cbc8541216af1d7ed272ea7ac2b66d50fd8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072057-sulphuric-stumble-eadc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58fd6cbc8541216af1d7ed272ea7ac2b66d50fd8 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 14 Jul 2026 18:55:32 +0200
Subject: [PATCH] can: bcm: fix data race on rx_stamp/rx_ifindex in
 bcm_rx_handler()

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

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a53dba6ab8b8..f213a0b37791 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -800,11 +800,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
@@ -836,6 +831,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
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
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A444D2EF2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449889; cv=none; b=m71LZ1u8a6N4pFFrwQWgn3PcKZ8KWqyNz0wSb32eRUadRrOlTKHHekrpZcbebgQoxRPwLcTdR8ji38lIQcR8onA99+yRCjqIvzM6cIU5X31Amxfpx/APPbo8xbRugUzyuCT9P6bSrJ+bFCMcfXl4E2YEDZTdYKgxrCEKLreO6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449889; c=relaxed/simple;
	bh=Qukt82KIAoZmVSA4dWscWrZEmtEAlk4kC07hkr1kFEc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WlKzKyKouLE/gynhi+5LppNjqYzIkSgczicqVi8SCrM8/OyT+zaHrsjwiAhJF2qJm9w/60XWFGK8UefGmQGEBHN5zKJszL5rXKhEE/WO3FhmDrP92XAG9tMR56kAReRKZOJmyewiAVrHPxmFgo/DVuJE4hI2EyrUPVXN2l+e3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OmGDMiOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OmGDMiOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9591F000E9;
	Thu,  3 Sep 2026 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449887;
	bh=iBBVpHE74nwEeNKxnwUsmdVGmElKKMlOIvHOVWGlxXE=;
	h=Subject:To:Cc:From:Date;
	b=OmGDMiOMNu9Sj0vqR1u5gNAz8B3SaC0umUITw1Fbr0RCeHutPr3OVtAq0nS9DMdAs
	 O/G+ESOjo8nBZc5dA5n10Ix6gnR4OseT33PW/uLbXG0MIX7Mzt9XW3wcCTeO+wW6qm
	 0rLLLkXb8tIlsjGifz+zme69qA/AFEbSlwsLIGow=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Mark the connection down when bringing it" failed to apply to 5.15-stable tree
To: fy15309206903@gmail.com,horms@kernel.org,kuba@kernel.org,mika.westerberg@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:07:58 +0200
Message-ID: <2026090358-matcher-folk-642c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3c8b26ebf525ba5960510f48c6e9936a79ebe76f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090358-matcher-folk-642c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c8b26ebf525ba5960510f48c6e9936a79ebe76f Mon Sep 17 00:00:00 2001
From: Fan Ye <fy15309206903@gmail.com>
Date: Tue, 11 Aug 2026 13:20:50 +0000
Subject: [PATCH] net: thunderbolt: Mark the connection down when bringing it
 up fails

Every failure path in tbnet_connected_work() undoes its own work and
returns without clearing login_sent, so the connection still looks
established. The next tbnet_tear_down() therefore takes its main branch
and repeats a teardown that already happened: it stops rings that are
already stopped, which is a dev_WARN() and fatal under panic_on_warn,
and it releases net->remote_transmit_path even on the HopID mismatch
path, where this connection never owned that id, silently freeing one
that someone else is still using.

Clear login_sent on those paths. That is enough for tbnet_tear_down() to
leave the unwound state alone, and login_received has to stay set: it
records that the peer has logged in and carries the transmit path it gave
us, which nothing on this side can make the peer send again. Two things
change beyond keeping the teardown out of the way: the logout request in
that block is no longer sent, and the peer's next login request now
re-queues our login work rather than connected_work, giving the
connection a fresh login instead of a retry on stale state.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-2-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index e5199a87ea7a..2a1728621887 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -626,6 +626,14 @@ static int tbnet_alloc_tx_buffers(struct tbnet *net)
 	return 0;
 }
 
+static void tbnet_connect_failed(struct tbnet *net)
+{
+	/* Leave login_received set: only the peer can make it true again. */
+	mutex_lock(&net->connection_lock);
+	net->login_sent = false;
+	mutex_unlock(&net->connection_lock);
+}
+
 static void tbnet_connected_work(struct work_struct *work)
 {
 	struct tbnet *net = container_of(work, typeof(*net), connected_work);
@@ -649,6 +657,7 @@ static void tbnet_connected_work(struct work_struct *work)
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
 		if (ret >= 0)
 			tb_xdomain_release_in_hopid(net->xd, ret);
+		tbnet_connect_failed(net);
 		return;
 	}
 
@@ -693,6 +702,7 @@ static void tbnet_connected_work(struct work_struct *work)
 	tb_ring_stop(net->rx_ring.ring);
 	tb_ring_stop(net->tx_ring.ring);
 	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
+	tbnet_connect_failed(net);
 }
 
 static void tbnet_login_work(struct work_struct *work)


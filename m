Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EC4E2369
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449891; cv=none; b=ldn+BZfGgGMiUi84CY9kulJAE686oa6O9M2QXXyOBc8+jAom6yB7+ynNYm/4UfFCkq/aAlLYNkBXUTb1hOmSrb8lf0HrM7cZziiRFBje9AxuvzH0YoPXs27GR3aor/+Amp52CQBfED8gjL9mrY4QPwYxbZRdAkvj8IEC3JtTwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449891; c=relaxed/simple;
	bh=qkgYYKOy4QWCxaSPgDpM4yJQJa5FoRy7/GeqDHzRpus=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l5y1bz2Q8XsHVEsdIszztq+mfc7oEv6e5Wkj2TPYQZhnOwaxyC8+p1wVrbEp+9vwAWTpc9Vc6RnZZN9TtcKqeAwDQ+6kQbeQgDzTzBINbZ1jllBpc2kUrdkt43DWC3S2omIGbMja+L+5FEb89cVae14iAjFYZIcWqA4pm927zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ctxjN3ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ctxjN3ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ED91F000E9;
	Thu,  3 Sep 2026 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449890;
	bh=oxaXSmUXN+wE4VkerbEZKqd/NN3P+U3yxxfLP/vcMRs=;
	h=Subject:To:Cc:From:Date;
	b=ctxjN3haDMlVoQJkiNywMyZ7wWtmViAoruUysB6h6s1nPc18XZ3hKGmx0NEFcgOR9
	 0r0mM7E9RQX/s6PhS1j5AtV5xISXW/G+ZH++MWvQ0SBrRwlp3inp6xqznwnrAKzL/y
	 6yYgd6J6Nd6AX+vyhInE61Zv4KEH0cdItoCzSaQM=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Mark the connection down when bringing it" failed to apply to 6.1-stable tree
To: fy15309206903@gmail.com,horms@kernel.org,kuba@kernel.org,mika.westerberg@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:07:58 +0200
Message-ID: <2026090358-language-antitrust-4e97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3c8b26ebf525ba5960510f48c6e9936a79ebe76f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090358-language-antitrust-4e97@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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


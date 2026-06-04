Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3A30276A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562227; cv=none; b=PwQ1D3pr7vQUiMUauBC/m7ULdM/LAvWlvEq091XmejuNRf26H/zKWWC33WOW+qxHoYwfuQwKYq4fOzCr8479WZ8nFwub2MlVfKjfAi5JgAgrQVm7OTBHVodscS2MPulSyLZkczgg8Yd7bC5zgaFeh8qMhsVABJ7b+z+LGMrTcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562227; c=relaxed/simple;
	bh=jXIqtmwNeQ97sDOjPoGEA1NTbRtcxe9ChIc5wIy132M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BgaPgmCWgBn+rxEA6lENEceovY2G8pT6MOU5JAUNM2wjIl6yD3kUcb+LtyZnn8JN3hDPDPLGHIXFWw9gMGmHTa9vvmDnrw/N+/q71iigomTOk2ZzK3ZtFVbpkwnpEiOfWxygRM+FKN880q9pmfpCOak2ZXCYYoipsdfR+nVGvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OH9BuS1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OH9BuS1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFC01F00893;
	Thu,  4 Jun 2026 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562226;
	bh=7KbuGSVtf7mfD73IcvQnGqcfxoxZfQzerGvpqit4CUQ=;
	h=Subject:To:Cc:From:Date;
	b=OH9BuS1jeivCUjp/8EftPpH8uWJAm0Ah0Z8LABMYTntXqrryi5C2iRupddJyi+FKc
	 R65bAeUMrsBRTdYDaB0wmW9h0PoFMJ1Zj2nhPYzw+Py/MXo8RgfrM86S1Ifah8X+JW
	 AbmF+Rnmsvk/4KqMy7h/4VUNVxun7j2AL42e+CnY=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: use chan timer to close channels in" failed to apply to 5.15-stable tree
To: oss@fourdim.xyz,luiz.von.dentz@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:36:10 +0200
Message-ID: <2026060410-livable-earshot-8a13@gregkh>
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
git cherry-pick -x 8c8e620467a7b51562dbcefbd1f09f288d7d710d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060410-livable-earshot-8a13@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c8e620467a7b51562dbcefbd1f09f288d7d710d Mon Sep 17 00:00:00 2001
From: Siwei Zhang <oss@fourdim.xyz>
Date: Wed, 20 May 2026 22:12:20 -0400
Subject: [PATCH] Bluetooth: L2CAP: use chan timer to close channels in
 cleanup_listen()

l2cap_chan_close() removes the channel from conn->chan_l, which
must be done under conn->lock.  cleanup_listen() runs under the
parent sk_lock, so acquiring conn->lock would invert the
established conn->lock -> chan->lock -> sk_lock order.

Instead of calling l2cap_chan_close() directly, schedule
l2cap_chan_timeout with delay 0 to close the channel
asynchronously.  The timeout handler already acquires conn->lock
and chan->lock in the correct order.

The timer is only armed when chan->conn is still set: if it is
already NULL, l2cap_conn_del() has already processed this channel
(l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
so there is nothing left to do.  If l2cap_conn_del() races in
after the timer is armed, __clear_chan_timer() inside
l2cap_chan_del() cancels it; if the timer has already fired, the
handler returns harmlessly because chan->conn was cleared.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Cc: <stable@vger.kernel.org> # 0b58004: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b34e7da8d906..c138aa4ae266 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1499,6 +1499,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	 * pin it (hold_unless_zero() additionally skips a chan already past
 	 * its last reference).  We then drop the sk lock before taking
 	 * chan->lock, so sk and chan locks are never held together.
+	 *
+	 * Since we cannot call l2cap_chan_close() without conn->lock,
+	 * schedule l2cap_chan_timeout to close the channel; it already
+	 * acquires conn->lock -> chan->lock in the correct order.
 	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan;
@@ -1516,14 +1520,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 		       state_to_string(chan->state));
 
 		l2cap_chan_lock(chan);
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		/* l2cap_conn_del() may already have killed this socket
-		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
-		 * double sock_put()/l2cap_chan_put().
+		/* Since we cannot call l2cap_chan_close() without
+		 * conn->lock, schedule its timer to trigger the close
+		 * and cleanup of this channel.
 		 */
-		if (!sock_flag(sk, SOCK_DEAD))
-			l2cap_sock_kill(sk);
+		if (chan->conn)
+			__set_chan_timer(chan, 0);
 		l2cap_chan_unlock(chan);
 
 		l2cap_chan_put(chan);


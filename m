Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD97478E2B
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580742; cv=none; b=pGHmZl5Q4j2o3yT9NnFBa02tGqMyHBpVNukjo76WUxx3xjVzRP9DPIZ0U9J3TisPFMeH+3LbQuOJS8t+Hmnb6lAPMIUnMB+mMaECKEGDJS6DCDwetEH9AkiOZCX0FgUMO1cN4HIumK/W2ZLrUg7a0idMamiG+LgcjKN76vyl1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580742; c=relaxed/simple;
	bh=vGVZm6VOAYeaZuiU6JyrKD8TGVk5RMserZ3q/+QJ/R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fpj7TfZtumkvv5glMph9q5swmSZ7FaOvXbCr3oaVH+ihJF7HhUlcFgheTHQIxegDl5bOBdKrrXMTeO6qhhFC3lKZ2QbfjPLoOSkRvyTr8d94pbRiAx5uRT/Q39JiaQRHpO87dsJWsWtW6Q8mDYcu/T6QlHGPmz1Q51IFeemuZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jShyWONs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jShyWONs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B741F00893;
	Thu,  4 Jun 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580741;
	bh=Grs6jr4u7dORp3u224cC2DX+BiBniTgznF/OrefQwiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jShyWONsSlPXlvbb/cxkilIQGlVq6lT3H0oY48/WT6teBSiDxEshYjxdhy+VDq9bf
	 MVz5p4drOiKusDGEVIgwbv83NDQ67G/2ALO4RazL8/fcHB0VUqj6kwPzPjCwSXir+Y
	 kp0HBG3ZLUb9Y8IgJ8+MvM+MpnF0mWF8GPVjN9z3Jp08jhnQGqEjEJGz2juPUnIs5a
	 6j7MeehJy6gW6sg/GA59eT6Xeq4+gOQytsDtZs3eR6I9ehaOuIFqVlq0sDEUFsOGv5
	 w2q3xB9RdaGzpDbBzcS4Ya4EBHfO/uGDnD0hkBLku9mu3TLj9uElXvBwyL3jg7067B
	 f4y+PL8jvZv0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Date: Thu,  4 Jun 2026 09:45:37 -0400
Message-ID: <20260604134538.3463737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060410-arousal-fasting-6cae@gregkh>
References: <2026060410-arousal-fasting-6cae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Safa Karakuş <safa.karakus@secunnix.com>

[ Upstream commit ab1513597c6cf17cd1ad2a21e3b045421b48e022 ]

bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
accept queue and release_sock()s it before returning, so the returned
sk has no caller reference and is unlocked.

l2cap_sock_cleanup_listen() walks these children on listening-socket
close.  A concurrent HCI disconnect drives hci_rx_work ->
l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
frees the child sk and its l2cap_chan; cleanup_listen() then uses both:

  BUG: KASAN: slab-use-after-free in l2cap_sock_kill
    l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
  Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill

This is distinct from the two fixes already in this area: commit
e83f5e24da741 ("Bluetooth: serialize accept_q access") serialises the
accept_q list/poll and takes temporary refs inside bt_accept_dequeue(),
and CVE-2025-39860 serialises the userspace close()/accept() race by
calling cleanup_listen() under lock_sock() in l2cap_sock_release().
Neither covers l2cap_conn_del() running from hci_rx_work, so this UAF
still reproduces on current bluetooth/master.

Take the reference at the source: bt_accept_dequeue() does sock_hold()
while sk is still locked, before release_sock(); callers sock_put().
cleanup_listen() pins the chan with l2cap_chan_hold_unless_zero() under
a brief child sk lock (serialising vs l2cap_sock_teardown_cb()), drops
it before l2cap_chan_lock(), and skips a duplicate l2cap_sock_kill() on
SOCK_DEAD.  conn->lock is not taken here: cleanup_listen() runs under
the parent sk lock and that would invert
conn->lock -> chan->lock -> sk_lock (lockdep).

KASAN/SMP: an unprivileged listen/close vs HCI-disconnect race produced
12 use-after-free reports per run before this change; 0, and no lockdep
report, over 1600+ raced iterations after it on bluetooth/master.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Reported-by: Siwei Zhang <oss@fourdim.xyz>
Reviewed-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Safa Karakuş <safa.karakus@secunnix.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 8c8e620467a7 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/af_bluetooth.c | 10 +++++++
 net/bluetooth/l2cap_sock.c   | 51 +++++++++++++++++++++++++++++++-----
 net/bluetooth/rfcomm/sock.c  |  9 ++++++-
 net/bluetooth/sco.c          |  9 ++++++-
 4 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0b8400bda73d63..88ca5c196179d0 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -237,6 +237,16 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
+			/* Hand the caller a reference taken while sk is
+			 * still locked.  bt_accept_unlink() just dropped
+			 * the accept-queue reference; without this hold a
+			 * concurrent teardown (e.g. l2cap_conn_del() ->
+			 * l2cap_sock_kill()) could free sk between
+			 * release_sock() and the caller using it.  Every
+			 * caller drops this with sock_put() when done.
+			 */
+			sock_hold(sk);
+
 			release_sock(sk);
 			return sk;
 		}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fb22574278c4a5..634ee15cb71558 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -366,8 +366,13 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -1432,22 +1437,54 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Close not yet accepted channels.
+	 *
+	 * bt_accept_dequeue() now returns sk with an extra reference held
+	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * -> l2cap_sock_kill() cannot free sk under us.
+	 *
+	 * cleanup_listen() runs under the parent sk lock, so unlike
+	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
+	 * establish sk_lock -> conn->lock and invert the established
+	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
+	 *
+	 * Instead, briefly take the child sk lock to fetch and pin its chan.
+	 * l2cap_conn_del() reaches the chan free only via
+	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
+	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
+	 * therefore guarantees the chan cannot be freed while we read and
+	 * pin it (hold_unless_zero() additionally skips a chan already past
+	 * its last reference).  We then drop the sk lock before taking
+	 * chan->lock, so sk and chan locks are never held together.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		struct l2cap_chan *chan;
+
+		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		release_sock(sk);
+		if (!chan) {
+			/* l2cap_conn_del() already tearing this child down */
+			sock_put(sk);
+			continue;
+		}
 
 		BT_DBG("child chan %p state %s", chan,
 		       state_to_string(chan->state));
 
-		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
-
 		__clear_chan_timer(chan);
 		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
-
+		/* l2cap_conn_del() may already have killed this socket
+		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
+		 * double sock_put()/l2cap_chan_put().
+		 */
+		if (!sock_flag(sk, SOCK_DEAD))
+			l2cap_sock_kill(sk);
 		l2cap_chan_unlock(chan);
+
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
 }
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2dcb70f49a68a5..ffc8a476facfce 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -180,6 +180,8 @@ static void rfcomm_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		rfcomm_sock_close(sk);
 		rfcomm_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -498,8 +500,13 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ce084a184a1cde..5f3d1376a60989 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -384,6 +384,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		sco_sock_close(sk);
 		sco_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -677,8 +679,13 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
-- 
2.53.0


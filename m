Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4947DF9E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580742; cv=none; b=UAX1kBdGzV6xJc44NmUywzhGfx6gzuk+E6BuXNBBpZOP5JSEpGncj6ihpy4XcqQjXy0PEUBTe51JAKcuKZ/IwDs9lBkZ2T/OTDHyvgs3AtHBKXhbYaJkrw4gsCnX/5IiV47mVrNl9fvPAEt6masiOrinFYupw88YAk0o3fFiQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580742; c=relaxed/simple;
	bh=qKFjZeLBCl/W2nV+li7KKVbmdXG/JfuR0rAQKf7HHS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6ICYpMFn8SfcMxpyeIvhz6WBSTt99VrxaZ1ZHSs0QIPpzYQMkhCRoHc1jUAlOqjbzTpG/+EOxppkZjpt+dQjKixHcYZ9S6t6CLhnrJ0tVdSMi31KMGXRoNndEmOgI91XHtUeSWSdWL8w5XfqzLxXIJNKw4NPeHJZEjNBKHu4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH0CU8M4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH0CU8M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF561F00899;
	Thu,  4 Jun 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580741;
	bh=Jlnb8gPvuci9l753ocdB8IqdFNGcZpRG9wtLAwL+0m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hH0CU8M4Qxo7HXQnSJcLePVbeEOan23bnRL+ir9HjR5uyhyxdX78yIAdMYem8Kut+
	 RHIsX95D6Nv2dBjIu9LW/nuFiv19yHgV/1gYs9/JUgQtS28JaCjV+/FkAkgtbkf6v7
	 E1HgXtqCGxWzxeq6im+f7tRXiVmQCaWvunIsVrkOg3+a67J4OrfSjidcauoWvBfoad
	 0J5eI7DJe+GBZ0r74J4Q66I+GGL6Sd0t2NekPTqtIWGdbWxU0IUlynojAZcjhPI/BN
	 jGfb8BnUhX6LJr1tvFKSdK2inD7dCFi12GsLMs3S5S5wFtIHMVOHi4+dGjvR09Drx7
	 hyd6w8aea3/sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
Date: Thu,  4 Jun 2026 09:45:38 -0400
Message-ID: <20260604134538.3463737-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604134538.3463737-1-sashal@kernel.org>
References: <2026060410-arousal-fasting-6cae@gregkh>
 <20260604134538.3463737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <oss@fourdim.xyz>

[ Upstream commit 8c8e620467a7b51562dbcefbd1f09f288d7d710d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 634ee15cb71558..db8a90fec98e9d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1456,6 +1456,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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
@@ -1473,14 +1477,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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
-- 
2.53.0


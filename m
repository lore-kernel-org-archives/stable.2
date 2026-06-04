Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39047DD55
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580251; cv=none; b=KLreMiK7xbDmxCxlq+CTJ9Nnpk8AGKLoJ9Q8MMFME0SxDmuwMk30ol1abHBxK5+ZAA2f6uk6cCtTQfDzPPbyUA1E0bS/iDzqSswPSJd820Xj+2pZ7G43gB5ghZl9TYblKGUdFhRFC4J0GwRVWG9p11y1js4Xs/AW8NbZEsYTheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580251; c=relaxed/simple;
	bh=BNLq8AU/dYecCWvovvORTgOVGCSFtPi/WDO5/sd1nTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qP4toMl+3Iu3bjLLrt0iOmIlukPr1q83/t9vx7pWDqjuH/ILTmLUMHC9F1cxz9HH1onukPxdgFpJT5zWUDDflnS/QPk5fShTC5BLjZtUwx0x+0g+db/ZpbXKnN/wXcVcbGlzCgchF0b+tb1zwRFlvIMCjaLUDcg0oEKEanD7U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBd0Tq28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBd0Tq28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653041F00898;
	Thu,  4 Jun 2026 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580249;
	bh=+2XW4LKfC3/PSuR3p22u7mn2v99Ht/do2w6T9b3lkoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kBd0Tq2878ywiuuSHH1OZ5KkcfTHeiK0cM3eYR140vqR8M1mY/HvkA6CWXYEJu5D8
	 bc6AB4DfO94Q/kUo9uj5cge+MiXw2qPmeJPVstg1mRqJqeZ/02xnq8W2kJ7uC2Sgd9
	 FaggzsPvr/eakwQZ8H87MWB0E8UD1t2H8BBGyi1lpKcGNzlyyPmG22V2JLfNImiULv
	 ZcqodFHU0vs3yhyeQlAkM7w7TFNUlJBv/wRzvf++SuVjLHnM/5co/8r7y33ZTPeMq1
	 dh1d6eNInbVmMQwjFiZVuKvVgRad2PaAbLEWbOgw+PKOAyVdq927A2je5n+Mjcj5yX
	 HnEKtwqkZiYaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
Date: Thu,  4 Jun 2026 09:37:26 -0400
Message-ID: <20260604133726.3434716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604133726.3434716-1-sashal@kernel.org>
References: <2026060410-livable-earshot-8a13@gregkh>
 <20260604133726.3434716-1-sashal@kernel.org>
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
index 8493207cedaaa4..5ca96cfe9611a4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1468,6 +1468,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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
@@ -1485,14 +1489,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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


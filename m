Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13038A299
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096918; cv=none; b=LH/Ia0zX3v7tXCHWDid4fUZ2z8TajAkgpKh2TXbNNLwdbF4yy4St5eEBjHpFzF/snN3AYvJt+JSc+h/uZSPv8GuQXbixvozd3zK25OmguafNRJbQKhGpr0SEyoU3cq8/op9Y8GQWAaSAgUGZSnPH8tDmspa83FJ/9jhAMFS7Ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096918; c=relaxed/simple;
	bh=88ZcLyMB03/DNitilZZ1befWfnHNVz/C5ErNJPsKCpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV/Vp4sTn8cFqCUUMfqSPYETSha5S3lq4b+3g2gLIfb8gKcZfscfL4YH+5Su5EbZQrBm4EpjHbAAwEFLSJ6hBCa7bSeaeHlGUAx3lOciEgAGNp0rNEOpQTHniHaM42cuuGlclK9JpkIiBSyPWYrguLHoSEkrLjRbCeM7rt1uWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpvWPSSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpvWPSSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B021F00898;
	Fri, 29 May 2026 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096917;
	bh=CbqTHoR3wkLGBb4wckd/4khVLUmIw/8tLTGf9XPcNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NpvWPSSFbO0FkN8aSqHIzEWmJ76p0BIc/pLUA5m14UsyzyyZkMJEzNm+1CjDcQ854
	 LmFdlObekDRMLlXaRFmrb+gB4IHbJ5Me7Wb8MPNyB4vii9+jaC4mJwaJqgQfO76sP0
	 cBXj28CragLC0mmWIHOmmg9bHvLHy5+0FbZaeYD4lWsKFsdaAXwEkbf3wKg8GjuqMi
	 pVZ6fypbOe4BnwZ6o9jafalzmYk5iAhf5JElmtodhj4dJ1k3q2MakkeY6GjLD95lvG
	 yQA0snpfGHeyMnRNGmxpMXiNkvsrtfg5XDb3ZqmN5GPptVeivI0nUQ2rKwwV11QRcp
	 scWBIwvoBYdnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiexun Wang <wangjiexun2025@gmail.com>,
	Jann Horn <jannh@google.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Bluetooth: serialize accept_q access
Date: Fri, 29 May 2026 19:21:53 -0400
Message-ID: <20260529232154.1873470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529232154.1873470-1-sashal@kernel.org>
References: <2026052841-railing-periscope-eaaf@gregkh>
 <20260529232154.1873470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiexun Wang <wangjiexun2025@gmail.com>

[ Upstream commit e83f5e24da741fa9405aeeff00b08c5ee7c37b88 ]

bt_sock_poll() walks the accept queue without synchronization, while
child teardown can unlink the same socket and drop its last reference.
The unsynchronized accept queue walk has existed since the initial
Bluetooth import.

Protect accept_q with a dedicated lock for queue updates and polling.
Also rework bt_accept_dequeue() to take temporary child references under
the queue lock before dropping it and locking the child socket.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5689b4744764f..05dc9832f9bb6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -361,6 +361,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
 struct bt_sock {
 	struct sock sk;
 	struct list_head accept_q;
+	spinlock_t accept_q_lock; /* protects accept_q */
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index f4ea70981410d..67bd4c1993fae 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -151,6 +151,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 
 	sock_init_data(sock, sk);
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+	spin_lock_init(&bt_sk(sk)->accept_q_lock);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
@@ -211,6 +212,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
+	struct bt_sock *par = bt_sk(parent);
 
 	BT_DBG("parent %p, sk %p", parent, sk);
 
@@ -221,9 +223,13 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
-	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	spin_lock_bh(&par->accept_q_lock);
+	list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
+	sk_acceptq_added(parent);
+	spin_unlock_bh(&par->accept_q_lock);
+
 	/* Copy credentials from parent since for incoming connections the
 	 * socket is allocated by the kernel.
 	 */
@@ -241,8 +247,6 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 		bh_unlock_sock(sk);
 	else
 		release_sock(sk);
-
-	sk_acceptq_added(parent);
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
@@ -251,45 +255,72 @@ EXPORT_SYMBOL(bt_accept_enqueue);
  */
 void bt_accept_unlink(struct sock *sk)
 {
+	struct sock *parent = bt_sk(sk)->parent;
+
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
 	list_del_init(&bt_sk(sk)->accept_q);
-	sk_acceptq_removed(bt_sk(sk)->parent);
+	sk_acceptq_removed(parent);
+	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
+static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
+{
+	struct bt_sock *bt = bt_sk(parent);
+	struct sock *next = NULL;
+
+	/* accept_q is modified from child teardown paths too, so take a
+	 * temporary reference before dropping the queue lock.
+	 */
+	spin_lock_bh(&bt->accept_q_lock);
+
+	if (sk) {
+		if (bt_sk(sk)->parent != parent)
+			goto out;
+
+		if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
+			next = &list_next_entry(bt_sk(sk), accept_q)->sk;
+			sock_hold(next);
+		}
+	} else if (!list_empty(&bt->accept_q)) {
+		next = &list_first_entry(&bt->accept_q,
+					 struct bt_sock, accept_q)->sk;
+		sock_hold(next);
+	}
+
+out:
+	spin_unlock_bh(&bt->accept_q_lock);
+	return next;
+}
+
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 {
-	struct bt_sock *s, *n;
-	struct sock *sk;
+	struct sock *sk, *next;
 
 	BT_DBG("parent %p", parent);
 
 restart:
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
-		sk = (struct sock *)s;
-
+	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
 		/* Prevent early freeing of sk due to unlink and sock_kill */
-		sock_hold(sk);
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
 		 * bt_accept_unlink() due to serialisation caused by sk locking
 		 */
-		if (!bt_sk(sk)->parent) {
+		if (bt_sk(sk)->parent != parent) {
 			BT_DBG("sk %p, already unlinked", sk);
 			release_sock(sk);
 			sock_put(sk);
 
-			/* Restart the loop as sk is no longer in the list
-			 * and also avoid a potential infinite loop because
-			 * list_for_each_entry_safe() is not thread safe.
-			 */
 			goto restart;
 		}
 
+		next = bt_accept_get(parent, sk);
+
 		/* sk is safely in the parent list so reduce reference count */
 		sock_put(sk);
 
@@ -307,6 +338,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 				sock_graft(sk, newsock);
 
 			release_sock(sk);
+			if (next)
+				sock_put(next);
 			return sk;
 		}
 
@@ -509,18 +542,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
 
 static inline __poll_t bt_accept_poll(struct sock *parent)
 {
-	struct bt_sock *s, *n;
+	struct bt_sock *bt = bt_sk(parent);
+	struct bt_sock *s;
 	struct sock *sk;
+	__poll_t mask = 0;
+
+	spin_lock_bh(&bt->accept_q_lock);
+	list_for_each_entry(s, &bt->accept_q, accept_q) {
+		int state;
 
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
-		if (sk->sk_state == BT_CONNECTED ||
-		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
-			return EPOLLIN | EPOLLRDNORM;
+		state = READ_ONCE(sk->sk_state);
+
+		if (state == BT_CONNECTED ||
+		    (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
+		     state == BT_CONNECT2)) {
+			mask = EPOLLIN | EPOLLRDNORM;
+			break;
+		}
 	}
+	spin_unlock_bh(&bt->accept_q_lock);
 
-	return 0;
+	return mask;
 }
 
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
-- 
2.53.0


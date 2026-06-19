Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10A378D89
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883443; cv=none; b=BPQEC6ur1sXDzjpfpQvL4bdIzoQ7reWN2Ck+X04X3c3o/+jNdNfJKjB0JYkHT8Kd//qUOlRPNaDTU3iAYITx4yrQDcf48zNq5LHVbMVIXXe1hYBbL53R7cAl3cU8HnTyUWxtwwPyy31LUxRnFP7L4KrvN8OJIPsk4RXrKxaCCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883443; c=relaxed/simple;
	bh=Zs7e/+O4mz2zf91CtUdd5caxIJ1n7vj5Kj6VbFfzWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFnch7EwIsXE97fqcpOSOBCguhx1oKm3uDfLVl9hbhnMyqtxcOWd5J57gf7jd9eKkPExf57SgjRAdvtLgCdMupPnVYFjEE+39+9TfHV3f3S2Ipo4eoP9ntD05OcEo7KHfJvPe8pY1ei1J93MzunLlVHPPkGibwkbqQMTRxIhmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wIA9tFqF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wIA9tFqF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=mW289Z+7jmnr8kVloQNZjJyZyeJzqp7Kag8AVGpjeEQ=; b=wIA9tFqFDPH7lnkFAtKyGL7ueI
	Jh/22Y5Od/IY9FVOKUBSEg+tB+kq6YWfSO+NmICkhyX7J099GPL7hhGFGj5lFyiCcApm/ZBNr19r8
	ofpA5FdFQyaEHGcaNcq6BcKsBOHtzIBFvxzUXqCHUeiBW0GU/EMKhHqXFAB/3edL9aSYhipxRMoUz
	UGP8y5HXvu7O6ADZ1/gUFvb4MRU7VYJEvQaRbsk5qnmLlqYrGRzWcflBvRpb24ye4B/4llTm6LSsu
	VBOzyx31pV+Okb6WtV3+L8acQcNr8EfziejXL0CMiXj8M7iAnS6j6z6lOoqYxC8EQmeQ8B6lhLW9Q
	wZSFgigA==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Fri, 19 Jun 2026 17:20:12 +0200
Message-ID: <20260619152012.2016837-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 ]

skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
not be taken in IRQ context, only softirq is okay. A few drivers receive
the timestamp via a dedicated interrupt and complete the TX timestamp
from that handler. This will lead to a deadlock if the lock is already
write-locked on the same CPU.

Taking the lock can be avoided. The socket (pointed by the skb) will
remain valid until the skb is released. The ->sk_socket and ->file
member will be set to NULL once the user closes the socket which may
happen before the timestamp arrives.
If we happen to observe the pointer while the socket is closing but
before the pointer is set to NULL then we may use it because both
pointer (and the file's cred member) are RCU freed.

Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
matching WRITE_ONCE() where the pointer are cleared.

Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260220183858.N4ERjFW6@linutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[adapted sk_set_socket() in include/net/sock.h to fix the conflict  from
 not having commit 5d6b58c932ec ("net: lockless sock_i_ino()") and the
 additional previous changes required by it.
 It comes down to just now having the lines of
    if (sock) {
            WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
            WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
    }
 below the changed line.
 I've tested this on a device running an nfs-root and did some
 additional network stress-testing.]
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/sock.h |  2 +-
 net/core/skbuff.c  | 23 ++++++++++++++++++-----
 net/socket.c       |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0d77a87929f9..dffbaaa7fe49 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2040,7 +2040,7 @@ static inline int sk_rx_queue_get(const struct sock *sk)
 
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-	sk->sk_socket = sock;
+	WRITE_ONCE(sk->sk_socket, sock);
 }
 
 static inline wait_queue_head_t *sk_sleep(struct sock *sk)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4be699bd3a17..fede3aa3ddbc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5525,15 +5525,28 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 
 static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
-	bool ret;
+	struct socket *sock;
+	struct file *file;
+	bool ret = false;
 
 	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
 		return true;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	ret = sk->sk_socket && sk->sk_socket->file &&
-	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
-	read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	rcu_read_lock();
+	sock = READ_ONCE(sk->sk_socket);
+	if (!sock)
+		goto out;
+	file = READ_ONCE(sock->file);
+	if (!file)
+		goto out;
+	ret = file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
+out:
+	rcu_read_unlock();
 	return ret;
 }
 
diff --git a/net/socket.c b/net/socket.c
index 5c5dd9f6605a..723bc3a1ba5c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -652,7 +652,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		iput(SOCK_INODE(sock));
 		return;
 	}
-	sock->file = NULL;
+	WRITE_ONCE(sock->file, NULL);
 }
 
 /**
-- 
2.53.0


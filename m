Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD21D89EF;
	Mon, 13 Jul 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911029; cv=none; b=F1nhia9FfbV4k/XyKFMbI00nhVn0VwwCJSGmzp7FDn5ULErCIKBK9Lt3dSvWQZpdMSjT8lWa38jUQjHkpi2fkzSFCbzF1AnnFQVl2rXLTn3kEArmEq26TfSeiCclfbRZhCom0Ob+ZPzWOklIb4eNlPIkGxWf2z1Z8Uf3HCEb8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911029; c=relaxed/simple;
	bh=uK8ebHrJy18jlhpHPvs3n5bmfgYPvQ0LUYvUb988Ms8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dSz/ittaWpaAW+ZohPnsrJUbwhVSmMpYtNBsA26TkQZbn8yzlD5SVOFGUCELaVvSgFmqgjMGCBSA20+aW/SEPSY1gfivWY0nqHt9igjWN0KgKu6fZdbE2TXMPDy7WDRn0iZBrCI97h3h3uNmTmoa6qptoMYSZttgdfbJNyOSqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L8h5ewnI; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L8h5ewnI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783911018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/o69Om8gHFJIP/BBTTV1YqRrq880BAJGehlBpzOYFX0=;
	b=L8h5ewnI3yJTakwl/nCpLDYI+RyWgCyp4rFqnlTejAXdyinetQW1xrMuJtvR+KtASw33V4hckyeoF8vRHbNKuBlxLMZeA3vBThWV+1A8r0qWrJPqSlo1Bbyi5ggEuEhuBnULwRkUAxAf1sHSEYC6PTVpgzx4tWj0zgy3dBZlors=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X6tIp8i_1783911017;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6tIp8i_1783911017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 10:50:17 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: bigeasy@linutronix.de,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	heiko.stuebner@cherry.de
Subject: [PATCH 5.10.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Mon, 13 Jul 2026 10:50:17 +0800
Message-Id: <20260713025017.38079-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 upstream.

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
[ adapted sk_set_socket() in include/net/sock.h to fix the conflict from
 not having commit 5d6b58c932ec ("net: lockless sock_i_ino()") and the
 additional previous changes required by it.
 It comes down to just now having the lines of
    if (sock) {
            WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
            WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
    }
 below the changed line. ]
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
This patch is same as that in 6.12 (c770217044d9)
---
 include/net/sock.h |  2 +-
 net/core/skbuff.c  | 23 ++++++++++++++++++-----
 net/socket.c       |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f0e391afb511d..b9c44e47cb7a7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1981,7 +1981,7 @@ static inline int sk_rx_queue_get(const struct sock *sk)
 
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-	sk->sk_socket = sock;
+	WRITE_ONCE(sk->sk_socket, sock);
 }
 
 static inline wait_queue_head_t *sk_sleep(struct sock *sk)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e4a39e0f55f24..90a63c356affb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4772,15 +4772,28 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 
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
index de838c3b00486..eb157ea2a3efb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -608,7 +608,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		iput(SOCK_INODE(sock));
 		return;
 	}
-	sock->file = NULL;
+	WRITE_ONCE(sock->file, NULL);
 }
 
 /**
-- 
2.47.3


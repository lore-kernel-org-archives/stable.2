Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625001;
	b=tQXQEgMLubmRgC4+NJDbVQkijIE2tRSsw41Szcm1X+UTyt2PcqzL73tx9yXboK8epWWn
	 8BsxK5CHEKMCjLPGMdeovyRCKnQ+jcY+Z5X8JMsNCihsKW1B5+RQ2VQ6vKlzBefBPdEwm
	 +4bvLQwXuKP+wy+nChCMzdXTH1AuOrH0dr7DdTwBBjcVuYtmC7lmK29BQJ8Oyvx0y6K5Y
	 1J7bMJhgqNvX0+Zd39hR9s3f+9C4DPobgwBJA/3PGaqczTeFZSE+5AiY0O8IDHrpQH76n
	 jJHMTNWXo+Lv5UMtfPouGkxUPrC4N0klLUN5Ljpyujioq93+WbeL5+HUY9cO/m0KsYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625001;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=GHqMw/q7TleuNfGocIGHyAhvtp87XaBBGPNbbQljPFA=;
	b=yvTfTFHPTPWWog0olJUQkWF8OkD667aT8aJc1k3KfdsjXckYD8KMQugIQvj+dgOddQ3y
	 164VNYOlZY0g2gUmno3YiE+uDbrGXXNHFnEnoVm32IgrKka0LzUtMPrRlOgRIGLGx+esJ
	 ItFmzgpBjuaw0uiCNtbbhKGqhKtwvqz08QJxjzZ6dvGbv+KwhfRodm8cJVpB/5oNSW1MI
	 cEEKQy7XWgWnNzqbVcH7sNS7kwbRuAz2nnBsYH5FWvJVB0qirnlNVXJBejuEdFHdLfKgQ
	 b9yg9tO5XmyAf0ianSdPU+s9WKA6pxRKFAgqXzKmrE5xEntGGLziRCmy90k2cszuXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hkDw8QnB;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820FB606A327;
	Mon,  2 Nov 2026 13:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 820FB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hkDw8QnB
Received: from mac.lan (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6952520B7167;
	Mon,  2 Nov 2026 05:09:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6952520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793624986;
	bh=GHqMw/q7TleuNfGocIGHyAhvtp87XaBBGPNbbQljPFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkDw8QnBTDt6E80Z5hdYd70uvNkEDFdNNuvZS+e8HxPlxvNNVdV54wxhkvPN/mMDg
	 hzcvyYjkda5LYWou8UhJUmE9gLzTEcFyAq/FMXxK2eFPQyff1C4gWhkOQhc0+XNPs2
	 RGZ1ZKwJoMHOKMkXgr0chE6tGdKr1/sUf7ZMGAQA=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net 2/2] connector/cn_proc: release socket state and listener count on close
Date: Mon,  2 Nov 2026 08:09:22 -0500
Message-ID: <20261102130922.75629-3-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102130922.75629-1-cenzhang@linux.microsoft.com>
References: <20261102130922.75629-1-cenzhang@linux.microsoft.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cn_release() is the netlink release callback for NETLINK_CONNECTOR
sockets. It frees the per-socket proc_input only if the socket is a
member of the CN_IDX_PROC multicast group, and it never touches
proc_event_num_listeners. Both are wrong: cn_proc_mcast_ctl() allocates
proc_input for any socket that sends a control message, and a socket
that is still in LISTEN state when it closes has incremented the count
and never decremented it.

This has two consequences. A socket that sends a control message
without joining the group leaks its proc_input on close; an
unprivileged user looping over socket(), one control message and
close() leaks 8 bytes of kmalloc-8 per iteration that no process exit
gives back, until the OOM killer fires:

  Out of memory: Killed process 93 (trigger) total-vm:1016kB, ... UID:1000

And a listener that exits without sending IGNORE leaves the count too
high, so the kernel keeps building process events that nobody receives.

Fix by moving the cleanup into cn_proc.c and running it for every
socket on close: free proc_input if present, and decrement the count if
the socket was still in LISTEN state.

Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
Cc: stable@vger.kernel.org
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
The bug was found and this fix was developed with the assistance of an
LLM-based code analysis tool. The analysis, the patch and its testing
were reviewed and verified by the author.

 drivers/connector/cn_proc.c   | 14 ++++++++++++++
 drivers/connector/connector.c |  7 +++----
 include/linux/cn_proc.h       |  6 ++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 4f613c0648ae..a4b62998095e 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -387,6 +387,20 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 	send_msg(msg);
 }
 
+/* Called when a NETLINK_CONNECTOR socket is released. */
+void cn_proc_release(struct sock *sk)
+{
+	struct proc_input *input = sk->sk_user_data;
+
+	if (!input)
+		return;
+
+	if (input->mcast_op == PROC_CN_MCAST_LISTEN)
+		atomic_dec(&proc_event_num_listeners);
+	kfree(input);
+	sk->sk_user_data = NULL;
+}
+
 /**
  * cn_proc_mcast_ctl
  * @msg: message sent from userspace via the connector
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 4028e8eeba82..f31ee8962f7c 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -14,6 +14,7 @@
 #include <net/netlink.h>
 #include <linux/moduleparam.h>
 #include <linux/connector.h>
+#include <linux/cn_proc.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/proc_fs.h>
@@ -182,12 +183,10 @@ static int cn_bind(struct net *net, int group)
 	return -EPERM;
 }
 
+/* sk_user_data of a connector socket belongs to cn_proc. */
 static void cn_release(struct sock *sk, unsigned long *groups)
 {
-	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
-		kfree(sk->sk_user_data);
-		sk->sk_user_data = NULL;
-	}
+	cn_proc_release(sk);
 }
 
 /*
diff --git a/include/linux/cn_proc.h b/include/linux/cn_proc.h
index 1d5b02a96c46..8de921d731ce 100644
--- a/include/linux/cn_proc.h
+++ b/include/linux/cn_proc.h
@@ -19,6 +19,8 @@
 
 #include <uapi/linux/cn_proc.h>
 
+struct sock;
+
 #ifdef CONFIG_PROC_EVENTS
 void proc_fork_connector(struct task_struct *task);
 void proc_exec_connector(struct task_struct *task);
@@ -28,6 +30,7 @@ void proc_ptrace_connector(struct task_struct *task, int which_id);
 void proc_comm_connector(struct task_struct *task);
 void proc_coredump_connector(struct task_struct *task);
 void proc_exit_connector(struct task_struct *task);
+void cn_proc_release(struct sock *sk);
 #else
 static inline void proc_fork_connector(struct task_struct *task)
 {}
@@ -54,5 +57,8 @@ static inline void proc_coredump_connector(struct task_struct *task)
 
 static inline void proc_exit_connector(struct task_struct *task)
 {}
+
+static inline void cn_proc_release(struct sock *sk)
+{}
 #endif	/* CONFIG_PROC_EVENTS */
 #endif	/* CN_PROC_H */
-- 
2.55.0

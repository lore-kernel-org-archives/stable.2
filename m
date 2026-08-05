Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A03CE0A2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950398; cv=none; b=A3/wTOS85dmvcx/rXzXBGK8x223Lgj+sZGXUd4akrT5t4Cav0bqo+3UVf3T1maxZUlar5kvW1COIakK/mc4NsqYTHPV6F5xdzJ+WEDCkMJ7m3SMp3pkT1dJgDJFc49CaBGpTOynU+kzSaKJM0xvBVVhaGoW4Sxp3Z1RtE77RFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950398; c=relaxed/simple;
	bh=HUHqKK3tEWqIlHSSdjMuGR8O49ZGWQ0XpK9KdBsbkP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsxiC/xXhMXa16uj4j4bBO+DIPVnMujZffAiJ4ZgfMufTUzkURjzoJgzzshDlizorkyjfhlB1B+nEe5YDYF30vJYOZ099n8T+jwto9NU1gKPCud5pXf/uXG4Z0w72UDs8qPy53x/MbCUKLcMp4GAOIsZFTsmi31AzioNRdVMAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PYADePWM; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PYADePWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950364;
	bh=GIvESApwO4jMbvkbw91s0TD6yLv/yiWo2jhcEtKILtc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PYADePWMDZX+kl2MrXnQCx8BCbxUWX/UXn7yoOlqWgkuB8EbMKEgLsSEPvqwcPI1X
	 ACxjBtgNCcF/2ilHy6wlDZk4NSHGCEj4Pe545KuqhmUtLx6bdysCfXAJ3hbxSnsM1n
	 ot3ge6bGIskGZTNNh9XWuQZ/b2XpG0j/2M5sKpEY=
X-QQ-mid: esmtpgz12t1785950346t8036abfd
X-QQ-Originating-IP: s3Uj+XHgpZukS1RIlTL4lsUHszI+q/wa5gFcB2VsNNI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:18:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 854321210931568902
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v2 5/7] net/handshake: Take a long-lived file reference at submit
Date: Thu,  6 Aug 2026 01:17:45 +0800
Message-Id: <20260805171742.654530-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805171742.654530-1-guanwentao@uniontech.com>
References: <20260805171742.654530-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OeFOmPvKThpBs7QyXR4JO1MwSEm53JmiFignvR3dqrrYk7WASWA9ZNi4
	Xzd1HhhJ1Hx/8Lc3OEGrSR6VfuQzSi0MPBXQOkpDBDcly5lzlvkZtijGsyMZ0oiukyf9Dxv
	ePFHLH6uxx0BLAPb0YGamswtwSCTP8yddGc26nCghIDShxd5ahx/OqwN65n5k2bEWIQcT3j
	5VV4jnz1PO5479DOphQuHGX8ADQQJ3oSGzPPJSyR2JGy65iOZ/6L0TP7H9Mq0vScrT45Pi4
	Tc8b4z6hZVXv0Nc3ZQ8NwDfsJI4rSHnNQHm1///sebhmAiVkbC1ORueC+hndNyHBFzXZIfo
	KcXAtqVLUHxYfib0eokAXHlzMufOrRZKEK4lVF+MBdoloqcUg4PWJdeIJNN0W+Di396zp0F
	u42zP6ztJddaBf9ppE9EwFVoO/g3sWNVT+fmzx+iQFxMvH9I2Je+l4tQRjp1UMSyVPAQ03I
	D3Suk5Ns9kPWjQmoKkiU9lJCYRwC/jQtlM7h7ssdDEvv4RYsomixtKeUqsU5IfdOAxxF9wN
	qf/hIWQ4PIr91NcLmOx1sYpICbLFF3zuKQ+iyT4pw84wP4K8TuA2jotqy5JFpbn5OSc4iYp
	ALvfmZ0gnZJcCJI8/cBzvpvVmPyB3Gw10fX7ZhM1xAhUAxQO04SqJSZ0q1XfySbjSyGSJ5w
	Pog0uCENzeGisKLTmSjiHB4YQaBomGy+dKj9CrU514Q274Xo5bRCy3SvfjOnCBG6rO5bpsA
	viunhPAGRAUF75YmckQ28aGdazxhMQudSit38vCFVgLR9adhhGRm34Eu7fU+/oEjjMWK/0X
	+sNpkRrTP4Kzg+FpFQesHMvr4AgPyutiIdeR5VHsmLlyde1jXZfCYifKj5x86zW7co0uVA6
	P3bVZ0iIbfolJX/qpgme08tLUjVJz1fu7CDQDWCH4trmO0/qMMUS5U+jQM7RL+MzjEvg/UL
	9EegvW46fEXQWXs/uLOL0ijqWlwYRuz6gDbpbGVKCNdpuzBUfFO3T++SJRuIMbLLI8aVezi
	hWwST1jRvv8Pogygfp/RD+e97ubDi9v4UrrsFHG+7wRGhn7su/nrbuh6EPbtd1JfMO4XYlj
	aJxQp4d9RiQc22o3vDzvHhGIrDBoEKvRl00VWYmyCGG
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Chuck Lever <chuck.lever@oracle.com>

handshake_nl_accept_doit() needs the file pointer backing
req->hr_sk->sk_socket to survive the window between
handshake_req_next() and the subsequent FD_PREPARE() and get_file().
The submit-side sock_hold() does not provide that.  sk_refcnt keeps
struct sock alive, but struct socket is owned by sock->file: when
the consumer fputs the last file reference, sock_release() tears
the socket down regardless of any sock_hold.

Add an hr_file pointer to struct handshake_req and acquire an
explicit reference on sock->file during handshake_req_submit().
handshake_complete() and handshake_req_cancel() release the
reference on the completion-bit-winning path.

The submit error path must also release the file reference, but
after rhashtable insertion a concurrent handshake_req_cancel() can
discover the request and race the error path.  Gate the error-path
cleanup -- sk_destruct restoration, fput, and request destruction
-- with test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED), the same
serialization handshake_complete() and handshake_req_cancel()
already use.  When cancel has already claimed ownership, the submit
error path returns without touching the request; socket teardown
handles final destruction.

The accept-side dereferences are not yet retargeted; that change
comes in the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-4-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 09dba37eee70d0596e26645015f1aa95a9848e9d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/handshake.h |  2 ++
 net/handshake/netlink.c   |  6 ------
 net/handshake/request.c   | 42 ++++++++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index 2289b0e274f40..da61cadd1ad3e 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -24,6 +24,7 @@ enum hn_flags_bits {
 	HANDSHAKE_F_NET_DRAINING,
 };
 
+struct file;
 struct handshake_proto;
 
 /* One handshake request */
@@ -32,6 +33,7 @@ struct handshake_req {
 	struct rhash_head		hr_rhash;
 	unsigned long			hr_flags;
 	const struct handshake_proto	*hr_proto;
+	struct file			*hr_file;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 039344979de93..1a5821eb71847 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -210,12 +210,6 @@ static void __net_exit handshake_net_exit(struct net *net)
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
 		list_del(&req->hr_list);
-
-		/*
-		 * Requests on this list have not yet been
-		 * accepted, so they do not have an fd to put.
-		 */
-
 		handshake_complete(req, -ETIMEDOUT, NULL);
 	}
 }
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 62efb7e32730e..35bc6290e1203 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
+#include <linux/file.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
@@ -215,9 +216,16 @@ EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
  * A zero return value from handshake_req_submit() means that
  * exactly one subsequent completion callback is guaranteed.
  *
- * A negative return value from handshake_req_submit() means that
- * no completion callback will be done and that @req has been
- * destroyed.
+ * A negative return value from handshake_req_submit() guarantees that
+ * no completion callback will occur and that @req is no longer owned by
+ * the caller. If cancellation wins the completion race after the request
+ * has been published, final destruction is deferred until socket teardown.
+ *
+ * The caller must hold a reference on @sock->file for the duration
+ * of this call. Once the request is published to the accept side, a
+ * concurrent completion or cancellation may release the request's pin on
+ * @sock->file; the caller's reference is what keeps @sock->sk valid until
+ * handshake_req_submit() returns.
  */
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags)
@@ -236,6 +244,14 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		kfree(req);
 		return -EINVAL;
 	}
+
+	/*
+	 * Pin sock->file for the lifetime of the request so the
+	 * accept side does not race a consumer that releases the
+	 * socket while a handshake is pending.
+	 */
+	req->hr_file = get_file(sock->file);
+
 	req->hr_odestruct = req->hr_sk->sk_destruct;
 	req->hr_sk->sk_destruct = handshake_sk_destruct;
 
@@ -267,7 +283,11 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/* Prevent socket release while a handshake request is pending */
+	/*
+	 * Pin struct sock so sk_destruct does not run until the
+	 * handshake completion path releases it; struct socket is
+	 * held separately via hr_file above.
+	 */
 	sock_hold(req->hr_sk);
 
 	trace_handshake_submit(net, req, req->hr_sk);
@@ -276,10 +296,13 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 out_unlock:
 	spin_unlock_bh(&hn->hn_lock);
 out_err:
-	/* Restore original destructor so socket teardown still runs on failure */
-	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
-	handshake_req_destroy(req);
+	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		/* Restore original destructor so socket teardown still runs. */
+		req->hr_sk->sk_destruct = req->hr_odestruct;
+		fput(req->hr_file);
+		handshake_req_destroy(req);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(handshake_req_submit);
@@ -291,11 +314,15 @@ void handshake_complete(struct handshake_req *req, int status,
 	struct net *net = sock_net(sk);
 
 	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		struct file *file = req->hr_file;
+
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
 		/* Handshake request is no longer pending */
 		sock_put(sk);
+
+		fput(file);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
@@ -344,6 +371,7 @@ bool handshake_req_cancel(struct sock *sk)
 
 	/* Handshake request is no longer pending */
 	sock_put(sk);
+	fput(req->hr_file);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);
-- 
2.30.2


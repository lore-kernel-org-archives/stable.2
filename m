Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3DD3F8252
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921352; cv=none; b=WkfUp9+el1CTakk3ENEFZHUzs4/RovRLWNuIS8EJfNtAruWFFbKj5fZ/D+QEaHgvzYCt5TdwTbGJwN0n4dVFIpsckbazF38y64j3IRhZt5gc7jDs9oErZ3BWM0NLGVhvQpr8Hgt87h14v4VRt+oiI4WKvFnYwekrVqEEMPgOzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921352; c=relaxed/simple;
	bh=IDYEoR2s8eA+B+yuNIhNiHoZdVpQraF15L/v9foPdek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4/qq6bWdSrnjMgO9Sh7K3PhLP/iyQhzJoTc8q6t9lrZ9GopEKIkIetYz1hPRLFuZyUZrjh5GCXvkzzoykRlNcZ8rHHUldrGsUQiO6jFrYcnavl+zZUInVnF9SZy5j58IDrjZC/tY6Gz+PzHw2bAnGQIK8nnc95pMyJ9GbyyIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DkMCmiLP; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DkMCmiLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921315;
	bh=fbOdV25Sq9uDcG2Hfj3L2zsCt0mq3EjmtABUlIqOZD4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DkMCmiLPxe9dilZHouuEP07JxWxkcOYmgoV0qsjE6aU0HPYyMa7/hjet7Tf1IZCih
	 yQ6adEhQcuuiwNsP2TSA2398OT0cSsgcuC2Ly9TOLLY7pL9nX116ywYbd1XzIFtlNs
	 jDYsNZEOdGuH/aIHhRRCbUsdaYldFh5Pe0Olpy/g=
X-QQ-mid: esmtpsz21t1785921297tf258f088
X-QQ-Originating-IP: QOvrTWi9yUDnV/TyNKTYEAKxo01MSVUc+Xv6Usqd9NU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:14:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8650475195165954339
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 3/5] net/handshake: Take a long-lived file reference at submit
Date: Wed,  5 Aug 2026 17:13:50 +0800
Message-Id: <20260805091348.609325-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805091348.609325-1-guanwentao@uniontech.com>
References: <20260805091348.609325-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NKjpL9D7hCRxYqNW0oUpyK+Ik5pSMmBF6sxvJihcwvZ2j3F7oFn43GZy
	QhrdJ1soAJM+B4++ucCYyYenuxQJ8KysFRvRtGsveFsPXnc2OFJ+KeGT5/EhkviCSoj73lx
	vBR2VFAioHyv1/pTTdWW9aHDsCAKPDq323yHe4VxDTBA3F30Y3KmbjyQxzqRE+7YXhKeBaR
	Bmtvz42/dnVzojirxiWW3ED+6E4EdrS5Lc5qThC+wbko+YxX9HJcuit0yHeTr4uIY1m+lnz
	pOK9I8RfUOXerb2Orid+k8pRT1KzH3fNS4u5MghutrH403K6B4ojO9ZHBtW8V9ct4OMvC3j
	IlBpjmnl9UtSoaEPNOHGUUdS/nLnJvjX/0YKG2AGltSxQ/vCc8W67k9O8DKIhzHW6OZ6xyW
	zlHFrTRcONZoQYfWOpmMPPGpm1QkXW7lomrSXTcuAhp7Ce8tRm7bgWl8DNVGz605b21Y5+h
	yvfyX7/wv1DWdLdc9Gf68fK9d+QU5eSNTuPll7GSMABRGhksnIP86KfO2LMLHAOoG0QdA0b
	MO5EVozEgwXVETHw9D0fF5ig44m9xypkvf6YU/+Ez9UusNo22OkO4LGCE6peRqmD7GZDWo0
	KBIyF7hlEiY+X6oQ2WWcgxjHEgTOmQ0+CySphfCoeHYhwTAOnU4TAloAdExHO1QAKEdkR51
	aQsPLgEq5DiVgmi7IW6BgWOeS8AkPNt3qx756YKFgpZmk1LiYZT5DG6m6jfACPaJa44BwRT
	Wl6YgBRcAJ6UeMAV4sq0SjY8QB6Priv2cYwM+d+1LkyBbNekYkJcaDCSYgKenENX5lyaTAy
	U1AKQoaXPId+sm/29QzSZPHuDlAfzeM/3B+e8c5BJGCLkxiXJLPnsTArvVuL1gv5HfMiaNd
	Irbxc//emOjrVOh+mb1UREg1amw094WgyczMJ27nLapeA+jQA5vgRSe/C/5duyhCWYPpnjI
	NJQDqAiEsmhu5vcx7gO7HcAMjslhkwGyis6JmP4j73iUAPIDlw2Ni6SrtZL3T42ILYfOkHS
	n/2pVPWxAP58lG9Q4+kbsGt/vNIXyuOkp7j2mHT56S5TceDXFg0rjAKaoYFn+P2mH7avmSw
	j7GM1hMsWOOzOxq8YmW1jfdlpfkhVfMb2NPb8B8v+LdsA05ypgcGyo=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 7b1d42607ae68..fe4e22b87b3eb 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -209,12 +209,6 @@ static void __net_exit handshake_net_exit(struct net *net)
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


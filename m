Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2B3B8BA5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951752; cv=none; b=c7dQ5KU2+wtRlpkO4WtlfWVdi9TFKzj38+pMQkFNvf4HssFBF1E43iSRCgla7KgcVFQFY2BwVwRxddH5Bv9Mgx7EBf00W1pWrfB//XXPZyNzk78QGAUY0W7G4tB7qCMvp1pd2xinrqw3RyFP2/I2yV/ASHwjik4ppTu9VcHhOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951752; c=relaxed/simple;
	bh=HUHqKK3tEWqIlHSSdjMuGR8O49ZGWQ0XpK9KdBsbkP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifGaSR612LLQsJbj15ATdEqDPRNTW78KVU95KIXg7tw/HLyLlNyeg2k3PCNv+yAmzUx1oyPXDlEhFGXOfLotsbyHFULjAlsSg1PqCYRi3diEOj5tpK20s8vKm+2+ASU37QJq4abqmg97uaNeTV4ZSU2Fx8YMudZblJhAUljy/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ozAI9SgX; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ozAI9SgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951714;
	bh=GIvESApwO4jMbvkbw91s0TD6yLv/yiWo2jhcEtKILtc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ozAI9SgXsGP53Dq/4PJKysKWqXhQ9XcYqCi6RmF0ekO7VCXRaolpf3PV83Xi8LKwo
	 joucGc8A3oR53dgvDmi9uG99g1cr74ZFnqb/iLMBgHDndnlKiViKE4+OB5D467+rnG
	 wjWCzezXXHPejebBxLMNQOONdc2lIge+Xlp3bkr8=
X-QQ-mid: esmtpgz16t1785951695t88b48db5
X-QQ-Originating-IP: IJQ4TIPQs62SJsP2sNyLtR81w0KRdg+tKkunBLFjB6U=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:41:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14316294730529310377
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 5/8] net/handshake: Take a long-lived file reference at submit
Date: Thu,  6 Aug 2026 01:40:00 +0800
Message-Id: <20260805173958.660310-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MRgdQjHFXWe6M5LikS5sFHJ3/mAi74fArKyHILSFRHWIEj0Fu0XqcmVX
	HYz5CWC4lEjyE15dk+JakRIgXMtBpiU1cOHlBkuGSh+27SZldsUllBrQWZufNsV+1B6vNK8
	i0UbnpVILeoGrPeWfRuNy9BvNaYMnVHZhKC5jf4yO70xHyUHFI4BOFM1fCfnbOZp0pxMle2
	qMRm+HKz2O/7Eq+ZQBCPJ0ARnYk5NYzVKXserdfvllf93lFXioirpeB+1e5M+DLz/a7Coe6
	aR210TfLv5GiAXxWR5MzjHRq6GW6JAp1y5V1DolX0owkR11jAhQ+fdYkhCmWxPPBHyG7uoe
	yVvTIabyifUOPrcEymnUO4S7ZYET7HmfNHF+6FxSgND894pTx6FN5cD9Gac/NEHxtA7AZRV
	baJGZpZCRj6EulMwaJoTFTyaJgQffMjXHr80XoefxcovG2OgRzFPwYMBT/qtQTThf9XFqxd
	XU8XgmM3LvxMLodOAA2/AKs8NPiaplFvfSxXxZoZMiVz5zbK+r2eoaUOVsfraLQrXt3w4I3
	ADwemrfqAXE4getAKYteTsbRguUdDvYYm8I0F57odp+F1Owi8KJckEv91ZIVCKHAkNXa9le
	fEhCohJxmIMcoE4g/1+97aK3RHKYBouYeLeni8JY0BF6bOXGPZgQySYtr1dp29Y1nwEAYhV
	OV4+89BuS3wnZURxMa/BxACyp3z11SPP9FSTv4a34WPQ0bZQraVVFP5F879fTl/w+tl2ppM
	+tRgaH+h9ONjaJOVpVqXjNyeogcy7Cs3RExkRXrMIJUqJ7KatwbF0UMG8tdWBY72ox0CNxn
	WCV+RmKZUFzptCJgb3UH9DSLSm81vvn0/JJDOFbXH6sh1ErEsBnym/dqG+Mngl3l7pdQnU4
	s16YKFK5rjYQXKJA6Uxa74usu3IP8ho8cslJ5FB2m4fndE9zm1a3T2ILzmt/z656nwNfupN
	BZwmVoaC4pqzGJlCi2jVxk+Vo396x98NmBCYc55M5EOXxcBHYMUt/D3pZNGuufyFNW+pt/b
	vRYfhgulQl0HlsItyUoBVuEwrBq+NHYVk7zpVACes3wcbNd/WASh39Khe7IbIwoxOectMD0
	sF7xTZRGtW82CDUzHrBE2Gv4r24NEItRhs78A76pDaFlgpTyW7OO2HN3C0297ESd1r92EhC
	izbhSl8ZCIT4dpUNkQD+5ndkGyQSt6eiw825k0y1X0a9BrEr0KSX9fuGO6FkAAvDHioQ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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


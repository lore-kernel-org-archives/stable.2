Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C2344DB5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951766; cv=none; b=CoLH2NGZ3KcvHWK1TI4v1YRQTolC0Bldtxgd1cSd+UdxgO+bQhQBdRXuU6rYnKddiOTQw9X3aG83/qKpsQGs8v0nhGajfqyuSFwpKp2zNW0tfFZokB8D6+O3faVm5JqkmRfy2FgRiyEYDxRBor6VtBsJTjlosb6OnZOVBVwZHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951766; c=relaxed/simple;
	bh=T9ziZCIR/aRTPH46gvYVLdHJnVnNe1l+dng2RktINLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3hJshnBSjI7KgmShId9ZxJCTPqENHWu2tiAf6+RFj+nce1xpmEFyVsM/GgQmiyHTswIEwav1Rrwk43gGd7Ot+S6gO7LkFBes1KShZDJ4ryHgyHf/vLvuJ4/BAWdYdI5eQsmGCA+hWQf0MdzQ8wOf7lAd6c/+OhMdOSH17yCSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hTOZAoVt; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hTOZAoVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951730;
	bh=LtcYWX/Xn3kdKZh5VUDLXJ6KkFMsYOtAAJUigi6QiAs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hTOZAoVtY1T8e5YuTofN97C+dy5sCbZ+3ENsb9Rx6xNP+XTw2InuzwoK4RDIEt7dM
	 MgjKkuRm84oKknf7QweNxrS7NQ3AerXLPA2CwUeH4kawukOgtVLmecYk9yFVuGT4en
	 rzNzqw822F4W20Azw+udSDimz+zqHRp5leLJvZeo=
X-QQ-mid: esmtpgz16t1785951710t17e3afec
X-QQ-Originating-IP: qNYHNPQMbEWKqXGok5g9wFQ8DLQ2In3aHdnaiDOdgxQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:41:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12096282935761048146
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 6/8] net/handshake: hand off the pinned file reference to accept_doit
Date: Thu,  6 Aug 2026 01:40:02 +0800
Message-Id: <20260805173958.660310-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MBrnTbvXCMYvdTx/08zqhYQ9OFgl92WGPDpXvFkFmQnO/f4SWbI6fxXY
	9o6bmmcuHlSbIJHaVDek0FPUFHCrHoPm9NLhsEvcTRcqcwZ5Pf8FCe2d1yvqOnP+yru0R7n
	Ktw8fU1qMUOuPTJXs+Spl9qTR35kMmsgdxmM9LhUKpIJe+Axn6PYDuWR5m/6UBLZVUBhGWi
	h/4OjrL2JPDs6RD6Ixt/QjGo+ZYQbxJL+fHUPLxlAE/T6OKPoXAmVvSOL/gzaxpfwETEhur
	uy3Qgj3xjVb4HmU26H1I/RZY/upQSnVmPsL1f/7Ek7ezjCcHCn2wCjxDv5JPjjxBNgRuzpS
	odSmyuXFFcnOl59y+gFUqRSaEwJs8Wt4rcVZzLx2Yg50A287oJaCXaFVqCKX6p6or3Qec2u
	0U1qDQYI21QSX+xg7DqaToGJKrlNzQ7oHRmbI//NXxMQaGDxatFUh4ZYfN1vrdT1FwsYBNx
	ooVmQS0KqAFDr4WNrhPy5s2kS7BGJ68TkSQB4hSqdEkZ47wihKJoe0dp+mDksOsMFRyds67
	hmtH09vaBPIe1rCqF3dcYawNfNJoK9tJyfIdSzQAQQT5T31JMTVneo295f4JB6qiJSTeyvi
	+IvLz3WgJ4NYSj1klFEDF877yywZ9eUlye66wtbjslBijSgqPs8yRidiOaT4M3VmO8rC+pn
	ofns/8V+3gRhSc10IMS7BxuyP7JvCaXwmwDh4D9gcaKtp1qUk5g+OsykX6NJLBjjjHMk/CI
	/+VkS6W07UhoVmBmENMos9NUD5dKfjo7eShdDgKPLlYeJVmNOQKYvfqCs7BLU6PdXSX0NJY
	ql28SQsypwTLCs7+QUIwOkcrA93h/u11Mjm3k1AJNF65D/IaW2fgAZZuYpvNi9pC45LJmZ5
	INMCBW9kpzGu8yprOmFOC7jGWVKJyXmh2dm5n/ZTEffZ4TmltxiQtnkbT3IOKovk7ZkJek+
	6+xSMyZagBEI9A3tw647+M1yaFQH8yT2izK9O9zWAIyMQkLQorJhElPSb/LuT5RsrNZBfBO
	BcCS7Gpxl186iM8K000/yabbbDG6UdRATMuDzYp2g/s9dhdyzBy4+3Ix01qDORH9ye95LBL
	5Bgb+JS85fHu3vUit4pci+wTK7KDGCtrggvMLq/lfxkAZYuTpice0xZqRcFjg9St4l04TFq
	DrkqsIXr3Kh8V5nQgIZDE/+Zs4GGt6FdxqEHiTjvS8phOJYHS2TY4e8dsA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Chuck Lever <chuck.lever@oracle.com>

handshake_req_next() removes the request from the per-net
pending list and drops hn_lock before handshake_nl_accept_doit()
reads req->hr_sk->sk_socket and dereferences sock->file (once in
FD_PREPARE() and again in get_file()).  In that window a
consumer running tls_handshake_cancel() followed by sockfd_put()
(svc_sock_free) or __fput_sync() (xs_reset_transport) releases
sock->file.  sock_release() then runs sock_orphan(), zeroing
sk_socket, and frees the struct socket.  The accept-side code
either reads NULL through sk_socket or chases freed memory.

The submit-side sock_hold() does not prevent this.  sk_refcnt
protects struct sock, but struct socket and sock->file are
independently refcounted via the file descriptor the consumer
owns.  Pinning sk leaves sock and sock->file unprotected.

Retarget the accept-side dereferences at req->hr_file, which was
pinned at submit time, instead of req->hr_sk->sk_socket->file.
Pinning on its own is not sufficient: a consumer that cancels
between handshake_req_next() returning and accept_doit reaching
FD_PREPARE() takes the !remove_pending() branch in
handshake_req_cancel() and drops hr_file before the accept side
takes its own reference.  Hand off an additional file reference
inside handshake_req_next(), under hn_lock, so the accept side
operates on a reference that no concurrent handshake_req_cancel()
can revoke.  FD_PREPARE() consumes that handed-off reference,
either by transferring it to the new fd in fd_publish() or by
dropping it in the cleanup destructor on error; the explicit
get_file() that previously balanced FD_PREPARE() is therefore
redundant and goes away.

Update handshake_req_cancel_test2 and _test3 to simulate the
FD_PREPARE() consumption with an fput() so the kunit file-count
assertions stay balanced.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-5-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit f4251190e58b209999c1ba9e6d2976136a1be055)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/handshake-test.c |  8 ++++++++
 net/handshake/netlink.c        |  7 ++-----
 net/handshake/request.c        | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index df3948e807a0f..9cc7a95f41207 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -375,6 +375,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
@@ -417,6 +421,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1a5821eb71847..21d6cbd52fcdb 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -92,7 +92,6 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
-	struct socket *sock;
 	int class, err;
 
 	err = -EOPNOTSUPP;
@@ -107,15 +106,13 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
 	if (req) {
-		sock = req->hr_sk->sk_socket;
-
-		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
 		if (fdf.err) {
+			fput(req->hr_file); /* drop ref from handshake_req_next() */
 			err = fdf.err;
 			goto out_complete;
 		}
 
-		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
 		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
 		if (err)
 			goto out_complete; /* Automatic cleanup handles fput */
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 35bc6290e1203..4bf98793491aa 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -178,6 +178,17 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 	return ret;
 }
 
+/**
+ * handshake_req_next - Return the next queued handshake request
+ * @hn: per-net handshake state
+ * @class: handler class to match
+ *
+ * On a non-NULL return, the caller owns an extra reference
+ * on @req->hr_file.  FD_PREPARE() consumes it on success; on
+ * the FD_PREPARE() failure path the caller must fput() it.
+ *
+ * Return: pointer to a removed handshake_req, or NULL.
+ */
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 {
 	struct handshake_req *req, *pos;
@@ -188,6 +199,13 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
 		__remove_pending_locked(hn, pos);
+		/* Hand off a file reference to the accept side under
+		 * hn_lock.  A concurrent handshake_req_cancel() can drop
+		 * hr_file before accept reaches FD_PREPARE(); this extra
+		 * reference keeps the file alive until FD_PREPARE() takes
+		 * ownership.
+		 */
+		get_file(pos->hr_file);
 		req = pos;
 		break;
 	}
-- 
2.30.2


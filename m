Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8A3C3F7C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950426; cv=none; b=Dmgvk+5IQd0quuycVap9ZbM1yK2p8rgu/U8ZZJqZiZzLNa9gwZ3r9Q0CoQv0IjVJIYWGHOulN4LnSPHTPsG+R5C0IrKtfk+7MEEqxyU/Ef9h4AIUUd0k0y9gQ2peiI9bHnu3WP4THOvZ6gG4CPBM6x43+yc7iaCCkebVx+kWJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950426; c=relaxed/simple;
	bh=T9ziZCIR/aRTPH46gvYVLdHJnVnNe1l+dng2RktINLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPvLN5cXrKymPowvc4d8l2pNXn7zIUHi5qMMzTQuhXvfD9vTQ/xIT419vYk8gjXwrYHiizU7uEHSZxh6StkmpK2lq+IZwypQUv4RlKzxnvCNX9TcObv0IBYuOVD+TkLpv0TzRnQkOuEKa2X1GUtisJf2AaKo3Wbuc2KFnPvbEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DIbOwZ3f; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DIbOwZ3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950390;
	bh=LtcYWX/Xn3kdKZh5VUDLXJ6KkFMsYOtAAJUigi6QiAs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DIbOwZ3fNCT3SmjY+junppVnn6LxdvWrl0XDDY+AdMGGOqMbVbeL0IcBHC8eGQhj8
	 x/SI5I5GPEFBxXv4pYivzSE0IOZt/MgLV+qubR5kavUiRbLiiC0pHCcNYzQQMR6wLG
	 FBKCyWipC9tK4OE8jVwFsm5Kp6p/amSDpaRHGMJA=
X-QQ-mid: esmtpgz12t1785950371t783cd654
X-QQ-Originating-IP: BAacMoS+XR7MzRmiP1RUn3hOXPwnEwvoOKYIxBiuBH0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:19:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5019526471298216669
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
Subject: [PATCH 6.18.y v2 6/7] net/handshake: hand off the pinned file reference to accept_doit
Date: Thu,  6 Aug 2026 01:17:48 +0800
Message-Id: <20260805171742.654530-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OSjQccS6YHkH6/Y2nXztRhUpXNIEwonla8GIKPTaTyJdrg72AGaNv5DX
	gsCEdPmXwPxBGb0/SEzGKNElrU8A2riWTHk/FGSRVOx8W1ZX4mOs5La2kBSn39kx4suGjgS
	eRRS8Gji1k+WdC8WmOTYi5VuL+q2oitE7V3NX98CSw6HxXEP1tXBd9mZtfNbgimOmEpTC6q
	sMPiooGrdtyXjeRc2cDaEOTsluW6zCEXJmP1zsJFvfFHaflDsrmQrJDdBVT0wH8dIH/uc81
	MYc33Jns9bAoCNvqPt/M7tSzXTfwIPhTxyUrr1cscDliSXmiD5ZWAOfFCcV0UbA2K8s0Uwq
	d54KJ9e+SjnluJ6ZyEDWNdb1nQWqu1xeYXPtK+nP9lG1mjSLiSI3ZCbPxoD+dwJLczfr4ML
	aH+raMwEZ2GvC/7A7JApwzBqZkZUI594zXDn79MT6SfmH+o+mIdZt4KEY2QTfI1ve7K6lTH
	0Gogf5STw3LYjxioP2elntuxNV3RTE1uAq+NfLu3vLRtL23icmrclryxJsdKKr4tUeEGFpr
	B0wgp8RZaMnixT6VA084QbIcTHo5crFPbO0I2Nxf6CuUROxmoN6YKH8RcBkR/Jv/nYQxgRv
	wxX5IX3X87hchBCsw3k0yNK/gfrexUlGLnIACuH6bLZWOeAtrglvL7kW4eO7tAYz0wqUlwr
	5d2s+qEoF2MYLDYcfjMkih6UmtwV+OPQfYyask+uz1jQgnlbbikmx4cuh6ghYOUC5G7rrvu
	WyQyh6BtwuWd5Yk0HRK/+szAjarLE7dW6eQRUPSUYJc3UGQpC/6PBLzJLBX6YE8KkbTbR9a
	4fuTXC1HHcHt3FMXoENYSpTiiHQKCKOlmeIlrRWVRg1sFphJBpXxWoCmGL0vdSazT7PD2rI
	O/AUrcfhTwULJKcAEQzROQW2208S77ptJePrgjhH1UPCujRBDFYTd8X4yYllLD4y476cUqg
	kJdD2vqvwYkOg6Wfy0idG3+PN4/LZBHRf+XDxLEPN2GfqJlM+4oKp4rV5nzZXWxt0pOmAaP
	m+4jsndd8+vOfneZJg5x0ITWwMAXPgvSuk4FCtUaq8rd35M+pNPKgHQw/zUUXQMqvc6eQxJ
	FQnjoBbFUaf9HxP0iJ4ibCSJzeU+WNSY78pWTMy6JUX/ANVK6rWtkc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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


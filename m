Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266E3ED5A6
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921400; cv=none; b=q1wbepaeKMTj+ZU1y/TETSGFY/Wc+cPMyHfszzoUnp4AhMjHhacT74/wiCseOCLnuXAm5avBTSmqTfjGwNHd/SOXnDpPil7winL9XxCb9nChuunyBaFwZJvW3nfDI8a4F+nxYh4nfvLwppGx7X498NxRf/DPTLG0hInYiQD9wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921400; c=relaxed/simple;
	bh=aO5V/oNRCstsWebSCGGxHjY3EskvWtBnWudc3GDtyiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqrVxjbekiCGVfNz24c/kUjbnzNQ7F8zvKeB5RFihvlYV3ETMLIW8vOsyJAtxA6xm0nUSLCdpBmoSui2ByVBlAAsNkx6eMbJkPUFZYnH5V01CFn/fM9Q7J8DJB1JAfEomIsjO7zEanmsKh/MxcjBFym835MpHXHU+D07P61HNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=D2U4GcmT; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="D2U4GcmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921330;
	bh=aY+CRHV3CR9Ir2OubADc4Lu0ev8nDCeC8k0XH5poVtc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=D2U4GcmTiHugzLmRKU1M/YlAm86BmQ2AL/M2QfsWRBe9He5Y6p9UHCvHuU36nDDxq
	 llO8alnUfIZiE0V4CWscq7X3UgIII73lrbSWA6if/0zmDTJJbjeRzlz9qkKRh3hYkN
	 DABopuO44k71MvPYD3V/1C+6XCQtziLWn+dKAYPM=
X-QQ-mid: esmtpsz21t1785921310tbb058e1f
X-QQ-Originating-IP: hA9EXJc6ThtoAYG1dpkQnH8gGaFeNL4V3WwyfNrDX+k=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:15:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3116561549633193712
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
Subject: [PATCH 6.18.y 4/5] net/handshake: hand off the pinned file reference to accept_doit
Date: Wed,  5 Aug 2026 17:13:52 +0800
Message-Id: <20260805091348.609325-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: Mg90GDIyb2xWyYs25PsVxIAtHZCTdCIQd3bwn/YbmWzzlgpRymE4qzoZ
	Bd8pRSXPB76tUyTc1FLAiAf2dWq3EHkQ6WR9AcR7Fm1mQDtKD7KMEAzFuBAX5HnkLzk4Ery
	biUj1on6gftyqpUlru/KX0/kqcsyn0j67XlK0dZ1U6Gjd5V3oQCrWSCWOEurRSF6DCU1Fk6
	OCNT6zu1biSsrMoZbKmL4mwjx+QYAAWj8QBYWybryXNEPbGXdworZTodX3bCuoE9IDEcMct
	l7IItBuIrUuDrc39JEphla0CkPaZQUPBmePM6iOqYsm64xBc1mjfaEzLHv0tWn9TZQ9vbnP
	eUVeoKLyVp2/OaHWRVyF5u5o+DEvhOrTeF7PBILnvRiezdZN9eySNg1nIPcl5Gnx0HwKWYk
	tghUU2AgC7e61Efz5IsoCoJxO7f2OZCeJWYdXp8FVfHgPHf/vlNs8Chpb2zKq8JWTJEu4Ay
	mTLNIf7Rt9+vx7YqgDdvMcIvIhhpHITKqvOi+navS13lSSCfVbrTKBjRQxvVN0m53Y4E6TK
	rzGoUVWaLkfrKiyyVp5sNNZxaipxfbOh4p6In3z0cGlelA6yKjMhxV1fgj+DiT0nwjJUBU5
	8PSIjbLvxEl1iax5EJloX0kVyWUagswRLWtYMJ+TMMwjORMUSUkUzW0uA78Kb1+X/fGK7FJ
	1MrI+h0mdtX5wS3FOLfvRtV1FKv2iQqRAvOCD2S08F8W8UZtJBXtBhybd6F3vHDM2N95Rao
	ikfmEFygQM/wZ6vLeS/2GokAM5ajC1Z4IPBdga4pl/VBTy5ijGKkYhICCXL4XzUhtOh7Gg+
	XVe1r9wxQkcfIZCeZFr4KEIxZCm5McIzXtIxgvtMvgOIDFLqgmq9CdAbWQeDb7yzhQ9b5GK
	Yy5H926Vu1GRAOxlKCbZAECE2nWhJBHls6U3xmepPknJ7dD/Xv8TxcvDdP3j1MNJc27SI8t
	3KNzXtvaT6lpp88ZJdqeMU3VJG+zuZ3GFiAZjb+BBVkfzoQpkwjhSmOfnrg/o12zUVh0hyT
	e9GvXT4enPvo5isvcRLS0q8ShbpEzMootw+1JX8w+OBk/fM4Atu0gya9ENyfx15bOKd4vKZ
	kAdqpZrfkv1Z2ynv69hZYBsooqIVe3jgsBW1at8qMIgMdcdhHhMzqY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index fe4e22b87b3eb..67a78db7978aa 100644
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


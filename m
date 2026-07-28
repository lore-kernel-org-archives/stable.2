Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DD3B585C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262060; cv=none; b=ayvTQZ5eXaoYQnUIGZstu4nBsq7wQ/lpuZwxaUT3nmcsbOs4C7U/kXEbAbCHo1B031zbNUowbm6paWoenstwcT8xVVxwgymvFzMAfv4Afw3quuEGgHjDPkVlrL7C5k0H+iZQL3BwW5lFY9bRqhAnXadTf+SYsgThHuqwd/FQ9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262060; c=relaxed/simple;
	bh=MPdpnjXFEM7MrLw3ZQPjnI4WjYD7c3aZOgpcLMPmVkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b70214zkWYeJJGHKq8V6WuxKMa1Rh1HLCR24ME8y13Kq/9Aio1xWa9Xl4iQf6aJcxJ+jVeQTzvyC2czU7szIS8wFD06Ylb07IBDs24VIuNvBGXV8pKK2A7yNQXQcaFpgpEIq+kby/2BIuVmfCd9f1kcQ9Ck4Icl57zW4hwL5gfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfwitUP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfwitUP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F81F000E9;
	Tue, 28 Jul 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262059;
	bh=r8Jp89B51VWizuBed8FKPsQAOXjogn5WAWPm2PNJHMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lfwitUP/p87lFHPDpvoZDFa/Ffxph+Fl1XkyaOcx+SUp8DYkJrIbufTRmdfUOHu4u
	 tJFfIViAbm1Df/vhK3WkYlQeliUZeekWNat8r1wFO8qrKWZ0MHwrnABviQUYK1rlfo
	 CKguKcrWkcogGc62nnoJLPG1gGVnqaULu+vmiWGPqu2Z00hB/rpLMxxMz8JJ1ktX2Y
	 w+lHhoF+O4ZO1NVueTtjIMDB4fqU1IAxDr/sM0ojzh55G5IIuTDkfA2DWluBGBLkMJ
	 WFX8oJjox7QHfiqBK8EnTka0p3tRkRAEKxtl6j71gxVn4puwG1uAF22xnLVizFYHhh
	 dqmLzNe6oGEDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Tom Talpey <tom@talpey.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] siw: Inline do_tcp_sendpages()
Date: Tue, 28 Jul 2026 14:07:31 -0400
Message-ID: <20260728180733.291798-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180733.291798-1-sashal@kernel.org>
References: <2026072137-hatred-autograph-0bbe@gregkh>
 <20260728180733.291798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit c2ff29e99a764769eb2ce3a1a5585013633ee9a6 ]

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it, allowing do_tcp_sendpages() to be removed.  This is part of
replacing ->sendpage() with a call to sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 007800408002 ("espintcp: use sk_msg_free_partial to fix partial send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 6bb9e9e81ff4ca..d24442ca879321 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -313,7 +313,7 @@ static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 }
 
 /*
- * 0copy TCP transmit interface: Use do_tcp_sendpages.
+ * 0copy TCP transmit interface: Use MSG_SPLICE_PAGES.
  *
  * Using sendpage to push page by page appears to be less efficient
  * than using sendmsg, even if data are copied.
@@ -324,20 +324,27 @@ static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 			     size_t size)
 {
+	struct bio_vec bvec;
+	struct msghdr msg = {
+		.msg_flags = (MSG_MORE | MSG_DONTWAIT | MSG_SENDPAGE_NOTLAST |
+			      MSG_SPLICE_PAGES),
+	};
 	struct sock *sk = s->sk;
-	int i = 0, rv = 0, sent = 0,
-	    flags = MSG_MORE | MSG_DONTWAIT | MSG_SENDPAGE_NOTLAST;
+	int i = 0, rv = 0, sent = 0;
 
 	while (size) {
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
 
 		if (size + offset <= PAGE_SIZE)
-			flags = MSG_MORE | MSG_DONTWAIT;
+			msg.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
 
 		tcp_rate_check_app_limited(sk);
+		bvec_set_page(&bvec, page[i], bytes, offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+
 try_page_again:
 		lock_sock(sk);
-		rv = do_tcp_sendpages(sk, page[i], offset, bytes, flags);
+		rv = tcp_sendmsg_locked(sk, &msg, size);
 		release_sock(sk);
 
 		if (rv > 0) {
-- 
2.53.0


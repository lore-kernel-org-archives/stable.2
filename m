Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6623B3880
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687268; cv=none; b=Fg2FasrIsV9t0sSTg/GC4urZbjE7+uEnxeJ9ZSfL2YN3+EJSCa3tQyb6IQ3KRTAX1VGRLZ9YGW0JAipiO9SsDFCSYddsub8MuYffdBJkjcMEhp81scJ5RYKsTJFLWltaHv45JRQWaY1e48zLoe2LpaDWv2eo+KSUsM49j4dIHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687268; c=relaxed/simple;
	bh=6L1fp7bXilTZKsfJV3rTF/XKwILoKF4lGTqtJEuGuUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVCgx8TPgfU+6MVH41suhVOXXeK9GReG0QXhzgt1DZMZmPQ5vIhrIVM14UWz9w3jCYwGXERTdQXxjOnxuzsj7jTmJH9kk1fKyUOilO/9BlJq8+iZB1LOFCMhsDjnQw2hEbquepXpWrdDFTs56NmNr5Do1T+mgCQSHMNgTkF6AKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdpF24vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdpF24vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E2B1F00A3D;
	Tue, 25 Aug 2026 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687266;
	bh=4opHVt7uT49smtIAPskYz2z33g1Wy7YHssw+H3UWU7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdpF24vb9adSzCP+ZljrO+kTAll48V6DI5v7C2UMc9LFMFLUYSmpwp7zSBnN4ewKg
	 Mprt9e2Ab68zUGBgw/gmun6a4s4/a95Z+/oyuqGwu4xT/EnahozgnqTJhBgwpKhslP
	 LalYIObILxsfkW7IYpkm4UCtOpSMmiHlg/bd9e8k0qlg4OUyXydm7iYRAwYEia7f1C
	 iR8o1rSK1Y7k8DE7N5nZYUQChOiRgQUKLGtdxfW5KO7Pjo4t9VYA/9dMPgis+gA/Vr
	 5i5Xjp3Vr4JjSz1cEAdi32YrXMZNPC+BBmhJDGe4VtwJdOGuabCRB7TxwqAdswomOl
	 vaqeIiWYJ1gqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] io_uring/rsrc: improve regbuf iov validation
Date: Tue, 25 Aug 2026 15:47:43 -0400
Message-ID: <20260825194744.374948-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194744.374948-1-sashal@kernel.org>
References: <2026082449-reapply-disdain-0fc8@gregkh>
 <20260825194744.374948-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 2e02f9efdbc6c73544e315b7eb85e55a59776b6f ]

Deduplicate io_buffer_validate() calls by moving the checks into
io_sqe_buffer_register(). Now we also don't need special handling in
io_buffer_validate() passing through buffer removal requests. I also
was using it as a cleanup before some other changes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: cd305ee3633a ("io_uring: defer eventfd signaling when queued from a wakeup handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rsrc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index dc87c6a86e346..aaab927ffd1d0 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -94,20 +94,6 @@ int io_validate_user_buf_range(u64 uaddr, u64 ulen)
 	return 0;
 }
 
-static int io_buffer_validate(struct iovec *iov)
-{
-	/*
-	 * Don't impose further limits on the size and buffer
-	 * constraints here, we'll -EINVAL later when IO is
-	 * submitted if they are wrong.
-	 */
-	if (!iov->iov_base)
-		return iov->iov_len ? -EFAULT : 0;
-
-	return io_validate_user_buf_range((unsigned long)iov->iov_base,
-					  iov->iov_len);
-}
-
 static void io_release_ubuf(void *priv)
 {
 	struct io_mapped_ubuf *imu = priv;
@@ -317,9 +303,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		err = io_buffer_validate(iov);
-		if (err)
-			break;
 		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
@@ -788,8 +771,17 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base)
+	if (!iov->iov_base) {
+		if (iov->iov_len)
+			return ERR_PTR(-EFAULT);
+		/* remove the buffer without installing a new one */
 		return NULL;
+	}
+
+	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
+					 iov->iov_len);
+	if (ret)
+		return ERR_PTR(ret);
 
 	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 	if (!node)
@@ -895,9 +887,6 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 				ret = PTR_ERR(iov);
 				break;
 			}
-			ret = io_buffer_validate(iov);
-			if (ret)
-				break;
 			if (ctx->compat)
 				arg += sizeof(struct compat_iovec);
 			else
-- 
2.53.0


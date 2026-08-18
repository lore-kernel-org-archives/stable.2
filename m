Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E445629D;
	Tue, 18 Aug 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049255; cv=none; b=RyO0K8d0h9Oww31HiBJ5VTcPzwNrgrSffR8nJQ7mrok9XCUKvEFZhEtwHwik3cAM2gfM7q+jj7bxQefd4yMdK5MbzoyiUxlVezuKC0Bml7bkwb2KPhiG42UnoTtvuwud/G+Ko0rIHpfPxxrFMq7yg42hHRZCrGgSFhCt342eDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049255; c=relaxed/simple;
	bh=CdsGXzuS5WYUffl0vEgL+7KXN1SZOZo+DZQ4sjpdEVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osIArw2ZR4p1MOrNDQb6AMmtT0XoNHduhAKZ/ifR6FRNUWuagfPsVVUp1NWa54MFrB+8VXC0BM41v4kDUom9948vDt4CKAJfeDUf8fM5j8CqNwh6InOSGOgkK6BQQ6glJpL0m1YfunP/GNOXhSuWeFuH2yEROKPRCoFYfYpzfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lR8jYMvj; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lR8jYMvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ld
	PS+i+oSLCLJZksf+v7DOeHEUeYfNNTYd9ktbe5PX0=; b=lR8jYMvj8mnbz0rvf9
	rrSBahExCOxesiZRqVwvWtzHr26K/HS0GrAhz8mZ9482qkEB10S/F21ZH6ejwtfH
	Fwxn1I2XhKtsHlUnX53a1YeSLSJPNwQVGtpUTThMJcwMesCU0M/i9gClybky9zFb
	pULw3UpEsFSt71HY46p6/E/W8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAHZRoSNYRqYKrWPg--.62509S2;
	Tue, 18 Aug 2026 18:33:55 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	gganji11@naver.com,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/waitid: avoid siginfo copy during ring teardown
Date: Tue, 18 Aug 2026 18:33:37 +0800
Message-ID: <20260818103336.1922818-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818103336.1922818-2-sh_def@163.com>
References: <20260818103336.1922818-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHZRoSNYRqYKrWPg--.62509S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1kGF48GF4Uury3tr1fJFb_yoW5Ww1fpF
	ZrCrW5GF15XFy3Ka1vqFy8AF1fZ395Ar4xJ343G3ZrJryUAw1qqF48KFyFgFW3AF4kAFsI
	qr4vyrsxWr1jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb18DUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hMNbGqENRPujAAA3y

During ring teardown, io_ring_exit_work() cancels outstanding requests
from a kworker with a NULL tctx. The waitid cancellation path eventually
reaches io_waitid_finish(), which copies the stored siginfo to the
userspace pointer supplied with the request.

Ring-wide teardown does not run in the task context that submitted the
request, so it must not access that task's userspace pointer. Depending
on the address and mm state, the copy may fail with -EFAULT, but the
uaccess itself is inappropriate from the teardown kworker.

Use a no-copy cancellation callback when io_waitid_remove_all() is
called without an owning task context. Complete the request with
-ECANCELED while releasing the waitid state without touching siginfo.

Keep the existing siginfo handling for explicit async cancellation and
task-scoped cancellation.

Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 io_uring/waitid.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 7a23befd2579..1211f905a9db 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -146,7 +146,7 @@ static void io_waitid_complete(struct io_kiocb *req, int ret, bool copy_si)
 	io_req_set_res(req, ret, 0);
 }
 
-static bool __io_waitid_cancel(struct io_kiocb *req)
+static bool __io_waitid_cancel(struct io_kiocb *req, bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -162,21 +162,32 @@ static bool __io_waitid_cancel(struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	io_waitid_complete(req, -ECANCELED, true);
+	io_waitid_complete(req, -ECANCELED, copy_si);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
 
+static bool io_waitid_cancel_cb(struct io_kiocb *req)
+{
+	return __io_waitid_cancel(req, true);
+}
+
+static bool io_waitid_cancel_nocopy_cb(struct io_kiocb *req)
+{
+	return __io_waitid_cancel(req, false);
+}
+
 int io_waitid_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		     unsigned int issue_flags)
 {
-	return io_cancel_remove(ctx, cd, issue_flags, &ctx->waitid_list, __io_waitid_cancel);
+	return io_cancel_remove(ctx, cd, issue_flags, &ctx->waitid_list, io_waitid_cancel_cb);
 }
 
 bool io_waitid_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  bool cancel_all)
 {
-	return io_cancel_remove_all(ctx, tctx, &ctx->waitid_list, cancel_all, __io_waitid_cancel);
+	return io_cancel_remove_all(ctx, tctx, &ctx->waitid_list, cancel_all,
+				       tctx ? io_waitid_cancel_cb : io_waitid_cancel_nocopy_cb);
 }
 
 static inline bool io_waitid_drop_issue_ref(struct io_kiocb *req)
-- 
2.54.0


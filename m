Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF32D9ECB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966592; cv=none; b=B2ExqzCRXPX9Uli7DMOmEWIUsyqL4YD7IOs0kmzVNRg3WSo4g3yHQZMvAK0JmFTRmtnbnZlzK7SdRGUzHrUu1hXrX+bl/Q79HBb7B6F8DGQ0AjMa7llhBDwqLOAngoEV+Hp8NW660cP88QX0crQoeJLi6cYSQG2qQJ1KIzdkTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966592; c=relaxed/simple;
	bh=Kx6G2kiTSLBKU7whTLHQi0HOQCfbXfPw5t1J01GVSLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej2pw/Vn9oqsAzARrVvLBLB1ivSrZInW60hP7ETfehpBUpmLD+FX3+umPPJf5inPF8tKII8y3BpI3JtQA1vYSy0fzdyVr5F+hWV9O/QsXSIch2mQdaFfgzZOjA1GX3v6MKRa9hTF2jGBJB2XvOv2y4Ip92j+vxb86tKHrtszQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmMBXHcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmMBXHcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB261F00ACA;
	Wed,  9 Sep 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966591;
	bh=cHEo0eLl+LXbVDN8i7gzyn0VPfzrmlpOy7Kxe6agH+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmMBXHcdnWyWyoOVkv6snq8za54i5coMkDxM8ec9w7i/ZpinlAFMPYyi6P6fqAmFX
	 6vmBWyks2hSLa6GF+5cs3IuhhcQozCdAMly+v1J8UbRa0E9HUS3uUAIdxHAHd3uWhe
	 HEOHyXi+aQTo6GFOYTwDO1qEPlkTVed3MjE1Ztu5sDcgYvKYqVAS5WMGHRQ1mY+v7N
	 zZixf1NCmje+tAkOTLPUGu9fodh9XktNadgrW8bZZU4oQ4TNg/nMAynHczmV1va9na
	 JKaDoYDaIJo+JUsktqRMQBdyFLmOmOMi+GBOcA4rqfOOEgPEfCyyq9agGL1EE9yRdz
	 ygeM0A7lNXPmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] io_uring/waitid: avoid siginfo copy during ring teardown
Date: Wed,  9 Sep 2026 11:09:45 -0400
Message-ID: <20260909150945.2815896-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909150945.2815896-1-sashal@kernel.org>
References: <2026090354-alabaster-robbing-fd51@gregkh>
 <20260909150945.2815896-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 2cf20c4e0f72d523b8673053e7120d092ff1f074 ]

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
Link: https://patch.msgid.link/20260818103336.1922818-3-sh_def@163.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/waitid.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 309f0a934b575..41d5eed6c5723 100644
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
2.53.0


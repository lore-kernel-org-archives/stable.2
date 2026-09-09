Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB42D9ECB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966590; cv=none; b=Ln/CoEwQHvb5GAd6+5cFXrAE5+eGox2rR55NsrDKjWDxBFc8GXJ3QUvzo+Q7v+W8+fOGICrChuHJwC7u28VvfQeWPxKzgbEPjnesdgxxahuR6p+AEGLf9MBuF2X/LWjyT6hOtqPS1+1LNXf7E9XFQaWxw0wAQQR73yMhS3TODLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966590; c=relaxed/simple;
	bh=2MvJPkKPsrn/XS5VKFE7gS0pw1KYza7cPnvO8GczXBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEhipktxih6jsglS75wl6fmPrdCrdEAHrPz0ktfQJPDM2lKsQk7tHEULpLQlSbZxk/o822DuZfqE5HMhwKfiLhmX/ce+Vz5iqNcFyg0Y0SSkg0iDczQd1LGQ3HbeFU1mFLhiaryR3X/SPvO2O304XGRX69If7QjvOdTYEoIqbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daCrJb53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCrJb53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE5C1F00A3F;
	Wed,  9 Sep 2026 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966589;
	bh=P165J0dJBNQxpYsA95XytYgF1ZsCjmXvvzLP7PHsQ0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daCrJb53bs12Q2SfMfWrI/x6R4EkIouK6Qyb7CvdZCy1BJcEBxNpTgO9qwTxlS98U
	 es6HC5nZBzYUdW/ZZXK/CoFefroO8KAvtQIwcqQCwNegJqZxRjadgiq2V9Q9zT9o7U
	 4WMgRNRxpnDFJTgZeufercPZQ0Svx8e1Nxsq6rB+qF3TYNkD4d4XMngc7/g6K3ZuhZ
	 JhNDTowC8A9axcaNM5pjwAwxEfj8mCxhfQjD8x3uaShPE0VQVd3D/2rkXeSXOPLqOM
	 7LHUtyZXrmaUh+QxDJth/8U3X9zc9935X92q3W01nYFbdjr68jhkH2ROzkrkPKJsFI
	 KGbx8KCVBFvTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] io_uring: only call io_should_terminate_tw() once for ctx
Date: Wed,  9 Sep 2026 11:09:42 -0400
Message-ID: <20260909150945.2815896-3-sashal@kernel.org>
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

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit 4531d165ee39edb315b42a4a43e29339fa068e51 ]

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 2cf20c4e0f72 ("io_uring/waitid: avoid siginfo copy during ring teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d59a750e5e89c..7c0ef8f04139c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -292,10 +292,9 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
-- 
2.53.0


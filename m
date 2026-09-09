Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57A25783C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966599; cv=none; b=ibVfqVp/J7qOxvfjSPvBoJnaWZSZGD2SOryFBe8kOROvbO/hiXNdVpqsReSTxRSSmQXnY9k4+ou7vDmM9BI/X3UzXN4VjpzcUEyqJojYWi42Z2e9t/2OTsK3CFCWGcaMwJjA2KPVQiTxxj7RwGe04p4eabg4LnWD60n0p5qw3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966599; c=relaxed/simple;
	bh=XJ/FUc83tslN2+gvNaNF4a1ETNJ94RSpP6jahAFZ5EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ+rw2I+7ndPkSf+e3crytjc+sVdUz6d3pj3s8h7yyjehznrU0b2GoRLBcqbLxKkwOVDgrXCi8bgqbWV+ldsIWzio6Fq8rA/72GP6AAgH5SBPT0MuyzTePbxQLaiaa1NasKWSC2c6ByP6Su6EOHYhX+PVzWUjWU6WFeYpbf3aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWLTFMF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWLTFMF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEB41F00A3F;
	Wed,  9 Sep 2026 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966597;
	bh=FZGiuCDts4Q2MtwroRly9/O3f3dBWOyAkJ4oM6g/iCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWLTFMF+rOalGo6hit1ldLVkgvTOaQI1uQnv2cmAaAt4ncspwXSKk18LQKB9RFgEU
	 1eO0v6c+kdYXIMQVtfyLaYl1AwNmhoIEVzY11Y8N4xRc66usnFLqYpGv+URAmcRhOA
	 1nnIq4lZAYacpczHF33HCWnOo4EKpBrZPLlZvByo21t3/2a47QvKY4Ce1GJMGakiQm
	 mAuiRGF71waqjAA2MklJMO5tQE5Tess3nyOzOecLa265gYLvXBUecmnWtk0WfDWIel
	 sqkXNH/MgrV3F/qrUGWSBwzZCvt14iC09jZYGbPkoiG6w8Sass/ZG5Nmu7X3ivpSWz
	 XZMhxKRvdn59g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] io_uring: only call io_should_terminate_tw() once for ctx
Date: Wed,  9 Sep 2026 11:09:52 -0400
Message-ID: <20260909150954.2816677-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909150954.2816677-1-sashal@kernel.org>
References: <2026090344-mooned-reconfirm-9822@gregkh>
 <20260909150954.2816677-1-sashal@kernel.org>
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
Stable-dep-of: 14572de82e50 ("io_uring/waitid: honor task_work cancellation")
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DD43303A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115627; cv=none; b=Z4MhEiITbTpCVu8bJgRaW9hje8uYXFgvYgqV00sPLcqhwK3spDmK2GlMJ/XQpMtV4ECR6diyRvS3ry/4NAMz6EOH6xXGhECgRyxjTbHQxb2oB7Jx7c+qGTTiAXl/WndaS45uJwIH9Z9WQwAjEpITlhoQGGpjXynFuCLWLpqgIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115627; c=relaxed/simple;
	bh=sIxXvNI9OBBFOr+5tk8wIXJAmXmqGlX6vGJgXDsYjlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYqOGdmy8GWtN/ruXARn8jOiL37SI6FxJxnbDqlpynB110fHHikG7/nmNV/wJvT+Mh+Bnz/NinZbAAgF/KveM7agL3sKncBwX3VLxFqmoYmlBQNaWLxlbJPs3M9tJ3+cJDRkyoTNshtWciGqnB4N2tBYhOdmyyIV0pC1pcjq53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaiOJJpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaiOJJpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D60B1F00A3D;
	Wed, 15 Jul 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115626;
	bh=7foHQ87lxEB1eudb38AO7hm9RxFZSdtOLpakl49oElY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaiOJJpz7DsXnxeCr47wZJJLGOxE4sxL0jdSOmM9ZXovBGlh9vxTtlWreBzy1aiwJ
	 o9N/ukfxGuCpnT8ZJ9763pGqvcQr60RnFhELkwlykV9iJhdtJQLHu5LJJiRliLPMqB
	 4Gv6slebRQYmVE+XpPF2qFdf2NkwQkBWOUqVh/eDNtA+mCJXz3PN5zwvGwTTenHcfK
	 yWcLWxkN7X1hOWYuNGFGC++ymoTYicD8EYn+c24DWUhk/dprg4s5yNcPUk8jSBeELm
	 b2I6UF585p83w9qAh+Nom+W5b/aVJkqWoEZaz/VHiEd12AxkGMG5hFow5cTU3IPwml
	 zSjqcPL/hmvHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Wigham <michael@wigham.net>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] io_uring/rw: preserve partial result for iopoll
Date: Wed, 15 Jul 2026 07:40:18 -0400
Message-ID: <20260715114018.726395-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715114018.726395-1-sashal@kernel.org>
References: <2026071357-gout-canyon-b50f@gregkh>
 <20260715114018.726395-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Wigham <michael@wigham.net>

[ Upstream commit c554246ff4c68abf71b61a89c6e39d3cf94f523e ]

A partial read will store the completed byte count in io->bytes_done.
The regular completion path applies io_fixup_rw_res() so that, when the
following operation reaches EOF, the number of bytes already read is
returned.

The iopoll completion path does not apply this fixup to the return value
and can return zero instead.

Use the fixup result when updating the CQE, and the raw result for the
reissue check.

Cc: stable@vger.kernel.org
Fixes: 4d9cb92ca41d ("io_uring/rw: fix short rw error handling")
Signed-off-by: Michael Wigham <michael@wigham.net>
Link: https://patch.msgid.link/20260613225240.34032-1-michael@wigham.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0afbb1ae76618f..a744cb5d235a6a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -546,15 +546,15 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
+	int final_res = io_fixup_rw_res(req, res);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
-	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req))
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-		else
-			req->cqe.res = res;
-	}
+
+	if (res == -EAGAIN && io_rw_should_reissue(req))
+		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+	else if (unlikely(final_res != req->cqe.res))
+		req->cqe.res = final_res;
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);
-- 
2.53.0


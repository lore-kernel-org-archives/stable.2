Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E93515DA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687267; cv=none; b=gFYfYBFQMYpGS9UAbRZZEYhB64xevmBH3pwOdmB7vJW5RiM4eAZ0PkNgAHDT2r5gdoMJd0mi0LM5BYJqQMM1XPNpfDPsWbVCCydLx0WRVmlFbgriIQH7zxuX59Zt1mnFQzaKFkbHMpZboPICTGJNmS8y9p64I0uKzGQuHT/Kce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687267; c=relaxed/simple;
	bh=aUq0PqSz5G17+BtGRUsQI32M5kw2YgrLVkgUxOj0YL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thpC0PnDpcqHf/GS1V4vHO16bdwjd4XzplX/IhrViYDafL2n2dxot8epqiizHtK4aup2ll3m5LHLq8APXfYI2WsOUQEDGW6Jv4wAesQ1i12upJqbTmGIhq1SV+hynfk6LqSY3eWr5lGFtdEUTckGMjZXEsGpAj0H5NLUu38GzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fguAroLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fguAroLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D4E1F000E9;
	Tue, 25 Aug 2026 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687266;
	bh=WhpgyOxUWz6TM2NHkeI8AH+zvEg+EhEwqiS5XMOu8Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fguAroLHw3HLPUj8qqdxq56vCYrkNzq5Vos1P21Kp/ZUoryh39FAlzIG1H1UG7D8C
	 /MQ/qJapV72g7C1LSpL3sjDnBoNg11BucVLspC3jGtC3BhgD+XRlF/6AxLwQM7mJgR
	 dqYzvrw5l9s54j2LNpH/9Jzm8egYBE0HsFIM1Iy5J0Jlt0QwDY6uB4I/R8qczUxNTt
	 mhixGYnW7Djq1M0WjOCxMBTtkJoUxLxo7sRcjpPVCoXxtjRY44EfFEb+6ktxB7JAHA
	 KwBgrANjdymPdATIEIo5/AxteGeUU1qPt3kAhgMtUdhoU4IOrCbYQHh+L7HvAQ+YuB
	 /+QwZ599jo4Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] io_uring: simplify IORING_SETUP_DEFER_TASKRUN && !SQPOLL check
Date: Tue, 25 Aug 2026 15:47:42 -0400
Message-ID: <20260825194744.374948-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082449-reapply-disdain-0fc8@gregkh>
References: <2026082449-reapply-disdain-0fc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit 7cb3a68376da0bc0afab8157223cb479c97de9ff ]

io_uring_sanitise_params() already rejects flags that include both
IORING_SETUP_SQPOLL and IORING_SETUP_DEFER_TASKRUN. So it's unnecessary
to check IORING_SETUP_SQPOLL in io_uring_create() when
IORING_SETUP_DEFER_TASKRUN has already been checked. Drop the
!(ctx->flags & IORING_SETUP_SQPOLL) check for the task_complete case.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: cd305ee3633a ("io_uring: defer eventfd signaling when queued from a wakeup handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7f398c4a3a6eb..1dc160d86ea74 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3867,8 +3867,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		static_branch_deferred_inc(&io_key_has_sqarray);
 
 	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
-	    !(ctx->flags & IORING_SETUP_IOPOLL) &&
-	    !(ctx->flags & IORING_SETUP_SQPOLL))
+	    !(ctx->flags & IORING_SETUP_IOPOLL))
 		ctx->task_complete = true;
 
 	if (ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL))
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16C38AC65
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672027; cv=none; b=nW0w/j4dYPoTuqMY7zzlEE2FU0HupgZI2rMZNkXf/lsYtuqt3OHY84xo3Ps4yP8aXlIMxEOIxR4YTSkNvObL6Xsj2VSe0442EZEQtPlu/RwGw17Q9BZayJRiEhp/ok8dZt+axEaCaRAmkWsuCco86h/x3iWr0bjS9F0pvWIotXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672027; c=relaxed/simple;
	bh=BogmlU1c/VU2y2dV/UhqrY6+yHpyOvxY6yzJnYlUx4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYqlWgeT5OyztZx3cro+oG1tDd48LuitET1DNY3HLuofdvNMwWNo11zW+goOzc1iWzHfqp03Sb0O1WliJ51fcI5EhdzALKaw3W9Q42Z7iLxT350TtfjwRKEHkdrPflx3Jz8vnoQapjsOhXYIzTRk5X4qhKcYEE2Udzqlq8F4mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOfQ62LG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOfQ62LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796261F000E9;
	Tue, 25 Aug 2026 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787672026;
	bh=FT5W1IxQyn0ruGWwYFYLJmhHeKl0bC7FC++SbnDTLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOfQ62LGqYZWbdbpxiOHUK2s/ckPJFKmTmeH6oLh/2Uezz4T+qA4fj1LMN4hqrp85
	 R+bBc9tUixj7mANTxIxb+Vb8W9293jDbdMyDLjRciOB8bDqi+YubRxE9ejZT+ctMGg
	 4FO5A7l92r85t2vp98ueGCeRZCGR34PWt0iUWNfkOvmf/32mZATHItmL5Td2W14upZ
	 A7B2wn1l7Hz57+LIf9ddTuWBbgrowIqxnMm/Ye9tfnw86J66RaHj3Ie35G2Dk6cOCX
	 dICOTU3qCse6ccfeUPbBY0kiR40aepPDERpAdCO0fO7JaERB3LmonNAGDBr3kCZXDg
	 o0aX0m9PhNzYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Chengfeng Lin <lin2530632123@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] io_uring/futex: don't mark futex wake requests as inflight
Date: Tue, 25 Aug 2026 11:33:36 -0400
Message-ID: <20260825153337.4067089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082442-slogan-feminine-7a8d@gregkh>
References: <2026082442-slogan-feminine-7a8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 73e7019097473fc9f83a334ef2c6ab3343709fef ]

Commit 079afb081c42 ("io_uring/futex: mark wait requests as inflight")
added inflight tracking to ensure that do_exit() ->
io_uring_files_cancel() finds and cancels pending futex waits before the
mm goes away, as a private futex wait depends on the mm private futex
hash staying alive for the duration of the request. However, as
io_futex_prep() is shared between FUTEX_WAIT and FUTEX_WAKE, wake
requests got marked as inflight as well.

A futex wake executes fully inline at issue time and never depends on
the mm staying alive after completion, hence there's no need to track
it. Kill it.

Cc: stable@vger.kernel.org
Fixes: 079afb081c42 ("io_uring/futex: mark wait requests as inflight")
Reported-by: Chengfeng Lin <lin2530632123@gmail.com>
Link: https://lore.kernel.org/io-uring/CANGjgdn=R_qyUdE=j9za+vkmqcxacbP-84OHXF4nZ4ho9qRyVg@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 4d327bbd1cd2 ("io_uring/futex: only mark private futex waits as inflight")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/futex.c | 11 +++++++++++
 io_uring/futex.h |  1 +
 io_uring/opdef.c |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 64f3bd51c84c6..57a17c6942219 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -144,6 +144,17 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	    !futex_validate_input(iof->futex_flags, iof->futex_mask))
 		return -EINVAL;
 
+	return 0;
+}
+
+int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	int ret;
+
+	ret = io_futex_prep(req, sqe);
+	if (unlikely(ret))
+		return ret;
+
 	/* Mark as inflight, so file exit cancelation will find it */
 	io_req_track_inflight(req);
 	return 0;
diff --git a/io_uring/futex.h b/io_uring/futex.h
index d789fcf715e38..987db3f2c6d9a 100644
--- a/io_uring/futex.h
+++ b/io_uring/futex.h
@@ -3,6 +3,7 @@
 #include "cancel.h"
 
 int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags);
 int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a57c820567f77..0a3b684d72d80 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -466,7 +466,7 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_FUTEX_WAIT] = {
 #if defined(CONFIG_FUTEX)
-		.prep			= io_futex_prep,
+		.prep			= io_futex_wait_prep,
 		.issue			= io_futex_wait,
 #else
 		.prep			= io_eopnotsupp_prep,
-- 
2.53.0


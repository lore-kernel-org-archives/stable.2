Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DB371D14
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194581; cv=none; b=sSSyuPwknpBd4Va4ZSEdUpBwGp8SOyuTwluPiJm/pA9FkOzNIrWg484Qno+X61Z6URL/jlIatvfP1EzD9LrXf/JHtZODOafPVVHgV73tazmEHA3NXqBSBqBFb7oMMMgMVm0HFY9PETLdhFuTwXHWbfzfdUtblLREurwq0j4OqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194581; c=relaxed/simple;
	bh=D00FTn24lOrDuKH6Zd/5lGqie8sQ6wGZiMqX0rUuVtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGC8GCBVnRipSTr/LHhlRLPeocy0Kh41254PSnwxqkR2tvZuTija/39Nl6lQUrPDbUJyCHNdDUfJsU4Og2y7b6DCOn3n+ayQDtABfZneedcuU7Nko0vjSqxH5v0DZ+zYZggwsvenMnUuN2MkAhCtVSNy1pB9NE6RxzrsM7xwTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ50VO42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ50VO42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4E51F00ACA;
	Mon, 31 Aug 2026 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194580;
	bh=cmcXy159io3U70OAvl2yu76g85R+ZwNxgd7xDrpP8J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJ50VO42y36dJJlxXbtaJrZ16Wln6OJpu0nQtgk2pWLy9ZPrsYUKHlmKLLKIKK0T2
	 VPYf38TFei9hXnargO7xjcSmJGHPMcOieuLYMJoJVbLt6EiaNGt35tAd6cb+oHvOtP
	 re4vG1RWIEiPwamHGoYcOg56BLifL/md1KHkQnDn2kSjqSXiNaBMqIaOBuNsKgl+5m
	 yWTtnYxtpkNVXwAeAYWUSfsKZprd4GwvUvWjWA+Fc106+SYRMsx/9OKer8lRiOsA6d
	 2aZYxJSwdRAJZeJdfBkLrwljV015UwXeb96y5UclMDkNXNr7HSrOmJSWTctLdHLDWb
	 7tkFFGUqBw20Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rochan Avlur <rochan.avlur@gmail.com>,
	syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
Date: Mon, 31 Aug 2026 12:42:56 -0400
Message-ID: <20260831164256.270090-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831164256.270090-1-sashal@kernel.org>
References: <2026083101-rimless-sadness-3898@gregkh>
 <20260831164256.270090-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rochan Avlur <rochan.avlur@gmail.com>

[ Upstream commit 64b0b5cacbd2fea88001464cb712c9dfc795b26e ]

The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
concurrently processing the same request (FR_LOCKED set), the caller
frees req->args while it is still being accessed, causing a
use-after-free.

Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
returning early.  The wait will not hang because fuse_abort_conn()
ensures all requests are ended.

Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 50012b0b1258a..9f1f81e66cace 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -580,7 +580,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_chan_abort(fch, false);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -591,6 +591,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
-- 
2.53.0


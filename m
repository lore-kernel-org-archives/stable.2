Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B63BB13D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394412; cv=none; b=FKszVnxeTZKlyhEoAaqaYuNoFCL3TNYLOdJXXcAqgfZBe8x3HZ7Dcpi6oU7ndXGWLu5rtcGOSfzldJBMCqu1gNnnKnaxRrpts2m3HdvxwXvRqzddfyRVpXszNzulhSK4L2wCsFgRtzP0oaCzAuXrzQoFA0gL4ILsgKCvOSvIzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394412; c=relaxed/simple;
	bh=677eW36uFAlhwvcNy5Rv6KDXVIDYKumFBKah6KoDO6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aObVtod9CCDHL78KKULGr90exT6GihTsLLDJLGl2GdFzr9hgy5qMLyAGGZnVAGDiZoQiSCQ40JjeF1Q1ZhS+dlFTAa5hZR5izbM+fJCUOorPvAyfNz/uOHrZin9MdaSraK/kcLLL7RN1PVGk+/ekV5aDp2y8XJgxrBUdyN6GC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/H1bayE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/H1bayE"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so993655a12.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394409; x=1791999209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVifve+wTTU+FFFuQhgCruNKhcNcDfydOFbFRWXOG0E=;
        b=O/H1bayEoHIDCV4xuTI+WrLGVlYlWzUdGZNE3d9WTIuqULqAD2AMX2nY4oZpdpv9w7
         ECDYfiYKB+vKLURREYIb0dP6jwYngm1peFVy0MBCKwaIXQfH2F3dNQe2HddTTJQGzIO4
         OUZnFrqnc+CqutmXEoof+q0JoSMHMH17QJxUpv+aWeOFafd2Bt56sSsKdFNZCoJ7neyy
         XJalHmDJ9UunSDZ8pOzhevQj1EG9261kfWfpl7TwKzojOdXS3aR16D40xZ5EwNgPNuFH
         cioDA9CF9IIsPhPMQjzaGe0sWFHQQ4dOlMMmR1gSjn/uj+SdNz3+OBjYKzJEbce0rWIW
         a61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394409; x=1791999209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVifve+wTTU+FFFuQhgCruNKhcNcDfydOFbFRWXOG0E=;
        b=UWYzKrvv0N8K3KftuT2TWSFnb4t5Zyn6jc7fa6cclnN4BRtBelsrctQywgJ//GdUr2
         qNhUzlR6FEzmdnJm/6B1XhG9BEyyjQh/DETzjZLtW4AXFEAATBOQIEORG/5ptHYRYCxr
         RwYRYHhPs4iIPULBLdaxTlo/z4camTgYIwyrNZIJwZyuW2smzrrVsAAbR3rFU1zWHvk5
         +y3TFZPkm3JHprKzBXPxUvC426hBmMCUod5HVShuVly4fskxUr+Kv57AAYmzlc+eGqHR
         q5pa0tHzMKZQlKRlt1S/39jlUXObVfj4IpuubBY9ii6828TrxyryFwKjutO2gc4Agb2y
         tcvQ==
X-Forwarded-Encrypted: i=1; AKwUvByMiSgcNyMUkRWdqmcDKyATs74NSp/716pw5vtF/6fD0UgagWvtzzdwHl3TBbLvURgp4RzVpGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIajClO0/iMSqo1LWv8VYyuY/72IcRB8rBkh12d3XwbJvksCMN/
	BTCchQgQhj4MhDfzXH+pwJv7gW7UlWl9SvaLUDfzTVofWQt63+i1xMWm
X-Gm-Gg: AYBFou1NDm7VU1RwLtUO88dbv6BHoDh3VREzUf6xMOvR5pUgn4tj3IELilKMF6M1ZdT
	GRiEXnfAj4Za1uMMPheuk6nUjxlWJvQr7r6tVoPJv9VFPjgRLLe77IgsfsIV81sKjHSNUr2gitm
	qs2T+uPrMLzI4INK4S0DfXjhMi7M30e9j/8AJ9/m0umYlcFprhbWhZkf+czMTGO1UwOa1z/eb38
	XJFoyrpR0cdxKCRrNJL2SZRYiTNOZIjIfvB27Am5mrs7KKvlEdMIYYYH9mwvCoCosR8FoYlwwwM
	FBdgiRTcTkOuk4faQA3LvNhb+ulXY39Y1fZsMX0CV5vbMNCMZkdrjNF/osTQFDfU3OMy9jvtG5G
	y2e7lsLy797U0dC0i1Zuz1bK7VQOfBFg5BnUOWK4l1MjeITrPpBwMVYVJt9r+Jj5WA9RATDUC4x
	+ApfPzsy1g81U2hCktZ+OlQ5EW4KmgJ8fuqLTqt5bocvRd75GunMW/BQgkY7Mz44xVsQ==
X-Received: by 2002:a17:90b:4b8d:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a8a1569ab3mr1745936a91.38.1791394409515;
        Wed, 07 Oct 2026 10:33:29 -0700 (PDT)
Received: from dungbv.. ([58.186.69.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff5b3b06sm421884a91.15.2026.10.07.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:33:29 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Mike Snitzer <snitzer@hammerspace.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-kernel@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] workqueue: Fix NULL current_pwq deref in current_is_workqueue_mem_reclaim()
Date: Thu,  8 Oct 2026 00:33:24 +0700
Message-ID: <20261007173324.227988-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

current_wq_worker() indicates that %current is a kworker thread, but it
does not guarantee that the worker is currently executing a work item, as
worker->current_pwq is populated only while process_one_work() is actively
running the work function. Outside of that window (e.g. during worker idle,
initialization, or auxiliary execution paths), worker->current_pwq is NULL.

In current_is_workqueue_mem_reclaim(), worker->current_pwq->wq is
dereferenced without checking worker->current_pwq:

	return worker &&
		((worker->current_pwq->wq->flags &
		  (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM);

If current_is_workqueue_mem_reclaim() is called when worker->current_pwq
is NULL, the kernel triggers a NULL pointer dereference.

This mirrors the issue recently fixed in is_chained_work() by commit
980db94e3eee ("workqueue: Fix NULL current_pwq deref in chained work check").

Guard the check with worker->current_pwq before dereferencing ->wq.

Fixes: da729ddd4a1b ("NFS/localio: issue IO inline when not in a memory-reclaim context")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c56c042d1c3..c1cb328bce3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6320,7 +6320,7 @@ bool current_is_workqueue_mem_reclaim(void)
 {
 	struct worker *worker = current_wq_worker();
 
-	return worker &&
+	return worker && worker->current_pwq &&
 		((worker->current_pwq->wq->flags &
 		  (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM);
 }
-- 
2.43.0


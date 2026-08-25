Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1333ADAC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673948; cv=none; b=eWWIyE6flOJiro9axfwKO6oQ3D9CjkhiKhiGwTmzLK1ycBpOhdMUsVi2v6P9v91ZLFs+6IQBpkC4Az2dprCZpCo80wXJmp9kJoHnBm/c+j4AkHToXV+oCc0AY4mW9JEDXvdoPbMuvitsbCh9ohNUjp4PBJURvQXHFysqvUMQDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673948; c=relaxed/simple;
	bh=kDI2ihpW2N+Pu0rfna1EMnQOHYrZILzhojiJVcBIzLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdhqkK22Ppk5nEpVmk3xkjKnrFzFN9poIZZU7yfBwBLUFg14JX2BE52t5xJmU/miGmxii6MNPblELIwrfNai+HqpOn4xbPMAJeFSvLKvfZuSWEizK28a2Mz0TWJO09hiJIoQ+ow/OWR8su8DOKDcFDuVmgO9pwtHOyKV9WpeaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5I0xE94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5I0xE94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7531F00A3E;
	Tue, 25 Aug 2026 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787673947;
	bh=9EYtlfLUMpJ5EfAj5NHVjsEiaP9nzoMAmolGqX4NRjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K5I0xE94JxFazvykjmwUtNeNp/XsfNdp2KzZDnlBZdEbNcrhilS4qNaoaTVQiwRrZ
	 oG6cHUqvMQwtcaXCReghR5NOS6lvATVOAP4qF6Pu1OTmPfks+pOqouQAv7cX0neosO
	 PSWeJ04fKm+EHDji3gBOgMaui70o9nF6W+A740jzRAiUe5+g9MHogIXgGvbNCc3+xp
	 1n3RD++wCQkrgO6O2eQtMCElNqT8MUvlU/6/YCnT13j+aVpNSXhrA04e3ZryojMopB
	 Ey0gPY/V7xeVTpvxZyuoCjmGSg6RWSuDU6aNfqEIf6tRECMydc7Z5TrvIpobo7gCnV
	 8uyXqNETkr+SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Razdan <vrazdan@openai.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] io_uring/io-wq: fix worker accounting when canceling creation callbacks
Date: Tue, 25 Aug 2026 12:05:43 -0400
Message-ID: <20260825160543.4126397-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825160543.4126397-1-sashal@kernel.org>
References: <2026082422-frivolous-grab-47d6@gregkh>
 <20260825160543.4126397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishnu Razdan <vrazdan@openai.com>

[ Upstream commit 297b5ccea4acacaa47c150f043bce695202afbf1 ]

create_worker_cb() reserves an io-wq worker slot only after its
task-work callback runs. If the callback is canceled before then,
io_worker_cancel_cb() still decrements acct->nr_workers. When an
existing worker retires with its creation callback pending, that
worker has already decremented the same account's worker count.

The resulting undercount permits worker creation beyond the account's
configured limit. On an AST2600 OpenBMC system, an unchanged sensor
daemon reached 4,291 threads with the original kernel. With an
equivalent downstream fix, 25 passive samples under its normal
workload showed 6-9 threads.

Decrement nr_workers only when the canceled callback is not
create_worker_cb(). Continuation callbacks still release their reserved
slot, and both callback types retain the existing running-count,
reference-count, and create-state cleanup.

Fixes: 1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Vishnu Razdan <vrazdan@openai.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/20260811-vrazdan-io-wq-b4-submit-v1-1-719ced16c921@openai.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io-wq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index f75160f9151b7..99ebb48cde754 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -202,9 +202,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = worker->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&acct->workers_lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&acct->workers_lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&acct->workers_lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&acct->workers_lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);
-- 
2.53.0


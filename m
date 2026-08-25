Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC93CB2D9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687299; cv=none; b=FDz/ptnD9Q0/8+L98k6FnZARQUazn8SIMTvplJJi6TOZFVdEzcke0ggpleK2QXWKe1l1Agcdo7d1CdthZb1NAk5JWSvU7yeSfOMKXUHzQbK6raGY4aUmmJZjk8n2neHiWS68DPdy4WxNHfKRf9JhxjC6AFUTHM2iRhoicnol2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687299; c=relaxed/simple;
	bh=bD3AWIUv9H9YJ3QQjBDFK4REcaPN0//7TButE/1VLJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2+2f2ztsr1xm9eSiNphZhH0mS6MPqJKIC0y9c0CZnLl5fWKGv3WmuQvGCu9ncvpzslk/8781nDNk4sxKIRPEeOUJGszuMrKHIhxaYK1e1tbntU3MqHLWRJFy86VkT0/rAPCt8kwjZn5gds4RlOHzYwlMsE2L2tbzE7Fv8w0Ak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARIHOsTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARIHOsTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538BC1F00A3F;
	Tue, 25 Aug 2026 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687297;
	bh=RsS+3M8ATlnAotWwmwGe3Eg+he+YApToDV6efDpte80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARIHOsTV1OvPv8P4FJWkz/7VZgJHHDg0sNI6kVvG5MAIUKbE5DNz+1cmHgFsDqOPR
	 Wu6wc7ZAVz7cG0VIu5VBEn9lSfDUnMwApBOFLsF/haXd38Ox9ZHExUOT/rXv/xN/r0
	 NHuHDbZ31Iko9gbA3IgyAFR3syGDNSTSXJrA6S/25M4uG6+dzIog0eACQbdZT0sNSG
	 rOUGVmdUFUBevNX8eMVQ3eun5aeQ+lpV9Nk74W/hxmckIIE33atAaYpfbYXG+xd3Tg
	 /f9J7vRZhKSQkFL6hTdB7NPbJzjWpp9FVRLlOX/0uYVnlZcfyJlOxTCB4BdRGjEaa7
	 apqFhO/YafC3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Razdan <vrazdan@openai.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] io_uring/io-wq: fix worker accounting when canceling creation callbacks
Date: Tue, 25 Aug 2026 15:48:14 -0400
Message-ID: <20260825194814.376625-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194814.376625-1-sashal@kernel.org>
References: <2026082423-fineness-promotion-9ac5@gregkh>
 <20260825194814.376625-1-sashal@kernel.org>
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
index 775c55e377922..b09fa30927930 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -203,9 +203,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
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


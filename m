Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F6357CFC;
	Tue, 25 Aug 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676794; cv=none; b=decM5bxYNYEN/tZ+an4cNkUz88jrpBInqhnknIxnySW29ISQUeZdLU7V4qrxUQ/UC8K3V2XgKhUZ/wCPs9JDbWweyZj6ezxuzUT6Y54FbhcDNg+iMhFHbpQbgX5FBRZJRmWR+29+PbvJkK1D0BddD5FLF7PQJ+jnzPsbMZayhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676794; c=relaxed/simple;
	bh=+1w877Is4LscSJhePxSfNtkgYNPcZ3dI1MzNgaouPUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ftCOn6Ef/Y+0iN2rOkhtAsGUGS2q7q4M0dgR0pF22Kn4mO6Yx0A6nUbmuVwnfZFRWnSvkrtujijUN3+UQsPJpcHlmhAk3Kdm/1KnYUoEcYLG5AzeEuvO/DNAZr69pu4/fy1xrjwv0d/KFXiiR/J0E2CeKh6HTT6AvMCcWXjax6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeiY/C+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeiY/C+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3032C2BCB8;
	Tue, 25 Aug 2026 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787676794;
	bh=+1w877Is4LscSJhePxSfNtkgYNPcZ3dI1MzNgaouPUA=;
	h=From:Date:Subject:To:Cc:In-Reply-To:References:Reply-To:From;
	b=jeiY/C+ZHtC73FpGCwl7KuA2mfKZAqcp8yCtBYExAUP5qGHtQuN1g/I4TvXQEgJZa
	 Cfbv/RfvMyRcxNvJIdnVo5dbjn3gIIvCtEJe3tGPt7njZFpS7xxubD7zLSzuBpNAWr
	 JYJJpLV9PiAdNUxakPe8xL6lTKZHakE1gns8mLIDsaYH+FdVMZxr35piJdX7R/r45R
	 EB9AmHDGCCeoSjaUAmc/qXp6UtJzR7aAw3XAsi36hh67Wttehzcf22jdhq0/lKCLyR
	 bclEK65/d2tBgwSCN6+WQ/JIa3Pw7nieQ/hjxc3RpIWgeRGS9secdt13N/fOyD2KDV
	 vLiA3wnMlVX9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF188C61DBD;
	Tue, 25 Aug 2026 16:53:13 +0000 (UTC)
From: Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Date: Tue, 25 Aug 2026 09:52:03 -0700
Subject: [PATCH 6.6.y] io_uring/io-wq: fix worker accounting when canceling
 creation callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-stable-io-wq-6-6-y-v1-1-c9f890168485@openai.com>
X-B4-Tracking: v=1; b=H4sIADLIjWoC/y2MSw7CMAxEr1J5jasS1IC4CuoiMS4NQinE5VNVv
 TtOQLOap5m3gHAKLHCsFkj8ChLGqGW7qYAGFy+M4awdTGNsczAtyuT8TemI7wdazYzeGdr11JK
 hPejxnrgPnyI9ga1tPUP3w/L0V6YpC/PQO2H0yUUaMvqrCy1mWNcvDve2R6EAAAA=
X-Change-ID: 20260825-stable-io-wq-6-6-y-ba2c3fc5c2c7
To: stable@vger.kernel.org
Cc: asml.silence@gmail.com, vrazdan@openai.com, krisman@suse.de, 
 axboe@kernel.dk, io-uring@vger.kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <2026082423-fineness-promotion-9ac5@gregkh>
References: <2026082423-fineness-promotion-9ac5@gregkh>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787676793; l=2337;
 i=vrazdan@openai.com; s=io-wq-kernel-20260811; h=from:subject:message-id;
 bh=VKXeGsfnMBFtjlWVBZ3PVT5X6resbdE+aaVqCUQBHaw=;
 b=cMPsI3bfyS4J/eutD9UJRVgZ7c6ppKcOg/mj1NypZn98YswYPv5cx12ROriVJTjkccI9/sHfg
 8xb7wxVT+LyAHcnstiJ0GFff2huUiw1h6vfl+7GmbHBxx4T3qJFW798
X-Developer-Key: i=vrazdan@openai.com; a=ed25519;
 pk=45vHW8D/KId5RtsP3Qx7zMcNpgDwEvCnL5uAw0KzuS0=
X-Endpoint-Received: by B4 Relay for
 vrazdan@openai.com/io-wq-kernel-20260811 with auth_id=937
X-Original-From: Vishnu Razdan <vrazdan@openai.com>
Reply-To: vrazdan@openai.com

From: Vishnu Razdan <vrazdan@openai.com>

commit 297b5ccea4acacaa47c150f043bce695202afbf1 upstream.

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

[ Backport: retain the existing wq->lock protecting worker accounting. ]

Fixes: 1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/20260811-vrazdan-io-wq-b4-submit-v1-1-719ced16c921@openai.com
Signed-off-by: Vishnu Razdan <vrazdan@openai.com>
---
Stable backport for linux-6.6.y.
---
 io_uring/io-wq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 37725c5031b4c2..a20be1a43aafcf 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -193,9 +193,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = worker->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&wq->lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&wq->lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&wq->lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&wq->lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);

---
base-commit: dc6160265ffc795a1832bc1424f58291d152c7bb
change-id: 20260825-stable-io-wq-6-6-y-ba2c3fc5c2c7

Best regards,
--  
Vishnu Razdan <vrazdan@openai.com>



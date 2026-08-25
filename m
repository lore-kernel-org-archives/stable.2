Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB8342538;
	Tue, 25 Aug 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676831; cv=none; b=W+Ns09WqIg3QvdADsNQux56aHHfm5sIUanhAZI1e5ZCnRlS8voC4gQVCt3B+yRdQZGE+SNwi3C8RUVNflnSu8XQt5HdzeasknpjndkcVWqP8vKEp1HmvrcY4ymcLOi/6aJcYKy4185qAtLofC688EjAtKxmd1IOMYaWjDOJc8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676831; c=relaxed/simple;
	bh=6Q+nZv0YRl/CyM23/aiGxp3BIyZ2CbBXSgWHvN1fR/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=MfnUZhd6tt+qBH01zYM87PqEdOUvn0ELuswHe+kBWskkccfiIvQIZAqtEeM57gugdlb+ukYJkV7f4ySha9FgJ1iH4EDVkmPuZGNCnuH7B7Fm8HkDXfG6R+5KB3GRYyPi0MxUZmbddjxWoMNIfV0SgCsCdaMZYKOe0Yqyl43SZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0TihZWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0TihZWf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9A77C2BCB8;
	Tue, 25 Aug 2026 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787676831;
	bh=6Q+nZv0YRl/CyM23/aiGxp3BIyZ2CbBXSgWHvN1fR/Y=;
	h=From:Date:Subject:To:Cc:In-Reply-To:References:Reply-To:From;
	b=I0TihZWf0kwFWT2RsMGubyZRQ7Qo4Pe5+CuB8KNcQV7qKvZSczqs2uNHV7lpB6raF
	 yA8e9YudMU+dDbMbyBo+iS+0bO3cNs09BonM/I1Y6nhuZJLxrNhIhRmHwtlYQFtQ+d
	 nXaRE9Dgtbu6xOETCXp/x8xXOiGm4TfhBFfuDHqmm5opA1B7PUcYO5L8OrcaqIT/DA
	 2WzZuwDpGzG00dh8+IyYHaXtgUMqiUOLoXDbW/4SqZbcjXoRsWXsQE/qhZzbMSVpiX
	 HzpvKZNzbQUfawsuwJo0nWG7NAZz488WnWr1bYwDIYwNggh9K11bpkJj9inz7HleXI
	 D3THqHXmQQ7ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D4C61DB9;
	Tue, 25 Aug 2026 16:53:51 +0000 (UTC)
From: Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Date: Tue, 25 Aug 2026 09:53:47 -0700
Subject: [PATCH 6.1.y] io_uring/io-wq: fix worker accounting when canceling
 creation callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-stable-io-wq-6-1-y-v1-1-8166bc2decba@openai.com>
X-B4-Tracking: v=1; b=H4sIAJrIjWoC/y2Myw7CIBBFf6WZtdMAVtL4K8YFj6nFGKpMfTRN/
 11Al+fk3rMCUwrEcGxWSPQKHKaYQe4acKOJF8LgM4MSSoteHZBnY2/ZTvh+oEaJC6q+23thBi+
 og3y8JxrCp0ZPoFvZLnD+aX7aK7m5BMvQGia0yUQ3FvVPV1vLsG1f3kcvzaEAAAA=
X-Change-ID: 20260825-stable-io-wq-6-1-y-2843d0afd0e4
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, asml.silence@gmail.com, vrazdan@openai.com, 
 krisman@suse.de, axboe@kernel.dk, io-uring@vger.kernel.org
In-Reply-To: <2026082423-scotch-snowbird-3d10@gregkh>
References: <2026082423-scotch-snowbird-3d10@gregkh>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787676831; l=2382;
 i=vrazdan@openai.com; s=io-wq-kernel-20260811; h=from:subject:message-id;
 bh=sCRULoicw5p9DvIy5OfX6hMqGoHK4NAyp/A0A5zZiaM=;
 b=fdLiFznmtW8IuNsu3K5YlA/j1sU4OmxUeKh1RIChqvDlzNYMHZ+feA+nxGN/GiHsYpeEKZa0r
 9daucjK824uDTooUhNOb5+69KMhAwlGPLCnKMl3rqYO6EShHrxJ9+fL
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

[ Backport: retain the existing worker->wqe->lock protecting worker
  accounting. ]

Fixes: 1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/20260811-vrazdan-io-wq-b4-submit-v1-1-719ced16c921@openai.com
Signed-off-by: Vishnu Razdan <vrazdan@openai.com>
---
Stable backport for linux-6.1.y.
---
 io_uring/io-wq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 66fdd69fd6cb40..0c3de2fead81cc 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -201,9 +201,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = wqe->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&worker->wqe->lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&worker->wqe->lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&worker->wqe->lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&worker->wqe->lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);

---
base-commit: 05208478041ccec1b348d25e1df5c4013608590e
change-id: 20260825-stable-io-wq-6-1-y-2843d0afd0e4

Best regards,
--  
Vishnu Razdan <vrazdan@openai.com>



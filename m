Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85A40B0F4
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573917; cv=none; b=nxdbZ5+g8XdUrEOCJA3HYem+DsH160n8QJ0bhK3NZ8aIq8zinCjsOvznwNm9jz1XOh1xiZwh/Z80QMb0jVicmwFum5XhosQe37QFbu7OXk4KlVBZgefaX7GPDETWzGIhdFfi70QpFhpBA12j/8XHEXAzNoQ5R3yLc46+T6ybip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573917; c=relaxed/simple;
	bh=t+29Hire3rCmljOsPpEQIcKWBHOGZGvcrFeeX1B7feA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=neG3W2TPXK54XENiT2q4gxk2SnUY/63EXO5/RxFdPGRXEB3s6OknkUWXm3tnaTxjb2UFR+Nrq2b8bolJ8rU5KXu7zsf8YiuhCs2XSZW5R4by2MqSO1sqSoFoYXvdyc+ciUKtaiwb/dLLg6B9nLjgMvCCzQrMeS7DbasYm5EBFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTHMjjLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTHMjjLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563D11F000E9;
	Mon, 24 Aug 2026 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787573914;
	bh=ZiQACgRF3QNYH01XzCp2CvLzkTZUSi2w/lqzjeohaRc=;
	h=Subject:To:Cc:From:Date;
	b=bTHMjjLfbjxqmCzFjcdr3SNdKA387zaJj2Os6Ibxa9he8YuDmuDV/vnJ1/jxjNkay
	 7tRsr++rrmk1kBAPjIYb7vmdB8wkH7MUr3VejIEv6WIqyQL5a/waLygtcipTnNJsKz
	 2QurWiiV5B2AcqRB6eNWV9N6+uf3A1T/GtTubPdk=
Subject: FAILED: patch "[PATCH] io_uring/io-wq: fix worker accounting when canceling creation" failed to apply to 6.1-stable tree
To: vrazdan@openai.com,axboe@kernel.dk,krisman@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:18:23 +0200
Message-ID: <2026082423-scotch-snowbird-3d10@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 297b5ccea4acacaa47c150f043bce695202afbf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082423-scotch-snowbird-3d10@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 297b5ccea4acacaa47c150f043bce695202afbf1 Mon Sep 17 00:00:00 2001
From: Vishnu Razdan <vrazdan@openai.com>
Date: Tue, 11 Aug 2026 00:01:27 -0700
Subject: [PATCH] io_uring/io-wq: fix worker accounting when canceling creation
 callbacks

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

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index be8d75731d24..2ca223e47d41 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -212,9 +212,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
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


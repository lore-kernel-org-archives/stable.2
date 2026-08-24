Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396D13957E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573908; cv=none; b=lH3d/reepAwNXaiD+vSOpcvXvwc+AUM5N+kARy2f6CRKUDIilUjgMouUeADIFmyf9Wx0U4OQzfPRYh2WZy2UEW0YHOALDmUUnp5hXgGmjKJavbj/M5u63n36jyYD5Y+ZELrPVb8xAFs/cVQYfLQdTMErriYIM+1PUqbvdzhPJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573908; c=relaxed/simple;
	bh=vpopAWWqeWGo2twmVnXbk2mZI/8FvoPv7mxpz0o8bQ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pB2hoXJ6Lf8o7XcbxFlsBveaTjNFhpq3cMGDYhRsTBh35H3gviBE/PDbMp9QGw7QIPG62Vk1YazuIsWrzQkrrJLEpcIy6Vd2dNfR0P7xh49b8PcRInyi6etahF89ASWqzvKV/gWM3G9/OsAc/NhquRFkMsV2I2bad86NsdnYVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qydL/nR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qydL/nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A71F000E9;
	Mon, 24 Aug 2026 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787573907;
	bh=m4e951+PyOq8Qtcom3sLTYexVWx63vtO5hXnFIN9LqA=;
	h=Subject:To:Cc:From:Date;
	b=0qydL/nRsZ15Kwt37GMR9U1m1R1kXFCL1mqXA78vjeo3vaI7ZR/cRWWe4eeYUI/UO
	 aa4pCNOzRuxCwcbM4DjDldWZqV3m260GdPCSrlhlA8shB7ABolLp/C7sRky+QzsJDO
	 1SC5KVtErRc12q5lGYGGdvVNY+498DhLU56hcdRc=
Subject: FAILED: patch "[PATCH] io_uring/io-wq: fix worker accounting when canceling creation" failed to apply to 6.12-stable tree
To: vrazdan@openai.com,axboe@kernel.dk,krisman@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:18:22 +0200
Message-ID: <2026082422-frivolous-grab-47d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 297b5ccea4acacaa47c150f043bce695202afbf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082422-frivolous-grab-47d6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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


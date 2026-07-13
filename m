Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B74252A3
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948793; cv=none; b=qXCnNwt3qBDbu31lwzIHbDRyGcSyEAYstCyjamssIjMEvB2+3eMhEylim1cTdVLs566Gs/uuL5uqORRvurDAytaAl4akBYE/NGb2eZKvzC+MXlAUc1hpPhf0uWJtnQBQ41LdcQWs0nT/djQ23qlJP3GncKWNtoxTp6xt9etXFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948793; c=relaxed/simple;
	bh=n3bIgIyVOqODJDhH+GdOWKLLLCpvvIgXutKmtjieMA0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KEc0lT+PjtoSyk+fDln85uBMqtXLX8k/5azagt6qcnpedaTDZAttBFwa+TqwQZVNaMiXbwaIK//nQzFxqz1Y/nlGB6FqRZAi0lkJcbXcih8HxRCnyRp4eTmoprbVb2uEgiBBEMtVY+kWAYDLwW9MdblH4LLNTkz7n4Jw9XBG0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKxOm3WA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKxOm3WA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C51F000E9;
	Mon, 13 Jul 2026 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948791;
	bh=PaRIFy8J3KcUsEu7E758wB50w6VR0RYTduW4h4pEvks=;
	h=Subject:To:Cc:From:Date;
	b=MKxOm3WAEnOmCh7pfVK4W2NHq6yeyb58H7DFtDdd/2fg8Q1x0ChSoMrOmBykp4I/o
	 Rf/R0vy7Z1uQ4LlUq8/gLBw6K/PrljZPv3iT8xrPQi1OJ3M2yHaFsKe22Yv8veRHm8
	 R0zhaWtvPIMkyGzjvpW+jI2g/+Vh6sUma39+WKsY=
Subject: FAILED: patch "[PATCH] binder: cache secctx size before release zeroes it" failed to apply to 7.1-stable tree
To: clm@meta.com,aliceryhl@google.com,cmllamas@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:11:06 +0200
Message-ID: <2026071306-applaud-quail-8690@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x b34826e55aad3520ec813f1f367c11b24b29dc9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071306-applaud-quail-8690@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b34826e55aad3520ec813f1f367c11b24b29dc9f Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Wed, 3 Jun 2026 10:44:54 -0700
Subject: [PATCH] binder: cache secctx size before release zeroes it

binder_transaction() bounds the scatter-gather buffer area with
sg_buf_end_offset and subtracts the aligned LSM context size because
the secctx is written at the tail of that area.  The subtraction reads
lsmctx.len, but that field has already been cleared by the time the
line runs:

    security_secid_to_secctx(secid, &lsmctx)   /* lsmctx.len set */
    lsmctx_aligned_size = ALIGN(lsmctx.len, sizeof(u64))
    extra_buffers_size += lsmctx_aligned_size
    ...
    security_release_secctx(&lsmctx)            /* memset zeroes len */
    ...
    sg_buf_end_offset = sg_buf_offset + extra_buffers_size
                        - ALIGN(lsmctx.len, sizeof(u64)) /* ALIGN(0,8) */

security_release_secctx() does memset(cp, 0, sizeof(*cp)), so lsmctx.len
reads back as 0 and the subtraction contributes nothing, leaving
sg_buf_end_offset too large by the aligned secctx size on every
transaction to a txn_security_ctx node.

Each BINDER_TYPE_PTR object then derives buf_left = sg_buf_end_offset -
sg_buf_offset as the sole upper bound on its copy, so the inflated end
offset lets the copy run into the bytes that already hold the secctx.

The aligned size must therefore be cached before release rather than
re-read from the now-cleared field.  Fix by caching it in
lsmctx_aligned_size at function scope when it is first computed and
subtracting lsmctx_aligned_size instead of re-reading lsmctx.len after
release.  Reuse the same value for the earlier buf_offset computation.

Fixes: 6fba89813ccf ("lsm: ensure the correct LSM context releaser")
Cc: stable <stable@kernel.org>
Assisted-by: kres:claude-opus-4-8
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260603174506.1957278-1-clm@meta.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ec0ab4f28530..c48c22264266 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3080,6 +3080,7 @@ static void binder_transaction(struct binder_proc *proc,
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	ktime_t t_start_time = ktime_get();
 	struct lsm_context lsmctx = { };
+	size_t lsmctx_aligned_size = 0;
 	LIST_HEAD(sgc_head);
 	LIST_HEAD(pf_head);
 	const void __user *user_buffer = (const void __user *)
@@ -3346,7 +3347,6 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
-		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &lsmctx);
@@ -3358,9 +3358,9 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_get_secctx_failed;
 		}
-		added_size = ALIGN(lsmctx.len, sizeof(u64));
-		extra_buffers_size += added_size;
-		if (extra_buffers_size < added_size) {
+		lsmctx_aligned_size = ALIGN(lsmctx.len, sizeof(u64));
+		extra_buffers_size += lsmctx_aligned_size;
+		if (extra_buffers_size < lsmctx_aligned_size) {
 			binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
 				thread->pid, proc->pid);
 			return_error = BR_FAILED_REPLY;
@@ -3397,7 +3397,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
 				    ALIGN(tr->offsets_size, sizeof(void *)) +
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
-				    ALIGN(lsmctx.len, sizeof(u64));
+				    lsmctx_aligned_size;
 
 		t->security_ctx = t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
@@ -3452,7 +3452,7 @@ static void binder_transaction(struct binder_proc *proc,
 	off_end_offset = off_start_offset + tr->offsets_size;
 	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
 	sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
-		ALIGN(lsmctx.len, sizeof(u64));
+		lsmctx_aligned_size;
 	off_min = 0;
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C534BA24
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036410; cv=none; b=dRBhNxQfh34UIJugQh3qpecpYxMhsgTeA5qtJvlAiUnoPVtdk+J42IZu1zjlKkNqIjwXXg5iX2nviVJuyla2izz4kMRKjXJWFCRphWXjDi/fzrI0fByrYCAElbYU7ATmub9in4YvN8pARarQSvWBBAFzOOOBZZQI9TkEsv+sbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036410; c=relaxed/simple;
	bh=RxyJhCNyPT6eHTsQ8lpDd9jQW2Sm9djEYfqBomVdp0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVdGJ7qCGOpOSoQraODlRNe+VJ8sTipws3r4xfEMlFjEkzu6dD1PgfL2X5VaAOxQTxCXpOixvObcLWNg54A1ahi1YLzwIETVeaWgQicBlwYWrzyC900tAsaVlfbULQqvWb+8vB3BsbYKiXx/t3cnVhzeVaiOLPHxtqIltcU4/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1BzgR7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1BzgR7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF4E1F00A3D;
	Tue, 14 Jul 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036409;
	bh=GrofG+giuBnJDhwOYAfYDP0Q6HEAeL+Cgxk+la4Hxx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1BzgR7q26G2unkYO/lIMn0D7J9U2UoBq2O1BD56aq++r0w5KF6ZvHEhFKwbY8dr3
	 Cn9dsydBi0GliWbsx14ZxhOxr2xRKrqN4yY14dzlRSQ/mIN0ruWKk3K5Ikt95JCpFT
	 Oz8mey1EFWVqcBKBlGJNmXORjnT5m5MxtGeyQjZE//lQWV2ZOQIXPcxQNzmf8tbMA7
	 JVBeWrPpNqpBNji0Id21j0DtlpHuV+pgQtgDE3+NCYRlMX/k+7iruUYEey5qkB8jgz
	 vQMgLcJhcZRT1HLn8YQkGoYbiVw9tP8w5DuQmLNQiV6DWz2F9ZPQU1AN1saxuk6Min
	 Bp2JdqlaLD9Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] binder: cache secctx size before release zeroes it
Date: Tue, 14 Jul 2026 09:40:06 -0400
Message-ID: <20260714134006.2674552-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714134006.2674552-1-sashal@kernel.org>
References: <2026071306-applaud-quail-8690@gregkh>
 <20260714134006.2674552-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit b34826e55aad3520ec813f1f367c11b24b29dc9f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ec0ab4f2853014..c48c2226426665 100644
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
-- 
2.53.0


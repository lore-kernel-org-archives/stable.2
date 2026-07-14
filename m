Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8035AC3E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036592; cv=none; b=unt48vRC6DH2UlEMcH7GpxN8cFmZf19ZMp1vcPVIyf8DpIzPrNMiNEB4B0pkvJe7PLJYwi3lY4uPlVAov9RSbLD+PfBqBOSvUH6ENITqpw3sYFh4JUmuRGsr8mz29EHFkVW60EiTgaKZYOE6JIuobcXUYC+Sp+866gtbRdL+OGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036592; c=relaxed/simple;
	bh=i5gL2B10VTjq+MYcJfQ0Dtr/NrIxWuKFKH+afQSyvvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBWA2jZVBPPtFGsUsF+CO5FeT4sWHmMbEe7ffJzOMWIX1V9SXqgSoBi/r1wU3bhZ3vdZqeIagnMIBxXBFwgClQj3O5BCk+WhlPr1AJUksaNsukBys7ltZ0Mp2KFDI3LKeMtauEBbXM/py1Ww1NtahKz0D5e4u5hU6tIQ0yT8j/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRiT6g9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRiT6g9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4E41F00A3E;
	Tue, 14 Jul 2026 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036590;
	bh=YNZycHI4PjfdssMWG3OeDaytanwfsIp2qLLj5vpWqTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRiT6g9qoIFUT28P3+h0NjCL9+z7oMMJ3E07adoZSp86HDPFgHI2bPBU/2TbdgOFE
	 LU5mkMlHKcnGznVJZ7jSPHMG8eVlduC51eFiyw3aJD/3j1lQeFYOGt2/j5OSAYtQxB
	 dpA0qrhQUTYqpJA9jfIX799wedhJZExelX+CcJoGGMqqvi658UDcrRgBtvvEE6sW2t
	 DdTiHu+kvNptJ5Zto4Zo8u5J+bvEGwWtHIPADnyzDw7f70t4pls3uZqIdd0JhcMW3P
	 8QtGBAfQ7hKed6Ns52KTqel2l5ZVr7WomUmGhnMTD6iaTL3zrk9lqId9KIWUsGMHBS
	 ZxLYR1cqif8Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] binder: cache secctx size before release zeroes it
Date: Tue, 14 Jul 2026 09:43:07 -0400
Message-ID: <20260714134307.2675829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714134307.2675829-1-sashal@kernel.org>
References: <2026071307-outdated-speed-452e@gregkh>
 <20260714134307.2675829-1-sashal@kernel.org>
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
index 81ebc5762fb422..abfad4df2938bb 100644
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


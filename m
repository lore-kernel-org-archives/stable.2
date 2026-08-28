Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3C3BC680
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892419; cv=none; b=mz+86SInqM9LZju3dpsGCXv7oywFXen047NK3XbPDXoXJ8xAiSUQ1/FWIxdLLFGa0WCosdY5X/Cixbn/rC9lRDz0yzMqjis7XjUeUd03RAImdCY/rQl+dBNDZIfwBgQLXUTwL9XXAmRZp9d3r2uKPbrzmJLF4Th0YvjbJ0dkVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892419; c=relaxed/simple;
	bh=/07CWLlS3zPricpeioY6LhUPp1RODGtY8/ym0vV2gdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F76apnc41YUZpWWcUDiUZt7zZHDCyen9D+kcwDGiTo/6CDdOQeG0gGciE93YHOafjXg0dzH3Tcwm8D0i2ZnNH4wQtEDPTm9e0WMyKHUKf2RovjuT9C3EcGOcRab1fczehkrCIH50jIfXQxEnIWpMJy13rLIdvyCZh+oNqEFaLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=WdR87Uw0; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="WdR87Uw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:
	Content-Disposition:In-Reply-To; bh=DC9UOK+G4VnOheSMMT0xVppY9U6O
	QzTS/3YhuwKz0Us=; b=WdR87Uw0X8POOlQXAdhtRJKkT+FhnVB3UzcaioJ947V9
	lHLBoSDJMLt3rLXq/cMO9/znyic0jaqUC0l+kauYyw4VY9+lfllTKLXJBnpIpN0T
	ofqPT2fw22PLEpSZ7dl2j3xlXcKOX41/ew/VwEj/hB0oZCHpVKN2+Z+16QgjPGA=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnaTC4EpFqqMCsAA--.524S2;
	Fri, 28 Aug 2026 12:46:48 +0800 (CST)
Date: Fri, 28 Aug 2026 12:46:49 +0800
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: Willy Tarreau <w@1wt.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Amery Hung <ameryhung@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] bpf: Invalidate dynptr clones in every call frame on
 release
Message-ID: <apESuZfLOKdGsqCx@DESKTOP-F439VFF.localdomain>
References: <apD0GtLd8lXgXD2e@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apD0GtLd8lXgXD2e@1wt.eu>
X-CM-TRANSID:3pYKCgBnaTC4EpFqqMCsAA--.524S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45try5GrW5AF1DXryxXwb_yoW5tw17pF
	Z5KF9Iqr1kJr4Ikrn7tw4xGrWF9F4kX3yUGFZ7t34Sy3Z5ZryY9F15Wry5XFsayF95tw4U
	ta1fuFsIyw4UGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgBTYUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

unmark_stack_slots_dynptr() walks clones only in the submitting
pointer's frame. A program that clones a ringbuf dynptr in a subprog,
submits the clone, then submits the original in the caller is therefore
accepted: the caller's STACK_DYNPTR slot is never cleared. The second
bpf_ringbuf_commit() flips BUSY on an already-committed header and a
userspace consumer stalls.

Walk every frame and invalidate matching STACK_DYNPTR slots, the same
per-slot work destroy_if_dynptr_stack_slot() already does in one frame.
Leave the existing WARN_ON_ONCE(release_reference()) as a swallow: a
hard -EINVAL would reject legitimate programs that release once in a
different frame than they acquired (6.6/6.12/6.13), and on 6.14+ the
second lookup fails because the ref was already deleted.

Depends on "bpf: Invalidate dynptr slices by dynptr_id on release" only
for the slice helper call inside the new loop; the frame walk is
independent.

This is the minimal stable equivalent of the cross-frame half of
308c7a0ae8859. That refactor is not a viable cherry-pick for stable.

Cc: stable@vger.kernel.org # 6.6.y 6.12.y 6.18.y

Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++
 1 file changed

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -811,7 +811,7 @@
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi, ref_obj_id, i, frm;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -843,22 +843,33 @@
 	WARN_ON_ONCE(release_reference(env, ref_obj_id));
 	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
-	/* Invalidate any dynptr clones */
-	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
-			continue;
+	/* Invalidate any dynptr clones, including those in other frames.
+	 * acquired_refs is per-frame on 6.6/6.12/6.13; a clone submitted in a
+	 * callee must still clear the caller's STACK_DYNPTR slot. Do not turn
+	 * a failing release_reference() into -EINVAL: that rejects legitimate
+	 * cross-frame single releases on those trees.
+	 */
+	for (frm = 0; frm <= env->cur_state->curframe; frm++) {
+		struct bpf_func_state *f = env->cur_state->frame[frm];
 
-		/* it should always be the case that if the ref obj id
-		 * matches then the stack slot also belongs to a
-		 * dynptr
-		 */
-		if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
-			verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
-			return -EFAULT;
-		}
-		if (state->stack[i].spilled_ptr.dynptr.first_slot) {
-			invalidate_slices_of_dynptr(env, state->stack[i].spilled_ptr.id);
-			invalidate_dynptr(env, state, i);
+		if (!f)
+			continue;
+		for (i = 1; i < f->allocated_stack / BPF_REG_SIZE; i++) {
+			if (f->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
+				continue;
+
+			/* it should always be the case that if the ref obj id
+			 * matches then the stack slot also belongs to a
+			 * dynptr
+			 */
+			if (f->stack[i].slot_type[0] != STACK_DYNPTR) {
+				verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
+				return -EFAULT;
+			}
+			if (f->stack[i].spilled_ptr.dynptr.first_slot) {
+				invalidate_slices_of_dynptr(env, f->stack[i].spilled_ptr.id);
+				invalidate_dynptr(env, f, i);
+			}
 		}
 	}
 
-- 
BPF-SemSan disclosure follow-up


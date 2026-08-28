Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F51FECBA
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892394; cv=none; b=JfyNZX6yBfl+BX1wfUR1vfMGYvVV123d4DV3U1PtuIma1v0VUx4JasyJlrFNazZEqPuyCQ7tKrccwWfxczRDjxPkOcYh7nz2GqwO2TMUqpqxiywj7LzlW4SsiyRsIJ+QFTfbRdznpOxoh765s6mv6A12VlTiM78kJQuvaiUuZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892394; c=relaxed/simple;
	bh=eEdmtIhjgLzN83Qqv3tt5IAWwt94fQATWP9WbNUcKm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oahgKzOuXnP0X8/iNvF4ukyXAs9Cukg89ZDtwx5DkZTiDJopTaEUAWKbwpRBoP61RTTRK3RdTqU8FDyu8kqUHKpXD/htWdAOLUoUE76fT9xuE3UDoVfSS23cO5YfhR93TemaKAUhmH2yvjBengKkDY9QFT8UWwPsF7b2UspGIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=lPhMExNm; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="lPhMExNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:
	Content-Disposition:In-Reply-To; bh=PhU18CW4vYaLVU4D3ZccQrCRBY8B
	rHDxAmJFzRdfKP0=; b=lPhMExNmHpviIzwVyg+Fcj3iSvsLDNA603HJIEDbJaVS
	UwvFjOX2wetM2MGTVVCKWYP6SPYTcoW8V9UekBbw6WoCsz9m7BisCUA/Jt9WEZ9l
	seGE39Xte3HyqAJfjmjZ7oPUf6Lff4xQVRqYvpnD4dr8QzIg/W85TRtL5lmq5U0=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHDTSfEpFqLcCsAA--.562S2;
	Fri, 28 Aug 2026 12:46:23 +0800 (CST)
Date: Fri, 28 Aug 2026 12:46:23 +0800
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: Willy Tarreau <w@1wt.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Amery Hung <ameryhung@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] bpf: Invalidate dynptr slices by dynptr_id on release
Message-ID: <apESnzAPQa0cMeK0@DESKTOP-F439VFF.localdomain>
References: <apDz2usnU7NuPNQm@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apDz2usnU7NuPNQm@1wt.eu>
X-CM-TRANSID:3pYKCgAHDTSfEpFqLcCsAA--.562S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfJw17JF4xKw1UWrWkXrb_yoW7Gr4DpF
	sYk3sIgr18XF1xKFnrAFs7JrZYka1kX3y3CFWrt34xJFnYqr98ZF1vgryUX3sxtFy0kr47
	Jw1IgrZxZr4UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

unmark_stack_slots_dynptr() comments say it invalidates slices associated
with the released dynptr, but the implementation only calls
release_reference(ref_obj_id). bpf_dynptr_slice() / slice_rdwr() stamp
dynptr_id and deliberately leave ref_obj_id at 0, so those slices survive
bpf_ringbuf_submit_dynptr() / discard_dynptr() and the verifier still
allows LDX/STX through them. bpf_dynptr_data() slices are already covered
because they carry ref_obj_id (see data_slice_use_after_release1).

Walk registers with a matching dynptr_id, the same way
destroy_if_dynptr_stack_slot() already does when a dynptr stack slot is
overwritten. Do this for the released dynptr, for each clone, and for
the non-refcounted path.

This is the minimal stable equivalent of the slice half of 308c7a0ae8859
("bpf: Refactor object relationship tracking and fix dynptr UAF bug").
That series is an 11-patch bpf-next refactor (parent_id, DFS, folding
ref_obj_id into id) aimed at qdisc/file parent-object UAF; it is not a
viable cherry-pick for 6.6.y / 6.12.y / 6.18.y. This hunk is.

The same change applies to 6.6.y and 6.18.y; unmark_stack_slots_dynptr()
is the same shape there.

Cc: stable@vger.kernel.org # 6.6.y 6.12.y 6.18.y

Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 32 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++++++++++
 2 files changed

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -805,6 +805,9 @@
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 }
 
+static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg);
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id);
+
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -815,6 +818,7 @@
 		return spi;
 
 	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 		invalidate_dynptr(env, state, spi);
 		return 0;
 	}
@@ -828,8 +832,16 @@
 	 * 2) Any slices derived from this dynptr.
 	 */
 
-	/* Invalidate any slices associated with this dynptr */
+	/* Invalidate any slices associated with this dynptr.
+	 * release_reference() only walks registers that carry ref_obj_id;
+	 * slices are PTR_TO_MEM with dynptr_id set and ref_obj_id left 0
+	 * (the stamping comment talks about packet slices, but the code
+	 * applies to every dynptr type, including refcounted ringbuf).
+	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
+	 * slices by dynptr_id.
+	 */
 	WARN_ON_ONCE(release_reference(env, ref_obj_id));
+	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
 	/* Invalidate any dynptr clones */
 	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -844,8 +856,10 @@
 			verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
 			return -EFAULT;
 		}
-		if (state->stack[i].spilled_ptr.dynptr.first_slot)
+		if (state->stack[i].spilled_ptr.dynptr.first_slot) {
+			invalidate_slices_of_dynptr(env, state->stack[i].spilled_ptr.id);
 			invalidate_dynptr(env, state, i);
+		}
 	}
 
 	return 0;
@@ -862,6 +876,20 @@
 		__mark_reg_unknown(env, reg);
 }
 
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id)
+{
+	struct bpf_func_state *fstate;
+	struct bpf_reg_state *dreg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
+		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
+			continue;
+		if (dreg->dynptr_id == dynptr_id)
+			mark_reg_invalid(env, dreg);
+	}));
+}
+
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -316,6 +316,31 @@
 	return 0;
 }
 
+/* bpf_dynptr_slice() does not stamp ref_obj_id (unlike bpf_dynptr_data).
+ * submit/discard must still invalidate those slices by dynptr_id.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int slice_kfunc_use_after_submit(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample = bpf_dynptr_slice_rdwr(&ptr, 0, NULL, sizeof(*sample));
+	if (!sample)
+		goto done;
+
+	sample->pid = 123;
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	/* this should fail */
+	val = sample->pid;
+	return 0;
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
 /* A data slice can't be used after it has been released.
  *
  * This tests the case where the data slice tracks a dynptr (ptr2)
-- 
BPF-SemSan disclosure follow-up


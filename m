Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509950;
	b=ZQ/CAcy3lB/PHV23y61g7gTW2YkA34BWH/OS3D+/E+TqY3tICK/kulICF9DyZDFPimiL
	 q+Qv92ZtvJihOqdu+MM+AZwu9FEA3sRlC/a6XW1dowHyl/U6TNM+XNUO6fAcIqfbk+5B/
	 dPNqIsExAKndTzEZhOcJ6nVK3Nt7spFuUOsB0ZfGveHH3ntklwBC2rRwUGgWSeau8SAee
	 jo3BTvizSnVGFmCOaQUCtpGCtXnbLyOA4CXpBVaGTkUVWFwTutLFeSM89C471GgTmrnBu
	 fSMZ530rlHFzMOKwTVucSckN2JKQuInfMpvln6qFlY0A4ZjEbcSw2xCVFzqVvXVIJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509950;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qnnKDDvmabqOsa4xKgNN1r+wBeLKSYF6UBFIXxksVrk=;
	b=Nd/zLW0PcyCmX95YsXV/bcXpN3Kd5CN0aUx4JgESS0MNTqrhIYH9RmvxQPtcCb0bTrD9
	 KBW9dzaRg+qvhSkL1OJM5EFRO8A8jAtDhp1pmJzACE0M8PR+sDjFi4E2Edb29q5Qbw+/q
	 PopAM2ZLEFGRpCAUf88LYWcVdmKNEgLkGxEQ4JY6mVWUXhFUgk/JWPdhvkyetifwz1CnP
	 mvx1b/Yu0UCaRTIB7hsXn9JwZ+oXJzGzCrp/BFWU0+ssnfvWqk+FBTFW9SeqKg2SlGgqW
	 tigpuftVM2hipKf4RxuwK55Z6MH8PfhAuynfDIWQzsGR6kSMuomNsFln1IVKavr6tZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/Ryh22H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76B606A31A;
	Tue, 20 Oct 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/Ryh22H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395A81F000C4;
	Tue, 20 Oct 2026 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792509949;
	bh=qnnKDDvmabqOsa4xKgNN1r+wBeLKSYF6UBFIXxksVrk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N/Ryh22H3bh2OekkLERS5+/ZNyR79Ait3mk83MBE58z5nY43sBxn8Q9mb70aqTRLT
	 kdRkja4iI4E8nIbnMI6tw5NgjDFfu5AnqxuLQiDzEU7pet6JhegJxpupKTcC5FkjuY
	 OTnTETl4hTWohoiYS2FZ87uIookOWSNwoPhWDP0n5NsraDyNgAbD+ru21uhbIfzPwI
	 tl49VaWf4TvIpf347OiU6Ulfc/C4ylIsSLfjRvr9UT6MKCqLL8cd+VDS5z9kux/xGC
	 Fg4i1KgYvbSS52K5qSC184y7iRf+pTkBa0CEiGQbDUk6pKRn3s2elqhj5rbtGUDScg
	 69FDpahn/H8qw==
Content-Type: multipart/mixed; boundary="===============4093518717466758589=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a9ee5ed21d9e00e36d2bc48f64d47422ccfa7f8d12575e63456ffb0f9decd400@mail.kernel.org>
In-Reply-To: <20261020145059.2146170-6-utilityemal77@gmail.com>
References: <20261020145059.2146170-6-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: song@kernel.org,puranjay@kernel.org,bpf@vger.kernel.org,utilityemal77@gmail.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 15:25:49 +0000 (UTC)

--===============4093518717466758589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Bind iterator elements to their iterator

TL;DR:
- Iterator elements may stay trusted after the next next() call drops them, so
  the verifier may still accept use-after-free programs
- Fixes: tag likely should be 4cc8c50c9abc

>     bpf: Bind iterator elements to their iterator
>
>     An element returned by an iterator's next() kfunc is kept alive by the
>     iterator alone. bpf_iter_task_vma_next() returns a snapshot that lives
>     in the iterator's own allocation and holds the vma's vm_file reference
>     only until the next step or destroy; bpf_iter_kmem_cache_next() and
>     bpf_iter_dmabuf_next() hand out objects whose reference the iterator
>     drops the same way. The verifier marks every such element PTR_TRUSTED
>     with nothing tying it to the iterator, so a pointer saved across
>     bpf_iter_<type>_destroy() stays fully trusted after the memory or the
>     reference behind it is gone:
>
>     	bpf_iter_task_vma_new(&it, task, 0);
>     	vma = bpf_iter_task_vma_next(&it);
>     	file = vma->vm_file;			/* __safe_trusted_or_null */
>     	bpf_iter_task_vma_destroy(&it);		/* frees snapshot, fput() */
>     	start = vma->vm_start;			/* vma, file still trusted */
>
>     Set the element's parent_id to the iterator's reference id, as is
>     already done for the PTR_TO_MEM elements of bpf_iter_num_next(), so
>     that destroying the iterator invalidates the element together with
>     every trusted field acquired from it. Elements of an RCU-protected
>     iterator keep MEM_RCU and stay bounded by the critical section instead:
>     they point at RCU-managed objects rather than iterator state.
>
>     Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Justin Suess <utilityemal77@gmail.com>

The Fixes: tag points at 4ac454682158 ("bpf: Introduce task_vma open-coded
iterator kfuncs").  Did the problem described here exist at that commit?

At 4ac454682158, check_kfunc_call() gave every kfunc-returned struct pointer,
including the result of bpf_iter_task_vma_next(), a plain PTR_TO_BTF_ID
without PTR_TRUSTED, so there was no trusted pointer to outlive the iterator.

The PTR_TRUSTED marking of iter next() results (or MEM_RCU for
KF_RCU_PROTECTED iterators) came with 4cc8c50c9abc ("bpf: Make the pointer
returned by iter next method valid"), and that change affects all three
iterators named in the commit message.  The kmem_cache (2e9a548009c2) and
dmabuf (6eab7ac7c5ee) iterators were added after it, and task_vma only became
affected through it.

The task_vma snapshot and vm_file reference described in the commit message
came later with 4cbee026db54 ("bpf: return VMA snapshot from task_vma
iterator"), which itself carries a Fixes: tag pointing at 4ac454682158.

Should this be:

  Fixes: 4cc8c50c9abc ("bpf: Make the pointer returned by iter next method valid")

> diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
> index 189e3ec1c6c8..08c9c15b59ac 100644
> --- a/Documentation/bpf/bpf_iterators.rst
> +++ b/Documentation/bpf/bpf_iterators.rst
> @@ -79,7 +79,11 @@ Constructor/next/destructor implementation contract is as follows:

[ ... ]

> -    NULL-returning kfunc, of course).
> +    NULL-returning kfunc, of course). An element is only guaranteed to be
> +    valid until the iterator is destroyed, so the verifier invalidates it,
> +    and every trusted pointer derived from it, at `bpf_iter_<type>_destroy()`.
> +    Elements of an RCU-protected iterator (see KF_RCU_PROTECTED) are instead
> +    valid until the end of the RCU critical section.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d3deea1cdc7..869e8d4083c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15762,6 +15762,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].btf = desc_btf;
>  			regs[BPF_REG_0].type = type;
>  			regs[BPF_REG_0].btf_id = ptr_type_id;
> +
> +			/*
> +			 * A trusted element is pinned by the iterator that
> +			 * produced it and dies with it, like the memory
> +			 * returned by bpf_iter_num_next() above. An RCU
> +			 * element is bounded by the critical section instead.
> +			 */
> +			if (bpf_is_iter_next_kfunc(&meta) && (type & PTR_TRUSTED)) {
> +				err = validate_ref_obj(env, &meta.ref_obj);
> +				if (err)
> +					return err;
> +				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
> +			}
>  		}

Is this fix complete for the lifetime of the element?  The documentation
hunk above and the new comment say the element is valid until
bpf_iter_<type>_destroy(), but several next() kfuncs drop the previous
element inside the following call to next(), not only at destroy.

The commit message says as much for task_vma: "holds the vma's vm_file
reference only until the next step or destroy".

What the next() kfuncs do to the previous element:

  bpf_iter_task_vma_next():
      bpf_iter_task_vma_snapshot_reset() does fput(snap->vm_file) and then
      overwrites the snapshot.  This runs before
      bpf_iter_task_vma_find_next(), so it also runs on the call that
      returns NULL.

  bpf_iter_dmabuf_next() -> dma_buf_iter_next():
      dma_buf_put() on the previous buffer.

  bpf_iter_kmem_cache_next():
      prev->refcount--, or kmem_cache_destroy(prev) if the refcount was 1.

  bpf_iter_css_task_next() -> css_task_iter_next():
      put_task_struct(it->cur_task).

With this patch the element, and the trusted fields walked from it, keep
parent_id equal to the iterator id and stay PTR_TRUSTED until destroy.  Would
a program like this still verify?

    bpf_iter_task_vma_new(&it, task, 0);
    while ((vma = bpf_iter_task_vma_next(&it)))
            if (vma->vm_file)
                    file = vma->vm_file;   /* trusted, parent_id = iter */
    /* the last next() returned NULL after fput(file) */
    if (file)
            ret = subprog_trusted_file(file);  /* still trusted */
    bpf_iter_task_vma_destroy(&it);

Once bpf_iter_task_vma_next() has called vma_end_read(), nothing stops the
VMA from being unmapped concurrently.  Can the file then lose its last
reference while the program still passes it to a trusted-argument kfunc?

The kmem_cache and dmabuf cases look similar: an element saved from
iteration N stays trusted in iteration N+1 after the iterator has put it.

A later patch in the series, a51a1f92e627 ("selftests/bpf: Test iterator
element invalidation on destroy"), covers only the destroy case, and nothing
in the series invalidates the descendants of the iterator id at next().

Should the verifier invalidate the registers whose parent_id is the iterator
id at each next() call for PTR_TRUSTED elements?  If not, should the
documentation, the comment and the commit message say that elements stop
being valid at the next step rather than at destroy?

This looks like a remaining gap in the fix rather than something this patch
introduces.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39445554665
--===============4093518717466758589==--

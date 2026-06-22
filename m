Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD911643B;
	Mon, 22 Jun 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172083; cv=none; b=VH6dH9sMnOiduObvr2S7/XZc4227bXsd+mCqPEtqUVHYbBiquett26ZarpGLSRahznTES85/DWvTWuU9MU2d2TcBFpqgFEHyqVH765nSf3lXWGBqwlWqJPztuX0fz7egru1oXfX8Hy7ThF+RF9H+Tu3iPNqHq+j/XfPsBFyusVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172083; c=relaxed/simple;
	bh=nfoWq9R7GBoKDdsbiJZ7a2NyNOq8qlYJJM0AGSKi3AQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WKonCBIRT8x8PO7oBAaMgpxEut7f9aecEALA/8iluhCWAUsaFRUMjd3lBFnATW/SfBxZlxvfzG3/8Y0PXqQRLEGMp4EABb0vTWyImpYWrJ/SNRlYP+tIY/nPHL0+T2q81wSFPEFr4J2HBoxGk8yqsHUO3/F+Q6Yk5wv2MGgQqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETCUqZLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETCUqZLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073541F000E9;
	Mon, 22 Jun 2026 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782172082;
	bh=JytJFOfxKwPACn3VV6PeQxCT3IyTWu+Q2yWyLZATs0Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ETCUqZLctKWI8afmputjxETpnh7713hSQ8tspQCfOtWm0P+b6EbWClT00dxHXMWWs
	 cDqK++sOsPKoALqoolGEkIP5BgkgDg6zmvj5G2NZTS7EwG8qV/E6DNP+gZgvh2LzmL
	 uWyWsmZhJ+KJQ7bMTglnwM0uRuFRoKWbiCnsHZoNOdzzEobg5qwpNQe5gtUfxg8C3y
	 aPaXCr3FAHvDit4FJGbWfFGOg01TUqNEKI1BU4rJfY65EFqtX9RMMA3+Ebw06Gow/5
	 DZOnbk3ibm15O5OWRrFprAJUMDmiOLZk28jzJhVo76CD7n4UccmYWxeet+HSW0YOFc
	 35ImarE2WjJuw==
Content-Type: multipart/mixed; boundary="===============3652432469569788701=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a513201b6f2574ecf1e238a0caabb170767a2006d388f86f80ca7641371120e2@mail.kernel.org>
In-Reply-To: <20260622230123.3695446-2-tristmd@gmail.com>
References: <20260622230123.3695446-2-tristmd@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
From: bot+bpf-ci@kernel.org
To: tristmd@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,xukuohai@huawei.com,jolsa@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,bpf@vger.kernel.org,stable@vger.kernel.org,tristan@talencesecurity.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 23:48:02 +0000 (UTC)

--===============3652432469569788701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a2b348f98080..21a365d436a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6201,6 +6201,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  			 */
>  			if (info.reg_type == SCALAR_VALUE) {
>  				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
> +					mark_reg_unknown(env, regs, value_regno);
>  					err = __mark_reg_s32_range(env, regs, value_regno,
>  								   range.minval, range.maxval);
>  					if (err)

In the v2 review thread
(https://lore.kernel.org/bpf/4eae275e93d8eb165da8485a127a1fd0e7f91510.camel@gmail.com/),
Eduard Zingerman requested that a selftest be added to demonstrate the
stale bounds issue. While the v3 cover letter claims the selftest was
added as patch 2/2, the selftest is missing from the current commit
being reviewed.

The suggested test should verify that loading an LSM hook return value
into a register with stale bounds (e.g., from r6 = 0) properly resets
the bounds, preventing the verifier from incorrectly pruning branches
based on assumed constant values.

Could the selftest be added as described in the v2 review feedback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27990633425
--===============3652432469569788701==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4240F8CC;
	Thu, 11 Jun 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197135; cv=none; b=K96EtsNa+l02jkCL7TNFph4RCvQWgCidXi0y5slIDZ1rA3+3AnxVwgw78Q2S30k/hk6KlRXwG9/wOspdGTrAbL/zOX03kfDH7EDB3MRJJQYCQLjWj2E9CAI4HGmSO6TfKzXPnY883fJJ7bwdoLFv1K4ZCciINPhqgWWDxR3KjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197135; c=relaxed/simple;
	bh=4ZFEbFD81u5LUhUWFKld3vbU9/8s6szbOIw2oirOw6Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xg+fUy+e7A6MqYGHLiDB6df+irT0No88fo7STZAMXE2nEVM7W6UAmrqq1ry0IlBmCTbJXb12+36e0vKxj9vNvPNP9B9713ulSHkT6tFPvC3ihqkhj6AlhU1Ua05I7WeV96ERd6RjVabtrFFZMLUqggqRKg2QPZTDawMFpRaxjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLrvBDuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLrvBDuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FBC1F00898;
	Thu, 11 Jun 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197133;
	bh=uVDpGYZZxW2DQMI8Lh5Aglbvu24Qa8ZF4UMqTtV3e2s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lLrvBDuum20nVLciqma/w8IqnhJzQCW/KEDBzYU+yR36ub0LapY+f3cCLqt835gC0
	 hmLPZReSXV+Dn+QaGlLoLV505/hTrRg2arriqcWecOF3r0lmySNRZNmn2hzXjTtKn5
	 LKBxuYnCuzMdmxEXlG8qSIMY1o14RICgjTqcueTSSrsxvG9DxoZsnDDGsMkb6Yn+PO
	 YKMPBNhta+fsmATvKEWr57INq8rXCy3PfX4kQlyPNu3u269WgXVYURB6m7zFIa9wFi
	 jxbaf8h3HIupgAz6Q3zrzDwZS6j7ml8I3Bp6O5CyDO3pjLFBTvyeGF4MDXx2ITdquI
	 zLMWEJmRz3beA==
Content-Type: multipart/mixed; boundary="===============1394429373764920186=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e70a018efc87ba1334617b2e6c75ca003e7b1345affe15f1b605634a4ebd183@mail.kernel.org>
In-Reply-To: <20260611160749.391279-1-jt26wzz@gmail.com>
References: <20260611160749.391279-1-jt26wzz@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar pruning selftest
From: bot+bpf-ci@kernel.org
To: jt26wzz@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,menglong8.dong@gmail.com,eddyz87@gmail.com,shung-hsi.yu@suse.com,stable@vger.kernel.org,mykolal@fb.com,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 16:58:53 +0000 (UTC)

--===============1394429373764920186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add helper retval linked scalar pruning selftest
>
>     Add a verifier runtime test for a branch pattern where a helper return
>     value and a related scalar stay live across the same control-flow
>     sequence. Rust/Aya-generated eBPF can naturally produce this shape when
>     a match on a helper status keeps data derived before the helper call
>     live across the same branches. Such code commonly uses the helper return
>     value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
>     branch shape.
>
>     The test preserves that branch shape but shifts the success value to 1
>     before branching. Using r0 == 1 / r0 != 1 avoids depending on the
>     verifier's not-equal-zero refinement, so the test exercises linked
>     scalar precision and pruning behavior directly instead of being masked
>     by zero-specific range refinement.
>
>     On affected kernels the verifier can explore an impossible path where
>     r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
>     test return 1. With linked scalar precision tracked per instruction,
>     state pruning keeps the real success path, and the test returns 0.
>
>     Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>     Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>

This adds a regression test for a verifier state-pruning issue with
scalars linked by scalar ID, but there is no Fixes: tag.

The test structure (success path keeps r7 independent with id=0, failure
path links r7 to r0) matches the "registers with id=0 in cached state vs
linked in current state" pruning scenario that was addressed by changing
check_scalar_ids() and regsafe() to treat rold->id == 0 as independent.

Should this carry:

  Fixes: b0388bafa494 ("bpf: Relax scalar id equivalence for state pruning")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27361218656
--===============1394429373764920186==--

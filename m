Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5370381B16;
	Sat, 22 Aug 2026 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443111; cv=none; b=HhvYRmuc75KxAMmChaHanxigRegty2DWjjRmNvSdzuQumyGGmEZUouUFy1izJ3uBRY8/qU5RjlaifvhmQHa7KpjWazcC+j84LpjXDtGU2SZVdBBiEUArSMGLvh9ALksuTQ74ap19iPMcv0k4+msNIjkgCRXUDdLIZ8QGhEOvsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443111; c=relaxed/simple;
	bh=0mZgLrcyBuKD5AheS/w+kc7tOpRuQlfY6xsMFmZlsY0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R3SwNTHkHito4GJl0byfNYm0kxf4WNEsZT1W54BiawKBeulTuB38Zox0wsh5loY8G7TQ12i8bkTLk/76djMcY9+4L2+NVgt2kTLhOtlmbjwxZAkWhRdhqXwtV0fstvflE/urqS1Oc+xjaaWkJZo0EUiPo0qWXkPBPy5wHCNDmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgj/4bM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgj/4bM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5795D1F000E9;
	Sat, 22 Aug 2026 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787443110;
	bh=2p3v0k9V8tRQ/XIc5VGij6LpaxJnDh7EBK/2icodcoU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kgj/4bM4RZDO3pHgaxXlLo1HRma5myZuk7RLsg63kJUPYBqrihK+iS0N34R21ytU8
	 juB4ITWMhydCdqfCtyNOeUhiAMBH5qOXLEsZzS9MXdnu4xSE78CoZy3HIOwyWMeDln
	 BCfNyvkRvEQm7GBhqIE8PDgDu49fQY/EiHccPmNaZQQj2BDS5vPPHjgIe+Qjui0GjF
	 lNAINl6gF/HAgy66yfe45GGf8feL0UEQ5CfPVbVy1oBQcOhqlOR2iOhDtfrHXPeNtU
	 ofZPs3KBNW7Um2y1CYYW+WOQ2fZjTCE6+1qPa6rVIlnVrRRPI3dV25a3PpROJJw6tC
	 srUF9U8Olor3A==
Content-Type: multipart/mixed; boundary="===============5750037036314627249=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a69fad06f74d4aa1ceb0f94b0cfaffb40275c33b239d4d05cf08a8b60c1d4eec@mail.kernel.org>
In-Reply-To: <20260822225444.2774461-3-simon@swine.de>
References: <20260822225444.2774461-3-simon@swine.de>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: verify preemptible uprobes avoid private stack
From: bot+bpf-ci@kernel.org
To: simon@swine.de,bpf@vger.kernel.org
Cc: simon@swine.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,tj@kernel.org,yonghong.song@linux.dev,stable@vger.kernel.org,andrii.nakryiko@gmail.com,olsajiri@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 23:58:30 +0000 (UTC)

--===============5750037036314627249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c b/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
> new file mode 100644
> index 000000000000..a18970d2c584
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c

A subsystem pattern flags this as potentially concerning: the BPF
selftests guide asks whether a new test file for a narrow variant of
behavior should instead be a new case in an existing more general test.

The behavior being tested - that the verifier disables private stack for
sleepable uprobes - is a verifier-level decision made in
bpf_enable_priv_stack() when prog->sleepable is set. The test suite
already has tools/testing/selftests/bpf/progs/verifier_private_stack.c
in the same directory, which covers private-stack selection
deterministically by asserting on JIT output patterns with __jited()
annotations.

This patch adds a 254-line, two-file runtime test that depends on thread
timing and CPU affinity. Adding a SEC("uprobe.s") case to the verifier
test with a 64-byte frame would pin the fix by asserting the absence of
the private-frame-pointer setup instruction, without needing threads or
timing dependencies.

The runtime test does exercise something the verifier test cannot -
actual concurrent same-CPU execution - so this is raised as a question:
would extending verifier_private_stack.c have been a simpler way to pin
the verifier change, or is the runtime concurrency test worth the added
complexity?

[ ... ]

> @@ -0,0 +1,165 @@

[ ... ]

> +void test_uprobe_sleepable_stack(void)
> +{
> +	struct uprobe_sleepable_stack *skel = NULL;
> +	cpu_set_t old_mask, mask;
> +	bool affinity_set = false;
> +	int cpu;
> +
> +#if !defined(__x86_64__) && !defined(__aarch64__) && !defined(__powerpc64__)
> +	test__skip();
> +	return;
> +#endif
> +	if (!env.jit_enabled) {
> +		test__skip();
> +		return;
> +	}

[ ... ]

> +	if (!skel->kconfig->CONFIG_PREEMPTION) {
> +		test__skip();
> +		goto cleanup;
> +	}

[ ... ]

> +	link_err = libbpf_get_error(link);
> +	if (link_err == -EOPNOTSUPP) {
> +		test__skip();
> +		return;
> +	}

This isn't a bug, but could the skip paths include diagnostics? All four
skip sites (unsupported architecture, JIT disabled, CONFIG_PREEMPTION
unset, and attach returning -EOPNOTSUPP) call bare test__skip() with no
message, so a skipped result gives the operator no way to tell which
prerequisite was missing.

The test_progs framework's test__skip() takes no arguments, so this
matches prevailing practice across the test suite. Is it worth noting
because the missing prerequisite that matters most - runtime preemption
actually being enabled - would be most helpful to communicate.

> diff --git a/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c b/tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32604492082
--===============5750037036314627249==--

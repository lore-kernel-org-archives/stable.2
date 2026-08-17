Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC663B635A;
	Mon, 17 Aug 2026 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950840; cv=none; b=siHCkZyoFQ8Tp3qhfBegF8dfT58XSkM/bNtv9SHwVxQjQPwxojFclq3faVC/qh/XaAYxKATLHiN38C1nTYpdtVb0VyrFAf420/+HXbxRSNXNkUxLzGWzXVANa5EuUht3NSSREIFZxMrvKnESRQvUOTv4iT3TTmEyfeP9R0uSNfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950840; c=relaxed/simple;
	bh=dNiBm8Z4TPsQpQc7cLPtPFMQKci3flxF9+CF8nRfLRs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n8AuVsLWmspQAiEJ2F5f1M7y2OZF82zVmubkQNxpfq50ijIHQer05gGMQgrRUj7aFyLppPX5C4lbNy7ajLIls7TV0c6krKe7Z3BbjZZuXcRetnuYpzfg26PPANprIoVQZNEVeS9RneMogBkfkEjmEEP50M+KJbvI5Pm7d+bvbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y224I2SD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y224I2SD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E4E1F000E9;
	Mon, 17 Aug 2026 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786950839;
	bh=dNiBm8Z4TPsQpQc7cLPtPFMQKci3flxF9+CF8nRfLRs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y224I2SDPGu1RwxqHULAl/1tYEvIsZMkDqLKc6u7GtMXv+ra0UePzREYFyqHknITo
	 4jlIuOSPeiJfwUMmkYSvz5CBmOyLaAomyuu5hRRLXrG8/x5gy+z6ebsZnxp1hP+JMM
	 B6LrjT7Ljcg8ugyTjYj0mVSLtjnSbm/tQjOx37Tz+SnU4sW5wyn+8zPSTstsS6kAcX
	 /qYUizFqrwwruhtFvZW+rmPciVWCr4WkqJFB/DEFdVVi2/i64s62rBV2Lu01FD49j3
	 m1aegDV4ojysTS9p4jyrbRF3j79CVutevVOKBeWwVXqUWPXsECXXAdOR2fQB+xnja1
	 NyRO5uFnELdvA==
Content-Type: multipart/mixed; boundary="===============2466479123060906233=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61f56e7f20ef48c6be7829c12a0cd02a57fbcea73ffd4b537af9a85b6e6e3781@mail.kernel.org>
In-Reply-To: <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
References: <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
Subject: Re: [PATCH bpf v2] bpf: Enforce cgroup storage map consistency for freplace attach
From: bot+bpf-ci@kernel.org
To: 3472274613@qq.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,zhuyifei@google.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,corvus@tencent.com,henrymei@tencent.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 07:13:58 +0000 (UTC)

--===============2466479123060906233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Enforce cgroup storage map consistency for freplace attach
>
> When a BPF_PROG_TYPE_EXT program replaces a cgroup program, it
> executes with the target's runtime context, including the per-program
> cgroup storage descriptor attached to the cgroup prog item:
> bpf_get_local_storage() resolves the buffer via
> prog_item->cgroup_storage, so the extension's own storage map never
> provides storage at runtime. The verifier, however, bounds the
> extension's bpf_get_local_storage() accesses by the extension's own
> storage map.
>
> The prog-array path already enforces that programs sharing a
> runtime storage context reference identical storage maps (via the
> owner cookie matching added in commit abad3d0bad72 ("bpf: Fix oob
> access in cgroup local storage")), but the freplace path performs
> no such consistency check in bpf_freplace_check_tgt_prog(). An
> extension whose storage map differs from the target's therefore
> operates on a buffer whose size, flags and layout do not match its
> verified assumptions: a smaller target buffer leads to slab
> out-of-bounds access, and even equal-sized maps can bypass
> BPF_F_RDONLY_PROG or mismatch BPF_SPIN_LOCK fields.
>
> Reject the freplace attach with -EINVAL unless the extension
> references the exact same cgroup storage map as the target program,
> matching the cookie semantics of __bpf_prog_map_compatible().
>
> Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")

Does this Fixes tag point to the correct commit? Looking at the commit
history, 7d9c3427894f introduced storage map sharing between programs on
the same cgroup.

However, before that commit, bpf_cgroup_storage_assign() bound each
cgroup storage map to exactly one program. This meant a target program and
an extension that both used cgroup storage were guaranteed to reference
different maps - the mismatch this patch rejects was unavoidable.

The extension's bpf_get_local_storage() already resolved the buffer from
the runtime prog-array item rather than from its own map even before
7d9c3427894f, so the underlying behavior existed earlier.

The condition became reachable when dynamic program extensions were
introduced in be8704ff07d2 ("bpf: Introduce dynamic program extensions").
Since this is Cc'd to stable, should the Fixes tag reference be8704ff07d2
instead to direct the backport to the correct range?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32002984717
--===============2466479123060906233==--

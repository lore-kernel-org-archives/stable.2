Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210ED3F86EF;
	Mon, 28 Sep 2026 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574819; cv=none; b=nBIKn0yL2PlvSuLVdDi1sFu4azz/UvAo6wggdEvpN3otbpjlgWX+bB1Mz9hMnKYFglFYbwQjXCMqZua/SrnmcRq4Aou/QAJ6f+TDRCoD+fgdCUKVAYj4sBL3VQB7/pj5A6YN60RsSgRKa9MH/2RoI//JtnYe0RBBPySQowMYZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574819; c=relaxed/simple;
	bh=DunKnc3bPJ58jVAWjZyerYcgdaAXaL1XDTzmmXf9obc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jsEv/VAKsjFPWzf+gb/LuKrtUuPrCV/aeNJHDPxctBOx0KZNt2X9NXyHPsevUE9dRyiptHbhb+gWhnkU1PjmiMCcvnON6BHCg8PC1b0AcFRNtc2eNN1HEP0FUPq6GrX6kCVHjx3RCIJqgCt3Kmf2UYx184ogisgqyat2pl/seP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFgQYIvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFgQYIvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF61F000FF;
	Mon, 28 Sep 2026 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574817;
	bh=oiaWAk2ChzwSv+/OHxCIuOjma1tWl+GAlbfyo47VIHo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YFgQYIvqNH5Y0lPP6y/Ba0aWrLpu4gI1vjh21V1qIY8jRvSF5FUge7FelPatbAqI7
	 b1p1msKmXEEjeb17CELxSOGRjThjBWR94m8KCKCve9VokhW2tybgoTFIzwMIR6UUxk
	 9Xdai2nE/ZG9SDF2NVAuHOXsfpFMH55VJqMoIMkNnMxj7Gv+2ag9WrgjsElI036QyZ
	 fdrYSCtx9iLkD+Aj1GuilZUGtBmJ54h7pSZ1EMMO4Xbc9t9uQFf07SBZ1mKUHQInY/
	 pB238vuX+owGxxE+m2FWdGn4DpY5zDSMjnyizHPIMhu7fWaGHjiB24ZUhSgafx3owT
	 5XqswYVPyXLfQ==
Content-Type: multipart/mixed; boundary="===============1210779320454498450=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c4f07d70efb357deef9f256e98298c9ef861831e3ffcfa4bd42fbd9b4b31a5a@mail.kernel.org>
In-Reply-To: <a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com>
References: <a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v14 4/5] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 05:53:36 +0000 (UTC)

--===============1210779320454498450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 6ef500644d23a07941d6ec45def92b9391c03a10
> Author: Abhishek Dubey <adubey@linux.ibm.com>
> Date:   Mon Sep 28 10:43:53 2026 +0530
>
>     powerpc/bpf: fix alignment of long branch trampoline address
>
>     Ensure the dummy trampoline address field present between the OOL stub
>     and the long branch stub is 4/8-byte aligned, for memory compatibility
>     when content loaded to a register.
>
>     Reported-by: Hari Bathini <hbathini@linux.ibm.com>
>     Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>     Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>     Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
>     Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
>     Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

This isn't a bug, but could the changelog say what fails when the slot
is only 4-byte aligned, and briefly explain why sizing with an
unconditional NOP and then conditionally dropping it in the final pass
is safe?

The load-bearing rationale seems to be missing. From the code,
bpf_jit_binary_pack_alloc() only guarantees 4-byte alignment of the
final image, so the SZL-sized slot read by the long branch stub and
rewritten by patch_ulong() from bpf_arch_text_poke() may be only 4-byte
aligned on ppc64, where an 8-byte access is then not guaranteed to be
single-copy atomic against a concurrent patch.

The non-obvious part of the fix is that the NOP is emitted
unconditionally in the sizing pass when image is NULL and conditionally
on the final fimage address in the codegen passes, so the allocated
buffer may have 4 spare bytes while jited_len reflects the actual size.

The phrase "4/8-byte aligned" also blurs that only the 64-bit case needs
the NOP since SZL is 4 on ppc32.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36381917401
--===============1210779320454498450==--

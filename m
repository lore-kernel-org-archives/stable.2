Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12341E6D8;
	Tue,  4 Aug 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828650; cv=none; b=sEzybW+OUmy1wYsxG5Tg6v1RgsdAPVLHZVTHEzkQlZxhZHb25NXFlScvKc6tp5odNk+KsX2M2TdSsvxfH2dbpfA6clRN4vI2iay4mdcCJtivCazqgwCChckcfdXf7Ctkc20IalpF3ri8Lmz9Rm2Bx8zlfrd1HtyFu4lnO1z/+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828650; c=relaxed/simple;
	bh=uQo5xmHWgWZM+XNe9mvOTnt7Nc54mzCP0VFu1Jw45J8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eNrEJMJ20FZ8r/peEYDFrxWmI5o1NqAKWDUrd1NchwMUg9l9BcG8e3JmgGfGLAbB9gVl2erCDxI2dM7E+wqOg4IZUCgsU56+g++x5qQDQ2YMGWhGfkU2QSw+fhIe03R2kcyTICFeSd1TRwjF9GMXC7b/xEbO4e/PGV9jl7xb4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6Q2mknU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6Q2mknU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E51F000E9;
	Tue,  4 Aug 2026 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785828648;
	bh=Mgv41DrsNNY5KSr/+kJxMfoMTv6unJRL/btwkappeSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A6Q2mknU8T3IvjsgFjyXL0egXOcFAG26Uz/FjLstMJZEgxpnRnPaG68g9mYrqKCDe
	 vp9nGDvKH8UHypZmK2NTl6ylGqqIEfahcif/wLkqOlT5lLcZEDiM2297uoGfLSDKlG
	 1deN9y5DYKPi/FQNP2xh9LnmbFhiXpG4lDk4iQA/Dv7Du0iFxQncSfjTcoVsiLBTM7
	 rSdtvapvon+ATdJBa69+Pt6Nc0z1XfCTlKVJGgmuJwcXDqFm4pYRrRHcjPQSXsXLGd
	 HMj9bIFgTsBQVK/6o4FibqsHnet8Y69p57pICfXGVdtk4+ryMTkKQzLIlw/JrXiB46
	 NM0F2qPTaqMsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B123924A65;
	Tue,  4 Aug 2026 07:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178582860939.3014158.15212060647956229102.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 07:30:09 +0000
References: <20260731003925.2728977-1-ebiggers@kernel.org>
In-Reply-To: <20260731003925.2728977-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, emil@etsalapatis.com,
 jolsa@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 31 Jul 2026 00:39:25 +0000 you wrote:
> The BPF verifier and the dynptr abstraction ensure that the memory space
> referenced by a dynptr remains valid.  They do not, however, provide any
> guarantee that the contents of the memory are stable.  kfuncs are
> expected to remain memory-safe even if concurrent modifications occur.
> 
> bpf_get_fsverity_digest() didn't follow that: it could crash if
> arg->digest_size was concurrently modified.
> 
> [...]

Here is the summary with links:
  - fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
    https://git.kernel.org/bpf/bpf/c/3e8ec7c03872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



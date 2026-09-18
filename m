Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CA4BD370;
	Fri, 18 Sep 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734497; cv=none; b=CwT2CoFyxHW3XD8Mh8RRgNxUQQj/Nrf3Z0SFyU4oasEr8d1LPoYa/pBvAktVPe5KJSPUzfjtRH98lI5lDeqO2+mq/gWrtssAmezlyjJ419QmiLwwu8Y51711MtlX+GEGnxKg0udatLbiUV/GzVi6xvHlgQsaYzbhk3rgA3MBer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734497; c=relaxed/simple;
	bh=FcF/CoiAitZeJ7aRj74ekADOE+YPKZ2/KzjUjBOz7j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDIpuu1F7jjLcfP71YBnkG6xXAW84qgCL3rHXz4mAlKmFtrPCqav0xpD5MtiXRK/rZCjHvvC3ZdW7YirfDK52/MzFTM5z9bYnBx/x/OhnKGvuR48NW2Mjcuq114pebRlMrA6clVcq8qvNyFuSVkelx94OZjC5mxrrEnx+MfZXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCqy2Ksy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCqy2Ksy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864791F00898;
	Fri, 18 Sep 2026 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789734495;
	bh=7t4xYZPS5/zZ1VngL4kG1hvUave8IACXX7PMjAjWykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCqy2KsyM+zvVJpaZisBGtEEzqYvC9v7ViEJhlwJLp4DUW+lZkn7+Y5fFG+Fl3hzf
	 joPmMHB3+CmpBBEup2zZxaGtud/kQ8Zi6YOlJwSUJ6zCLMK97GGfNKMLgixZXRJbIg
	 64zdfeP6tvvgQN/A2JXcXKcL2XV0hUpfsZFRLNmcSv+/B7QrNJKZtmfyD96aWlBBZI
	 KqcOqkP4Pm6bZI50foFQLtoipVmXK/dr3zT1tDpW/CqcQYZ6jGeLQREmQQUhE4I6fA
	 phLLTFrOcl/GGY5yzkMcVc2FFgYz/uIiMR2410X5xcnQ6CYz4/H+QhE7YNpWyvpB3C
	 xQ6GggrRq6zkw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	David Carlier <devnexen@gmail.com>
Cc: mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: match the target implementation CPU's own MIDR
Date: Fri, 18 Sep 2026 13:28:05 +0100
Message-ID: <178973065688.2324564.11650949029036534707.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906121421.60575-1-devnexen@gmail.com>
References: <20260906121421.60575-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 06 Sep 2026 13:14:16 +0100, David Carlier wrote:
> __is_affected_midr_range() is handed the MIDR and REVIDR of one target
> implementation CPU, but tests the erratum's range with is_midr_in_range(),
> which re-scans all of target_impl_cpus[] and ignores the @midr argument.
> The range test is thus constant across the per-CPU loop in
> is_affected_midr_range() and only answers "is any target CPU in range".
> 
> Since just the fixed_revs REVIDR check uses the iteration's own registers,
> an out-of-range target CPU can decide whether a MIDR_FIXED() exemption
> applies. A VM then enables a workaround whose only in-range CPU is fixed
> silicon, e.g. erratum 2658417 on a Cortex-A510 r1p1 with REVIDR_EL1[25]
> set.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: errata: match the target implementation CPU's own MIDR
      https://git.kernel.org/arm64/c/b7403afb7a5f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDA48A8DA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134269; cv=none; b=JNDwJsfFuMxQm+KjLLB1q1Xq0DlpnKjTc/hmsnG/gz0VuQ8hIUgdx55i/vrf13UuNCZbCurbkK7lMH99W9oiqv5d6TzOaMltGFDF1sS0WsPAV/BzdZkEfaPF8XR/fsPvIl+IzrQdEJfvFZWH5K1/hsEiSMgO6EfqhH1hPHCBa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134269; c=relaxed/simple;
	bh=RBzlAegoy/oPKmTPUcJtwWvy2wxK5zyyU+2tEKyGaUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3FHVB6almERdfJtd2pfU1HS44b9O1MWu74lN12TCFzhEISGalS6OSYTV4tnWNPVfYK068defhTWain056EQz0jrf73ktyG9IcOiGX3L97WJDZa9lwwCFyYqEnuV/w91w6PzkTH7rHD8PHj57weUe45o1wpkP3sR5z8//a/WGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ3QFGOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ3QFGOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD71F000FF;
	Fri, 11 Sep 2026 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134267;
	bh=O/gnEWBZBBZeAGzcXhNZJLq+4jTjWHhMRP3+5fPBvFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZ3QFGOfGKR1bOVfD2b1kPQy9WekS03uMZ8D7/gg10AN9xnBV/2v+byGsD0T5k0Rh
	 +UfZqDfqcJk20w+R6EZbm4n+rd2T9pkcrG9JMhigWdAWAWK4/xleJcmc8EBd38vwDz
	 OiQhidquGjHh/OtQ6g8MR/xl1iLpQYNDIlADe8p9VU6YQO0ApPiTPxP7j0xU+lrn35
	 YTi/t7NDaT3lQNst5vjoeJHwvTDWxhFnEsUGnJ7SaO+kb+DG9l2GrgjiR52FQOhnQa
	 UiGcLsdG0qMoiCEV9kg/AxIux9xYkPzsH+drBOvoIkQMcSDiGKVgcHOL09fp1m0fGd
	 pb7/Y/ypj+G8A==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ada.coupriediaz@arm.com,
	ardb@kernel.org,
	cl@gentwo.org,
	david@kernel.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	ljs@kernel.org,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v4 00/21] Preemptible this_cpu_*() operations
Date: Fri, 11 Sep 2026 14:44:10 +0100
Message-ID: <178912994348.2451035.18388822109867455442.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908151741.394589-1-mark.rutland@arm.com>
References: <20260908151741.394589-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 16:17:20 +0100, Mark Rutland wrote:
> This series reworks arm64's this_cpu_*() operations such that they do
> not need to disable preemption. The scheme is described in detail in patch 13,
> and is similar to the approach Heiko Carstens applied to s390 [1], which
> inspired this series.
> 
> This scheme should build and function in all kernel configurations (e.g.
> regardless of KPTI, SW PAN, CNP, VA BITS), and has no dependency on new
> architectural features. The fixup logic should "just work" with kprobes,
> etc, and I don't expect that this will need to become more complicated.
> 
> [...]

Applied first three fixes to arm64 (for-next/fixes), thanks!

[01/21] arm64: percpu: Fix this_cpu_write() casting
        https://git.kernel.org/arm64/c/885bff055a0f
[02/21] arm64: percpu: Fix this_cpu_and() mask generation
        https://git.kernel.org/arm64/c/44274c657256
[03/21] arm64: percpu: Fix LSE operations on {8,16}-bit types
        https://git.kernel.org/arm64/c/8cf2093f5372

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335607;
	b=zPobCpRlSrI2QEbTBjQOrVy06zQ6PPUzJpqp1Zf4teaHqblp9B8tbp7jCfhVrpkLCxw1
	 YqMIYYbb2qbCdl9pN6bM1AiVDLyvYTyl0bcLym16OhvuRWIXL1KruRA0hmfDbmORlXA7A
	 2dWZGEVdG/Y2AY5VHQXqHVdzYb3rQoeiA45KAP3sC7vSrZSzzooSO1koZQhVJb6vKCWTz
	 1ciw5HqFA02eMKz6olwnNKTrrdwvxUmnylqrKd2ibFNO1rdODKSZB+PtXhEmhq8Afof+N
	 8LXLToxUhokwZdnBkUri+Pw0+PbsVH0YyDsWIM5CfBiu6gRkew7L8X9DVlyOMHhWT4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335607;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=QsGdKG/KD49x8kh/L/31jkdnS0AYzN1/NmNkRV4H86Q=;
	b=V5kAMNTVlV4RZ+8yA75/Rza4PdsbTwphweTR6qtLnj/FJ+7HNqItThfKXo3NHz4cMrsx
	 HKtB9kpy4bQk38T4TEw5x1I5Ym7QqA7OSXM9ziWCsrlWphQfJ1fl0mjueN3iL9/Bfxwv/
	 BAZh02gnM0YmrAUIR+3RQEKotLwqQURBQVjXvHSSxPR93BHKi2esli37dwT6EsT0q1UPH
	 dfa/phG8dgfoS0sG2HFLvqVUwIgGt4CWvjHlyj4WnoqjqSQjd01Oeul+Faj3vLqTDxPz8
	 xFwzF7Gd+CiG4kEmELx1YQkJaTXv/Ts0/2UT1ze5GcQYzpNN0yfpkqTCwMkgpjzw74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qkdmn5b2;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D3606A31C;
	Tue, 10 Nov 2026 18:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qkdmn5b2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F3921477;
	Tue, 10 Nov 2026 10:33:21 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316683F85F;
	Tue, 10 Nov 2026 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794335604; bh=wZpA4tSEkZzY5bAQjPtDXzsMjtvMfTAPE1zEhv36Z/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkdmn5b2WFR6H+pW4M0yFIkY8M/jdb7wwi3KaQDM0fXSoiXHNUIiBM1iJY+mjkVHT
	 vLzDDTbB6NUbsjbVkGRFOHzbVG5NQ6/HnA981y2+MpBXQUrVQKPB+4dtYDFFxrKrhF
	 FkxD5vu8FlMT/cYZlDI+Tm2lV/jNbEWsxKOZEV14=
Date: Tue, 10 Nov 2026 18:33:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peter Collingbourne <peter@pcc.me.uk>, stable@vger.kernel.org
Subject: Re: [PATCH 01/24] arm64: Fix lazy TCO clear when enabling user MTE
Message-ID: <avNjcKtuQkZW0_Sr@arm.com>
References: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
 <20261107-mte-kasan-split-v1-1-d84ea5f30f94@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261107-mte-kasan-split-v1-1-d84ea5f30f94@google.com>

On Sat, Nov 07, 2026 at 04:36:07PM +0100, Pierre-Clément Tosi wrote:
> On kernel entry from EL0 with HW KASAN inactive and user MTE disabled or
> in async mode, mte_disable_tco_entry() leaves PSTATE.TCO set to avoid an
> expensive write, as it assumes that EL1 tag checks are not needed.
> 
> However, if the thread is in the process of enabling sync or asymm MTE,
> set_mte_ctrl() updates SCTLR_EL1.TCF0 without clearing PSTATE.TCO! As a
> result, kernel uaccesses miss tag faults until the next context switch.

Nit: next context switch or another syscall. I think this makes it
clearer that the only potential missed tag accesses after the prctl() is
a signal frame write as we don't have other uaccesses.

> Clear TCO in set_mte_ctrl() immediately after setting the task's SCTLR.
> 
> Cc: Peter Collingbourne <peter@pcc.me.uk>
> Cc: stable@vger.kernel.org
> Fixes: 38ddf7dafaea ("arm64: mte: avoid clearing PSTATE.TCO on entry unless necessary")
> Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>

The patch is correct but I wonder whether we need a cc stable.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

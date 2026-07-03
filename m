Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413B2F8E9C;
	Fri,  3 Jul 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096112; cv=none; b=aYx3d6kgwvPgeoUqTNi5LBBdeaLbXTP7pbCWKGLIZh+fURDqzHoK7w47kCNe4dQpq9q1n+k/vcUwRHVoTxcJxiHPf2i6x3KgJGvM66wc0A2m3SnxRvKYDY4b8RbSOG4SeLxwWvtzKaiJQIR32U25G/l78lE3yFx5QPS6PHrTkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096112; c=relaxed/simple;
	bh=hcr/VLRoB6bOL7od2RJpsiqly4sCMoyU4iz0d/lMjTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p22Z9JVHTFe2HuklRQd6zgpkoJSF/S2cpurpQ5z3GrPNR54wyrNolot9oP/GMBkUYE9BS2XAdVj62gLp/6CFHTMIuHn5gkeoRDb9nTH2kA6mpYHdcduDrD+5KJzjypnlvfsf334ChzD2DUasAz2SFvYFhA3+XQ7CK/o4LaQjZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gF2WbR/W; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gF2WbR/W"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5DA71E7D;
	Fri,  3 Jul 2026 09:28:25 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F493F905;
	Fri,  3 Jul 2026 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783096110; bh=hcr/VLRoB6bOL7od2RJpsiqly4sCMoyU4iz0d/lMjTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF2WbR/Wf9hS09+xZK6JhcHHu6PbPN2K9KD3T4cUGcy8JE3xadOOPtFQtuNps/yF9
	 aCFHuItvlieixXf9raOV51gLR8iJtvOC9FPqO8FM2wzEi9bUbGiItUJzFGPJxQqU9m
	 L9sWLC1odQPoLYqPu8x0KiZEzsCEQiJf6+gfRvyw=
Date: Fri, 3 Jul 2026 17:28:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: fix checksum computation for per-cpu objects
Message-ID: <akfjKpv838nqsl78@arm.com>
References: <20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org>

On Fri, Jul 03, 2026 at 09:17:24AM -0700, Breno Leitao wrote:
> The per-cpu object checksum folds each CPU's CRC together with XOR and
> seeds every CRC with 0. Both choices make update_checksum() miss content
> changes:
> 
>   - XOR is self-cancelling, so equal contents on two CPUs cancel out and
>     simultaneous identical changes leave the checksum unchanged.
>   - crc32(0, ...) over all-zero content is 0, so a freshly allocated,
>     zeroed per-cpu area checksums to 0, matching the initial value, and
>     the object is never seen to change.
> 
> See discussions at [0].
> 
> When update_checksum() wrongly reports an actively modified object as
> unchanged, kmemleak stops greying it for an extra scan and can report a
> live per-cpu object as a leak.
> 
> Fold the per-cpu CRC as a single rolling checksum across all CPUs and
> initialise the object checksum to ~0 so the first computed value always
> registers as a change, even for content that hashes to 0.
> reset_checksum() is seeded the same way.
> 
> Link: https://lore.kernel.org/all/akfYImSNDh3OjIfR@gmail.com [0]
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>

Since you added co-developed-by, I think it needs this as well:

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

(otherwise I'm fine with suggested-by)

Thanks for the investigation and posting this.

-- 
Catalin

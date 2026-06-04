Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC8492506;
	Thu,  4 Jun 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591822; cv=none; b=m/odLRcpyFP94QDBpRiYiWlPaZvLdesEzqV1hvwupZ59JfP+2IFlRmRRvNDgzbXOeb9dMbE4gXJyUa6Ju5T20mTmVlleNPgZpZMlR6NeuuhfWSUVeH3lo1hWbmKfDBm3czV4zKbgsYJlGU8qafqRJPnhApbVWgy2AINJCe5K47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591822; c=relaxed/simple;
	bh=38JUf3SZ3VZqsjB6ynqgMt4h1xyvY4kOLChEDF6u4d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHz410P5ACyc+VTmS5L9+S+yqU8I8Stl7VTITBV+WaBJGzrkhaFqueUn96w2IJUEIQOxyKVP5/iF528xf6FoM8BpZdVpVkCasZzC2vOT+tN31Ei+IgWyGpCHk8zQ3OFBVYGCmRh/D71kxgq1/s0/W/W5JKmplz6l4uxULiW+9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=s9dQ6haN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="s9dQ6haN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09104973;
	Thu,  4 Jun 2026 09:50:14 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69B6A3F7D8;
	Thu,  4 Jun 2026 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780591819; bh=38JUf3SZ3VZqsjB6ynqgMt4h1xyvY4kOLChEDF6u4d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9dQ6haN/Phb4x7EJ9nXX4Ifq3IDaQ6kHbMraTI54HI8i1ea/p2XV+NUMIvr4+DsI
	 kV8Cwns9sWiYe2i+9JVDFs5JS4LLzzfPD/NLHnfYe88SopVvS5wDynFR6tg9lnoIWl
	 F9TIr62X0u7ngaCkrZ3JjstbwZ3B11i9jkTU+d1E=
Date: Thu, 4 Jun 2026 17:50:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] KVM: arm64: Omit tag sync on stage-2 mappings of
 the zero page
Message-ID: <aiGsx2Ls676t7-iJ@arm.com>
References: <20260604151151.150377-7-ardb+git@google.com>
 <20260604151151.150377-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604151151.150377-11-ardb+git@google.com>

On Thu, Jun 04, 2026 at 05:11:56PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Commit
> 
>    f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")
> 
> removed the PG_mte_tagged flag from the zero page, but missed a KVM code
> path that may set this flag on the zero page when it is used in a
> stage-2 CoW mapping of anonymous memory.
> 
> So disregard the zero page explicitly in sanitise_mte_tags().
> 
> Fixes: f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")
> Cc: <stable@vger.kernel.org> # 5.10.x
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

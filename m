Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565E49C4C8;
	Wed,  2 Sep 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366242; cv=none; b=bjCPs8tx25UH/dmvZ57gXZUrD9VkolLTWITJeezB2cgg7sKoYxMqb4DPZ1D4OZLQHpTDjykJgmWX1ARrvVA69l/clE6pN6d2zN6oKDJDm0ydZdJalPQXcvV3uNmtmNcbUw3TjeOUBe53P4lQhVxibXoecA7OE8zRTf/ke8v5Wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366242; c=relaxed/simple;
	bh=Sv8+jp5k/bUDRs3ouxA6bC23CuTA5ChMaFkmgMbFpHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2HLr5jGnXHTxh9iNl+7MIvZhc1zZvlL08gPOOEtcJJRSDGuNyIYh+OE9MEVylFOTIgloL88pwFLeUZKDPqH/S1VXOMSsxmlaw6G0IFu8cxuLe9cpyvtDDmP9b8QaYorjr+zO9cQ1NNYaAfIXQTRyZWoAO8RTeHlyk3NGvvY+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS5z9mkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS5z9mkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A411F000E9;
	Wed,  2 Sep 2026 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366241;
	bh=DzCR3vb3/ecs6a0QnSjA+pH8109oGOY0mJv1v9wZtZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fS5z9mkwscerKkaDxWQvaj7vS6Gv3o1ZG9OwTX8u8KouGRFIE6baUwzh9Dr+TlNRg
	 uJWrsor0gfeqwSWGaIddAaIdjr5EPZAzaEv/+mC6QgD+V0txJOs8i86CsdCx5WiQwg
	 UeiTqouNj9LST12DMAXBKFlXQyrvyksO2kZKO70/Z9X3jTBENZpT76Zx08jn9VkEFP
	 8prZ58Hge6niAGJaWXA0z+3TwP2lvxDdh4pm3qgNMv0tkc1y0luLWIk9dpPbb1SnxR
	 MXXIA2QJG0nqoyDaAXso4MbQlBiX6BYcm+QHC4av0gpxKIpcoKTXhq5yJSGyaA2hiA
	 a44ysmJ3g6awA==
Date: Wed, 2 Sep 2026 09:23:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260902162359.GA2497@quark>
References: <20260831212248.213805-1-ebiggers@kernel.org>
 <20260902133706.GA21538@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902133706.GA21538@lst.de>

On Wed, Sep 02, 2026 at 03:37:06PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 31, 2026 at 02:22:48PM -0700, Eric Biggers wrote:
> > Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
> > before returning from it.  This is needed to avoid degrading the
> > performance of any later SSE code that may happen to be executed.
> > 
> > Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> > 
> > This didn't get taken through the x86 tree.  Andrew, it seems you're
> > taking patches to lib/raid/.  Can you apply this one?
> 
> Can we do kernel_avx_{begin,end} instead of having to open code
> and document this everywhere, please?

Again, there are cases in the kernel where both AVX and SSE are used
within a single kernel-mode FPU section, or where a CPU feature check
occurs within the section and one or the other is used.  So that
abstraction will not work as-is, and it would be different from all
userspace code as well.  If you'd like to try to refactor everything you
can try to do so, but let's not block fixing these bugs first.

Also, AVX != "vzeroupper is needed".  The relevant thing is the width of
the registers used.  There is 128-bit AVX code.

- Eric

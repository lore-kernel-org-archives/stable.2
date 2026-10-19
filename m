Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421972;
	b=0iq8pMPOXhjAz7ybUawRBCG7VP+EKFj5DzqwEzn69h3Gy+EAo3qXMYf3HqHf0PIXoEYH
	 4LCWVzDVhh+K0zhFlGIwFxwHrVa6tDWYJWIayhRXQ22u48rkelVBiuxUIeQU4JZ+RZFE3
	 n1mlby30m3Mf8d6Zl4UJW1BKVxOsjFRXyzkPE5j+aJq2yXTv5W2opKrLw5oIzhSB2WnK0
	 XAVbkeusyObqDDvXBZMsYm4xUZ3Z9rjiT+jkp/fCrW/rNKJ5dhN5nd+W+L72g4FZD1CXO
	 Oqv3p+Ke1K3qJr6Lb59AAmxgPbELmHJTLVFrj2InTLHJ6a7qqpl7k6p7lk4GhvwZmeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421972;
	h=Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yve0cUum9UQSEKmMOgKb9cO5F5O72C97ZH6SJDHLlwk=;
	b=GpQlw5Pm7QHkoSNZcdKhbPTiiqVC8TGk77fQdG/PqiAB+BHxY3EczVXdiVpXeHJoSPhK
	 9wKwDS2B9PjJ3z3qeLI19xw9rKfSz/rm3QFYfe1RYyLZPbmfpSOh/KDyRyJDkHcVv21xp
	 YaSNFpOxuZ4EtAP7+4/s3l72fSM7beeGq5jS/SRS15db1ANNWHKzRR3xRwIkBzaaogrtq
	 eF+93OcixAAazcU7QIZq1E7R9q8lt2FVqO+KLHCkRDY5+Igsf5El2am/XTzpSJk697MMz
	 ziaNAfRswenTtlYyz7Kx/zdAKlJBvIyRKMqT5skufbeafHPa765Qxp+Cp+/6WMzbXCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9CQocWC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F346078847;
	Mon, 19 Oct 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9CQocWC
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2A6513C1;
	Mon, 19 Oct 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421972; cv=none; b=V3mFbQTMJqP1o+0cmp8VRhRbamWZzZFIEdD35xdky6kDAg29cXgi+JCrK2LcZzDgt7dJT0g6oFzUU3uFNOrUXV99lFWgpwBfCuXne+lhXSADJAy+F3xEq+rYfdki7u8O/dcYG6OfapefDHHFqO1GN+agok7fIDQuPsvatjLP00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421972; c=relaxed/simple;
	bh=yve0cUum9UQSEKmMOgKb9cO5F5O72C97ZH6SJDHLlwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+IJFNnT+hyzuM0Amwnt/FsqJ3rQivmOwwkULXUOzq035h6oQFbQ9SelrigFisK7mGUjq+CSbL5lVRhlFmH3SlvI2rYLsGrUm4MhT0bMdHJs4Jdw8LBPhwjuxIV6i/mMgNEEogMoyFNSwbJjggaCCYZFsoK3ks9qKeuler/9qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9CQocWC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAD1F000C4;
	Mon, 19 Oct 2026 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421970;
	bh=yve0cUum9UQSEKmMOgKb9cO5F5O72C97ZH6SJDHLlwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d9CQocWCrg1MwkPcNEJMJTPoYIufvaWwh7pFHAQXpkzVF3uzdXwg0HLcq8QO/UDoJ
	 nYY2j6wFjSjqMNiiN3eIkKE7NnxlOhm9APJcn7RdKsXPOOT5TG1w5B0wrT6xNjF/wJ
	 WCWmur5wo5pI3OXmNZB2/p/GW+5uOp6ttTsAiT1G4Vzonsno5y/unM28H5i7aX50hf
	 lKJYk/asfEKtupqvgScK8RG7GL99tx3n+2zhO8A4lKTO8Fyci2FsQPnGxuYX91GeH6
	 4BIRhxBT2CiXQwwovFJ6ZeVFgN+8oZFsXegfZU2Jqp5FHsYjUU2vDIAfZtcnSYSc3r
	 5Fnq961JIFrBg==
Date: Mon, 19 Oct 2026 15:59:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: Re: [PATCH] mm/mremap: populate calculated fields in vrm state
 correctly
Message-ID: <atYv-s4dz_UD4YXJ@gremlin>
References: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>

On Mon, Oct 19, 2026 at 03:28:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> Commit d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
> introduced the vma_remap_struct helper to pass state sanely through
> mremap() logic.
>
> Part of this state is vrm->delta - equal to the absolute difference between
> vrm->old_len and vrm->new_len (the old and new lengths of the VMA,
> respectively).
>
> This value is used to correctly charge accounted VMAs.
>
> When shrinking a VMA, mremap_to() sets vrm->old_len equal to vrm->new_len
> having performed the shrink of the VMA first, prior to any potential
> move (e.g. MREMAP_FIXED | MREMAP_MAYMOVE specified).
>
> However it does not recalculate vrm->delta, which results in incorrectly
> overcharging the VMA.

Andrew - could you update this to:

>>
However it does not recalculate vrm->delta, which results in incorrectly
overcharging the VMA when both moving and shrinking a VMA.
<<

To make it clear that only when you do this (rather unusual) action do you
encounter the issue.

--
Cheers, Lorenzo

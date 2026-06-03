Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11F46AEEF;
	Wed,  3 Jun 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488432; cv=none; b=FSvyVwOQ7FA0dRPvn57iMonz2WjQ4H1aEJ4EoLGBzp3dPDYOXmjDm9EJojE7VveKivrPkMn2bS2lqaGGvw41o11eUV+/CQ0WmipHxVdUXM/wv82Zi4NhpWkbsiQV5qnP0maAM7MOe1JeyoUmQYeOjmdnR9p/nq/XEZuc4u60670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488432; c=relaxed/simple;
	bh=E5rIMKuyhWbd3Zxun55NbugrMDv5v+spiyX8e6rGRmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B43CnUUO9VcQNXoOBZYxpfejUoTNRb02hvD10WRXsey70Ooniecmr2sUZ/DH2t/y4/6KohZQogid1NK6EKWbngw+8lpcRURILrlYWl/Eu+0tZist2Z514qv/zYw5LoTgwbfu3hu2d7q9D1n2nHPqFEahMXPUhO84KbrK7Qcl8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYm5CHKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYm5CHKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D1B1F00893;
	Wed,  3 Jun 2026 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488431;
	bh=41Cj/PxB8IV5xLxJUHx++raQ0rPB+IqmfFjkW4NJYZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYm5CHKC81StCRxxxKFlG9szspVf4C7KNhgbWzh8h8wwz4fp5dFA1CheUmvOySY+Q
	 k3syGp4c2BYlIYZCBfVP9q25Qqs247hV6hxQsEK1D4+yC30ytHaYjlkNWGaXiSvsc5
	 mX4P1WhonPESIh7xNSbb7mnrbEiSm12M91Rb6WdWS/5T0fM6ayhe/4BImvBac65Q3/
	 ihIAmCXvGamwlcA/8QnUY+rMhTFvOjWhWCqdIgBp7v+K2/IfNZMCYZ/CsZt8DhG7M8
	 MnfW/bRPlmku4SjuqIllzALDAbflZxjXFYrUV2M4U4G0OYHowBIBgR0Z/Sl09eAL7c
	 x3Pr9LQrHIeAA==
Date: Wed, 3 Jun 2026 13:07:04 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Pedro Falcato <pfalcato@suse.de>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, jannh@google.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org, chrisl@kernel.org, 
	kasong@tencent.com, baoquan.he@linux.dev, youngjun.park@lge.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/mincore: handle non-swap entries before !CONFIG_SWAP
 guard
Message-ID: <aiAYt2pNBVAIBaFg@lucifer>
References: <20260602172247.279421-1-usama.arif@linux.dev>
 <ah8XqXQycZdbYFG9@pedro-suse.lan>
 <bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>

On Wed, Jun 03, 2026 at 10:52:24AM +0100, Usama Arif wrote:
>
>
> On 02/06/2026 18:51, Pedro Falcato wrote:
> > On Tue, Jun 02, 2026 at 10:22:47AM -0700, Usama Arif wrote:
> >> mincore_swap() also fields migration/hwpoison entries (and shmem
> >> swapin-error entries), which can exist on !CONFIG_SWAP builds when
> >> CONFIG_MIGRATION or CONFIG_MEMORY_FAILURE is enabled.  The
> >> !IS_ENABLED(CONFIG_SWAP) guard ran before the non-swap-entry early
> >> return, so mincore_pte_range() can spuriously WARN and report these
> >> pages nonresident on !CONFIG_SWAP kernels.
> >>
> >> Move the guard below the non-swap-entry check so only true swap
> >> entries trip the WARN, and migration/hwpoison entries take the
> >> existing "uptodate / non-shmem" path.
> >>
> >> Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
> >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >
> > LGTM, thanks!
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Maybe Cc: stable@kernel.org ?
> >
>
> Ah yes, I have cc-ed stable in the reply to this email, but probably that
> is not enough?

Yeah I think a Cc: in the body is required, but then again Andrew does add Cc's
for Cc'd parties so maybe it'll be automagically sorted out.

Andrew - probably we're good here but just checking to be sure?

>
> Thanks

Thanks, Lorenzo

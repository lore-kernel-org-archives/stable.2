Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174C4FECDA;
	Wed, 16 Sep 2026 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572120; cv=none; b=evYyjpfMdZFfdyAlcBtxUSrN6SaPKRgMd4VtTq4Zm0EzREAVwS9lmEpyiGZmYpeh9TlonlXlueJO+6dIj2FUc5Lf9BdTgPbX2f7il0moxniV0TQ57u4N85AUNmkWbzNNMwTkCdiu8iBatkcX9v72Wpydg4f1G3YT2qZAU5//oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572120; c=relaxed/simple;
	bh=jYSmK5y+SZIRTC3GyQbRTqJn7SlfXievVVdd5VGAyTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsYYW/HE0c9QKi0k+iewjJlMDgaEyDqrBlncPIu6AT+sQftEm33047fs6Yi2EAeHXmi7bmUKt0zn6rbSFLxNfoTMMoog3mwXfMypVv/vzLOpZ3+WAyVz0wH8fLACEc4oDQEFPywB8c5JDj50U5vRGoJfAfB2PKKp5q4bT37egPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YruKXo64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YruKXo64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905981F000FF;
	Wed, 16 Sep 2026 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572115;
	bh=jYSmK5y+SZIRTC3GyQbRTqJn7SlfXievVVdd5VGAyTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YruKXo64eKDZQFGDDd8CEzuHZHfosdcnkd/01HIK6gfZyUV3aIPITuaF3Bx5IQ1JW
	 vdWSmFv0U0ltztQYw0xb5LedymRs9pTaXO/WBKCOFimTiwzisE4Cvqi2menFkbioZV
	 Ghugtu5MJWJa3Iz0euWc0rEJtKXUpFdeVO46PBYUgLVA5tz2oA8xCZX+Ojj1si0l96
	 xmoJEp/7DMlISrSJGF5+fMyGxd3FfWCSCzXFEI3zqAM8AbquN5MS5SRqXA6Jw9cxmB
	 sulhd9yPZfubs9yJQ3LXvn8uo7eskwHnaRXptcxZ440t2mxx5GnramlMLhMoCJ0Gd4
	 U45HzK/LmW+aQ==
Date: Wed, 16 Sep 2026 16:21:49 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, wangjiexun@tinylab.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqzpldNskE2RRo-@gremlin>
References: <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
 <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
 <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>
 <aqquDtEZL1ndymGN@gourry-fedora-PF4VCD3F>
 <46d923e6-5724-4df6-b0d5-8dda7c547f6e@kernel.org>
 <aqqyhkZqcXDUrzeb@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqyhkZqcXDUrzeb@gourry-fedora-PF4VCD3F>

On Wed, Sep 16, 2026 at 11:19:35AM -0400, Gregory Price wrote:
> On Wed, Sep 16, 2026 at 04:59:32PM +0200, David Hildenbrand (Arm) wrote:
> > >>
> > >> I told Brendan exactly that (try stubbing it) and he tried ... and had to give
> > >> up at some point because it just wasn't feasible. ;)
> > >>
> > >
> > > LLM go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
> >
> > No schlop like that please, I don't want to hate my life

Somebody doesn't realise it's all too late for that :P

Picture Pennywise the clown in a storm drain etc.

> >
>
> You missed this part:
>
> "I'm trying to be careful about not causing a bigger maintenance burden"

Yeah that'll be the hard part :))

>
> I wouldn't do that to you :]

Hmmm... wouldn't you? You want to don't you? ;)

>
> ~Gregory

--
Cheers, Lorenzo

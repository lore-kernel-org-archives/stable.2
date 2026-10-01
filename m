Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455D43BDA1;
	Thu,  1 Oct 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841944; cv=none; b=Po4E7ir3COIEziuIrFLIU09SFDegE1WHyMyTSyTQiughILVye9eN1BIx3gm8w7HrzZU/u4UKMdgWa+RCvOJ1X7263sOWq5vVzJUE7fZcnoQUMSJdQ2k+9azAKThmfWjuAIPKIKI5muiGahV13sIpdQyQFJ0fp7ip88bhC4RsI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841944; c=relaxed/simple;
	bh=6i++DhDCJo3alPBNnwrUPtudb0DfC5cHquTsuDEHPg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO/hh1ey2grry3E7faMfF+EX2kTcJ6txh0SbsWRklCoo4HVNCr9j8X7E0qYW/QRW0cL90/KKQ4W4buASsxkE1PT2WuouCqwzC2Sd2SgHyqOfetq5yUyYsO0EVmMHZElk0JsSbOGIqJsKXInSHhxI1Lz/SvbctnF9FWqfrV6dECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9/IDkVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9/IDkVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55FF1F000FF;
	Thu,  1 Oct 2026 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790841943;
	bh=PGdqsABiHifezL69EQkKgockADvH39dMNn1MkutZUlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9/IDkVgxh7FvYe+24kJvQV30H1sGhInXRDF37M7Id1szihp3UUzg2Af7pGxKy8v+
	 HmqWMx+3VUhxt+M8xLrTB40t4tZOecSJ/CaSmxnieoT7VolyewNLt36gBG9IMPiZ8a
	 mkhs1P/pZspYG/O/U4w+wDrWInsNWatn1RcmcGnPWhxZJ5Neq+4v8gP4WaUaOUePha
	 RZFHQOmfYZJbi86cAgWcKB8u+Uu7qiIOnXuQofDqZpqlLxImrb6zRoNfLtellzvYqB
	 zyCvJiiVIP7XGhSDZz38TriJrMytpfoiRvcpBMuBNxKw2ePPxoDwJfGLmodU6eVr41
	 6L6Ni9RdVgNog==
Date: Thu, 1 Oct 2026 09:05:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-ID: <ar4T2vmGD1vZfAaI@gremlin>
References: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
 <20260930152139.e8fc193b9c2880b625fda814@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930152139.e8fc193b9c2880b625fda814@linux-foundation.org>

On Wed, Sep 30, 2026 at 03:21:39PM -0700, Andrew Morton wrote:
> On Wed, 30 Sep 2026 19:47:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> > v2:
> > * Added tags (thanks everybody!)
> > * Updated 2/2 to avoid splitting the VMA if the VMA was not mlock()'d. It
> >   is only meaningful and necessary to perform the split in this case. This
> >   also fixes the proc_maps_race selftests that broke, as reported by
> >   Anirudh.
>
> Here's how v2 altered mm.git's mm-hotfixes-unstable branch.  Quite a
> large change - are you sure that retaining the tags was appropriate?

It's not a large change conceptually.

The dontunmap_complete() delta is just reverting it to what it was before.

The rest of it is literally just checking for VMA_LOCKED_BIT to avoid an
unnecessary split.

So yeah I think fine to retain tags.

--
Cheers, Lorenzo

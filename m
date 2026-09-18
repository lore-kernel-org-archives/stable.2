Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B228DB54;
	Fri, 18 Sep 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748385; cv=none; b=FL18n5p9RlGWYse1V51gfUMV6JXFW89xvheqecflzmnIq1082Rl5028CzMOUcBGtcgEXEyAuySKZoNvA9ydqAh/YNKaAROfCoFWvlfJadwYDMhO4tG6gl6DdZQ5HZWO44k+HNp0iuLSmG7kJcdIO01I9qB/BxH6IRNaNp1y/p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748385; c=relaxed/simple;
	bh=8soQ8P2FPShAhnfJkjF2giHQyyAUbFnFCa2IVU0rjrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViWT6JUUuukhRWA5hQnx4+fawpoRsv/lP1B4XCWf4g/eZus0qmz1VSKpKjiH0X2XwXz9Kvanu8fIW6KA37pbAPO9+qe6tGEUk6IgAlula65jUcDejvGxIDsu0Tem7CupMrjsvpXlk9nNLI0xlkn14VnxoBv6uenfmZMI57ePHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRTLOrJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRTLOrJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BE51F000FF;
	Fri, 18 Sep 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748383;
	bh=iTzKtvsupp1mqkbq3aYx9lBsTuNoskZZ1du0FOb6ZD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRTLOrJl6uBkAckvGJa7Q4j8QM9MnDxTzeT7vFUfu8aroSxv3ViUGjmgkYRofm84f
	 Od7WiIFsiMv0WQgGaDj4J4nOCA9FqMmmrF7aII+f1AZl2O9RW9S+lyNcykBQR61ZJJ
	 /eSXUDKLxADfTT8qU5sko7xeqauJh00+bDDVJgHGwhy/nPra9WXAYryAdNtb3yG+n2
	 q4mqQMsrvOw4n4kvMCkvLX305pUTBpTJd0R8DStQOsS8wHTsEgQdlz+PCV/6htpRup
	 sqiN9itGDS1BIKyURs+74BH3+JcsTnCSlQyIhqUCTqlKi1QjRZA+ebPu2mBTCnfZf9
	 W4//WayV+N/NA==
Date: Fri, 18 Sep 2026 17:19:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, kas@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, osalvador@suse.de, 
	hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched/numa: scan read-only file mappings in
 tiering mode
Message-ID: <aq1inYWiNWtZlyoo@gremlin>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-4-gourry@gourry.net>
 <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
 <aq1Cwh9hNw4wWEUP@gourry-fedora-PF4VCD3F>
 <c445a20c-ae83-4571-ae97-031ce7facc45@kernel.org>
 <aq1FDhy00epXXtgd@gremlin>
 <aq1ZUTgLQfLBxn80@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1ZUTgLQfLBxn80@gourry-fedora-PF4VCD3F>

On Fri, Sep 18, 2026 at 11:48:03AM -0400, Gregory Price wrote:
> On Fri, Sep 18, 2026 at 03:53:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Sep 18, 2026 at 03:59:40PM +0200, David Hildenbrand (Arm) wrote:
> > > On 9/18/26 15:57, Gregory Price wrote:
> > > > On Fri, Sep 18, 2026 at 02:58:36PM +0200, David Hildenbrand (Arm) wrote:
> > > >>> +/*
> > > >>> + * Read-only file-backed mappings are expected to be cache replicated between
> > > >>> + * accessor nodes, so they are not worth sampling for placement.  They can
> > > >>> + * still strand on the slow tier like anything else.
> > > >>> + */
> >
> > This is the most specific description ever for such a general condition :)
> >
> > > >>> +static bool vma_is_ro_file(struct vm_area_struct *vma)
> > > >>> +{
> > > >>> +	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;
> >
> > Firstly you should use the new VMA flags API :)
> >
>
> Please, I beg of you, let us propose clean backportable fixes to handle
> the dumpster fire before we propose setting the entire dump on fire.

Nobody told me it was a hotfix...

>
> I'm not against doing all of this, but this feature is horrendously
> broken and every piece of tiering research that used it since ~6.14
> has just had its data invalidated.

As above...

>
> > But also it seems odd to check VMA_READ_BIT. You can have it cleared but
> > mmap()'ing without PROT_READ but has no material impact on mapping since
> > write implies read for everything afaik (that can have an impact on GUP
> > though).
> >
> > Also note that (well my series changes it hopefully landing for next cycle :)
> > MAP_PRIVATE-/dev/zero which is anon would satisfy this. But anyway :)
> >
> > Anyway in general then I wonder if this shouldn't be vma->vm_file &&
> > !vma_test(vma, VMA_WRITE_BIT), but then it makes me wonder about whether
> > you care if somebody can mprotect() this writable?
> >
> > In which case it'd be vma->vm_file && !vma_test(vma, VMA_MAYWRITE_BIT).
> >
>
> Right, I made no attempt at assessing the correctness the existing vma
> checks - I just moved the existing code to a helper.
>
> I greatly dislike this pattern
>   1) Fix a bug
>   2) While we're here, fix some other subtle hard to explain thing that
>      may or may not change something but certainly is unrelated to the
>      fix and might actually regress something else unexpectedly.
>
> In a single patch.

Well firstly I'm explaining why what you think you are doing isn't
necessarily what you're doing.

Your check as-written includes write-sealed memfd, MAP_PRIVATE file-backed
mappings etc. and you need to figure out if that makes sense or not...

And secondly do not talk about figh... I didn't know it was a hotfix ;)

Anyway, I'd rather you didn't introduce a VMA helper like that here please.

It's not doing what it says it's doing and it might not even be doing what
you think it's doing.

I'd:

	a. figure out whether it matters/you care/etc. about MAP_PRIVATE,
	   write-sealed memfd, etc.

	b. open-code for the hotfix with a comment.

>
> > > >>
> > > >>
> > > >> MAP_PRIVATE can easily map a read-only file with write permissions. So the
> > > >> function name is a bit misleading.
> > > >>
> > > >> This smells like a helper that should go next to other vma helpers and have
> > > >> clear semantics.
> > > >>
> > > >
> > > > No argument here.  Would like to balance improvement vs backportable
> > > > bugfix though.  I broke out the name to try to make it at least a bit
> > > > more readable.
> > >
> > > I understand, but I am not asking about much.
> >
> > It turns out I made it probably too much, or at least too many words :P
> > Sorry.
> >
>
> Can you at least propose a patch on top that adds the cleanup you
> suggest? Much of the VMA stuff is lost on me because I haven't had
> the time to sit down and consume the novel.

What, literally writing the function for you wasn't enough? ;)

I can follow up on it _myself_ if you like + you nag me to (hard to keep
track of things...) good enough? ;)

>
> ~Gregory

--
Cheers, Lorenzo

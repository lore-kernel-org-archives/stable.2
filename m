Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E23AF66E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746488; cv=none; b=REZ9zrb24bLh+2ob0c6w86S5lYYHLwsEB0ymXOa2xNstWrno6DI9npzOIj81nla976QTv+3B8xbczFV7HvdLzcA+sQGb1e1V+tFCxTVUn1fzk/3LE4VIZltQGfgGd9qbV0Q2nVSUMX9QX9NXDUMbp0hOrEXy8O6sXJvs/9yPqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746488; c=relaxed/simple;
	bh=xDLKzxGNaZyML2nW2GM99UOK4heZ9FfxtRHBvWOrxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGwzJhgaiDgyAV0k+Kx6tJMDSIcGynyU8qJ42Wfq+AXzvUdAJdQ/WyH27+YBxab3OnMLoTPZ6vza/P/4+jQPi6c8z5EU6HEORv0MHcYp3rW92SIyGegUlbk5VLnOY46RRkagikWRi6wA5KeHexpzrNqj8XORLdpzWQyP3exceTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NsiDdNOK; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NsiDdNOK"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939ca12ab70so108791485a.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789746486; x=1790351286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IPLmlyFNg1TvrjgHDtlZeDYufzZUYgmgWzNOrLusAF0=;
        b=NsiDdNOK4z98e24NS79GuOAkp+jqr5nv0gtBDqdDXQGCRfdwSMY1NN9YKFVpmqiOhH
         Wui1T/+K5hBgJ96ae+D2lWgbZFMbnKmvlJE4GoVDLdUWJbicYhYCVHXGTNwHfrZSV6Cd
         aUOT8jfAaoDr6E+MmXP21Cx63x69sRSi2wRC4QvNAdjDLOh//n29K8oM2wWLhz1Hc5pd
         3Z4QR7gOsA2NDA9n7m2/K74iUgMg/m6ZaVdH2Shu/SnEc3qR0t6GVwVLm0/9bspts1WV
         UaymaK4UesET9jY76Df3UyoNaLywX0+DitkwuwKoaBxyuCRY9eybWcvLZoBxM+pKeeaB
         Qucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746486; x=1790351286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPLmlyFNg1TvrjgHDtlZeDYufzZUYgmgWzNOrLusAF0=;
        b=ff7wLtEJ454pLzp1okkNpfZaS8qmyDWsLzsgV/o81H/CrVgUxQRfBw9W58MbTEFdlo
         kzDxs+EFxz/hCnz+R5p5tmTZsV1TTB8fIQRUpTDJcbpSP0fsjwNn9fI6Xq4vXaB6Wdjj
         9ny4qD9mqIVgjWQz4hemAbiofqNrJUi4j8VIogiKPc811GA7p9ACqArkQxRu3BV1pNoe
         kjAEbzZuFtG9xc6xblRpz2DINcX3G5RyJnnkTLzJff+DyR6QJTZtTdFnDWqJNI9YBQxe
         RaQJfWv+8fIawSacg/hT8UAXnyFw1gTin40mD9A6M8E72wfLhaPpWD543I7YsTB3rA2r
         5Y7A==
X-Forwarded-Encrypted: i=1; AKwUvBwSv4ca2HIUVBOveQmWa7VygHxx1Dy//J8hRG1df5yL+UNwPTl7tmy2b/LA9rGw54VDJcV6mOI=@vger.kernel.org
X-Gm-Message-State: AFuF++lIswWWOi6pTGcVxU7vnz5dsGIMNJInVUVXwdVnUiJ6vttzu0ZL
	e+DLB6A9nyoRG/ycDMo/S5Pa9hbH83LRlECUDYu37u4x80ZGwj4Y7Fi3j6yw5Varhoo=
X-Gm-Gg: AYBFou0xsvvk0ebVijZ+dC2BKUpw9TNiwb3EFSn/FJBTZ/S8YtQkalAsi9UWclZGBmz
	91vUwtjEbsPP+CFuYD7MBrLx0whY4ji5InIIA6SE8UIg+pByVM0dzrREb13lKf7EfZcrhiS6t5/
	NHrMPBA0SK2rkecj91G42TXU2QfjISlTYY1N01ajlUeGomG6ANSJxmdVVtUHv0GRi1SFlRVCMUD
	EqLjiMSowX/Bl6e52iO0vP2xzeis6kLpwt0eBLCZNVTpARNv89A0mi5CTPAEuaHe4UHuS7WRk75
	vxqC8THZwzoLrZau6KPUcSN9IiVBPfV41EpsJS1auBfk9u/vkCKTvC8UwZJDpVtjY7byAn6Dsqe
	SJ3x26qQZho03tXc3offUILze8Vxly5YUB9ApVYf/7cK0FJkfgwK18BCeSU5qBeijYIT3UwAFpy
	9oBsZrtMRRLzOK+1RLTfNKLsfSDhlc2iqnkZlLeVSNGKlILoFNQDG0LkElBpt79VO0pDH4DfP9c
	TnYdEAqENXEmeUuPyhs6mgUxD2Rd2ZKNFKOIatdEbuMebZpsJxz8n8=
X-Received: by 2002:a05:620a:4710:b0:937:50b6:4a5b with SMTP id af79cd13be357-93bdc70b5b9mr439833785a.23.1789746485649;
        Fri, 18 Sep 2026 08:48:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ead31asm170247285a.25.2026.09.18.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:48:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:48:03 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
Message-ID: <aq1ZUTgLQfLBxn80@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-4-gourry@gourry.net>
 <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
 <aq1Cwh9hNw4wWEUP@gourry-fedora-PF4VCD3F>
 <c445a20c-ae83-4571-ae97-031ce7facc45@kernel.org>
 <aq1FDhy00epXXtgd@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1FDhy00epXXtgd@gremlin>

On Fri, Sep 18, 2026 at 03:53:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Fri, Sep 18, 2026 at 03:59:40PM +0200, David Hildenbrand (Arm) wrote:
> > On 9/18/26 15:57, Gregory Price wrote:
> > > On Fri, Sep 18, 2026 at 02:58:36PM +0200, David Hildenbrand (Arm) wrote:
> > >>> +/*
> > >>> + * Read-only file-backed mappings are expected to be cache replicated between
> > >>> + * accessor nodes, so they are not worth sampling for placement.  They can
> > >>> + * still strand on the slow tier like anything else.
> > >>> + */
> 
> This is the most specific description ever for such a general condition :)
> 
> > >>> +static bool vma_is_ro_file(struct vm_area_struct *vma)
> > >>> +{
> > >>> +	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;
> 
> Firstly you should use the new VMA flags API :)
> 

Please, I beg of you, let us propose clean backportable fixes to handle
the dumpster fire before we propose setting the entire dump on fire.

I'm not against doing all of this, but this feature is horrendously
broken and every piece of tiering research that used it since ~6.14
has just had its data invalidated.

> But also it seems odd to check VMA_READ_BIT. You can have it cleared but
> mmap()'ing without PROT_READ but has no material impact on mapping since
> write implies read for everything afaik (that can have an impact on GUP
> though).
> 
> Also note that (well my series changes it hopefully landing for next cycle :)
> MAP_PRIVATE-/dev/zero which is anon would satisfy this. But anyway :)
> 
> Anyway in general then I wonder if this shouldn't be vma->vm_file &&
> !vma_test(vma, VMA_WRITE_BIT), but then it makes me wonder about whether
> you care if somebody can mprotect() this writable?
> 
> In which case it'd be vma->vm_file && !vma_test(vma, VMA_MAYWRITE_BIT).
> 

Right, I made no attempt at assessing the correctness the existing vma
checks - I just moved the existing code to a helper.

I greatly dislike this pattern
  1) Fix a bug
  2) While we're here, fix some other subtle hard to explain thing that
     may or may not change something but certainly is unrelated to the
     fix and might actually regress something else unexpectedly.

In a single patch.

> > >>
> > >>
> > >> MAP_PRIVATE can easily map a read-only file with write permissions. So the
> > >> function name is a bit misleading.
> > >>
> > >> This smells like a helper that should go next to other vma helpers and have
> > >> clear semantics.
> > >>
> > >
> > > No argument here.  Would like to balance improvement vs backportable
> > > bugfix though.  I broke out the name to try to make it at least a bit
> > > more readable.
> >
> > I understand, but I am not asking about much.
> 
> It turns out I made it probably too much, or at least too many words :P
> Sorry.
> 

Can you at least propose a patch on top that adds the cleanup you
suggest? Much of the VMA stuff is lost on me because I haven't had
the time to sit down and consume the novel.

~Gregory

Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C650EC08
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569764; cv=none; b=gAXVe8DfSCTv95eZJR0j+GpQW5JWk2HTOQpxIq8xZkcPceOpoXS0S9ndDrjozif6upC8XVTsWBd/oL90xV5v9ZbO0je8x5RDEx7C7gEeVGaOi1zyoKGtsQHBZRk3THIxWeRZBQ9GGi7zCB8I0qb8rzIgYv2qTFqv76LzUpqcSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569764; c=relaxed/simple;
	bh=Q9s4sEEri3oRIDOADPZxVwPNRw8PRSNPYg5PLYUT/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/nJ+IjdjcBHm7Ok3vIfOrqNEBKIQEjHRsCuFsQ3R74wchNNaO8TZOsAmzlT6KhzounM8jhIVh4eROhjJnZPdEBZdFnKza1QJYE1tZlLGxAX6PWj139IWp84AKdutwomx/XajDB1ukvDXkqbEnBPwq5swqjtEpsfjKWwTK/R2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YlVtYB1l; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YlVtYB1l"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76bcb1fso9538871cf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789569761; x=1790174561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=APS81j5DoNNcu6pzB1xIdVlOym6nIXIYbB0pf6pRDP4=;
        b=YlVtYB1l+o1U4kuvnm2L9WsWnIGlPER7dV52fip1whNuoJBPhzHbh5eR5qO+2HuXe6
         UOGBH61elqKO5Tf6jSZIPLkQtPiez5xf5RN4UzdHCVHN+MNxyZSFaYmKcbrGQl51MGO3
         NyIv5i0nQo/JYMIaw3E5aOCHRMl7NrWkjeHbPWpz0aTzIFTTctqNLeRh0vfw4RE1vbmZ
         ge9rssmsIwuAZlShtBT6+KqVqvyHDrPPr21WOutLbjaNPx7Zbn4eZxJH3U0roilUPmqD
         7Slspjlqt7V++BDMWCL4BvJqij4GTfR6fB5f9jZV2DJoOnrvaYJ8VimWQt2I+lLSMX/G
         syHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569761; x=1790174561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=APS81j5DoNNcu6pzB1xIdVlOym6nIXIYbB0pf6pRDP4=;
        b=T90IdMa0g2c4Q1QjjSoBwQPyGw4/SGLcKNR5JfQBf+OV/t0Ww6EpMSDpI+vbkyGifS
         9VIfdFhFQFR7LexWHGTM4KSvSczji28cWgjHdpaOQec1Nsn+m/edH3X16a/qqZnwZdmw
         Ihm/1spk6XjqLZ+VgWuRkRhfRLvfs0S7esDogRt/8YIfyJaO4MaUoUCVoT55uUlv2HDp
         4lPAn/PtgvQt6EvKtTGL8VUITsywNib9NtvnpPDZEbOTdkGWvZ3UhDD7Gm+KgWAG7k2j
         F4YbjvhxlVluo3RvE4b+V03QKEIZn1E8L2J8bL6dsKb2DzM6jvEaLAhKh7T4qWWAQeVW
         ZJNQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1lzH8F8wqzc+ac0cv6DTftszEenQR2E5C/ZUnzqUyI/rAPNfAt3qW2aBf2PZ8W5vaBJZ1+Fk=@vger.kernel.org
X-Gm-Message-State: AFuF++lzyy5axGxS2zLm230jJvlH71FDjcq8uQ5lidnkPFHDUOPuF7To
	sBIbhKlPogVsKVOWUmAPz3I734Bjrdvn2JvHOf5kjbb8p5m3B7Le4ayRqpghuPJWgns=
X-Gm-Gg: AYBFou2Pi9iGizYMp9YIrCX8MT9EoQmYwmqfrOUG5H6ViTtkzixTD5SRAT/K+W/2ozF
	2+sKYSZAVMv79Cnc5kl8VR9BkVVGWiR6etEfbwJ9CzOvBqa/4dfeErKgN8f5d3C57iWNBfRiKH8
	8l1jseXwkOaKi7Et0cRq5mOrBZ5Iyzcmzein3OgQ+2+iBrqCKtS690HsOhx8iMPTtl/MLQ+FsSN
	01Q2MKV6+yZFSqi8QKf8K4lhaOTcZLZEKkyknXBWL6TYgBROrAnp6TeiSuNJwe3N17ymBW0v7oC
	Xod03IUmGah8mLq+/4sgo8S3HMnmQPpaf8Ct0qYXTb395C9GK/VNpMJttvARnqyWFyfaYEFh5eU
	2cbpSgPzuSbyX+iorOcwWMkX0tFmfog9AsH48szw5DWkI0aKuW2T0aYleAnQBXZuIk8wum/cvZ7
	9s1NYA50aNfftpzBGONc4nnZEqunEZAgOfHH6D27TRz47UbQQP3QiGbXxVbTzPbLZ5bAibc04Ol
	W1WkdwgbrfJUJWSu/qDxd8cxfaEYgE89bxO2JtwFr9d84WUzSEv1Rk=
X-Received: by 2002:a05:622a:1312:b0:530:b2e2:d7e2 with SMTP id d75a77b69052e-5327f24d070mr45834991cf.61.1789569760741;
        Wed, 16 Sep 2026 07:42:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326208ea78sm25268101cf.24.2026.09.16.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:42:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:42:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqqjW5dpyznijYLh@gremlin>

On Wed, Sep 16, 2026 at 03:12:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> >
> > Going to spend a little more time testing and tweaking before I post it.
> >
> > I've been working on a making more extensive unit tests for certain
> > parts of mm/ and this might be a good time to look at whether I can
> > introduce a piece of it.
> 
> Nice, curious as to how?
> 
> Have you tried the userland VMA tests btw? Not tooting my own horn so to
> speak :P but it's nice, though it comes at a bit of a cost in how the files
> have to be set up...
> 

Yes, in fact I used that as a start for exploring how I might make other
components testable the same way.

"Stubs... stubs everywhere"

There's basically 4 testing mechanisms i explored:

1) selftest
2) Usermode Linux (UML)
3) Userland stuff like VMA
4) Linux Test Project (for syscall and ABI testing)

selftests are really limited and actually create a maintenance burden,
they're not real unit tests and are highly dependent on the actual
machine configuration which is super annoying.

But, lets take the page allocator as an example.

The only piece of the page allocator that "should" (cough, simplifying
here a bit) be machine specific is zone and node configurations... but
I'm not convinced that this should require a full VM to unit-test.

(other caveat: obviously some things like RCU and interrupt contexts are
hard in userland, putting that aside for now).

We should be able to stub out the reclaim calls and at least demonstrate
basic correctness for a combinatrix of commands into the page allocator.

Anyway...

I've been looking at how to use the VMA and UML test infrastructure to
stub out even more of mm/ and generate these kinds of basic contract
tests.  So far I've found bugs in a few random corners, but nothing
critical or reachable as far as i can tell - so that's nice.

Have made it compilable with ASAN and Coverage

The harness itself turns into a decent fuzzer as well for basic stupid
logic conditions, which in turn allows coverage and LLM guided fuzzing
into an easier task for any random kernel dev to start engaging in.

> I always feel like I should do more with it but don't have the time
> atm. May set the LLM on it though...
> 

I will keep quoting myself.

"The thing LLMs do is make the pipe dream of test-driven-development
 actually feasible."

:]

~Gregory

---


some stats from my infrastructure:

  How much of mm/ is testable

  24 of 130 files (excluding DAMON) — 30,108 of 187,486 lines, 16.1%.

  ┌─────────────────────────────────────────────┬───────┬
  │                  Compiled                   │ lines │
  ├─────────────────────────────────────────────┼───────┼
  │ page_alloc.c                                │ 8,050 │
  ├─────────────────────────────────────────────┼───────┼
  │ mempolicy.c                                 │ 3,923 │
  ├─────────────────────────────────────────────┼───────┼
  │ vma.c                                       │ 3,429 │
  ├─────────────────────────────────────────────┼───────┼
  │ memblock.c                                  │ 2,911 │
  ├─────────────────────────────────────────────┼───────┼
  │ util.c                                      │ 1,317 │
  ├─────────────────────────────────────────────┼───────┼
  │ memory-tiers.c                              │ 1,215 │
  ├─────────────────────────────────────────────┼───────┼
  │ cma.c, pagewalk.c, pgtable_move.c, +15 more │ 9,263 │
  └─────────────────────────────────────────────┴───────┴

  ┬─────────────────────────────────────────────────────┬───────┐
  │               Not compiled (largest)                │ lines │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ slub.c                                              │ 9,933 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ vmscan.c                                            │ 8,163 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ memory.c                                            │ 7,603 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ hugetlb.c                                           │ 7,320 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ memcontrol.c                                        │ 6,756 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ shmem.c                                             │ 6,019 │
  ┼─────────────────────────────────────────────────────┼───────┤
  │ vmalloc.c, huge_memory.c, filemap.c, ksm.c, gup.c … │       │
  ┴─────────────────────────────────────────────────────┴───────┘
  The uncompiled chunk all need real folios, which is a problem that
  I haven't tackled yet.

  Coverage of what is compiled

  ┌──────────────────┬───────────────────┐
  │       File       │   Line coverage   │
  ├──────────────────┼───────────────────┤
  │ page_counter.c   │ 100.0% (119/119)  │
  ├──────────────────┼───────────────────┤
  │ numa_memblks.c   │ 99.5% (221/222)   │
  ├──────────────────┼───────────────────┤
  │ execmem.c        │ 94.4% (271/287)   │
  ├──────────────────┼───────────────────┤
  │ page_poison.c    │ 86.5% (32/37)     │
  ├──────────────────┼───────────────────┤
  │ numa_emulation.c │ 82.2% (199/242)   │
  ├──────────────────┼───────────────────┤
  │ page_alloc.c     │ 79.6% (1873/2353) │
  ├──────────────────┼───────────────────┤
  │ mempool.c        │ 67.0% (179/267)   │
  ├──────────────────┼───────────────────┤
  │ page_isolation.c │ 60.8% (118/194)   │
  ├──────────────────┼───────────────────┤
  │ memremap.c       │ 58.5% (137/234)   │
  ├──────────────────┼───────────────────┤
  │ mempolicy.c      │ 54.1% (735/1359)  │
  ├──────────────────┼───────────────────┤
  │ mmzone.c         │ 52.8% (19/36)     │
  ├──────────────────┼───────────────────┤
  │ shrinker.c       │ 51.6% (174/337)   │
  ├──────────────────┼───────────────────┤
  │ cma.c            │ 44.6% (206/462)   │
  └──────────────────┴───────────────────┘

  Aggregate: 4,283 / 6,149 executable lines = 69.7%.

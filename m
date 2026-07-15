Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917F3C1983;
	Wed, 15 Jul 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100539; cv=none; b=D683zEMMKeOPQuV2TvXUHvyYhc4PGLkVhTdwuWcqqZ7/JzXl+mnxZDt8Ndsd+u+AjeCexlo1X8JFLhtsG7SRCjmJsaKZHfC6vkYOaUE4nNL/zntA8JSRrENHHAzvBw/yzw23A+Eoxqfe/ycC9TTV2Xug+6CYYyjFv4TvXg9FHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100539; c=relaxed/simple;
	bh=6X3BfS/vlKMVeP0+vXeVJjquysDomjXRdgpvx3atWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWQIuwQGJRJpP6dhtdJu+20iUACVUs6uIMOdkSaDMsg7PwPG3WCFWiw3GVkMXwIcoWoF+hkkqsCF6yVyy4O800LJKpSbDOHZDqSvvNgM3KRh94KZqqLSvMeV+o50wyCFlLmRkOUt0UIG/bZxsjahw7B7rPIZt9lH7accLd1OvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCWKi30M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCWKi30M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226311F000E9;
	Wed, 15 Jul 2026 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784100536;
	bh=Vk/Pmtw5V1S5Wy95XZKiQxPxVWpzziuE+PvkoAYgcUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCWKi30MM2OO4LbExOFY2K96V4NJnrOuSYk2LaflLMjhkhQxOtZ8oF5qHjCyMhZjy
	 fPI9vhQ68B18TFLQc3JbwI/Bza/bFsu5vcGWnxMof6ezZ2Al6zMpJSuqppPOTYXzYT
	 8+D5XxspV4qS44G7arRn0036MucchjV9d63PSsiJbu1DSE6GwYB0emo7MC2q4heaGB
	 TKK6px3LaBeex8N46xrQYxluBESDOGdkya0vb+VTMG0INmsmp1l+C1gSOSe8CTqgcr
	 pRlVqlQ7TMusHrBvhsj2AwYxV1OOC6mM8wt75yCtk/bubtRjZK+Pe103PlnYk0FR5u
	 LwNn3Od+F1tEg==
Date: Wed, 15 Jul 2026 08:28:39 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v3 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <alc0YTcSVuBMdo8A@lucifer>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <e2d9f516-2dae-4356-830a-14b99fd32a90@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d9f516-2dae-4356-830a-14b99fd32a90@intel.com>

On Tue, Jul 14, 2026 at 10:31:52AM -0700, Dave Hansen wrote:
> On 7/14/26 10:24, Lorenzo Stoakes wrote:
> >  arch/arm64/include/asm/ptdump.h |  2 --
> >  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
> >  arch/arm64/mm/ptdump.c          | 11 ++---------
> >  arch/x86/mm/pat/set_memory.c    | 14 +++++++++++---
> >  include/linux/mmap_lock.h       |  1 +
> >  mm/pagewalk.c                   | 36 ++++++++++++++++++++--------------
> >  mm/ptdump.c                     |  7 +++++++
> >  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
> >  8 files changed, 78 insertions(+), 77 deletions(-)
>
> BTW, this is super nice. It fixes a bug, makes the architectures more
> consistent, and is effectively neutral on lines-of-code.
>
> Very cool.

Thanks very much Dave, that's very kind of you to say :)

Cheers, Lorenzo

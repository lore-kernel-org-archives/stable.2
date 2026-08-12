Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D5476045;
	Wed, 12 Aug 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549390; cv=none; b=kntjF5oNLeMqrNiuRu6TJzRRDQ/fKKVWX765po92hRuFsX7sWEjIX65fCEe0JhTMqGWgmGy4d70udbTariwPVhWtxA3ix0YQ3X2hkZadC8ou3+rmGTm2Rux1GhWoNpWJIU+9Mr905EYIiqKt4y5vU6uhuHJMpJirUj3DeA1ZFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549390; c=relaxed/simple;
	bh=ykHPef6px2LEsz+rF/QyMgTcHhWJelZPGb0hNUYCe6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfs1NnhKXBA8r39/h2kxmdH32hJYJJ+VNOGnUPAHtPhFhzOMs1Z2Ux7JGDdiV6oSNgEVFDk1Vzow0Fq/y7S8uNZngF72JpoMDYuIgA3/Gk5j6C5xTIZIO2jMKr8O9DeU4PSVPrMM7eIXs2eF+08rO0tXBUOk72qJYtWJl/3pGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fufXIEYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fufXIEYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4931F000E9;
	Wed, 12 Aug 2026 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549388;
	bh=SH2IG96p/hOxc9SLkk6aVEywXxuFDmbXLKwtNkWmoN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fufXIEYcOCk7YFdVicoPopDzl8wzocwZ2EjRi2VL5jySYt2sM6bAvIkk2USQiGyv6
	 bFTWZAOZL6b1qLTF0oIgHVtJh9e0XefpYACXv2k3cAAoRAJyKj8xk+x5US3k52E+ic
	 Ht/dHNMv92t9saJSHSqLLjWksucgUSNjan04csD2GLBawVcFh+oAAJuXFVt/sKDPgE
	 JFAtBUCbiVIXTbRbm11cghXms3QnAAR3bEUNGgzdmX2Nd+X493/dXPqiIM0z5hRthE
	 nwDltJFtZKB9f0ermYAXl7IilzdxDjzxlWct+ohIVz0CLq/gdxq4dPqDcF0xCApos8
	 RkRzccYduCbOQ==
Date: Wed, 12 Aug 2026 16:42:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	Steffen Dirkwinkel <lists@steffen.cc>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anyUC6VgwL73aTm4@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
 <anCK3eWFMwZqq5ka@pedro-suse>
 <anXvODEvV4f_Taj7@lucifer>
 <anxbSdxDlyq__-T1@pedro-suse.lan>
 <anyOHfbXJAAmbcdi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anyOHfbXJAAmbcdi@kernel.org>

On Wed, Aug 12, 2026 at 06:15:41PM +0300, Mike Rapoport wrote:
> On Wed, Aug 12, 2026 at 12:46:09PM +0100, Pedro Falcato wrote:
>  Just Hold the mmap lock on callers, but it becomes messy quite quickly)
> >
> > Mike, if you get to queue up my patch then please replace the diff with
> > Lorenzo's (with a Co-developed-by:, I guess, since he went to the trouble
> > of moving quite a few things around). Otherwise, I'll figure out how to
> > re-submit it after your series lands.
>
> I moved some things around as well and here's what I've got:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=cpa-fixes
>
> Build tested only for now.

Had a brief look, all LGTM, send it :>)

>
> > --
> > Pedro
>
> --
> Sincerely yours,
> Mike.

--
Cheers, Lorenzo

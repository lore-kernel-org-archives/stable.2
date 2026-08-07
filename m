Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A3478869;
	Fri,  7 Aug 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114845; cv=none; b=ieN8tahpQqAYxEwUy21ul2pxRQjPsRnOar3A5bCksBKV4vtVQZ1TUkuUzq/tUAydDzEU+Kd7fvvlMfhbaBsG/G7XfjDe0rIZ2AaaNs1cm1YtRmt4K7lmygkIMxv12TBjrHT/qm9buCYExWgjorZHpd80oMW8KLhOr2vL084aLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114845; c=relaxed/simple;
	bh=+h2ntushaSurPWxhUgJp+aSl7bfbjD43fXSlCFyGReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWT7cDQrHqGYUnXoToeYMTJIDoUTPhSCU4NpSJsvOAmAEyjs4/7f5RxRmwqUzVZkxhSs0HEryfARVNtBs+D58/nINTi3vBQ0yvxLd/4XEPcwE7CpndaTN04uV5VBBBnm1i/ZzNnVUKYAwA9KwcWGpSHo2J4gG+0YrczweHugi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs5Q+OB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs5Q+OB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B81F00A3A;
	Fri,  7 Aug 2026 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114844;
	bh=+h2ntushaSurPWxhUgJp+aSl7bfbjD43fXSlCFyGReU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rs5Q+OB0Wx01lvmG7UQ2SWL/oswGIMCb0bGn51z7kxjRXwFCBcpuGPKP2IaSe+L9D
	 qzYpNK01oIbWiVXb5ds9Zqg+ZPVIUhKrjuyD3eWnCLNn5cFzMVxzIEwmiFenJQ/oTN
	 YHVNxIN46KjNUt3awv7QEKwJIrOk+x8Kuq7nLQMFNsp71UVMwIemD3U13IEU52YV0D
	 63K7dZY3cMCV77d61lIF9pvF/dsTXxEvvDZQQ44iYaRUFZ2Sy2I8IN6KQCx1NqD9lE
	 oBfLzt62arVBgZrEjy3qb1fIou5EtMYt/BHlDrYJ3k3/T7gPeHdcQji8x3iXuhU/p5
	 9yB+Z3OouJcUw==
Date: Fri, 7 Aug 2026 16:00:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anXyv6CffFFmpDNn@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <anCwUb9lV18v6mfN@kernel.org>
 <anXp--mLLEE2Qo0g@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXp--mLLEE2Qo0g@lucifer>

On Fri, Aug 07, 2026 at 03:34:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 06:14:25PM +0300, Mike Rapoport wrote:
> > @Dave, @Peter, how do you want to proceed with these?
> >
>
> Hi guys, I know as discussed off-list that you are snowed under but there
> are bug fixes here that are worth looking at.
>
> I must say I'm a little surprised that the series which came out of the
> discussion here has been taken to x86/mm while the actual series hasn't
> but there we are :)
>
> The core mm bits my changes rely on have been taken to Linus's tree if that
> makes life easier?
>
> In any case - Mike - I think you probably need to respin this on tip
> x86/mm anyway?
>
> Maybe worth doing that and seeing if that makes life a little easier for
> the x86 folks.
>
> --
> Cheers, Lorenzo

BTW if there's an issue with it I can ask Andrew to take the 3 of my patches
through the mm tree, they're still sat there as they were originally :)

--
Cheers, Lorenzo

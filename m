Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749D2D060D;
	Mon, 13 Jul 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951711; cv=none; b=PMrFvY8WXqbCaeMl5obH9O0dcLdgPwmduLc0haK/aUMlK0saC88XHaeLAiKqmKLGylOdshQJc5o+pWqeRTNdGXdsCFS4IdbEzQKLV10JJ2PHWLh9A3CyXJyuRq20s4Jwp/WKDS3nmNi1qfnx6Wt7/Ywikn7EwR8skZHpIShqEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951711; c=relaxed/simple;
	bh=5DbuGR9lroVkXyXX85L3Xd4O5tZ7zNx7+G+n6zDvEoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYlzJ988Dxl0oNLhJ5emmEA8tcOBz7Mgd9icT1W5YspSsTTv4RW0S0YWiPO+AcWeGzonEt2c/CwIu981dGJ+dZBO9ZgWhJ3ingcTq7ZItgDrzxuBlUrzMsBmsO3//JEqSYk9E2Xc57Svl/7erVQsbocrFpBTmgJHv5hBBuvAw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEcGRUQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEcGRUQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F931F00A3A;
	Mon, 13 Jul 2026 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951710;
	bh=5D70PgPOpXCYze4+Z72DPv3iGsJRzVh17hn0cbIFj6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEcGRUQmq/j2oZwL8Kf6eWI82YyVPYbNH14/2FzJeoTFePEit3iAhoG4ugytrOWrR
	 ezVl9VkrgoNuCquhjp2caRSyWFKyvEA4Avoby4m52bd/FgGA7ty7D9RJhdpUUyPzTF
	 1X9WJm/iSqoa3qwgcFma1zhTzZJ4XR2pSNCFH/uGOlr4rgClyC4tp/iEiGbxNBIqXj
	 bbbRBKZZ8Cr2oXnnM8Pr6nAKVuv2FQuQ72Mi+/qjRLearyyBnI4huUQdyifm5sNC78
	 i8TBAdjsJQ3WQef2klxC2+c+KcDEgROBsMslT0iy3f5f1+TUc59vzSF7QS+j4XoiFY
	 NFVQrR8/FtVEQ==
Date: Mon, 13 Jul 2026 17:08:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Carlier <devnexen@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alTxUwrkzEx-FEOP@kernel.org>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
 <alNQccqtx5-QApup@lucifer>
 <alTOCtzQh9RMfWbc@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTOCtzQh9RMfWbc@willie-the-truck>

On Mon, Jul 13, 2026 at 12:37:46PM +0100, Will Deacon wrote:
> On Sun, Jul 12, 2026 at 09:46:46AM +0100, Lorenzo Stoakes wrote:
> > On Sun, Jul 12, 2026 at 12:50:08PM +0530, Dev Jain wrote:
> > > Will Deacon had pushed back on a similar approach:
> > > https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/
> > >
> > > Although now when I read back that thread, it feels more so like my
> > > incompetency to convince :) because:
> > 
> > No haha not so, I think more like this stuff is fiddly.
> 
> Yup, not disputing that this is hard to get right.
> 
> Conceptually, adding locking purely to deal with a vanishingly rare,
> debug reader does turn my head but I'm _far_ less concerned about it if
> it's done in the core code, as is the case here. x86 needs it and we're
> recently running into related locking issues with the set_memory_*()
> APIs if we want to collapse the page-table on arm64 [1]. If the overhead
> is flagged as an issue, we can see if it's worth generalising the static
> key trick that the second patch reverts but I definitely wouldn't start
> from that position.

I'd say it's worth generalizing the set_memory APIs ;-)

Since it's de-facto machinery for manipulation of the kernel page tables it
makes sense to have a common code for page table walks with hooks to
architectures for checking/setting/clearing protection bits.

Coincidentally, I'm working on a POC that lifts x86's CPA into mm/ with
the intention to later use it on other architectures.

> Will
> 
> [1] https://lore.kernel.org/linux-arm-kernel/799181c3-a1a1-4de7-bc6a-576d3282efb0@arm.com/

-- 
Sincerely yours,
Mike.

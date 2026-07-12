Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978E1A262A;
	Sun, 12 Jul 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783843303; cv=none; b=Lut7Hp8HvvjJ1Ub6/dLRCWJY54B24na7mA3Xw8C4+gDVqIHXVrkReKqLWsrTbInS0N35gR63ps5wBmuFGt87V+pRmyDVaKrKHzAfARZ6A1a0sze9oeNxa9+ZhBhjKQXqoLA3gYj1c+D+8DI7kD1dwt4Efu3xu06UE6M71RBQsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783843303; c=relaxed/simple;
	bh=dGC8c3v2fKFDMXvfLStgqQIzkVNu1KesDS63qbksjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQJlINVKNn451D2ecyDZ8sN54yM6Hx/NoGICOW3zju8aegaJfgcVuQvqaoWeqHNzvVEMQiFo+IA7XRCKAhuIkPvDm9vT5XfXij705BKhKYGukrW9+Ie5vrMIRoEJ/t4AL7bLmkL7wY935UiR9lvqcanWo2aW68Z9fbiSYI2CNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnCux/Zc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnCux/Zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706E51F000E9;
	Sun, 12 Jul 2026 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783843302;
	bh=JDe2roBwGlbGNLfIylYtCXE90pGvdrMhNrHyux+rp2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SnCux/Zc5Sz6wi+JbQXUqQ08OdE2kieVNBoY0ZP2rJjIyDGi+Mwh+J925gW6WEXAD
	 ObL+XgBuml2lhR9Pro5gioOUQsXo8yR9KccFsZiRYaA6Sc4obLsxN350uxi89mjIYd
	 zrGI85qqVm6Sxw+V38cHDlaKVAvXBULd2Teh72jk=
Date: Sun, 12 Jul 2026 10:01:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <2026071252-sweep-quirk-a068@gregkh>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
 <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>

On Sun, Jul 12, 2026 at 01:13:12PM +0530, Dev Jain wrote:
> 
> 
> [-----]
> 
> > We also define a guard class for mmap_read_trylock() so we can use
> > cleanup.h to make the scope handling cleaner in the implementation.
> > 
> 
> Will this cause backport problems, I think this scoped guard thingy is
> not that old?

Don't worry about stable issues until after the fact.  Fix things
properly in Linus's tree first.

And scoped guard has been backported to many of the LTS branches
already.

thanks,

greg k-h

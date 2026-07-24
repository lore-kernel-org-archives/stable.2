Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83D380FDB;
	Fri, 24 Jul 2026 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872715; cv=none; b=tSYHneERvuSJBFN6Wv4+EELPbUfxLPyHrpdbKeDAyer7aiUz1EnesJJB0kG9b88mtiwEyXJGAEWzO5L07sgBciXzOX1rN7alrf96PbtBccGl2+aGWIwHWl2Wwt1iFpNr3wtPhKNXWMDVI6tJgBzYy6uyHW0xUy4d0O9pkNos6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872715; c=relaxed/simple;
	bh=b6dQC1lAIxjPJsN1ntSyrgB0Hb0SlTfYeI0emI8v+LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfyDy2wDPcGhqoatyWh+moyYHtei/FydWrwh6OXWjp4Ao4sjWclAknfQ/rTGPpzUwhGjYTFqjfzy8C2oUTeWNxmOSYDjxE8PSfSZKelikj5Qt8BYYFo/q7pMBojQJAx62ZSEBR1f0BWcCyQ9Fuxus54uwPsMUAiZQ3wrSNgXjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gjsUKBMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gjsUKBMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499B51F000E9;
	Fri, 24 Jul 2026 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784872713;
	bh=pQm1ddMox3vEUAJvm6IXwOnF8UxrgOIpTNbU2CB4GxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gjsUKBMmXyhpiY95M8Kz5bEMNbqsjbYtAZ2aGfKzJP1iQ5IwpQ0Z5qRYHCub1GNiq
	 VOQDb/2uAVhQWj/EXaFb0DPjeSDQhOdQHjte2b1TtTTC3bfnJyvzQpgYMhT0byHuir
	 oVI6cdnBF4VK7tE5Y0E161TXXdQl+SCqUBfxdIMI=
Date: Fri, 24 Jul 2026 07:58:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sasha Levin <sashal@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-ID: <2026072426-exodus-deck-e14a@gregkh>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
 <20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
 <67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
 <amIgT-l7PExKVJlW@cmpxchg.org>
 <00bb7fd0-998b-49f0-9941-cc4d796a8751@kernel.org>
 <20260723170249.98d83bd68698fff2629391c4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723170249.98d83bd68698fff2629391c4@linux-foundation.org>

On Thu, Jul 23, 2026 at 05:02:49PM -0700, Andrew Morton wrote:
> On Thu, 23 Jul 2026 16:17:51 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
> > > 2/4 actually came after 4/4 during development. Without it, compaction
> > > cannot make sufficient forward progress on the promoted non-movable
> > > requests. So it is a hard functional requirement.
> > 
> > So that's the tricky part then. If it's a hard functional requirement for
> > 4/4 and yet leaving it out results in no conflicts when applying 3/4 and 4/4
> > (as it indeed seems so, based on my local test), then it's quite possible
> > stable folks will figure out themselves they need 3/4 as a stable-dep-off:
> > 4/4 but won't backport 2/4, unless you act quickly enough on their mails.
> > 
> > > Whether it deserves an independent Fixes: depends on how many
> > > GFP_KERNEL pageblock_order requests we have :-) I'm guessing not many.
> > 
> > I don't know how else to indicate it though. It's kind of a co-fix with 4/4?
> > 
> > >> > (An alternative would be to put cc:stable on all four patches.  That's
> > >> > a bit abusive but we do it rarely).
> > >> 
> > >> I don't think it's necessary, the stable team are quite capable of figuring
> > >> out the deps and backporting them with a Stable-dep-off: tag. IIRC the
> > >> "fake" tagging is discouraged? Maybe they can clarify.
> > > 
> > > Yes, I *think* it should work with tagging just 4/4.
> > > 
> > > It won't apply cleanly or build without 3/4. So I'd assume if that
> > > dependency is lost, the automated backport will bounce and I can send
> > > a backport series by hand.
> > 
> > The way I see if often happen is that Greg sends a mail that it bounced and
> > soon after Sasha replies with fixed up version/series. Which could very
> > easily be 3/4 + 4/4 without 2/4.
> 
> My brain hurts.  I'll include
> 
> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> Cc: <stable@vger.kernel.org>
> 
> in all four patches.

Thank you!  Don't make us "figure it out" as that way lies struggles and
time delays and the huge chance I get it wrong.  Tagging them all
ensures none of this happens and it all "just works".

thanks,

greg k-h

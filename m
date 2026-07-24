Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AD1DA57;
	Fri, 24 Jul 2026 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851372; cv=none; b=S2YDg2O7Julc4EZ9qnuEIOaLxbT5QGRcixFKgqZHb02Ais7QbcZ8FpUwa7afcWBPFOksUz9ZWg/d873JRuOoYu2rhJCTx8qLodixNThYOmOuyXwGIb5jrCcGrc2WSNmx1k/ofWSvnj7RzJ3aB4kXwJaS5TyjmAuKgJvEAHdosvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851372; c=relaxed/simple;
	bh=+jeKp8UReakMpv5M7ur1K2WG96E+Z+HftIGiPY2KAJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fWgw76IrCBufoQ3/k2YSXLyv0UihEaSOc8ChZBMJNDL/UDFUHJKSNiKIbFNy43NjYz6VKaRUNCTARljZdKB9TEiEIhfFnU6BGPYcNoaL+zuKyFReUXedaDaM1G389NjQouPoGDnMi+9FU0Nmg8ZVd+FeJEw8NGua+D02IZe7h84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LBcwVAU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LBcwVAU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1A1F000E9;
	Fri, 24 Jul 2026 00:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784851370;
	bh=c9E04AFsCJ/VZ9edKXAtGVUUjcTIxBBUMYLvzGUzl5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LBcwVAU0Maz8s9W9L1HgHkU9+APYMXK0mWzYaa/ZRGIlgln0kLS27D8ggbEblmF0J
	 0QQWnHVI50v4BzgZvGwtfJYCc5Uucl1Dvq2uYu1l7uZZHkYOGJ0psgix6YPjCd+FQR
	 zOxtuggw3kInBwUd7ZsZ5A6Eo9N68yK2Xhp92CqQ=
Date: Thu, 23 Jul 2026 17:02:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-Id: <20260723170249.98d83bd68698fff2629391c4@linux-foundation.org>
In-Reply-To: <00bb7fd0-998b-49f0-9941-cc4d796a8751@kernel.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
	<20260722150006.3848560-5-hannes@cmpxchg.org>
	<20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
	<67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
	<amIgT-l7PExKVJlW@cmpxchg.org>
	<00bb7fd0-998b-49f0-9941-cc4d796a8751@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:17:51 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> > 2/4 actually came after 4/4 during development. Without it, compaction
> > cannot make sufficient forward progress on the promoted non-movable
> > requests. So it is a hard functional requirement.
> 
> So that's the tricky part then. If it's a hard functional requirement for
> 4/4 and yet leaving it out results in no conflicts when applying 3/4 and 4/4
> (as it indeed seems so, based on my local test), then it's quite possible
> stable folks will figure out themselves they need 3/4 as a stable-dep-off:
> 4/4 but won't backport 2/4, unless you act quickly enough on their mails.
> 
> > Whether it deserves an independent Fixes: depends on how many
> > GFP_KERNEL pageblock_order requests we have :-) I'm guessing not many.
> 
> I don't know how else to indicate it though. It's kind of a co-fix with 4/4?
> 
> >> > (An alternative would be to put cc:stable on all four patches.  That's
> >> > a bit abusive but we do it rarely).
> >> 
> >> I don't think it's necessary, the stable team are quite capable of figuring
> >> out the deps and backporting them with a Stable-dep-off: tag. IIRC the
> >> "fake" tagging is discouraged? Maybe they can clarify.
> > 
> > Yes, I *think* it should work with tagging just 4/4.
> > 
> > It won't apply cleanly or build without 3/4. So I'd assume if that
> > dependency is lost, the automated backport will bounce and I can send
> > a backport series by hand.
> 
> The way I see if often happen is that Greg sends a mail that it bounced and
> soon after Sasha replies with fixed up version/series. Which could very
> easily be 3/4 + 4/4 without 2/4.

My brain hurts.  I'll include

Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
Cc: <stable@vger.kernel.org>

in all four patches.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AF3E5A19;
	Wed,  7 Oct 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397934; cv=none; b=WV/jKFVsAJphxKxhZe9p7mhno5MSb73eCF9WlvrSIv1YJtDGtLHidmVuMGLkNnYf++Uk2WISsvki5qkyLK6Rty7SJ/EO6hNL3Krq4Lh4BB5GBj5Hr8HubSeC7uIInUdgc3Oc67iRIJi5cbidpxX/iE8D1KHhah38vNtN0mRRNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397934; c=relaxed/simple;
	bh=dPF65IjOkF1mR6HuOW7Z6I1A4650VxFYktCYyggh7RY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IeUJfxIwuisHN0i2qZzwvdRWE++3FIuQ1LJoCIUZ+/USTnn54Ds7Eumqn6oISL5RR+JF+Wj2gvOgR6k6/TkfwQpcR+lj87xgrRLJe9njZM3xrcynWLRttHM+c4Bzj3ZnzP4TqS/9hd/P/Ylk3Td02ENS5z74eL2fpGOq+9ccLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0OS5oqUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0OS5oqUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1841F000FF;
	Wed,  7 Oct 2026 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791397933;
	bh=wXKdwWcLRR3vqhF5m8FLcwJNO6f5rIMeMs9Q/KXzZf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=0OS5oqULRyWgpbfqTjnQ3A6FT/xShl+lOJRGnqnpayMFTGZE2Q1gpaPQrq67yZMSD
	 h2BPLZh0nae2J0BGQ8zjMgPRwmWThPrhTHqAcGCM+aZbxYDTKECvQxUwk7/PgXMxxq
	 FUIpn1VMNp5ow95ENmcKXxp12WAJRyWodq3en9pM=
Date: Wed, 7 Oct 2026 11:32:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Harry Yoo
 <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan
 <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20261007113212.1fa804db80cc6f534ca01a59@linux-foundation.org>
In-Reply-To: <asZCEttmL6VlMXKc@thinkstation>
References: <20261006091815.897133-1-kirill@shutemov.name>
	<20261006164122.ea9a673b336b8ac74725c35c@linux-foundation.org>
	<asZCEttmL6VlMXKc@thinkstation>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 14:01:33 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> > > v2:
> > >  - keep the compaction priority floor and the COMPACT_SUCCESS retry
> > >    limit on the request order, so non-costly requests still escalate to
> > >    SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
> > >  - compute the promoted order once in __alloc_pages_slowpath() and pass
> > >    it to direct reclaim, direct compaction and the retry helpers, instead
> > >    of each of them deriving it (Harry Yoo)
> > 
> > Thanks.  That's a fairly large update.  v2 diff is below.
> > 
> > Are we sure about cc:stable?  Or even 7.3-rcX?  It's a pretty big
> > change.
> 
> I think defrag_mode is not widely used. Maybe only in Meta.
> 
> What about keeping cc:stable, but only submit it to Linus for v7.4-rc1?
> 
> By the time we would have the patch battle-tested in the fleet.

OK, let's do that.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296836E467;
	Wed, 30 Sep 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798582; cv=none; b=R1Xqm2dISyawyvYafljHlODkGnJUdKkM92W4YgUf0x1oip1bymgGlQeINoHxauuERcblpW4sWY8xoRuUUgHIwiOU0gY1E8VoM5abmr3s3oof/gaQpyy4quwGs0tEyhvq9HUAfUjo2YDGoBK/I7wXUaAwr0JWzkbtjczNGKOIwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798582; c=relaxed/simple;
	bh=wdmewPuK0kw+vIRfKmx97qxuPpuP2nxQdBydnafiVTU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BtQfY+ZDHj6hmr7T7zQqXA9lRgyjiZspblhbiqOsqbjwp5UOhwq//Rl0KDx2aMxaF08H5+P51TYnkev3bq0wOi6CW4XAcu8lvVcfLgmypasd3VZkRFVn6bEPclACjixfly5+AADpWK4kqHJFoRCgRWGmsudL4+4yXbfJVls3cIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ExlvIxdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ExlvIxdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1381F000FF;
	Wed, 30 Sep 2026 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790798580;
	bh=u08t18FaZZ/JoItkaTytwkoDNv5W489UK9Ej3SaW7sM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ExlvIxdbN8JjqNmq7VsmSrsVUc6pxFiLPpW5EV0yT5cQhwrumhMEM2DrYiSKwxFRB
	 V0Ji2JQN3kuDi4RDUu8ZXgrmY/sbD74AO6RjhEG3qSGzjUDpJ5VTWQMmcxmI6c07ZZ
	 uQFr429+DI/V4CQzuFxFOwzlTC6jfTnwaB51VOlE=
Date: Wed, 30 Sep 2026 13:02:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Usama Arif <usama.arif@linux.dev>, Harry Yoo
 <harry@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20260930130259.8d7d967f4a38afa34e051145@linux-foundation.org>
In-Reply-To: <ar0AiPWwfcZtksPu@thinkstation>
References: <20260929174553.175333-1-kirill@shutemov.name>
	<20260929125816.5a846a62943eeaf63725b525@linux-foundation.org>
	<ar0AiPWwfcZtksPu@thinkstation>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:35:01 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> On Tue, Sep 29, 2026 at 12:58:16PM -0700, Andrew Morton wrote:
> > On Tue, 29 Sep 2026 18:45:51 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > > 
> > > Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> > > storm in defrag_mode"), direct reclaim and compaction for non-movable
> > > requests under defrag_mode run at pageblock_order, to produce the whole
> > > blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> > > still use the request order. An order-0 request can therefore retry
> > > indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> > 
> > 7e8756d7ad22 is new in 7.3-rcX, so no cc:stable needed.
> 
> The commit itself has cc:stable. And it is in 6.18.50 and 7.2.4.
> The fix needs to follow it there.

doh.

> We are running 7.1 with 7e8756d7ad22 backported. We found defrag mode
> crucial if we want to use large folios in page cache.
> 
> But nobody besides us seems to test it :/
> 
> Can we make it default pretty please? :P

Send a patch ;)

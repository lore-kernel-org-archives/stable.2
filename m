Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F63793A5;
	Tue, 13 Oct 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858516; cv=none; b=ArzxPu4MxkFUQHZsz50dJoQe0S+VbxT6vEKmBoqC1lKTojcyiRiOlAmUywmKUWJajz5xxYCoOJz3d5EWerm7xL+3cUAsfE4ko5msZ/mJpBslwF4/a6HZP2gTFggFr7j6IMf3986G13iv9WSvlEh2c8xQRmJkdNwPoWBb4zHh3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858516; c=relaxed/simple;
	bh=rwKVQ6y4LbgKk3QBLlGci2dXE5ZnYmIy+GJ/6wAxFNg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zv34npK3JBBbKmcvj2fVtcHf9ZETsgG/LAglSfpQ4kfYVtKrd8y3/GClbu6xpVz284Y4HT71fazvMFdleQJngOrC+10wpz8gXEWzZS8QScLYql0dvdA20t7HNtvx4IxULIIWGcYhglhuCHbBF8l3nlOmiXtbOCMBOd+Mn7Pk0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vpmcDywG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vpmcDywG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11621F000FF;
	Tue, 13 Oct 2026 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791858515;
	bh=jKylga81/fMMmRtBFAQ1W3QCN8phgvUppb+ffP3/CaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=vpmcDywGR/O5t9GrEkNC7RsvhGFadRRn0/HR5Y4LXy2Oli02WCbqfwLqIHjmDRqLN
	 ozTD6JRQymveRi7jcSxPFOT/Lv1n2pVbfJ1bgCai5zrluhRhkjnVzyK2ux61pxrbUS
	 eNMy3agw/9ZuOjgougzj4G1533G7Ky7wTZit7HI0=
Date: Mon, 12 Oct 2026 19:28:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Harry Yoo
 <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
In-Reply-To: <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
References: <20261009125503.126202-1-kas@kernel.org>
	<15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 13:40:36 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> > In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> > 
> >                                         before    after
> >     should_reclaim_retry() calls           63M     293k
> >     peak memory pressure (PSI some avg10)  99%      12%
> > 
> > File creation runs 5.7x faster.
> > 
> > Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> 
> LGTM, but I think we could simplify and get rid of all the function
> parameter additions by adding a field to alloc_context instead? We could
> call it e.g. reclaim_compact_order.
> 
> The function nofrag_promote_order() probably doesn't need to exist, given it
> has just one caller, could be just open coded.
> 
> What could be useful instead is wrapper for comparing order vs
> ac->reclaim_compact_order. E.g. something like bool
> order_nofrag_promoted(order, ac) ?

I'm concerned about the sheer size of this patch.  It fixes significant
issues, but it's not going to be a simple or safe backport.

So for now please let's optimize for simplicity and backportability and
defer cleanups for the -rc cycle.

Of course, if the changes you suggest achieve that then go for it.

Perhaps we should defer this change into next -rc?  It has cc:stable so
it'll eventually end up where we want it.

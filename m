Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCF3876A1;
	Mon, 27 Jul 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181245; cv=none; b=iaidtg/YOPFUHEu9AKV1dxtuRj3SQbNlLHtIkBb83mQm+ENdn1nUu9zxn3lfzQ5/ZhzhVx5WRR97+rQF1vGcw2GUlDKxLEKYmfHsWb5ShVNB5gqnl4TuM0Jca/ZhfOeYdMn5AC2NuUq4SzA9/VQsn1GLiFKIcUyLXe+jYSiNzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181245; c=relaxed/simple;
	bh=jDCTDDIYcnoTn7FU5D81QyHJpbSQs+nkENtVu76zIQo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MGgEY+b3Erixs+Uey9zly0EKgLlb8sBTGZJL/5tjgAwwtm7NQ8/RhQvHye7MLGerDKvz7/GSWscX1HDJmMgLvaf5bhwUWZqW6T+8cJ7GgG2nDc51Ww81necWMJnCOcfdVvktP256ceDUE1igNbAh6LG91QltvoVmIJRRVBGlcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o/mc0v5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o/mc0v5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E691F000E9;
	Mon, 27 Jul 2026 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785181244;
	bh=Nt6DEP0tju5SaHyQIaUeD0xCAwRQILx3XKs/g5W3uW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o/mc0v5DzjKdaELjinsIVbJ1Sw/1+L2RHD7lgy9f5kHNZvXfw2+z8cNiUJIEVoSit
	 xCeZqJeU/wWmytDmCtU9FN6Du3D4p7kEK14qh+Yy35jWMf2yptyrwhtKDWFgVC1BFp
	 qbFzvg7WaWACDjTud98doO1WpWjv+/f2fmXkpFn0=
Date: Mon, 27 Jul 2026 12:40:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
 Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org, Naoya Horiguchi
 <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v5 01/12] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-Id: <20260727124043.f7751d0259e78f15db94d4ba@linux-foundation.org>
In-Reply-To: <amduqWdnxeYwToax@casper.infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
	<20260725160042.1557264-2-willy@infradead.org>
	<amduqWdnxeYwToax@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 15:43:53 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> > If the THP later reaches a state with a single transient reference
> > and no mappings, unpoison_memory() acquires a reference (ghp = 1),
> > calls folio_put(folio) once, and then TestClearPageHWPoison(p) clears
> > the flag and returns true. This triggers the second folio_put(folio),
> > dropping a non-existent poison pin.
> 
> I don't know, and I'm losing patience with the Sashiko rabbit holes.
> This is all getting very far afield from the problem I actually want
> to fix.

That's fair enough - you aren't a memory-failure maintainer.  If you
want to take a shot at the pre-existing things then great, but
otherwise then let's ensure that the relevant maintainers were cc'ed
and move on.

One relatively minor issue here is that if Sashiko's pre-exiting thing
is serious, we may decide to fix it with a cc:stable and such a fix
should be staged ahead of your series for backportability reasons.  If
we end up upstreaming these things in the "wrong" order then the
backportable-fix developers will be asked to prepare a backportable
version of their patch, which is a bit cumbersome, but not the end of the
world.


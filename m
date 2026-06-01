Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5133358C4;
	Mon,  1 Jun 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346669; cv=none; b=JYSl6Q3f0xWrZlCXPl0rq6+ruj0NMpBocY5WeHZoweKSxAOHJ+zFm3h/aXYooZ2Tr6zGSjyeCt+elR9ug9eS67fGxwpOp73CZVSgsjA2zSIRJ/psWj/2DblBJ1xIWDdLNSSTCdhiIxF5cpiR05I/8rsrbnVxfN3LxADqYYAN1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346669; c=relaxed/simple;
	bh=rUZOBdM9EjHb9Ij1KI0G6nXjC8r3Of2qZtSZyBmeWxU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a/i8/H7GHvjdOAuBX5ea1lA0T+anBff2sBQyRF+9P88OvcIIOkHjirze09nbNa3kL63/8/ip/2qVr5tyy1wuNbdy4bcDZeXAaYQmnbWF4MMCLK0TVp/8hOMMHtn1H9VaOZoFaEffhXYym73L3o+IqI4W9zOlSDDh81TON4aObkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hrrMw5Xx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hrrMw5Xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6858A1F00893;
	Mon,  1 Jun 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780346668;
	bh=x1Ita4ALRIwbUma+e/SouNp6V9HdLIRsvnqj4QVKvVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hrrMw5Xx9njrDfRhxz8cA2HudadDAyZ/Tq/XTLaaWnSpxkbH7q96Xak4yU+QSv52M
	 QAPXFegY6c4cYCJjYPzFdkmx1oksfr/gs4pKXzc6kLSZdy54qt58pLrhha3ANm+XnO
	 Lc/OdZmlpzwyZ//IdLHBeaiJf88jBAyJH073AIi8=
Date: Mon, 1 Jun 2026 13:44:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/compaction: guard move_freelist_head() against
 invalid freepage
Message-Id: <20260601134427.dda82558dfb2da579d66cbb0@linux-foundation.org>
In-Reply-To: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
References: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 17:39:42 +0400 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> In fast_isolate_freepages(), freepage is declared uninitialized and
> is only assigned a valid page pointer if list_for_each_entry_reverse
> exits via break. If the loop runs to completion (all pages in the
> freelist have pfn < min_pfn), freepage holds the list head sentinel
> and high_pfn remains zero, so the high_pfn fallback does not update
> it either.
> 
> The subsequent unconditional call to move_freelist_head(freelist,
> freepage) then passes the sentinel as a page pointer, which is
> invalid.
> 
> Guard move_freelist_head() inside the existing 'if (page)' block
> where freepage is guaranteed to refer to a real page.

Seems correct from my reading.  That code is rather twisty.

> This issue was identified via Coccinelle (use_after_iter.cocci).

But AI review is worried:
	https://sashiko.dev/#/patchset/20260601133941.111989-2-giorgitchankvetadze1997@gmail.com



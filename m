Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782488;
	b=ydM2Zzf7ks4gXQdXL7bpnbyRJ/ZrYa+whOR1TdIyG4QHjRL2UDNRblBko/oF1Tt1jBA7
	 0NDLlPW2s29MDvSj1WvndkWZnfUvw4r4g/X3KrENoHp3yPZgLys6ixlh3+nnUsZOOPOvK
	 PqCydA1Prn8Mpyb48v3eLbsC+uY7NtLC+FeW1rY3nESROWdaC3eemhPLUfbaxwZ42iH9X
	 FmCv0aFg66KDJoMXnCqlcm1AndbaIxKdMn3Pfp/lUbdQc+HDnum9p1nh4Zve1AdsDEMMZ
	 NphR84eTz8YdQjMcrnyhMZ2yqF9i57Gt/9vfKEuYw3h04qWJZ+0pihqDxNMYSQSFMUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xEFifYg6a2nyazL1s6Ddx4/FoL09hcLUL0ZmGYbCVdA=;
	b=5SyCv0+1OFtth3y84yTO3fQjUk78rYFn4O2QpQqDNR8HN9ukvOWfX3EzICk0lF4lr2a5
	 fL/meMzySsQsa1aJ2tZFmwFutMtNhgUJVb6KGUYMrRw901sPGPdNvx/VG+Dh5CjlfamGA
	 ASDQ3bpcSJxkjju2ajZjZSiIqtwPIdcyf82qE/6lJzsSOHlnMple664F334o5DOWn3oEc
	 RxsHh1RD3HvsOfTD1wKFhOgw+A9tbhbwGQZEe3JxU5Aie8YRAFxYv0OzQ34xER6D3kOxE
	 ikir+y/dbSISrr3r19O4uRe7qVQtxrRq0mwAI/tlE9FhiksReWLT05lyPllEwJ7eMxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LFWo5UYY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B8606A31A;
	Fri, 23 Oct 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LFWo5UYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1BE1F01825;
	Fri, 23 Oct 2026 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792782487;
	bh=xEFifYg6a2nyazL1s6Ddx4/FoL09hcLUL0ZmGYbCVdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LFWo5UYYqiHQP2M2zIVZiVaDSk+/76WOvHUHdxOY5iWBZodd/7ZHjuYU4oxRcu2tg
	 +XERiVgDZ1DsvXExmg2SObPrKD+RFWxgDevxlYSSuJTwTCNsUyUuQJT07mbpCuwoEC
	 bseBWIN4Qfv4KnkRVVkKwTzjGd7ia7rso8iD37SM=
Date: Fri, 23 Oct 2026 12:08:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, SJ Park
 <sj@kernel.org>, Kees Cook <kees@kernel.org>, Colin Cross
 <ccross@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: avoid losing atomic VMA flags
Message-Id: <20261023120806.9ae793140c252b4a4cfb3894@linux-foundation.org>
In-Reply-To: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 14:47:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Since commit 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove
> under VMA lock"), VMA_MAYBE_GUARD_BIT can be set atomically under the VMA
> read lock.
> 
> However, a number of places wrongly assume the flags are stable under the
> read lock, which can cause stale atomic VMA flags to overwrite existing
> valid ones.
> 
> Additionally, one case in which VMA_SOFTDIRTY_BIT was overwritten is also
> addressed.
> 
> This series addresses each of these, while keeping the logic inline with
> existing conventions.

Added to mm-unstable thanks.

> Each patch in this series is a hotfix.

The fixes continue to pour in.  Right now I'm adding everything to the
tail of mm-unstable while patiently for Linus to merge our stuff.

Once that happens I'll assemble the second-week merge-window material
into mm-stable and I'll spill the recently-arriving cc:stable material
into mm-hotfixes.

I don't think it matters whether cc:stable material is upstreamed in
7.4-rc1 or in 7.4-rc3 - rather than rushing it in I'd prefer to give it
a week or two baking time.


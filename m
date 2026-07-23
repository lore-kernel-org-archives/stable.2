Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D652F8BEE;
	Thu, 23 Jul 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825932; cv=none; b=FKO74KoEdNn751zV+A0c8CkNOyO9He4WG+DvO54IBk1kFc1sqEiskTkz2m9BBMwWm4tDETdTMKXfNIlwsj4n2LupFjk2noH4KvAPktWHHBZt2TO8QLUIOeusZtPPipN329oP5qS6oIxOm4olO6R/NV1bcjMky/moy80n6Nyin1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825932; c=relaxed/simple;
	bh=0rosnFueFk5L+rbQoTyhq77sYbaq4m804yU4PWOXAks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfwVtD0+Sq0HOBPQBRMd8QfM9T6KwkL6/wWgmrMxvAyaQkoumrbB93046jHRNIH6NCUpK1V5F4uhTmyeurLXunGgfXAZmzhlTLFlpzfTfUczFt/3SFaqsjbpgqYF/QiIWjcJ+Om+MvIs1MfIrVzN1Srg7nxCSvQd1I4ai2FXtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD0A1F000E9;
	Thu, 23 Jul 2026 16:58:46 +0000 (UTC)
Date: Thu, 23 Jul 2026 17:58:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nirmoy Das <nirmoyd@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC PATCH] mm: use precise current RSS for high-water accounting
Message-ID: <amJHS7EV4UJMqFVT@lucifer>
References: <20260723134158.1473841-1-nirmoyd@nvidia.com>
 <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>

On Thu, Jul 23, 2026 at 09:47:13AM -0400, Mathieu Desnoyers wrote:
> Did you compare this with my hierarchical percpu counters series ?
>
> https://lore.kernel.org/lkml/20260707131544.75906-1-mathieu.desnoyers@efficios.com/
>
> I've sent it to Andrew two weeks ago but have not heard back from him

It'll need sign off from relevant maintainers, I suspect this is simply a
product of your series being complicated and the incredibly overwhelming
amount of review load at the moment :)

Do ping on the thread though if it's not been responded to within a week or
two, we're usually (much) better than that in mm!

(I'm not sure I personally have the bandwidth to review, but thought I'd
chime in to maybe help you bump it a bit :)

Cheers, Lorenzo

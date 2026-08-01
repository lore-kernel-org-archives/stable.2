Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B7340406;
	Sat,  1 Aug 2026 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785612043; cv=none; b=JyvdTQq+GdXbnjDPI6I0imK79b3r94bXS5XbzM1O4tO81D0IRDZSyqcFXDckV/Zbb00OZI9olA0lDckglaNx8CbFz+Ff9xxfJy/0PiV/QLRnX00tXXIwzGiRUHz+sOuag7elSxif535qohxdUUXGTdT3iaseiKRego81SuiXdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785612043; c=relaxed/simple;
	bh=m9PIkBTIP3MxhXQjaomX+/nAPl9QwpyiXSjyPZ36e38=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jDV9LQ82z5fgVcrHdoe3m9rmcfdt5kDsVLCCOwxS/vTqNscsKBeh/CyPNDgvnT/JZbfc9cNO7hIV91LTjcZJ46jgZJhoagTHNzAtkXzhpwSAWSJIcnmWqEuEyAJT1jdnDeaZ3Ja44JdplC7WD2g87NPJ0TZFpH/ISIQsL4Yrivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EgIGL3Fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EgIGL3Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9F1F00AC4;
	Sat,  1 Aug 2026 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785612041;
	bh=7eOeE4EBbEtBW4lA82aotTkFyalIM0ORScy2U0jVdEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EgIGL3FbRxeU5XW2xULyYeljHqCqhy6r6Wkwtxz0U6rEWEYJNOBAW4QS1+i9XzI4r
	 gVnFCttP3qStKohiNNiAuxXCWR+8cOBlZRFOBZqhSMh7qT3a8E0kqkHU8vd6r468US
	 ARj7HeSZzPe34bjt3YF01R/085aCSLysmxJE18Q8=
Date: Sat, 1 Aug 2026 12:20:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, Ackerley Tng
 <ackerleytng@google.com>, Frank van der Linden <fvdl@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
Message-Id: <20260801122040.7230a8eb0dc846ce357fba67@linux-foundation.org>
In-Reply-To: <f616e9fc-339d-4430-43ea-0ec8810c5f3b@google.com>
References: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
	<f616e9fc-339d-4430-43ea-0ec8810c5f3b@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 11:49:39 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> > Found by code inspection. If someone has a testcase that can easily
> > trigger this and result in migration problems, please test! But this
> > change seems to be "obvious the right thing to do".
> 
> Sorry, I don't (as perhaps is too obvious). And I'm a wee bit afraid
> that some of the problems which those changes happened to succeed in
> fixing, might now reappear once the drains are finely targeted.
> 
> Am I arguing for a delay before advancing to stable?  Perhaps, but
> I think not: it's probably best to get that working as intended,
> then deal with any fallout if it arises: just be on guard.

This patch is in mm-new, so it's still some months away from -stable
eligibility.


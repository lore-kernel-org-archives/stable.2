Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3491DF748;
	Fri,  3 Jul 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084846; cv=none; b=AK+fOTEFXpcJXu4Nk/KXeQTyAv9+ffGEma8KoV8ISnF5xD9isND3pgQysCQUQYHhwIm6KPTlucAVoABM+r6rVtPYkx+RyA07Cvag69MGAqVwvJeK8wUW1hF/dhmddDF/qYnxgvkQiUiv7YXTjinUdIRqlpNdOves1GG6UXqDHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084846; c=relaxed/simple;
	bh=o9HA0u01949GrWaok4cjwcYYdph9iVfnUpfsprV4hk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl+1hwmiQE4/wR8psyO+D8JmyB/Q43bpBtyhhzrdb1/oIhF145WI3XqcYXDnLU2E5LY0nQDvLmaTNe1qrU5nb8Dy5VSUsOBw3KvOsW/T2jnq97dzgUqZK0ORQZ5kZXCOr/klYFPNGTZkEG0wIXD9ouHOA+eeA69fIQ9b5yOQCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COLcWCYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COLcWCYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC53E1F000E9;
	Fri,  3 Jul 2026 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084845;
	bh=DMtNEtbh86PE/0OtSHafNiiMNiX2mMRVhXm4LGea/eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=COLcWCYBFT9dd93pF5q2QEyFgZQkzG1MIG1pbKLA7Iqufd1ueWiJhww7kRKP1/Us1
	 7jZQ3FGx35azOG0U/OqArHOXVUnQo3ZbamsNIryLfGzHDK/A4RNwcjMtuiY/y3XyhM
	 PJwSPxZxHNLbOAmD59sbkzC9BCcuiN3o0tGsX//fnW50q4TueRw/LsGJ4a5mrT0pmD
	 aeUEpglPCCvC0AQLzRWBn66GHeWX98d5Wmw36HEdFxXRmKemLZA2/9Jdiw1lUnFYMR
	 B+45sMK7yABG6VQh4p6AHeUHilH+1lpYA3VdApKKwBTyN90fxFYkkeUWLmE04v6qAs
	 V9jXfSdWfX0tg==
Date: Fri, 3 Jul 2026 16:20:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <ake3JZJPYHP-0N7n@kernel.org>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org>
 <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
 <ajO4sLq2UBciSgOn@kernel.org>
 <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
 <ajO7yI541hphWRb8@kernel.org>
 <11bae87d-73e6-4946-a41f-c5542fb40b75@kernel.org>
 <akeJdxdZXAFb8XCr@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeJdxdZXAFb8XCr@lucifer>

On Fri, Jul 03, 2026 at 11:11:14AM +0100, Lorenzo Stoakes wrote:
> On Thu, Jun 18, 2026 at 11:37:10AM +0200, David Hildenbrand (Arm) wrote:
> > > In a way that's an extra check for hugetlb, but it will work.
> >
> > My point would be that we exclude all special VMAs, except hugetlb (which is
> > special but supported ... in its special way).
> 
> Mike - you said you were respinning, it'd help my series if you respan the above
> quickly so I could base my change on that :).

I sent it already:

https://lore.kernel.org/all/20260618095017.2553004-1-rppt@kernel.org

and Andrew apparently ook it:

https://lore.kernel.org/all/20260618183442.BBCD71F000E9@smtp.kernel.org

> I can send a quick patch if you're tied up also!
> 
> Thanks, Lorenzo

-- 
Sincerely yours,
Mike.

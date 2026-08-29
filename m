Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F816F288;
	Sat, 29 Aug 2026 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966975; cv=none; b=nXqZao0y3EO8s8sjRmp41MnxaLPloacCh4z4NXsSaY7o7jBEpNq0d80587ZRX6LyUO75EPYApnfEMh+zo8XGgSaLTF0UoNeIFGnV+CknnsaxuTxX2ntYY5ik/MbBhuBYjs/lV+V/N9KE7BslZi8cddFm5QUXn2BhmzQza658/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966975; c=relaxed/simple;
	bh=fKRcyFcyHKFbk+UYZrpXsvckb8il91988v/zAh+Ph5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iciGbGXnNzBNjYtWdzf0V6ezyq2rnLXBkBHVo8cjWVohL9s6Umxo7ThRUk5IP1wB5jbbWMTzXEzWI4G+SxzUWqgZe/l/zaKfbaV/KkxmSIX7sJSK5k9rhCZlhfp3GPd9F+Yri/IZd1QYdJkQuOy8pOneqE6TplwxJAfH90JPvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HiX3f7UE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HiX3f7UE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473A21F000E9;
	Sat, 29 Aug 2026 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787966973;
	bh=As5WzZ21e2lE9qQzcY6pB/XU8R4yuk56z+VgIeeRdPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HiX3f7UEQ6C8SnqLgz+pze4w+flhncZZJ+hrrW1e2fhGWobXBunQRoT5Ze0cPRwpH
	 /9Xvu0b5vTlF16HB2AVvL2GEySXbbh+Q/7oRcfp7o32NWpobNyUyajlq4nZeO7GTlf
	 QQxuO5cU0J8QywTc4nEPLFIibz+xSKHwaqbPODKQ=
Date: Fri, 28 Aug 2026 18:29:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Houghton <jthoughton@google.com>
Cc: Lance Yang <lance.yang@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, liam@infradead.org, Nico Pache
 <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, zokeefe@google.com,
 hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
Message-Id: <20260828182932.96529e36e992740eb8132185@linux-foundation.org>
In-Reply-To: <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
References: <20260828222640.1638457-1-jthoughton@google.com>
	<20260828173302.29778f1bf802a1db932778ad@linux-foundation.org>
	<CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 18:09:39 -0700 James Houghton <jthoughton@google.com> wrote:

> [lots of good stuff]
>

OK, thanks.

> >
> > > Suggested-by: Lance Yang <lance.yang@linux.dev>
> > > Tested-by: Lance Yang <lance.yang@linux.dev>
> >
> > Wondering what Lance tested.  Was he able to reproduce the bug?
> 
> I assume he just re-ran my repro, but yeah I'm not sure, heh. Lance,
> what did you test?

Wait, there was a reproducer?

Oh yeah, found it.  You changed the patch Subject: between versions,
dangnabbit.

I asked Gemini to write me a reproducer and it basically said "sorry
andrew, I can't do that".  ChatGPT was much more accommodating but
after a few iterations it was still pretty mind-bending.  I came away
thinking "nobody has ever hit this".

But that's not the point.  Now that it's out there and known about,
Black Hats might be working away to find and utilize a reproducer, so
yes, we backport it.

> > Sashiko might have found another race in there:
> >
> >         https://sashiko.dev/#/patchset/20260828222640.1638457-1-jthoughton@google.com
> 
> Let me get back to you on this. Best case, I'll send another
> (separate) patch. :)

Great, another patch ;)

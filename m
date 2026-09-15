Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC13C98B7
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480339; cv=none; b=dYAycPl4BQ8VQ41bnOwo+UMLw7ktDXrYv8ETyxKMnV+Pzei1sne7ZvevRjAZuoz6jsxo5n3ud6RYHI0NZ4s1YbJnYMn0opbjjNdszdwFR9Q6cCL9XC7ODcp252AHltn2YVNr8snyZ9iRBMTN4d6gzrAcBXz0xjYlxuAO0P/mQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480339; c=relaxed/simple;
	bh=ZAms6xLFIiVySZXmTurNlRNYz1fQZdQMmujTnwJtQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuP7Y48r73XAmK8lRmo1GRVAnTBzG89slXHzQYpVpyv0lXo6/0AZFlPOxaoUJjmW3gYnoWdgy+ISY7x6WzalJ1Q2qyrzmoY5OTuzt+94yPvhfPZu2qQx0W7nawwlL4qgfMUaV+Z7c0el7EvhjmzX0wSntb4vINCaalVd5+9x8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it4mEL39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it4mEL39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9331F00898;
	Tue, 15 Sep 2026 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789480338;
	bh=5JZvciHOubNz1++8I3c/2N9YUlCfXc/5f861xiy4ft0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=it4mEL392VOylMtWKucJN1H/SF3DAnw0vMuOMuzOxgyrfVosMCtYFPEOzDYEmBrW2
	 W+hJM+/RR/gY7ErtRBZSwl+WlJhSXohUCn6o1XeZ5ycAVGIW3kJ6OjOCPHwu/L+pGK
	 3ewVonc7r4UoKGfvtY6i8NU2P25btpAx/REc/e00UQY7GKiqtjsugzZ0EDzQXqhGbx
	 DTQLHHJXWC7QgdC95T0OSpDwm2v9UDD/SPGVZgjCkxcnGnPS+6Bj6wVpNIvstFD8Uf
	 JqsdvI//38sC3gA3EB0fPBHDwi5qqkPzu8hm4b42Ytx76sVcEa8g/ceU/zcGffVBHK
	 0czi5YHXvhY1A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 20534198003A;
	Tue, 15 Sep 2026 09:52:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Sep 2026 09:52:15 -0400
X-ME-Sender: <xms:jE2pahuaU0yPr89PNnwihMvtUDzatVBlf1o7bmhFX_fvdotrRxPNaw>
    <xme:jE2pasyD6rPQU-T7SmzLq9z7dbjbsLYjkbKjXrtQhdyq-J4_MxeCC2WM7ITBa4AqI
    FODCsVl6oZ-jRmH8MiPOJhi-AazrWCFj-aOKBwuMtiU815RWzjoBZhDkA>
X-ME-Received: <xmr:jE2pajfDJtIrKyv_BSRFJVrRzGMsmE7J7J3okImqThKeGQ6jl3GvpHylMds>
X-ME-Proxy-Cause: dmFkZTGFaXHpQBoGzjJpzXuLzZEpEDoJVlEK8qfTCGlpZSscY902ocbS+NTIbNE8tMLKHV
    Kw+V8ruiMZ5vcsUwLmFvicjQ5fT2dEGX6BR2ofYNuwhWcszZXWDOzUPFZV9Kf2hTY0XyYu
    jgPRsVUGCvAoUBVHrbjcyoU/B85MGHEOvmNw+eGSCdPHSF+WLKvCB+LRHaJjwhCDtr3onu
    9t7U2m3RKVIfG63unn994NKXoenEEAMJlO4Bca8sh/2dGdJkRJfrRO11fJi78OFB2d6mXQ
    f6/BbV5VWGgDSXWO0Q4c80Vk7TllbENgzRJLLQpIDfQ0PD5mAXpy4gZfEHx7Mr9L/IT0K6
    qh4TshP2kn6kCNLC26NFy23vTdqmsw8g3megqLyVsGqfTaooE+RYvVeuOIYZy7Gn/syAK/
    mNQESXCErDbA14ZJWZl10saMPTrc6xf8XeOzvS/LSSWkGC977QeRJhhixrzJbfu+n81g9e
    1UH9yXgjzdTmINJ0W1c/2l/8tsZ5SsrH+DBIDUf7x1iNg5JRg4E76mGNLhLbU0PpzmXwuz
    fxsbi5T4JDhLZVv7EnZRfeABl7Tvmoe5VcDJ5trMTr/Py6Jb0oHqYqPMt54lsK/cZ45fqp
    eYKlOCmUSIfa9v0foUvG1fSeSBnE2eyER4tyPwmWpyxheKzoGzIAZR2ZhruA
X-ME-Proxy: <xmx:jE2palKexW_56iZGYRl_E5d3Cu6P3XzpWFLsyln1PPKWwAz8EhzrtQ>
    <xmx:jE2pavkxi9ChIIU-0-VW8D515yeU6YlXXf4pRnSrH_EjKz4cAJAgkQ>
    <xmx:jE2pagWthQlpbluzBQjzPidj4ZNuzeY1gW-HZYMmAX7jFVQ98KShdw>
    <xmx:jE2pahs_bggCtIocE9mX-k2TRJSv5vXt2OxUFTUW0cPEs59A6Q52Ew>
    <xmx:jE2pak0I-NiCjXIwieGMDtqxkNU6lajCAf3ySXrSuRVN2imtLk7w-USU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:52:12 -0400 (EDT)
Date: Tue, 15 Sep 2026 14:52:11 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, usama.arif@linux.dev, ljs@kernel.org, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero
 PMDs
Message-ID: <aqlMvfIhr8nD9RHB@thinkstation>
References: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
 <20260913072312.52111-1-lance.yang@linux.dev>
 <aqfRCPheDYTgTdAk@thinkstation>
 <f76beaf8-351a-4b22-b362-a945a5e1af6a@kernel.org>
 <20260914111940.f7e2c72eac4a2df97a646793@linux-foundation.org>
 <30bcc70c-be07-4237-9bb1-554aa5b5c5c2@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bcc70c-be07-4237-9bb1-554aa5b5c5c2@linux.dev>

On Tue, Sep 15, 2026 at 09:43:15PM +0800, Lance Yang wrote:
> 
> 
> On 2026/9/15 02:19, Andrew Morton wrote:
> > On Mon, 14 Sep 2026 16:29:00 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > 
> > > On 9/14/26 12:59, Kiryl Shutsemau wrote:
> > > > On Sun, Sep 13, 2026 at 03:23:12PM +0800, Lance Yang wrote:
> > > > > 
> > > > > On Sat, Sep 12, 2026 at 11:46:35PM -0700, Andrew Morton wrote:
> > > > > > 
> > > > > > 
> > > > > > That's the sort of thing we'd prefer to avoid.
> > > > > > 
> > > > > > 
> > > > > > How real is this?  Is there a reported-by:?  Do you have a reproducer?
> > > > > 
> > > > > Yes, I reproduced it on x86 with a small test module. It sets
> > > > > VM_MIXEDMAP | VM_HUGEPAGE and calls vmf_insert_pfn_pmd() with
> > > > > huge_zero_pfn, without touching the page tables directly. A full-PMD
> > > > > munmap() crashes before the split series[1] as well.
> > > > 
> > > > Ah. So there's no real bug upstream, right?
> > > 
> > > Matches my understanding.
> > 
> > Thanks.  I'll remove cc:stable, move this into mm-unstable as a
> > next-merge-window thing.
> 
> Sounds good to me, thanks, Andrew!
> 
> Kiryl, David, would you prefer the validation for raw-PFN mappings
> of the huge zero page as a separate follow-up, or should that
> validation replace this patch? wdyt

I think this patch can be useful for graceful recovery if we somehow ended up
with a zero page in a mapping where we shouldn't have one.

A separate patch with validation would be great.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

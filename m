Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA723624A5;
	Sat,  3 Oct 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037814; cv=none; b=TRoGuWOMvN38GLqR4y+OOG5HbgNrf2i2pDldQkWimOneJ7px+do1H/9UvbGYHxBJ9XzJ3ai/EKkD4LNVZsNFXV7+V/Re2LIVugnW0wTyLqpCT9dShmRKHXgB+KfG7lmaw6RevmfKsdhn7YFGSnUb3l7t6OFRMyX82yFyuJVyUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037814; c=relaxed/simple;
	bh=t0UDno8TrYYCKqsnhBUcmiISR33g6wQpfmrIYgzFs6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXrAGPhR6L/K2W2iNAIAZ5csq9G0uZ3ouitK6gGjYjPeMQ8PtzZat9O8tiE+5wnN/c7Aq+Lcly7Sb0dw3Jy1JqsfKONNzPKFx7y0ivKe8LNGQ0Y2Rsi+Czs3g2oM7kad4Pyl+l4KERrxF8PKvU+/q1NYl7BV8PLI968ajpreIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5nou7g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5nou7g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA99C1F0089D;
	Sat,  3 Oct 2026 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791037812;
	bh=0VOKNZsXt8POVkaKJcBsptOeZCCqTjnL2Hl8Rsw8LdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G5nou7g3BqkL8GO0V7LH3FWiz4Xoa6UoLxbdYyBRNRvGCkLhqMbp6+wA6pS2p/wVK
	 sidohVIkYNtujZDVfUM350+FJ1wgxX60ajONcjnohTOYKxjQMkWAyWELf0CnGvr02Q
	 gjohG0PwgaN8nLfzWqbu/L7Nia0F7RUnlNp248cYN3q92WlLgwaMyITpAQqEehfXjP
	 sea+oh86kMUv9RdeT7EsCS9ncjSttPEBd3y2ixsVo0icKtKNxWC3oeZh/c3Q5WQ0Sk
	 EhQsd9nLHWTRG2SBKA3cDpqFKNSGHPTNptvc7RmnmGg5bTdKrg/s5hmD3gnBUMZB7v
	 QtpTiEniK6sSg==
Date: Sat, 3 Oct 2026 10:30:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	david@kernel.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	4ncienth@gmail.com, alexander.motin@truenas.com,
	caleb.stjohn@truenas.com, ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asERcvLuNJatsBL7@laps>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>
 <asDF77csaLDIuHTB@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asDF77csaLDIuHTB@gremlin>

On Sat, Oct 03, 2026 at 10:18:34AM +0100, Lorenzo Stoakes (ARM) wrote:
>On Fri, Oct 02, 2026 at 09:30:23PM -0400, Sasha Levin wrote:
>> > Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
>> > pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
>> > memfd_secret() page for the first time fails with SIGBUS while the
>> > same user is running perf record, and read() into such a page fails
>>
>> Thanks for the report. I've dropped 97d34aa65c29 from the 6.12 queue,
>> and also removed the copies that were staged for 6.6 and 6.1.
>>
>> 7.2.y and 6.18.y already shipped it, so those need an upstream fix,
>> which stable will pick up once it lands.
>
>Sasha,
>
>Could we perhaps take a breath and pause?

I pulled this out quickly because I didn't want this issue to go into the kernels that were released this morning.

In general, our policy around this type of reports is that if the issue is in a
released LTS kernel, we will wait for a fix upstream, and if the issue is still
in our queues, we will simply drop the patch from the queue.

>This patch fixes a really quite serious vulnerability that allows an
>unprivileged process to allocate arbitrary, unreclaimable (i.e. OOMK cannot
>save you) memory.
>
>Allow me to assess the validity of this report _before_ dropping things
>from queues perhaps? :)

No disagreement that this would have been better - in this case it was timing
as the releases were about to happen the following day, so the safest choice
was to drop it while we figure it out.

>It was sent late on Friday in a week that I was ill and it's Saturday
>pre-LPC, so that's hardly a timeframe that I could reasonably have replied.

Keep in mind that our release cycles are fairly short, so this shouldn't be too
big of a deal?

We will generally go for the safe option of dropping a commit that introduces a
regression as it's fairly easy to queue it back up very soon after a
diagnosis/fix shows up.

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21836197E;
	Sat,  3 Oct 2026 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066898; cv=none; b=qz+gd+XP07ttzZ686NLyC1xe8mdKBJvq0YjjZ8OM3mVsWk/tOqfIZ4TZ3v3i/rxVgW80GVyIMkZtFMNY+9FXvbxMC20J5Y56BS9uJMwCXcKcvY0jzt7uPjX98QK9nHFhiquxtkP4uWyt1Dads+Lz+30TTD29djq0HNg5ffVMmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066898; c=relaxed/simple;
	bh=3c83gcdlMeLewvksfduAw5wRq5N5/4MFTXSogqZE/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoyMYvx/tUeLLURe9e0FjWvhWMgXzbUKiV/Y/4T7p1GyLXosNJkxMxSyzaNi/EoQo/yXb+W+nNeEdjFmQBObnc6zN5EY5LdsuQLokoYJxwja1V6dIUOgKyuGIAYKarPtENm1VRD92ScQarCUHImwU/lOEhYuNDCBDQ3VxK9azVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct2T4C8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct2T4C8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B91F0089C;
	Sat,  3 Oct 2026 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066896;
	bh=zM0wm05N9ZuKkLRyyuk0bb0nZGRol8Du4ryT1xAF6Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ct2T4C8w0B4NvOUhuAHDjs6urnTBmSBma2hgKbEK6vMzu0BleolZEr8UYilUeTcpo
	 cj6LeVtQws2ZNkAfkwi0RXGE8crK0CF8nyUA+ri30xkJM40i9rjErnYw5fW+XjXgc+
	 LrZoeTae6F0j+baG8DKdekLuwm5ojpVYfOW6r774y/BKWhXKFWZyUXzmubgcdZrl02
	 q5e6KpTldk63TEOLIcF7nyv/nBC7rmSlvFhKJ5uiKAE8IYWpPkBY5c/yaqqArUauHP
	 p40OT8Rtqjq7gPyRMZSIch1RXfZDc1gI3uo3WTrAKZ+UKdQ9JVg6Yml4Q2TNpHE8/x
	 XL3HvrZhi2IBw==
Date: Sat, 3 Oct 2026 18:34:47 -0400
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
Message-ID: <asGDB8ZBX6zcsmWJ@laps>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>
 <asDF77csaLDIuHTB@gremlin>
 <asERcvLuNJatsBL7@laps>
 <asEra6tBau-hiutj@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asEra6tBau-hiutj@gremlin>

On Sat, Oct 03, 2026 at 05:23:53PM +0100, Lorenzo Stoakes (ARM) wrote:
>On Sat, Oct 03, 2026 at 10:30:10AM -0400, Sasha Levin wrote:
>> On Sat, Oct 03, 2026 at 10:18:34AM +0100, Lorenzo Stoakes (ARM) wrote:
>
>> > It was sent late on Friday in a week that I was ill and it's Saturday
>> > pre-LPC, so that's hardly a timeframe that I could reasonably have replied.
>>
>> Keep in mind that our release cycles are fairly short, so this shouldn't be too
>> big of a deal?
>
>I mean the same argument could be made both ways :)
>
>>
>> We will generally go for the safe option of dropping a commit that introduces a
>> regression as it's fairly easy to queue it back up very soon after a
>> diagnosis/fix shows up.
>
>I think we'll have to agree to disagree about what was safe in this situation!

Happy to chat about it at LPC. Our reasoning is that users are better off with
a regression they are aware of, instead of getting surprised every time they
upgrade.

I can see the other side of this, and I think we can do some work to accomodate
this type of preferences from subsystems/authors.

-- 
Thanks,
Sasha

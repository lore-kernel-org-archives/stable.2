Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118C339377;
	Sat,  3 Oct 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044640; cv=none; b=hJLRN5xqzbdJecqik/KCdtBz2/pVxJYTu+5QKJMLHErIna6HA5Iy+nmPPxq2lgdBVO+ZdRit15OU2HJ8WUWNYVV9wPxVXnRwEfGtR32rt6fDkPkd0oREQrdkUdN/9CL2z4iehYSz3e+D00D+4JuTZlUnFx3KFVYOkQIhGI8qHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044640; c=relaxed/simple;
	bh=fCyj+yKFZ/zNUv75m/5gM/WMYwo4kn0fmfxbz9QYRxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlIw0OsIqoHrrrlUiRZC9x0qmqE12fRAawmMTum5NlcDXDy55nw2Ua8mUhI366wHx9fwwfvbQUekwILLUjSVKzNw9lf6UrXW75jITYi1rPfydwKgos4tpShzDC8+WpREyV4gXu/P8vYIwarteDO1BzrH7uSz7Uzo72km5JNgfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3By/iIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3By/iIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397251F0089B;
	Sat,  3 Oct 2026 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791044639;
	bh=fCyj+yKFZ/zNUv75m/5gM/WMYwo4kn0fmfxbz9QYRxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q3By/iIl+wAWB6NlC2hxCvyxm5XSUpTLsrE928c+38kDsIt973GEHRqGftSTW6Ddr
	 e7likP9QdpMWzP3a32sP5Ys9S3pTBCLNaE+uPpPM2M/6oy1/1YHSxqMCW77Ss38jU+
	 QqcSttsQE2TakfDeLZ75mcLnKYKfftys7qdNcKRJF9dO30fcfrbED40zQsKGOcM+hY
	 SL9embAUhiKsPdhiut0AvYCKRP5c+mTIDkQ4VtrRbvps888kVvHlZMwEiDgqGEYTPR
	 w+WppNHEK6Cps6GnRukkoPzlaewW6VQXMq9QBiBmb1Hcggc7ChDnHnKXjp5XYg3zHM
	 J0gGzixokOomg==
Date: Sat, 3 Oct 2026 17:23:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com, ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asEra6tBau-hiutj@gremlin>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>
 <asDF77csaLDIuHTB@gremlin>
 <asERcvLuNJatsBL7@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asERcvLuNJatsBL7@laps>

On Sat, Oct 03, 2026 at 10:30:10AM -0400, Sasha Levin wrote:
> On Sat, Oct 03, 2026 at 10:18:34AM +0100, Lorenzo Stoakes (ARM) wrote:

> > It was sent late on Friday in a week that I was ill and it's Saturday
> > pre-LPC, so that's hardly a timeframe that I could reasonably have replied.
>
> Keep in mind that our release cycles are fairly short, so this shouldn't be too
> big of a deal?

I mean the same argument could be made both ways :)

>
> We will generally go for the safe option of dropping a commit that introduces a
> regression as it's fairly easy to queue it back up very soon after a
> diagnosis/fix shows up.

I think we'll have to agree to disagree about what was safe in this situation!

Anyway, the commit is fine as-is, and fine to be queued.

I am writing a patch for what seems to be the underlying issue which appears to
be related to how perf accounts things.

I guess I'm going to have to pack for LPC really late today :)

--
Cheers, Lorenzo

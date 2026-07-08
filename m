Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BD2DAFBD;
	Wed,  8 Jul 2026 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542450; cv=none; b=HfkuRpH+OKWpZpIQLV82ZAv1CWFZ0XGnBDr6ROFuf5Zl216TEd18TNlxy1cO7GiZ781QB9qj9sOZYvHurdW7DDiI2o3Csxy2k3w2x+ofE1AkUfzuanabfbB+XgrLQJjRnoRq0He5WQMjS6oG0MydPh2Bv7mdQPL74z/t+2VmteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542450; c=relaxed/simple;
	bh=2bcBNscmDky4aSYHhbYgTzFGJWzM3m90tuRJA3fOHaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II09zvKNdjMK34g8x13DmfKcTOdQMwuQa+Ae2dJDOrDWARc3p7QIlFb3uL9zcNeWNusB+xpOS6mW5H9/J4/6CdP8TGfdOXkb2EwkB1P1Cu4le2UUDyo5zbTY/Fi3WRegbSIy1hFkLC6Rnq3IH2h+/DQVIuD8PPpIfxOCWN/vDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0mPIK5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0mPIK5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187EA1F000E9;
	Wed,  8 Jul 2026 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783542448;
	bh=UufbTcVS012NEpYIzE5O8k6HEf05ir9SXh6XReM6d7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0mPIK5AYQ6lOSauRm2llKdYadPbnYco+nGtJyVuMmLSLVb1wuzdDO9CcPmmXb945
	 DNxWOukux8NB2ZNLw2hP0YeKhKmDB9hAdlUlUxXPxjsxiRaUV+UaKbwTH+Zp6t5cV0
	 USPLBYMZtg9hKcD7nwJxMTZurTBnfKLhtWKO7nOnjvQbmYNzeFqmf6DysKoaf3vVZv
	 /MSWe6RyGYwSfxIM8SnuH2Bucn7W9NExwJPRVmF7JFAdku7reOFt6JfsicKO9siJZL
	 yOWLvLjjFyNd/WA7oDTxfjAONp9HJSMZUBF3rq044TUNMcgERNrJCvEy1unkEz4uHB
	 tV3bwit303nmA==
Date: Wed, 8 Jul 2026 22:27:25 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
Message-ID: <ak6yrQlcifIHukBA@pavilion.home>
References: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
 <ak51mpHPzsQrGFmv@localhost.localdomain>
 <ak5-L-1SzGPEc0_i@redhat.com>
 <87v7apqrx8.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7apqrx8.ffs@fw13>

Le Wed, Jul 08, 2026 at 08:04:19PM +0200, Thomas Gleixner a écrit :
> On Wed, Jul 08 2026 at 18:43, Oleg Nesterov wrote:
> 
> > On 07/08, Frederic Weisbecker wrote:
> >>
> >> > There is a similar problem vs. posix_cpu_timer_set(). For regular posix
> >> > timers it just transiently returns -ESRCH to user space, but for the use
> >> > case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
> >> > allocated on the stack.
> >>
> >> do_cpu_nanosleep() only targets current and since it's on the stack, no
> >> other task can access it. And the current task can't be exiting/exec'ing
> >> while calling posix_cpu_timer_set() on that stack timer.
> >
> > I thought the same initially, but it seems that this is not true...
> 
> Indeed.
> 
> > I can never understand this API, but it seems that
> > sys_clock_nanosleep() can target the !current processes/threads ?
> 
> It obviously can't target the current thread because how would that
> accumulate run-time when it's sleeping?
> 
> It can target the current or some other process, so it's subject to the
> non-leader exec race.

Duh! Yes sorry, I got confused with the "timer.it_process = current;"
line which is of course the waiting current task and obviously not the target.

-- 
Frederic Weisbecker
SUSE Labs

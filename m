Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8524293C;
	Wed,  8 Jul 2026 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533864; cv=none; b=KVOU/FbBLkG+rpZZX8RPL/z7HT0or9lOUys6vX0H+z8lvPixcFYbdA0ybt1ZDXGFGRstamXXg/TBluCOYX5+RvxVZXWpgwJxmE78JZwVmwBr9xdhOhWGUZOL5BVAwjlHTDTQHRjJiDRipmEi7GyK3JGhsOhu0g/rGULEM9cs/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533864; c=relaxed/simple;
	bh=BYoyTsXKeOKLoybb9RXpJX7DfLF46U+dXVSkSmt1cA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQlo/wzBZn3RQ/z1ecWOuSR20kPgluuMOMYWbmwJHkCfW9pJAnU4R/Rh3jA2qoshlmIhLPA6tPk3RuUtAwmvSTsRkOqeqx2Vkwjh7KCH+0bJ4PYm4He3EPa4ePxRSyjhkg9R+UCPXpMYIngteW5eGGRur3QcuHIgtiOXqTQR7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np18De23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np18De23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497A31F000E9;
	Wed,  8 Jul 2026 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533862;
	bh=lglVf6gCknhzk8O/k1JDutf15oIRKP3Kl5VT874IV5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Np18De23cSWDdpOvofshVSCFsCyYrL2Zsv7ZRjFsVprcsfSFYs9CoCUAfOR/itfWc
	 1m6/TTt+rIOtOXjeuTK8kM9VBE5F7yr8ZKBw0mAEZnbHkUcXIGN/A6r7gem55EhMPf
	 JrCS85isVx17+lIpnJfb/GddL1VQRmI4qFiQ79FFP1dJ6FEixpUjTugve+4YBQOmfZ
	 i/5tlBYSkFi3FDxuWFCmdfn2mErdp01NJ3F8eeN2eZfWyGte1ZEA9w8NP8ajp191W7
	 bvLZwCeueMvoRbZ+LUlQr0dD9d3sn7I+/HV9JEDF/0z9o3G21FXnNWRAvrAWe9oo1q
	 1STlFakM3nBig==
From: Thomas Gleixner <tglx@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Wongi
 Lee <qw3rtyp0@gmail.com>, Jungwoo Lee <jwlee2217@gmail.com>,
 stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
In-Reply-To: <ak5-L-1SzGPEc0_i@redhat.com>
References: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
 <ak51mpHPzsQrGFmv@localhost.localdomain> <ak5-L-1SzGPEc0_i@redhat.com>
Date: Wed, 08 Jul 2026 20:04:19 +0200
Message-ID: <87v7apqrx8.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 08 2026 at 18:43, Oleg Nesterov wrote:

> On 07/08, Frederic Weisbecker wrote:
>>
>> > There is a similar problem vs. posix_cpu_timer_set(). For regular posix
>> > timers it just transiently returns -ESRCH to user space, but for the use
>> > case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
>> > allocated on the stack.
>>
>> do_cpu_nanosleep() only targets current and since it's on the stack, no
>> other task can access it. And the current task can't be exiting/exec'ing
>> while calling posix_cpu_timer_set() on that stack timer.
>
> I thought the same initially, but it seems that this is not true...

Indeed.

> I can never understand this API, but it seems that
> sys_clock_nanosleep() can target the !current processes/threads ?

It obviously can't target the current thread because how would that
accumulate run-time when it's sleeping?

It can target the current or some other process, so it's subject to the
non-leader exec race.

> Or why else we have clock_getcpuclockid() ?

To express which thread or thread group the sleep should be on. It's
exactly the same as timer_create() + timer_set(). It sleeps until that
clock accumulated enough runtime, while regular posix-timers either wait
for a signal or handle it async.

Thanks,

        tglx

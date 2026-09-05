Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FED345EC6;
	Sat,  5 Sep 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594645; cv=none; b=aV81L9f2s0Rxh5BuDomaAB+p4P3Dec8uGuNCrnz91oAuOZmWH47A3NBi4zEDpOXLF/TTyn3D0DWEox/z3RcPbS3xbIXny7wOSE+Fg/+SQAeV1obhows1JsQ5a6myhyl6OslvggBfiHYUCUHWj/khcfmjqX6X1iTSKri7/RwRCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594645; c=relaxed/simple;
	bh=PfYFORsSj7vEBAJGUHn2afquRpLoQWdfQHuBeWZSAr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jknyswMz1aarrWoOX/npLkak7DoH8nFLvUCnjGgYTivEhpfe8ia8clVkckfw3/opL0FMgd9hsb6P/C4WMa2NEvI551m6iMwWzlEX5GJZCzxzIL4YsdlbKGSdsJAB3UGNYrqE/QoS89ybkhp0Vk1gqeOFbSaTEUIQmrilMTI3Kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isoWgHLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isoWgHLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1C51F00A3D;
	Sat,  5 Sep 2026 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788594643;
	bh=12rDiarrJ5lBoqLH1Yft+FtP+5k9xoayCncZ/D8LH2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=isoWgHLZrGZ5rM3NXSskfE55A5910JBj6Xhr9HK2c5uDBffajVxBfcElr6dzobrBi
	 TJ/HvoB3JgCSzERd3ZWaH2+70uBA6x+Rkrx8/vn42N1zUOssN2sq5Qi5WyH96qLVi+
	 vWJxgc1UJT1B35s56e5zdoKigH8GgtRrLO4DoHBBCKPOGbBDCuGVbuxEHBIQ2EBuG7
	 jztfbbPOIlsti9pee2I30xQgd34Bcqwacrl6DMZG0Msw/kOjYpLMy2goIqciO6UkkN
	 G/ozTPuOymwsfHHGZWyzg52Zt9xopqSoYyBHG2jCTSiyzXUyN501P2TNMUQLywfgz3
	 Pq++50i9Zfqgw==
Date: Sat, 5 Sep 2026 09:50:40 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch 1/8] signal: Prevent exec() race
Message-ID: <apvJ0PO7DJnh1JHS@pavilion.home>
References: <20260904112100.683893401@kernel.org>
 <20260904112202.074391651@kernel.org>
 <apqs6wgDtpdLI-k8@redhat.com>
 <87zexw5exv.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zexw5exv.ffs@fw13>

Le Sat, Sep 05, 2026 at 09:34:52AM +0200, Thomas Gleixner a écrit :
> On Fri, Sep 04 2026 at 13:35, Oleg Nesterov wrote:
> > Thomas, I can't read this series today, will try on Weekend.
> >
> > But you didn't reply to
> > https://lore.kernel.org/all/apgHJj0qH7HlAXKO@redhat.com/
> > Let me quote that email here:
> >
> > 	OK... lets suppose the exiting task T passes exit_signals().
> >
> > 	Suppose we have an "ignored" timer tmr. Another sub-thread calls
> > 	do_sigaction() -> posixtimer_sig_unignore() and finds that tmr
> > 	in ->ignored_posix_timers list.
> >
> > 	But posixtimer_queue_sigqueue() doesn't check PF_EXITING, I guess
> > 	it should check it too?
> 
> From the patch:
> 
> @@ -1990,6 +2004,9 @@ void posixtimer_send_sigqueue(struct k_i
> 	if (!likely(lock_task_sighand(t, &flags)))
> 		return;
> 
> +	if (unlikely(tmr->it_pid_type == PIDTYPE_PID && (t->flags & PF_EXITING)))
> +		goto unlock;
> +

But posixtimer_sig_unignore() calls directly posixtimer_queue_sigqueue(), not
posixtimer_send_sigqueue().

However posixtimer_queue_sigqueue() -> complete_signal() -> wants_signal()
checks PF_EXITING and complete_signal() then just drops it.

Ah but doesn't that leak a refcount drop? Looks like the PF_EXITING check should
indeed move to posixtimer_get_target().

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

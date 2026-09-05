Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB663644B3;
	Sat,  5 Sep 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617361; cv=none; b=RUcJIsQ7QKNQ/ShH34XMyx2oYsOTynI5RiUNqVW3CYotGunwoNUV1EF1oxProy0RUO/R9REHV9zat5Xlg+Qo/0qM45+c4IpjnCYSLtflWMH1/pLgGvNK94eW/Su9xg9OvG7ZKzNRUtJuMhdpkDxCSZt1SUU4QeVcM3teQAAiZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617361; c=relaxed/simple;
	bh=zXOI2pas1pZBtVrSpW7UFnbMRtEXVsuraxNPn7n/stI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn1GHLgq/oX8eaNQTSzqQChncY5+skz9JmkRkPooqwUW7m6Pr7WjrQdt3MmnEP8sRSOmSoiBJFNd6wyD+EBBwbUywNYBoyWUhp17Ms7WfvFaSV3rLDbSG69VDc7infUqI+D4R4NeWu9GQ4dDTMXmqEpa8hT/wjsMCBRwqF10PNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=pYCBhce3; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="pYCBhce3"
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 685E7uMc2875246;
	Sat, 5 Sep 2026 16:07:56 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 685E7uMc2875246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1788617276;
	bh=7R70YHIqPDdfMwkw0zcIU3h+rSevE4/ppoGMS+wfe14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYCBhce3aTrnSEcBA15TWNsqgE/TWuGKIHXEbAf9aNoET8hbL+c5lgwzJvRpaBwbb
	 DU8e0Y4RIt0wSPKNf5oKVdQDG9EDG15layejk7s/phueO5ESWzWd4tJpMSPrdJoD4M
	 znlrPhjLloDhcACVgUhS+xJ3sWvT8ty/1e4mLPys=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 685E7tRC2875245;
	Sat, 5 Sep 2026 16:07:55 +0200
Date: Sat, 5 Sep 2026 16:07:55 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: tulip: use mod_timer() in t21142_lnk_change()
Message-ID: <20260905140755.GA2875205@electric-eye.fr.zoreil.com>
References: <20260904123843.375633-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904123843.375633-1-linmag7@gmail.com>
X-Organisation: Land of Sunshine Inc.

Magnus Lindholm <linmag7@gmail.com> :
> t21142_lnk_change() is called from tulip_interrupt(), i.e. in hardirq
> context. On a link-fail or NWay renegotiation event it calls
> timer_delete_sync(&tp->timer) before rescheduling the timer, which is
> exactly what
> 
>   WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));
> 
> in __timer_delete_sync() exists to catch, since tp->timer is not
> TIMER_IRQSAFE:
> 
>   WARNING: kernel/time/timer.c:1611 at __timer_delete_sync+0x13c/0x150
>   ...
>   [<...>] t21142_lnk_change+...
>   [<...>] tulip_interrupt+...
> 
> This isn't teardown, it's just rescheduling the media timer, which is
> exactly what mod_timer() is for. mod_timer(timer, expires) is
> documented as equivalent to timer_delete(); timer->expires = expires;
> add_timer(), and as the only safe way to change the timeout when a
> timer has multiple unserialized concurrent users. That is the case
> here: t21142_media_task(), scheduled by this same timer's callback,
> already ends with its own mod_timer() call on tp->timer, with a
> comment noting it synchronizes against add_timer() calls from
> interrupts. Using mod_timer() in t21142_lnk_change() as well, instead
> of an unprotected timer_delete()+add_timer() pair, matches that
> existing concurrency model instead of racing against it.
> 
> Update the comment in tulip_interrupt() accordingly. pnic2_lnk_change()
> still calls timer_delete_sync() from the same hardirq path, but its timer
> callback re-arms the timer directly with mod_timer(), so fixing that path
> requires separate consideration of the callback/reschedule race.
> 
> The warning was reproduced during a link-state change at boot on an
> Alpha UP2000+ running v7.3-rc1 with:
> 
>   0001:02:08.0 Ethernet controller: Digital Equipment Corporation
>   DECchip 21142/43 (rev 30)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---

The current code may avoid concurrent run (#1) of t21142_start_nway and
t21142_media_task. It may also deadlock (#2) as you have noticed.

As far as I understand the code, current users - if any - may experience
#1 (avoid concurrent run) or #2 (deadlock) alone as well as #1 and #2

Users of modified code won't experience #2 but they may fail more often
at #1.

It may deserve a minor comment explaining either the choice or why it is
not an issue.

-- 
Ueimor

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818931;
	b=t9gpAWngiDCFp2qEb9O8pu7sLGzXM2ldZ/L7q2pxi0Yjh2QCiQ7p0Ocs1o0WsUw/G8QP
	 rtf7h7p1yQLAqevGOvEKtwaIZYzPVm9j9Xk95NWiXbNTO84GDDuQeqowtnGYEuTvAi2b5
	 AqwM6wdIXFCXZl0n0u1DhhhR7NsH1aEmOOvf+FMB7QPBt+W9PTZDZFalhuPV/3M++MoG3
	 u3EH75C/QX8lwUaINMWw5bPRAWGmgE8H5mJasmWYA/OXmfJrSmHAMH+649Kd5+Fam52VD
	 GwHnZJmtwEOiwGyNbow6gC+5giQFNEPeXv7/nuRwrDO/w+daMi+dC1JQ7egVHhigeNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818931;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cRVaCL7qU/Nur8d4hgs/SV92X/SL9mr/1daLWF0YHKI=;
	b=STxujYFlUrhM1OCs4symiMGqEO0KFX7hjFYuofS8xLF4tEQPgOfRTNdnVJ9lrIbxFLmj
	 yuZ8Ahr4KcKzY0EqHl5zgaN5ScnYv2zO923QvfsqKqOsJ/cQoZxmO+1VvUUg8sWwPwnXA
	 YenbCrrVJvz0fFwOifj56sf8D5dRT8Uzdu3zM3fwhYsTO6ah5myJvbN/X9EtTsHxhjjT5
	 LsVDus04iGFgdOwuqWcOiS2uwTLvBdyVXlxn2bJRjmwJQOgmbLqlscQ/RoZM9wpSrBv2H
	 /DJ0AAzSRKHdu+QUdUAb72ivpOZqCBTU1Och6GX24us+aO4O86/t6Qf6ZqwB6jfiBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Vqu+DQf/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85A606A335;
	Mon, 16 Nov 2026 08:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA85A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Vqu+DQf/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1987E1476;
	Mon, 16 Nov 2026 00:48:47 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 063273F673;
	Mon, 16 Nov 2026 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794818930; bh=0WXE/Ly9cpApr/71QrxJ7M876eoHyZDmr6/7lDWWuQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vqu+DQf/8WoHXNUICTl252urZ1VZBjUD5IxrSPQw8Og68X/mI+9yOTKikAuycE2NM
	 JgV9UHCp9ROnf6DrjV6/siDzVuGlksM11dt4Nb6DgaYzrn6sWGuXVE4upg4m0oHcmQ
	 aqnGnd/xYeD550ektColUwYAJhb6NeVbei6HnwpM=
Date: Mon, 16 Nov 2026 08:48:41 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: sudeep.holla@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	cristian.marussi@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: fix deadlock between reboot notifier
 and forceful work
Message-ID: <avrDaZKTkXKfono7@pluto>
References: <20261104053359.1613991-1-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104053359.1613991-1-lui2012qwq@gmail.com>

On Wed, Nov 04, 2026 at 01:33:59PM +0800, Chengyu Liu wrote:
> scmi_reboot_notifier() calls cancel_delayed_work_sync() while holding
> sc->state_mtx, but the work it waits on - scmi_forceful_work_func() -
> takes the same mutex.  If a forceful transition work is in flight when
> the reboot notifier fires, the notifier holds the lock and waits for
> the callback while the callback waits for the lock: deadlock, and the
> reboot wedges.
> 
> Moving the cancel outside the lock is not sufficient on its own, as the
> callback also calls unregister_reboot_notifier() unconditionally, which
> blocks on the reboot chain rwsem (down_write vs. the in-progress
> chain's down_read) while the notifier waits for the callback - the
> deadlock would just move to a different lock.  Fix both sides:
> 
> - Notifier: compute the decision under state_mtx, drop the lock, then
>   cancel.  A callback that slips in between sees state ==
>   SCMI_SYSPOWER_REBOOTING (not IN_PROGRESS), skips the forceful
>   request and finishes, so the cancel cannot miss it.  (The callback's
>   own system_state early-return does not cover a work item that
>   started before the reboot began: kernel_restart_prepare() runs the
>   notifier chain before setting system_state.)
> 
> - Callback: only unregister the reboot notifier when actually forcing
>   the transition - that is the only case that needs it, because the
>   forceful kernel_restart()/kernel_power_off() would otherwise
>   re-enter scmi_reboot_notifier and self-deadlock on state_mtx.  When
>   the state is not IN_PROGRESS there is nothing to force, and skipping
>   the unregister keeps the callback from blocking on the reboot chain
>   rwsem while the notifier waits for it.
> 
> Found by static analysis.

Hi,

thanks for this, this looks good to me.

Sashiko flagged a residual issue in your patch:

https://sashiko.dev/#/patchset/20260916093527.2004594-1-vulab%40iscas.ac.cn

Since I am fixing some other issues around this driver I reposted your
patch within my own series, maintaining your authorship and adding
the additional fix needed (hopefully :P)

My series including your is at:

https://lore.kernel.org/arm-scmi/20261116084211.3066460-1-cristian.marussi@arm.com/T/#t

Thanks,
Cristian

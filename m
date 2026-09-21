Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569B41D4FE;
	Mon, 21 Sep 2026 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978147; cv=none; b=sajo/CNeUJWy6FUcTtXXZd2kJL20Fa4r5CqZcjBX3zr9CBGVm09CzwPhStfSWFeA1XiXqBvam/66b+YLC3BG+XHnI/fylHgfIGv352ya3XJfJMGIQVArXynca/q8FFuoR9CEO5ujlYN/WXiWmNZYPwTiWZMkxs2Np9k338dH0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978147; c=relaxed/simple;
	bh=yG94IDnRPo7ZwRo0nGVXZF/hqh0iJRXqgpvzk04JUTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hymNgPtyoxnj6Ps5WorISbuR5p35RT7PtAm8B+7+iKIXA2Q2TXeiEo1bqeYNEBvSMSnItTD+Z22FusdYzN1+K6xdpcyjna3ESw/BOkL4SDFDv4jCN1fdzIRuIWisFrpOe+G2nWGvcYVqOMykC5J9bhQb+Nyg2I3iLqf4nGxkQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g8OQOE7G; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="g8OQOE7G"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hpG8G23S7z6SXg;
	Mon, 21 Sep 2026 10:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789978126;
	bh=yG94IDnRPo7ZwRo0nGVXZF/hqh0iJRXqgpvzk04JUTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g8OQOE7GljT0CxIcDfRd1o1O6QIFNLAP5Bl2LkuCJr35rL3PdHzZYYT1upAOG86l/
	 R+M/QkvIeVDwPCBTOB7j7VifTuEoZr9JK8mDQdk6waz3odX/2MzYjJXA8U0T4RPAxb
	 nt9u1yEYCyWCNrGRJ5FoRp4ntHB7Szx0jnQu1+t4Wh6K3peenkH3pq0dP66NbAe9gU
	 V3C0h5b40ithZAXqcLJqXHtInFwkMWCKPslHIKoGaTMdTd8bKgS8RIkHWlIa3EB3uf
	 7MJJDfwEiAPUkH6Sx0Rgrdzt5xBSMyrolPVwQtyuKYjGGE+FByMMPw2Ip8qEpxE6rw
	 BHuIj7JIoGiBA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hpG8G1KWLz50Dm;
	Mon, 21 Sep 2026 10:08:46 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hpG8D2Stcz8scg;
	Mon, 21 Sep 2026 10:08:44 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CC40C5FA21;
	Mon, 21 Sep 2026 10:08:36 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <a40f9988-7e82-42f0-a27d-7a7c94dc37d7@leemhuis.info>
Date: Mon, 21 Sep 2026 10:08:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: David Lomas <david.s.lomas@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
 matthew.leach@collabora.com, superm1@kernel.org, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Florian Schmaus <flo@geekplace.eu>
References: 
 <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
 <2026-09-20-daily-reply-0011-re-hibernate-preallocate-deadlock@kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <2026-09-20-daily-reply-0011-re-hibernate-preallocate-deadlock@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178997811733.4166978.15433736405461601017@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: CC40C5FA21
X-NC-CID: R1o9YNrR4YLrPmjeFjPCGDNUa9u6P2zxWTuAYaBDBMxyJJN9O+c=

On 9/20/26 19:50, Sasha Levin wrote:
>>   task:systemd-sleep   state:D pid:36677
>>    throttle_direct_reclaim+0x358/0x3e0
>>    try_to_free_pages+0xbf/0x220
>>    preallocate_image_memory+0x35/0x9b
>>    hibernate_preallocate_memory+0x25b/0x390
>>    hibernation_snapshot+0xc1/0x4e0
> 
> Rafael, Matthew: there is no fix or revert in mainline, and 7.2 has the
> commit in its base release, so 7.2.y users keep the hang whatever the
> stable queues do. Should the ordering go back, or should the hibernation
> task bypass the pfmemalloc throttle?

Not my area of expertise, butm FWIW, Florian Schmaus (now CCed) on
Saturday posted a fix referencing the culprit and from a very brief
looks sounds like it might address David's problem:

PM: hibernate: Freeze kernel threads after image
preallocationhttps://lore.kernel.org/all/20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu/#t
David, you might want to take a closer look or even try that patch.

Ciao, Thorsten

#regzbot title: PM: hibernate: deadlock due to waiting for kswapd

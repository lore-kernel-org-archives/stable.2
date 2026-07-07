Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D63DD530
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419574; cv=none; b=MYzDeb7oiTY3BULvc6cxezaCkAN7S3Mt7T3i/juXMKAxWwiq/H898KCGcN4yrqkz7IjiYgPqo1Dt8l5fivGmHfV6I5CEi9nJM8wi3kU1wMOSWXjTiJqGnImbKZc8iBxtO5ZFZWSvv6vDw2hiE3bmKVeTxF66Np5IzV/giEPftGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419574; c=relaxed/simple;
	bh=jkCdGKHrAXlnKoBbnYNWHuWXfPuaFC6iRVd5Bb2qsEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ844BlvjYEgNyOJC3+u69gQYTodXlKu9UM+Yl/kszbwm7S3tHK17N4q6HzM7n9U8CiFC2Njw7fO99MA/ysze5l19HTWJ2LycDtthSvXDDksE2ps69H+/DWbpZDaLlC0s7/3fETiOAktMlHPBSNiKvtj7pao0uQ9B6YXYr3j1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DJ3sZkK8; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DJ3sZkK8"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gvcf447Flz89sF;
	Tue,  7 Jul 2026 12:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783419564;
	bh=jkCdGKHrAXlnKoBbnYNWHuWXfPuaFC6iRVd5Bb2qsEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DJ3sZkK8Oky7YIl9PpZ2KwXVNtleOwy7M3f4PNM9hCdkzDk07KuIulKqUPkCQaeoP
	 HJVBo9G2t9fGhdSqOmzSirSICFLx4K3TBv6LfDUgEIe87idde//yr2NhNgdfkspuwU
	 oLyDOVDJun314gIq8gJ97gOGK6WgDakwTZck8itlzTntknesXvgrEDYs7d/1hceGLm
	 UkAYzrhAobtFIsSLaRwYSe9ut2t978gNJL6vVDc9xzHNPNszDpr9qdUErXXxeyDbvr
	 r7gOxrGrCl6+Q9aXwqfsQFbdMW9Zf2J/0xb2YPId9imyYNOsr+KSr0xO1X/qHyCRr0
	 r5ZeDTLwxfClQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gvcf43PVvz835F;
	Tue,  7 Jul 2026 12:19:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gvcf26VXyz8tZL;
	Tue,  7 Jul 2026 12:19:22 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D01AE60387;
	Tue,  7 Jul 2026 12:19:21 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
Date: Tue, 7 Jul 2026 12:19:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
 <2026062236-ludicrous-detached-6e20@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026062236-ludicrous-detached-6e20@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178341956224.4116813.1796060844406734301@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D01AE60387
X-NC-CID: t9z4NYfy/uCu+sY8wZzJbyURLwVE4ZPbCV0TuDrLPdGqwFYazFI=

[CCing a few people]

On 6/22/26 07:32, Greg KH wrote:
> On Fri, Jun 19, 2026 at 11:43:41AM +0200, Greg KH wrote:
>> On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
>>> Hi Stable Team! From the regressions point I think it might be nice to
>>> pick up the following changes for the next round of stable updates (e.g.
>>> 7.1.2), as they seem to fix regressions I've seen multiple people report
>>> with 7.1:
>>> [...]
>>> * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
>>> Blend)") [v7.1-post]
> 
> This doesn't apply to 7.1.y, and would need a working backport.
Just a quick status update twimc:

I pointed that out in
https://gitlab.freedesktop.org/drm/amd/-/work_items/5396 , but nothing
happened from the AMD side afaics. They have much on their plate, I
fully understand that, I guess it fell through the cracks (maybe this
mail helps). Thing is: the backport of the revert is quite big, so
nobody else (including me) did yet dare to submit it themselves.

So two weeks later the regression caused by e56e3cff2a1bb2
("drm/amd/display: Sync dcn42 with DC 3.2.373") [v7.1-rc1] is still
unfixed in 7.1.y as far as I can see it -- a regression that is known
since more than two months now, as the revert to fix it (12f58a6caad3be,
mentioned in the quote above) was submitted already on 2026-04-29, but
only made it to mainline during the merge window for 7.2 (this is
another thing that afaics fell through the cracks; sadly I only became
aware of the regression after 7.1 was out, otherwise I would have made
noise earlier to get it included in 7.1).

This all seems rather unfortunate.

Luckily is seems the KDE Plasma developer turned off support for the
color pipeline stuff in Kwin 6.7.1
(https://invent.kde.org/plasma/kwin/-/commit/9079a417b821f80c0d9e3bc5014a388e0e340f82
), which apparently avoids the problem for many users (see the
gitlab.freedesktop ticket linked earlier).

Ciao, Thorsten

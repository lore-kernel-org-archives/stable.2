Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56640B105
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925280; cv=none; b=U3Vy0MFwXPp/YGWpoRyFsUIJhgGxqad/X6XYQxPPfhZlCiGVKuBaHYZYjwPJ8tykFqBCukGJjfYASTfRsY4d/2K1n243ii0MB+pTiqks+PcHWWImY10QmxB6o6mRsAfTOSUoLNcyW8X+pmqEz/sAYpqBPDREhzC9mffJGgf9h8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925280; c=relaxed/simple;
	bh=i+snYksOmCncMv0JTq1UlNGvX1gSXaTihaQsnsUwq+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hRCLIb1FgY0qZRjqrQcafkbPA9ZwszFf0EeQQ+DsH8n9vQtJgauhq1oknJtHydyoVZD6VzMR33szRjksMtBy7OBJhMzNfn9mlMgK9tCN6IX/2+nD5E5jWYUUQU7Wz7UxabuNYl+nNhTA4V89LpLciTSy1za0kxbD8dqeVExwzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=G8nUtidv; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="G8nUtidv"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hx0QY3dHLz4MBT;
	Fri,  2 Oct 2026 09:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790925269;
	bh=i+snYksOmCncMv0JTq1UlNGvX1gSXaTihaQsnsUwq+8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=G8nUtidvBVFneYpd4JfsuQ8ecQbuNzJj3ITP+GyGFT79dji506Kr6tnjHYg4kRs9+
	 8LQyBk7AA1cArYtUuf/pNJ/EU2xjrbNxyNcnpq5C2G+jYIIXQXvT2rP7B0qbUZTTQ1
	 LRYZnB8VUkozanFjEDT+Uo/17OZrd4c9PHdiyindBGT73S1CajWmGvcdYm5XI8Dguz
	 g16zlKYgMxaw3aEd1SzaPiF51q3Zx4i+CncEAOp58xWeoqrfyQVypxrUhMKO4E7rzm
	 oaGvteem3ky19SbNsRhtrfSjcFZXbf7ddXhqNI6wmpF2fG0CCU/DXwzh8wiZ6PRbw6
	 xTxQ9wUUIKAOg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hx0QY2wHLz7xyL;
	Fri,  2 Oct 2026 09:14:29 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hx0QX4QSXz8sbC;
	Fri,  2 Oct 2026 09:14:28 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DA56A5F8CD;
	Fri,  2 Oct 2026 09:14:23 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <477e5184-a041-40af-8648-11e346ac55f9@leemhuis.info>
Date: Fri, 2 Oct 2026 09:14:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: screen will randomly display static
 on high refresh rates
To: solonovamax <solonovamax@12oclockpoint.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <9404c689-a95f-4475-a53a-47a724f6784f@12oclockpoint.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <9404c689-a95f-4475-a53a-47a724f6784f@12oclockpoint.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179092526417.2673927.11195834536261437204@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: DA56A5F8CD
X-NC-CID: Y1/Cj3rQNhW2yLTl1vBCk6i/khK/9bDAtiAEB/zxKykHgo/mnOk=

On 10/2/26 08:03, solonovamax wrote:
> 
> I'm experiencing an issue with my laptop where, when using a refresh rate above 60 Hz, periodically the screen will display static for a handful of frames before going back to normal.
> 
> There are no messages logged in dmesg when this occurs.
> 
> I bisected the issue to bf3fc94cd72abe6fc6cd88691fa98f817f4cd6db, although I'm not 100% confident that was the cause (on that commit, I observe slightly different behaviour. In addition to the full-screen static, there are also rendering issues that appear when some surfaces are being updated). The issue does not occur before this commit though.

Thx for the report. You want to check if latest 7.3 still shows the
issue. Then report it here:
https://gitlab.freedesktop.org/drm/amd/-/work_items

You might also want to look for earlier reports about a problem like
yours there.

Ciao, Thorsten
> My laptop's built-in screen has only 3 refresh rates: 60 Hz, 240 Hz, and 300 Hz. The issue occurs on 240 Hz and 300 Hz, however it seems that it occurs more often on 240 Hz.
> 
> Setting the amdgpu.dcdebugmask kernel parameter to 0x400 (disabling panel replay) causes the issue to no longer occur.
> 
> System details:
> * Laptop: TUXEDO InfinityBook Pro 15 Gen10 (AMD)
> * CPU: AMD Ryzen AI 9 HX 370
> * GPU: Integrated GPU (AMD Radeon 890M Graphics)
> * OS: Arch Linux for bisecting, I used stable/linux)
> * DE: KDE Plasma 6.7.5
> * Compositor: KWin (Wayland)
> 
> I'm also more than happy to compile any patches and test if they fix the issue.
> 
> I'm new to the kernel mailing lists, please let me know if there's something I'm doing incorrectly or any information that's missing.
> 
> Note: I have not tested this issue in 7.2.8 (only up to 7.2.7), however given that the files in question have not been modified between 7.2.7 and 7.2.8, I don't think doing so is necessary. (Though I can do so if requested)
> 
> See also: https://bbs.archlinux.org/viewtopic.php?pid=2311113
> 
> Here is the hex-encoded EDID data for the display:
> 
> 00ffffffffffff0009e55f0d000000002a220104b5211578077335a7544c
> 9c250e505400000001010101010101010101010101010101606c00a0a040
> 64603020660049ce1000001a000000000000000000000000000000000000
> 000000fe00424f45204e4a0a202020202020000000fc004e453135335144
> 4d2d4e5a320a020502032400e3058000e60605016a6a48741a0000035130
> f000006a486a482c01000000000000000000000000000000000000000000
> 000000000000000000000000000000000000000000000000000000000000
> 000000000000000000000000000000000000000000000000000000000000
> 000000000000000000000000000000ce7020790200220028bf2a1585ff09
> 9f002f001f003f06630005000500ffee1085ff099f002f001f003f066300
> 050005002b00122700782b0100270064ef00002700303b000021011ddf0c
> 0b08000a40068866fa53c8949851120e023554d05fd05f003813782e0006
> 404ed05fd05f250109bf2a15bf2a153c2c8100000000a790
> 
> #regzbot introduced: bf3fc94cd72abe6fc6cd88691fa98f817f4cd6db
> 


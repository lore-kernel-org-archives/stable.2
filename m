Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945230;
	b=EM1cuKybkjBIqy5AspXTtFyEDQeBAeOoDkCEhtKjtGa69MhDWZjGuOfACySiBubETopi
	 HPi8azR/5H9xlqa4k/yk2GeYPqSv2PC+9LOvb/q+C4xaROV74cS6f+6golLR9p6MgzWh0
	 9H7bOnL3p8ah+puUYiAiPlCABwTlH3JItYglS9dEt0eFehWAkiv93GmtCHl3ux9SUBgWP
	 Tpp7rPO0J23wvPwEJ0o7+js5DsgdEpql+s1EiU/pAUPD7lxbBcpuz3PWEGUAINCflmE9w
	 2jCrFugYvd5IkCpi9AYkqEbmEOUy4k/QwUHyRRZv24+8aejS3GlvoBrVqQRky24nxcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945230;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=PpzXraTFdyRxNfl8GcJ8XJ94FDh9H10NIgMltOxLU+k=;
	b=m9rKnUkYJIip1GB8sUohw4rgz3Y8CA9lLd8Hy8wiILNaJLBYlG04Fcg4ypqBQiTrPogt
	 DZyUx/ALy8smWpZH0NbeHZLBZIeS06rrjgMdRQBSu4B/3JrzSfo4pRo6mgICyMIjCU12h
	 LaeI2jeREg78/BXQBOxfSwkq0qWVRAOqnFk5sIdqH1mw5P9of3/EM51dRxedR5yWcjzVv
	 8KwA8vaIP4Po1pMGDHsRbp386eeH+epvW+eYHbLkp3p2oWkgxhnbqFoShc/HqEh/E1ZAI
	 44cofrtkyCzP6gOYTXkYptftbhaY5kRO4qTrpl5JcSR8lQXA1OfWz+pFUgLQSEZ0Fzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=CH7XbPI4;
	arc=none smtp.remote-ip=188.68.63.162
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13A606A331;
	Fri,  6 Nov 2026 06:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C13A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=CH7XbPI4
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4jLTGG3g1gz4VWL;
	Fri,  6 Nov 2026 07:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793945206;
	bh=U1P4pKnmVurL3i3GyV3nk4vKog5jxB64C210aaIiFYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CH7XbPI4AwC0QPZEFpWbp73vcR1zBzoIQuE1LXfXJW0rqD47ptWTWYpUJek1FOSwv
	 9x+1/B1u/3yJ8D+n15DVaXXCmmGC6vw3QU9TDNrG8cjNZdYbmZZjplyLR9MpmGTlmc
	 Oa0hP/TLfcdPnuKsT8JbHqvWUAohvO6S487/qU43XKdBOdqNTJjmni6LqwvZpcSLqh
	 I+3/wu7DtTH/rTDR1Pm1G+DI3/wjRjOIxclOtGW6b2bjF14EzveJhSXXpZa56FIrpH
	 5gNgkeyG+1Wyad/cHbSh7v4qNVCbJWhcSvgVkIb7qytdzYPwR4YTvJuJVCYznH1qat
	 KfDTurMp0dhuQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4jLTGG2xZCz4VVL;
	Fri,  6 Nov 2026 07:06:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jLTGF0vLtz8v3y;
	Fri,  6 Nov 2026 07:06:45 +0100 (CET)
Received: from [192.168.44.188] (unknown [185.238.219.126])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BD31D5FA2A;
	Fri,  6 Nov 2026 07:06:39 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 185.238.219.126) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.44.188]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <771d0a88-fc41-45b1-9792-2086f36c7618@leemhuis.info>
Date: Fri, 6 Nov 2026 07:06:38 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] media: em28xx: list_del corruption on dual-TS
 disconnect
To: Shantanu Sarkar <shantanu.connect58@gmail.com>,
 "Jiangong.Han" <jiangong.han@windriver.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Sikorski <sikorski.grzegorz@gmail.com>
References: 
 <CAK8Z4SCRhWcbL5i6NgwiLWDCX48YbMfcJ_+nFrGxKMZiN1vG3w@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAK8Z4SCRhWcbL5i6NgwiLWDCX48YbMfcJ_+nFrGxKMZiN1vG3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179394520047.537139.23515709434205249@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: BD31D5FA2A
X-NC-CID: Y6bQm04KuOl6PVdPAYNUggXJVzsqyXOuFRAcdEHdp5T3VYDm0Qs=

On 11/6/26 05:59, Shantanu Sarkar wrote:

> Commit 826915b6b65e ("media: em28xx: fix use-after-free of
> dev_next->devlist on disconnect"), merged for v7.3 and backported to
> stable, makes em28xx_close_extension() unconditionally do
> 
> if (dev->dev_next)
> list_del(&dev->dev_next->devlist);

From a very quick look this seems to be the problem that was reported
earlier; a fix is discussed here:

[PATCH] media: em28xx: fix NULL pointer dereference on disconnect of
dual-TS devices
https://lore.kernel.org/all/20261104052800.44551-1-sikorski.grzegorz@gmail.com/

If it's a different problem, please speak up.

Ciao, Thorsten

> On a dual-TS board whose secondary device is not audio-only (the
> normal DVB case), dev_next->devlist was never added to em28xx_devlist.
> em28xx_duplicate_dev() kmemdup()s the zero-allocated primary in
> em28xx_usb_probe() before request_modules() links the primary, so
> dev_next->devlist is {NULL, NULL}, and the list_del() on disconnect
> crashes. On current mainline (7.4.0-rc1, 05441d697f7f), with
> CONFIG_DEBUG_LIST=y:
> 
>   em28xx 5-1:0.244: Closing input extension
>   list_del corruption, ffff88810de88250->next is NULL
>   ------------[ cut here ]------------
>   kernel BUG at lib/list_debug.c:53!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 1 UID: 0 PID: 32 Comm: kworker/1:1 Not tainted 7.4.0-rc1 #1 PREEMPT(full)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    em28xx_close_extension+0x15a/0x390
>    em28xx_usb_disconnect+0x16b/0x2f0
>    usb_unbind_interface+0x295/0x9c0
>    device_release_driver_internal+0x48d/0x7d0
>    bus_remove_device+0x444/0x560
>    device_del+0x523/0x8f0
>    usb_disable_device+0x3d4/0x8d0
>    usb_disconnect+0x346/0x9a0
>    hub_event+0x1bd6/0x4d10
> 
> Reproducer: syzbot's C reproducer for the bug the commit fixes
> (https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c), with
> one byte changed so the emulated 2040:026d device (WinTV-dualHD
> 01595) exposes a DVB isoc endpoint 0x84 instead of the audio endpoint
> 0x83, i.e. in the memcpy of the extra endpoint descriptor:
> 
> -"\x83\x99\x35\x19\x1f"
> +"\x84\x99\x35\x19\x1f"
> 
> Results in QEMU (x86_64, syzbot's upstream config, 5 min per boot):
>   - tree at 826915b6b65e^ (before the commit):  no crash (3 of 3 boots)
>   - same tree with 826915b6b65e applied:         crash above (3 of 3)
>   - mainline 05441d697f7f (7.4.0-rc1):           crash above (2 of 2)
> The unmodified syzbot reproducer (audio-only secondary) is fixed by
> the commit, as intended. I have not tested real hardware or the stable
> backports (6.12.y, 6.18.y, 7.2.y, 7.3.y carry the same change).
> 
> How this was found: we were testing AI coding agents on old syzbot
> bugs, and an AI-assisted review of the candidate patches flagged this
> path; I then confirmed it with the reproducer above. No AI-written
> patch is included.
> 
> #regzbot introduced: 826915b6b65e
> 
> Thanks,
> Shantanu


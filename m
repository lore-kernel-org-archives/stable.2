Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.247.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792909724;
	b=EOsRXlvtv3U9ztvS1Y+C8xJs4utj5gJdq0JlCxQrDhr3odjJ7RAwEXwUhWhr63CsLQ2Q
	 IYv0tUy0nvAGOlaaXAbVlKKpOeBxq4Sx/ClD2+7/HC6+zGvFdYabr0kH5/psNqAS7Cp50
	 +6VcirOKLB3TXG9SBX/FF33fTS4/HRAJpfH7/YU+G8qrckV/wUtOXxfNySz4VRzSqrK3N
	 3tL1QFQbnKvj0yWnqAqlzQk0VjkGDYdSz2cfk4UY09d39wPKODKA0GBTfTeqeBmEoz8pV
	 krfB27HmnWyqd/ynRLDDU9KBfHsYAkhWXwtCxZsC7cJdiEyxRUNPfe13k3uhAtKUYxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792909724;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=td0xhLqxPtCtucyFvg5GGJAM6SWXYBLzBIie2ytR+m4=;
	b=mCh2moan8Tx7SmQu08HsYFP+sBfPmZmzPgBSwrhLiZyihlOgQIaDXV4HjEdnVmid7ZLy
	 AA2dpQKu0vqvIxbm2iuKFwwt6zZ9M1krDq6SMb3lFCGBgUiyKH1slLuzWhdDdlkjOLMlE
	 uphPVcmRP3gCsnKH37p/ZTGOioQoHoiQ+9oWdmK/I3h9uoRP7crd4+bEXAY0bxjLlCObI
	 QNKrW3Cqx5WxpnnKkmCq0hn+L1c+Mci22LQkTLuPQeOgNqnwRS36my+QTm2PJFpjOI5to
	 Agzce4Ibf/6xZA+IOFo2thF52XXoV8wng9GQFfHF/VUPGWoRE4AAFT0PN972qjjeeAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=frFK5+ms;
	arc=none smtp.remote-ip=46.38.247.119
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A93606A31B;
	Sun, 25 Oct 2026 06:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A93606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=frFK5+ms
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jC6Hh51R2z8Syy;
	Sun, 25 Oct 2026 07:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792909648;
	bh=K/ZiyT5YUeBIaU+YqvmFgcl0w/wbqgWGfHRcA8lzAbs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=frFK5+mszTLtKYe4LiOvJB98V72CxJS44G8+/UD/Z7dqUuNmBugzNcUQpGKlIanrE
	 BHqhsIV1E65NT95n6ZuHB/N269naiKlcNwa114IxMQnPJlxG7LusIOO+dB0nfkiA/T
	 ESXxaknvyoG8U5TMbJpneCeyjFndu9gDOEVCFiJKfQxAXvRgfCxEzvzMtE9S1eKM8q
	 AD7LVqEwVLzJzXZQ6iUQJtqcMZRXNrD+Iwcfq/LZONWICAsKsWXgB3yY+MTXGtV5gd
	 Pwfd1HTbjTLLxEhTYtv/wBic5zFmI1FXUwEBoS2zRaXviHUTRzoUR2esjBUJ1qNBYT
	 moFIvxJ4KWkmA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jC6Hh4JMLz4y38;
	Sun, 25 Oct 2026 07:27:28 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jC6Hg4896z8svZ;
	Sun, 25 Oct 2026 07:27:27 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 697425F9EA;
	Sun, 25 Oct 2026 07:27:19 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6299a7bd-a934-41b2-95f9-d68056551714@leemhuis.info>
Date: Sun, 25 Oct 2026 07:27:17 +0100
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
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org, Christoph Zwerschke <cito@online.de>
References: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
 <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>
 <2026102508-thicket-duration-c971@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026102508-thicket-duration-c971@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179290963998.1045469.17593029835196345954@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 697425F9EA
X-NC-CID: kYRygMnJtKhrCP37Qd34WBfYQr0f7InRGES5DgEHB1c/1Cl4eXg=

On 10/25/26 07:16, Greg Kroah-Hartman wrote:
> On Sat, Oct 24, 2026 at 04:10:59PM -0400, Sasha Levin wrote:
>>> I did meanwhile and agree, the backports of these should be reverted
>>> from 6.18.y and 6.12.y:
>>>
>>> * 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
>>> 8761CU") [v7.3-rc1]
>>> * 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
>>> 8761CU") [v7.3-rc1]
>>> * 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for RTL8761CUV")
>>> [v6.19-rc1]
>>
>> The stable trees match mainline here, so nothing is going into stable for
>> this. The fix has to come from the Bluetooth maintainers or Christoph: an
>> upstream revert of the ID commits, or a fallback to the ROM firmware when
>> rtl8761cu_fw.bin is missing. Stable will take either one for 7.2, 6.18 and
>> 6.12 through the normal Cc: stable route once it is in mainline.
>>
>> The other way out is on the distro side. rtl_bt/rtl8761cu_fw.bin has been in
>> linux-firmware since 20251111, so a newer firmware-realtek package fixes this
>> without any kernel change.
> 
> That's the simplest solution, any users hitting this should also upgrade
> that package as it's been out for almost a year now.
Feels wrong to me, as
Documentation/driver-api/firmware/firmware-usage-guidelines.rst says
"Users switching to a newer kernel should *not* have to install newer
firmware files to keep their hardware working.". So what those three
commits did in mainline even there could be considered a
mistake/regression. No worries, mistakes happen. And reverting it now in
mainline would do more damage than good. But overall it feels wrong to
bring that mistake over to older stable series.

Ciao, Thorsten

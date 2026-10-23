Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.247.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763044;
	b=oOdqJ1JsNk2GENcCqtuYloypL0sgXY5/XOwpss4/CVQjSfK49Pad3ZQITg+8QN8UwQCt
	 Xm13HpgN/mH+It9LNWpbeEdHPqJWQOkR2vgZF0rDDrnSj6lg31NV5+MYYGejO1jZ3Usmu
	 CIOjU1xZqpQRhX+EHg+Z6RD2CjBQHsy31jBQpuAuwhKzrAZBFb5Eip9UGXlb6W+CpOrFR
	 So2R9TDNH0TZUx/lBKvw9WA5zpVJqgS2jXDirKn1/1joQ3I1hWcyBnoLVunGzKzq1Zap0
	 TjZB4Lx2ZBFXMlTc0UYWqR+yYZfG6/qz9HJ5mHL5HTf5qvPegZ6mixsLjWyyAnJAhgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:
	 Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=omIBejW03o1DNuS224xHckdfC4Tdy12qkWWdcAx+ZRA=;
	b=NghStGe5PTU6CX/ZEAWxSV/RV1L0BsWPogGQWwU8PjaWtr2/DlMkvgcBY27iDxO+B2tf
	 GnJIqmJF6ttKsrJ8X/33PElw4FwMAeaANh2Z618bIsKWdaqMm4aDakbu/sQnMklpPIEbF
	 wsWQAaX9FJyg/aSwovCL1+WY2sqP6DTMjjUAW6GQjWdKSaihO2B8D/258GshAs/+WSIIQ
	 KiTupRRBzSezu6+x/ly28NSO0Hg1Bw1tbODMbhKwnW3512GoqeKU4ZbjTdKjpnFx4mbkE
	 kSCex6V+KbkIOpAOQwu8oXYmPEH10lVzN3rRB0Lw8KQnhK6U4YttojSdXO1UoJ859ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=e9E8bhqJ;
	arc=none smtp.remote-ip=46.38.247.119
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135E606A31D;
	Fri, 23 Oct 2026 13:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9135E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=e9E8bhqJ
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jB44C1mkmz8XSR;
	Fri, 23 Oct 2026 15:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792763035;
	bh=aJnx2yywdJOJQF24mLcAVe2DM4zti1C12vQFMGaGn9I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=e9E8bhqJu1VuJYY5NYn0RzJHYqHRfF79sCrlU2GeG1WXt0BTNWFKwZNtdn7Skj3aW
	 Jqd3z0I465OGaWDYNfYarCjIkxD9pO9WMzZWD3oP0/uEl6tOkrPtMJLOgt2ZGab8Vz
	 C7x1RRV9hXnOj+ceRk/9Fg8bhwOnl6WwvqWAA9ghgrbqBjRyyTsM8BBpCc9aQEx6AQ
	 Y4+XpeD9wjQ/f/dOSHf1VNWnTdQCuPZk2Gv4cs1dSPUmT61yFQIf+bylZ5KElHlqvx
	 GklPFb3Ktb09mPuteL06IngXnTlcwkOJD9h2S3Yl96x8y0NywAC3IRXen/9VLY51NR
	 EWPspOWHTqjxA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jB44C14HMz50KZ;
	Fri, 23 Oct 2026 15:43:55 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jB44B3wR3z8sb7;
	Fri, 23 Oct 2026 15:43:54 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 749E45F9FA;
	Fri, 23 Oct 2026 15:43:49 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
Date: Fri, 23 Oct 2026 15:43:43 +0200
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org, Christoph Zwerschke <cito@online.de>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
 <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
 <as0YtvgukA-Gp-D-@eldamar.lan>
 <3c931ea6-b325-4338-acdb-4f6eec9d204f@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <3c931ea6-b325-4338-acdb-4f6eec9d204f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179276303008.2712656.16619764390688834313@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 749E45F9FA
X-NC-CID: 807/fAhNKsBLJFRDt5Gz/wNt7qUMN9gCV3mu59yfQs7RpfFoo9Q=

On 10/13/26 11:03, Thorsten Leemhuis wrote:
> On 10/12/26 19:28, Salvatore Bonaccorso wrote:
>> On Mon, Oct 12, 2026 at 02:00:18PM +0200, Thorsten Leemhuis wrote:
>>> On 10/4/26 18:29, Sasha Levin wrote:
>>>>> In Debian Erik Brangs reported that after the update from 6.12.107 to
>>>>> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
>>>>> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
>>>>> anymore working, the full report is found at
>>>>> https://bugs.debian.org/1149377 .
>>>>> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found

This is still unresolved. Salvatore, Erik, and/or Christoph, could you
confirm my analyses below -- and if it is ask the stable team for the
reverts?

>>>> The stable code matches mainline. The failure is a missing firmware file:
>>>> rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
>>>> and Debian trixie's firmware-realtek 20250410-2 does not have it.
>>>>
>>>> Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
>>>> commit, send an upstream revert, or a fallback to ROM firmware when
>>>> rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
>>>> through the normal Cc: stable route once it is in mainline.
>>>
>>> Hmmm, that was a week (granted: with the LPC) ago and nothing happened.
>>> Anyone working on this?
>>>
>>> If not: Should we revert 980084de4d9b and its backports? Or only the
>>> backports to older stable series?
>>>
>>> Strictly speaking it should be the former due to our policies wrt to
>>> firmware -- but I guess most users of a more recent kernels also have a
>>> newer firmware, so I wonder if reverting the change might do more harm
>>> then good now.
>>
>> If my understanding is correct from a earlier fixed regression in the
>> ariea, aka
>> https://lore.kernel.org/regressions/0fd8c1c9-7f56-4bcb-a727-e4386d8ef094@online.de/

There Christoph asked "please revert them from every tree below 6.19" --
but they afaics were only reverted for 6.6 and earlier.

"Them" meant the backports of these:

* 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
8761CU") [v7.3-rc1]
* 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
8761CU") [v7.3-rc1]

Maybe because 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for
RTL8761CUV") was included in v6.18.53, v6.12.111. Which lead to the
current situation with "firmware file rtl_bt/rtl8761cu_fw not found" in
Debian.

>> should then not only 980084de4d9b ("Bluetooth: btusb: Add ASUS
>> USB-BT540 for Realtek 8761CU") be reverted, but as well along
>> 6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
>> 8761CU") and as well 4a23ce935f74 ("Bluetooth: btrtl: Add the support
>> for RTL8761CUV")?
>
> Maybe, I didn't look closer,

I did meanwhile and agree, the backports of these should be reverted
from 6.18.y and 6.12.y:

* 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
8761CU") [v7.3-rc1]
* 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
8761CU") [v7.3-rc1]
* 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for RTL8761CUV")
[v6.19-rc1]

At least if the problem wasn't resolved meanwhile, but that wasn't the
case afaics -- or did I miss it? Salvatore, Erik, or Christoph? Or was
it meanwhile agree on to fix this differently, for example by including
that file in a linux-firmware update maybe?
Ciao, Thorsten


 but that's why reverting in mainline likely
> really is a bad idea: it might cause a regression for users that depend
> on those changes (one of which is from 6.19).
> 
> So I guess reverting some or all of those backports in "older stable
> series", as Sasha suggested, might be the best -- but I guess it would
> be good if someone with more knowledge in this area could provide an
> opinion.



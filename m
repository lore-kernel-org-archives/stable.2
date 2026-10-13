Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55E3815E1;
	Tue, 13 Oct 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882241; cv=none; b=p9E3RyX8xJgc+oC6yQb+aKgOf7o0A8rj+cvPNrEgUU5G9fXvwf6JUE6z6gqO8MfNB/C2KXRDLdCwQ+I+C1gyAGt0d3ntqm1U+2IHhIeP2gmaXgfs5rZ1YCbwoj3z7/641+uWWLKie9ifVZSSxkQy5xSBcoc76uOw2JFTsE9SOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882241; c=relaxed/simple;
	bh=CoBD4zfp/8zMMlDxoaxdt4+171ruICpTPdof2Xq+EW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft/vZdzwRF1ACMF2i5dUS9W+DMLCNZqtY3qt/w1UvBz/EVvYEwa1dRz7RUpKHePnvv9l+nlrcM7wioF1XZy/9u56sQLJe9WWgDDhy1UROV/ljN1f29sLOy2y5w+4vgI6oq6Fl4bWoX40kr3ub1gAfPBQOhgxZngwO3hiXYJ3yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZzG7gY98; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZzG7gY98"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3pKT1mJ0z8Ly4;
	Tue, 13 Oct 2026 11:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791882221;
	bh=CoBD4zfp/8zMMlDxoaxdt4+171ruICpTPdof2Xq+EW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzG7gY98IEJLdDx5YzVpkTDxt+HEPCaXNb/uV9nCtICkvZEJi2lV/HaCCZ4n2QpkJ
	 qImDKUQY63EKdr4EnfcHjX4AEPm/YWgc7UMzRonW095kkioAJOKQGdNDI/J4zMAsDK
	 LreRyQq84j0wq5DAxqz9KuFjsEXIXlBPQjBWy224F650kWEz1Jb6+Re3iGQ+545EW0
	 Re22DsOwZelFmq9NA0raLWDgDI/OVNu+0JkIQEKMAcPyxDVnHcYM51PJ+9iLNjd0GY
	 ytd7eVI/l+vp6BzmZ9thITYa93NIjO+SRV2ZOosDMdjcMOfkJ7drSDcPx92wGL2K9K
	 oSFY+L0KxhYhA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3pKT13lyz4y15;
	Tue, 13 Oct 2026 11:03:41 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j3pKS4L8hz8tH6;
	Tue, 13 Oct 2026 11:03:40 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A69055F8EB;
	Tue, 13 Oct 2026 11:03:39 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <3c931ea6-b325-4338-acdb-4f6eec9d204f@leemhuis.info>
Date: Tue, 13 Oct 2026 11:03:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
 <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
 <as0YtvgukA-Gp-D-@eldamar.lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <as0YtvgukA-Gp-D-@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179188222016.3611723.6434990531770933847@mxe9fb.netcup.net>
X-NC-CID: ZI9MalgMdhi9eCT6ZzEScJGXOsO+xX+/G+BQntWa10F98EVZgtY=

On 10/12/26 19:28, Salvatore Bonaccorso wrote:
> On Mon, Oct 12, 2026 at 02:00:18PM +0200, Thorsten Leemhuis wrote:
>> On 10/4/26 18:29, Sasha Levin wrote:
>>>> In Debian Erik Brangs reported that after the update from 6.12.107 to
>>>> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
>>>> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
>>>> anymore working, the full report is found at
>>>> https://bugs.debian.org/1149377 .
>>>>
>>>> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found
>>>
>>> The stable code matches mainline. The failure is a missing firmware file:
>>> rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
>>> and Debian trixie's firmware-realtek 20250410-2 does not have it.
>>>
>>> Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
>>> commit, send an upstream revert, or a fallback to ROM firmware when
>>> rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
>>> through the normal Cc: stable route once it is in mainline.
>>
>> Hmmm, that was a week (granted: with the LPC) ago and nothing happened.
>> Anyone working on this?
>>
>> If not: Should we revert 980084de4d9b and its backports? Or only the
>> backports to older stable series?
>>
>> Strictly speaking it should be the former due to our policies wrt to
>> firmware -- but I guess most users of a more recent kernels also have a
>> newer firmware, so I wonder if reverting the change might do more harm
>> then good now.
> 
> If my understanding is correct from a earlier fixed regression in the
> ariea, aka
> https://lore.kernel.org/regressions/0fd8c1c9-7f56-4bcb-a727-e4386d8ef094@online.de/
> should then not only 980084de4d9b ("Bluetooth: btusb: Add ASUS
> USB-BT540 for Realtek 8761CU") be reverted, but as well along
> 6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
> 8761CU") and as well 4a23ce935f74 ("Bluetooth: btrtl: Add the support
> for RTL8761CUV")?
Maybe, I didn't look closer, but that's why reverting in mainline likely
really is a bad idea: it might cause a regression for users that depend
on those changes (one of which is from 6.19).

So I guess reverting some or all of those backports in "older stable
series", as Sasha suggested, might be the best -- but I guess it would
be good if someone with more knowledge in this area could provide an
opinion.

Ciao, Thorsten

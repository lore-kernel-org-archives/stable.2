Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0447ACF4;
	Tue, 13 Oct 2026 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859116; cv=none; b=pDnst835cX4REQrJy6GlJ81K7McOHHn6Vr/LYmDdoZ5KODbzYPywZqt2d3/b+oPZWgcF8Doi6KcOY/dMxH1+Kt+MVcSNRmKwSNDQL2RrYLsDkTbXve3opNu911l5ZT2ukbWtc2Fx3yNowcLqq3eckF3qyAud+wyh3qk6vs8yjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859116; c=relaxed/simple;
	bh=I3coorphk9JkdHrAoSg2U+w+wpGHjRGOgo1vR8YJqP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMYDPhXHov6ISJJmn7g/GmiSpiaZzzZvqkiAArE7je6MeTG/axjBYOwMD81IaJrU8dkGIhTNN13wYqlug9qSTU+G9uYIdqgaTeAWZdZq0UVxig1RmGadTIzQsie5urraUUvMnrqT73pU3V29rCsesrSKzzWzMvRP79p/7xLHmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ac00dbcc6af11f19a56ed5b684f684d-20261013
X-CID-CACHE: Type:Local,Time:202610131036+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e9b0ed25-595d-416b-b600-acb5362e38f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f6862183627acf49100bff84daa64240,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898|915,TC:nil,Content:0|15|52
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ac00dbcc6af11f19a56ed5b684f684d-20261013
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 112571573; Tue, 13 Oct 2026 10:38:26 +0800
Message-ID: <e7ba57f2-092e-4801-9659-7e7533f031c4@kylinos.cn>
Date: Tue, 13 Oct 2026 10:38:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd@realtek.com,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <ee122a12-eae8-40a6-bad9-086228ae76f2@birger-koblitz.de>
 <b56624e0-d1e4-4b52-9d3d-de923c471a58@kylinos.cn>
 <6030ce9b-1e93-4d11-b9f3-6101fec2229e@birger-koblitz.de>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <6030ce9b-1e93-4d11-b9f3-6101fec2229e@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/13 0:13, Birger Koblitz 写道:
> Hi Linmao,
>
> On 09/10/2026 9:18 am, Linmao Li wrote:
>
>> Hi Birger,
>>
>> Thanks for testing. Only the first BMSR read after link up returns the
>> latched value, so ethtool shows the problem only if nothing else reads
>> the PHY first. On my systems NetworkManager reads it right after
>> carrier up, so a later ethtool reports 1000Mb/s while NetworkManager
>> keeps the unknown speed it read.
>>
>> With an RTL8153B on v7.3-rc6, stopping NetworkManager was enough for
>> ethtool alone to show it after 3 of 3 USB rebinds:
>>
>>    # systemctl stop NetworkManager
>>    # (rebind the device, bring the interface up, wait for carrier)
>>    # ethtool <iface> | grep Speed
>>            Speed: Unknown!
>>    # ethtool <iface> | grep Speed
>>            Speed: 1000Mb/s
>>
>> I got the same result with cable replugs on a 6.6-based kernel. The
>> latch does not time out: the first ethtool still reported Unknown 3 s
>> after carrier up. On the 6.6-based system, the network service of a
>> Chromium-based browser also read the PHY first, so other tools may
>> need to be stopped too. I have not checked your setup and have not
>> tested an RTL8153A.
>
> Thanks for the explanation. I re-did the test and confirm that the fix 
> works. I tested on:
>
> RTL8157 (5GBit device, 2.5GBit link)
> driver: r8152
> version: 7.1.8+deb13-amd64
> firmware-version: rtl8157-1 v1 2026/01/01
>
> RTL8153A (1GBit device, 1GBit link)
> driver: r8152
> version: 7.1.8+deb13-amd64
> firmware-version: rtl8153a-4 v2 02/07/20
>
> both worked flawlessly. I tested
> - plug/unplug during normal operation
> - link-changes by peer in normal operation
> - plug or unplug during suspend, then resume
>
> Tested-by: Birger Koblitz <mail@birger-koblitz.de>
>
> Birger
Hi Birger,

Thanks a lot for testing both devices. Just to be sure, was it the v2
patch as posted, without other changes? The RTL8157 result is
interesting given Hayes's comment about the newer ICs.

The next version will probably change the approach, so I will only
keep your Tested-by if the code stays the same, and would be glad if
you could test it again.

Thanks,
Linmao

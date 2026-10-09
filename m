Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DB3D5253;
	Fri,  9 Oct 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530313; cv=none; b=nSZ6n9m2NUeCWRVN9RW+GEa8hMh08/Grn74JbSUoOnCx1RmkJegEnFAySM1531md/3rNiQkxbg5RuY3zPoO7wVofWycZoTaclSGXgSvgB55tz6ZO4svAL6dc9ko7Dz1u4Ck0g+5yhsF0VNvlsQ26GIcYKw4p1eD8LM7+Ux0IcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530313; c=relaxed/simple;
	bh=vIFFea0aaR5xqeEyw5iHuU2tPuyRuNzODNYqzV7MLyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuV38gHNwCxNPdmU9RkeeNfKMasEbLHb5WzIfbTO6Z51MYip+52Jqs4BlQ1LM+7NftYHu8MdEYjQoE9hcSo7Eop+bSFU6qLnjdroUKyl45Hy7mCcXiNrtzC1RyjuA7njNRRff8Y723k1Inek1Wtmn4naUeUeNUUXWSDu4KwVvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 97d0a1bac3b111f19a56ed5b684f684d-20261009
X-CID-CACHE: Type:Local,Time:202610091516+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:121b21a9-dffc-4080-b835-a6d43dc6e083,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:6ead2c12ab8a5df136f25aa15dcb250b,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898|915,TC:nil,Content:0|15|52
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 97d0a1bac3b111f19a56ed5b684f684d-20261009
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1712129514; Fri, 09 Oct 2026 15:18:14 +0800
Message-ID: <b56624e0-d1e4-4b52-9d3d-de923c471a58@kylinos.cn>
Date: Fri, 9 Oct 2026 15:18:10 +0800
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
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <ee122a12-eae8-40a6-bad9-086228ae76f2@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/6 2:32, Birger Koblitz 写道:
> Hi Linmao,
>
> On 05/10/2026 12:52 pm, Linmao Li wrote:
>> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
>> BMSR_LSTATUS can still be latched low when the carrier comes up.
>> Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the
>> network cable is not connected"), the first speed query after link up
>> can then report SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until
>> the next carrier change.
>>
>> Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
>> driver consumes the latched link down itself. If the first read still
>> reports link down, the next link-up notification triggers another read
>> and brings the carrier up.
>>
>> Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
>> replugs, the first read returned LSTATUS=0, a second link-up
>> notification came about 32 ms later, the second read returned
>> LSTATUS=1 and the carrier went up; NetworkManager reported 1000 Mb/s.
>> Runtime suspend/resume with the link up did not change the carrier.
>
> I have been trying to reproduce the issue with the following adapter:
> driver: r8152
> version: 7.1.8+deb13-amd64
> firmware-version: rtl8153a-4 v2 02/07/20
>
> But I am not able to do so. Both after a link-up after a plugin event 
> and after a system resume, ethtool always reports that the correct 
> link speed and state. Could you explain, what you actually do, 
> exactly? Or is the wrong link information only there for 32ms and I am 
> just too slow?
>
> Birger
Hi Birger,

Thanks for testing. Only the first BMSR read after link up returns the
latched value, so ethtool shows the problem only if nothing else reads
the PHY first. On my systems NetworkManager reads it right after
carrier up, so a later ethtool reports 1000Mb/s while NetworkManager
keeps the unknown speed it read.

With an RTL8153B on v7.3-rc6, stopping NetworkManager was enough for
ethtool alone to show it after 3 of 3 USB rebinds:

   # systemctl stop NetworkManager
   # (rebind the device, bring the interface up, wait for carrier)
   # ethtool <iface> | grep Speed
           Speed: Unknown!
   # ethtool <iface> | grep Speed
           Speed: 1000Mb/s

I got the same result with cable replugs on a 6.6-based kernel. The
latch does not time out: the first ethtool still reported Unknown 3 s
after carrier up. On the 6.6-based system, the network service of a
Chromium-based browser also read the PHY first, so other tools may
need to be stopped too. I have not checked your setup and have not
tested an RTL8153A.

Thanks,
Linmao

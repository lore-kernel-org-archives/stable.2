Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566B472074;
	Tue, 13 Oct 2026 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858996; cv=none; b=mG4vS3o0Cpek0WQXQfjzBmnDAZeoKu21+8eWftzX/7LStJtNbYjtSSwN926VRhIq1sAe8X4PD7PT3/Fg+vTyIqf9GH21usHtMQT84ad5Luqw4vbOhhet+KYYmvTww8uWK+2xw6PFHcnn/wP4EGX2o4JZOcMRgwarKI3bvaYZK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858996; c=relaxed/simple;
	bh=3kQcr4RJrMQs8PmG12XJIlM6t2rTn7kBgxGTi8l+NQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpD+AV9XJQ9+uesDowkTQQGKM9cDWcaH5WnwXkyVmBnqo3WOp8Ru4NmcsYsfFFQ2aP9FuuvF1JB+B5JzE2pmXCif3igyTQALcCTi0Y6DPsf8itw/0k96PYycmYVxHDK4OLX7GN6M0Q8f28TVgjVBUVvIPUIMfuzIuFN3dtPYNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1d5f5b2c6ae11f19a56ed5b684f684d-20261013
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2ff5db69-0338-421d-847e-741d6290ae67,IP:0,U
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
X-UUID: e1d5f5b2c6ae11f19a56ed5b684f684d-20261013
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 208549267; Tue, 13 Oct 2026 10:36:24 +0800
Message-ID: <c32ac5e1-ecbe-4857-b36f-cd0cb1f54f90@kylinos.cn>
Date: Tue, 13 Oct 2026 10:36:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Andrew Lunn <andrew@lunn.ch>, Hayes Wang <hayeswang@realtek.com>
Cc: Hayes Wang <hayeswang@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 nic_swsd <nic_swsd@realtek.com>, Birger Koblitz <mail@birger-koblitz.de>,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/9 20:22, Andrew Lunn 写道:
>> Hi Hayes, Andrew,
>>
>> Thanks. Since the newer ICs notify only when the link status changes,
>> the driver cannot rely on another link up notification after the link
>> has settled, so v2 can leave the carrier off when the first read
>> returns the latched link down.
>>
>> Before sending v3, which approach would you prefer? Both fixed the
>> problem in my tests on an RTL8153B with v7.3-rc6:
>>
>> a) Keep carrier detection on PLA_PHYSTATUS and read BMSR once before
>>     carrier on, only to clear the latch. This is the option I asked
>>     about on v1.
>>
>> b) Detect carrier from BMSR and read it again when the first read
>>     returns link down, as genphy_update_link() does in interrupt mode.
>>
>> Neither depends on another notification. Neither reports a short link
>> drop that recovers before the link work runs: with a) a later speed
>> query still sees the latched link down, with b) the latch is cleared.
>>
>> Hayes, for b): is BMSR_LSTATUS reliable as the carrier source on all
>> chips supported by r8152?
> Ideally we want a list of devices which correctly do notification on
> every change of link state, and which are broken.
>
> For those that work, read the BMSR once and report the down, and then
> later on the second event, report the up.
>
> For those devices which are broken, double read the BMSR.  The danger
> is, somebody who quickly unplugs and replugs the cable is not going to
> get the down notification. The dhcp client will not restart, so the
> old IP address will be used, for the next hour to day, and the network
> is broken.
>
>      Andrew
Hi Andrew,

Thanks. In tests on my RTL8153B, down and up notifications were about
3.1 s apart after a quick cable replug, and about 3.4 s apart after
ethtool -r. A double read should still report down if the link work
runs during that interval, but I have not verified this directly.
These results do not cover shorter link interruptions or other chips.

Since this fixes a regression for net and stable, would you accept a)
there, keeping PLA_PHYSTATUS and reading BMSR once before an off-to-on
carrier transition, and moving carrier detection to BMSR with per-chip
handling as a follow-up for net-next, once the chip behaviour is known?

Hayes, to build that list: which ICs notify only on link changes? And
on any of them, does reading BMSR, which clears the latched link down,
trigger another notification? The single read depends on that. Birger
tested v2 on an RTL8157 and an RTL8153A without problems, so it would
also help to know how the RTL8157 notifies.

Thanks,
Linmao

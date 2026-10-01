Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A211EB5CE;
	Thu,  1 Oct 2026 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820554; cv=none; b=ehy4lGFMf1LjzWRM9N6o4W6qv9rsg0nxSRL/rAwrBXiKLHgakRa3faHG/TGFLg+kSepfSidPfA+tqbMTXdZOn7h0JO4Y+2B8AHtLQCsu8kh3SIreRUBUr9/ipwj2xv+UkZjmXKYWFdznhPHHdmHVn0V9YawL2s5U6LpBn1EwsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820554; c=relaxed/simple;
	bh=IQlrvALK1b619WKc5XNjUWIb/3F6f8gyqfmpp6NtaQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+9L8XGIUJfFv5ejlfcLpPkyUjXnO/nzyZNUuR6Z2BtU1sVOgn9GCDu8H2KAyDI8bEVxGXk4cB3dYWK79qX9obwfYz44sfwVc/6kvTSc3s9bUSL0I7w/tHKhruqR6BECK9ijOfjhA0Avc74O/Dn5C8EtSecco2slemff/5M3afM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 131b125ebd3d11f19a56ed5b684f684d-20261001
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c0dfbf8d-2076-46b5-8c2d-59e547b0af6e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:2deb9fef9e9a6be7b3b863d346e90781,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 131b125ebd3d11f19a56ed5b684f684d-20261001
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1994764991; Thu, 01 Oct 2026 10:09:03 +0800
Message-ID: <0f0a9d6c-2a3d-4414-b5d8-c960085f0b3c@kylinos.cn>
Date: Thu, 1 Oct 2026 10:09:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mii: Fix unknown speed after link up
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xiangqian Zhang
 <zhangxiangqian@kylinos.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260930113842.2640928-1-lilinmao@kylinos.cn>
 <e31a9b2c-2f65-4767-b66a-85676d5a0d5c@lunn.ch>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <e31a9b2c-2f65-4767-b66a-85676d5a0d5c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/1 5:47, Andrew Lunn 写道:
> On Wed, Sep 30, 2026 at 07:38:42PM +0800, Linmao Li wrote:
>> mii_ethtool_get_link_ksettings() reads BMSR only once. Since
>> BMSR_LSTATUS is latched low, the first query after link up can
>> report SPEED_UNKNOWN even though the link is already up.
>>
>> This is seen with r8152, which detects carrier using a MAC register
>> without clearing the BMSR latch. NetworkManager can then keep
>> reporting 0 Mb/s until the next carrier change.
>>
>> Read BMSR twice to obtain the current link status, as mii_link_ok()
>> already does.
> There is a reason for this latch behaviour, so you should not ignore
> it. It ensures a link down is reported, even if it is for a short
> period.
>
> I suggest you change the code to detect link based on BMSR, not a MAC
> register. Better still, throw away all the mii code and port it to
> phylink. A lot of code will go away because phylink/phylib and PHY
> drivers will implement it.
Hi Andrew,

Thanks for the review.

The existing read in mii_ethtool_get_link_ksettings() already clears
the latch, but I understand your concern about preserving short
link-down events.

For a focused r8152 fix, would it be acceptable to read BMSR once
before netif_carrier_on(), only when set_carrier() is transitioning
from carrier off to on? This would retain the existing MAC-based
carrier detection and clear the latched status before announcing
link up.

Or would you prefer changing carrier detection itself to use BMSR?
Could a phylink conversion be handled separately?

Thanks,
Linmao

>
>      Andrew
>
> ---
> pw-bot: cr

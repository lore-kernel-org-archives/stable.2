Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51C41836E;
	Fri, 16 Oct 2026 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134970; cv=none; b=m0KVs0upO/TiZj0UzoOa30P8BQSBg2g1IPDya2cfLt6IB9ui3t2EHY+EZ3mubt7DlqoWvgZjD9m5nKegYbYRCJux49XX/HrFoTtex3NGi6td41etP8XmWffuV8JFsHJNlRDNbHFkWTwH/cnILZK8qBwVKf/E+6D8hYkfmL1dpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134970; c=relaxed/simple;
	bh=reMh8EImUs0mPoq7Sn7CI9WwCw+gKKbPUySGUxJmUWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLReJ/ghHr2euUtx4nRTjOcz3TD3BFLEsE7tHmpfiW/F2PwYCScTjTPWoZmw/PFk/S867I7P09IMzFxnIOIxImTMd4e+BOD9GuGRE1ZmQYD4PB11nqv+2lS3tDBr7VvtIyPQs8CdppjyhYJUewLkXNiz9eKs8hA2U9XkDxr/iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71d9c718c93111f19a56ed5b684f684d-20261016
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:adc9d3c2-c7d9-4237-8ddd-2956ea1e427c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c17ac3be8ee54d42ba4eb173530fc794,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898|915,TC:nil,Content:0|15|52
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71d9c718c93111f19a56ed5b684f684d-20261016
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2073871153; Fri, 16 Oct 2026 15:16:02 +0800
Message-ID: <cf64cf73-aa31-4a78-82c4-a9a6c866d7cf@kylinos.cn>
Date: Fri, 16 Oct 2026 15:15:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Andrew Lunn <andrew@lunn.ch>, Hayes Wang <hayeswang@realtek.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
 <16d9caec96e8449d88ac456e8512f08b@realtek.com>
 <06aaa778-ad49-4e30-b1c6-a7dc68718a21@lunn.ch>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <06aaa778-ad49-4e30-b1c6-a7dc68718a21@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/15 0:10, Andrew Lunn 写道:
>>> For those devices which are broken, double read the BMSR.  The danger is,
>>> somebody who quickly unplugs and replugs the cable is not going to get the
>>> down notification. The dhcp client will not restart, so the old IP address will be
>>> used, for the next hour to day, and the network is broken.
>> Could this actually happen?
>> I think it would take several seconds for the link to go down and then come back up.
>> Wouldn't this issue occur only if the link transitions from up to down and back up before the driver processes the link-down event?
> 802.3 thinks this can happen, otherwise why make it latch?
>
> If i'm just going from port 7 to port 8 of my switch, it might happen.
>
> Or i reconfigure my managed switch to change the port from one subnet
> to another subnet. The RJ45 is not moved, it is just a configuration
> change. The switch should do a down/up on its side to indicate
> something has changed, and that needs to be reported to userspace so
> dhcpcd gets a new IP address.
>
>         Andrew
Hi Andrew,

Agreed, my replug numbers do not rule out those cases.

Option a) addresses only the speed regression. It keeps the existing
PLA_PHYSTATUS carrier detection and does not improve reporting of
short link drops that recover before the link work runs.

I plan to post a) as v3 for net next week, keeping that scope
explicit. Please let me know if you see a problem with this approach.

Thanks,
Linmao

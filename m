Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814F3B058F;
	Fri,  9 Oct 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530190; cv=none; b=PdsZj4MEhZSYwTW8WX0HGUtMLjeIvdJCnWI3b8aJhytnRAb8xfLd9SLZCeUt7vxvbKoj+MP7ST5b0e+B3jjtXbarNkfOurorrykGOXX02HtDo2kMKIBS14WlX6KSIU0+NNfWOtrYXW+9KNEi9vtZxOBtk2qe7DtSr3nKMEYnAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530190; c=relaxed/simple;
	bh=yFIcK03YR1EPWOWpZUiTJf6yYh14EZJ8rlFVV/wG7Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czYdFdpHHAnL0czstmDeEDBCmXlMjYX0OiJo2t4KdvL+VhX7GNQoyNF3OT77k4mNPIHdOlXDIqN4hjNZ/5pLmbGj83i5A2KRRYyG3++3fzKvN6WLsdB/rjl9uBfMpDCvnZ2A7SgjfUArg9rPUL5IkFaJUhDKkNW+swipiDFyoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5225f02ac3b111f19a56ed5b684f684d-20261009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d97d8542-796d-4be6-a727-cafe12b21010,IP:0,U
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
X-UUID: 5225f02ac3b111f19a56ed5b684f684d-20261009
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 835964222; Fri, 09 Oct 2026 15:16:18 +0800
Message-ID: <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
Date: Fri, 9 Oct 2026 15:16:14 +0800
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
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/7 0:10, Andrew Lunn 写道:
> On Tue, Oct 06, 2026 at 08:28:21AM +0000, Hayes Wang wrote:
>> Linmao Li <lilinmao@kylinos.cn>
>>> Sent: Monday, October 5, 2026 6:53 PM
>> [...]
>>> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
>>> BMSR_LSTATUS can still be latched low when the carrier comes up.
>>> Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the network
>>> cable is not connected"), the first speed query after link up can then report
>>> SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until the next carrier
>>> change.
>>>
>>> Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
>>> driver consumes the latched link down itself. If the first read still reports link
>>> down, the next link-up notification triggers another read and brings the carrier
>>> up.
>>>
>>> Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
>>> replugs, the first read returned LSTATUS=0, a second link-up notification came
>>> about 32 ms later, the second read returned
>>> LSTATUS=1 and the carrier went up; NetworkManager reported 1000 Mb/s.
>>> Runtime suspend/resume with the link up did not change the carrier.
>> I think this patch may introduce a new issue.
>>
>> Our newer ICs do not generate periodic link-status notifications. They generate a
>> notification only when the link status changes. Therefore, with your patch, BMSR
>> will not be read a second time until the next link-status change.
> But the link status in BMSR does change.
>
> You read it once and get the latched value. That clears the latch, so
> the link status changes to the current version.
>
> Now, 802.3 C22 has no support for interrupts, that is a vendor
> extension. But if you are not generating an interrupt when BMSR
> changes, i would say that is broken.
>
> 	 Andrew
Hi Hayes, Andrew,

Thanks. Since the newer ICs notify only when the link status changes,
the driver cannot rely on another link up notification after the link
has settled, so v2 can leave the carrier off when the first read
returns the latched link down.

Before sending v3, which approach would you prefer? Both fixed the
problem in my tests on an RTL8153B with v7.3-rc6:

a) Keep carrier detection on PLA_PHYSTATUS and read BMSR once before
    carrier on, only to clear the latch. This is the option I asked
    about on v1.

b) Detect carrier from BMSR and read it again when the first read
    returns link down, as genphy_update_link() does in interrupt mode.

Neither depends on another notification. Neither reports a short link
drop that recovers before the link work runs: with a) a later speed
query still sees the latched link down, with b) the latch is cleared.

Hayes, for b): is BMSR_LSTATUS reliable as the carrier source on all
chips supported by r8152?

Thanks,
Linmao

pw-bot: cr

Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4648035B;
	Thu,  2 Jul 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996175; cv=none; b=BGTw8fE3tSdcjvNkyGYjzB/ikymNABsk99xpRKEwFTvLhVATcJY+WkD/2V9R6G8/dUJSumaKHDD6nYgrtsBSLWDOolcVGpwC9H4eRrQqDDiZQigKH6ZWuBvqENOKMZaltsgTi16U82aG3oJZ1K9YBLkimLMfAw+zcOSeksqll24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996175; c=relaxed/simple;
	bh=MgWRd4h+1ZvF37zSMm+H/b1FobMAkfbtnh54QFTkQ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXp2d8JhQ2MrHPbwc+i0h94nSoUGPL4RXAEEaLo55JjeFtoVL4Z4pq5CV81DoOTZP97uaE9HHBhqEKX55G2C/6u1r8siF7lv0kFeIyD4U1JnkmEozn/plLaUGgDlRJPaNzz+0Od9rGC7B8iO+9FQMANz9UWs1CFanTnhM4GircU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NsTgasIa; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NsTgasIa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782996168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OTB1A/EEfq3n6WQvgiifoOHUPAwpCie6I2ssPdTySVE=;
	b=NsTgasIaPhw7xUDJpGnjtVQGHfnXWfw9/uH61NLBWTUK5pbJATDM63V99/Yc+aCW0WglkwuACAGAWk/9dhZIr9NQ141aAfeKoJelkJNjzbE7wlxAzbVV3SFhvr6Os79TuuFdZVTvT1m9jKNGvPeUBjEMR43FqQa94sk/2ejV1Ro=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X6EmiYR_1782996167;
Received: from 30.221.145.62(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6EmiYR_1782996167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:42:48 +0800
Message-ID: <941afcdb-ee39-4649-901d-3c7a0d15b0f3@linux.alibaba.com>
Date: Thu, 2 Jul 2026 20:42:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and
 queue teardown
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, gregkh@linuxfoundation.org,
 skumar47@syr.edu, kumar.shivam43666@gmail.com, kbusch@kernel.org,
 dust.li@linux.alibaba.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
 <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/26 8:38 AM, Sasha Levin wrote:

> 
> Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
> Your 6.6 adaptation looks like it should carry over with minimal
> context changes.
> 

The 6.6 version can be applied cleanly for 6.1.y/5.15.y/5.10.y. And I 
just sent out those 3 patches :)

Thanks.

-- 
Philo


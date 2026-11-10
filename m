Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280342;
	b=X7Z+cSEYTv6PJgJ0UEMadXXgi9f5voSujdM6tFrrImDnGHVCn7fgpp7HBl9VzmrcbRku
	 LhPI0JEFbuGw/qImg4AdFRsisFJ9O0UphOqdx9MPwtyeBnP+d2QAEYzWQx2SZSf4E/Ygj
	 dXlhFxED+zoE1JbqKj+CvYsE1Qi82beFk32/l5ZragpXBGJvVMNrPWrKpKLKmYsHCxey7
	 ULLkMOzEXVjtUeF6VO/nySIKDT/6/owd0HyO9xOyrGsqxVVjwvVzDgbePqEXKHl9wupve
	 n0UIYY2ay1uBAV3Wy/Ts2bYhD4ReBS/ZzlCKMjk5C97tYq3Z37iOhMt89OhsKhL9UtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280342;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2v3JS1+37tp2y0d1uCztNRQ0OfftGDT7WHwoWOI5Js8=;
	b=lBQ6OW3X/eOXN4oK+0WHzj2T5GopkAvOZ7CVraYOHekRqyvMPNN5QqNCRZ/g39VNAYM0
	 EpBsaKxu19FS0SWED5ZIEItL1/DMa0g12t4x9S7Wk5cWsEIKYjD7/ZDob4Pl+AXxn3jqe
	 DraL64mYX5UfWLk6n8dsI2JUrDtcU/YTjaUDb+ndZ1WC62iOCzNuT4W81y7niV2AiJPXC
	 L5VCVUpiNtbBM0lYWVYMgMym0c+l1VTUlgC0MKEE+1I9P8QyP5oIHP2Nh+eDOqx4/bXCu
	 hhu/tNu40usUZ+qS0WC0Z/itWBHexVhwYsaF5dm0XJIyKA8/6uM9HJxZDrLeCYo5Psw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.121
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07592476|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.386135-0.0825521-0.531313;FP=2385524740461372419|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.k-dhHxf_1794280330;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.k-dhHxf_1794280330 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 11:12:10 +0800
Message-ID: <13c1ffd8-4483-4a6e-8781-25143e12e6ea@open-hieco.net>
Date: Tue, 10 Nov 2026 11:12:09 +0800
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
Subject: Re: FAILED: patch "[PATCH] hwmon: (k10temp) Stop matching Hygon
 devices" failed to apply to 6.6-stable tree
From: Lin Wang <wanglin@open-hieco.net>
To: Sasha Levin <sashal@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, Wanglinwl <wanglinwl@hygon.cn>
References: <20261107053014-failed-6.6-08e6615c909b@kernel.org>
 <c86128b4-1ead-4645-aaca-4f2584faba62@open-hieco.net>
Content-Language: en-US
In-Reply-To: <c86128b4-1ead-4645-aaca-4f2584faba62@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha, Guenter,

On 11/10/2026 9:19 AM, Lin Wang wrote:
>> The patch below does not apply to the 6.6-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to<stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following 
>> commands:
>>
>> git fetchhttps://git.kernel.org/pub/scm/linux/kernel/git/stable/ 
>> linux.git/ linux-6.6.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 08e6615c909b2504a5862764f3a7fca00c7ab066
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply- 
>> to'20261107053014-failed-6.6-08e6615c909b@kernel.org' --subject-prefix 
>> 'PATCH 6.6.y' 'HEAD^..'
> 
> Please skip 08e6615c909b ("hwmon: (k10temp) Stop matching Hygon
> devices") for 5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y and 6.18.y.
> 
> k10temp works on early Hygon platforms, including with the reworked
> AMD node code. Backporting this commit would remove working
> temperature monitoring.
> 
> The removal is part of separating Hygon support from the AMD NB/SMN
> code in mainline. These stable trees do not include that separation
> and should retain the existing support.

I missed 7.3.y in the list below. The same concern applies there:
early Hygon platforms still need the existing k10temp support.

Please exclude this commit from 7.3.y as well, or revert it if it is
already included.

Sorry for the omission.

Thanks,

Lin

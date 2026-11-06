Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997465;
	b=EXRYYigy7nFCVVJK4a5ZnOT7m8TDVUci8yUlSEEgObQVusqloaZNKIysmzZcye7Y/Wir
	 4yDKFjApIPhzZypn39zgPYKTO1JRWBwR9P0IxXkwytBVHV85XxRyh96wYiRSIgeAVAmxU
	 sp78r2rhJt5qogrvw24OwRE2lUsxdOrgt6Fjg2Xe1XnW4n0ggtVMc1GcmhnksCXVowAvk
	 C+kU48SzKgnnO6WfW1F21IbKH58KtOIuo0sA9pS+tRSBxYa68HvtVv8Yuufk7uyUdz6kE
	 pZ5Vaxnb9iRQmE/CrLL6SLzBciH6LNo8RU1ICihuUbxhGVQspVJnObMph6jF2vdMjNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997465;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=73dt1ns3WoQ1A4eVfdflZRp8nnX8v2Q1WwP7myyWitU=;
	b=TYjEQe+p4EfACe9Cvag/U9aD+k8S9OgXPEye514oQ2TYC7F6ab/OkR+oHQ1g9IFM0hIO
	 ckbKesz4MVXrb3ExB76kvtI95dDB2ls6XDV6T4g+hpkj17nU4PmG3/5OuAvDrPqxVMw5J
	 JOCFcqrdudtZS5IB90mxHTce0wQ43h78E9Hzga1TcJq8k2c5e3gP+8bDl7un1MBo1wNVv
	 ZnwrbnouBi/vqDTHVMyXHekScdqxTaeXfYqVLCYRX6ubENead6y4l12Dtd2FUbNgNLniN
	 HMjd6CcYQm24QRGjIuPj2BMipvXgY9XgskCNn+Te7LHVFYkRyWsXbAEkT2ZWtTCopjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF7606A326;
	Fri,  6 Nov 2026 20:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AF7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.25.222) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 6 Nov 2026
 23:37:34 +0300
Message-ID: <1b4d1203-4af9-469f-9c20-52dfda499916@auroraos.dev>
Date: Fri, 6 Nov 2026 23:37:34 +0300
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
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Don't log when of_clk_get() fails
 with -EPROBE_DEFER
To: Yao Zi <me@ziyao.cc>, Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner
	<heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Midgy BALON <midgy971@gmail.com>, Finley
 Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Kevin Hilman <khilman@linaro.org>, Caesar
 Wang <wxt@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261105001257.1368266-1-me@ziyao.cc>
 <20261105001257.1368266-3-me@ziyao.cc>
 <71b77625-8475-43da-a62b-983cf572229d@auroraos.dev> <au2UvnY0CdGTRnum@pie>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <au2UvnY0CdGTRnum@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 11/6/26 11:50 AM, Yao Zi wrote:

[...]

>>> Current error handling code considers -EPROBE_DEFER as hard errors,
>>> logs misleading dmesg like,
>>>
>>> rockchip-pm-domain ff600000.power-management:power-controller: power-domain: failed to get clk at index 0: -517
>>> rockchip-pm-domain ff600000.power-management:power-controller: failed to handle node power-domain: -517
>>>
>>> Use dev_err_probe() at the callsite of of_clk_get(), and check for -EPROBE_DEFER in places
>>> where its return value could propagate to.
>>
>>    To where?
> 
> rockchip_pm_add_one_domain, rockchip_pm_add_subdomain, and
> rockchip_pm_domain_probe. I think it's obvious in the diff and too
> detailed to the commit message, so didn't add them here.

   Ah, I was too hasty and misread the patch, sorry about that!

>>    And I didn't understand why you couldn't just call dev_err_probe() everywhere --
>> the error code seems to always be propagated...
> 
> This was what I originally wanted to do, but dev_err_probe() sets the
> deferred probe reason, and if we call it several times, the earlier and
> more specific messagess ("failed to get clk at index %d") get overridden
> by the later and less descriptive ones ("failed to handle subdomain node
> %pOFn"), which I think would make it harder to debug.

   Seeing it now, sorry again! :-)

>>> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
>>> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
>>> Signed-off-by: Yao Zi <me@ziyao.cc>
>>> Cc: stable@vger.kernel.org

   Not sure the patch qualifies for stable though...

[...]

MBR, Sergey


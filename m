Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364854707B;
	Sat, 26 Sep 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790411028; cv=none; b=s0uNydAOny9muDhMLJ6uu19ZEeewF4eRzEprZfpwPdVz78fPp9Pag1kO6NrOlsrnVjd6uKyOaaixvhiCHlLy6R8yK+/jTMGigV28MBSkq08DbMJwAKlWrTgafjLZ2F9ZSA/aBYyka4xiaE7t8qhvHHD0uw3k/Nh+CiySCP/TH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790411028; c=relaxed/simple;
	bh=VuoLgkqCDEe8dcGzSWCLH0K6KSzEtKKtX5GqvNNK9iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJLaQZZOQVWBaKBaEBLPmLUYzOLrwtWlZkshuiB76oL/Ot075sZvxuLXi4HQUIfehZvSDUA9N+v4qHWbru+9tiHaux5ph6f/eHhbOSjIFBalNb2OKWxdhlloMLCAIHCr0ERxzPbXQpklMXLKvyIxsp4vWgGEfXBBmiUyasUVSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hOrucROU; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hOrucROU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DmmflsCJs+O4XzU3h43GHEyo2nPD54EvzzNcB6z/E44=;
	b=hOrucROUvk7Az/fM59lAs7lVr4tq1vYJkMdKQXLuvRPHv1Qjbe+xavGHdkQ8E+
	esttqk3pnj1P64myVpFZ+E1UQ+b0xLHhFpFMMzGEwM5GiqggxlblnW5VvVSVaCX2
	wMk/3TXi92ppK4zmOvWmYLJaGYb2L75eWSyKM3PukW6HI=
Message-ID: <9ecf6f60-a2ab-4905-9ba6-011523684547@126.com>
Date: Sat, 26 Sep 2026 16:22:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: request the MDIO reset GPIO only once
To: Jakub Kicinski <kuba@kernel.org>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260921015727.2643540-1-xiaolinkui@126.com>
 <20260924093720.1aaa697e@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <20260924093720.1aaa697e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3NzuygLdqIQa8AA--.62328S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xtF13tw15Gry7CrW3Wrg_yoWxKFc_uw
	nF9r97Cr4DXrn3Cw1rur4aqa9F9rsrt3WqgF1SgF98K34kX3yxurs0yrnIyFW8WrnavFn8
	Jrn8t34fAws7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjc18PUUUUU==
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBPUq2q3gLNy3QAA3F

Hi Jakub,

On 2026/9/25 00:37, Jakub Kicinski wrote:
> On Mon, 21 Sep 2026 09:57:27 +0800 Linkui Xiao wrote:
>> +struct gpio_desc;
>>   struct stmmac_pcs;
>>   
>>   struct stmmac_resources {
>> @@ -287,6 +288,8 @@ struct stmmac_priv {
>>   
>>   	unsigned int pause_time;
>>   	struct mii_bus *mii;
>> +	struct gpio_desc *mdio_reset_gpio;
>> +	u32 mdio_reset_delays[3];
> 
> Someone already marked it as changes requested but also no need to
> forward declare structs unless first use is as function arguemnt.
Thanks for the review. I'll remove the forward declaration of
struct gpio_desc and include <linux/gpio/consumer.h> in stmmac.h
instead, since its first use is as a struct member.

I'll send v4 shortly.

Thanks,
Linkui


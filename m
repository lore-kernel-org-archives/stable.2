Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEF23BD02;
	Thu,  1 Oct 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845653; cv=none; b=Y1YiRxDUNZMXF4gflUO6JjLcGW5R40uhjqTuXHg5y7HsyHNiJ2pfvlhrkH74WMVkLXTDX6e7MKVt0oMXhrg4675LJgbVR8BbHfgRXJC512WaFUlspRmuiAcQ4h4+BlYEnMPoHMh1TCIS425fT7LRdZ+2WcoZ7Ea5jF5OjoAy9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845653; c=relaxed/simple;
	bh=DTAQziup/oIarQOW2copEqeYrhfmA0HoE9UIKAcn0KI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HU8Omzdq/9m0CibBMyrj6kTKLJmXdwVHz7hbYtsmgyqhl30B3vklz+mDE7lVzXeM2b8Kq5W9oZQtLTyfQpcmAIpWg9kgRiEUaJu7whwqZ4wc2m1Z9mocykDhhyiSYq4M6GeGSLSG/AfXa7NNFE9Q35MKV/3Lt3Y/LL0FCSRXVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=TI1ZT7Ve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6ZJsyFk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="TI1ZT7Ve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6ZJsyFk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BFD81400048;
	Thu,  1 Oct 2026 05:07:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 05:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790845650;
	 x=1790932050; bh=Obx3qv4P0/DtypWACVLfTv8l8niOWtVy5Y30TJxQ9Ao=; b=
	TI1ZT7VeT9IB1tNLlHmdYnAf1l6oJ3rGs7+bG3mSv0Uwb7g5alg2C/0LOOTw4VKe
	vCwpsZAuzbfNjCrd+tbAY2R1X5mU7oyTarO/CIHKmMPoTwooQvF0xK2+nWdUiv7Q
	qHVcy3uC7vFqHzLP7jF3mClq33lXp0FVCd+B8A+fBADKBoZRK5pQ1s9MreDWJH4F
	Va0LhDdM3xcPv1iX3ao+SeeR1SMlgDIXZ03NKFlyyq3mDbvylrRLFNFb0EQo4fVX
	PLzlrTmvLaF/nvoEoqoeWCVxSAQ/+0k3DhVT9rYRm4tPUiVTz/Xr5CgS+qD2O+qM
	RIq0iK37gcl7Zx3BBdGixA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790845650; x=
	1790932050; bh=Obx3qv4P0/DtypWACVLfTv8l8niOWtVy5Y30TJxQ9Ao=; b=q
	6ZJsyFkvxuOlO57m0bzahP/uoFOgD1bhOsaCFtAf7qJqBmSqs7EHGmmtucM9KfFw
	fjfUslZC1GdnAKajjrGBlIFzYkBu8BU2xN5K4ftcMS5TgVwTHztDbHy+QIhEFzov
	W1+EwYSgdYAszezqgRIaBRU3LxAsR6Ap8sFJX9imoV+ylz8pwrzzdomB8gMCHaWC
	CFQa5657MtatoWo+DqPd4zTHAZcjuxZiCxk6TATaxwl9T1opgmGvSDKPe8iZQ6tb
	J/K7FHzdlqIfm6kC4BCgH2l1aKFgbnSUFvOFWpBLuc7Sm/rFp+ba0kp5in75rOMD
	yi5HZGRHtAAZtMeN/nQFQ==
X-ME-Sender: <xms:0SK-aj3w6eqn5yHTlWAJ8dh_D7U-Vyq1vZjVyOa9kVyOlJScu7-e8Q>
    <xme:0SK-amBf2F8Bl7K1rfhrskpkYXMhcMqCpxPIZnLYOGm727L5ABJeTCuD5Sami89v0
    zim7NTXSUGrn8AFzzhtvDdefpiGaV5X5YCdFcKLN1BF8dMLZs6XS9w6>
X-ME-Received: <xmr:0SK-asYbDqpiBvIXE4Tq3xrPLqCYqoWoveQlUGPwtLcVHAB-TLJJJtr4s-ltX-0hrH_hDUxHRCLU-PLDLzcW5tXX>
X-ME-Proxy-Cause: dmFkZTFNKHa1tEzcbkT1o9dM42RBYjEqARiImiJoaiXXguSrsFowz9vv+XpWUUP2NSvQLG
    YiaRj38uvBc9moZw8KxMY4FPpZts1BgllbQw5it0MChKAy2bsiOJHtYusrCCWyKhOwHMW3
    C/mlU4nBoIr86k00MMXfRbwwQKkCfzlQ2duMeLPlAw3QLxY+cPeSdpstY1PRvM6m/HMzor
    Kmxuvf+jSHXR2py02Bidx9a0WWilIuWtQ/4WzHU/V0NyG0lUvDn3NCzNRXtoZ/AHjy5vth
    hmA/5fv2n6Wtc2JYCb4oiDOR8swQqZG7jx6gVT769YAKVVCjCKR1hhjUaO74SSPrEvP1Nn
    6H9T5KOwF2Vdas8ksximWcCJ15gileZQGgBIUP4JLQFVOWdrjzg3E+7j2dLNe5d2G9Cx0/
    Is++gE3kPt0Xu/7FLtgvDXPwzGdnlZlc/w8RM5EDNCt19pLBUcUrz/guOEryenNkHPHbYL
    qucOvnzvMXx7W5rAclgGpRnZ0HvOtdTk6AR5JkXsiXhA6jmpT93/JFzSxDI5es/ybtJY/Z
    stC6ZtneBSlxLrpmznWUyJymQristkGQ8ASCiHASf9BRWh4R2QiMnNnJHH9vZZg265Hfmj
    PSRIItfGaHgAtVZ0zsRKfRmdbH6Pgsucd6UeorMi4KYwwPabTraq8IYf1FWw
X-ME-Proxy: <xmx:0SK-aibIWdXmJJy_8zG3yMy4ApT7uXLy2jf7egysn9dqPhb2C9IU_g>
    <xmx:0SK-atmu3MZKYysiY6fxfzRsuA5mYz_0PbrTS2UnBVV4AcyUUYSMlA>
    <xmx:0SK-akR6Yk6hIvg17XYatXDyZ_ROvoA_6DnKMBTz7uCU0bC1K4J9ww>
    <xmx:0SK-aiVNaNiBAsABaQCHJbh3nlCFLdVXDXhMRH2w9RzlG9AR3LD7cQ>
    <xmx:0iK-arB-xWoqEg4IA-9mNtXfIalto2YqoJoDrBrFozrRAl74CpuaTsZA>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 05:07:24 -0400 (EDT)
Date: Thu, 01 Oct 2026 18:07:22 +0900 (JST)
Message-Id: <20261001.180722.1686004013398665163.tomo@flapping.org>
To: ukleinek@kernel.org
Cc: tomo@flapping.org, fustini@kernel.org, guoren@kernel.org,
 wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net,
 linux-riscv@lists.infradead.org, lossin@kernel.org,
 m.wilczynski@samsung.com, ojeda@kernel.org, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <ar38qq0q8f2Vecuw@monoceros>
References: <arz487DLBlaBrWLN@monoceros>
	<20261001.070215.521963012921142699.tomo@flapping.org>
	<ar38qq0q8f2Vecuw@monoceros>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Oct 2026 08:27:45 +0200
Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:

>> > Can't we do better than that? For C code the right thing to do is =
to use
>> > one of the div helpers instead of a plain / for types bigger than =
long.
>> =

>> Indeed. Rust code already uses some div helpers. However, the kernel=

>> crate does not have Rust wrappers for the helpers this driver needs,=

>> such as mul_u64_u64_div_u64(), so we need to add them first. The
>> changes would be too large for stable.
>> =

>> So how about merging this as a fix? I will work on patches to use di=
v
>> helpers in the driver.
> =

> Fine, then let me just wonder about the expression you chose, that ma=
kes
> it look as if 64BIT was only needed for COMPILE_TEST.
> =

> How about making this
> =

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 729776086879..4cc2911a0673 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -774,6 +774,7 @@ config PWM_TH1520
>  	tristate "TH1520 PWM support"
>  	depends on ARCH_THEAD || COMPILE_TEST
>  	depends on RUST
> +	depends on 64BIT # no 64bit division available on 32 bit builds
>  	depends on HAS_IOMEM && COMMON_CLK
>  	select RUST_PWM_ABSTRACTIONS
>  	help
> =

> instead?

Yeah, it's cleaner.


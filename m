Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7B38D3F8
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257132; cv=pass; b=WpjR4UvVJBxlseYwqOSe6+25MPbvxXDkBtyeHZElr/Rlol3LD30gOy/frPvz3YGmXpXiITKmwgDXEfZuCGMJ3N5c+OKvG1hEqDum4vCoHgR5PAQcFxkw2Nm//Wnh22BiWOxX+6dpKWJqGAMqrIAxmctYpKNvHC3sUH+MKikdAwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257132; c=relaxed/simple;
	bh=0g4WUdTKfLucYlvjr9hlWVI0vIpzcaIiEfJ9AzEw6rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0nAQGFch2gGG367dvoQXjf/plXp3hPrutVGDiccjwGaZVVLQ7dzY4E0HpuhGnlMzidkhGFKpat2qgCr4Rf1eH7+zTkECLMggyjFSc4V7VBRyoERZCdgDdZL5o2riQm3JfsNSFi2/VGi1s8DP4SD8ONNyLGoEyHqrLukOyGdOTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oOqJAI6J; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YFFbZ+xv; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oOqJAI6J";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YFFbZ+xv"
ARC-Seal: i=1; a=rsa-sha256; t=1785257121; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rt3FYoHBRdMdgkVd/VAW6rWytBhdiu9OfZqerAKjFyZDNzzY073LhvSKSf44S5ucTD
    nKOVGxEqXxeX61AmkfaIJo/y5GB9jM874D/gecDBY35VdKUjEzp/oNHR7X/VV2aw7858
    5oWrnSHUcGmFwWo/dfN2/DlW2I7piphw+EdL3V4TimWvN6Ljl+Gr/HBbDcMlhMTRAlS+
    w4lwifiZEnAlGEVNHS5c8CNYoZWzdjX+d+Oh/v/nZ4aAzvJbIjZeFU5qMUVxkPveNskM
    hPjy6eWjgMGAIQc/oc12OBJw7sDYa8zU1hN0l79Dsr/gdYTjSSkT/8LrAVoyXiTh1bUr
    pTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785257121;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DPq/iJim5CekAVahRpDGH32vHXQBNqWG9JKNDv41VVw=;
    b=FiPk4Y64FRR6gPJ/xTbMhXe2Ukz0MWf64wLhH8nupvJHK4lzgT6UQ72HlM32k6JnKs
    BYoYaNsYtLEh9lwgF26pYkLXfrPwS7rfcAbjjCFSane6aw68mPr0ZiU/GBM1d5xlfPbb
    C5l9t0wDQycn1Wg4RKdH6oTyC5JIVxFQQracFzFCbuDjZnrD8u0ylADzWCdmkrMHQRTR
    1udbQJ+/icLAv6Oln2u3B7mBZGIow5d45M0I59liKjdNO7VHNUFoPli7flOz0clKRR+g
    lbXjvY+TSSOY46NWoG6zB1K0Q4Jg25MJFyrD7Hjy1rKxuN3RyWy9fSJK+HwkZzYBfCR9
    OQfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785257121;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DPq/iJim5CekAVahRpDGH32vHXQBNqWG9JKNDv41VVw=;
    b=oOqJAI6Jjux3V0jki7Yn/ImHNwvG3FjbDaLaAnuOsAyf3Vt3ZURocnRAfevYo0G1Jv
    ffO1WpY13gioU/7upPcXf0NUNBetvczXVR1EK7pN9gsZE9Vwdz5mRJeNveM/TP2bFz/m
    oTWObKlJopU16VXXqQfQ+SnlQ8TByJyeF0yoAj/tJAPBvtZ6A0HoFz0avLpBXqWFQ/Xa
    WxA/slGB1/kuOAu+HLWEHAuqP14tSk/HhTnL7HbjKvfgvv9MhENbmxPwayoq4E+PwAtR
    2oLDwC5v5vkogkMDw8Y1FjqU8312IHlA3xLD0ZBPxSQmDbOEp2QdOwJ2LX2rPZoOZoxF
    +61w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785257121;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DPq/iJim5CekAVahRpDGH32vHXQBNqWG9JKNDv41VVw=;
    b=YFFbZ+xvxsXpyrjDhnB/jZBjb8mlbcYmUZ8eExk4sQv2i2oUW7U7AxNDgBmOUBiwXa
    rf+c5qNCyZH6hLBzOHBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926SGjLNIe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 18:45:21 +0200 (CEST)
Message-ID: <2d85c6c2-fe50-4aee-b230-cc2dd2060296@hartkopp.net>
Date: Tue, 28 Jul 2026 18:45:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/9] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260724101342.16000-1-socketcan@hartkopp.net>
 <20260728155654.stable-0002@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260728155654.stable-0002@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.07.26 18:09, Sasha Levin wrote:
>> -		sprintf(bo->procname, "%lu", sock_i_ino(sk));
>> +		sprintf(bo->procname, "%llu", sock_i_ino(sk));
> 
> This hunk is not part of 68973f9db761 ("can: bcm: defer rx_op deallocation
> to workqueue to fix thrtimer UAF").  It belongs to 0fe27e598592 ("net:
> change sock.sk_ino and sock_i_ino() to u64"), which is not in 5.10.y -
> sock_i_ino() still returns unsigned long there.  The result is a -Wformat
> warning (a hard build failure under CONFIG_WERROR) and, on 32-bit arches, a
> /proc/net/can-bcm/ file name built partly out of adjacent stack.
> 
> Patches 2/9 to 9/9 look fine on both 5.10.y and 5.15.y.  Could you respin
> 1/9 without that hunk?  I'll take the full series once it's in.
> 

[PATCH 5.10.y v2 1/9] can: bcm: defer rx_op deallocation to workqueue to 
fix thrtimer UAF

without the "%llu" hunk is here:

https://lore.kernel.org/stable/20260728163902.24067-1-socketcan@hartkopp.net/

Many thanks!
Oliver


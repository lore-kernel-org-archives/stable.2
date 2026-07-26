Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BA2DB7AE
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095133; cv=pass; b=Rcb7AwvrgKt1j7ONd1Z1On62fyNwSSZtTuWavEQJJlBEwKzP6stt2Ycl5TFzKE2qobT6nuBkYuzA30ACz9+G1DK91ms/qu1NH8sxtCNub1y0N+9CmGtoW7kLxZxtdLpXfP+hTQ8DRuhP7VgulWqjGCUc53S2NKwSMY+RV2Y6+Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095133; c=relaxed/simple;
	bh=t37LLRxVmxoTXXp/ZXoIiRtHquDeIr5GCoq2k8yksBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxTvh0uPKLQrKN+S271t8w7sw4RHp6dXJ9ct2ZNPF0VCwYQ6WW5sqqhbYarYJAcVIerObHqDARxYYG+ssFj4jV0hwr0VCNRqy6zpLDoiOaOG8/Bl5xQ7hniz0GD1NMtzlgQh2MjWfJy0yuXgTlFUgsoKJLLoivWHoIN16gdVI6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DVBLuJeo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Xc56SN4a; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DVBLuJeo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Xc56SN4a"
ARC-Seal: i=1; a=rsa-sha256; t=1785095116; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nITydkzRLA4Akn3E1Y4MiO8RlHNRaFi38BO9LaobmNWJH9+6bTq1M8X5tbcsDFEha3
    9tg1wD/61tOfCjNQjJbPfulQuzFl3xPpdlcbG56BkOfSJpNLRxeZnrXj1BbACUg6AOMo
    95RU1L1k0r7jMVsno2SkkP+X5F13dzjtIh0nViMTiOqLr+91oshiYvM3fO6zGSxMHmpZ
    QV9c519RLpt2S97jgtYgDRDdcHTBqg1DrlLnZeekvxp+Qi/+2Fjftr1axvdigmxagu49
    DomvjzpESNncY/iigj83IB6G0D7V4jIymctXKnIQCry8kpNDEiN04CeObUliGjGxFdwI
    QB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785095116;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4Hm41xLHH/6KQ5QkL+8Q6xHqskD+n6OFKelYxp62mI=;
    b=qlNNTYVnRVrMIxlDBIqULUSbnIMstoPhoT96aIlNVTGAUq56E8tGA+vvKsypBQVS75
    nMbIUX4clvFiz6PUYbWjXZlYck7nkhzbXqxcSS2ouENnWm2Y1SwJ2KyilFM7LWgb3UzF
    HAKnAtijW++5/IcnERQtcBS42h05WQsB3LBVqcVk5mXumPFgdvdyvVZmB/c8h8gzHy4N
    7kS5GhBxY/WqcqHNH+6KQpibhjKmXXq0ib/wRguRMX2FJVqsDy019m6YHuberXor4k9b
    8VuNpaaQwbcNobGWW9kjLNZu6OPfYAcCC6tC0USVIJy81vx6cPmQnI3q4wFXjSCXIRDe
    gxgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785095116;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4Hm41xLHH/6KQ5QkL+8Q6xHqskD+n6OFKelYxp62mI=;
    b=DVBLuJeoCsbrx9geIJlCkGCs07GumtrjbmKzIMtk73VCQicrbQ1Ru+wV1SU2GaiGC9
    BUhqKTRVQ1ZqZiKgIOCynh+uG/qH1Vlo4OIOiO/YpibPI+XLSv3EA2S6PF1sDbwjYUBi
    co2eQH3kvgi8wXhRcrk85TUT6niQKhevgLerMV1CGYb7MV4ugXQItfPzagmLQjmVAbjf
    LTRUBErXkWPCB5xuKums+VJGCKgASlhV19IzpGghyn1mXSqef6JYGrgOsIXr5TWGoLfx
    daEnFG+u4AmpNDd5X9N0WZWwoLa/1cYgSk/LljfGjfXvkNp9KviTqctOsdk7/l4R/RPh
    JE8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785095116;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4Hm41xLHH/6KQ5QkL+8Q6xHqskD+n6OFKelYxp62mI=;
    b=Xc56SN4aweqhLrw/5r4FzJjlc/WsbkKlSQ6//J7ySEagUcGinEyp0fM1a+JwjHr9ah
    TYUGim6aOdg4vmR2QlAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926QJjG67G
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 26 Jul 2026 21:45:16 +0200 (CEST)
Message-ID: <918a5842-9649-4c13-9291-f06fb3fa2910@hartkopp.net>
Date: Sun, 26 Jul 2026 21:45:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-4-mkl@pengutronix.de>
 <0f3b44bc-41bd-446a-bceb-bb2c9581ee6b@hartkopp.net>
 <2026072653-handheld-reliable-4a78@gregkh>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026072653-handheld-reliable-4a78@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.07.26 13:17, Greg KH wrote:
> On Sun, Jul 26, 2026 at 10:08:52AM +0200, Oliver Hartkopp wrote:
>> Upstream commit 1e5185c090589f4146d728ab36417d8a5419f127
>>
>> is missing in stable.
> 
> Which stable?  And why wasn't this tagged for stable inclusion to start
> with?

This patch fixes commit 890e5198a6e5b238627c245fafea1a92670a86cd ("can: 
raw: use bitfields to store flags in struct raw_sock") introduced in 6.18:

$ git tag --contains 890e5198a6e5b238627c245fafea1a92670a86cd | head -1
v6.18

So it would be needed for 6.18 and never.

I thought the tag

Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct 
raw_sock")

would automatically tag this patch for stable with AUTOSEL.

Unfortunately there was no Cc: stable in the commit message. No idea why.

Best regards,
Oliver

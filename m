Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792624987;
	b=G/uaaxNWD2ylffCzSR3Rqz37wkA63tM9BBvHhOHHn3Xs4AiHJ/Ld5dBX0s/oZJ3YbP46
	 Ex17cXkoIGLFIrEHKbcNtuP1sB95xtRyi8d7MvOt6caXAfVEy4O1ZQuw2ai5/jW486hOy
	 T7Trp8IrF0l851sGdLU9HOesyQBXa/fpvlW6QEMFwQ5JBFypSXNBLnC7DcHZjlMITMLu8
	 asbvyOnIXlxcpEjEm8eBWlrdpPgkd6fjmKKNdDKoRWPpWlOVmj8Rt4lzfBKVehwQkEorW
	 BFVNNkm6I7NcGIuPoDvtnXHwp73C+M+xJ7AWSB88aldG+gy5uioTtlkTY7ehk4rLOVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624987;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2kqJEOUpU2gskRJFc634G/d1nlDL62VkmIjkDq7ivdk=;
	b=RV1zuHbmtFV95+Wss4VkwqURUcrHZiLGlGPmBVJTsJx6SC0A4obfl5e+GjcUb9nuuPB1
	 YbVRx1er3Pgvi3SPDlMqLagX7BeELPLjwg8ngqsfjI6Vo5T2S/pMOrwLP7s6xotqQ6A0g
	 a0mPXXdX6QtbN/1HJqfHJshVIYRyqxo3JbByKvEcQLlqKupbpfsZyCNnhgpTBXZCtBdAD
	 qn8j65e8Qq5uMGMeQQGM07JTmRIC6MyW3zKLux7N5ch9cy1j/+N0TdMP3Lqh8x9UZ1dx3
	 OycLmcNi5PyXAxM5lgX61gU1P4IvEMG3kyGyOKp8eUsxfwfpWyZcktBBjuDlCfW1XzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TphEDy+Y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Qvgrfbx5;
	arc=fail smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA788606A31B;
	Wed, 21 Oct 2026 23:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA788606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TphEDy+Y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Qvgrfbx5
ARC-Seal: i=1; a=rsa-sha256; t=1792624970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JbcOg56Ojz7+QF4s32vva/dkMKHveiD7CN0hFcxTsD2Jnz7Qz/5FtMswg1zlkI/MWd
    DFDDQXS7EjmQGYyKcPqMhIgU9mXpWGnWJAfRhtvz/YzvBgNS28vbplJlOiFRHS+ChDoY
    +qL1T6P1EdvrQWJkQ4KkhtoaHsQ9eEGaPckAxo5LX23NbhbdhPe/SgKS3l49HuHRIA8E
    8YoEGLfxcJUWhgAkgwwRQf25v6jcjsW8do5UfGXkMOs+5ZySjUN8Ye1Z7/WHQTBj71E5
    6jnmXMqVwJJu1eZTfcK5A99Ynr2+NHcZXYKF2iSKnrryaM5titGg5/80qsA/W0t+8wsi
    mFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792624970;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2kqJEOUpU2gskRJFc634G/d1nlDL62VkmIjkDq7ivdk=;
    b=tkeopCfadVRFFbVQDwXbmYOkgKhLuPWBXZKNtvvTkdu8BruVU8ctuNu/ivFQgfqqHP
    +fuPSi0dCuhaz8trc6lbgHzBLC3uGa6kUVEKdVpzlmxVE31gcw1FMe2Wo+iFQBMloguh
    zVB0bH6tO9vdpUgBSnODnx/vD6tWXXBv6+Lwcwsg4gdkjsksR7yqbrO4FqxbF+EbQ6hV
    qquLxlGXKJ+bWOnxq2RzZH8aFjcfQh55LL2sr6zGxeQSnFFj9JC7rkjcjsEK6caksh18
    4DN5+ntCZsLfG5UY7zzqH0+vqs8lgN3zOz5v9Nh4do9vfpCr7hRlyr/BwFMqRniXllmP
    uW3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792624970;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2kqJEOUpU2gskRJFc634G/d1nlDL62VkmIjkDq7ivdk=;
    b=TphEDy+YR2BM8q4IFhBaaEgPHyX6W+Q7dZMYTiAPdwARmgj8rI7AM/+1RY3+KxJWc4
    W1KgICUXkMuoFRRlvpsR6DZzaQOteVbZfJKH+g9TgnrIfYvwkj8PThLUmfDRyoOEDymI
    vOpKry6wkRbNkM+aTqotAZUt45paACqWWKbvWYujsIAcrTXghW3Q6mTk5aGc9BdrTH9O
    5frpJe85/c+g0srLIVR5+w86Jhv2jF9agVAVChM4sKfPH5J+mcfzlIhZf0OH3F+iy5gS
    wMSY6FBJWHXi8Ix2WgyxisoISNmLhb2mws6UR0gtRJssfdWHrixnF7V62/3d+/u4znPu
    ziDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792624970;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2kqJEOUpU2gskRJFc634G/d1nlDL62VkmIjkDq7ivdk=;
    b=Qvgrfbx57mPyWVTlvMMHVAdvrdza+kwOrXBGsE3FhtV16mY0QNaWVONdftqt+uZQRO
    F+LrTDROiW+C58avu4Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29LNMnlE0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 01:22:49 +0200 (CEST)
Message-ID: <1b72ac61-e703-4b9c-96e1-f5c197956f3a@hartkopp.net>
Date: Thu, 22 Oct 2026 01:22:49 +0200
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
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, runyu.xiao@seu.edu.cn, stable@vger.kernel.org
References: <20261021102756.1900679-12-mkl@pengutronix.de>
 <20261021205534.1620083-1-kuba@kernel.org>
 <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>
 <20261021-refined-free-wapiti-c46445-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261021-refined-free-wapiti-c46445-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.10.26 01:05, Marc Kleine-Budde wrote:
> On 21.10.2026 23:59:17, Oliver Hartkopp wrote:
> [...]>
>> is a good hint from sashiko-bot and follows the raw_bind() concept.
>> @Jakub: I've sent a V6 only for this single patch 11/11 here:
>>
>> Is this ok for you? I think Marc is offline and can not re-spin the PR right
>> now.
>>
>> https://lore.kernel.org/netdev/20261021215456.119268-1-socketcan@hartkopp.net/
> 
> Give me a sec, I'm preparing the new PR.
> 
> Marc
> 
Thanks Marc!

PR can-next 2026-10-22 is here:

https://lore.kernel.org/netdev/20261021231130.2085690-1-mkl@pengutronix.de/

Many thanks,
Oliver

Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D13B83E0;
	Fri, 16 Oct 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150852; cv=pass; b=chtk8M5WU62CYfC9UlL7ebklyw/HSxkh4RsCBKcye0J4r3jV3WZeeyM9xiwzlDQsCVfb6dU8V7RnY4p/pMBV4f8uxbNEKpcH6xR9LKxf3MgY+caLEQ7nQNrc0Ge2413Au+jNWYGv8XDIYNWYtNzCBVMoSpU8DoJLmzfyxMn08yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150852; c=relaxed/simple;
	bh=xYWPp7YU6hM2jzcaUYObQXDD9gDbxG7J/UBgh0niR7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxSk9L89wywtBtWShRmvICUBYRw5mIY8/ZkH6V3UP/WjJD+ZYkEsGoIVfkAGCqJIOFWQBEs9vWxqbpCAP74HntYzc/F//XrtTycWXwDS7j3V5MAAxG8KCIZ46I+GI+exLnRYdotB5X1xTC5x6BRO1BjQqJ9NNeLW28herPacL2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XYBdsPxO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4C6e0ELd; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XYBdsPxO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4C6e0ELd"
ARC-Seal: i=1; a=rsa-sha256; t=1792150838; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ReoSi2wgp3fXuma/xc+ZNc99IAvfdYV/7obAFn5pXqqtmq8oJ+at2X9FjLC29YNG/0
    Xq1xQbqfrQOAd8NHX02tg7KCbvCcsHla+5rJcbzWSb7UyJmGFJ1+zxR/9ntPmAmHjzEC
    8/F9pIyCm0kIABAarD0zKU0s7OmF0y/YJr0Tjzb+WbOleDRWzyS55LeCaWNReY0LcBaI
    zZsQXuyRJyTnzYubojDHsYW5rk002FnsyoSNCMqNRNYM64Vgn2dJMwvOynRLn/5DybcT
    8eXBBH01K1TxQRML0wcvQUuq4vFP4WitQfey7KO7HTy821ZhqN5pIBhb2O9+9u5jmW9B
    5d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792150838;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWpcSo/GofMHjp3LAOA3kGB2wxUg1Y5AlLEhmASUc4c=;
    b=iO2mdZAYANfEj6BsOqXLZPrAR4JQL4NF45kKu8kyRzGpgzCCnxBgOTdxCp9LKz9sVG
    NOf4vhxaq8UTK3Gb4ry1yz65fvby8a6MA5thY8a6W5CIXcs58qwo7eI6840fWrQlL0Dt
    kt0U/BC6m+gaS7guWluylTlLiiaWuvAUJGq7BURLhs3zorfZ6sXpMvenCfS9KMSGfCG1
    +h0/VM29jJcPcsqVKgnRvq/l5OxoBMAmSqefjIL/A4+B6d8FS8ObGFl/7lVmNDay2scm
    /Ca7Fy/HNlo8VPWy+CyHVQK3Fl3Xdlc3e1uXNkDOsjm2tXWlDRs7TCeamtd2e/2Agynb
    B9LA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792150838;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWpcSo/GofMHjp3LAOA3kGB2wxUg1Y5AlLEhmASUc4c=;
    b=XYBdsPxOIIYCVpriPx5ddqijZLLC8tiPMbuO2kMYXjsAnGkR2pTW9QImhybQXbanoU
    Uf6zMRuEDckCRaBy/cwwE9c+rPEuNzBBMkPSkw5PqeCxsHIe8xU4tThHk12YUtZa87s/
    oPISJ/t5PwUBTj6i++ub/PNwmSbZe54RG6TwvGTt4lZXdQLVj8xlJIX91Rb04cdgCJZi
    2bZOGyfcydv8X/MTMsLp7KR/281FMfjx/mQ55CQ5YWNxmBk19khzrGzpAREnXTu0cAb2
    e8KqjjKPGOtkhVKtUBIhZ7wso8ZE8nwwCUSwue0ATT7gfrpHgTSiJ9jdNe2IQIgHICH4
    VI5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792150838;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWpcSo/GofMHjp3LAOA3kGB2wxUg1Y5AlLEhmASUc4c=;
    b=4C6e0ELd7Ck1HmUnV6zPb2399hHaAGkbitDXuGOcpr9fVSuR5/g7Pn+03GKYgOFVxQ
    z7+GPnEtdXQDQsaXYfDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GBecM5r
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 13:40:38 +0200 (CEST)
Message-ID: <a1b96d3d-ca61-4983-83bf-15090a455a70@hartkopp.net>
Date: Fri, 16 Oct 2026 13:40:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2] can: proc: reset pkg_stats atomics
 individually
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 stable@vger.kernel.org
References: <20261016110905.422684-1-socketcan@hartkopp.net>
 <20261016-precious-industrious-muskrat-0c77e8-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261016-precious-industrious-muskrat-0c77e8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 13:36, Marc Kleine-Budde wrote:
> On 16.10.2026 13:09:05, Oliver Hartkopp wrote:
>> From: Runyu Xiao <runyu.xiao@seu.edu.cn>
>>
>> Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
>> converted several members of struct can_pkg_stats to atomic_long_t and
>> updated the hot TX/RX and procfs read paths to use atomic_long_*()
>> helpers. However, can_init_stats() still clears the whole struct with
>> memset().
>>
>> can_init_stats() is reached from can_stat_update() in timer context and
>> also from the procfs reset path. Those paths can run while the TX/RX hot
>> paths are concurrently updating rx_frames, tx_frames, matches and their
>> *_delta counters. Hitting the whole-struct memset() in that window
>> performs plain writes to fields that otherwise follow an atomic_long_t
>> access contract, which can lose or mix live statistics updates.
>>
>> This issue was found by source-level API-misuse analysis looking for
>> whole-object resets left behind after atomic_long_t conversions, then
>> manually audited on Linux v6.18.21.
>>
>> Replace the whole-struct memset() with a helper that resets the
>> atomic_long_t counters via atomic_long_set() and clears the derived
>> scalar statistics explicitly. This preserves the existing reset
>> semantics for scalar fields while restoring atomic access discipline for
>> the live counters.
>>
>> Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
>> Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
>> concurrent traffic and reset_stats reads, which reproduced inconsistent
>> exported statistics before the fix.
>>
>> [Hartkopp] can_stat_update() also read the *_delta counters at the
>    ^^^^^^^^^^
> 
> As this is a regular vN+1 patch posted by you to the mailing list,
> please don't add your [tag] here.
> 
> If you want, you can add a change log entry after the "---"

I would have done so, if I was the original author.

But in this case I documented my personal contribution and also my S-o-b.

Otherwise this would not have been transparent to the reader.

Best regards,
Oliver

> 
> Marc
> 
>> beginning and cleared them with atomic_long_set() at the end. Increments
>> from the hot path in between were lost for both the current and the next
>> interval. Use atomic_long_xchg() to fetch and clear the *_delta counters
>> in one atomic step instead.
>>
>> Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
> 
> Change log goes here.
> 
> FYI: you can use b4 to pick up patches from the ML:
> 
> | b4 prep -n proc-pkg_stats-atomics -F 20260512133937.21957-1-runyu.xiao@seu.edu.cn -f net-next/main
> 
> Add the change log to the cover letter as usual, b4 will merge cover
> letter and patch for a "series" consisting of a single patch only.
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


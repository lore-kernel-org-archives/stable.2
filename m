Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55E37FF68
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162233; cv=pass; b=ieNUq7O5FcyCLDCKTSM9IakErSG4gRUwmu508eYIYJZBuRobfRZvCUTW6Lmb4ZPotYQt9R/NAPs4DYjVfCwg7tMPWR60scR9nokYJY5/nU+N3FJjWBfVI/PxoNkgEqXvLpX+LFBHNvGZGkdfSPnhYH/vqgkqUiUb9EeTqfq8EYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162233; c=relaxed/simple;
	bh=y/ugXYR2IdmwBOp+hYhWLSJ2BvFu5cgelKB1JmQlMhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XaEJLyqE0qRkg0MAT3jZhQvWqjK+p+rAulJbgeTckZvxcFjM56o/5UacF6LRl+yP3Cl7C4+LOlZhvMUPZEosYDdtfbt9dljqlE5gkK1AGx6gEFL2S8vbKneuAURPny8PBoupT1avPKlby4IZTkhRRORjW125mjzo3VjSq7flNDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tG9UIsFj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DuOSQeiu; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tG9UIsFj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DuOSQeiu"
ARC-Seal: i=1; a=rsa-sha256; t=1785162217; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KnmCtiwF01Rg7+rN0utO5XWeEFx7MOSdUz5liv8FhLh4JXjJp30JEETMtIBEBhPvVI
    FkxfuSTuHBFZwT7k6hLrN1ovbvxjrYd6JyROViTsXULAG2H6DY2GAtSjFsJqDphkOWbo
    ETobtZjk49g1AypVRVtvdRQ0CMer8yk1izDkzz2CrXiqEgcf6Sj+lri4HXfP1gpyD+Oh
    HWLPUBF4Tc8AHdbCGtU50zgAov0sTFCgFHQGZDjVofpo86vStybGkdPQNUeHB/dilOEA
    0czRYvhQ9VS8qAa7DahhUQa6N/IJyTY51vxsB39YlkFGBJBH3jharO6BZ2WZWVBwdSPp
    /sHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785162217;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sRpbgR1GSzmKcgoAbD9A7ByOwWGa+MtaUar/xrovIWM=;
    b=CkwlOApwcG+/lr7m/GRwEPW4q/9bxoh/UJEpG0yhUXaEOVoF2zs9ZracH/pQIHeEOM
    sDdbS001svicMcNj5FQAnqtc1rULfK5J8aLfppvWBvzSMz7mzdCFF6nSz8mUQaVkMRXD
    xYrzwVrHE81IMrENWJ8OwF6M/LH5Mw4/7NzOxuCqllWvrRc63vwSDezgUGfizXdWh7rL
    DHY9JhLYhSlSgZANaRT1Vv0X42RaI0EX1Mr5pc8K/uocHr9GbT1Xr3YMDzKo0vCXpzxY
    Zt4YeWF19ppnLcER3h3upaRn0Vyk1URg6jkASpmxWLSklTarmmbj+yQHcQY/pT4VxfYb
    9Qsg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785162217;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sRpbgR1GSzmKcgoAbD9A7ByOwWGa+MtaUar/xrovIWM=;
    b=tG9UIsFjjQsYWkjuuuBa0x+OBSdvOiYPToiE/5owd8YzCzlKnlkvfQz8JAnAi03992
    Nu6y28RUoS7e1Sw3vrb8kX5dWuJ3OmNRl+TVY2aypiBqiWapplrZc/OyCyc+ougHJu39
    R0wUSi6lnB+7yiz5yjMfgEIlVei9606eAf+bOiRX1qKIljpRigK1fnCgNbeZREwbbdAL
    HG0Gt8dZVYguw8scT1JlIPM5Huvf3gilLSquD6ZiOZcn7e+PiGvBjooEWEsD7IMeGaRz
    ZSgKkbBH9MmuKE4KXNfXKsGaWObM8pzAWazICSeCMPNUzHpIY8h3dw/Tt49eJE9QWkFi
    BMTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785162217;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sRpbgR1GSzmKcgoAbD9A7ByOwWGa+MtaUar/xrovIWM=;
    b=DuOSQeiu9/Mtb7U7a93vQfN+5eAnC5IXSsvKqokUkQq2cirywy8FrbI/T/o9LaHAgs
    z5UvzTPsTsIIJCMyuiDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926RENbBKy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Jul 2026 16:23:37 +0200 (CEST)
Message-ID: <5e96e874-0e1f-4c40-a959-ae39615cb20c@hartkopp.net>
Date: Mon, 27 Jul 2026 16:23:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/2] can: bcm: registration process optimization in
 bcm_module_init()
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <2026072027-showroom-maggot-c452@gregkh>
 <20260727133928.582256-1-sashal@kernel.org>
 <9c5f7364-86ee-40ce-985e-6d913712eb0f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <9c5f7364-86ee-40ce-985e-6d913712eb0f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

In fact I would be fine to apply this "can: bcm: registration process 
optimization in bcm_module_init()" before the series as it is an 
improvement IMO.

But it never had a stable tag and therefore I thought it was forbidden 
to do so.

But the following patches 2/9 to 9/9 should apply properly as they to do 
not modify bcm_module_init().

Many thanks and best regards,
Oliver


On 27.07.26 15:47, Oliver Hartkopp wrote:
> Hello Sasha,
> 
> this patch is a feature.
> 
> In fact I prepared and posted a complete patch sets with 9 patches each 
> for 5.10.y and 5.15.y that backported the entire patches while 
> circumventing this bcm module init patch.
> 
> 5.10.y
> https://lore.kernel.org/stable/20260724101342.16000-1- 
> socketcan@hartkopp.net/
> 
> 5.15.y
> https://lore.kernel.org/stable/20260724102149.16440-1- 
> socketcan@hartkopp.net/
> 
> Best regards,
> Oliver
> 
> On 27.07.26 15:39, Sasha Levin wrote:
>> From: Ziyang Xuan <william.xuanziyang@huawei.com>
>>
>> [ Upstream commit edd1a7e42f1d2d09c5f79ecef05ae19dc669bf34 ]
>>
>> Now, register_netdevice_notifier() and register_pernet_subsys() are both
>> after can_proto_register(). It can create CAN_BCM socket and process 
>> socket
>> once can_proto_register() successfully, so it is possible missing 
>> notifier
>> event or proc node creation because notifier or bcm proc directory is not
>> registered or created yet. Although this is a low probability 
>> scenario, it
>> is not impossible.
>>
>> Move register_pernet_subsys() and register_netdevice_notifier() to the
>> front of can_proto_register(). In addition, register_pernet_subsys() and
>> register_netdevice_notifier() may fail, check their results are 
>> necessary.
>>
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> Link: https://lore.kernel.org/ 
>> all/823cff0ebec33fa9389eeaf8b8ded3217c32cb38.1663206163.git.william.xuanziyang@huawei.com
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Stable-dep-of: 68973f9db761 ("can: bcm: defer rx_op deallocation to 
>> workqueue to fix thrtimer UAF")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   net/can/bcm.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 06ee3bfe87c99d..334a5105a4532c 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1832,15 +1832,27 @@ static int __init bcm_module_init(void)
>>       pr_info("can: broadcast manager protocol\n");
>> +    err = register_pernet_subsys(&canbcm_pernet_ops);
>> +    if (err)
>> +        return err;
>> +
>> +    err = register_netdevice_notifier(&canbcm_notifier);
>> +    if (err)
>> +        goto register_notifier_failed;
>> +
>>       err = can_proto_register(&bcm_can_proto);
>>       if (err < 0) {
>>           printk(KERN_ERR "can: registration of bcm protocol failed\n");
>> -        return err;
>> +        goto register_proto_failed;
>>       }
>> -    register_pernet_subsys(&canbcm_pernet_ops);
>> -    register_netdevice_notifier(&canbcm_notifier);
>>       return 0;
>> +
>> +register_proto_failed:
>> +    unregister_netdevice_notifier(&canbcm_notifier);
>> +register_notifier_failed:
>> +    unregister_pernet_subsys(&canbcm_pernet_ops);
>> +    return err;
>>   }
>>   static void __exit bcm_module_exit(void)
> 


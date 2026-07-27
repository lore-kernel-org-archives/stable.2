Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531041A55A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160086; cv=pass; b=qqt0Myo/2oQrEKEbIWN04nPSpq8JOj/juq+qNJEHTeLWMUiC9tlCF2FuQaNMSOcNWskXtH/s2PaUJIMa7cuGbe3EcqE2+V47PjTR3Ji+J/ZokuSxDzg3NLdvx4lFH2do/xMdiVevBQAeajEMwDBDhVBvz0CW1N439G9D17gbe3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160086; c=relaxed/simple;
	bh=ooVT35Vt6WqjSAwuZBzjQOrJdRmYiUnu3JOKe1QbxUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcgIHsRMyUqJ5wOSY0xA2eiDDTR2qdfNqHRXxbsE4tqQwyHZCtIkxl2m4yVY5yz1vPtJ6ApJ3vt4m2qgHrZZKWwjbNm14AFwl0Rsir5iScPNH+zgor3YS48aKgOpeqoe6lA42ijhqpTRi7rII0Aj0w0DNBxlFoDYNusq9OteaEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iCN/myDz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yQ5mFvAr; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iCN/myDz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yQ5mFvAr"
ARC-Seal: i=1; a=rsa-sha256; t=1785160063; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=raTgGxRpVQwe8G1znB76Bmmn9H4OHjkuxL7FrTkn07O9JsVNk3Lz7aBT8vm5KAni27
    fbB6rJrx8xvDYUPScAGEC51d5Sge+TB74HrS41v4OJFtc4dPQ6cItueKEWLmqnmSvnRF
    XfztuuHWuoIrOQtBuAau1D7Dv2SCBi8YLNUT5SCgfCHCIQwvESdhuR+7rUuE5Zu4GAna
    AMFzLvZzRFSbhIKNPgnU6G3xCE/NEE0pgXO7/LrY9vQyA24m3AmF7tAseTnD7nq9fTSk
    9ixMy35444SnXBg9cCMXhoshoq/0K2AgfHXm0YiSpsMQMjWuo6+oF1hOPpmSsFw41H/D
    xgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785160063;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Sbpbo7dJkKHLk3J+dcCv4C1pW9pMTTmf0uQQDZkzI6Q=;
    b=DEe/NfdXyz3lP8hrxcgzfquIb1N0UgNeUpTdKgFnuIc151MyvfjsmyYfMdbekT03zg
    SJsQRZtXP0Hse988LHuDM5mGHiZauJ0dGhWFj9gIZQOnKALi7U8lSV09njY0pyLI/f4c
    qHrk3Q4/Pfa5xDXCm4P970T9ztbWTk5qa/s3+N+BMfZ3wPl5sAB+HGW3f4/RkkPY+uj+
    pyIA6tp1azCoZDYiWnI4woua9JhePQrpH7sXHdf7VXBObJA+W5GEw2lm9JoIkJ2/9Ny4
    8Usxg0e7IOH3B+yNHhcBsaL5oM1WyEcxrBEROci8IqsCPP5+B0jBjJ0/I7KTyeHItm19
    vrUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785160063;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Sbpbo7dJkKHLk3J+dcCv4C1pW9pMTTmf0uQQDZkzI6Q=;
    b=iCN/myDzG6wbq7/FUCk968zHDb3TIqW9qaOqkeUnmEtYueyheybJiLqW7tgWQA9SF4
    JtM8XWBc3BoSbmg41uSDjJ0mX0tX/GKjpql6TZ8+gaZkr6NBNNIKteYLu3sMqcfxu7wL
    NDmwhu3MFGebhlfw+xU2+YKfJlarbleHmcSUhjwlV4R83SBVoRiHHs+/vURxseefdDIS
    M5M6VmQlCQTYAK7IgDYB3cveii2otVQdDI27OjZdcpa09UTKnzdzzirkgRF9vEX/7ABi
    IzZkWuujTYIywR0tf97D/uu8OBDwG0NlkCI1I2EXY9CUgmqiWJ2Lyl2g0K41rkn9FMxD
    K0vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785160063;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Sbpbo7dJkKHLk3J+dcCv4C1pW9pMTTmf0uQQDZkzI6Q=;
    b=yQ5mFvArqUzYav3bU6XCGfYew8+B2THaZpvovFKWqpmmVHELvrhyzZVrp76Bpgqlwq
    dy+E8iGqrtxu6ViZy0Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926RDlgAhS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Jul 2026 15:47:42 +0200 (CEST)
Message-ID: <9c5f7364-86ee-40ce-985e-6d913712eb0f@hartkopp.net>
Date: Mon, 27 Jul 2026 15:47:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/2] can: bcm: registration process optimization in
 bcm_module_init()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <2026072027-showroom-maggot-c452@gregkh>
 <20260727133928.582256-1-sashal@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260727133928.582256-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sasha,

this patch is a feature.

In fact I prepared and posted a complete patch sets with 9 patches each 
for 5.10.y and 5.15.y that backported the entire patches while 
circumventing this bcm module init patch.

5.10.y
https://lore.kernel.org/stable/20260724101342.16000-1-socketcan@hartkopp.net/

5.15.y
https://lore.kernel.org/stable/20260724102149.16440-1-socketcan@hartkopp.net/

Best regards,
Oliver

On 27.07.26 15:39, Sasha Levin wrote:
> From: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> [ Upstream commit edd1a7e42f1d2d09c5f79ecef05ae19dc669bf34 ]
> 
> Now, register_netdevice_notifier() and register_pernet_subsys() are both
> after can_proto_register(). It can create CAN_BCM socket and process socket
> once can_proto_register() successfully, so it is possible missing notifier
> event or proc node creation because notifier or bcm proc directory is not
> registered or created yet. Although this is a low probability scenario, it
> is not impossible.
> 
> Move register_pernet_subsys() and register_netdevice_notifier() to the
> front of can_proto_register(). In addition, register_pernet_subsys() and
> register_netdevice_notifier() may fail, check their results are necessary.
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> Link: https://lore.kernel.org/all/823cff0ebec33fa9389eeaf8b8ded3217c32cb38.1663206163.git.william.xuanziyang@huawei.com
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Stable-dep-of: 68973f9db761 ("can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   net/can/bcm.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 06ee3bfe87c99d..334a5105a4532c 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1832,15 +1832,27 @@ static int __init bcm_module_init(void)
>   
>   	pr_info("can: broadcast manager protocol\n");
>   
> +	err = register_pernet_subsys(&canbcm_pernet_ops);
> +	if (err)
> +		return err;
> +
> +	err = register_netdevice_notifier(&canbcm_notifier);
> +	if (err)
> +		goto register_notifier_failed;
> +
>   	err = can_proto_register(&bcm_can_proto);
>   	if (err < 0) {
>   		printk(KERN_ERR "can: registration of bcm protocol failed\n");
> -		return err;
> +		goto register_proto_failed;
>   	}
>   
> -	register_pernet_subsys(&canbcm_pernet_ops);
> -	register_netdevice_notifier(&canbcm_notifier);
>   	return 0;
> +
> +register_proto_failed:
> +	unregister_netdevice_notifier(&canbcm_notifier);
> +register_notifier_failed:
> +	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	return err;
>   }
>   
>   static void __exit bcm_module_exit(void)


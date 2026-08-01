Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977523385BE;
	Sat,  1 Aug 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577239; cv=pass; b=StC7xlHf8ESGlq0sPZEz4vqhS+Z+rvXkmfZXBP6Bq1X+eBqKiV6GfqylK5Si3YTHbZJ2TZFiw3P1Yaed7xKeJgKsZI4R3RsKxEdig2FAz4TnlVAk/rsuq+65Xh7Gv/gSZ3fCN9lht+E3mEhEG5Mlh4dkgWM8LrVZvQ4LglUCoiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577239; c=relaxed/simple;
	bh=SA7FD1pq1ihGmllMdi3d2vuVRVfW1+xfwV1t9DflmF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H91do6sUDTv4tXmX+rspBHPlbooUgHILuMruzbm2Gh6W3kmmivWQ1sYMHWbnOqnTIhq9rDgx6nFuvqbNmj7MImV5FDQgJY0P36gMnHaIDZc9HFY9drT/axVy6EZ54TuIRSknfy2aVwJm4Pkcw8NvkDM4HO7CZlh4CjjEqRr61oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mobQ2gun; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GMkI6ut7; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mobQ2gun";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GMkI6ut7"
ARC-Seal: i=1; a=rsa-sha256; t=1785576871; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BMINZHqqyR/4j0WqjB0GVVSQH6ap2+rUfeap8rIilx01PmwdjhDfIr5DQyvQBysqtA
    1FgzhN/hls0UWOTkar60nfS6fhZYVdY0BTrgGDhk05oequU9iYl0ggyeb0nA9htZGZ5F
    VazTi1G8VmsI2rILvXEOcL+xU1GshLJc5o3cprzG1LZDLk52fn07hcOKK+lCRp9/TrBv
    +L51UnV5K0qR9IBObsNX2VsmMwb4oYSeriCu/cdidrxFpb3GfyZ5XJNibxZXpCnrzksA
    97JuBYeCZd+vE38OtENDLjFZX7EbjSIspSz3cRB77XaSDd+pudfFVDObMl2Z90FS+y6g
    8D8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785576871;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6vnn0p6Rgo7NzYu4bB4EgOcUV6/jtJK1GBUNjn6Hcjs=;
    b=LWpO/zn/Z4MFXbUsx0v6SsB+zCFk4Fi58aYT87D9yBjYgmnqAWOqo7ZCD2p7OuMEjX
    FbM9MnyVVnP83cEEHogDKYU23EUI39mQwnJvjMeKTo5x6cM/PryxeY7TdI9yErH+RYUC
    DEMVTS7Gahfy/3BObsezXRtyUaENGzMrq2XupPo9yDc3HKLftOylo1nnrvF3X0Z/hEIe
    NwKQ7eGIQGv/Sp/dJX6DdhhZsu6bfjar1lMWgFBeL2+C7fsGumQDuLHRnSd5McdSadmZ
    8N47CLYCtg1rz6ma0kNUpUTYKZTZK12KYEeEY8pqZD0FJ91xEE6PY2Aoc+d8HOZHVHv6
    CyIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785576871;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6vnn0p6Rgo7NzYu4bB4EgOcUV6/jtJK1GBUNjn6Hcjs=;
    b=mobQ2gunjlcBc5ZVuJy0IfmU4wPeQuz5iQA+A6+th40+PokJ00nhnVZ7WC0UlNP5uG
    VpDoclQeIYbDDZiX2+FghTQkfZ5664aNvk8PO+pScFjQCDneC7WvDeNsV6ucz11g7RIq
    /ruNFfaQ+LmqvUMaqGUd5dfr1EdXQC+CNmK86ISkMF+MeCpCSh3fr767MYsU0IRAB4D9
    lLhd266IhANPlT+7CaOVJNcUgAkxMbz8oNPKQrKtqvLorSWS24b2O5xeBmObG/jjF3As
    NMNWKi3XbMc08+CswoehIIrViqFqS9WDL+km+pIn1Dh/ZLVFni0UvmdFNRT7fE3t0oso
    f4rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785576871;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6vnn0p6Rgo7NzYu4bB4EgOcUV6/jtJK1GBUNjn6Hcjs=;
    b=GMkI6ut79b9xtzwu/NnDt+LKVIglX0nsEh5p3vo19spgS8GY4nNKmXfNaQpfYEinJs
    65JK+XTCfX1myPjd/mAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K528192719YVhmC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Aug 2026 11:34:31 +0200 (CEST)
Message-ID: <a66f9e1d-ffff-4fff-9322-629195dc62de@hartkopp.net>
Date: Sat, 1 Aug 2026 11:34:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: drop CAN XL skbs when CAN XL mode is disabled
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <tencent_2E3C237AFB193409D300C97027F88CB8070A@qq.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <tencent_2E3C237AFB193409D300C97027F88CB8070A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your patch.

Please take a look at the latest activities on the Linux-CAN ML.

There's already a patch available I would prefer to solve the issue:

https://lore.kernel.org/linux-can/20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org/

Many thanks,
Oliver

On 01.08.26 11:29, Cunhao Lu wrote:
> Valid CAN XL skbs can be injected through AF_PACKET. Although
> can_dropped_invalid_skb() verifies the CAN XL frame layout, it does not
> check whether CAN XL is enabled on the target device.
> 
> can_dev_dropped_skb() already rejects CAN FD skbs when CAN FD is
> disabled, but lacks the equivalent CAN XL check. Consequently, drivers
> without CAN XL support may interpret a CAN XL skb as struct canfd_frame
> or struct can_frame.
> 
> For example, rockchip_canfd interprets the mandatory CANXL_XLF flag at
> offset 4 as struct canfd_frame.len. The resulting value is at least 128,
> so the driver reads beyond the skb frame data and writes beyond the
> controller TX data register window.
> 
> Reject CAN XL skbs in the common transmit validation helper unless
> CAN_CTRLMODE_XL is enabled.
> 
> Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-can/20260731105402.B7A451F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>   include/linux/can/dev.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6d0710d6f571..13fa607474b7 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -167,6 +167,11 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
>   		goto invalid_skb;
>   	}
>   
> +	if (!(priv->ctrlmode & CAN_CTRLMODE_XL) && can_is_canxl_skb(skb)) {
> +		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
> +		goto invalid_skb;
> +	}
> +
>   	if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
>   		netdev_info_once(dev,
>   				 "Error signaling is disabled, dropping skb\n");
> 
> ---
> base-commit: 02dc699f83d04069fdabc996fc22d47cda47a4a9
> change-id: 20260801-master-bc2e15d668f5
> 
> Best regards,
> --
> Cunhao Lu <1579567540@qq.com>
> 


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499928;
	b=vx7P1bWGBqgnc3JSJ9WjtHkj0fnWnOJnb57y+lxrxL/W+aZmt/208rTuG9HneR5F2kfn
	 XNV6S4tBAE9YtB0rD5FD5xKSTn0kibKWKShWP+qJS0k0T27pk0v9OuSBS8OG5o8ko8x2x
	 7zW9k8lymr5a0VPwwTaYSKMREqi8sjofsddJ8zUC+KZedXBrU1D/WBYXH0mfnEFOADzO3
	 0ywatTqv4Xfk6BaFtYlOIpO7OWoBbM5QHSDGxCz2EN4acRAhf9tnaH/uIh+c7Vt6NhN+n
	 TIOFdDx3AAXTlR4HHKLnk3LmrErBnXibqN5ASc4/F2XtmnkYSm1yJDgHZzD+czKkNsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499928;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/6x4bCYZdPi3t0lUuSJXXxFJL4VJcQrmB7LrShT9NXU=;
	b=T77+l4AIY9pdUk9K7JndpmNni2koqKtu6vB7djtJYXLDDjEYRcgZwQnGNFsIw+yYE7Vh
	 qNGhUPFQvANZq+IQzVQ/Mis4qJH9y7kvUiPYvgId708TkINfJG2I/AhrmG/BT+e5oA8P2
	 5mCPStQNtijmmM9H2rPHt+W4bzFeaGtZV+s2xdlECBXG62qgOVJMYfcq0To9F09nASdYi
	 952JFV7QjVTRlS0VgQqNB513IO1urBbVtZ7K0Osyf1FDf7N6UYCgPrFx3QK6F7YyqsRBh
	 nIN1Erz8EvpAv2MaXX3AJvL1TFo/keJmdWphNpMphPXqvzS8c/0qQfMloFp13A5UreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6A606A319;
	Tue, 20 Oct 2026 12:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF6A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2debce02cc8311f19a56ed5b684f684d-20261020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a345f462-07ca-4556-8621-33e4c1eca9e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:16d147198c1fb3b894fead51ff1a54ea,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898|915,TC:nil,Content:0|15|52
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2debce02cc8311f19a56ed5b684f684d-20261020
X-User: lilinmao@kylinos.cn
Received: from [192.168.1.101] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 756192786; Tue, 20 Oct 2026 20:38:40 +0800
Message-ID: <9dae0159-f62a-47f7-92f4-66e547612245@kylinos.cn>
Date: Tue, 20 Oct 2026 20:38:37 +0800
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
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Hayes Wang <hayeswang@realtek.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 nic_swsd <nic_swsd@realtek.com>, Birger Koblitz <mail@birger-koblitz.de>,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
 <16d9caec96e8449d88ac456e8512f08b@realtek.com>
 <06aaa778-ad49-4e30-b1c6-a7dc68718a21@lunn.ch>
 <cf64cf73-aa31-4a78-82c4-a9a6c866d7cf@kylinos.cn>
 <04de94998df1449b945b8847204980d2@realtek.com>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <04de94998df1449b945b8847204980d2@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/19 20:12, Hayes Wang 写道:
> Linmao Li <lilinmao@kylinos.cn>
>> Sent: Friday, October 16, 2026 3:16 PM
> [...]
>> Option a) addresses only the speed regression. It keeps the existing
>> PLA_PHYSTATUS carrier detection and does not improve reporting of short link
>> drops that recover before the link work runs.
>>
>> I plan to post a) as v3 for net next week, keeping that scope explicit. Please let
>> me know if you see a problem with this approach.
> I tested the following patch, and it works for me. It might be useful as a reference.
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031..398d35f6fb7b 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -6979,11 +6979,8 @@ static void set_carrier(struct r8152 *tp)
>   {
>   	struct net_device *netdev = tp->netdev;
>   	struct napi_struct *napi = &tp->napi;
> -	u16 speed;
> -
> -	speed = rtl8152_get_speed(tp);
>   
> -	if (speed & LINK_STATUS) {
> +	if (r8152_mdio_read(tp, MII_BMSR) & BMSR_LSTATUS) {
>   		if (!netif_carrier_ok(netdev)) {
>   			tp->rtl_ops.enable(tp);
>   			netif_stop_queue(netdev);
> @@ -7009,6 +7006,11 @@ static void set_carrier(struct r8152 *tp)
>   			tasklet_enable(&tp->tx_tl);
>   			netif_info(tp, link, netdev, "carrier off\n");
>   		}
> +
> +		if (rtl8152_get_speed(tp) & LINK_STATUS) {
> +			set_bit(RTL8152_LINK_CHG, &tp->flags);
> +			schedule_delayed_work(&tp->schedule, 0);
> +		}
>   	}
>   }
>
>
> Best Regards,
> Hayes
Hi Hayes,

Thanks. I tested your patch on an RTL8153B with a kernel based on
net/main (513444cc62e2):

- With NetworkManager running, it reported 1000 Mb/s after 3 of 3
   rebinds, where it reported an unknown speed without the patch.
- On link up, the first BMSR read returned the latched link down,
   PLA_PHYSTATUS showed link, so the work was rescheduled and the next
   read brought the carrier up. After ethtool -r there was no repeated
   rescheduling while autonegotiation was in progress.
- I also filtered intr_callback() to pass only link status changes.
   I delayed the first link check until after both down and up
   notifications from ethtool -r had arrived; the recheck ran without
   an artificial delay. In 5 of 5 runs, carrier went off and back on
   within about 8 ms, and ip monitor saw NO-CARRIER then LOWER_UP.

I will post v3 based on your patch with Suggested-by: Hayes Wang. If
you would rather be credited with Co-developed-by and your
Signed-off-by, please let me know.

Thanks,
Linmao

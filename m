Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B6342539
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316621; cv=none; b=cz+cJsfuCv7Grt9vGRwISaasw6Q742NfJsVS77Eep74VJe4I05pG4uL+NML4mkYeLDX42iUAGvA7NDaZ6+yf/Mn6NF5lEW056FHUmywDoyEcdTN0IEusVIXXpIkEajUvWyqwnnHDMXLQExF1albZ0M4uMwUVeImGxCS7cOpyFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316621; c=relaxed/simple;
	bh=sYdvhM4TiA9hquL5iwmC1+OokQSUH+N7/63f53X0ZeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQXzFGtCvy6n8O9CnzvHeZdK7yxzg4wud19uA6ANU7wFOuIMZbH3SilGumB7pm3M6AYS/5BWnYZ/WBZutwD1qWtAQULqYqyxV6vvJUBWQdDY/fAmp4pp3iLVgxo8Q0A5/Lb17C1xhSM33P1iSoL4gQClykfpCHeKL8hnEk5scVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MLQgv-1wXcEy190d-00Qu6f; Wed, 29
 Jul 2026 11:16:35 +0200
Message-ID: <87c8fb9a-30c4-4800-8aa3-d22f3081f6f9@green-communications.fr>
Date: Wed, 29 Jul 2026 11:16:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "wifi: mt76: Disable napi when removing device" has been
 added to the 6.18-stable tree
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20260728183145.331367-1-sashal@kernel.org>
Content-Language: en-US
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <20260728183145.331367-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ENN5fD53VDntno4+vY3CYM/2hDaO3WkayP50qFnJffI0Ov3Kc9i
 nS/INwJ8q9VS3+C5Cr/97ni7ligFU8wK/+h/nty/JPgOCBYE3vc+Ql9RiFZoZwNilm2BPD2
 Vm65fOGyAui9agHyFDsdKE4Wad3c6FJZCp2+X4z9nZs3WDcBBwvaQLAFDOKEBgkcGONcz3v
 l+8A5ySkjxrwKyhb49ueQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+8KXqRCwQKg=;rIRlacpQ0QPB9bJayH3RRZyC7l0
 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
 =

This patch alone causes regressions on mt792x, please wait for this fix
to reach mainline before applying both:

https://lore.kernel.org/linux-wireless/20260728002048.19351-1-mikhail.v.gavrilov@gmail.com/T/#u

On 7/28/26 20:31, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     wifi: mt76: Disable napi when removing device
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      wifi-mt76-disable-napi-when-removing-device.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit ec85c41196070fef11374b2a774ece87083c8a84
> Author: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> Date:   Wed Jul 8 16:43:47 2026 +0200
>
>     wifi: mt76: Disable napi when removing device
>     
>     [ Upstream commit 13b7e6a96a005c656d38f3da51581deaf9866375 ]
>     
>     Unloading the mt7915e module with a MT7916 triggers multiples WARN in
>     __netif_napi_del_locked() and in page_pool_disable_direct_recycling()
>     because the driver does not disable the napi before destroying it.
>     
>     This is troublesome since on MT7916 it is required to unload the module
>     and reinsert it with a different enable_6ghz parameter to change the
>     frequency.  The system generally becomes unstable after reinserting the
>     module.
>     
>     Fix it by disabling napi before deleting it.  Also, do not delete napi
>     on WED queues since napi is neither used nor initialized on them.
>     
>     Fixes: 17f1de56df05 ("mt76: add common code shared between multiple chipsets")
>     Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>     Link: https://patch.msgid.link/20260708144615.24092-1-nicolas.cavallari@green-communications.fr
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index 9ef073c27f3096..f5b2c8996affd1 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -1174,7 +1174,10 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
>  	mt76_for_each_q_rx(dev, i) {
>  		struct mt76_queue *q = &dev->q_rx[i];
>  
> -		netif_napi_del(&dev->napi[i]);
> +		if (!mt76_queue_is_wed_rro(q)) {
> +			napi_disable(&dev->napi[i]);
> +			netif_napi_del(&dev->napi[i]);
> +		}
>  		mt76_dma_rx_cleanup(dev, q);
>  
>  		page_pool_destroy(q->page_pool);

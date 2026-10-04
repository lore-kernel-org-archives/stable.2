Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641F46D547;
	Sun,  4 Oct 2026 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147177; cv=none; b=lF5SxpaRFKhtzxFD2DitE7EuWnMC0Z7C9ZRHo2sQEx7xiEu2hUONZHDmWbkIjoFM91JApPdCM0q3XINdo37KdGx6kIinU6lr210NUG6OJPr4yeTqVVWoQH48j3bTOnpSeHBjmpsyUDJ85Q1D0kY22ZFaFxMi9jalUDyUhQbcpqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147177; c=relaxed/simple;
	bh=4F98gCfH/a3S6D7ajfNo8HPxvP18/75MDPbhlAebBms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGVhlJE5mNBE/RNMBNPLMCEtQhc3CmC+Y5TdaktLUsKFMR3JXq4zAr2J9y8YhsYWaGxcJ3w4U2W5ZHydkxyXpna4EvCpt2wQTleM/FIskDmgb6SHLRhjzAKdeSZXYnT2Lq//mohHSWYFXohA9m681rCMPARkEAcsAPPZyI1F86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asNzq5Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asNzq5Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462781F000FF;
	Sun,  4 Oct 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147175;
	bh=IiKYqe+0JnRhLAddcDWqeOuJqO+Zz1xcsm4f01eB790=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=asNzq5NbWIVTjxQShq6lqiil9TLvxhyLcPQ1xNhdx/63FSdhG8iCLRqw/V3zgaEvY
	 LTQn6/jQJhejAyY9UyBbi4JacbxcTlWNAnPq3pSDeg8rFchNm2n/KBy97vN5KtASA2
	 z2Yvst+miZVIcM5Wr3tbu/A2JDExCRbigwTMzK+OipWPVZ+nmRLHsekTgnS3biWa9b
	 C6bXY19qhD0yhmcvXQCg5C7Ad8mwH3d8b4HinppRyjBBefwxWhKFIot4bXKmuCjpOR
	 +xj1st0HRpoyncRpI6vknGZTksd1eKHUUa9MNKUnor3nTryrT8QW441INUuy2rqysK
	 zKKMQYNQFLwWw==
Message-ID: <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
Date: Sun, 4 Oct 2026 22:52:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Stefan Fleischmann <sfle@kth.se>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev,
 Joe Damato <joe@dama.to>
References: <20261004122616.56714cbd@nargothrond>
 <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261004192902.3ab3b7f3@nargothrond>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/26 19:29, Stefan Fleischmann wrote:
> On Sun, 4 Oct 2026 16:35:32 +0200
> Stefan Fleischmann <sfle@kth.se> wrote:
> 
>> On Sun, 4 Oct 2026 13:46:08 +0200
>> Eric Dumazet <edumazet@kernel.org> wrote:
>>
>>
>>>
>>> Notice that 0xfc499000 is on an exact 4KB page boundary. This points
>>> to a DMA read overrun where the Broadcom DMA engine reads past the
>>> end of a buffer mapped in page 0xfc498xxx into the adjacent unmapped
>>> page 0xfc499000.
>>>
>>> Have you tried a recent net kernel ?
>>
>> Hi Eric,
>>
>> that might be a bit tricky. We use ZFS on this server and the version
>> we have installed only supports up to kernel 7.2.
> 
> Scratch that, I noticed that this even happens with none of the LXC
> containers running. So I tested with the main branch from
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
>   (commit 6dc989ea46b9)
> 
> Same issue.

Okay, this must be a bnxt issue, that has been hidden years because of 
some skb->data headroom/offset.

LL_RESERVED_SPACE() has been increased from 48 to 64. So perhaps small 
packets are now crossing a page boundary (which should be fine)

I see one bug in the skb_pad() vicinity. Could you try:


diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 
d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..f9feeb4471a8cf310788ef8d00b68a1508a7e78e 
100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -678,6 +678,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
                         /* SKB already freed. */
                         goto tx_kick_pending;
                 length = BNXT_MIN_PKT_SIZE;
+               len += pad;
         }

         mapping = dma_map_single(&pdev->dev, skb->data, len, 
DMA_TO_DEVICE);




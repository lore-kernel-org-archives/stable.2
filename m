Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAE34EF03
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441015; cv=none; b=Iab5l7ZDMQOZ5SsW7A7dt3vCecBm+o4SWgSlrWvDhJS5OHn5AoVHNq7xSXsK9i3lrrN/zCV1qPEv9aq2cH41chPeFgFVJHx4Djxy+hSLoY9vaGYDCL1ELZsN0eUpoUhGXfyS7nHQFrZX3SRIhHFIWMV/yG+M9Pmf8Qwxwy28oT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441015; c=relaxed/simple;
	bh=OE0nooUYwmumkrSLABt4lMUeWyUs9/rU3ZT8ApUycB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV6S+yxLRDUPaX6FuApKJ7G3x9u6RNlgUjxPfqBbMZU43RvOf9Bl+UuAnUMf8QgEwsbEQcMkTwITYL+I1rCY6MRRrYjXuXw57jl4Ukmz5rm1/tttJqxryQ9liwQklCOBTASsqUv2XhM9ugJ66EHzW/fLyomdLHSO69UOXneOGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [213.165.67.103]) with ESMTPSA (Nemesis) id 1MuUvS-1xAZL305yc-00ykdI; Tue, 11
 Aug 2026 11:36:39 +0200
Message-ID: <ed1f051c-b2d2-4e37-90fa-b9ad71d33688@green-communications.fr>
Date: Tue, 11 Aug 2026 11:36:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "wifi: mt76: Disable napi when removing device" has been
 added to the 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <87c8fb9a-30c4-4800-8aa3-d22f3081f6f9@green-communications.fr>
 <20260729223316.stable-0007@kernel.org>
Content-Language: fr
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <20260729223316.stable-0007@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TiEQdsb5jb4UOBcGntpb5MZbG8faThIhOWYn2zH57KZ9/z55h1K
 va2IDmG1Wsio0fecQj6VTLA4MVUC77en260bZdeTynsUIfkyMlzmMwaBmbVOpxFZ0jqiJ+O
 I+90Cm4vWCtfnZT1LLlwHBmFtdotO4IDs63R5y/qjT0lcumjE1ILY/0AYQxrHBhP6RFmYgN
 4pW8EWDDJHkU6E/Hb5kCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AUaP/lbaAas=;PTFpKZmL69i2n9ZvQ/suBs3eZQi
 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
 =

Le 30/07/2026 à 04:40, Sasha Levin a écrit :
>> This patch alone causes regressions on mt792x, please wait for this fix
>> to reach mainline before applying both:
>>
>> https://lore.kernel.org/linux-wireless/20260728002048.19351-1-mikhail.v.gavrilov@gmail.com/T/#u
> 
> Thanks for the heads up. I've dropped the backport of 13b7e6a96a00 ("wifi:
> mt76: Disable napi when removing device") from the queue - it was only
> queued for 7.1 and 6.18 and it is gone from both, so nothing shipped to
> users.
> 
> I'll pick it up again together with the mt792x follow-up fix once that one
> lands in mainline.

The followup patch has been dropped and the former patch is being 
reverted, so you may stop waiting for it.

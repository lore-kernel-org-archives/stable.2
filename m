Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C483E51F5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175802; cv=none; b=Bdh6r0/qqO9B8BTsIVwzqA2YaIpH91i7W4hWtWprvG00WxyLtMREapXmPD4QcN3suaL6pmb40p8O905EFaabRYyCx+1lrshdx1nLTPK0oh03GrJWXwTcwDMHJkVDyyHLcGXiwn6d9m59ASDXn1NNvBRDgx5jWk3e/7tc0dfK4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175802; c=relaxed/simple;
	bh=uLhhVUN6ngd8j2x1y2bu0WRlPkyjSAYqqJNC1LceToc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Emvlaw/mYquJs/82CVpReMwQ8VBc0Yqirnt71tc+Ua0rxc8zuE5kD+8YKMmemx9imt8uj8hn0PkOTcCkJEjrOQSbCxl9PLcIED/B/xJcS+9z5ZsJMVwkyGIirCkNxiWuFGf1LbL4sN+8L7tglXY7kYxG+h3epQ3MxO2pLJBr9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN+XrPso; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN+XrPso"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so868072f8f.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175796; x=1790780596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FplGfmQH7NVN/0KzB9B8C7XnxdnkI3i8bSndgLklG+k=;
        b=NN+XrPsosLDe0xzoOtpb9qBCvoQN042ei2OAuf42x99eBS6Z0BTd8Xd+LVOseczEB8
         EbVg8qBayhEpnE7Mlu+6g82eYPBdx2LARGGY35wADMfMA24meVReq/NkqkLbrj18pxRH
         kf6qA2PLoeWs04e66QxsH5MLOQkr/ry+Z9SdvjHthJUrFJgNQjTtlLnJn0Ge9Q3IEAIK
         aPsz6C9sasD5oa8BQicEzwbi1gUralMmPlJam1+X/D45hECATuvSM6tRgNDQHJfnWhUj
         vlpfCnAStzJAc/tM6Zw87t6pdEVbCUCXnzrWSsqG8Pz9LPC82AE7LEwT/RehFnld28W6
         C9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175796; x=1790780596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FplGfmQH7NVN/0KzB9B8C7XnxdnkI3i8bSndgLklG+k=;
        b=TDrxu4Qc+VaEU7PdfXTELCfJVFPDL+Dq+UEozxmzoqUYC11c1ST/7ucVvGgb0wzaDk
         LCaRQWAOtTWiFClOnYIy8vVwzZpNikY7Y2TnSH3DaSq7Qk99NV9VfQVNJiEC/DOgMEBn
         BraU6BWphPbByNYplaTHPisvsVNUbVaGDHm37/d7SuN4g0e/CAruWtIagKFWTVHE856w
         YhmJcBIQCAaKnFyQmk8jeDgO2IKpjwOgry8Qni7NvRYLOCOPDhk95rafLoc44x9wNqiF
         mcF8IIhMK36w5uSJBF4TXSeaHLXmofjR1AU9eFisXXrrvrNpi3y5EVi6u/dbOrOdnIjd
         No3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgeGrH6jL8ir0ppYijD75QqhT/fO2xgPjVZCmGcb1dgLxYF5WrXlp2Su1e3BTc/HK6I+1Bqsw=@vger.kernel.org
X-Gm-Message-State: AFuF++kTNUuDae+erAnwaK+UzEJsgSOwK9K09SRc0LqwBrIKtoRR4oUv
	hZkj5gDORhvDobF3COda9IENUOThIvA22V5YRRII19EMbPwHbQmBZIfz
X-Gm-Gg: AYBFou2QTjU2S2rMysg+pcxEg6XuGvPucILpy91p8kL3/QOacabEKl3w4Gz4tdRB1tV
	SUXsxwnxqPSQJkQdvsYLHPXLDVjruxqmbienUFRbZx1fTiwL56bcol69cYs2FCDZYtnCbHEt5cS
	nMxlES2Dc3rUf41XmJNvhOAMeE23oRDsmcKpaZ66q2ar6SDI9Of8CddO2GUVWNkKWPtQ75RyO3U
	Klh96Y7FHPcC/dOo0QVFlKPeFs2KsK2K2C4v74DTRE2U2GyKdkN94ZPZvZf2+EvTJH1WqNDc+f7
	alwThwEwvJdUm3JjqssMX5TkircU99R4Q9bSdTWAtZw4A/eI1Cop9NzC/YsiNQvtkMKmblYtL4P
	V+38P2HoipccSifHoXG+FMaxkUAcbmsfnZTVKN/Q39CaiIR1yphIL/nTx/wNVOeEkmWZz06+oRJ
	lBbp37IaaBrNvfSSOPItUChg2BFQD4IbA/TQGi6E0DhLWmBka45mNnEeHsc4/sOGssUTcOmlrm7
	Kw4SQ==
X-Received: by 2002:a05:6000:1447:b0:487:27f9:83e with SMTP id ffacd0b85a97d-4886709d6d8mr5046351f8f.51.1790175796488;
        Wed, 23 Sep 2026 08:03:16 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688893a0sm7826780f8f.32.2026.09.23.08.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:03:15 -0700 (PDT)
Message-ID: <96f122e7-2004-43d6-917d-a07027f568a4@gmail.com>
Date: Wed, 23 Sep 2026 18:03:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
To: Ping-Ke Shih <pkshih@realtek.com>,
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260921165343.8131-1-pepe.schlehofer@gmail.com>
 <4c000f11b23c4920b052e8513ad28345@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4c000f11b23c4920b052e8513ad28345@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2026 05:03, Ping-Ke Shih wrote:
> Josef Schlehofer <pepe.schlehofer@gmail.com> wrote:
>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
>> index 4e110a457..55d7923e1 100644
>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>> @@ -208,7 +208,8 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
>>         __skb_queue_tail(&tx_report->queue, skb);
>>         spin_unlock_irqrestore(&tx_report->q_lock, flags);
>>
>> -       if ((rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
>> +       if (((rtwdev->chip->id == RTW_CHIP_TYPE_8723D ||
>> +             rtwdev->chip->id == RTW_CHIP_TYPE_8822B) &&
>>              rtwdev->hci.type == RTW_HCI_TYPE_USB) ||
> 
> Hi Bitterblue,
> 
> It seems like more and more USB chips need this, let's enlarge timeout time
> for all USB devices. Do you have any concern? Need your input.
> 

It seems fine to me.

>>             rtw_is_8723bs(rtwdev))
> 
> Also, considering SDIO chips, should we keep original timeout for PCI only?
> 

This too.

>>                 timeout = msecs_to_jiffies(2500);
>>
>> base-commit: 73e3b1c94c7d5b4a113e7cbb42665dc2fe3b9d78
>> --
>> 2.54.0 (Apple Git-157)
> 


Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E994DB56A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048050; cv=none; b=h/uCa7cAEyz9tef3zFQ96a1d97RQzvVb4JKa+QKhqsyUsddueNvX4bD4y1vd/QSK7PXaFqSnN8WklERGgy9KCxj/buIwuZVzw/QehaDWc/Gd/jGjr0rGEuAwQuRV4gCi6EmBLp4//hMleg9vHpanYKaQTevpr9Z2PgYKtXtC9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048050; c=relaxed/simple;
	bh=QpVWA5kBxLRil/3cTlurIa3Gg0zOcMLKe2INn1/y+4Q=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Tnfdz0nJBk/dvOrVK+q+vKlnIZ+STe59nCiTG1eCVxiadOlI64oCvyi99LHVVriwyPM6y0hOqwP8A0WK41z2gdDsHNIgSHsOz8ufpvZjdPkBmb+Js6TRbdmgibfrfUV5HUlULJBvdmibcbDoH/4r+JDdywbFz2GrJUEasgHoSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QBZ98Snf; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QBZ98Snf"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ceab75934dso38322035ad.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048048; x=1784652848;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptG2LrgVCiWDRJ0AJb0FvkOQlNYFLwr7+eK1TRT2NT4=;
        b=rl4By1Y8ZR1HUCwzlxuKtFTaHVWTUXl8gph0KPOsnwvKSD5l8wUhByy5ZPFDDPcRAi
         9o2S6CD6E7PrVePB7wis9vxznGS98nridZ8lom4QM1slNBi8xCXPlkTDiVE0mmyOwdwM
         uX0x/7ENyMDmvYlkOqpYQ5L2SELy3UoBzbGcNRsVdfBJvVZ4s19GFE6qUEZLgsjvzgb0
         zyrCegkcyeQYrzYe0C5i+2FL7RaaQ4TWugHVK2OB+vbD9MzQgNu/7x4xVDIo/2CVHHfG
         Zibxb21pW+DcHrQSN2SZd0mcaht4SD567AbY5lLkG7IO0vMtIMvTWCAY5qWXUO9BfbDx
         FCDg==
X-Forwarded-Encrypted: i=1; AHgh+RrIPUkfAMW9otJOTpbB4V6gMkEluJU8YZ/y2CBE0NacwtPJ23yTLeL0WnJxqBCrEUWu0C3UZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3TQjztvUS2X9QbyQpILnrFu7CGPOd728tNDc2NvkgWwbXl4F
	4Hg5iQ+tynGGBjkPW298LAjWux4uuOSYRWPHRd2XnnvbKDtZ8Y5Q3fDWNNSzK7do0HxaVibMy20
	ZCwG7E8n9Ap62Gh/OCanTsi2/v70KWJmHsCrc/83q3JHgVETNyVOzN9rXTtP1mygtTMCiozX4rC
	UVAG3mYMW3D0O+R8BjZ2hSua2VBro8Tbvy1fbc32R3ObAbBLX+Kne2TKEtNe0cafOz9KV4NCeVf
	NgqpNcI8Nq+VgHPKg==
X-Gm-Gg: AfdE7cnSUINpO0pLUbz9AqOWFxuSl5vo3PXdHsq4gEfVvdij6dht0M2dHsk31KCRp2A
	crUDrAf509RYkFWoKYCCDKry0/qEhglhVmHdoPHrAuALZwuYV4p0/MCV7rIiMk9415QtDVPiF/N
	LZ9x2EAKW1UcmecYmz1W3b1PKzK9Ycim2Uv1tpJAn4Xk9Ok/Lj/g9xw0TFrk2mzcaZNfw86sUIV
	7Sw9LL3XzXJ5OhFXya99/Dsxlu+ByNvMykR1tiYOKWtoDJHQBxa9n8Mupj08GXHb/9WkIpIvk8L
	lh4Gw0Cua0VMLZ3SuX7ZKtMeyYGPDXp+noENq2HvVjRGAbOz67LiFEWgzWyAnuAfqIeDiRqMJIQ
	DZJAe3rAV1eJy/Z01XOlhqJE6w1daliGJmBowwztT4p3lbA/LYstVBpVdSfRcce/L1zIkVyQ9WO
	BOuFkt2YZ61sx5o/qK2zbwsbJrVolgg6SfPlASJ9pOgg+w2wV8kQ==
X-Received: by 2002:a17:902:c94f:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2ce9ead3f00mr140794205ad.17.1784048048358;
        Tue, 14 Jul 2026 09:54:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ce8b590967sm14055155ad.47.2026.07.14.09.54.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:54:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15ceb17a28so127547266b.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784048046; x=1784652846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ptG2LrgVCiWDRJ0AJb0FvkOQlNYFLwr7+eK1TRT2NT4=;
        b=QBZ98Snf/9Zq+wjlsGCHqvUCptOX/VPFbqXKc+lrvYZA/hBdG1/j28NQpPafUFgvq3
         fm5YFTH2mQ0xiUX/Qc9CBoZhDQ2rOsOMGFuNNs5GM4uPbIs822kbvjL1T/2Hc+c9GITc
         VRjEv7trb6z6EZoBt/mjMNx4WpfhU7HSLI0qA=
X-Forwarded-Encrypted: i=1; AHgh+RrZVR+7LD7KgFID2BcWPFm4qjx9PReq068w2jAtzdjgHicWolpmjM0l192zGqm+avbB/8AdNEM=@vger.kernel.org
X-Received: by 2002:a17:907:6e86:b0:c12:4c5b:f170 with SMTP id a640c23a62f3a-c161f469872mr712371166b.62.1784048046308;
        Tue, 14 Jul 2026 09:54:06 -0700 (PDT)
X-Received: by 2002:a17:907:6e86:b0:c12:4c5b:f170 with SMTP id a640c23a62f3a-c161f469872mr712367266b.62.1784048045367;
        Tue, 14 Jul 2026 09:54:05 -0700 (PDT)
Received: from [100.98.74.8] ([109.37.130.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15db22ed68sm890052966b.35.2026.07.14.09.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:54:04 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: LiangCheng Wang <zaq14760@gmail.com>, Kalle Valo <kvalo@kernel.org>, Angus Ainslie <angus@akkea.ca>, Wig Cheng <onlywig@gmail.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Date: Tue, 14 Jul 2026 18:54:04 +0200
Message-ID: <19f618cc7e0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <uhwfd77gkvcrs22h5h42x5ujclzrq7ru5wkixguywfej3444w2@ejmn5s2kmapd>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
 <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
 <uhwfd77gkvcrs22h5h42x5ujclzrq7ru5wkixguywfej3444w2@ejmn5s2kmapd>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 13 juli 2026 13:52:28 schreef Gokul Sivakumar 
<gokulkumar.sivakumar@infineon.com>:

> On 07/13, Arend van Spriel wrote:
>> On 13/07/2026 10:50, LiangCheng Wang wrote:
>>> The BCM43752 is not reliable with the default 512-byte SDIO function 2
>>> block size: on an i.MX8MP board with an AMPAK AP6275S module at
>>> SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:
>>>
>>> mmc_submit_one: CMD53 sg block write failed -84
>>> brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
>>>
>>> Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
>>> set up the 43752 like the 4373 for the F2 watermark but missed the F2
>>> block size, which the 4373 limits to 256 bytes. The vendor driver
>>> (bcmdhd) also programs a 256-byte F2 block size for this chip and runs
>>> the same hardware without errors.
>>>
>>> Group the 43752 with the 4373, matching the F2 watermark handling.
>>> With this change a 10-minute bidirectional iperf3 soak completes with
>>> zero SDIO errors at ~270 Mbit/s in each direction.
>>>
>>> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
>>> Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name
>>
>> Looks good to me but the stable instruction looks confusion. What do you
>> mean. If there is no 43752 support there is no need for this patch, right?
>
> Arend, one year back, from Infineon we had submitted a patch [1] to correct
> the vendor ownership of 43752. i.e, SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373 got
> replaced with SDIO_DEVICE_ID_BROADCOM_43752.
>
> So in the older kernel versions like v6.16.x which does not have patch [1],
> the 43752 support exists, but with SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752.
> So his instruction is to, again replace SDIO_DEVICE_ID_BROADCOM_4373 with
> SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 in his patch [2] while cherry-picking
> to the older stable trees.
>
> Rather than that, I would suggest to cherry-pick both the patches [1] & [2]
> to stable trees, since the new patch [2] is dependent on existing patch [1].

Agreed. Thanks for your guidance.

Regards,
Arend

>
> [1] 
> https://lore.kernel.org/linux-wireless/20250724101136.6691-1-gokulkumar.sivakumar@infineon.com/
> [2] 
> https://lore.kernel.org/linux-wireless/20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com/
>
> Gokul
>
>>> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
>>> ---




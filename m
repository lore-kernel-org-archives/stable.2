Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F42E27FD44
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780764371; cv=none; b=S53qJ6Sz/d+k5EMIbrS+9ZAaqwsWrtPFdMIeyFAL/s8ZLCw3/+MD/EjxxI53wsh4krt5bzvZjr6p1VO5EER+SIhPhKIppgOYSLing1dxouin2LnFkrXYAnBWuASRlItVi0xhI9SxVYiWfLDQjOT5//6lqmO75wAiEBg13O9QAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780764371; c=relaxed/simple;
	bh=Ff8Fy4eHBG4/BzHVJkR4pQSm6mkilhlVqPXSRn/JWGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6xi68wvnpnA3qiUSqAEr6a2pTTx3j7D8d1VADVbrEq0kcFOo0EBITJ3qzVSnC6T8h4SkXlc+dKewCMkir+b+H0rhZ5Ns6R1AC+vdacCfwGjaeffETNN3jmezNQkzGdi+peOk7r/BWesTE5adExsKHwIHg5gJzTkwWRBWqQaKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpkDSec+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpkDSec+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so2139988a91.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780764369; x=1781369169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CCEPdnbAf9O7YZGI5gomWMwSVZTv0vCb5M8aGMFXew=;
        b=BpkDSec+K5B3jDabJcU8wwBivXrUcXaJgwkEf+lbg6VGHswjUW1ezWvktrCEQrC0vs
         ZAD9Zq5TrjQ4E4+5oGUdkie0lzwyEj8H+RA7Atxwh6q0RIDmk5Butc3YmIi8oCKDRx4N
         sHH4XBYjireaK2XX76DVKFKt0EegNOe8i3S/ey8M0WTheMEhooPlA15OKA3YAPXyUsKw
         5W8Ron+sCcNjPcpn5MGIugHM+KLXBTOr5jHzPpwBjUDVVkgEZ/bjXLyPaie9yEldA0bt
         ToD2XfYt4BN1Yj1XC+2kenw+CPA32m5Epe3gGyzGXT92VY5oKqU7LIrwHVUsozeevVYa
         sZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780764369; x=1781369169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CCEPdnbAf9O7YZGI5gomWMwSVZTv0vCb5M8aGMFXew=;
        b=CP+QZ8oDtvRbqyCdLWZ1fYOyHDjJyR1qOVyRale9DBSFreyLcPDSsvtazUJnk+uk9e
         ZgFXz7ndHbPXy2S1HHAbi575XRFbbtlNo90RtuniXYI9vPFAiN3uSLlOYpUWAwWCNa0J
         kCR3fPKewN0rvXmZ9DgFRSg3syy2mIWFRO10xZtBt31bzts9pC2vN3Otkhk9YyQDGagc
         /qXXfdLFOm+SwWKXzN9RXNjyR3HCLT0CGNo9wZBMYseCG0hRgvmIBdStsyRz0M9V/6Ya
         gRvgdNbbd5lsk/9RnQDdPgLHvR+6oyUGhyMW5ZsOCuOgU2bcFQWyjZWZkcilPj+aV4u/
         29Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9GgVpWrBECLvnZ9XGvUuvpbAlUMR/8aKnffzXgqFxx22TuHf01dnVHrI+PFa07E4GvMlgZORU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzxz+cbA/g8gBr2GLkXWQiri4qX1+Z79LhaVo8MFI0VNUPfp9
	7KHiL+PuS5VZvfwFoT492M/tBmYRTEei5aX+4HqRYc/lXNfwSokIk93h
X-Gm-Gg: Acq92OHjUMOY6tSs8deXdEpWVE7BZGHNdzgaq2YqeAJNkXRUfLBJx0ct7kfYOHHj2r9
	skuOP5dOK6HG+M1W7DCiLbP8+Vet7UM8MNGktX7y0I/Vt9RgeA07v1zwOvBUKQwtpgACLqTYy8m
	YZ3OgONxGhRkut0oAJt4QdKAIl/j+z6zHba3YFWujyZM/fgLgCpnA3HOP6DUJN43rD0SZLtm14a
	I1mwHplDH/J4mSXcQg692b9nyPE1wDvA6O2b6Qm6ftbM8v+JlFv9I01SLlNNyr8mWc7lqY/fbrY
	ww0XD5jvz+Bx0Knc4uL8+w1UBFdYb4RGEwoiM1+74ED0hNzsiKcD1k3HhQ/zleY+qTizZ/O7Sym
	DDHplKmOBRzbiECd7pJknUkPjXeDolqPiG7e+K8yfhQIcQ66G6c3CChKpPe7lp/5913/YtHNh3z
	N4MXdJ/yjdGyWfi/7D06x/UotscqYeds9Y4JAh6o18dw==
X-Received: by 2002:a17:90b:1ccd:b0:368:a297:bd38 with SMTP id 98e67ed59e1d1-370eedfff8dmr9852447a91.7.1780764369256;
        Sat, 06 Jun 2026 09:46:09 -0700 (PDT)
Received: from [192.168.1.111] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f714e26afsm10414758a91.17.2026.06.06.09.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 09:46:08 -0700 (PDT)
Message-ID: <b791aed1-cd05-45cd-973b-4d8bef27ee7c@gmail.com>
Date: Sun, 7 Jun 2026 00:46:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
Content-Language: en-MW
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
 <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Sven Peter 於 2026/6/7 凌晨12:12 寫道:
> On 06.06.26 15:25, Nick Chan wrote:
>> From: Yuriy Havrylyuk <yhavry@gmail.com>
>>
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> If a pending command tag is duplicated across queues, the firmware
>> crashes with: "duplicate tag error for tag N", with N being the tag.
>>
>> Instead of partitioning the tag space, which is not possible without
>> linear SQ, 
> 
> Isn't that just what the pci.c driver does with NVME_QUIRK_SHARED_TAGS 
> for the T2 macs or what we do in this driver with
> 	if (anv->hw->has_lsq_nvmmu)
> 		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
> ?

After adjusting the apple_nvme_submit_cmd_t8015() function to account for
the admin queue depth, it seems that the existing workaround for M1 of
reserving two tags for the admin queue works on A11 as well.

Will post a much simplified v2.

Best regards,
Nick Chan

> 
> 
> Sven
> 


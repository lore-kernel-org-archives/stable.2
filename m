Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0A43E083
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776931; cv=none; b=mti20MmMBEyleODbCqE8uyEBNfN14e4mQ+UbtmReWz08x3re1mc4zVS6+tC3A+qPMDU5SRV4E4OHUDpOCmjVPphX1KZOZiGOWVzi8BgkK7zlS4hZTrxSNuC47Qa6KPy3EH0smxkz80RTuAWAhwmX9OMJHwA28EPhW1oo8Yr8IBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776931; c=relaxed/simple;
	bh=4Ada3OHpXiLG5T0AAsYcOgRew4MZYqz94GyBaLtLsxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0QA1/NTnPJBQPpuq3gqAeTQ0/2kvemXs7c4Tk5Sb6HDiwFpnD4nZE+96Tx7e/Cv3xDqcI25hf47ZvJyDDdoch8Kxy+8WdEg6XP3X/mhJyA/5v4822odcT7Z5BfSHjJ0+KA7TRCcElach/G/kn1s0uRGjOfkUdiCn2As+S0KOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DhzAcSlD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DhzAcSlD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4858303de5dso4185010f8f.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788776928; x=1789381728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZhjTAmwyW+i7ADmwUXpM1rxtxgoKnriyct2cm5k19E=;
        b=DhzAcSlD89HQ2VWd66DWzvfHNSMFsVzvjntO7u1QhhCh1mLqurIJFrBdA5iv+PMlMA
         tlK7oVHeeRGYU44W4u1gf+dH/tJeGvYe9ruP1a+4bcroliSBznuJwNNFiwm0vK2n7Kps
         1zBnN87/Qb3dENUTixohUs/0CUeEFD98ZLB7ttWT1kp8ceprqarsf7z8JzFxDArMFH1l
         0McLH5/jBgP22sP496rmkT0l4e4v3EpnOEUx/JZahz9GdG7KMpgzqmVOAkG6zvYu07O9
         ZK1eG6U/2BqpDtdItJz3BIqSzMWAlezYluhaxPuGd2SuBfloRwMiCgqqEa1Dp1WSSuAV
         HpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776928; x=1789381728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZhjTAmwyW+i7ADmwUXpM1rxtxgoKnriyct2cm5k19E=;
        b=MmBc/6uFvD85efPzL0/QumbvPDPpsETC4zWzLdOlnPxmo2sLvHoWpLimKi+KAi0ID6
         AE04dAsowA6Yosfl2b9RKAgtGJeAAYPiQrDTKgfMzQ+DRTEKkW/moJq5QJ8tqIcG7g3S
         pa/AYY50vQQCFs3KGKiTc2mFyRyt7wAYMS4/FpiEu4q8BnECp+rtRbanfSh3QOy3QsAe
         omMxvdEsc5Sj9+uoJLJdfqGdir8BxzMn4RRteqnzf8W5VgyJtodr3B5Vr6sWtuVZZInv
         BowZsNFsTNu/tPwMQ+ITOW6gHn4CTdcx5MTF1cwV0MKaLi4SGLbwgBg+hyMn+VazLMXy
         MNfg==
X-Forwarded-Encrypted: i=1; AKwUvBxTwqmIj9t6iPdZ7dI5Kkjukv6nGpQXjIhMWYzcxl2ob4PsWV7p1M3Pb6a4s+8p8qXqtPsYSZo=@vger.kernel.org
X-Gm-Message-State: AFuF++mgZ50Nh1SZLPIMM0YoyzHvc6ZeM4aIYPR8FW3E0jElGPd3gpP2
	FrgUFJ39U4lvQT1KlaAbylcu9a2+qYyxYajtTJ5op6cwzaMxPTJxjX/S5cUooGpgeJo=
X-Gm-Gg: AYBFou21ifGUP1kNH+WZeqERiFISR+0goqBHKE+ggbmtqrwoH1Xl2jAlPG9yqye6oe6
	LAnXhsDL/ZlUgtVtpoVd2/WaF62e1YJCRotFsEdBdoezKp3wtQNro/m3aS6T1gTLuZNXrIpqHdo
	v+OBJJbtY3StqdHdj1h6UdbFWbiiwv7WxZIKYD+wFG/JJ11C29ZAmoeSdKZ3sDSb+vqpuqnm0v6
	OEXG8ddfrXCRE8g4Jd4qJlyA53CP1V9zQ4HhdWmYgSgC0jt+XjgNS1w/cOSXOvfh4w7C/BC32bY
	Zj7kDxTvvPfuZZyZ+AAZNUAsBuIDxK/CTNByaOTquO+9atg8VERJlLMscQLTYrs4qOVMJgy59Bk
	eTQQ6onoo6yhcn9zVtdHQ/98XgtG2bMAXvCyEYouCCQwmmc94oxBF7c/LIFtiM+QlExDQfc5jbS
	T+pIyeuF57FeFigfqYmphkBxIaeKOMB/inQN6HhoX2rogFYr/JllGMAeebyqHCY6Gwt8Agmmrv5
	PJfthrLhBFcEG5Nt5L2B8T+HzYl98JlqZwnsA==
X-Received: by 2002:a05:6000:985:b0:485:8b95:706f with SMTP id ffacd0b85a97d-4858b9570c4mr18007364f8f.13.1788776927892;
        Mon, 07 Sep 2026 03:28:47 -0700 (PDT)
Received: from ?IPV6:2001:a61:1340:dc01:654b:3cf0:59cd:498? ([2001:a61:1340:dc01:654b:3cf0:59cd:498])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm27384160f8f.4.2026.09.07.03.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:28:47 -0700 (PDT)
Message-ID: <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>
Date: Mon, 7 Sep 2026 12:28:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
To: Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
 <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.09.26 12:01, Johan Hovold wrote:
> On Mon, Sep 07, 2026 at 11:50:41AM +0200, Oliver Neukum wrote:
>> On 07.09.26 10:47, Johan Hovold wrote:
>>> On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
>>>> On 07.09.26 08:55, Johan Hovold wrote:

[..]
>>> Looking at the implementation again now, it seems further changes are
>>> needed to fix the implementation, though. The completion handler should
>>> not be updating old_count. That's for each TIOCMIWAIT to do.
>>
>> I am sorry to be obnoxious about that, but I am afraid that would
>> break TIOCGICOUNT
> 
> Why do you think so? TIOCGICOUNT just returns the current counters.

Yes, but user space can call TIOCGICOUNT multiple times in sequence
_without_ calling TIOCMIWAIT in between.
In that case the counters have to increase if a line changes, don't they?
For that to happen you need to handle a status change in the completion
handler.

	Regards
		Oliver



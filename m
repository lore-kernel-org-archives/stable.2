Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE0145B27
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404269; cv=none; b=kMvbyRf3vfo2/jcepZPPv8HFalXdyCkzQyRcA1pR6xg6Sq+HYnl6tKq5YUK8zAej9Bvdd3ioA0IlwpzRyDLjWQFYxPxq62WfPweXbJWQxFmOc1wJYRfwvQ5jj3+JlBuJSxNn1kwWMnlDjFZz9w0EdvSGHnGXXg6+NBJOZWOiEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404269; c=relaxed/simple;
	bh=f/GwSDcTuNxj6GI0IAdppKyMtlQZ5eLCPoEtFeydlAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwvFa+jCBrmnMsNULgo7Rppi+Jz6F3+ijJ82l3Fq/qDmwtcGO86yfkGRCIamgo3CCGiRt/p5n51AECqDTppCeCfXWTEcDn2diDhT/VAsbcQ5Q9FF/DA8tmQfFlK6MAmwOHq7qA/ADZFKOahidp4QRDd7qAJMtkvMUwKYwjX04tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=yvWFLm0O; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="yvWFLm0O"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1867944f8f.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1791404267; x=1792009067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpvtus2Gmr8I4a/o4HiiEj3yjRD5bzEOhaip8SrB8nI=;
        b=yvWFLm0ORuyZ9yRXtqUyLnLImvGJu4Qd8Yu4de/2uHI+VAeGV5VtiJ3Q7kMEtMCPkK
         YSfEvepc9vBOk8LWmAm4/PQn5cej606zKCmPFuwXuJgXlWlv/OV8dgJTHhC81OhunJwx
         K5Rs3lcHAcyTAaLm6H2s6gbnD3SEWbmJvTym7NSDqzOkOtSiDsgLDpTspm5H5YfoH8Ya
         blA6YhfbvY+azjKczPEg/T+xAc9wNRohVcwXQH/3Ma0sICEv3IHkhtpZ75vcuPRXRyI7
         ijO25MeyRmzrTUcvDNhXXYYlNsPHwc78/rkS2vPVkt2XxpS05tiOMuikzflEe4OBKsQ/
         ZwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404267; x=1792009067;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpvtus2Gmr8I4a/o4HiiEj3yjRD5bzEOhaip8SrB8nI=;
        b=hSyxYI12L12mtdbmycZDxNXrsnRYf5WKEOoi+AXudmd0FDKvJrbiYqWETJv+/0rMwv
         8JMuePMNTvetsA3JGYspGK2iSwClv7FRtllCYuiFIPBFpJb/ssQpcJz5/OiVysZo2/kl
         xw7CBUpsUEsAfbztlIHRcxWRHjamAGG9nBWFnGBokuPKYT7Me95mBwl9N8rCEB/SmZ9i
         N+OvRx0B6eBgqClLFkHGs9Y6T/ssxTKu3BwoLe42WSfXH3WT/xDGPUR9b2nKE9Qjn2eU
         WUq0aheyfdBMdL/WXyB9z4OyyQKE/JOjAFOk7rhPmv8lxQrG57SN+49UJ0gu4SING1yX
         Cpiw==
X-Forwarded-Encrypted: i=1; AKwUvByjNc0ZxkdjAxbeP5NAImw848Qf18V3AukCR55hBB6IYL1E8knPpkFHAf6bOpZEo5UiLltvSG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS/6ZCCXojjIND813aHdr1WYWvqWmmg9uWpvfvxVXO6nW8g/FV
	d081N+QvHSKJQujveINSW1NeqbOtstmiaIXsuUv0ToqAl9r+DmOUiube4V7kecZ3oWMEbaqcJjZ
	ZX1jZi+cTSA==
X-Gm-Gg: AYBFou0eLZ48nCrYs+XepW29GSCriy6M2KJ0HbT4gomIT7yypnpNxT8mFvlPxEJEmto
	dsrDaZq44VpppuDfJE5aiLFgdIF4hbZsSbz20dDXPcvRydmeqBjgaRaLJgTh4viO1gcNoRibw+p
	OVG83eyHPrUr8kZDZ4t46HXUZZOB5PfrsMZAOup0hsWqmWoLHY/gqJZZLdkII//ymDwwxLr/dMG
	+5HEnskKIv4feenvO5hRkvkWOmX/zM7Md0yjRShW1D7gN3RtTgQBbTQxuNYXBuWYKD7+LdqAbKh
	XsMGdar64VN08W877drn2fqtNBzmZJpNRjer1IPPcZ8wPMbQvAq3fl+7Py5RSyh6TndgcrFUec3
	25o8bpRP6KJZ2u/5DSDLumwP8YrW2hmOjDM2W1+Ai30ytC0c/VQaAf+PFa5EhGpDnCblcubWEXL
	upjZZD5EGO4XAqvO0cFiqVtt58Bp8qYZaGIpow9/3QsuwVgTOjkni2QAZSNev1hymqLH4y4QEn2
	MkeAKjaw4JVzBGhjX8ytslZac74QefC+QHCfqeI
X-Received: by 2002:a05:6000:41dd:b0:487:27f9:82b with SMTP id ffacd0b85a97d-48c72886689mr6669566f8f.32.1791404266599;
        Wed, 07 Oct 2026 13:17:46 -0700 (PDT)
Received: from [172.16.1.199] ([31.221.81.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1ffd2sm7005500f8f.34.2026.10.07.13.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 13:17:46 -0700 (PDT)
Message-ID: <33f685a9-1140-4b4d-a40d-8250ab93e500@davidwei.uk>
Date: Wed, 7 Oct 2026 21:17:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK
To: Jens Axboe <axboe@kernel.dk>, hengyul@cs.unc.edu,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261006125732.3425762-1-hengyul@cs.unc.edu>
 <01d75013-9eae-4ec6-93b5-cc1b2b83b791@kernel.dk>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <01d75013-9eae-4ec6-93b5-cc1b2b83b791@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-06 16:59, Jens Axboe wrote:
> On 10/6/26 6:57 AM, hengyul@cs.unc.edu wrote:
>> From: Hengyu Liang <hengyul@cs.unc.edu>
>>
>> Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
>> 81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
>> allocate the rings with io_create_region().
>>
>> However, io_create_region() charges the memory to RLIMIT_MEMLOCK, and
>> the rings had been exempt from that limit since commit 26bfa89e25f4
>> ("io_uring: place ring SQ/CQ arrays under memcg memory limits"). As of
>> now, a user without CAP_IPC_LOCK gets ENOMEM from io_uring_setup() when
>> their rings exceed the limit, which is 8 MiB by default. PostgreSQL
>> developers have already hit this in their io_uring tests [1].
>>
>> The issue can be reproduced with a simple liburing program, run as an
>> unprivileged user:
>>
>>      #include <liburing.h>
>>      #include <stdio.h>
>>
>>      int main(void)
>>      {
>>              static struct io_uring ring[64];
>>              int i;
>>
>>              for (i = 0; i < 64; i++)
>>                      if (io_uring_queue_init(4096, &ring[i], 0) < 0)
>>                              break;
>>              printf("%d rings\n", i);
>>              return 0;
>>      }
>>
>> Before those commits (v6.13), it prints "64 rings". After those commits
>> (v6.14), it prints "21 rings".
>>
>> This patch makes io_create_region() take the user to charge, and passes
>> no user for the SQ/CQ rings.
> 
> Agree that this is a bug, stricter accounting may break use cases.
> However, I think we can solve this simpler, and actually kill more code.
> How about something like the below instead? Only apply accounting to
> user backed memory, which is how it used to work too. Would be great if
> you could take a look and also run your test case against it.

Tested in a VM and confirmed that with the patch below the reproducer
correctly allocates all 64 w/ a 8 MB RLIMIT_MEMLOCK.

This change is really helpful for me as well, thank you for addressing
this Hengyu.

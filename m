Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600362;
	b=JnTYijf5LcIktTZK10VsKpBqta64dipWAIzYjCFA7H6FSpD0PLcsMNtADHwtAD82Mpax
	 Lah612g6pyGdL1HrGNuNX7d4npxQjDNtWIRAgijeYxO4q29pDIvMZE3DadHLTnOaKZVcG
	 xAF2YpwD8Svp5dRQN/Lpla5wJ8yy4rmuyKCSi/QdyzTle+Ah8zUWtmCe77cF3z/GGRRK1
	 m2XIN/7H6ifq9wbzkdN7FTC+JXZ8s59U3XrRe0IWCurlf5MwliqUQWEvKI0HzYsNO+dJS
	 LS/JUKfNgT3Y5nRaCddDSNvTikGgGdsg/c0F93RFkSo9QfOXpXjflYTZT13kCbgsYlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
	b=PEelnc/py83AO4ApKmqUrtdpavInEPj2J/0931BDhAzA0xrQe5oueyxmKJ9n4OghY2Ma
	 mJzo/DTBWBjKptB0t+huuLbZy+S2BRxfMIEA2exLeywLgUQcZCeM8+GoPDOEWEVVkBsW6
	 OxeKWqiz2LbxPojuXO7ACIJa4i1QomrdVMztIH5Z0VTakssPxJuE4N+xd5RDSWJxEGM8R
	 iZrIfRh3JWGdYyNuWfVPFXifXZ1SKQoUjbEthuh54ovgWjqC/ldkjEWl0MKHTtExQGz2Z
	 Z51rM9LPSxiBNEdyLO63rM7GkD8XB5T/4CuvK9ynU+b55UwASvyjquyX3A081kzz5hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ok0zsLYF;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317F606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0317F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ok0zsLYF
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so562577b3a.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792600360; x=1793205160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
        b=ok0zsLYF6Jt/8Qjs3Kouo2Hzmuakm+SQxEo0XQvD95+U0UY1ZRvyAH9axs1/PubNR+
         ySRUGtxOsFYH7B6eJCgGD35Q43GfFsIAm0ds7WDg5uKXytYT+K2bu/MiXsK96XEahIrr
         LmV5/vV18/k2UtrB48TVICp3aKT/FrH3PED1mJRwpfur3y4hfNR/I+rq4BGtX8PYXBYe
         xuvq3hZy4pyuzD7ozUn7eG6lO50PP1Rd+k0qvZMyaSA0Kew7qmSo4GZC2IkXbxrMQEmo
         kshvDGnk6gF7pa6O5v63sFlndH/DRnUPOP605Q/EmggJO2qII0sYznH5JUZoXWPa6TTR
         /hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600360; x=1793205160;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
        b=irHUnktSwJnXPBx2R1WBblN6M2BE+zSCd/QW9QJVVUeLypowLN4Mzyu9gPfwt54OeP
         nE6K35CXaYyXpIdp3v7GjLgf49wGxjVsbeAdW0c8dmnj1i0cW9B/FRHGqGjOaZpvwtHq
         yBgE96j7wMy+M4X5hZ5AAGv4gkCL5gTvu/QF84I1JXD0ATFSZaV4uLnEENtXRdrbir9s
         pcx1lB49A6+HqQ3JYTATDIcfnQCj5NHVGgwwcYvyUIGSvKeDfk+M7jar5xo7WgcFw3Wj
         gC9kyHB1Uo+GDkZ1aBJhHbzzqarnlsEYCng4eIm9l+3seyfJDYJb+NnKKoxJy2khuA5O
         UMkQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+zlM7kJby/h2ui1MnN6hAaOTW4yuem97bRnNdGGLfZltycKkQaSbVJmyRPtvVnqL29W5vvRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIf91gXaC9vR2e1lI9gB8d8j20XG4BChZwrl+UIHeGJ77ozQApk
	MA9bRSpMOdF7TCke2l8KYpcu0ZYaGX+BiMDIiluqHHV2RJ+nv0PMxwc3OkWbmfoVkJ0=
X-Gm-Gg: AYBFou15CkB6i0kgIXlFImnFWymDSGuyM8OxCvFGT/NpYpGQ/GajuX0q4cSyvrA91Gw
	HsycKJEy+ahEwYn+cZ1SAiddZtlWmW/j3wF1Xy1SD+yLzElfku5r31xl/pz7oUcThBlGsTkf/eo
	cZhhiNMWZyuaS+gQxxfXDT5ojdXTiVVO0pncLtlgJD8ZwE8ubcbAgISunxVWsgBOPLBbJrwi8kr
	MTAPRbIM6gXzggAR9/bpMvHT39FQlRB+uMBSyVCTST0WpTZEPch0lrrcyKsODv/1c3bnag6YYg3
	DiiPGB7PFTgn36er9T9utt1p54kU6WxulU7BgBHC0Fqmr0aWB5zHs2A5MMAEFJQrGTapA8Xr139
	QtjmdrIcJOINZgOCRDtKaxmgfq1ypZ7JQbRtPViQY4GXvt18rWW+i8W66PFvaQdJpmQbfd0WFSh
	AzRASLTxY+KNwXvAvgZMyBlv8jQqWSUO1hENZYSIsqGRy00FYCASN37odiNlLpuliz2Gdw9oTVW
	si5aiehpMHETizzEY65NKfsUmzKGxxR035R81Cgg8yvWTyLw3TRKcCyNkzd/45iUhLAE1ipVpDm
	xg8bfx+Pmcw0jvNwxSs30x36hp9PPtC3hGRs9cpwe5IAco7HsTlyIizxBXW+
X-Received: by 2002:a05:6a20:9154:b0:3e0:b445:5612 with SMTP id adf61e73a8af0-3e287dd624emr2111224637.14.1792600359159;
        Wed, 21 Oct 2026 09:32:39 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b8482048sm247328a12.7.2026.10.21.09.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:32:36 -0700 (PDT)
Message-ID: <db225771-106e-4014-bc43-3cd8f0e459cb@kernel.dk>
Date: Wed, 21 Oct 2026 10:32:35 -0600
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
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Bart Van Assche <bvanassche@acm.org>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
 <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
 <a39c904d-4d84-49ef-84b2-16db1b28b706@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a39c904d-4d84-49ef-84b2-16db1b28b706@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 9:18 AM, Bart Van Assche wrote:
> On 10/20/26 7:39 AM, Jens Axboe wrote:
>> On 10/20/26 8:13 AM, Bart Van Assche wrote:
>>> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 025a799f35b924d..00b75eb95dd943a 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>>>            goto fail;
>>>>          hctx->queue_num = hctx_idx;
>>>> +    clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>>>          hctx->tags = set->tags[hctx_idx];
>>>
>>> Why clear_bit() instead of __clear_bit()?
>>
>> Since this isn't a hot path at all, going into details like
>> that does more harm than good. clear_bit() is totally fine
>> and honestly preferred.
> 
> Although I'm fine with the patch as-is, I want to clarify that
> the concern behind my reply is code readability rather than a
> micro-optimization. No other context should be accessing a hctx while
> blk_mq_init_hctx() is in progress. Using clear_bit() instead of
> __clear_bit() might make readers of this code wonder whether any other
> context might be accessing the hctx concurrently with the
> blk_mq_init_hctx() call.

I know that was your intent, but it just reads the opposite to
me. Whenever someone uses the __ variants it should only be
for optimization purposes, and preferably with a comment
explaining why it's safe. Unless there's a reason to do so,
using the normal variants is just preferable to me.

-- 
Jens Axboe

Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D72E11C7
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172838; cv=none; b=lAbrYYUqu0ijyG46pKb3Bfq7DIBQJgK9xTlOIKdujPRehsVRYStZU1IMDwFdVrFmGUqEl/oNvgGmsIm1H6D/CGwShuPiqc3XhrWDgg7W9N1NMwda1JtU4EG0T/FgLzP7a3Ghj022iWroS0OPWDp/AP2G+XESrG7FyTeakIsaBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172838; c=relaxed/simple;
	bh=9COjZBjMNWPO66tZjXBlEbkfK1lABv+uJewU4IkvCLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7Zl8XGd58qsKw6axlbg/SuHtHS9JRq/S9qfaqRceV/e/sOUFDsSNyrdHHlfePEYf5YxSkHwTpkJ0ViROIwcRlhqlMeHJYMphAwdeY27hCC5Mrgcyb6o+lo2vDlEYXVXTNU4Q9vM1MXQzkCWSghy3adtuNiM3ycdS+unN7s715s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h/HxTYnN; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="h/HxTYnN"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6ac83a09781so138900eaf.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787172835; x=1787777635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpLEkKOKUwZ5t98OnGDW7134XoHRGbaaW2RNRtHE9rc=;
        b=h/HxTYnNJYJN9HTajfGS/sMJboOH7uF8/GNT9stKPox2vaDuTILy+eAOK1Dgt2JqmO
         UEtqSh1VQDWKMInax+o5x8kJMxLjRnt3qiOP9JHPjbY/PrjJsdnP7i72OYCmxbAjySC6
         KVKYnE0KUnTi6hcH8UM2gxpjCqBW6B26YfNXWt+AdswlDz7ieqa0+0qTPCFRaeXdn7GP
         oAIfbZn6NEBBB6IQk2z0xPBfpFrku3itSbXJpUXHboBogO7kluu6uzK7VOHkXBcZms2D
         NiwyBCVRQpQ+NSLzWCyCoDcYyvCKZLsQ+jAQ/ct6xlKIbWcq11HfiEeINadqslM9lPzK
         j53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172835; x=1787777635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpLEkKOKUwZ5t98OnGDW7134XoHRGbaaW2RNRtHE9rc=;
        b=fv1mXsZnLld2SqaFOJVj6YiAiOYNqJwTsE29cJs/0VD+gbqmWxXkhZ95oentd9oeej
         pomDBQY7UGnunn0smoPQoWLzO7enuOQsHcClvPOpaxY3kvLDymFsrGvXHsYpD8ljWUyk
         UfEJ0UDpcfj5sV8Gyihsi8sKl40/qs7QqeOo0KcD17ERTqniAKjV1BMz2K/ZnPfb5mzV
         Mtd+HbYosKif+TI4oomAStoJJ1iS2PU3uG3/mPqfaSonx1meQzO2rV/IC6uZIdlC/+rq
         g4wEf/pY/zMNrJuGiq/rHy3z9qA5GMosFYWF05ip09PZhlRFz4K853KoseAbakHlolsM
         9Jow==
X-Forwarded-Encrypted: i=1; AHgh+RpGVH/hOQL2TdgpOh0WPZ/T8t0PHaOcuWm83LvCppkuUt3UvUupxYR+GELeMb5lQGQ1V3Z7ti8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHtklIUS5RCUaQO9IWivhl31YfkVT+vCEoqt4gb8Yyji9r2rL
	/Kl11ho4q6zb7BAEG4JWCz9aWEaptDol5Ua7gRfqrtxgi6grf4UuCrzEDrlYEk1zDc8=
X-Gm-Gg: AR+sD10z+2JiuOvJlRRb7ZsYOKsx3CIR/meD2ItPl77qIEjoTmpGj+r3T+MT8TDLCts
	Nq3olf4UgcSVEBz1lCHrKIRmESFq/prBYL6a3PkekZ6sR4XqPGayrEfsmvz7Y44NsfD2Zd7E0gB
	mOFGT1OMx6ho9IQOZelr8zVXryajQqeiCWLSFgA30BrtBwOn8NZwzgnQYV6s/tG/D6VA+xhUJCy
	eRqIpwzv5XiPYAI9M460QHOGHYhTzcihLkagUM4j0QZ6xp2JmZYQFC/kpE9G6WYEvS0dgkWIvjG
	TdRNr23um9bWSItoLA8za2QiyLtFS80RMlaTm87EOxqs1NRmIJvpQyioFFFFkKWOnegEsdPFFqm
	VweJagNRD+2f14VGkS2Cv/oWPSStZ58DxgMwiFWfwfBnr6TKq7QswVOCeuTLwoXv5U5iB60Auld
	2jD9LnKb1F1Kah9WVlE+ezfKuXSs9XuIVgh6K/FCm8lOqS5HyJDK0LXFeI0hJHLEojyXd/BbHFD
	RZYQnyqD/Nb+PJVJ3+Y0ZQjffJkMs0AVo/FKuWlyOTv1laQAQE=
X-Received: by 2002:a05:6820:2211:b0:6b1:3270:23b1 with SMTP id 006d021491bc7-6b148fe8629mr1648344eaf.5.1787172835333;
        Wed, 19 Aug 2026 13:53:55 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb51ebdsm2839413eaf.3.2026.08.19.13.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 13:53:53 -0700 (PDT)
Message-ID: <8671f4fb-e9fd-4f1a-bb2d-bfba7bf1bceb@kernel.dk>
Date: Wed, 19 Aug 2026 14:53:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 7.0] io_uring/wait: honour caller's time namespace
 for IORING_ENTER_ABS_TIMER
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
 Maoyi Xie <maoyixie.tju@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Maoyi Xie <maoyi.xie@ntu.edu.sg>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260520111944.3424570-1-sashal@kernel.org>
 <20260520111944.3424570-26-sashal@kernel.org>
 <5a50c3f5-a5ef-4b2b-821c-5858d8b1ac13@kernel.dk>
 <8e853555-604e-46e5-8e25-a5f80b88e51c@kernel.dk> <ahG9meYUQ-YLDwHN@laps>
 <afe1ad86-3454-4092-88d0-bd9753a1b2c8@kernel.dk> <aoXlt3pcqsqfp52s@laps>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aoXlt3pcqsqfp52s@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 11:19 AM, Sasha Levin wrote:
> On Sat, May 23, 2026 at 08:55:43AM -0600, Jens Axboe wrote:
>> On 5/23/26 8:45 AM, Sasha Levin wrote:
>>> On Sat, May 23, 2026 at 08:23:13AM -0600, Jens Axboe wrote:
>>>> On 5/20/26 5:40 AM, Jens Axboe wrote:
>>>>> On 5/20/26 5:18 AM, Sasha Levin wrote:
>>>>>> From: Maoyi Xie <maoyixie.tju@gmail.com>
>>>>>>
>>>>>> [ Upstream commit 45d2b37a37ab98484693533496395c610a2cab96 ]
>>>>>>
>>>>>> io_uring_enter() with IORING_ENTER_ABS_TIMER takes an absolute
>>>>>> timespec from the caller via ext_arg->ts. It arms an ABS mode
>>>>>> hrtimer in __io_cqring_wait_schedule(). The conversion path in
>>>>>> io_uring/wait.c parses ext_arg->ts inline rather than going
>>>>>> through io_parse_user_time(). It therefore does not pick up the
>>>>>> time namespace conversion added by the previous patch.
>>>>>
>>>>> Once again - If you auto-pick this one, please also do the other one in
>>>>> the series, 9cc6bac1bebf8310d2950d1411a91479e86d69a1. Makes no sense to
>>>>> do just one of them.
>>>>
>>>> And once again, no reply. What is going on with stable these days?
>>>
>>> Jens, as I've mentioned in the previous mail, I handle the AUTOSEL
>>> mails weeks after I originally sent them out for reviews.
>>
>> And you think that's working fine? I would suggest that's a terrible
>> process. How are maintainers supposed to deal with that? Patches x and y
>> are autoselected and an email is sent out. Maintainers react to that,
>> either saying "no don't pick X" or "if you pick Y, please also do Z".
>> The expectation would then be a reply that says "ok, doing that" or
>> whatever might be appropriate there. Instead, it's just silence. And now
>> I have to follow-up MULTIPLE times to ensure the right thing is being
>> done. We're about 2 weeks into this particular incidence, and
>> hilariously, I still have no idea what the state is on your end. Did it
>> get dropped? Did the other one I asked for get picked up? Nobody knows!
> 
> Hey Jens,
> 
> So I took some time to figure it out, and I want to try out a slightly
> different process to address the concerns you've raised.

Appreciate it!

> Instead of weekly AUTOSEL dumps, I'm just going to do them for a given
> release after Linus tags it (so I'm going to do all of 7.2 in one go),
> about a week after the release, and targetting just the LTS trees to
> reduce the number of commits we backport.
> 
> This will make it easier for me to handle the volume of mails, and
> also reduce the number of reviews folks do since we can skip the most
> recent stable (not LTS) tree.
> 
> What are your thoughts on this change?

I think that sounds like a great move in the right direction. As you
probably recall, one of my big objections was lack of response when
issues were flagged. If one per cycle makes that easier for you to deal
with, then I'm all for it.

Ideally I'd want AUTOSEL to work _exactly_ like the other patches that
were grabbed for that stable release. Sent out the same way, at the same
time, and responsive when issues are raised. If you only want to do one
AUTOSEL per cycle, then IMHO it should be timed with the regular sending
out of patches picked for the next stable release. If we have 2 separate
things going on still, then that's annoying for maintainers to deal
with. If I was doing this, I'd have AUTOSEL be EXACTLY the same thing as
normal stable picks, work the same way, with the only difference being
that they would have the AUTOSEL marker in the subject line.

-- 
Jens Axboe

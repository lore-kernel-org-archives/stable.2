Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF93358367
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168873; cv=none; b=Q65Ywhqa2EIzE14qvAIwfaxBOdGrs/piXsoUwENyiPiDjERiSES0AButUxQWl9v2izR4dx1nNbmToijs2Uj7/BmpBZNtq00tPcC/VhbzdilDmrtbAUEXH3HBowzH5WqNXtauekcx+jcD8pckecs4hzigHAVEn3B0wqteS0zTGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168873; c=relaxed/simple;
	bh=Pzb59zMw9c7fwB8hvcrr8QRJvQWGAqOF8cL2ak6YFIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtidfeMwEQ1bJX/l7ONGewO5+ZEP7lyvl+72/AczlGBFPujkaMvmj+3gOP/FIrWfCCnLiY1Q1k8cnMdxR3V6alM8Z1BWXR+DdWZFpRrWit3qjhSPYZOTWo6elgkSFtZh2kaPq2yBp0wjABnkTIaX6g/lZiAODgM+0msMSIf1x9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PttccgQl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PttccgQl"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb4d8a21a8so982160a34.2
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783168870; x=1783773670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vnv6F3Vtj1/6ltkZgp+b4LZbO+GnTeLFfHnUVR5NK5M=;
        b=PttccgQlNRCr3wurfzGx4bqKI3UG7Gg4OIrCXWkssHjJ/HX8wuYSoAj5FAXEjpjc/a
         n90njfjctqDhBfnngNLpg2x8uJJ9nxjm4DNReiJN2Pp79HrDkniDTi6FCJkTUkVIzuac
         uWdk6ZYpWtBDaGfEK/IjfA0FmIy6zKI1kIJ6rX7OFwTkzFSGRNqdhXzl2XIbwchUzJQU
         108mlAdBK+REg32I3WVazQnfZxIDxuFFua9sOqb417pZ6g5OiC2y7WKzQuAFJC++aJIj
         Gxye4G2u7Nmqe6kD02g6ICkdBsaEv0llCKmMDRSf3PpWOxHPM8tXMTrrupkTko5+Zh0C
         10UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783168870; x=1783773670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vnv6F3Vtj1/6ltkZgp+b4LZbO+GnTeLFfHnUVR5NK5M=;
        b=DpksJYRTMrK7PwU7kd0XaiuttFXAIRzOzXrIOWBfjdmRJEvoF4rHS58olx8xUtokn2
         jpH8et9TyeWH9+Pr1Tc4e7UEDbWAhGTtHNv+7R/0NANUQmaVhuN/raMnLeQ+UxBTS9ow
         fr8Qaq4L4KpS/3WCbcMUHR2JfocY1Jt9Xsj9KLsrB947xzSrLsPIP6xtew6OSWSOWYse
         7xPbU+7+B2TzLfGajLSVEf2GHe+Nbd7D6qddYjmJUlaQOVotHtpmLVaggPj5hOhbRKC5
         cc1bRr6Mr4EbAN4g/6Yi/Alj+OKxFSZMzxR5pkEnAnuktJhe8eLQuC/f0dov06oXuhJl
         wbdg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZRy3tIBKs6ieJVWpNOEDJ86lo8sesW8+EnVfPZPdMiu4YH/UOJPvOKv4yp+S7gtCIoA4g4l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5R6I/hpgyPSt3ziqTcpV03zrDGbJkLZmFa7gw8+v4N9YHVL9
	rhSOQkbLW97RF1beJnTMtjtjFqiaPak9BEyMIU4AzWgyMNPzjORlzRQqNFNQuHhKzl4=
X-Gm-Gg: AfdE7ckP6GGZxWeO6wEpVMnjGG/eCBmW8k+YHAFYBV5ri1yxs4ahSSTjd3CJJVSCbi+
	I+HkY0H55cOlt/L2KoooxbtCfB0j563abxeVYVWpJLAMXG1f5/tEw5g7drhqe8IPfxtnYoGt+iL
	Aiz7w8Jph5xZYFxXrJZNyvW8PagSyKtmUYnLOPQahlabqOG36FbC/U1n6CEc44zTw4U3d1qYFat
	HjUObtK7NljIKwTopqMt5ijsbEkc0OC8MNGSQpirFcCfE/utcfz9ztU7BlyrsT9FMk3j2vG0HmL
	zquLgIii4tSjHjVNPScW/GwUZbXdLzp6+KGNuMqzQPqSIm8sbEGYT6Tn6tB1NrdxcKtz/gYGCiQ
	gA9pLqgtKbbNJzbCxcD7mamB1O88Tavmh9E/rSTLLI64LpGlpEE2ljXzJC6/LQc0oMVdtolYZF6
	llUiM2tjnz+2uIN1enPgYobD9Gup94IDqpvR91lcjJEpZtDBWfmPs+EUfKTiBZwXgafT0Fpa8=
X-Received: by 2002:a05:6830:4987:b0:7dc:d2ad:fb17 with SMTP id 46e09a7af769-7eb7fef910cmr2036102a34.20.1783168870488;
        Sat, 04 Jul 2026 05:41:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542f07basm7412639a34.10.2026.07.04.05.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 05:41:09 -0700 (PDT)
Message-ID: <4a05f7e4-d831-4696-8d34-7e976839b4b2@kernel.dk>
Date: Sat, 4 Jul 2026 06:41:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 044/108] block: invalidate cached plug timestamp
 after task switch
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 stable@vger.kernel.org, patches@lists.linux.dev
References: <20260703123236.3139759-1-usama.arif@linux.dev>
 <2026070315-stable-reply-0015@kernel.org>
 <eeec321a-fd07-408b-9d64-c4d65ec92935@kernel.dk>
 <2026070416-bannister-charred-76c4@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026070416-bannister-charred-76c4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 12:45 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 03, 2026 at 08:35:46PM -0600, Jens Axboe wrote:
>> On 7/3/26 8:05 PM, Sasha Levin wrote:
>>> On Thu, Jul 03, 2026 at 05:32:35AM -0700, Usama Arif wrote:
>>>> It looks like this patch was backported, but the preceding patch [1]
>>>> in the series was not bacported to the stable branches. Both this and its
>>>> prerequisite have the same Fixes tag.
>>>> Not having the prerequisite will result in a NULL derefernce.
>>>> Could we please add [1] to the stable branches?
>>>
>>> Now queued the prerequisite fd38b75c4b43 ("kernel/fork: clear PF_BLOCK_TS
>>> in copy_process()") for 7.1.y, 6.18.y, and 6.12.y, thanks!
>>
>> This is a problem. Can some light be shed on why only 1 patch of the 2
>> got applied? This could lead to big problems, which seems to be the
>> case for this one in fact.
> 
> This is on me, I only took a "subset" of the patches tagged for stable
> for this round of releases as I was facing a huge backlog of stuff
> (everyone loves to wait for -rc1 for cc: stable fixes), combined with me
> having travelled for 6 weeks straight for conferences which didn't allow
> me a ton of time to do stable kernel work to keep on top of the pile.
> 
> The patch wasn't lost, and is still in my queue to process (along with
> 748 other patches) it just wasn't obvious that there was a dependancy
> and that I had to take them both in order, that's on me, sorry.  This is

At least this one would've been avoided if patches marked as fixing the
same upstream commit would never get split. Which does seem like a
(very) sane default! Particularly when they are part of the same
posting, it's not like they landed at separate times.

People get busy and life gets in the way, I do think some fixed rules
like that might be helpful.

> also why we have review, to catch things when I do something stupid like
> this :)

Agree, but at the same time, requiring review to catch these is fraught
with error. Not only do maintainers and developers get a lot of emails
from stable, we need to carefully sift through them. And rely on the
original patch author to do the same. Which in this case thankfully did
happen, but... People also don't necessarily pay full attention all the
time, there's work and vacation and a bunch of other things that get in
the way.

This is different than normal review, where inclusion is gated on the
review. If nobody says anything, it'll go in.

>> A Depends-on could be used here, but it's pretty hard for a submitter
>> to do that, as the sha isn't known before it goes into the maintainers
>> tree.
> 
> Agreed, that wouldn't really work, and isn't normally needed.
> 
> But again, maybe trying to get patches that are cc: stable into Linus
> _before_ -rc1 is better?  Hey, I can dream...

I send out fixes _every week_, -rc1 or -rcX changes nothing in my
workflow.

-- 
Jens Axboe

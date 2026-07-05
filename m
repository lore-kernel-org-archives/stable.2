Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA92F8E99
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292744; cv=none; b=G6dVzjvkxKMYiIm2kLUo/dsEgG6eIzzMbsIU9IteCu1FdLrmR9UR2XVzV1RhBFI8xrjgGuQPvtLS106rtricmVoj6tOfA4EMX+ZVQkVy2eyfWY4UfwK3sGL3CV6IQyYU6QZMQew6kRlF/UMC70uifLCoOdGdvBTayDgMlu6OYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292744; c=relaxed/simple;
	bh=0puW1GlkLrKjuAN52AnZ5Av6soFnbeaQxVhz4+sbgPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMeIu4rPOQ+svLpiI8+1EFJEJHOrWiQ9O2+7ulafoWwibACXY6rB4aBZ7SxcD0e3pI3/VzFrFkD60eYH6Mti+EJApFD8KSms/a3GVRkyW30xTGf2O0eYo820yiVqJZ7ScYstpnRoJSGb/jm/u2zlrk0jD/vVkryDrRd6QlSytWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=N+zxJl6I; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="N+zxJl6I"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6128bd9b3so1045665a34.1
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783292741; x=1783897541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvAz5x8LchaZtxQrMlKYhRGP/HbrS7tesS0/zUspz2Y=;
        b=N+zxJl6I7pDyzEjkLCWcgkYzHOvUs/4CWB8bzssu1UqAR3mT+f3jPOd6H9GtcERceS
         aR4/s9BZ2U5A09qjLeC+4KsE1voThS0rJVJkqwdsAjTpTDChBOySCTe6g/Xam5pTkdso
         74GkmwXZLoDMgm9zcT4khow1Y9j/nH+L0w3ip3eNuWqjp54PlyPtWXjwtXlcjvZCOHmL
         edoU+tY3diro1wmP3nhH0OhMDUrAXSRgi89Qi7JdV90yeNT5YlmI4B6zoJdb0nGyk+si
         TGWIwYrP21NMDjjHPWXKEzF5VdtlWW4mCjS1q5uIBXUxpxCYhO/0KyOZxPjA7vCFs3r2
         pvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783292741; x=1783897541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvAz5x8LchaZtxQrMlKYhRGP/HbrS7tesS0/zUspz2Y=;
        b=du2uy0fi1UVVqkvcclrA9W027sQf3/RRPyquNEysrDcyRK5MEHHuQlCBPMYAUIAl3Z
         SOCTNJwLg7Jcz4oKDGFCe+ZuKL7tOkLn+QPGhQjvBpYK/pGl6bYzMkUPIOEya2rgY9CO
         Uz9GuiXs6zhHb+8B9ocBdk4kMGPj22jI1nRgAmN0jKa2kOjYQb8eKKE6jx2eqsHPAFCY
         UMuSB6Las/IPyb7OwjkPbpB9MOjYf806tfF9HpSOHHXxykJcUeclRIrAJzo6cWiaJYI4
         wqH/0h5JfcVIMoJG1VBskYuvWgNivTR0YgkdE7rIwG1P7oTSiZS9+FlwjvdixELvKOoc
         Y/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nmBmE31VpaNDQ/1oDIdAjLtJy9wBzEzmtGYMxdrDKOn48IFByKrPeoWxIcjB8qUQCcG5ZF+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgfHA/mF+KaBBwwGNMVhc9cvlv1sKG3NFWAVEu4GG2D9rvVVA
	YPdXurQYlxt1VGYRJzECyYpK2YCvyePQqhRGOHLRvrti6oqHyJgMxfV8O0InX5XykjM=
X-Gm-Gg: AfdE7clwtORJ/Yo/WGIunoBeM/RP5PPVirtDi2RBxwAoiSDpFhh0VUpXpo5T/lbMCmS
	8o7OLdtM7UtBV3CGAUBmOLtqm4tXWLzavtFm5jKUDGixbrmtKmiFVDNEHKadIx364CG2W6XwuqY
	4mt/8PrY4yA8RlyBDaC61QzCioQeMi0d8jl06d+xupPNpALsZ0+2i4PbHPDwlow1GTV1F0hZzRl
	37l5APE3VsTPNU1gaoU7sI4LQv2tmkizGCH+t8ZUA9UWktF26knnSjGl0gs9ISoWXSWD+XuU07G
	LU2hNz3UnzRGuTFZ4LfzJu7MnUVD0okh+wQDZRGjLvU7ELx+UjQJx0l+6ccvJBFoIqDvWkJGzQY
	3G00JXkT6k4tmMAl6KPCWV74eab1nG1BkCb6IW83Dxh4w8UWn+do0d/V42KEALSrqrzjCWvI6CA
	v3cf7v5VsIv41rYYcVwbyDCRtXTCw44nZ10rg3zkJtRu8zZD2P90AnB9MaMkmt8omRo/iwssA=
X-Received: by 2002:a05:6820:1352:b0:6a1:80a7:2c9f with SMTP id 006d021491bc7-6a32f67f473mr4299633eaf.58.1783292741274;
        Sun, 05 Jul 2026 16:05:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a3103e064esm7735907eaf.14.2026.07.05.16.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 16:05:40 -0700 (PDT)
Message-ID: <6504fee2-a8e2-4cc6-ac60-524160710842@kernel.dk>
Date: Sun, 5 Jul 2026 17:05:38 -0600
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
 <4a05f7e4-d831-4696-8d34-7e976839b4b2@kernel.dk>
 <2026070536-showroom-unlit-4f84@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026070536-showroom-unlit-4f84@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/26 3:03 AM, Greg Kroah-Hartman wrote:
> On Sat, Jul 04, 2026 at 06:41:07AM -0600, Jens Axboe wrote:
>> On 7/4/26 12:45 AM, Greg Kroah-Hartman wrote:
>>> On Fri, Jul 03, 2026 at 08:35:46PM -0600, Jens Axboe wrote:
>>>> On 7/3/26 8:05 PM, Sasha Levin wrote:
>>>>> On Thu, Jul 03, 2026 at 05:32:35AM -0700, Usama Arif wrote:
>>>>>> It looks like this patch was backported, but the preceding patch [1]
>>>>>> in the series was not bacported to the stable branches. Both this and its
>>>>>> prerequisite have the same Fixes tag.
>>>>>> Not having the prerequisite will result in a NULL derefernce.
>>>>>> Could we please add [1] to the stable branches?
>>>>>
>>>>> Now queued the prerequisite fd38b75c4b43 ("kernel/fork: clear PF_BLOCK_TS
>>>>> in copy_process()") for 7.1.y, 6.18.y, and 6.12.y, thanks!
>>>>
>>>> This is a problem. Can some light be shed on why only 1 patch of the 2
>>>> got applied? This could lead to big problems, which seems to be the
>>>> case for this one in fact.
>>>
>>> This is on me, I only took a "subset" of the patches tagged for stable
>>> for this round of releases as I was facing a huge backlog of stuff
>>> (everyone loves to wait for -rc1 for cc: stable fixes), combined with me
>>> having travelled for 6 weeks straight for conferences which didn't allow
>>> me a ton of time to do stable kernel work to keep on top of the pile.
>>>
>>> The patch wasn't lost, and is still in my queue to process (along with
>>> 748 other patches) it just wasn't obvious that there was a dependancy
>>> and that I had to take them both in order, that's on me, sorry.  This is
>>
>> At least this one would've been avoided if patches marked as fixing the
>> same upstream commit would never get split. Which does seem like a
>> (very) sane default! Particularly when they are part of the same
>> posting, it's not like they landed at separate times.
> 
> I have never considered searching to show which patches say they fix the
> same commit.  Next time I do a "not all of the patches at once" I will
> do that.  As this hasn't come up in the past before, because normally I
> can keep on top of the flood, it shouldn't be something we have to
> institute very often.

I think the relationships are probably a bit loser than "fixes the same
commit", could also be things like "these two patches fix commits in the
same original series". Actually something that would be ideal to just
have an LLM vet, with some basic rules, honed down the line? Stable is
important to me, but it does feel a bit fast and lose sometimes, some
more process (and particularly automated process) might not be a bad
idea?

>>> also why we have review, to catch things when I do something stupid like
>>> this :)
>>
>> Agree, but at the same time, requiring review to catch these is fraught
>> with error. Not only do maintainers and developers get a lot of emails
>> from stable, we need to carefully sift through them. And rely on the
>> original patch author to do the same. Which in this case thankfully did
>> happen, but... People also don't necessarily pay full attention all the
>> time, there's work and vacation and a bunch of other things that get in
>> the way.
>>
>> This is different than normal review, where inclusion is gated on the
>> review. If nobody says anything, it'll go in.
> 
> That's because these patches have already been accepted into our tree
> and gone through our review process.  Backporting them usually should be
> trivial, it's only the minority that are in series and dependant on
> others in that series, so this doesn't come up often.

Right, but they were sent in for a specific tree, and all dependencies
were either in that tree already, or part of the series. That's
different than the stable side.

>>>> A Depends-on could be used here, but it's pretty hard for a submitter
>>>> to do that, as the sha isn't known before it goes into the maintainers
>>>> tree.
>>>
>>> Agreed, that wouldn't really work, and isn't normally needed.
>>>
>>> But again, maybe trying to get patches that are cc: stable into Linus
>>> _before_ -rc1 is better?  Hey, I can dream...
>>
>> I send out fixes _every week_, -rc1 or -rcX changes nothing in my
>> workflow.
> 
> Based on the huge number of patches for stable that show up in -rc1, you
> are in the minority :)

While that is probably true, I also think it's unavoidable to have more
stable going patches post -rc1, as lots of late fixes for eg 7.1 and
earlier end up being staged for 7.2 and hence end up as part of the
bigger pile from maintainers. Early in the -rc series I'm more liberal
in what I apply for the current version, later in the -rc series there's
a higher likelihood that fixes that should go to stable does end up in
my next branch and go in over the merge window. I bet this is pretty
common, as we expect upstream to calm down as we get near final.

-- 
Jens Axboe

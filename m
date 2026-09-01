Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707E3DDDD9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228160; cv=none; b=lJKLgq+Q+yIXumvbyXepjBZf1R+4RDQNcXC/SkLYGB1j/pchmuNhh0vHgWPOWQ2Hk8s4A9InIceQaxZuUkbY65wO0v/EVn1rIpOUIPdTaYbaoxbXaurKv1Zda/DoJayEf0WJK5lyHMNVsANULMMlVFBdgyxuA0qNDvjuxB2Od5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228160; c=relaxed/simple;
	bh=DKAZQ4HB8RVRyPINtHAlvihaYgNW2N0m1l6ppV9ct0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqeXQcnC0ug+uZu+8bPdaAtMLTd/unLRAl//EFvhnY9CBMOPEbysH3q2F+f6uP97l/m5/JfCCG9Pj2tY9OKvydSQLrXskxTHH6Cvew+BdQDEinkSGxZtUxbs9sYwKqSr6gS8p2dbngQK8usTv239UlDAMiHGfj7Grg2+un7VJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3ypPjrY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ypPjrY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so4329166a12.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228148; x=1788832948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xndijz6hV8q9in3RSA1ablFs8VlKyT94mnXwH4oGlXE=;
        b=m3ypPjrYii6n/6JqvApbVSBQwf8fPWfJqr5KrTxkCaHfpDrNumXOJkTKe87EZmT5u9
         IFVhRFkYDnKN58EWJ8zfCc+GHPPiNXfFWEinFk3sIYoCK/C1eoKS0FNX8qGIw0Z5bDd5
         ivUOg7CqLSC03SLe53kynnVI8AilnfyBraZBwMkxVCFFUpHLFHyefp9qfRqAG6A/jb2g
         k5Sv0eg5pZsZivr+0WDiBHbZnC304OTSOwa5WHh38xNyRSAFrrPWSzqysoqJ8EEedmRM
         6gEJigwdlumWYiEmU2qGy244xRLLir7TrHpd+BjZ7coUA+BbvZeB4N+GGRDQcbhq6wOK
         1mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228148; x=1788832948;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xndijz6hV8q9in3RSA1ablFs8VlKyT94mnXwH4oGlXE=;
        b=m3UrTi7SGD3TGbnQ2pFIcpGcO5BUH/qs7YcXamP5tlzujuaYWKrh9cA9iwAZ4T/+MO
         5iQiIKXLFasnoovRpEAId4fEYOOP025Ay+e8kiTpq5De+HCf0UiWoVyIqllFbsA5Uatt
         V2E3Vs4ke1N2XHe8DZbamISpv6Z4PqB+/oRsq4sOZZwx3YBkUPbTNZ+5yHDY9cY1Qzfh
         DyOOCYj51NQqZ+EWiFgyvRZkfS7auoYkA0mTj6hrxSfCezz83KVl3dEeawKSKgW4pVD9
         nqyAz+fggCxVzUuZ8v11QCepou/lPNp6A4NZiOTNELChId2SsHkqDqpBnD+y4jx8snWs
         CngA==
X-Forwarded-Encrypted: i=1; AHgh+RpAhY4M01w3jssPY6t/+VqhrNyb+BahmsyVYxuxE75znlD2VizDRM5nPrvocwH8FGNh7uaxDrg=@vger.kernel.org
X-Gm-Message-State: AFuF++koDDMtZa6E5XKJ+QoFB3+J2TLHNXVarrqrEXVCmsaYsX7Kb+zm
	a7UwcUlqfT2Oi7PksKcdULgSMoi8rtp6Lql4IkZUUQssn4BZQj2jw3vI
X-Gm-Gg: AR+sD13H1pvr9Jn1W8e4tLGcgJxUhzixZQ1P9UzTfSQgO5k/gUm7cQ5cKKEwGslXEuv
	qiy8gwLw8rFCeaTRrQJCDoT0DF/+m234uqJ/u5aoib5e4yR9vDaMrN3xda2i6h+I8b+SuFS7Hze
	uW0NOC8LCdz8YvyDi2iGIXRLWB1sqXQzHVv2WPOzoOi82BxLRJh5NQKRMW11HnX3zoJ12GFkMfL
	jzVme1MU/4SkypEUDAy/KdLQqBk0wUQkozR+HYmy3cmzxStk0ITLhZzcR99nkXeK5DqSSZlTYNF
	PtUzdmyi+Ro/cxF4P2dFxqI73zZZhBts5tclW8a9SrSjy/VTvqpX0HbLCabNObib+qh8o9aLVVA
	AittwEKTnXVwSQ04+8HrNJO1u/4DGesNFPe7rEMR7nEXfgiq/i8XvdE5g7VJ4HKFfr3QQ1KucKj
	JpuXUD6Qt9xG0fasL6+5xi/C8wkQF0GlWt0S4awPLVy5KimAHGlRZRv2OfuSct9T3rVwx5BK3lY
	bc3MdID
X-Received: by 2002:a05:6a20:d502:b0:3d3:aec2:4dc8 with SMTP id adf61e73a8af0-3d7b0548a7cmr8045683637.20.1788228148286;
        Mon, 31 Aug 2026 19:02:28 -0700 (PDT)
Received: from [10.240.116.157] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36e8ee6sm5115496a12.26.2026.08.31.19.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:02:27 -0700 (PDT)
Message-ID: <7b007eef-2f6d-c86a-065b-85eb85b5ee0f@gmail.com>
Date: Tue, 1 Sep 2026 10:02:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
 axboe@kernel.dk, bgeffon@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
 <apT-ocFYDmU6iC-j@google.com>
 <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>
 <apVK4g2ikVJe_Hcg@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <apVK4g2ikVJe_Hcg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/31 17:38, Sergey Senozhatsky wrote:
> On (26/08/31 16:37), Hao Jia wrote:
>> On 2026/8/31 12:15, Sergey Senozhatsky wrote:
>>> On (26/08/28 10:24), Andrew Morton wrote:
>>>> On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
>>> [..]
>>>>
>>>> Thanks.  Sashiko asked a couple of questions about this change:
>>>> 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
>>>
>>>
>>>> Does this early return prevent marking valid boot-time pages as idle?
>>>> When a page is accessed during the first second of system boot, its ac_time
>>>> would be 0.
>>>
>>> There is no possibility for zram to hold pages during first second of
>>> system boot, regardless of whether zram was configured as a swap device
>>> or as a block device (mount-ed with real filesystem).
>>>
>>>
>>>> Can the early return above bypass this zram device initialization check?
>>>
>>> We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
>>> from that, that's not how one checks if device was initialized.  We may
>>> want to consolidate those checks, just for symmetry.
>>
>> Agreed on both points -- the early return is not a new "bypass", and
>> the write() return value was never a way to probe init state.
>>
>> How about moving the init_done() check to the top, so all the early
>> returns sit behind the same device-state check?
> 
> Yeah, I don't know...  Moving it under device lock doesn't buy us
> anything.  We don't need device lock to validate integer rangers,
> etc.  There are validations that we need to do under device lock
> because those require a consistent device state.  But things like
> "is system uptime less than supplied sysfs data" don't logically
> require a device lock.

Thanks for the clarification. The current patch is enough, so no change 
is needed.

Thanks,
Hao

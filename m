Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB84D6C55
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471288; cv=none; b=rANbmlfLWakodPGAeib1uUA9XX/aXJ9il/RRYqSxwpIDhGlcMQoKCFGOti4L+KzLOeeDLB4WmIGSU2ghl2qDqvSRF9dkPXeMSKzvICfprHbiFnzBnQJSO0JZiI382noeoi8+blQGn+Cy2zDNAKyVIzH8MI6+oO5gawm8HDQro9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471288; c=relaxed/simple;
	bh=mTVYvKeNxH9x54GqxZX8L5n+NY3oJiIMt9Q4M8B7Qjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYizJgy8UDxDfat5ma9PlV4b+VtlRXvkMkG+9djFSSfjkISQyW8d2Ezy3hBnYpHeDoNKxyeyvlNE3pD12VFxO9hxftsfIdzMgD/HqIXJqxdhIgz8BvuxZlJ5wkxGVuJ1/A2OK2mkXDz0wNHqPUyIe2SsuS+65uYI7t0GXPqthl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nVIVnaOp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nVIVnaOp"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8244537ab76so1578638a34.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791471275; x=1792076075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCGr+lVw0FZ4ggSWHdBUJKRxZZGinYin+dhCyqmG9ss=;
        b=nVIVnaOpAPtXCj+1nYNm4rsGPofGyGUnoErHzJzzrrhhm1u0s9ARoT2Xj0LRuQgxre
         B+YHsRCba4yGnI4t0Y2Q61ktU7jjhpCWbsgmvhF6ehNjlp8SvP/UX+hP+pXyFf3UlLIa
         Bp5MPQQhQ3S7pqOAUCUUpzUQZIEJ2+iIGP98r1XjlQVZ4kq3LB3v+hkGPXJCOyqbOSNb
         ypeRYlxGCmHI4MzA42at88zLK4XprTzFgm8tAIU/D1+DyfR1h4R7xPAJS30uh1PPO7FB
         ZXPuzRETpIVTGAGMut9tU+84GqcHvQ8dShRQWfI0NIdL9tjx08Vb5XmHe7Pp52IBR4rn
         kicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471275; x=1792076075;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCGr+lVw0FZ4ggSWHdBUJKRxZZGinYin+dhCyqmG9ss=;
        b=gGPp9D3scYYoOxKzH7+rZLunS28WNVeahuuEwWCBqYITILLdzqfxr+jmV6BMrsYnUi
         oeuqTXWkhUt6ycCwjo6zyWHCcV0njATBJ/E5sDYHmwwTmBBOSziJGUVJHOVNcyijHI+4
         MNB9FdbeYmHlt5bwbWxL+Q5gihf9ihSyzQmKwLIUUeRxq+Qiz8qLpJXy7ux2s2HG7fbK
         uCr2PyK8ZdROhPY10DHVXdsDOr6O7VJdfHz030+mp0c3Mk17qUgFucq84fsBmyH8NNfs
         pcsQyLjS/Cc62BR7TFTRSC/SbXHA6csg39Dz1jlU1H382ykWGMP+fU7AcQM4dN4h4//Y
         MuFg==
X-Forwarded-Encrypted: i=1; AKwUvBwoMs2m39icyVvPsYGt2bu5YuT8rngVk6J40pUwqTgVROfxDj7cZ2i8OuQmPSYy45+hTy1GVxw=@vger.kernel.org
X-Gm-Message-State: AFuF++lINNikO41tazSQacSZ7VARThHLxpFDeo25UVbH/Vtm5ThoKBI3
	gbFO1WX/KFlYaP+jsL3pA57A9nf73iqGpCk0j0vVYMKmOImem4YRazoH6g7qZgqS+MY=
X-Gm-Gg: AYBFou1gR68Zb751p3l+hy94aEshALU1L3rF6UOtDp2I5VeEUxAHU52G0bsho2hxFZM
	ldYChDrMx3aSfAeb8WeHWA3HTbx2SMI4AFKt3D4l8fEBomjL9GOuYKqVX3VNPty018XVqzh1//n
	LlKPE9LDXRvjbL+JRxODTshV3J52FEB4n9lUDsF+77lrUk0vP3RoCijxrB7CJJL5AE2LCviKOID
	y0SM+Qmrz8+zNvD6T0ps+j4Yo9rflC0O0FeYRHsa8Di32mtpXmnXk4ToUi2UrC4jp3P21y0SoUo
	0/AfgwRhT5zI+b9VbyPw2+LVP2mnzs/v4LQspLGN6/znCt0IR00O+b+kuURBwl8p4uAgvomM569
	swPWX8wnfMWY4Cm2rwXTgpseeDM/2xnQwNoy1Z04nX+gjV0OGDiV44YN1t6y4picsJTbm9qVwjO
	Cop1xg5oseU1inAY3gORjCd/0ycsqiU2xm6UuSnjLWzcuwqeNxCZTDXmPqrKtL0j0IxOyVZ6zDi
	jcimiLRSmO/37kfCOkDcF8BE4Ve6iazI5Sw7W6w2GGFNM8eaCMCBM4=
X-Received: by 2002:a05:6808:c213:b0:4e7:a6e3:7338 with SMTP id 5614622812f47-4fc452489e3mr5378129b6e.17.1791471275421;
        Thu, 08 Oct 2026 07:54:35 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49656fbfsm5760405b6e.15.2026.10.08.07.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 07:54:34 -0700 (PDT)
Message-ID: <b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk>
Date: Thu, 8 Oct 2026 08:54:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/memmap: only charge pinned user memory to
 RLIMIT_MEMLOCK
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20261007213903.445430-3-axboe@kernel.dk>
 <20261008045733.773725-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261008045733.773725-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/26 10:57 PM, Hengyu Liang wrote:
> On 10/7/26 3:38 PM, Jens Axboe wrote:
>> Charge RLIMIT_MEMLOCK only for regions backed by pinned user memory, which
>> is what the limit is for, and leave kernel allocations to memcg. User
>> provided ring memory keeps being charged, it is pinned.
> 
> Sorry for the late reply, and thanks for picking this up.
> 
> I tested both patches on top of v7.3-rc4. The test case from my patch
> prints "64 rings" again, kernel allocated buffer rings are fixed as well,
> the per-user locked_vm count is balanced after ring create, close and
> resize, and the liburing tests give the same results as before, except
> that read-before-exit.t passes again with the default limit.
> 
> Tested-by: Hengyu Liang <hengyul@cs.unc.edu>

Thanks for testing!

> One case is not restored. v6.13 did not charge rings created with
> IORING_SETUP_NO_MMAP either. Number of rings created out of 64, as an
> unprivileged user with the default 8 MiB limit, 4096 entries each:
> 
>                                      v6.13  v7.3-rc4  this series
>   io_uring_queue_init()                 64        16           64
>   io_uring_queue_init_mem()             64        21           21
> 
> PostgreSQL 18 is in the second row. It puts its rings into shared memory
> with io_uring_queue_init_mem() whenever liburing has it [1], so I expect
> the failure they reported to stay. I have not run PostgreSQL itself.
> 
> Would you take a patch on top that leaves the SQ/CQ rings uncharged for
> user memory too, as in v6.13? I can send one, or test whatever you prefer.

Yes for sure, please feel free to send a patch we can apply on top.
>
> Also, kernel allocated IORING_REGISTER_MEM_REGION regions are no longer
> charged. They have been charged since they were added in v6.14. With the
> series a user with an 8 MiB limit can register a 512 MiB one.
> 
> [1] https://github.com/postgres/postgres/blob/REL_18_STABLE/src/backend/storage/aio/method_io_uring.c

We should still account IORING_MEM_REGION_TYPE_USER, anything that isn't
memcg accounted. I'll take a closer look, but if that isn't the case,
then yes that also needs a followup.

-- 
Jens Axboe

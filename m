Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404142C4F0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343486; cv=none; b=cgaFbCWIOpCSAyGHOrdBjLvqOiI7PjE5RMxqHYXSlnAm5u2NoFNBm7IG91NUxopKB4kE7JtgNb/eCotMXP2CZHci3tW5PEdwXXCB/KWTh/5hUDobq7BX8ZbXPTLiVX8a1vK0KLIfHHObDT5YC71j4QJEPdekA1TiclbyMdBCveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343486; c=relaxed/simple;
	bh=oJK0PD+a5StLPpTanOicMcFQEHdIsjy/U+zZywQmNds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cn8krhZTf9rxnykuweYDWVOiFdCombfV0HEx8JSWeAdHJFHotp9Tx0pamFkTfZ33tn3P+N+t/QcRrDBp3slkUZhKGQoIfErhBOdGyBlqI6OLSSAzhGieLEdQ08lW0JeJloHxPJvG/169pBNyPTIFThbyYT8iEHD8hdOssPtn+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kbZl5JzB; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kbZl5JzB"
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-4960b753d6fso130324b6e.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785343483; x=1785948283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItGNlQ8VnmY1+S2rbSPlU0WG06O6TGHKeLl4xbUymvM=;
        b=kbZl5JzBcrOialHJbWm3iMLaGW8E3FD6E2HV3yBOuRmWO+2vk9p4nN/Nz3lZ9wyr78
         V0QuTVoMvMI16TRZlER1+zU+2DMCV8JLrb+x7+g+qP4FDJ+mIodzN+8+spsRPPOypRTq
         vX1EepMMw2Gp6Nr3gVfUN7fbcaYEUrwiHvzCJjeHu3+XpApDmseCLBf3u3J1BP/PZWzw
         prBPH91m7eTuWIXdzcVBWUIbCQ9nz3IUuGYZRg2RmXwg9EhSkmBs29I7iJ8FGx8xLwCt
         ddcYkJq0DE6bCJld01gGLVQaQGrtjkWEsAbpbiE9z7gaKD4EDMDZ3ksKo/1IrDfCwwvh
         5CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343483; x=1785948283;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItGNlQ8VnmY1+S2rbSPlU0WG06O6TGHKeLl4xbUymvM=;
        b=eWI3bCXyc1J/8c6igRqEgrmCy7a4pe6jc1LfixoM2ddM/RRSp7QzbwJrx9qieEmiJ5
         AIzVc/wYknv6mVCLUSl/VpgjHwZJ5Whw/coY+BqyjSrVUV4ldqtQ0cq+nwXUsHMFmGM+
         01dsVSW9FNiJAhJ/lebT/w77KC6zYGW0GH4AoerbkgKHBIbYM8vfhf7K5gZPd1yUYnfD
         JiaWhJVCjGtY5cYpCgMW/bwhKL/RuMoMGq++UVu+yKrBJg4hQt4EzSxuTLfQnCdAd3CG
         kWizIlzL599NREQ8RM/f13gBA3qBXCASmUIu1u1Wpj0P8O4rQJrQdh4PjpPI9LNYEota
         IdjQ==
X-Gm-Message-State: AOJu0Yx9F1lxY4JOF8+oRYoTUJcFBLSAMH+ece3rRCGC7T5+xLjZlDCw
	ZpFAOhc8uURaYMZZ9QG8yyy99RyipJ0bjV7EqQNjWLmpvTjTAFe/H6BVCQkuJ1q2SeA=
X-Gm-Gg: AR+sD113Bk6rI0HE3syD/Ocx5Jd9Yhm5mVryaklzVz8vPke9bg8QQH8IvFk2skk2PEc
	c3R9+1EcN2O8WywuPHgBSmYHUQ2JcehjQ9qRdoAIzMAZea97/+HuEhn7PNUrUsQ2+gxD8CBnY9x
	UW/QmLwAT8c1hbioO7KxE/Uj61d/QhAnDmAIQcq+4L2imEGZxq21qWZNsVOfR2sR8Q7XN4j8qWc
	iXiPtM64jVVkOxPDK/bBvrMWlvo53sMAkTTmQ/KNsQnYuBha5/2fTlISQk2VsKleMHtMNLwix1N
	V77m+/X8j8PpYwHcw/znaIED279wCiRXMY0mUgyvknZjIEX2eai3P/GolAuMsEdyebuTdZGliZj
	I1vrKD9qbw2cp6baLhF4l48cl9r+01x3v5R2z1YrlHy50pNaorjINr98Qqv6ZzZimB5kbMm/H5g
	8Bz3LMXeywLeqZMh4hhcGjqr1LtX2G4LSmmMzcOPWwzI/Z0m/aAT+VuXdlb1c+a8jlgzCNsxa8x
	3rMjbbotKSnEmg=
X-Received: by 2002:a05:6808:17a6:b0:48a:ddd4:d36f with SMTP id 5614622812f47-4ad5b7fe320mr3952214b6e.8.1785343482919;
        Wed, 29 Jul 2026 09:44:42 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm2059616b6e.13.2026.07.29.09.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:44:42 -0700 (PDT)
Message-ID: <d7716c35-8b74-4d91-9830-3bd4b2509e14@kernel.dk>
Date: Wed, 29 Jul 2026 10:44:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.12-stable tree
From: Jens Axboe <axboe@kernel.dk>
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-manpower-thrift-f2fd@gregkh>
 <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
Content-Language: en-US
In-Reply-To: <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 10:35 AM, Jens Axboe wrote:
> On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.12-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-manpower-thrift-f2fd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> 
> Seems that's already in 6.12-stable?

No sorry, I'm blind. I'll take care of this and the 6.6 one.
-- 
Jens Axboe


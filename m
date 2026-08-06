Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A803A2E2B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032481; cv=none; b=a8tdt1cXJj1WNeXV+O0BPfimN0cxoRHDTxocdOsFN5Vv1O6WIF8ziorEqguBVhDj+cFEP/SP0jVUTiopRdb4HqhtVGxehPigQQIQkPrio+FUt+NKbh0N4do6e+2kY7esat51VMuEjDehKXSsnKgKID3gzmXEp5+EEALv4WnKqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032481; c=relaxed/simple;
	bh=ArGsFM3cJ6Rp/xGrIKGWfTn+FGLQ2MN4c2sD46sD0Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZTLnibgDotZkh6/gEYiKpG7c9lCDf8vkmopdaCUdBcHZSItWZu53O6bvrm2i25onY7choKqh5l81sHWie9r6I39C5YnCPQdhOAGUxy2V5Xieoe/0hgEV4XOuVjTHLTF19O8OLZ3fvlqgzYrnEbgZcuGOq8VarQj6lZL4ogd6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejS9SVja; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejS9SVja"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485ab7c382so441856b3a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786032479; x=1786637279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyX2/v766GOIV90GXvGFKE9yXmREQs/QcaigmTO1ry8=;
        b=ejS9SVjaBAR18P5vRm5VAnlx/KfgfzGZQUsdeJ8tJNfwtzsfHIZECMhCrSknyYGalI
         E20e+tZUdbzOC94PzxYLVu9Gv9fVqnN6f0/AYSxD5d0/DZYsSijN5jeHE4F631sst6hw
         GisqgDlaUeBQMdKlr3M+jBg527dsDZenVFCj1JS58pW+cRsCnkTwqhAX2m6WvjRoUzrr
         KG8r+L/N0qkmEqLD1z2K3eQqzbp9Z6T+tqGzHrSyhMAbpkdt64O54RKITw+QRinu1AT9
         +8CPirjAUSdMKn/Ygfx2tREiV9qJGalRputtOvnuQn4vqu9VTp8/II9mdEIF1lDNz9Aw
         iXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786032479; x=1786637279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyX2/v766GOIV90GXvGFKE9yXmREQs/QcaigmTO1ry8=;
        b=DaVfwVHs0fKZhWwrSx93fsZa+GcN8aisTi0KrXEtG7XM1YKzCKP1RHguyBofYnqZfY
         VePJYQO4xedIXf8Dzjzr2H0nXvqHBEXgrPn7JL6xWMouFz6i7eODZXIJ9ZEnq7j731OT
         5QKGaXY7kDhdqAC6Tc2f6HLmsJarOaA8aoOkl62RGZj9i9Ht4jsR0zjqnObEbkmlwVeD
         Msz6GQ3iSko50iR6q9X70Z7M05QYrQWAsWnFn+s6xZyH0SyPZspKz0/k2KM1AMXkKkfE
         GoTh00N0C0gQuiqobl0PEfT/90X+TMuEa/teU0jzNFfUeo7FFoZBYOCmFDS4eYXqZm9i
         v/MA==
X-Forwarded-Encrypted: i=1; AHgh+Rr35YhaZKa64UYISzqHccvBQjUc5o1mZ7Q8OCTIrUbpa3/rSbRuFQ/03aNxKCiZW+hbgPAyRvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwXIzUkefRHkrXwyTBaSovYPXq6Vo9Zd7498WU/9F3PkiUPm1
	tp1JiuYASHYlYAOJCHoSv0323XGH/WULWdCNC956ymFEjmmtDX6vqBL3
X-Gm-Gg: AR+sD11JAdi0Gz78DAu5TKMdbE/blcJ7MQhf2Q3VqiqzD/hQvrxjIDEK5pWeX7gw5kl
	7hbHN54WLsyjPkpsyH4LtTX6/5drswp+oMUv4JlFNXupFRDrh/IxFYDFRXAaVqKU2xI3iF5+Jl2
	NOGbnYGa1LLmsDMhgcVSd6XP1yFGVNgjruffCwDyXw0FwdhBgL7+nXreDyfTwnjrWtR1vNEGzXE
	VibiDwUN/kkZScCeqsXYIS3NsUYm3Ei7KUWC23g2k2LY/OynxpWSB2xn/C13eYYRPPdL1sr72N6
	fZgGK00sdFnHX1e2EIJYnF9Z0sESw4J41ow7wz/av78B9Y5H1F/X//206MmoQi34VF82hQ2CsNs
	t2zFxnRoJa6iMynJB3CS9TO/ZnOGPANJln/hWX+KczIiCQN+6vVGD5XXfc8OvklOlPsx/vDk2Ey
	//abpFxanqOAtOZgvuqge8Vcaa88+d5IKegOdvoQbs6ufOrHMJhm1HJIDyrQrN
X-Received: by 2002:a05:6a00:1807:b0:842:4af4:3080 with SMTP id d2e1a72fcca58-84f2dfb7931mr12420953b3a.1.1786032479389;
        Thu, 06 Aug 2026 09:07:59 -0700 (PDT)
Received: from [192.168.5.2] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f454cd0d2sm1698470b3a.27.2026.08.06.09.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:07:59 -0700 (PDT)
Message-ID: <baf66d46-773f-4094-991d-e726b0e3b159@gmail.com>
Date: Fri, 7 Aug 2026 00:07:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] Fix memory leak in io_wq_create() on success path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260806142314.557312-1-shinnkka1@gmail.com>
 <2026080644-suffix-earthy-2f30@gregkh>
 <CAGeKw7JFxZ6QBg_p6ma2NjPMBe5utoZ715z3763d0qH=uLehYA@mail.gmail.com>
 <2026080636-financial-iron-4bd9@gregkh>
Content-Language: en-US
From: Chen Xiaokun <shinnkka1@gmail.com>
In-Reply-To: <2026080636-financial-iron-4bd9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/8/6 23:29, Greg KH 写道:

> On Thu, Aug 06, 2026 at 10:47:02PM +0800, xk c wrote:
>> Greg KH <gregkh@linuxfoundation.org> 于2026年8月6日周四 22:33写道：
>>> On Thu, Aug 06, 2026 at 10:23:14PM +0800, Chen Xiaokun wrote:
>>>> The commit 657ca82526d0 introduced a temporary allowed_mask cpumask in
>>>> io_wq_create(), which was freed only on the error path.  This caused a
>>>> memory leak of cpumask_size() bytes on every successful io_wq_create().
>>>>
>>>> Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
>>>> Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>
>>>> ---
>>>>   io_uring/io-wq.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
>>>> index 66fdd69fd6cb..34a1a9067cc2 100644
>>>> --- a/io_uring/io-wq.c
>>>> +++ b/io_uring/io-wq.c
>>>> @@ -1218,6 +1218,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
>>>>        wq->task = get_task_struct(data->task);
>>>>        atomic_set(&wq->worker_refs, 1);
>>>>        init_completion(&wq->worker_done);
>>>> +     free_cpumask_var(allowed_mask);
>>>>        return wq;
>>>>   err:
>>>>        io_wq_put_hash(data->hash);
>>>> --
>>>> 2.55.0
>>>>
>>>>
>>> Why is this a stable-only patch?  Was the backport wrong?  Or is this
>>> also in Linus's tree?
>>>
>> Linus's tree has not this issue.
> You need to explain why, in great detail, Linus's tree does not have
> this problem in the changelog.
>
> For example, try answering the questions I asked here, that should
> provide you a framework for what to write.
>
> thnanks,
This is a stable-only patch because the backport introduced a
temporary allowed_mask variable without freeing it on the success
path.  In Linus's tree, it is bound to wq, so there is no memory leak.
> greg k-h
>
>
Thanks for your patience,
Chen

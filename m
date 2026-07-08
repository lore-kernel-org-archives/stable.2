Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04741378828
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517569; cv=none; b=A90zswjZp7pbdEccgnztzX86htsLF1bbPodQGKmcTbOZZIyo+CQfw5rps67yL7WtUBOPZQeJr2bRKrgUBihHZ4DXjcK2G1CjEY92nsVAQKIxy7WKLOliI1SCmnDCm6NKjmq34q/zulbDEZsQQxbKW1R3E0+Hqq5znmoWd1Bhjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517569; c=relaxed/simple;
	bh=TBQnnf1ISW62j4RHZSvYvNLSTDQ9QzUk7AAeKMrk3ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1ixsFI4NTBLD2bl2l5OxPyjFFFTOfSyfkO5ZCibhXKn+QlJomcZyLgH0ucXeEpvGrL/60skMmVKQq14VDPi8RIhbrtgfIsL5u0M31zEV5PwzCsCcCfEtwxAQrqG5xGpa1h5fSGJVglihHW3K4oJfKhjge3CIMpUpKahaSnyNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEGDG4dT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKZAolcw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEGDG4dT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKZAolcw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783517565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6QdbQflS+GfJz88gA8xHxJyZ3hxbQBYcalujojmxh0=;
	b=XEGDG4dTXV3yrHNWjB7nb+RFPZ9UFpaz5oPCZKnzBCezJjkjqzzNZRSQL4jKcmkkXz1SIx
	hestetMBOSyu0+yt1Yk7YjmpfXw2keurLXQNdxparSp93QoSFGnouvbB0dIzBpCUor6eop
	6Y0dgbU5oQn1eBphrRflXbOXc4jaCso=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-mKAUrvEWP2yWsAoeqtFNkw-1; Wed, 08 Jul 2026 09:32:44 -0400
X-MC-Unique: mKAUrvEWP2yWsAoeqtFNkw-1
X-Mimecast-MFC-AGG-ID: mKAUrvEWP2yWsAoeqtFNkw_1783517563
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so76196385a.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783517563; x=1784122363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6QdbQflS+GfJz88gA8xHxJyZ3hxbQBYcalujojmxh0=;
        b=XKZAolcw5ErbQbwpF6UKOiN0HNqCoVzDuKrGMaTezgEbNMntK8YGp/2apCjnodGbpp
         9nFOmca5h8zmL+7k0O4AD1hSJhhWyjCAIzvwTKa1kjZ/YrQDP7tWBKQlNWM6mlBcGD/a
         D8zt0LnIw7pEB4LjuTVfQkt8r8mTWnu610Q5Zpu1rWKbxC5DCTZ4eWbt4M+UcMoKg1iI
         NuhUEUjQ8NlyBRnFoWjMqTLP75qwxWjV1aIicMmUAkFFJauZoNuOfZhtiPejx73AxlPR
         TSp+FzXxMKcb/jKx+A4qpLiWnh+Hx6gsUbggotBEZsUqxywLK0XPlWkzv8h5WGTiw+rI
         bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517563; x=1784122363;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6QdbQflS+GfJz88gA8xHxJyZ3hxbQBYcalujojmxh0=;
        b=Mdg4moo2MBVsHXfNYjzPt5R9fhM/cDVQDFHl4mYp4CnkWtV9ow3Iwr4QMNZp49KWO4
         aOk2teN+Ks/RriQcKNIvTxYVMn5OvZWAltrEvqJjjn+u1faFg9LN0AW7sOkyJPM/aRAZ
         r32B6DDgXp5sSHnOVK41SC/i5UX+gbYuFU98hOUifTi6cuic5QmoWRk1VNU+FwO7ZJrM
         EtLeAWYq6eGpm2Z0NeVa9WgUCn+/yNTxJFRV/KB/fGemlg0garD6vdnd74+pAuVyQX+Q
         ilMI+JDTBp5UCf1U7CXAB1UVqQ5g03Qtnj3znNIXkRQIUOsT4KV6lFhCFRMkZJHDOjNF
         YTqA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6rMEGjIhgo+T/QZgb5fwtk0bN1dIBzfumoEUGAHE2AGR6ys2VUZx4yIvUciAYAZIJBH+RB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEshPT+J6JWHl5efKIDzwD+xtylfjY2w8T3qwIpiDtUv0SEcPg
	7Ew9aq2BrpI8KyoqIOUsMCYMCjZF7Ce7K7vrAF25v7h+sdZUcjoBac5a2jJrPRoA45dX2I7+8mw
	BTVqs5VWvvkdvwnThouh08+rVYH/ODKStFcn/lGLugqnMJRVovxAOWDtMyQ==
X-Gm-Gg: AfdE7clugiZQH3DCYLMohmiub5rLf8bv2vnmUh+1iCSZTXyXLyThFTC5eEcycEGP6yV
	JhJtXGSLCyqXZ27DEHYH2URMJRs6hVWC8hSClHB6vcMgsZ7wTvphF6hmJvoPAToJkXDl+kEBCn7
	gohedJsZBCM02MnfM+1rQCJgKH6bQ6ndfqsh1xtgvjnrJVxT3kdfPqE+sIBXwr3SbvNBiruj1WR
	0YDrKIOwmhKmxTL0APWUgko2yl9DgThJ/eE6qn3wOcCB26OplLc/bS6S2G9NjCJprjRK9ehU4JH
	Kff6eaGiblN9PPbNQHF6j5/jlMA5Fmv0Gbog8mHiHips+HOS3rirRMHqAMQGkPLGtm+5Ref6Y4I
	S3D8TlB9pUw==
X-Received: by 2002:a05:620a:46ac:b0:92e:c197:e9f5 with SMTP id af79cd13be357-92ecf92af35mr203843985a.77.1783517563402;
        Wed, 08 Jul 2026 06:32:43 -0700 (PDT)
X-Received: by 2002:a05:620a:46ac:b0:92e:c197:e9f5 with SMTP id af79cd13be357-92ecf92af35mr203839485a.77.1783517562934;
        Wed, 08 Jul 2026 06:32:42 -0700 (PDT)
Received: from [192.168.8.207] ([45.81.3.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba7e62sm1430433785a.13.2026.07.08.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:32:42 -0700 (PDT)
Message-ID: <d434fecb-5df3-4ddd-b2f8-27194a9131b7@redhat.com>
Date: Wed, 8 Jul 2026 07:34:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bug: fix warning suppressions with kunit built as module
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
 Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>,
 Alessandro Carminati <acarmina@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 brgl@kernel.org, stable@vger.kernel.org
References: <20260707125837.57256-1-bartosz.golaszewski@oss.qualcomm.com>
From: Nico Pache <npache@redhat.com>
Content-Language: en-US
In-Reply-To: <20260707125837.57256-1-bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 6:58 AM, Bartosz Golaszewski wrote:
> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
> lib/bug.c is only built if it's built-in. Use IS_ENABLE(CONFIG_KUNIT) to
> enable it for a loadable kunit module as well. When using a plain #ifdef,
> the suppressions only work if kunit is built-in.
> 
> Cc: stable@vger.kernel.org
> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning backtraces")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

I ran into the same issue and found the following fix also resolved the issue.

Tested-by: Nico Pache <npache@redhat.com>
Acked-by: Nico Pache <npache@redhat.com>


> ---
>  lib/bug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 292420f45811..b9820a0226f5 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -219,7 +219,7 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
>  	has_args = bug->flags & BUGFLAG_ARGS;
>  
> -#ifdef CONFIG_KUNIT
> +#if IS_ENABLED(CONFIG_KUNIT)
>  	/*
>  	 * Before the once logic so suppressed warnings do not consume
>  	 * the single-fire budget of WARN_ON_ONCE().


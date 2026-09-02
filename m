Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03570472092
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366935; cv=none; b=jYTPH4bLasDL5Y95RkX+TzJpCkgr6j0AG0a72dYe2GZJuwhVkH0ECzLkwdHScdAQf8ikT4AiU0FIS92pUMgVuY8mZ0wiUBGYN0ELOiHNqhr5bWyXvaO5AJlnPxigatuy6o1mFofLa2aSy76FotOUpqLuZCMRE+XTVkl8iU1iOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366935; c=relaxed/simple;
	bh=t8PyCRFnuTEhLx0POxPFJ3IdfbvAwWXeN2YROup4iG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/sVjSTSsAKB8kdbQtfQiXjQQ5m3HyyH3mFj5VxTWzxuup630WiBALmw0CFKTSoahGQc+wgUcbZISsBF7rw0OZdYpX1cK+zsRNXZek1h+CCM38gTHfDeWTThM1PRJgacaggji+IABlmPA+h2d9EYBtXcBnjsJFhuLw+CiwpYogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdm8Lfna; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdm8Lfna"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de0093c42so1393559f8f.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788366931; x=1788971731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=em+yl1HWPBHYUcif9OtkO19xDeGpBr2gFlnBjaM1mAI=;
        b=Rdm8LfnaDziuYcsYxiyyY2nqhhnjDM29brLLyZ5rPF72JGs4v9VL1YBFb+nyEUE7vx
         /cELDvLzAnfNDmf2x6xwkbrGtmQoo9qmOnIlZBF72qmlFDYHM2N52W87s9kUa4XU9lS/
         jVmgm0uC6RReFcVXn9lVt1qWLPFBouLzv7SvPm2CgftoiIkf21z3p9tjbypsS0HXB07G
         xbHEVXJvk7RCDQ8X933XpDrkljTK3noB3nQ2+fOT1S/bR4vSB/acNA0pslsFlvFKhXMw
         85vsFaJ6MDZdrzEmfHiAlhGKzJ7ecjSWnXi/XD1XoVqvbq3BEaCdzS6TIgBxywT9XxkK
         6h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366931; x=1788971731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=em+yl1HWPBHYUcif9OtkO19xDeGpBr2gFlnBjaM1mAI=;
        b=G0vqwAvLQx5gtHG9zbOqGJmYE8rAlUsyaQtP0Bl3hngOa/le6+ukvczVNWU9gikygB
         kLjayIN9Ld3kzbMyk0fTS/T7+yHZviKeSePb5JY/R8iXS6LpMgr5Uo+NQd085gLBe8m7
         tkzUKEg58vt7sSdYIFja0xEJYMdGso54FQRt6XIWBGVTYZwr8YTT9soytfIYAUxbhOTP
         zLKSYzN0CvbQcQLUv/zQiNZNk1BVO/95smxL4pBreJ2MZuAhLM/Yil7i2uuEnEofZAGr
         2h+m7i3aj3Rsm4vCHr40SLYcQz7dKJ6It1uAWut9N6RkYtgjk3jH2Wz30OGlSrPvOpHy
         D0+w==
X-Forwarded-Encrypted: i=1; AHgh+RrwI8LU9D/OU1Oy+5PiYKHkf7f1hHoXvQkLhkJxYwCd76afyu2mhb//Gf85Z/vw0Jl28TN7VD8=@vger.kernel.org
X-Gm-Message-State: AFuF++kih+RTEEcTEnNwmhSf6lje6uYrGDBPb1sQLu8nlPAl6UQkM9vZ
	VOAkx2LYFjYm+/ztevmiyd1jPKeirAQoLh+1Q0QEFPz4y/zFWMsQRwmO
X-Gm-Gg: AR+sD12jcbY1vABpcPJkxLUOl78RgOKFFM4SmjSW/9lc7XgXqDNuwDtBC0mdwPRGShx
	VnfDH2xq0OEszTv9JdLCBY7InPxF7ajhFFNdb+m7BD6JDgV3TsrQuEowNtlauz8AbsR1O3PaAhv
	NkX0JX7zY0GfmTgNHMIg6U082MHO51RRc8EFE4t+8RP+v/dNQG2U6KKZFQhW+Vg2MTNiBu8OzIY
	oef5+Z42LB5K+sDM8xYUqg/bm94NyfgUpeq3c4J578vyAPtK/vReGkla8hYQQQ4p8xoh7pHiXvO
	iduGLNiZk/pSXZpjSHdVsw3SycsJJsUq1eywv6kQe5xIpnXYECYRFpvIrGOkN9TLWNmPUen9Dlh
	rpx7k0hDpzTHFmf8y+xRBJSaOgTNzS1IN8G8xr9kDZ8rxxuqrCmPOZT2ugXyvM02PMgifRwwvC4
	zNcsK7BatM/wnu4p8HcWm7Ri/LEKFZYlGArLmjse7TOMmzP0U5azHNpuGuH2OctqT1WvfPcsf4B
	Zcv2gmsZUnkrb9A9wrkzkMWG+O8mgdi9SXofyuHLA1GO8VNzg0dEEoGkXA=
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr77886225e9.4.1788366930621;
        Wed, 02 Sep 2026 09:35:30 -0700 (PDT)
Received: from [192.168.1.208] (athedsl-11462.home.otenet.gr. [87.202.45.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm66601835e9.1.2026.09.02.09.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 09:35:29 -0700 (PDT)
Message-ID: <3552bfc7-ac6e-4133-95f9-69b4e96a5005@gmail.com>
Date: Wed, 2 Sep 2026 18:35:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
To: David Laight <david.laight.linux@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
 <20260902163151.59ffe47f@pumpkin>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <20260902163151.59ffe47f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 5:31 PM, David Laight wrote:
> On Wed, 02 Sep 2026 12:21:19 +0200
> Vasileios Almpanis <vasilisalmpanis@gmail.com> wrote:
>
>> ihex_binrec_size() returns uint16_t while computing be16_to_cpu(p->len) +
>> sizeof(struct ihex_binrec), so record lengths of 65530 and above wrap.
>> __ihex_next_binrec() uses the result as the offset to the next record. A
>> length of 65530 gives an advance of zero, so ihex_validate_fw() spins on
>> the same record forever. Lengths of 65531 to 65535 advance by 4 or 8
>> instead of 65544, so a 14 byte image passes validation while its first
>> record claims 65535 bytes of payload. emi26_load_firmware() passes it to
>> emi26_writememory(), which kmemdup()s 65535 bytes out of a 14 byte buffer
>> producing the following splat:
>>
>>    BUG: KASAN: vmalloc-out-of-bounds in kmemdup_noprof+0x3b/0x50
>>    Read of size 65535 at addr ffffc90000075006 by task kworker/11:1/174
>>    Workqueue: usb_hub_wq hub_event
>>    Call Trace:
>>     <TASK>
>>     kasan_check_range+0x10f/0x1e0
>>     __asan_memcpy+0x23/0x60
>>     kmemdup_noprof+0x3b/0x50
>>     emi26_writememory+0x29/0xd0
>>     emi26_probe+0x2d1/0xb64
>>
>> Return size_t so neither the addition nor the following ALIGN() can wrap.
> The ALIGN() can't wrap, the u16 value is promoted to 'int' before anything
> is done with it.
> What it does save is the pointless '&= 0xffff' after the add.
>
> Since the result is added to a pointer it will need promoting to 'long'.
> But the compiler can assume that adding sizeof(*p) will zero the high
> bits and nothing extra is generated.
> (Not that this is a super-hot path...)
>
>> Fixes: 9fb4ab4d3dd6 ("ihex: Simplify next record offset calculation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
>> ---
>>   include/linux/ihex.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ihex.h b/include/linux/ihex.h
>> index b824877e6d1b..0da1c4e3e693 100644
>> --- a/include/linux/ihex.h
>> +++ b/include/linux/ihex.h
>> @@ -21,7 +21,7 @@ struct ihex_binrec {
>>   	uint8_t data[];
>>   } __attribute__((packed));
>>   
>> -static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
>> +static inline size_t ihex_binrec_size(const struct ihex_binrec *p)
>>   {
>>   	return be16_to_cpu(p->len) + sizeof(*p);
> I'd always put those in the other order - matching the memory contents.
> (But changing it would be churn.)
>
> David
Hi David,

Thanks for taking the time to review my patch.
I had already posted a v2 before your mail arrived.
https://lore.kernel.org/all/20260902-ihex-v2-1-30bb117cfc77@gmail.com/T/#u
So the problem in this case is the fact that I misplace where the wrap 
happens.
Do you think it makes sense to send a v3 to fix the commit message?

Kind regards,

Vasileios Almpanis <vasilisalmpanis@gmail.com>


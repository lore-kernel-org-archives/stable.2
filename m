Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8292E0914
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851353; cv=none; b=cytiLgI4vD1pDWbHhQsRWqzMyDdKIUzgLQBmluCwmN71dHI9XVPqn0fvVcfDbijrSa6i4MS/AZLIaYRP//0mH2m+e1R2Kv24Smrzuxwq/ESsZkpSN7vAgUIWRpRAl1lGcyhXbzRHcO0Clj3J68HGOgDeEEC0XIfgtV3dAEE985o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851353; c=relaxed/simple;
	bh=vq0VLS/ylpM3CmAEtZEwDI7OGBBgEUHxL8PTx+OEr9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jy23I6o7hKKA1+5LZvPMQeBTvLo3MRQZGMu6LJij0Gkybem6zsNu0lDIrYStKAS/kfJQU657xGJ+FB0PLwJdRBoAspOaoNg5biWlPKIBub1cJJZ6gfm+snDBjeKbnhXqyMGyV9hxmes20qF7mFJ7Me1acd5zTBEMR6pHftntEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myKldV5g; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKldV5g"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48611862583so1590279b6e.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780851351; x=1781456151; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3oVPDjM9UNiAad2kRETnB/VhLXES/+/2f8UxjTzkJ8=;
        b=myKldV5gKWkOayJ8U/ypJOEEHBRkDxE7v6Hy0Nq01Lqk/TwIAcjO028egEo65OTyAd
         DdXY3lBxFAmqNvqAMpFJZpI1kLLn6CTliJpCvgkWcTILaYNLTNffoGzCJL4Mgqzh0/cj
         5vmXrKXmpT9VvguBA2uQ9qL70jxmJQczNqFOvBMuhHu1FZH/77JeKuw7/V8xQWaLzDx2
         LK37ACEanT6iXhPrJseRltQm3oc32HBVCBjJkkCAjATaRy08+4xOpMqtBJR1ekg1o7wd
         2V9ZNQj5FzVerFkOm7jSYpo7Dy5GpqWw688rx/WCOcbySVkzF+u5PVtMJ0zB1SvKRrp2
         R1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780851351; x=1781456151;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3oVPDjM9UNiAad2kRETnB/VhLXES/+/2f8UxjTzkJ8=;
        b=U9OFxkVNISSGGtc7xJYgqL5AThY49gdJYl68F1Xt04l2DYxwwlXVBVVkuUZr1EFDUa
         FTFNwR6YgxhYs9bn5ufDBoyf0gD++EJU5cGJzu4LPtw61/O9ajQ1uvitxZQeFkwZxbks
         VmQyPwbCeE0oD0QLOSyq2+e2h5rbFUDquPm/QbR2r4BgxfB4iTJXBxP7PINamKumctNV
         9+XQeDwTFSmW3Uo/Smlh3kyxlcaIQCv2fiJ4p8FnGmacQBh5YfKWjtPOEuvg3I+W1Job
         4NkjkRiLXCUHxub7YLix7u6pT66H0hGudiwhqp2upT4ilW4qlOZ6CWZPiyrZwsqh1glr
         +uFA==
X-Forwarded-Encrypted: i=1; AFNElJ9L2nhjgqOWdbt+fSoGUy/1sW8BkCXuPdlj7sC1zJupsG45FYPmcQ66Q4g7ppSAk7FvYYnPOUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpu53soPqKAscxwK58U4Hg6fVPrIXSCXKQziGxMf4hi6IBQN3R
	f0QzksdKqRMrL16LX4HdUt1CLbKEenZ6ke0eK555OTYNGbAV7ksZwhro
X-Gm-Gg: Acq92OFO2mS/KYwO6uSrWZqB+jfSYLHIXFDAeLwB3BGQr2EzxnMKxGkUVc/+6slfXr7
	zvHiF2xSYNn5CKTASRwC3eGI7pPKpXxUT30e5vwdhhQog1bnzo69xmdkwo1RzKwbTbEbKbL8SPr
	W05k9TASefYRmiJhWVlGm8fnQY+Hdio5WQSIFKnX7RiCeD+O4CZ43+mZpwSPDKvUXeR500fsteR
	o3SUb1IzUStHqHhXAJuv3gHrQe9m6Nm1p/1pBg8UkK/X8tlhVOq1ldr+7Iv8n5ob09jsMn4AZn4
	dOlwzAHCu3Yea0PVfySTs8kurUo6babL1LjIr6LKeN+rmKjxZ8649FmHQgIJWw4kGyEyRmX3SdE
	COFzgCr2GiyuaY0zTNXoXRU/6kXQiaZVldrul5NnZZEwfQcgDNAub9H+uZAwrg0Q3Q5BL8lSJWk
	91zECriS68U8xd5AK+SzmyWMj9DVSW+JFjPzbC8LboiA8WiJCbw1gSOnCYM+yjivOEzc8xR/e8t
	o8QHYlfkSyjKKObCBDEtn1egBt+
X-Received: by 2002:a05:6808:181c:b0:486:4bd0:9a29 with SMTP id 5614622812f47-4868df0166fmr6506417b6e.43.1780851351218;
        Sun, 07 Jun 2026 09:55:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7263efcsm14254294fac.0.2026.06.07.09.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 09:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 09:55:47 -0700
Message-Id: <DJ2Z46YDPFUR.3BDR6ZW4P912C@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260605234301.1109063-1-p@1g4.org>
 <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
In-Reply-To: <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>

On Sun Jun 7, 2026 at 1:59 AM PDT, Kumar Kartikeya Dwivedi wrote:
> On Sat Jun 6, 2026 at 1:43 AM CEST, Paul Moses wrote:
>> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
>> and btf_repeat_fields() expands repeatable fields from array elements
>> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>>
>> The remaining-capacity check performs the expanded field count calculati=
on
>> in u32. A malformed BTF can wrap that calculation, causing the check to
>> pass even when the expanded field count exceeds the scratch array
>> capacity. The following memcpy() can then write past the end of the
>> array.
>>
>> Use checked addition and multiplication before copying repeated fields
>> and reject impossible counts.
>>
>> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating=
 btf fields")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
>
> Do you have an example where this actually occurred in practice?
>
>>  kernel/bpf/btf.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a62d78581207..510aa32847da 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *bt=
f, const struct btf_type *var_
>>  static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
>>  			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>>  {
>> -	u32 i, j;
>> +	u32 i, j, total_cnt, total_repeats;
>>  	u32 cur;
>>
>>  	/* Ensure not repeating fields that should not be repeated. */
>> @@ -3686,10 +3686,9 @@ static int btf_repeat_fields(struct btf_field_inf=
o *info, int info_cnt,
>>  		}
>>  	}
>>
>> -	/* The type of struct size or variable size is u32,
>> -	 * so the multiplication will not overflow.
>> -	 */
>> -	if (field_cnt * (repeat_cnt + 1) > info_cnt)
>> +	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
>> +	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
>> +	    total_cnt > (u32)info_cnt)
>>  		return -E2BIG;

The callers of this function do:
        if (nelems > 1) {
                err =3D btf_repeat_fields(info, info_cnt, ret, nelems - 1, =
t->size);

so repeat_cnt cannot overflow.

'ret' (which is field_cnt) comes from btf_find_struct_field().
To overflow the struct needs to have 32k valid fields.
Is this really what is happening?

The issues is deeper. Please have a reliable reproducer first.


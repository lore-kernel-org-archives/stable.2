Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402734388A
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994635; cv=none; b=pd59RzqWcsbRX8Ji8l3wuFFZYVX//uGo5cslV1K2TDmeqpgTjKtp2/zpyiVIEuWR7lg1lDukLA76mulY8URFYnAOThEoUOBWnumTvZDIqvdVPAjF9mTIbuCQHM18VdGSgAzZvejqVJd83ud6yDWCbbcXnn+g9Sax2BdsvixDAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994635; c=relaxed/simple;
	bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sFvyhHZXEWldyFoQaexK3htilEueKLoTWnpVGwwq+cmR0RFQxyqHpaZFcVdIyHM1P+QGNL/TpWNzX0cEpNriniRzw45UkPyM/hhysp1EnjwvKa8QaN2rA5nLTFcELOfjeC669AAwUT7GjYPAbTr30vxYMNGH/XxtscJ4gqOV3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPAkhf1u; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPAkhf1u"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4795659f8f.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780994633; x=1781599433; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
        b=MPAkhf1uquZqzFn6EULJov+ZxAnSdVdGje6+ibL577WuH8w69cfqy/zmD36dPcNysJ
         lw7EWhjKnbUo94gp9tGq6tjvv3UWGuFCRiC0e6NN6XLEkVSw6taCWkiiBmhgvi3ki0uH
         QNu8CUqYp2FmCiPxJmtIcdcEDeCCQtfLaxAHQHHhF4IuHI9u3EVHrhlRZPstaYX0XAKS
         oiB2fInu+VDd7Ynw4KLaCpdByGW9imd4dKr9DmFbI11wMpfPVs9adFQLzAmN8iBYzZlX
         JRYM3sIJxIpmtm0Bvs30+q6qLWiHMjLfaGvjhsWkfxjNsJvURrWbBq+Fzk7F2HzkG71q
         mTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994633; x=1781599433;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
        b=XhaCR7hpaOxE7gxt5Awrto0IToSZPC5e78EkAcUqQlq6zyBC29bq3z0MT5j+38vvYu
         RmWq3pKa3NZS8F7jxNNraPVkOyoSl3YmnWlB4Ud1R2evIX7OplUWZiZAxfSsizPlh7WS
         BABtQ7mqjEEmyIK+Zzx1y8FdLmaSkVVc/JQmjijmd2cu5Tf+oDjJo3p+Fzc4Jqw3XFa8
         lfLN0azquzqXZkM8PFvEHdXbrnslZz3cLpofniR4iuAQFO3jJC52rTaju3louGJnt7La
         ZKoSm2tRFe+wnHJT3NAzBGpS4jHhi7GgA5vgFHJCkZN4di6omRmQLN6ATpDiROJAmedg
         +38Q==
X-Forwarded-Encrypted: i=1; AFNElJ9GevAR7EdxkPB6awhrHSd9hat9M5bedrtE7Zauyn0W19IetO/wHaiJHI2wulxOb0oPFjoZ3GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2Y2n8TBNz9VCXGw/p/7ntNBl5mulNGnXhNOzzfZTCLJLINvn
	e0Dv0w9ZY/oGuA2UE8RwRi5U7UEdb+qUbEO5TBq7xm+eC7vlJGyMzEXe
X-Gm-Gg: Acq92OGlWVYgIVx4DQgm3uTTBv8IXLLLoibefeCyMEeGRCXH8XA4nocxju6hv6ykEwr
	xQK/QKCdnN1QE31CSxIn0tEVuWx/FdAwadeeEZB+sZZcJwVL4aNmGfSWCKFfNEr8o2RadF+Avog
	ohO20dLXt05HQlH+qrtQN/6K86RAxdiuS7yZt/cmSGD62RwWB7qEOKdoutHJYtooQcem8Xdl44r
	rQvsldmhLpQ6fPade+fPDvfICpE4IRbUqu7rxlaBBRzyJwSRykdjmWIZlEx7NK1z5vyq9K8clUT
	DJH/Z8VZthXkFy9oY1IIbGkL9CG22u/7eGqi05gxEsY3AsTa92F2P96DbOLcNg0HYQ0nhfBIz6s
	F4ZKyJAh9B3EP0ZDlEPyMQYxtLeiNyoXYnEFnU8Xr1Q4n9y03quHmenn9wO+fPT8WAvmHlgRrZ8
	4FG3DL+jKyEBqp6Q8/HWSNm/H5MJUAijOXbNraIbJdIV/Al2Fmm3wHKENFuJj/4IpK+LAYkKzPq
	r4qJlJPC07EuNjyRGfqPHFCP3v16I+lN6WslyvA2cRZR17kqtcFmLgsUHSkdbpQCqvTCZDbXTd4
X-Received: by 2002:adf:e30e:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46030609798mr22356467f8f.30.1780994632620;
        Tue, 09 Jun 2026 01:43:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm60610866f8f.2.2026.06.09.01.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 10:43:51 +0200
Message-Id: <DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
 <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
In-Reply-To: <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>

On Mon Jun 8, 2026 at 10:01 PM CEST, Eduard Zingerman wrote:
> On Fri, 2026-06-05 at 23:43 +0000, Paul Moses wrote:
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
> Regardless of the sibling email I sent, I think that this is a good
> defensive practice to use check_{add,mul}_overflow() here.
> Having said that, it would be nice to have a selftest in the patch-set.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Paul,
Please follow up with a selftest reproducer to exercise the bug.

> [...]


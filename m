Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81653E317B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507693; cv=none; b=U4YT0XY1ecPpErljrEbpQo1ApmQa8zlAnht4j2qbXNpDUM2zxCiuA0xQk8aLoWy3q9mf7ilPwJS8lVPzbWy0B3rw5R0iJCQtzwQfK5ZKn/G4Jlrj/ddgqRxcZj2jkY8wl+hhaJn78eE7L/H8Ama1CMumCN32dA/ddjwdSIA4TQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507693; c=relaxed/simple;
	bh=tpcOx82T1i3wP56I++O00dhCkMEesV+OWfy8gFGewqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2FtCYG3Um6HpNvkTSeqPx2I/sUFHu8s0+B1ZaCPKupLtl+cLXaS16t2gGmGdDkf4LjbaldeG9CZX8O2cj/teTPHzQkSyQ66d0au+Qdz4GkW1dTnKK5UA37z4QuS9lqvJc+95yeJM+RvjR1fKRfq6ptlVe+8IoYvSle/DH9Lsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GEtANAto; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GEtANAto"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1f758014b8so97062966b.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785507690; x=1786112490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BqwAfgX6QeSnV97D/RnhlgmbHEZyyQJlqoEom+VcTo=;
        b=GEtANAtoXlxFIGbQZczHpyJ61OsCLXpeO42mdb7WFMAAW9ky84BUorpkeavvg9CPZn
         PT66+DE0iNNPxkLBQfH0Kse3I4bz/dBGEX2Az3N8BP4POprrd3hkMV5BO5BroK3PHRH+
         6ml51ClwHmZOG1ujF/7p+JuLpc5Wn5c2xxZ1Asvyu8LzPb/F+SBvPrZZoGbw7shret51
         uJ/TaW+7rw5uw+WaqtPxj2UTiW/kwkTWRx6Im/Xw2eIaGgw20qeLcJcfypYZXt7hi/Qe
         Z8EzaIyqsNPZs3Tp5/eXQYzP3tf6oyEmzno6AJK3ffas79ZHJ+KJ81hyTVo6eGEoQnsN
         16iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507690; x=1786112490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BqwAfgX6QeSnV97D/RnhlgmbHEZyyQJlqoEom+VcTo=;
        b=B39SCim6GA+jK2MY9IpYC2zX22AMRzcGSa7X656QXSW0+Z29aQI2YaC+XYwJZbG8uf
         B4QzkdZeERD4Wor8SkB4FRpBBWPJhFgH5R8M/MrkIOtZv4Nr9TOfwmX7lTnfZKchQEYi
         b+xBPiOY/bnAO+QpjetdUI29iRUYZ2nGFg3e5MGn8TZJHbOC7m+GyFpBQuyCv+2qYWM/
         /PvUFqQ0Q4tVfgOrmCMAMomFaYWwM/uYgf97Aj9LMarnm/iDC2jW/UDhIImVVAmLtdLO
         0N+84Hj3xkxfwesgWkPEjpGHC06WcrhHKEoRElXUXBJrg9SFrZ0qKvQbYvMN6Z4UvD7h
         /VyA==
X-Forwarded-Encrypted: i=1; AHgh+RqvYVA9Gtg0Fsk3pCsYRdPhuEys1hQvFBEL6hBieYsaxGGgnedL1FwYU5gmlAjCOZYq6dwzRSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIZHFOJurZqTbB6lQ9TwxxXFAYGXB/WWp/QBH3jzMEXqFpwVX
	UXsmjMcZksVn+6YxeRqI3jLTiEvlI7a8DqYribDdJdkCZ1RR9anH9gsgHR0MU+Fmzco=
X-Gm-Gg: AR+sD11X0oZO7n2pHHYVShhwsbBC4zOuzQFTW6E9+N6YpvAldn2R+Xe6KU/o2uGmJIp
	PHdqsFdpQi8J/rZrerzMvwIEy/NL73yhgTP9db5HFj/MjYJuGFTc3UJtPmD3TZRy0ZlPvzJ6wwI
	ShTYWhTLcjMZzAJRlngYtCmfhLz2gq5487TVLIIqF0xjNq4QqXyPMAn/NpN5FPrldZLxE6yOERf
	jkQ/w7eEq87oUdov3ckW2xCc0na7CPIng9Kjby9JZ1KHYJtW8Yse+ar0lgnSfLriNCtGfACgsEz
	Cqu8N9QldXocOh6mD89WkaYmaTTJthloPaYX3RXlY2PCTXDXQ+UPKRYRFHXFq/KkUu7zWsK/F6G
	8Zxi630e++vn2rwttExzptLOsiy+XNo6N1e3BK0IY/dlVr7Skgh8okhz5Cd3a83rC0zB5Jstjqr
	9IV8pC0MxZwM/2MYke4jjv6NrVVRIRSzecUwptjWmj2owLxnneLn2TFVBXdYNhlBblwH58a/P/T
	Fh9TjMHdn5Ue8AgvmktAXWPqg==
X-Received: by 2002:a17:907:944d:b0:c15:ce72:9352 with SMTP id a640c23a62f3a-c1fd21c33c4mr165122166b.33.1785507690113;
        Fri, 31 Jul 2026 07:21:30 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c90739sm162999266b.14.2026.07.31.07.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:21:29 -0700 (PDT)
Message-ID: <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Date: Fri, 31 Jul 2026 16:21:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260729123243.790023-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 2:32 PM, Jiacheng Yu wrote:
> param_set_charp() stores charp parameters in allocated memory after slab is
> available, and releases the previous value when the parameter is updated.
> 
> The previous value is released before the replacement allocation succeeds.
> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
> left as NULL.
> 
> Failing zswap's compressor update before zswap is initialized can later
> trigger:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:strcmp+0x10/0x30
>   Call Trace:
>     zswap_setup+0x3b1/0x490
>     zswap_enabled_param_set+0x5b/0xa0
>     param_attr_store+0x93/0xe0
>     module_attr_store+0x1c/0x30
>     kernfs_fop_write_iter+0x116/0x1f0
> 
> Allocate and copy the replacement first, then replace the parameter value
> only after allocation succeeds.
> 
> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>

Looks ok to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'll give others more time to comment. If there are no further concerns,
I plan to take this on modules-fixes.

-- 
Thanks,
Petr

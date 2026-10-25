Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894640;
	b=Sf5h2tWtl+cb5im4B/+YOVFNDYFJa5uOHQeB6kB72rs9kLxeaU7k3DjSJRJfpctKsZky
	 PpMer/+JLO8SGer2N3MwZ9h3gpUxXpcjc1uyfVEcAyihNt396gAq6+9M6UtavGX467gyu
	 IjfhAEPinlB4TSU4acqvTKjOnzS4hIrzigt//AtW71JABetLc52QdtTEghORUxXqUqbe2
	 2Y8RyB2yYI7T6wYkYzYknhY/r4wgrnTxk5dGYueyuKm5kTDqFbzxOB3rQh1+OweeVrSEt
	 7b9F7xY5OPelYGgM9HH9wwDPTf4g0sa/ckuENUGPqNYlpye4Qz+HEwDXLVEJbIYoFvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
	b=XcTnuwl4AA9zXUqHOXAOH8yH60LSRjl+SUgJwuyKa1arZJvXrn8B3WFt114VD1FlKwSu
	 i/Y+EpR2ZgJaN05gREjz/uFMhzAcOf37oAPohUa9Log+W5JOLLig4qIeHvbpr8eyaH134
	 +fBC054uohP7zhPXRZFVhvO8qbaZogYJAXIITXLt5AfWjQga1Ax0SCmMwLflbNq0kGRt/
	 dxBKIzquBVSlfC/oxTXS6XgT8WKPn+UdW4hT6xW4RnA8D9a+bY7QYaeuZgEhVv3VpYidR
	 iVzwpXre1H32BPcujcR3w6F1fNY0u/pl7gbso+XN9O2uljmr3sudIDX7YjcF8DtHY4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gNV5pj8w;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E606A323
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 02:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B689E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gNV5pj8w
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so3222154eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894639; x=1793499439; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
        b=gNV5pj8wvyqTFd7GT3mqJNxxHaMp++gpshfwksnecbSIJyjTxKBy1INB12+h1tG1vJ
         TfQo9m1tMSvHdOHNHXZWI8AUho60rXmoV1FcZWEGEJQX2VHMkKYsG8+OHtfvMdaNFZDf
         KT4Xik4kCy3zFWfrLIuy8jcbolNC71nrdK+Rv0h4JH2FWrqidWHkO4DzcPArWNJclVU7
         NOAjQf0A8qRwGhg7QHX7LrkTWsj6MOOgEcVlhuSvfI8RUvuaf2sg12bQk9tWE0DmEWo6
         JpdK6g8I1gV3+j+j1xZGvsfYzdMks+9louxLyXH6GOQJPkjPJXexM/eyivAnsDAWhG2K
         Vwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894639; x=1793499439;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
        b=LiPi+NsQy/+HfJ3lbSap5psfzma0AsGEGoe9ZUHJUJTQr+8LIMmz7feZhar345Xe2C
         cO8SArBbOY1f+7C7F0sPF7iTxb6j17/om5RwbF3U6Z2hqpkTsqFfVGec7I/gtokUiSNj
         t2Bf+0WytJZEZFHaJ23UliQfGS02/BrxiyXYnJaHR4Ye6Br1uQsrZHgnYaifv0BePE+T
         2TaYpsaWlAxVjDm8QXgnFRTg/X6uCKD2IKpaiXhnY/mHQ8hQlVaZrlt4IDQ7d4vJmeQl
         YDsTGZ77gC28iqVsmn4rot9a4xkvudiwPLUVzfY8jhw//mvD0wA5bQBgPO1BkbK40KEO
         61+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYwd8KjZyA1opDGVVXfw2ackkydfdslzMoSFI8rtVOdX5tbpzKItXq1aLeMIxcG4yzkPcJ08c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaqk/aWFu+iHFnLN8alUhE3PgdrDh0vOMxrU7nA/MAV14xiLV6
	hXMhNX9MjRuSZcTEZziD4/5xjEQwQu+mqC/FYs3/9WJKAYDSXzC734c6
X-Gm-Gg: AYBFou1QOHFHmywOS1sZeUTQar1SnPryLS3p/0ncdl+yR7kGzrPyGP1cDEOsiRRkzK4
	sEw2ZPmukuno8Yb1IFjasa4Yr9fvACcPWiUK3r6pcbNo4IGFARMSNBiaxfkev+XA0ZEMxZdIFgG
	J99qz+k4aBJsrguui5lxNeJSDUivuXiKJa8G2BES/ptTtCRzAcF9mEdzSeXuYPZQSH5VLp3bhxP
	YuWHqXuO8pImZZnMI8pKN5C+NIX0PCSoQGutmUDNYtC31J/Eq8WxxJwdtN9XTEfJQVOqxRMuZJJ
	op+YfR8R7YeOQ0KL3mAoH6JHmmX+6GFZm+r/6TVRjEZ+ZudjhUXn72EuL1k9chyUq7Ld4URSDUT
	vriENsOXw5EcMyPckF6du5vpq4ivHp0HaVpu9bMnZ7Xod+cdPW12LIZqRrjiZqJu9bmdmfLlb/x
	iLd8dWYVQm7X87aTXUpg6ppb2LsZZLl+VwgBCaVBv53qv2Rj4ugq54Y0idjQf3rGzmLgCrjyLm6
	b0bTZCqiSWr3qBaTRtXxTOEIPl8t2ytHE5VzFXPEvvPuQkyxae5NQ==
X-Received: by 2002:a05:693c:2d86:b0:35c:707b:acba with SMTP id 5a478bee46e88-369e8369d86mr7944429eec.3.1792894638749;
        Sat, 24 Oct 2026 19:17:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d812d6sm12003945eec.10.2026.10.24.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:17:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <songmuchun@bytedance.com>
Cc: Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Joao Martins <joao.m.martins@oracle.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v5] dax/bus: Fix Device DAX range alignment validation
In-Reply-To: <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
Date: Sun, 25 Oct 2026 07:40:03 +0530
Message-ID: <cxsy5y4k.ritesh.list@gmail.com>
References: <20261024112555.2476001-1-songmuchun@bytedance.com> <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Andrew Morton <akpm@linux-foundation.org> writes:

> On Sat, 24 Oct 2026 19:25:55 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
>> Only range sizes are currently validated against dev_dax->align. A
>> dynamic device can therefore select a large-page alignment and allocate a
>> range whose start is not naturally aligned.
>> 
>> Sashiko found that memmap_init_zone_device() could then initialize the
>> struct pages with a large-page order for a physical range that is not
>> naturally aligned. A subsequent write to a userspace mapping then
>> triggered a kernel panic in testing.
>> 
>> The automatic resize path can also split a size-aligned request across
>> arbitrary free gaps. When devices with different alignments fragment a
>> region, this can extend a range by less than the device alignment. A later
>> allocation then fails, leaving the failed resize partially applied.
>> 
>> Initialize the device alignment before its first allocation. Validate both
>> the start and size of allocated and adjusted ranges. Use the same
>> aligned-gap iterator for free-space accounting and range allocation so the
>> pre-check and allocation path cannot diverge. Skip unusable gaps and
>> serialize size validation with alignment updates.
>> 
>> Static Device DAX already has a pre-populated pgmap whose full range was
>> validated against memremap_compat_align(). Its usable data range may begin
>> after namespace metadata, so require only dev_dax->align for static
>> devices. Dynamic Device DAX builds its pgmap from the allocated ranges and
>> must continue to satisfy both alignments.
>
> Thanks.  This is now a must-have for 7.4.
>
> I suggest that the changelog mention that the bug becomes hittable once
> your series "mm: Unify device DAX and HugeTLB vmemmap population paths"
> exposes it.  That's 
>
> 4b77739fe789 ("mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX").
>
> I intend to send this to Linus next week.
>
> Maybe also a Fixes: 4b77739fe789.  That series didn't create the bug,
> but this data provides notification to people who are backporting this
> series (unlikely) "hey, you need to add this fix as well".
>
> Also
> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Closes: https://lore.kernel.org/wlrkqqvg.ritesh.list@gmail.com

I think, the fix for the issue (the one that I reported) is a different
patch [1]. And I did give my tested by there.

[1]: https://lore.kernel.org/all/20261016054914.2601510-1-songmuchun@bytedance.com/

>
> I don't believe that Ritesh has tested this?  He wasn't cc'ed...

Nopes, I haven't.
But I am looking into another open issue on Power which this series
exposes. So while at it, I can test this as well.

Thanks for the cc'

-ritesh

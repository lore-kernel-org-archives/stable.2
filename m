Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AA44C678
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141046; cv=none; b=VYSNLlucItJXNDKgNul7eGfXtvr+xL0Um60ZvpZmVlS4qhMtl5TZiFQrh9DXeM79um3Big1vBT2qNe1KtNPbJKIQO/et3NM1Rvqm+PZczaTnw95nrx/VHDZqaAx+91zFv5MDb3g/ykyLgZ8icEqm7UVRA05ueZ55efxeLNE51vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141046; c=relaxed/simple;
	bh=uL1w8BEtt8Np/I2lqGqbLuXM7I9yviHkRH0NnWW0ons=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5XZjyjJiXNYfIayeqFmRzgQXkGjqeLi/cpqAztM4G6TwWxw74BYGlRgVnI1HvZnO5YLbs4RkZzN9asAS5js9EDywK1+qU4lCe10lDJ/Hk8OqBesBXFd7IfTwdVxlVj7vDi/WCBTMuwIU1vND8s4H4UoWdCF4lM/KOQC3/KppEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdledJKk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdledJKk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso3457792f8f.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141043; x=1792745843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/q2L7BS45aTpoyNh7m1QrG5eRubgbrBzhsyuMzS0/Y=;
        b=OdledJKkHyKkUe6e5iBmeFLKmwU4PVSsxli3jDVGIf+o2l8l/lL/Q+j1oJ2S+OFZkZ
         vu1HLC3kzj3iQ81Du7bUKzkjPOXU6kzbKOss+TygfuoNDqCJpX9bnLZh6HATnZ6gFEpC
         2cFzzS5HTqFarzB0Fe4uaW/n83p3wxocH21RfEM02yq6NBTJPhuaJGU6P5yDl7K7GC28
         FT219PpULEJ93e3nq047QIiZ+xObxIw7LApAj16ai6Y+1iFPmVjW4L9m+gs40+k/R5TJ
         Nd7sfxW0mU3wypTvpiiXEuSj7lDUbSD75uz0m9WjqXnxtRDLLaRAnsGaS4TErlGrUrtY
         b+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141043; x=1792745843;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/q2L7BS45aTpoyNh7m1QrG5eRubgbrBzhsyuMzS0/Y=;
        b=ntH9po6jgptk4v5pP6+wdnaIPjSzKdZMSriZ10nSjqTZ5Dw08LKISFWnz32Yt8M9nX
         SEE1bIfztxenmPWnaQjOamMd9QnmFMPtlf4XAR5UMyP9BVsHmn6PO8pF7CvfQJrhptGh
         qBnF7JVvNbkCdf0ORkBzTlvoijo1L3rL/RRR2XI3ioF3MXEZyhc1jKQ4fVHGfFjoXtRG
         774KzMpCCIWl3zgh2LxdXbm4J9qyfR8GZvi5I65zG76/NF2jiaaYS0jgyLDj5Xiqi8FI
         WYWHe2Epu8il8P9eNP6Xp2hOyB1E2Cz9EmGedWwMO8Eol64GbLJtmancm0juuwlfCF8l
         nm7g==
X-Forwarded-Encrypted: i=1; AKwUvBxPi0VOsAjTu2NRir0iFvyoYn5lI16f+Li52c2v5m+IEO3HHEV5uXjJ6Ga7qCtbcaiFFBMW2Dk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ypxcmzdlQVJiw+JGlXPsIzXEDV2qHQ/PkraXKhz7VeKfo+1i
	PL/+cMCoodoYwubySXQ74KBoiXEgNlCL8yZK0ShGrpU0Opj/fOfXk2Rl
X-Gm-Gg: AYBFou0nu2l7Z2ibTJz6C/f0kYpGU0fvG7NK5Dum/qAAY77m3eTvUYJ3qBE/MdTdRPF
	0IKLm/klm3iGRQaRsGWWXXm36I31sgZiYOpdZL2ofaDYepC9Xy3eCJANr8PTKmiULKHHTWm5LJR
	pcjD2YvDAmt+9CySKSNDPWIu7hloZtuXM4MHaS1duU98rGM9xb1DmgmsG9BbG1o3kHfrrj9dj6y
	Vlm7QuFd2p6mtg7bqZ6CRAdrMbSfxVOQb2avmFeilqtgDNUZj+Mk6lBEJ/ExlD4I3JR8q+uBGZL
	QBJDdawtvUblo5poykkKZolJ7US+fOeOEj5HltEHq+WoRUZol6E+9FJJMwi84ZzOKFpU3DxgfVp
	9mz5XhMPukMZFBMAB4K5K/KiL9hFMgJ26BXjv5L439eOOkygxrzesuLtskUuhLqxxP8NPJJIGSQ
	5DIKKrtHTZwy+RVy/46gGedCvpXa/R1cL0QYbwwcZeRwnvkWvAHkfiWvD16saWPBflVnUmCfxKt
	2fLOkjVB9Ds4Ne702LrFV13+0ZiMSG4U507eHAnf7Q7j2aHl4w=
X-Received: by 2002:a5d:5e8d:0:b0:48d:f7ef:721f with SMTP id ffacd0b85a97d-48df7ef72e4mr8636884f8f.11.1792141042620;
        Fri, 16 Oct 2026 01:57:22 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdcc0f20sm3509146f8f.11.2026.10.16.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 01:57:22 -0700 (PDT)
Message-ID: <eaeeaecd-f51a-4c2e-8439-36c7b8f6721b@gmail.com>
Date: Fri, 16 Oct 2026 10:57:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: avoid spurious write locks when mm->mm_lock_seq
 overflows
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org
References: <20261015-fix-vma-lock-overflow-v1-1-01beb245d9da@kernel.org>
 <f5548d05-5aec-42d0-b9d9-c14fb575dec9@gmail.com> <atHa3-KlMPg6oy8v@gremlin>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <atHa3-KlMPg6oy8v@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 10:19 AM, Lorenzo Stoakes (ARM) wrote:
> It seems likely that you're using AI to generate these review points. Please do
> say if you're doing that, thanks.

yes, I used an LLM to find the commits I pointed out and check if my
reasoning was correct. my bad for not mentioning it. anyway, I reviewed
everything and checked that it was correct.

[snip]

>>> Cc: stable@vger.kernel.org
>>
>> the parity check relies on e5e7fb278e59. before that, mm_lock_seq only
>> increments on unlock, so locked values can be odd or even. should this
>> be limited to 6.14+, with a note that older trees need a different fix?
>> a straight backport of the odd check would ignore write locks taken on
>> even cycles.
> 
> I have a plan for older kernels (just make the value 64 bit...)

okay, I didn't know.

-- 
cheers,
jose a. p-a

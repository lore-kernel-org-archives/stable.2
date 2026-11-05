Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878089;
	b=c/eQ50pYPPSMJzxR183437/ZFlTONemslvHCScO70O1HsXR61GK8diRbJ8sUnzW61812
	 hjZCxkByfEHGPPjgD1B8j1g0NqDEM2xKGQAFXvqnUYbkoa97jgmvCQxdcc6NxDhHUuzjd
	 CpFFwx64A2I1U95gKdmMtKrvkkgGfzDxV9woV6b6g8IlrbWD7BJmMp2x9xxM+EwIpK2+x
	 N9/fzvHoU3OSU79MxEiz1AltFIKDu5jJYJP0+fOd+DRocGM9l6bWvWZFs0A/KZuN60xHP
	 X8qHt5WlQJWzWB/3I2NauUfSQaicIIQ/g9dXnl7j7i56a79E1nDA9w7P9+LdeYpf2lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1uORwWZ1lMFhwuvqvOoHtu8XYv8QFSZmfwB9UbsnnNY=;
	b=3zZoma5FiFXkdSjRArjGyqxWoAlBT6ArSepPoY3ehoXZMjzA05VCLzxfrbv9WWwM5Uld
	 Tn2T9HZbKpBSY40xkurssJvBwVmG0Y642J+00SLtjj8nStJ4ZCjn6FeNx/rBknZ8I3JxT
	 Q8QfizADXlIL5HbhIS5q49qyxWfi/RgE8p6HQM8pbs/7qHOW6UM+HPxL6BoCBQjROJQoU
	 UAOe1g8kjDtl/labdzZ9j7M6kZ+KH9QJTn4ymIuxMYtf7jkkd9hx4bzzizlkK1UBOTASH
	 J4YX3Z5MkL5oaBIXPDfwZPXLhug64kFuY2aaUGFJ58u1cFXTO7CD0LiqMfxrHz1RY+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meY0Mgew;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C04606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meY0Mgew
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so5742335e9.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878088; x=1794482888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uORwWZ1lMFhwuvqvOoHtu8XYv8QFSZmfwB9UbsnnNY=;
        b=meY0MgewWJuwjMDz5SeVpgfIXy0MfhR+jC26nr6Efi9GE8lzn5EI4anT+K5SCVxxR0
         5igU13C+exswLJk8gD8dH8D7/o/RmlU9CTbx3fOP4wrFx6CRBaOJRPt0jtFQhFrM5GI3
         J1RQJnNZp0a0BqTmaVKrSbjr2wjIvEYIKRZZ81gYcb6o/AaXuDs546MbFs175ZYpyAui
         gtHOh8jmc5USMrpzHu6a6/GG6nYY2fWJMfsDa10ZpZcLY1JLMEUg0JeF3mWHPwQvikVN
         c55WFvdzqDX9HHDHCgcl6U3UZDO3HDYztYnPNQ4jxCkG8nLS0wdoyQilq6HXuQJQ8UU7
         PpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878088; x=1794482888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uORwWZ1lMFhwuvqvOoHtu8XYv8QFSZmfwB9UbsnnNY=;
        b=mE5dRO8QvHYDbI4bWMW4qn1tdIF9FFvzsFl4fDUmeQ7RiYcUljGcFlOSOsylf84oZB
         qKU5q7OlyrEo/e0ygenq4DBnyrlQWwF1XyqeXhMr4dIxQ+N6Ooh6TzbbdexrIkysy7o0
         fXAq5pXmsCyXwu68o15VRQXc+hIOsZjQuWwDu6yIfCUA2sJb3keqZTs84LNzPPRX4qMf
         1RMo6ob2HjrKQjBC8a0ULeNQF4fGx0DOAjpx4vwptw9w2N8r7OOG74UttZjsizcAfTtl
         QMggRZpl9hx71STlwEP9JubwIGO6D7z7QKRZQuRtK2c3iodTlwziVh+/4ni9B7mz6pCM
         jL4g==
X-Forwarded-Encrypted: i=1; AKwUvBzq2Pe2oKIi15kGEMShFBixzv6U1MZd6f+VTaJMTCR16XmpJKARVRATvCzdN8ZYUMY1fL77UgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QowM4hAN8TEJ/E+1Bkrhwj4cfHSp5OO4BA5cbzjEadorNynTX
	FJkyoI63GljEwUjlkwuKYGjapWcHQzNuhK+H54U/bSbipddLjVmrHmXR
X-Gm-Gg: AYBFou1IcaCj5uoCZofNtmoR2ngl/NyMu14bjcZRgtYQhxAwDh/QqFDE7vos0aoCFDV
	ycA3IMc/qnppF6nJVGFo5Mg3DK1BRT/SNbdT3//hEKqR90xmu86aaGV5TMWzdinElZ7/oy0bft5
	gLBnxHUrx21cID+Jl+bcaRbwBkMVyjCjB2Y16Kv/m7WtrvpvPbZyB6CAIc/Fx6fPRFkY8vwyXwC
	8UFRGx+ZfZHKoB+ukWiBSCSEE8jYkjYQq8hx6UIZxlD+sdHVaeyU+Pu+zBPuVW1cn3bVCSkrsdn
	g/7merKBYbyapaDySQDKcwgrxuBPmR//UXpGT+g4f/RSPUH+/wxOSmukZ5V4+OOS4B9JG0hVk7O
	BLW/A0a5N4MkFk67e+qYLSaOAuKiIMSU+uYlqhs6qv9tvuDZAZ/5zSiVoxnGj17umYC2EtgBOUz
	I5lVm8xvVzgBlgHTCYwOIuT3xoBAHszap8Dq/XHLgCcb+xDAvyjmRm26GMzaXmoh3jchKi+olUw
	r2sUncGwWS1t1gYuHNoxNlNKfjumwmpVtc8+uvo/XGRGyQnx4jIZbkE2KJnzbtSnDOd3Qn1mweG
	jFImavnjZxKToWkWTQCcEIA=
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b55dbb09dfmr41331955e9.13.1793878087546;
        Thu, 05 Nov 2026 03:28:07 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e59d3sm64368315e9.10.2026.11.05.03.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:28:06 -0800 (PST)
Message-ID: <a6b65236-24d9-4e2f-aac5-d90bc4b6a357@gmail.com>
Date: Thu, 5 Nov 2026 12:28:05 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, akpm@linux-foundation.org, lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 5:07 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> unpinnable, causing unnecessary migration or pinning failures.
> 
> These folios already own their CMA bitmap ranges, and memory blocks
> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: stable@vger.kernel.org
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>


LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

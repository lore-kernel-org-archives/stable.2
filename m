Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089199;
	b=bmzC9Nw9AtAAczaRuoAGHQs8efFiWIIsCIScar5a8yQNMRcNqq1quXBVfotKbJocr+1u
	 f8Yjj43lmeH/tAtfVGHyT4hGEAqGbf8mULIYfDW/T+5ZoixFW+NSr1dh/s9yMvBXWMLju
	 DXVwxCMboMuFhq+CjWVutKTXPJSIKZStreyxF560V+36wLO61pKE2Z4tgT5qvipn+wT5+
	 rhWUNBnJchwVh9wSOOh6SdxUkxv3SdlaRE8QBZXAqozcpLIcD3Y7qfczsVAw6oEvkkyn4
	 vsgPshRcwGm+6zu05YtvHisL927ZD7uuHITqWzQx6kxAkbsRITpcRe6sZrSOpFOQDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zq2XnZcvuiLxYIMYDQf8X6o1F233lSiAvUCdfDIIF8s=;
	b=FxiGYHtPpPj5uIRxJ+Hc0QjLevGWr86YaT/uoxLgdtsTLaVHmkQjghkprmuYG/RBq8K+
	 sU3ys2Xobxoi1AQd0mVvBQFczO1eaZoFN2ZHCzql64sF2lNNsM5DlaOpiPxUtJOAXaHXH
	 xomlvnPDZdXqjBGrx47zARA6bEIrP7a1oVDPi8+yZLYDXbnUHXLEWWxcP37CcqSzjC4E/
	 7mOYyGIX4iQD4H0ShPQgv62u4+/d1ujiSSv0I9u5Q1Zple2x+oKUuuN7T183oYPaUmz6L
	 zj6ax8Ncs43ZmG6ZSuySJ3OY1uCCfX8pPTYzrWsu8kRhpkyfKDhRPSyM4iSnS/wdjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSA5jslv;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF49606A332
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF49606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSA5jslv
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so15877925e9.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795089197; x=1795693997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq2XnZcvuiLxYIMYDQf8X6o1F233lSiAvUCdfDIIF8s=;
        b=wSA5jslvWgrihmzbBRX06iwHPEIw4o+GsPZ9R3rG8EraHp5WQpMTNFJcDeIg7nvgtx
         UyIcvgYn0dv14wFu3mqCrAIefh2WmWEnAo7Wfif1ca/vNtqaaeNTfth1G9LI6Ba44X4/
         UgVluZBrOciU6YyrSiKPNe72Y9JlFHlsdS8+xETHO8KDL+vy3P2GKnubpH7K1Mu39WUS
         RxPGIoqwhal5spOz1UJeUvLv5VkIXgR7J8A3KMldlMuARWZmJZ3HK7yh+xRhmTcTiWcW
         B6QSyKuut2DoW1HrUmE0MmByu1U+z5mL5q3BqfyeX2X4ddggbAZSSD8r+ia8M8q+VCoS
         GMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089197; x=1795693997;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zq2XnZcvuiLxYIMYDQf8X6o1F233lSiAvUCdfDIIF8s=;
        b=o+z1pGaZaXIP2Nn+n9PEb1r6hhZ3fhnt8RUp7ChzqQ887VbCS9Nk9wS1iKBGwWb7xx
         hHKy0X2ZmrBGDSf4ro/o+bGRbWVVKL55bXS/QwPmKTTvnMuP19Eibha2IaeH/K7RlZaK
         SK6nQ2DNlGglZE3EY1s8vSkqDN7gEfI5A69Rav4F11ZHyRYBl3+/Jj7Q9IZ/iOrsVo7V
         WcefiHsh3gxqkqRoeVY/7PsHwgXirkbUfZaOO1E2nXWaaqAq4yQgKVp8hdMw9M4o3C2Y
         nYSqBMJQdF4iBX6Lzgp9GtfsnMNT1uiMCLpMUBTQXMXTF2MwdfKkjplqlRaFJ3t0OpN6
         4zgQ==
X-Forwarded-Encrypted: i=1; AL+hErGOwATzX5/r+OMk1F7ef54oaYRPlwy1IgrFrQJOxLDWSDuyp/MpJVOMGKgz0crC4qiCBfWOO+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SY6yWe3cDBKWoMZ4UlZlYhRI/i6qXvpuP2iJHRd1xpvxcfn6x
	jcwO/TaZhsQQJTKNqVE4sLqr0KYyW3FS2iurHILbFdH4EEQGErkpPlBN
X-Gm-Gg: AYBFou3tGOD5Z18sGqQ5jzWfMEbdU4fziuV+1pfQN9uRKvIxda4Xvi0AzyIr57Se7NA
	QJX/GsT9TZpYVAqQNQxh/izrwBweXFfoPViQG99sFObydR1yQz2UpTIJMKlFKPzT0T33HzxPt5W
	6nTQp2s7xsiPZAErIVL6egJknfIqhP68HYXsvoz12+eZJPRtfl+MjkRTthT2urc97I6TBqvQudy
	VNAgnHporQpw5MYlDXpAAx/HyvQbIhgf/zItWOrPJ6LoInUJsVgZgSxBKd30whvtGcKpHLPYZYs
	4UtQWqZmaRoQRD9QNO16yml4uOnKUVQ0aubZAyBIOLjJWHcLTIdPPDQtsN4sdCWbbo+MrzhEKko
	mfakn8NpIGiXieOnsdJrfOV4iHOtBNERK+5YPkyUo1DJJUMLbWI0vASFk/adabE43c9sQ5/RSWJ
	ZH1HWCGrmoyrfBf91sTILxu6JQjTcYF6KdOcspu5MWJzuA44lruMVaHVWF7G07ocHbELF0sXh3U
	+ClVPRA8LBEo8PlpMXPnJRHnzvXFRKYKsK/UkVzE5Rv3aOQq7d8T5Fm9orGdmQ7Ik9a3izHLOeu
	QLGlrWrEJZkUSBMf4GbDbbdJ
X-Received: by 2002:a05:600c:4ecf:b0:4b7:6942:39bd with SMTP id 5b1f17b1804b1-4bb7da395c1mr109315655e9.26.1795089196516;
        Thu, 19 Nov 2026 03:53:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b5f1sm10580575f8f.21.2026.11.19.03.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 03:53:16 -0800 (PST)
Message-ID: <32b06069-0cab-4e9d-8d6f-b0852711d336@gmail.com>
Date: Thu, 19 Nov 2026 12:53:14 +0100
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
Subject: Re: [PATCH] mm/page_owner: fix double decrement of stack count on
 unpoison
To: Nilay Vaish <nilayvaish@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118212819.403059-1-nilayvaish@google.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261118212819.403059-1-nilayvaish@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 10:28 PM, Nilay Vaish wrote:
> page_owner counts, for each allocation stack, how many pages allocated
> from that stack are still in use. The count is incremented when a page
> is allocated and decremented in __reset_page_owner() when it is freed.
> 
> A page that is hwpoisoned while in use and later unpoisoned passes
> through free_pages_prepare() twice:
> 
>   1. On poisoning, the last reference is dropped. free_pages_prepare()
>      calls reset_page_owner() but, because the page is PageHWPoison(),
>      keeps it off the free lists.
> 
>   2. On unpoisoning, unpoison_memory() drops the poison reference and
>      free_pages_prepare() calls reset_page_owner() again, this time
>      really freeing the page.
> 
> __reset_page_owner() decrements the stack count both times, although
> the page was allocated only once. The first call clears
> PAGE_EXT_OWNER_ALLOCATED, but the second call never checks it.
> 
> If this drives the count to zero while the stack is still in use,
> stackdepot treats the record as freed and warns on every later
> allocation or free that uses the same stack:
> 
>   dec_stack_record_count: refcount went to 0 for 92274844 handle
>   WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x5c/0x70
>   Call Trace:
>    __set_page_owner+0x110/0x290
>    get_page_from_freelist+0x1225/0x1440
>    __alloc_frozen_pages_noprof+0x1fc/0x1b00
>    __folio_alloc_noprof+0x12/0xa0
>    alloc_migration_target+0x81/0x1e0
>    migrate_pages_batch+0x1f2/0x14c0
>    migrate_pages+0x9c3/0xca0
>    soft_offline_page+0x189/0x570
> 
> A single soft offline followed by an unpoison is enough to trigger it,
> because the migration-target stack that the offlined page is accounted
> to usually has very few pages.
> 
> Fix it by decrementing the stack count only if PAGE_EXT_OWNER_ALLOCATED
> was still set, i.e. only the first time the page is freed.
> 
> To reproduce, boot with page_owner=on and CONFIG_HWPOISON_INJECT, soft
> offline anonymous pages with madvise(MADV_SOFT_OFFLINE), and unpoison
> each old PFN through debugfs hwpoison/unpoison-pfn. Without this patch
> the first cycle prints the message above and 2200 cycles produce 6597
> warnings. With it, the same run is clean and all stack counts return
> to their initial values.
> 
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nilay Vaish <nilayvaish@google.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

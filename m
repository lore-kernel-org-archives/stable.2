Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352719;
	b=Zb0HmVU9HXz9vj3/xqdRZVBqjSDaI5S6vowc74YKYipfT3kJr7F7khAZv8ATdBe2xRrE
	 wqltcDm/EY4bamCKkkX2mUFUvHCZrSrAnSjPwIawBhwCc7+7aKYbKb5JRsqhvGqtmbl90
	 NumcWtiyJd1C8wRAm9LgZt4DaQaBF40MlAz4qclFb60IoAuuLPUXIx7F8FJHN2FHS9uWh
	 g4HiHYL/ZmTUqh3l+IrXENvBKQVNehvFWcNQiDkgrGDEWJSZbisvX3LF0yLna3KlDBKDG
	 w2DAMA0eMf5OkiXJ6uu5JiOEicDp65U1x6LMUMYZd8NhWwG61mdyPk0TnzU45c2bWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hWrKfPGF7LOPwjmyteayfnOd6ieu3Oe0BV/YoOgWcuE=;
	b=MqBHTu5Jz2Df6cm/objX/t/MelVN3d0iKP0I5AJOMgTMRjZzMmUFtPIGbqrT/CHvK36T
	 WS0ylqg+I3c4BFjbTB5TVLR/fXS3+zUgLcwVnIG0+/eqICkwAjQbNj6x6vh2PPz3mEi7+
	 fl0ZfJqpDpOEMjgxSrJBY5oPLUG/JoWK1B3iKyNVa+vWJ3lzE01Ha6y5K9KAgWlcMgucP
	 8kLipYcKcGxMyH6lEUXu3OfvrvbgP1CzyPe7CZ7UqwyFikXQOSD257lo3XFFIHR84MWvz
	 KRnE9x3om5gMQ+Rncyea3EvGDPm/ONSj0VsYKq9xIkhmUAtzozcQFH14W3feQUxUttw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tozd2miM;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C3606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9C3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tozd2miM
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so28505725e9.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795352717; x=1795957517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWrKfPGF7LOPwjmyteayfnOd6ieu3Oe0BV/YoOgWcuE=;
        b=tozd2miMJgvbvNeNGbQWDgcCsVPebMa9c7yzHqEX9QfBBqx70IK5JMAqMaKnFSoHJV
         Gh7gFBq7mxdVhatyg4jioRwUVtk3G7tWkJ55dJoRjnLEe39cqNffHc+y65KIW+xgupC0
         cO8GLfsEgtRKrl/m45dF0CmvYuMdqPFHNJpg8elnB3uVhrL4+jV5qX8pPYJHqssOxEoy
         tOwLt5E/mFHAObutIqGwsfXdEDMTRmfztU/NSh8K2f+SJpY0x9MbXeg41oSNSdRSHac5
         RiMuS1a4ABA0j/MjQuEyQD6+nCgVI4rVI+C28gnmks1jOBe2CKE+PTb0h4dNVAqQsgGE
         4srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795352717; x=1795957517;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWrKfPGF7LOPwjmyteayfnOd6ieu3Oe0BV/YoOgWcuE=;
        b=f+1w63XYv/jqnn3++bAQrg9OTdJ7E03KPnvqhC8qc3c3NduOKyeW5tiwagSxsbX7Fz
         D5qWAK1pQIOH/vuAGehpOqrNmTOeEzmyYhar7bXUOO7hmJBhHD00Zw1knkVWNaoCb9k7
         eHYmzjmA1Aj+MFez0bN6Ha6nQnC2KoYbUw30u1SIphsKPVFbehamJVVHF3QCwlvGCU4V
         I+GZvo5adwvc98+Q01Cby/LRXK/txl1tiGIbiZuEY3zMHff2ZhKlITq/+5iwgzflnGQZ
         HqLsQnr5zbi3aIVEOrilgruIfUUbXXYcTn1Vl6jDtZJV61trBXZyMmDej8Mye416J136
         XNjw==
X-Forwarded-Encrypted: i=1; AL+hErEGbF48l2do+MiJhCAaZ1xYK+IPJM6+ervP6TSue3OPOwkSdELPUOtszE1b73zDyQWOJeK2j14=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2DyS/H3rNmgBTI9LY8lktaVnOM1rdIiZGgt6+TKcJ23U0i7JK
	ri9jCVAxtYJ8sQjkoWJS6LZ/QZ1BjaOA/anoio3Vay5jPRaCJx0Kg642
X-Gm-Gg: AZFdTZeRiLycR0CSGCw5V2QKFj0xrRcGb1vbCna3HdCsOwDc7GyJOP+2U05qyHYM/gW
	+GWmRGSHoxKpQChy4G3TtwKChLZUB3C9KGYXZ5y8N7Lq6cREOc96Av+T/1I8ymG8/4hLbKUiB9F
	vtFQ6o7xZfsaLwiLsO/qnUpAspQKuhnPiiRV8TJQ6hVqL1ECvAsgMuAFmBYV00sCyi8TT0E5PS6
	0/ddD3cPOhgFaZ7rg7Hqss/aWDkKNpZyxqlRm2NyZZAGeARx7mv2S+2IeXDfS1CH9hjX7Z1K8ms
	s+AqKm4rUCUFA0QrB6w6wfxtpAfjVzOwdjyLHu8eRuhe2AqhD2t0rRQDz6aLBhNTI7ZJWCM969p
	2CJte2M03/cjIe+LSXxL3Xjs6uLNKU+CTtANP3DtfrpJv6ArU7wg3UnvFOWPA4mLGbw4ufbZ1pm
	m5ir7YRO61tUpLsgnjpSWezjfsQyUKlNWZMAv7FI6m1xUpWDg6Nz7uUGlP37Ttu/MWYRHtjM3kU
	tL3S6AbibiwntoDGoNDzf/gQ16ocJMJLslqsnA9/XnSt4SLJoaDV+df1ATXHCtuIaTrVUL4eiZA
	AdYAl3wk53wmTUjVbYCRZFIe
X-Received: by 2002:a7b:c4d2:0:b0:4a1:d291:d863 with SMTP id 5b1f17b1804b1-4bb861394f1mr160871155e9.4.1795352716633;
        Sun, 22 Nov 2026 05:05:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm13317236f8f.45.2026.11.22.05.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 05:05:16 -0800 (PST)
Message-ID: <5f0dc94b-af96-437f-afc4-cd36d8b1a249@gmail.com>
Date: Sun, 22 Nov 2026 14:05:14 +0100
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
Subject: Re: [PATCH] mm/list_lru: fix potential infinite loop on xa node
 allocation failure
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Kairui Song <kasong@tencent.com>,
 linux-mm@kvack.org, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261122031143.3639941-1-songmuchun@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261122031143.3639941-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 4:11 AM, Muchun Song wrote:
> __memcg_list_lru_alloc() populates missing list_lru_memcg entries
> top-down, from the farthest unpopulated ancestor down to @memcg.  When
> storing the entry for an ancestor (pos != memcg) needs a new xa_node,
> xas_store() sets XA_ERROR(-ENOMEM) and leaves @pos unpopulated.  If the
> following xas_nomem() also fails to allocate, the inner loop exits with
> the error still set, but the outer loop ignores it and reruns on the same
> unpopulated ancestor: xas_set() then resets the state to XAS_RESTART and
> retries the store.  A one-off failure is recovered on that retry, but as
> long as the allocation keeps failing, e.g. under sustained memory
> pressure, the loop makes no progress and, with no schedule point, becomes
> an RCU stall / hard lockup when the caller holds mapping->i_pages.xa_lock
> with IRQs disabled.
> 
> Stop the outer walk when xas_error() is set so the existing cleanup frees
> @mlru and the error is propagated to the caller.
> 
> Fixes: 28e98022b31e ("mm/list_lru: simplify reparenting and initial allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-21c1dba9-8d6f-4368-b38b-9a57cacb056f
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362809;
	b=N6EI7ijIGlGXzwt62ID0gFY9MJxhQICBuxV0rBOJH9w2vIIvfohg+k0pQtfLtJ5WwFm1
	 fH6Tc/Sszp/pRPjZIuax8PoXjUNJUftELDzkRd6Xt/Upisy6aB39V0c3K8nwvyJ3qaj9l
	 PJ9ZpgDTS+p8HsIjiHciJvzlID4n59tsH++aRkRN6jLObjdbjPyr20f8RrG+8rgD1HNj/
	 6DE8ojlOsxv16d7JTxouTakX2Rz88Svmf3bLkZZfvWhQkQq7w1jQNvN2oT+Wbt0vM1rku
	 o7nDVzapWoigtFDlmDysXxiFkzNyNYk9sQrpEb41p0UYq7k1Hxfvm4DrMfvcVogB6tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=Fzk0SoUY1PVvL00u1hntgJWoBs0ufQmEIsqyDHWq1II=;
	b=TVH/wijlMD1YQogXYy6coIHpS+StZFYf4tzDHgcSusOjVzSbkGmo+fLASbgxz/bU4hGn
	 vakmm7O1EllDlWPHcP5ROvqXXE//v5wNh8ebMZBnF+oY1eY+ZwPvGXJuyx2hf7VwjS7OS
	 zAQmRG6jOVBFlAVovczHWru6NZ6ATrn15so9Xt/BKBZedbwjkDCPhY7y0s3rpFxtnfcLE
	 fmhjrAD+97X2Hb2hlf7VapOJ9jnh8SC2D8SPxT4ypOS+CQvdvahl846RrEZaR5gMpOTdd
	 k2y5Xvbqr+k6/ZF09K6HiMzVCfTjfUR8PEbU82ZNIKdyCKW//IWBVy38Rwtyi4e5Neg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uan6fDVp;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B813606A6A3
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B813606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uan6fDVp
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c1f548f87so39404776d6.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795362805; x=1795967605; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fzk0SoUY1PVvL00u1hntgJWoBs0ufQmEIsqyDHWq1II=;
        b=Uan6fDVpaIiP3qYVWWIb8jj4MD/7ocTjX8rCFaxIeYaCxdU1shSiLyBULnAyl/p+ko
         B2PVCw2VF3ph+HAosfgpTFRrrtjF5Gi8vp0a6N0KyisK94Fcj8cDmDWwcGB15B19XNPw
         /ZtZGvl99rUnm9/bIJfTBthSHBIadaaNdHW0C0XyNm351+kPHnC+qR9kzQo0Z/bIrUp+
         /otOUPbrwWCDwM+1A/QN8RR/Cl1ALc0vhyR7RbLyLiQt6f94Bd995uL/lxJDlsk1qBUh
         BS3hc0NC2LhbSKOTaE4i9xYGZpkBma9+l7wDq8pq6WX45OwUWKllegaqPdz6WdobGS4d
         VwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362805; x=1795967605;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fzk0SoUY1PVvL00u1hntgJWoBs0ufQmEIsqyDHWq1II=;
        b=x3xX8pr5fqLW59OKPIOHrnDI0WXIiy4rcJmd64cUiuHHD+6l/yC/Cbldh/Ua5MjCSt
         /KCpdQe41D408/0P0EqSxA6qB3Vqq5Q71BEAnHLgY/HVNerirnpQCZend3Dh7hvYWqyC
         tzaykDTxN9ysjrxdlIi9z28csc39h/VxIVZaqtakSDNPh9pkM01Qs3p1iVDQBU061CQw
         HRdxyDb9ilGzjiALC9qS+a2WHw2Pq/B99xGLbXj7gDC8E2FwZqI9JYWleIHGsCltkBZX
         4s8YPxkdQ2ktACwqktevoDbRXHYCfvkmnqbhGaw95aejCledrSUY9UL5xcZ9LPEEGzTl
         mm9A==
X-Forwarded-Encrypted: i=1; AL+hErEwboVGtfibtvsqMSc+S5jJL3VVLuzGAx1gFAVvceR+/g5ckc/TWiePqLiaNaaDQgFyJ0Y2kok=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GXBzshNeX4th68gxUoLMQ13PaK1bK1xTdHoqBosbf2S3DGyhQ
	DL7BzzInzP7d5aBZgMYfQBk4J4OpRogzE0xPBPCzGeF0REgy/HhnNwLKauFOu78BB7AQv2Ywqnj
	RU66u
X-Gm-Gg: AZFdTZfZWQtj1DYi3uipiEoGgH/WhSEYbpaG+GvZ38jOvqkqiH3cVKfqztixKizwa0x
	4ngTYW8zLIRTwTOC3oDC5j34KPckqoAFBWNJd5jD32OiKfXRf9rz4E6vCYQOKO8rnh8OtMmJXRj
	gZeby9toZiEnOCxg7Ipv97/Nly4w9ECmOFdocbwJpFniL28bHIf+b4OmW5QcOJnQCP0L4OZFeoI
	Z+9VzVDTzzmD92xNeO1LULCpT2Pr3wiAElNJoS4u+jkzSxbD1mLZNfJu+wd9lsxhE4//SCAGY8C
	12JqurdNjq527P4ivipAtIG26iTS19a+lAeWLKqN1zsALRYH19eYNwPshOgTbm3ATh2F1n+IBd+
	LDEu3eeSBkdqu62J6ZOSTz9Iezc+K1krirrUuRuO79N0kGy9XUI0Ycv9j6MMaS1zF2D0x3F2cd/
	e2nE23BxKpoeFMPZD6WyMMmKRLoXShJ+O12FSp6ReEE0YN6qnXQbOw5Qe/obGfzmedCrvL2877D
	fOYugwYvCFyP8H675pfbeslDaEutV0KrknoTTH9KRceDV67jnHnPMZkSrPG6JcDCoHv4Gan4uHL
	+hGGBZn50mELT5H9i9LYjuzC5AekfFPBuPumgsmM9BaekXzlosvGN0sB77lE3JAXu4HvAcclKfY
	/M7AgT7B2
X-Received: by 2002:a05:6214:85cb:20b0:91f:300e:a8d9 with SMTP id 6a1803df08f44-92134adf81emr116279406d6.21.1795362805570;
        Sun, 22 Nov 2026 07:53:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b79sm81259446d6.5.2026.11.22.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:53:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] mm/vma: lock VMAs before taking mm_all_locks_mutex
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:53:24 -0500
Message-Id: <179536280440.412063.5336368383648661511.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> If an mmu notifier is registered for an mm while one of its page faults
> sleeps indefinitely under the VMA lock, the registration of mmu
> notifiers for every other mm can hang un-killably.
> 
> mm_all_locks_mutex is shared by all mms, so its holder must not wait for
> something that has no bound.
> 
> However, mm_take_all_locks() calls vma_start_write() on each VMA with the
> mutex held, and thus waits for the readers of the VMA.
> 
> Since commit 4ed4379881aa ("mm: handle shared faults under the VMA lock"),
> such a reader can sleep in ->page_mkwrite().
> 
> Consider fuse_page_mkwrite(), which sleeps until the FUSE server replies to
> a write request:
> 
>     mm A, thread 1          mm A, thread 2         mm B
>     ==============          ==============         ====
>     lock_vma_under_rcu()
>     fuse_page_mkwrite()
>       folio_wait_writeback()
>                             mm_take_all_locks()
>                               mutex_lock()
>                               vma_start_write()
>                                                    mm_take_all_locks()
>                                                      mutex_lock()
> 
> Fix the issue by locking the VMAs before the mutex is taken.
> 
> Additionally, make the VMA write lock killable so a fatal signal returns as
> quickly as possible.
> 
> Finally, update the comments to reflect the change, dropping the lock
> ordering list which begs for bitrot.
> 
> Note that the lock order at the top of mm/rmap.c doesn't appear to be right
> - the hugetlb locks are taken after the VMA write locks. However, this was
> already the case, and can be addressed in a follow-up in any case.
> 
> Target commit 4ed4379881aa ("mm: handle shared faults under the VMA lock")
> as this is where it became possible for VMA lock readers to sleep in
> ->page_mkwrite().
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 4ed4379881aa ("mm: handle shared faults under the VMA lock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


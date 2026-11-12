Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506188;
	b=WWN0J3ur7DhxmxDpieAjH6qW3cwsryMzwJVD8qAInY0SxWI2iioMaYJvqbK6PfzhI/q9
	 pKBAsBiUBnxmisDC35todS1lXRUgJqHrZU5vvCOGveMI543d+BPYFMgafSBQEa20+RF5V
	 01bK1R8Co8EPNIf7X4tpBtQCd6+QPyYEqJD9otfZWQ3st8sp7y22gYlAp7/7beOJgrhPt
	 rDTuEJXMwd8gU/eC+v6nzG8FhkSXyS+/NhxN/hk/LGshSy63ngcTg63uyCEKAAyq0JwFp
	 NdKHW6RrGkoRtvwbAEk4cdIt5V8gKSX38Myb0ke3yJ+5yCr2gASBIrhBgPR6gSKI+eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
	b=Fz5XB9o+zzhgubi6A/1tNvaW+ivC/9gNL+mKARgREJDVkHvadU4WBeK8Udx7Uo1ZOPsI
	 UJKuCyoo2EvB3qGHLUpJP9aQO9BItUT71fRmTDrdYgt0s3uBLi5I2KihrCTbIJEEEW1vD
	 3kHwQRAjCdNrh00fAqbpN4OKOJJKbu5fZamW8XkYf1fjM+y5fue/PJGC7gZ/a+yP3ykQB
	 /2D/j76N0/mAayeRoydx4HkJuf2HK4DXdiAyEObdQTTdYYxvvMWdhJO3/5UUXpNQ01BqO
	 mwyLdfrID9oHe8p/IaPZG2bmvPqG8e3yIT9spyLKzFTrm26Z2vsQak8TWj0Mw39hQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EHevdXBn;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30698606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EHevdXBn
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91e8938fd01so449996d6.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794506186; x=1795110986; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
        b=EHevdXBnV4anAfSLKj5v8q2Iozg9+kJRetotcX6QAbpiWWKdfn3IwKbW+VaI2GAaZx
         1qceClnVl1GgIdWydNamNGFCl6PY/+1OUnJMCW2CqU0QDuIPdyY9QU1jxAV89RBRTHa1
         2lDsok4KB59SozZzLSpNfWCAD3Y0iYPpXq7vW2m1lZn8Cq3AXVNVdH/2L6JA+JVoVdAu
         QcT9Fv3EfNxygDjKYfo3ZKS4vQHT0eITMDOGpHaFNElXyCqjANHZeWKD2J2h0dWNDT2v
         rG89HgkXOJhxDBWcCS6c7h7an2NxYuBSUXIJhH5YT8eEJRaMSDwGmCuuaRJUFI87lodq
         3phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506186; x=1795110986;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
        b=EmP9Lf9nW91iWqt/nESMuoODNsM0/xOhz9KTUF3G5f/E+HgXQO8rWlRpNwzuYjBLNl
         SynAZCgBamI5ImivVbUQxBQ9wPZCokAF6N82IBJKYZJMbkiv7g9yZR73YwPciCeo5odH
         f7bDVTl3Ft/U3BLjWuj5/MWckxnN9lM2Yb8cjnuNJWYllYUYX2yHM/CANRFrgrvCZ8fZ
         ldulc4ypLx92MUDNP7TeizfE1PeTsNKLLcPsV8COyTP1W6iJZ4gzhhvQZDUfT8rchzN0
         Mhei0xGaMu+YBoesFcx6heAUW8XpRp8IeqffKLQmlqIZulF+b06oDs2oA3mDAe08t51F
         Shbw==
X-Forwarded-Encrypted: i=1; AL+hErFpxZeYDxrr+p2vn5eCKDHOUq2cGr3ZGvYz22VNSbApNx3DN7zyjn3DjZaa94xvoHGSBbHI1wM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rxk0C3A/f3M4ogg+CTtZbGxeoqXpZlkfsZo7Vhhhd0GbJvm2t
	U2rWpalKuVYj8RmzA18efgEMrMoNtxEFGgZE986WZt1l1ZsnZR1z/v1vnhyFYOhXKgc=
X-Gm-Gg: AYBFou0HFk3YPANx9IRZeUItQ4iactDGsvJOX+n/e3n9DKryM7zWTO3ClIY0eUhqZEy
	CYz1ptfJaW6Z/Wcrh+YUZ3oe+QRu6o0qobUAGnpOTOrDedDgOpA3yyrI+If5wWzJzgs+3gPSHMo
	wboiX3TTYIbm1dHcMswQY6kL0ByJ06STaYNEyViiWIxf8nVG9cGYPiUTQumXQEKFn+nXb296RJO
	ycAvJciuasBFD3ZexPDSN+h+1uUC5RohkS/53H2wkKnBguFrqjw68EciBiVMAVzjzUM88BZtJuH
	bevTgfTvj5JzUVs8EQiAtrEW6zLZx4b9u7ESbqjkkYL5cocAQ1ohfJDAK1HUm8Ra9mVb7Ia9Qza
	HsSvAqdIi80PuKru1conAgTc/BC+in8SPUwsqGTl58ibBC0iZ/3abVPFq+EdoChtHksdba4FjB/
	M0Xis3JcVsb0d0X8XaAnrxCiPcwy0ov44KJrbe+D/yiXb/Ol2FREhgOnb2Hm6mJGnn/T2TIqJ9O
	G5FZKpurwJrHG7qMKHX8FADGwfuZPjXS8hDOWuTwBpCdFFV9jcmB0oES+dXV513TEp7KEfqXEdP
	NfI9rQGdlhZXPJS16yMmW1GbgqRXecKxLjG+fiXQWvNXOqfbXnNSZUiL+ORON3tLds5GmwOkSpv
	upGlDH34=
X-Received: by 2002:a05:6214:858d:20b0:91e:9b17:2be9 with SMTP id 6a1803df08f44-91f24203591mr468026d6.36.1794506186056;
        Thu, 12 Nov 2026 09:56:26 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm1212506d6.21.2026.11.12.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:56:25 -0800 (PST)
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
Subject: Re: [PATCH 06/13] mm/migrate_device: don't let go of the fault
 page
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-6-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-6-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:56:24 -0500
Message-Id: <179450618409.482102.8556965317179106876.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When migrate_vma_split_folio() has split the folio of the fault page,
> the lock and the reference which the fault handler has taken are at the
> former head page.
> 
> It then moves them to the folio which now holds the fault page, by
> taking a reference on and locking that folio, then unlocking and putting
> the former head.
> 
> split_folio() has unlocked the new folio and has dropped its own
> reference on it, so until folio_get() nothing but the page table entry
> holds it.
> 
> Only the mmap lock is held for read, which does not prevent another thread
> from zapping the entry with MADV_DONTNEED.
> 
> If this happens the folio is freed which results in folio_get() taking a
> reference on a free device page, which the driver can hand out again at any
> time.
> 
> In addition, folio_lock() can sleep here with the lock of the head page
> held.
> 
> Utilise split_huge_page() which will leave the lock and reference at the
> fault page correctly.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweaked commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I was able to reproduce/observe the ownership gap trivially.

With some effort i was able to generate folio_get()'s zero-ref BUG()

Can't say I understand the change well enough to give an R-by, but
the patch does resolve the issue.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


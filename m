Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314749;
	b=zgIR9nvvZY1fndIGJN8X8ocDXQ4J6UQkT227kxIehhS9KyQ/OvqqqMeqglaQ9fd9qapn
	 Ld9VfPpJVflxEaKuBoCdlly4ZR5bnCdpINu98FoFMBP2Q/pbODdX7lyfNIphE+/utyu1g
	 KFGzte7sE5EYCYyaWLl/TQFq4X5LKnBQhkaDr+I3ho1YVUIALiiNUbMmk6yzRHWarTB+0
	 yRV1c8KlQHM8AYK7GlEb4JbXrALuC0eHiVLhjYWPmAP/wlKtbO+JtrhiTcEKG+GGOJ2A+
	 FwbymRLrwYzymNrlqkTDdh/IbwRa6C9QNK7U+5SVKy6QwC7CNYyDzBE4pT/cUtgKwcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=/n0bim+DZunsCFW3lXGEDWBVlO3l7mvDuQoSVxWJW/Q=;
	b=ty13cn1YAFgwd/o2uUTqAW8vsENNgbnyx2iKf0XpBHinQ1bPsbjl9BdR/XiAmq2BNdC3
	 RlZNZIm8RoleeLdSjWc6FR2eKsSPgcQkfLYu1jRyhHVAoqlKzI1haBnTFyWFjkLLkFDN0
	 KhuFZb02jAOKrI9K2fXHri9dB9a/IDNE1nbDuUXKFmYFstfOiYEAXM/YaMV9fWPxV8xyb
	 Vg1iPkAmC6ND2cwMaPxg/r9bnt1Uw+CCA0HzecdeKJ7bbxqHCa9bCWldmBm+0CbOP8dKF
	 xqystxN3+O8ZyGKZ0bOx15cHN/n4up74Psd1ffic7Kd9VsDZpoX4AS2XbJnbY+IQExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tiZ1cWKS;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tiZ1cWKS
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9441591aa5cso225286585a.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794314746; x=1794919546; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/n0bim+DZunsCFW3lXGEDWBVlO3l7mvDuQoSVxWJW/Q=;
        b=tiZ1cWKSpc9uAv0SdzmnaMzMNtVSWuInLRsIW8yxgbXOcAaw21fF2tKef0pbuZrtXH
         +aQ0sd4xtOF1PnF3vnvB/LSDXBjOSrJErA1oSrgBc5DZgQQdjpCJX+hYFYkQ4WAITkAD
         fDzUDn9nje5T45hIFzVxmaTKlJ7xpWldKxWedK8WqnRk4paqGkz2je46okt7IFJGjZmi
         IDx5hHlZnatMfaYpoQrRjZDuIA3xr1IeGibAjwN+3PFyfGCzOb4qJ5s4+cM13tYMewmG
         fq8+WmwDUI0puflffDQkswi8ZZ+69IhDbpzipsofhkc1Uo0K/GcDMPq0tP6kmv9F6aTl
         n+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314746; x=1794919546;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/n0bim+DZunsCFW3lXGEDWBVlO3l7mvDuQoSVxWJW/Q=;
        b=IsowhfRpqAgrWEQolRF6BxquQPYtHVK/9nVRnOAcwE0ZrrJpk5sjuBnd8E99nSO5xz
         74lWF6P28V0b3618fLXF9ix4Pl/WKrXGUfsNHFeECvPzIie/ON6kP7vT0VWFuWotLY8O
         Q/6b+uMFmhgdEoo1lHjfvhPwVdyJVLWoP3qTPLLNzlezx/8aDK0wxKBGR9fkb5hF59Z1
         3b4+xhwvOgVvTarbIXRpkFdVetqWJprk9JJYExfJkI6S9bOo8Jl1hbq7vj8gjgXEUENF
         2TO3mQT1WOvQCzaX0oyvz4Whp1fpcYEGr62MybmNCjfkj2slD2XEqMaO6uAh7iz0nHVI
         3LjA==
X-Forwarded-Encrypted: i=1; AL+hErG8uwiGdj9nf34aE5cGYsif6n5OXWiFl0GbCl0UG4CkgZITWbsql2sxI19ivXhW8YMvVAT2mL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3P49Asn2sWd+lUqSY7+Ia2A+/JxAYjaxqyosKRmJsb26JBYUa
	sRth2EJSIe2Je4xdr70lrrrUTDe/3e80sqvuXPCdHimdruK8TnE2ZyPAPxjEmra94Dw=
X-Gm-Gg: AYBFou3ewOrLZTjPrLaNsNsA0oR9qeCOxcmmfW9FZiddH8PEUMniQT18Jfp7+Bozt9L
	65ijtJHJYENI2Pp2iCVEfeelKHTfDO/Pk9tyMP8CgQacgARGhHJz6T0eeWpfER1Pf8pUQdQ3L+X
	iB695nFrTWg7SnqLcsQCRvMqJOQ3MCUhlpSSMKGUVHyIDQnLPs0vkw+/8JXU3Ms8LjfJsIM77d5
	HzcP9dWSGcHcgq5CSdc59VP5NuJ0ze2ptcJw0zG0EYzj2PNhl5z4yMO/d0ZSSPMbZS9cFJyGM/S
	2wPtSARSOLdNzwFDa5ntLF50jaWpUXnyLjI/cUn0SkJUAes/K7xgtvKaEmpI7QmrD9d32qhbgnO
	5I2DXQTmszgU++KctccQUWy3lcGCCp5Oi/OoaNYNAgO97rSvULxHP+CKP1qYFIuHpj72279znxl
	iH4kGzGfhBFng9CNG24Ku9vqy3aghr1XvhzMTwiFYEQ1FGPHMXC2HAG/StuB/pm84MW09TBRlOD
	ZaNzZ9htushNF89Dc6GeDH0mIxOJe/5fqgjVgUvGjQ6WwpISjBwFuWJzvrTjoEaxiR1KaKUPa2x
	26k3VBQcPZKGY2XseP95Gj1U5mGpA6GHeq4JQYTj/e0DQH4IVi0QRdlJYFoU/txGfXh0b/apEWd
	ssxXppRM=
X-Received: by 2002:a05:620a:4055:b0:93e:7ec5:2cfe with SMTP id af79cd13be357-9479f4b6e59mr357636485a.28.1794314746577;
        Tue, 10 Nov 2026 04:45:46 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c3ddsm215618585a.15.2026.11.10.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:45:45 -0800 (PST)
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
Subject: Re: [PATCH v2] mm/hugetlb: charge hugetlb cgroup and memcg in
 alloc_hugetlb_folio_reserve()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 Daehyeon Ko <4ncienth@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 stable@vger.kernel.org
In-Reply-To: <20261110-for-alloc_hugetlb-1109-v2-1-25795ce44f80@kylinos.cn>
References: <20261110-for-alloc_hugetlb-1109-v2-1-25795ce44f80@kylinos.cn>
Date: Tue, 10 Nov 2026 07:45:44 -0500
Message-Id: <179431474443.789062.10429880669466859032.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-10 14:05 +0800, Hongfu Li wrote:
> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> alloc_hugetlb_folio_reserve() hands out a folio from the hugetlb pool and
> consumes a global reservation, but unlike the fault path it never charged
> the folio to the hugetlb cgroup or to the memcg.  Folios allocated for
> memfd_pin_folios() through memfd_alloc_folio() were therefore silently
> bypassing the accounting: they are never charged to the hugetlb cgroup
> usage counter (hugetlb.<size>.current or hugetlb.<size>.usage_in_bytes),
> so the limits (hugetlb.<size>.max or hugetlb.<size>.limit_in_bytes) are
> bypassed.  In cgroup v2, with memory_hugetlb_accounting enabled, these
> folios are also not accounted in memory.current and are not bounded by
> memory.max.
> 
> Charge the folios to both the hugetlb cgroup and the memcg, just like
> hugetlb_alloc_folio() does.
> 
> Test with a process that creates a hugetlb memfd and pins pages through
> UDMABUF_CREATE. The counters were read while the folio was still pinned:
> 
...
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

one note below that is worth assessing but maybe not a blocker.

> +		ret = mem_cgroup_charge_hugetlb(folio, current->mm,
> +						gfp_mask | __GFP_RETRY_MAYFAIL);
> +		if (ret == -ENOMEM) {
> +			folio_put(folio);
> +			/*
> +			 * Skip uncharging hugetlb_cgroup since the charges
> +			 * were committed to the folio and freeing the folio
> +			 * would have cleared those up.
> +			 */
> +			return NULL;
> +		}

This adds a new -ENOMEM condition on stable which may race subtly on
two tasks allocating against the same memory.max and cause failures.
In testing, it doesn't cause splats or anything, it may just cause
spurious allocation failures that fallback to other paths.

This implication may be worth a comment in the changelog.

~Gregory

-- 
~Gregory


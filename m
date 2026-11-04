Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833072;
	b=f+QZoniQHgS4+VUSnYKFz9KbJKWA0iHGbMUvahAEQOTVya/6lLVpaha/eFcllXEC0sAi
	 JLKFCROBniC/wpsBELajhPMKBVkydTTQi1VqK3WAjWwI+TQ6AY9zNUaRyLJCYxbZC8fNM
	 BUTxETMP9lenHg/ojtM8URmZd1CR2ZYI01Wh/bpcW2U9vvY9I4DwumTcVexgMqmc6VXaa
	 Ohv6WS+qZ2EgsSTGG7N5GZ9+xw3pkooipIdfZ5C8yJbdwcjEOsspbz/iEDrdoh9QGs55s
	 uiTiqd9/eIL7pR+Bd7LwnT1dG7lrs1BbWFt3dPwxlNz4SveQNbwyQ2uYo3O9MUOsroA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
	b=fQ4IjiZFaXAFxrVgZirYtWQ5e1xWhp4hitd9X3Vl4/1dVJKJQm4YYTTMYLgbHWz+ejDT
	 7gVMk9Olxj/Vwmw3nxxKHpDzy3on0QUAcIrzlrM+SXeGcfHke3cMACHkLiShW/YcYONQs
	 8m10+TOFKXQrafADH7m1WBY7i0vZ66s7LmcCe/bt/XQtg0Hlhd25x52+vtRcC/mpm4Szu
	 2LsAoQRGkr2n2aCidngRZfkjgueD8rAB+gu097cxspG56FC1+dUVzmOM72BJz21YWU82i
	 K8N5rokA4YbUOEKTrhr52Jx/QXrOC2RjhTFGZR1hTuDeEnNJybW1droovibO7Ipp1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDfTc7XW;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B24606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B24606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDfTc7XW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so11070985e9.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833070; x=1794437870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=cDfTc7XW0ifae+8M1LuPWAwdIdNKakZkFWFnJt6KL55fGa37RQmqkq2uRmhEY7B1n3
         CaBTcgavNgfBak+NIwaNa3H5fTfJ9PIT5PgZQgH2MazyhDmo4aFllXX0SMasXGEEM9Fl
         p/51Tb9ZeDWq1NeJnxB9QMyf1cDUO3GXJQBRKRgploH8Le81bwbGb+y13nOzQrXCWpNq
         F42HKXSHEzc0A6bpTaknb/yOiq64kB0H1wCLiqtk4d1YdokCcUVaxOjocfuDaznMEOXl
         BFMxyeOdRQgLkukh4xswNJohIqsIMfXRyH1cjs8NbBnWvzJr4LA0LYjw3tAYWNzSjLvS
         MNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833070; x=1794437870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=SpzDsdjls0wyqvAlyQy4DjsXyrbf1mVNOGIeaH79F/QAjQpZ+7hJHFoDhjXvNKTQpK
         bg7/B9Ei0VTiP6/RlVhBPyATKCJPrEU9196xvR5mzicFwMy5dnnVCYbaXZbauIhRsuJZ
         VpHQpA3KjoA2kRQpPekTInlR/QuQrzIv7pt6/oUCs+jGdIsAv0wKvaj71JR9SVS+EfBe
         /47am//AZ9CD1xWFLYWxw7tp8fSgIk4WsVybzAeioNqkcHpsBO5rMMgg0eBQIfPMkBFI
         kCaM3qWBjqr1jlJPpQUfvE5GT3tHYorZaFWU0VPJaRQZ7eAh+sEpyUE6B8F5CJfVl1jj
         MSQw==
X-Forwarded-Encrypted: i=1; AKwUvBxt4EY9u2Z8ZdVknWEMIcBkOGmhMAap4EnKMnDDcGBEu4rb3xidisgC1dB6peNjlq5G22cNJAw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IPZqSnbRneutpZ7ucQ9+VzM70l2u0YQAfMIcz4OuRvjkyrj0E
	q99BAGMOgMVH4iWMd/p6QYH+xXkTdRfqTlG4yiffkKGq2kmK/9oxrUiT
X-Gm-Gg: AYBFou183Al1uoX/nrdN7MRI82t5GvT9GbKXuZAhPErlaqoJZ7htvkY6zpM28uWQYvu
	JdfmGSepe0iKwS4iKmhiOE1t8oW06NEqvHd9Cy+GyW+oDDWZhopVky7GzArsRHUBXvoL4cRT5zH
	rePEeQ25U1+aH/D3BYcUZyt9eVz32qD/ymIv0jIUNpokmEvtGwx04wC2OzuUe1eZwkiEK6gDSBZ
	ieF/z1Y3ghMfJqTP7FtIvQhMZJ0tXihsQK7SkMkre2r3hUBG3uDbZ+AqQYjiWgrkQNkUh5nNirc
	HXrKZKnP2KXv8L0m4osGs0anKcsVsCtUnBXi2ep94UG+Sf2BDR8twf9LVtApL3B2IH/y0K4iEb3
	q1zi6iSd6oKuMAd+sGoO81HBso5CzFgXao3rTbndZlUdeNDFFnI9DG5jAbI+oYnie0nKQYItVIe
	P2rXh9lY38qOhBpNgj638scmg5Mm9mwwE9r4XUtM0CVJj5Rt8osZXktF3zq178nZ6+ZZz+S9s5R
	aec/2KURFmHO/XsRnPvE16Wm5T9ACcikcw2kpN7uKiaf9T/Omz6YQ0IcLoYmVYIko2cWCv80DzM
	RGX9Q8KcljFavNJITVxMHDk=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b0a7aa0a54mr222825565e9.25.1793833070285;
        Wed, 04 Nov 2026 14:57:50 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725061e1sm17756545e9.7.2026.11.04.14.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:57:49 -0800 (PST)
Message-ID: <93d13781-0c37-4a3c-8fca-6f8108eff35a@gmail.com>
Date: Wed, 4 Nov 2026 23:57:47 +0100
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
Subject: Re: [PATCH v5 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping.
> 
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
> 
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

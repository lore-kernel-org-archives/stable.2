Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408825;
	b=W5L3a5GCDnTl96pZwKHmS4QIKtqPUKSwXTVBNF4o6dYFYkyooH8urQwOnZC3sRIg/LOQ
	 Go/q/i1XQMFz/AVUHwRe5ZDUO4iUwBIA/8VpidkUn1FsEAn8WrFjMqEPsY+K6uBUsUzbC
	 G1MGZL/o4h3uNyuZtv6jzsojZ6ReVqnELmZnc8rW0aYDcA0VFFrPHDGgJdfXDVLByCr6e
	 kp/8E0bo8oJuuAViNOAfK836aFKFShawg4aUxp8tJmGwflOWYFWrwUBz1fN+c8a1YVCAf
	 jvUS9bf7aE/00LoaQE206sgA6IxBy18mxd5mr3dbmXXHjj7pdguyyywza+0vID6HVvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=b4sM8p1tTNaPGayyybeEyqVTJtS8aLvMWjajmNIN9tU=;
	b=Ijk3HkQTpTPKjKVuFYJc8qHf0uRbighhuEdiwgqPGc53xBbPWm81vQoNIjC2UmEQOs8Y
	 TgCPOihlF+E87aBFvgLhLO1Ii5PN67KrA4rea07lFuaZVQHria+bpjq2bPCOkh2cefH8E
	 n0Yw/n/B3qCWn2JfZ9n4M05GkPBHWgLCYrhljIHk9hmmY7yVWFJMZ57XWFCP6hPnFC7P7
	 zb1FOP3hJTeeZZGB+1WfYQWN7SjO7Qnt/3t76I5OMxDo6BWFVEIQzzfz2Df3esEIB8IeW
	 oPgCefzfv0v7CsXwyEwXk80CekOFBrY+r/m8jGUvHFY0wA/VXeLVWtwN21W24eOOnTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVAkSsQi;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934B606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A934B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVAkSsQi
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so38483355e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408823; x=1795013623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4sM8p1tTNaPGayyybeEyqVTJtS8aLvMWjajmNIN9tU=;
        b=RVAkSsQib3j19dbhqVR2sdcks/BUmd2OjcQ78UjH5NxshfY/v59l98QRVHLW7kw9tX
         A7lJJArWoUN75ymWV+xjbTlxY+K2xPUlG+03KtKh0HFIJppCFMBwbjHGNEHAoBR0eYJF
         fwiS+srpoHXoAuB2gWjjskdF30sgLcrfwFLNhNMnZmcj+g1kPXoEDlkw0nGaCqK5auqM
         G3sH8EiUV6wTBfapH8mfnhzB4IJcoME01/hcBXrxAFEX9M+Fp/0ADjaw3X3HUz/utt9a
         +7A9PeAmLAkuUHBHwqKNaGkZIAGqYqPrxsMpx38QdLZTEiXDjJCDsTa29v4vtAKE+FgS
         UdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408823; x=1795013623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4sM8p1tTNaPGayyybeEyqVTJtS8aLvMWjajmNIN9tU=;
        b=tIdbVitU8xAvh1kk0XH/KxgmbwgWQAu/z9uSCMluWXigz1Oy5SS8VXpFk7JZ4zowRc
         D3R+DGvhYIAYKr2SoCTbCO3q3MLu4+qSR1k3wwJlpAuPo/wuoYmnKPTp0+ceCaRGuqvs
         thUAp99AUiHvPtbqSKj8g0Zel/qhBp+RfLNLBZPdoMcLPXGpi4ZDlfgVEN8iK58h2UXG
         riwPZN7L418yedXp8PiFF2gEnvwIvgo4Pjc8rE1WOyywEu4rRmzYBwTTVYhOyVzSjDOb
         B9V0T0LQb7yUQ8RU8IuWuuPtboJDDfqucUkBULc/hYRu++gDWlo8TPLs3ozE9+5bW/b1
         55tg==
X-Forwarded-Encrypted: i=1; AL+hErGylY0hvyyyK+Y3p2ipQt/GQwSrXPzFIGz3It5ohcDKc1gkeIX2lFb4zXjP48fHsfgXWhXO2ts=@vger.kernel.org
X-Gm-Message-State: APuU4Z84MNs0c1XlFes4ih3KAwK/VzqbOmKwLjzCXf3MY3B1SZLh/OCb
	wFRgk3yvBgsD3i1yirBO+cRrjpjGI+s4jklxD0/BfOhQ2jlCiOaUp3e/
X-Gm-Gg: AYBFou2SRQSSjd7U64SCCGiFYUU0xCU2hih8CcPUnUtVReIx7h6uux6uC5dtbrjtI1l
	B7lgKrFKV2YjIwAp+V7furuG2VRIfTU1rFp/n7xKjt8vqY/PpByYcmfqrzbOS1Ua8AqaA+8jH3G
	FWU7IbLt0atCik/xvfi1gmyhnXrf/gsaqXDXARAOOx4FTVeprdraN6bYhZcHj9ADZTvSCkxDoj0
	XcXU2trRP0DzX4cgXBz9gmKRig6w1DgraphE2Zyh91Qdk2c0bMmvto30t090XX6zqhNda4OzDBx
	iGzLDPO74HOjV6XH80wnbHi8HBYD8AeKrLWGKXWQESRHXffqMUtgmRoYA8075wvslixB4+NVfnP
	aMdARZlj+FoiDstYUWrT6ABjxMYou7jzUOL6zm7kGJNM82URKSjpxXQ/hFBb6uyMWTDFKS44v0t
	jJTisWULrpBqHsgXGWA1U8cZmWdwCWipanDw65gth1SJqo4onZLZwiCMP+VOAQ/YJ0ekSkLu1J1
	QNPQvS8nD8RlqzhdEVaYEnxdSnEtU7FxGkodQwUlkaAXSv3GP6vd8ihRwGruyEWiHhWg28Dd/II
	Q3gmZuXd2qYiwufxy+wwsLiEsAQ+zU5YGnAWnIfeDhwwW8H+1jztULecTF2Vp1Ei8FKI
X-Received: by 2002:a05:600c:190a:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4ba0936c8bfmr47936675e9.7.1794408822864;
        Wed, 11 Nov 2026 06:53:42 -0800 (PST)
Received: from [172.31.15.113] (6.red-83-60-147.dynamicip.rima-tde.net. [83.60.147.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddd467sm52895945e9.0.2026.11.11.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:53:42 -0800 (PST)
Message-ID: <a987a2f9-0580-4011-bee3-d706b4f41da9@gmail.com>
Date: Wed, 11 Nov 2026 15:53:40 +0100
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
Subject: Re: [PATCH v2 1/3] mm/hugetlb_vmemmap: fix lost HWPoison state during
 optimization
To: Muchun Song <songmuchun@bytedance.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111093747.50048-1-songmuchun@bytedance.com>
 <20261111093747.50048-2-songmuchun@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261111093747.50048-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:37 AM, Muchun Song wrote:
> HVO copies the vmemmap head page before remapping it to a newly allocated
> backing page. Memory failure can update the old head page after the copy
> but before the remap's TLB invalidation completes:
> 
> CPU 0                            CPU 1
> init_new_hugetlb_folio()
> __hugetlb_vmemmap_optimize_folio()
>    vmemmap_optimize_pte()
>      copy_page(old_head, new_head)
>                                   try_memory_failure_hugetlb()
>                                     get_huge_page_for_hwpoison()
>                                       hugetlb_update_hwpoison(old_head)
>    set_pte_at(..., new_head)
>    flush_tlb_all()
> free_vmemmap_page_list(old_head)
> 
> The raw_hwp_page linked to the old head is then leaked and the folio's
> HWPoison state is lost when the obsolete backing page is freed, allowing
> the poisoned huge page to be allocated later.
> 
> Serialize HVO remapping against HWPoison updates. This ensures that an
> update is either copied to the new vmemmap head page or applied after HVO
> installs the new mapping and completes the TLB flush.
> 
> Fixes: 11aad2631bf7 ("mm/hugetlb_vmemmap: remap head page to newly allocated page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-18e93f17-529b-4d84-ba44-a41829f4be64

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

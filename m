Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408981;
	b=i+ASA4LiONfG9qwVtwUGg4/BEDIDmodF9BxCklNIkqquXmkNMFLYp75SD40/8cAeP1Dj
	 ttlWdRJDowI9P7thei9C+NKfbjPFJ/O29/Xk3+HknqJGVHYxb2z+boz9GMNTEIT0xTZD2
	 6MdyzkntizM/o5ZbjXrYdhCa8oL9Nn3OLl++4uWvvZVJsXA3lsV3kQ/7NnvLWbDPDzwbQ
	 LmUb/pQSEpoUuIXlxfSSC6sb42VLwTapbkkTO4bIm3wiyi/BWi5ZwBkxwcLWVucaCmpGK
	 BAlP9cHBTique5OsB1hQTE7bFzlG1lO8q1oSgJ0GocdiWRNixlhFsDso0rCzJuWY5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MYyJqKHKy98cz/KTExGNTJetx9UGJc+W2b5O0OHZLt4=;
	b=MBM3p56LslGyKCMaAzhTNf+tbwbswnCnpjxMN/YDE+qt3EKEk0LprufcdLddtfUWieTH
	 S0e92rGpY8TQc2MxBt2YJJ3KWD34HlgIJCGdxUsVEqLufv0cLYbva+Tl7qY8z0Hqcgyx1
	 gzmXTfJ0Iyw6DzzpSon85omxRQA+LbuZsk2Yj5xvHJ7jHHTiX4RueziGdTfa40bGEUobj
	 UJJE8FcU67aM70sGw5asQX21soOfnCs+qXTToJK5+LJU1+9oNNGlnLhLioiydqoRmsrQb
	 vGwSFRapFUd4edBDaFEXrWteEavo7bLD5Logp9ZP76F0XmRGfpEU0+dcE3MEh6/CKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGF+OwVA;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCC606A33D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDCC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGF+OwVA
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so22830245e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408979; x=1795013779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYyJqKHKy98cz/KTExGNTJetx9UGJc+W2b5O0OHZLt4=;
        b=DGF+OwVABMpS2xBu0T6d07x5i1sBBDP4m4vqxkjoTgsPNkT6n/XAuf+zDy/mIAUflx
         rAPxgMuj4EnkAwQ8/8tf3gVR1qZbiU++2jcYfsxcdZK01Fh5djQJBAmVN6ZwG4IJGTnr
         Kmuu9zqea6V+UlVcuO6zyTF4ULlXDYPWg3fjcyC1mixriL+3y6i2G+2aRQ362m2FsNi+
         yDMdOY0eixVhT2ZS+PmgQb361VHkqTWTzElyYXLrVNCk0hsSVjli9CWLj+9yn8mV2Bhg
         g9i5EpUBL3zIB0POGK7O76WlZnNQIwdXiRpFUPPjjtKz4dWkH4dkHJMfLAtLLPr8UZ27
         VxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408979; x=1795013779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYyJqKHKy98cz/KTExGNTJetx9UGJc+W2b5O0OHZLt4=;
        b=IeQGXMi82/IiLkFrIIxZEcZg2GR2Fez8XgnE08O81U1weiQBdsqtq5wupMyl2X7pt9
         8Tu/dMzsVAbg8TIJJsSCD4+2eWximA0XjFvsd8S96rk1ZpBv/VeVVsl75GvcCSuRFKra
         Go6FgdhjnYkFQ40JB8CURy5+rZLdFICevlqy3gi7doli3aRJE27uJjr/9aUfhwfKAcGL
         Esvwey11tTiYyF+bQVptFo/HpDyjvdq/hPsnW3K7aqPDISw2+s+mrLX/czS3ovL499KD
         VElUxd4m5IDR763RGrZzufLtNsjANLSsSiGSRh3zbLWIU80wfz3ZgTk01lj4SXO0zKa8
         5SRg==
X-Forwarded-Encrypted: i=1; AL+hErHryDWKXj+6mTJgekpf2M8YslHc7G3cz0HN7e0WTJbQdsFSdKPuq9HDq/jxdGl24Nb4EfI2mL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kvfetObnVPP6bo7XitBDslWnVIHhdc3SJh//f5tk+QQYp5nmZ
	Ms9IPLhAdhpOLoPiWhOlTbu/JCQay3PfsCX7MLIF4AmiCs97dAA4eKQk
X-Gm-Gg: AYBFou3FcOyoRmijbR6enwNReYeonN+mN9g3QS5HufoDt56w0X0HPaXp2RWvutAhSGN
	RjaRERFMBo97t5gD4b1iopNAGKhkQRjmLM0EGuiM8ZioOc91OjIXoNffA4O67sFVlFiQS1nJ3fN
	lQNGlMQo2RBT5lWFNpFXanGmuVJnWZ0CUTtNLXwmGxlQkFjzvYEmEBSIEa4yy+up0jDIrOlbqNg
	ffVj12gWTl2mJ7KfkOix6fsJcta5Q4YKES9BxaokUTVj/WrKNei1nahvTqxjpOqOsYqyJNm34Pn
	uiOWkQ+Zf0CCiFj9s0mBt38t2OxZ7NbPtOeO6iS2FbIeaj3NkroO/u4xTeM3Fr82f9DfFKgsSOk
	eo1AQjKu+OjDwoBnPCM9BkJSwc0Zw8oYrMDiKIiHCUYo/LPy6OjrNOYASLZ7gUojWbvwPyr2Vbo
	dM78tfVVx3N5LV83cw9KsHzihd6a9WYa4FEDcyMqTOVDUjmB0wYqRnID/jAUsbPHZ1Fq0bHXqLB
	5ugsPCw8Ql2o/PJLu7xpW1w1l2UvCQRMA5rDsP8Ce9YJIyBWKaxq2r5XN1qXG+2nt6NkQp0Jvif
	Xzyu09omB9xcy4y/n+sVM14DB2zEnsPEGdjbYElKoX0IB60PKeNtcKprWZ6AbMccOGZMOg==
X-Received: by 2002:a05:600c:e558:10b0:4a3:18ca:806 with SMTP id 5b1f17b1804b1-4ba0938e116mr29687345e9.20.1794408978700;
        Wed, 11 Nov 2026 06:56:18 -0800 (PST)
Received: from [172.31.15.113] (6.red-83-60-147.dynamicip.rima-tde.net. [83.60.147.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c554832sm1533175e9.12.2026.11.11.06.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:56:18 -0800 (PST)
Message-ID: <998f89d2-774f-47d3-b6cd-df7bbfbf2b3b@gmail.com>
Date: Wed, 11 Nov 2026 15:56:17 +0100
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
Subject: Re: [PATCH v2 3/3] mm/hugetlb_vmemmap: fix deadlock during PMD split
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
 <20261111093747.50048-4-songmuchun@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261111093747.50048-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:37 AM, Muchun Song wrote:
> vmemmap_remap_range() currently walks vmemmap page tables under
> init_mm.mmap_lock. If the walk reaches a leaf PMD, vmemmap_split_pmd()
> allocates a PTE table with GFP_KERNEL and can enter direct reclaim:
> 
> hugetlb_vmemmap_optimize_folio()
>    vmemmap_remap_range()
>      mmap_read_lock(&init_mm)  <-- outer read lock
>      ...
>        vmemmap_split_pmd()
>          pte_alloc_one_kernel(&init_mm)  /* GFP_KERNEL */
>            <direct reclaim>
>              ttm_pool_shrinker_scan()
>                ...
>                  change_page_attr_set_clr()
>                    mmap_read_lock(&init_mm)  <-- self-deadlock
> 
> Since commit d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on
> attribute changes to avoid UAF"), reclaim through TTM can enter CPA,
> which also takes init_mm.mmap_lock. If a writer is pending, the nested
> read blocks behind it while the outer read cannot be released, causing a
> self-deadlock.
> 
> HVO walks vmemmap ranges whose intermediate page tables remain present.
> vmemmap_split_pmd() revalidates the PMD under init_mm.page_table_lock
> before installing the PTE table. Use the lockless page-table walker so the
> allocation no longer runs under init_mm.mmap_lock.
> 
> Fixes: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-206969@kernel.org/


LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

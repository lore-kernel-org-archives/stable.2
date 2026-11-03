Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706024;
	b=jYvrD/a2Qii+Oh8NbUa3jiavajfPMHwXiQqc8C3aYJyQdodPYBTV/5taxxrGbL5N6AC0
	 oxFvl2xhKIL+xiCQqjQ3PVL1iRSxr00X4LxrTa3p2Y1f9haPNe6qRm4/CkKAe6MM17lHr
	 YHJmPaYvjrHWPTeHZfvo38hE/6HUXsIgZWo7dLEHp3NnO/Fcy2PpvX4vkQcI6zheMXFNi
	 rxTWfCpdNmfh3smgWb3GLXXnjFPyf9wuu+jfbUmR6XA4AJuw90lG4N2SZXusLDxsIGm4X
	 2yYUecH8k3fCs5Q+MRtw5moiTYDnvcMFVXLkY6D8m0+szlrxLdBDOkttG0rN/B9VpgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=utxuIcSFdiIIVfsjndjc/ld0Uu9VZGyZLJcerN1xmmI=;
	b=cPcEf5PM2lL6viLv0UHkvv5C+JImjQGPgeMxUvl9/Lz7FZhczKgul7vdHSSOkhJEaWs8
	 2ETrZlm3Sy62eiUwCZ9SDWG5cD4id6ucrU94669Ca44uDNGQvmgp2VcyGeL3ZWXi+cd2o
	 vQnltGddTfUzZpbDlE2g5n0Bi4MPykDMuuHBl15KRYs4CkyvSxlBF2ZAr5LgahJSwiXLy
	 uAZheP+wCyD4+K2YPmhObqQw89gEK2UmKpOaa/uVv85acOQ894QJPK+nLUsIZhdSgpDk2
	 AH7T/hCKNdrkn9eFMa/Y2qTepDffkIk+HwuFipRezrKl53eGOVghlW/d4fXp8mvwdSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slToOVfu;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45346082BDA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E45346082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slToOVfu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d885929so3258513f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706022; x=1794310822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utxuIcSFdiIIVfsjndjc/ld0Uu9VZGyZLJcerN1xmmI=;
        b=slToOVfu9AxLwUIK47MdPwcsIF6ozJhIssMgKxOBM1lyCOrnJILGKc9mrrxBS1FSRW
         T18gn6F0KKrnPfV7klfJjz8EN8hK1pujWhYYrA8HWkXSjFRVK6EHn6mAlaHD3+v2joe2
         nDric/+6hPAQI0A0cc/3eukWVo9OYRKPd3T8X4mtIXRKfVsz8kUe9yaC88HJO/0VcldE
         jBFqMGEgknAen3Q+juUST5eC/meWkYfh0x/cgc3W3N5aTYQ9GL9Pu+HR8PY5Ba52yfYL
         /iAbxfPegp6ijg1tZjJSN19bmCk/4B+1BIEjJIfr/XUOWuW8cQl2RcOS0KKqpl7/mOKW
         T1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706022; x=1794310822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utxuIcSFdiIIVfsjndjc/ld0Uu9VZGyZLJcerN1xmmI=;
        b=1LlNSq0xckgD2+9B+He8jnxKbF1fGKlnPAwTo/5C6xovZf8O78ph/rZMVoKzefSFEP
         4zvYOcezmimk0Z7jSZQgDmUpqV72rGxIkm2h+Uh7k6RoeYerLiPUDGy4vnBRWGcfnTRE
         uKZ2iC1vurtKpDyIKhlU9OesdC6FyAqWP2q3Bfw9s1Jswa5l44j1/rEgySvSMe9P9FdT
         KMTfS8CRkTFXIvMOByz8M88OBAZMbjXUgydEOMbZS3c0wKXhvD6c4Mo+mSMEMJg66Txe
         e7UIL0YAW4zjkYUewp1cJmLccCujXCEOxf3VmNiicBqGmHwV5d8QsheOo4MO3L/b3SUr
         Px/g==
X-Forwarded-Encrypted: i=1; AKwUvBxPfw41uWb74TXwsuRHB5Xut3LF2Xfw+vPdvHopxbH1ZfAODLT8WMFjAQ9fhtjPrpbqnjKwYsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LilxQ4TrgWVJhheRR/aNtWDKFgp8TkUCXAi1K5vm7LTN6z6Bv
	QDwt9kwysCvTk48Uz5S3jD4axUQ0zgs7rLVglj1e4uBTY2LWP9GVlOQi
X-Gm-Gg: AYBFou3Qdv8JvpAaA3aZbN4KWK/wydsD0R3ENWTJ+Nj9VMpP5/oiSGeEIxwA4IK+y5E
	jsQ1S4RqS2trBlk5b/zJ0e56L9v21i2wtHs4i5oKTGW+oFqxKPTkFEpu3U4mnIVkCM0tzfwQCR7
	sLGRP4h8xONc1qTvhuGg0LbgNnVV9L+9ilV71cAbm0AXL0PQDZftzLhrktzy8gZt93Cqkl5ceBx
	npNUNl8XnG6quJBhBgzD2XBmvbINo7lAYKAwnpnKB1aIPqdIGtZkigHtb5olSR+N5AydGRMmPxl
	YJ85jhA5itFiC8kwuxK84RV3hPOeB7Enzq5juEunnueF+tzRDY9V0cISzFque8eDJ3cWtVdhVtX
	UbVgdfVzYiyiX2fURPzXfsSxj5KWP2nkf5mw6TwCGoiWxrZ2nCDI9hmeE/wYsT80e8ieYXVNtdp
	ofFqlGJ/RK+e0Tz/O7OsjQOXWjeSjoHxsjs05v046ckUOf9sxPEsxqM79k7aW/s897twUWTDJFo
	opbny7/aWWlqrTPojXGjgoENf4sZv4vBhnc+p9qczezXbKaXRPgUPG15bVlDPp9ro4ki5mawWM+
	Q8xRXOd3Vee4i+h+LkRMn4Y=
X-Received: by 2002:a5d:5c84:0:b0:48f:bcbf:26f2 with SMTP id ffacd0b85a97d-48fbcbf2becmr528573f8f.55.1793706022163;
        Tue, 03 Nov 2026 03:40:22 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bab1a8sm24248670f8f.57.2026.11.03.03.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:40:21 -0800 (PST)
Message-ID: <897b0ea8-d2f4-42e9-ad22-e331c5b085c7@gmail.com>
Date: Tue, 3 Nov 2026 12:40:20 +0100
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
Subject: Re: [PATCH 1/4] x86: hugetlb: disable default CMA reservations on
 32-bit kernel
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org, x86@kernel.org
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <61eee83da19a87337e68a7747fc0b89ee5d0393b.1793692578.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <61eee83da19a87337e68a7747fc0b89ee5d0393b.1793692578.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 9:01 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> A 32-bit x86 kernel can run on a 64-bit-capable CPU advertising GBPAGES.

weird. anyway, LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

> arch_hugetlb_cma_order() checks only this feature and returns a nonzero
> order, although gigantic HugeTLB support on x86 requires CONFIG_X86_64.
> Specifying hugetlb_cma= can therefore reserve a CMA area that cannot
> serve the intended gigantic HugeTLB allocations.
> 
> On non-PAE kernels, the folded PUD_SHIFT yields a 4 MiB order, which is
> equal to MAX_PAGE_ORDER. With CONFIG_DEBUG_VM enabled, this triggers the
> VM_WARN_ON(order <= MAX_PAGE_ORDER) check in hugetlb_cma_reserve(),
> warning that hugetlb_cma is attempting to reserve a non-gigantic order.
> 
> Require CONFIG_X86_64 as well as GBPAGES when selecting the default CMA
> order to avoid these ineffective reservations.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: stable@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/x86/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 3b26621c91286..70726a99ede7b 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -45,7 +45,7 @@ arch_initcall(gigantic_pages_init);
>  
>  unsigned int __init arch_hugetlb_cma_order(void)
>  {
> -	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> +	if (IS_ENABLED(CONFIG_X86_64) && boot_cpu_has(X86_FEATURE_GBPAGES))
>  		return PUD_SHIFT - PAGE_SHIFT;
>  
>  	return 0;


-- 
cheers,
jose a. p-a

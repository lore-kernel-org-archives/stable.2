Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA6361973
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182347; cv=none; b=MQ2kRpRxU3WPpL3smYQk4FHB0LMv5406WKSRqB/YY4i2WQazq7+P6gNxJ9enikvxhN3wEbq31ZSjhXCnh8er+gYbGmLj0jHaicA4PHzbG2oGbjTmYKyCiyhogXoUeSJMo1gV9TSwUvppX0uR7IWDhbtSSpiOzg32vop5qIsrLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182347; c=relaxed/simple;
	bh=0k1Zz1txYZH1PwdNSJa0KLKBMvPX3hwqFYmvK9C9q94=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eMwtnHc2RGpLJHvXSZZI0YdrMoQDPYh+jKQXx95/Gg6J6jPTOT6ys812xOaGS4t5w0dVMDVRHuRnKMP4lYOByAKMzQjZrBcBARyDsiRxay1lLx9OsH+X2i3V5vPOpuUIfdSgasoj4ig9RWBhPhiY2yvCGdypamEppocxdwGHt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op4xTJIz; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op4xTJIz"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so583856f8f.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791182344; x=1791787144; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jUXKHUsl8I+TxZpA4AmD7FcPh3xLEY1fLS46VnzRfSU=;
        b=Op4xTJIzjxglNcWyIfBLTQUXCfGy8FAOMPmlqZFCVDYg3iZmxYh+xSx/+LtpHDmN81
         T5VHgxKyncRIp+5QIuBvUwywb9xQYm/oShWWxU6t9wQGfbmZi85/ev0WiWjl8rTaV9gx
         PdA842VwTW4VNiX4gu0IR/SEmos+fLwl3Uelc85MGOO+hCoFX+FhgouFv0kVb20m/T6N
         veXtmaCk46oH3asOf3zW+AxDoBWI8aQktycu9BMywSscs7ijdnMZK9iVGGFPUKZN+iCS
         T3in5eXSObo/R2SZaCBWWxjnJ+0DznKfP4jkiephwUpmt19jTDQqH+x/hBuTWTLjHUDd
         +njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791182344; x=1791787144;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUXKHUsl8I+TxZpA4AmD7FcPh3xLEY1fLS46VnzRfSU=;
        b=SujCXSUc4uigDJTKrWukVND1ZzjS0Cm9VM8/+Z7x2Fcpj7PO9UCTCEIMuLljYtXVz+
         8SCW3/oEJPWKODaSeGcuxWebI3Q7+DLmF1sGyFxMs7wxXkM5/yl9D0TwvkgEAw/e+1LQ
         nYQIQeN765HcBm2+rlBeBkW6CHsYe2zTb3FszySdiETORMygFMkH2xBGOhWkOiSwTrWc
         9vwxNf2mT2/pfjjPG5zZstYZkjYMJ4PjGQs/KESbBxXLocVo2kZeIt5mfIjtRxvXLJTT
         y/xSUkSHZljTg/1GsEuRZ+rNgcNHs9eNcrj2x1kYAuvdQ/XkAiDah/fgQRT58wetlH4w
         xaMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnfOiIbXbRArmLoCgrE5lK9yo3vSL8iLVohRne9ISJ+KwBnoKLZkhfmBZfzGyQ5hmCLmjfG4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsLZ207zXT82i/gy5WZNYOdrCs+GoBrO6jrciznVnAcFjmLFz5
	TwY4svrJjhffMe89awLlCuEHN1v5zEQguIPOCLMj2y2f2nQhZ+LKw+eL
X-Gm-Gg: AYBFou3FRb+N4BJwI5rzXr6ItO7WIfHc2R7lwA4zcwv5QcRAZNDxlwSty6AjTVhIpAo
	gNMFfIrlB9C+uJ/T1jXHbGHxdbaVu9EXu5KgTZS2abFsyS/6oTJp5vr+/8cfgZsx+h4iv7sgskk
	aJ5hAFKVrC4gCzIgvBl6Uh8h6npdr8oa361EzjSg0Uq5ZEfNnn1mmBXhN/9eUMjgLsrWbcsLao0
	2BzoEXEz7pfuVbTN7x5nvwOqlzmapbL4HaodGJ6k1cGvnbfdN2mzJbOAIDX29Gd+FA89l34A6HH
	wwq2zR8biU4ZmGexlQKBdjepjPzMOV+AN/Z3r3veeU+eu7oalaWPXjNeJbd7I/NKRJRUhyYROhc
	+PPPaTR3qEGSFPakjEzi7QAdiwk+Il6hb9dmL8IzFRjB+nBIAOznC+eOQVd7WOBxka/C5sQ0KdV
	X9WNA+HeN2f1frJgh3kDuaFnXl50VX4lu6lBZ8amdff9UfonLtWXiSzeaqrfJAOfoazEYMv3LQB
	TtGHPeuXr6WssjcUs8GV6u+zx8ccPLhoCL9kDel8zotf0Dy/na6aA==
X-Received: by 2002:a5d:6b84:0:b0:488:89ed:4430 with SMTP id ffacd0b85a97d-48b1273e475mr13370049f8f.33.1791182343892;
        Sun, 04 Oct 2026 23:39:03 -0700 (PDT)
Received: from smtpclient.apple ([141.226.89.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c63904832sm967264f8f.14.2026.10.04.23.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 23:39:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20261005052302.43042-1-lance.yang@linux.dev>
Date: Mon, 5 Oct 2026 09:38:47 +0300
Cc: dave.hansen@linux.intel.com,
 luto@kernel.org,
 peterz@infradead.org,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 x86@kernel.org,
 hpa@zytor.com,
 riel@surriel.com,
 linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev,
 thomas.lendacky@amd.com,
 kernel-team@meta.com,
 linux-mm@kvack.org,
 akpm@linux-foundation.org,
 brendan.jackman@linux.dev,
 jannh@google.com,
 mhklinux@outlook.com,
 andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com,
 mingo@kernel.org,
 stable@vger.kernel.org,
 toshi.kani@hpe.com,
 david@kernel.org,
 mikhail.v.gavrilov@gmail.com,
 pfalcato@suse.de
Content-Transfer-Encoding: 7bit
Message-Id: <D8AEF6EF-D92A-4838-95A7-EB93BE319BE1@gmail.com>
References: <20261005052302.43042-1-lance.yang@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> 
> 
> On 5 Oct 2026, at 8:23, Lance Yang <lance.yang@linux.dev> wrote:
> 
> pud_free_pmd_page() uses a single-address invalidation to flush the
> paging-structure caches before freeing the page tables. With AMD TCE
> enabled, this only invalidates upper-level entries associated with the
> target address. Cached PMD entries for other addresses in the PUD range can
> still reference the PTE pages being freed.
> 
> The AMD manual quoted in the commit enabling TCE says these instructions
> remove
> 
>  "only those upper-level entries that lead to the target PTE in the page
>  table hierarchy, leaving unrelated upper-level entries intact."
> 
> Even with all PTEs cleared, speculative page walks can cache present PMD
> entries after the earlier TLB purge.
> 
> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
> the single-address invalidation otherwise.
> 
> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> arch/x86/mm/pgtable.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 4a105f283cfb..6b7fa44f1bf6 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -727,7 +727,16 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> 	 * via normal page walks. Make them unreachable
> 	 * in cached mid-level walks too:
> 	 */
> -	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
> +	if (boot_cpu_has(X86_FEATURE_TCE)) {
> +		/*
> +		 * With TCE enabled, a single-address flush does not invalidate
> +		 * cached PMD entries for the rest of the PUD range.
> +		 */
> +		flush_tlb_all();
> +	} else {
> +		/* INVLPG to clear all paging-structure caches */
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
> +	}
> 


It might be cleaner to replace flush_tlb_all() with:

	flush_tlb_kernel_range(addr, addr + PUD_SIZE - 1);

While the flush-ceiling would usually end up doing a full flush, the
code would be easier to follow (the very least). Maybe adding stride
to kernel TLB range flushing would make sense in the future.






Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663025;
	b=DGlSlkyD7ub4ICqtxc/L9Kj0tGbbNQ8Lqp1/xTGa97K/+XdbEkhNVUyDSQLeI8+5Gdys
	 Gk52nmGCoeVazCKu299uA76TiHgZax5Fgl5RY6AvHiVoIr7E0xTJdejvWPGFdSi+3PSSZ
	 jduuMyq6ffhG9CNzdkxwx5mn+i+ksiuzfbo3x8VGc0IhiFpPIi3iHLMQnfcJoKhewjN4+
	 y90gvzlLFBU8v2PFIRPdHNFenYTh74g3sZsKNaEK85rBJVbq7FNO9aQJDSkR1ySLW5lQ9
	 MNbo1GPlhvToXZJp8PaOKF0mJaIcuK/RCNgzKbsYNpAh74el5/OuYFt1OBRJAWg1ZGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=BNDduFV50mDAnusTfhsrm1AfLUFfYS9m3CckSvA24Lw=;
	b=CzLIqbFZp5K2BT376K09QES57EzPvm+Zo9pAZgCRCW8tCQMO3oO6x4zCJCVM9NYQ0q0U
	 7x9F/Atx6jIRtnGORAVXjw3LNfOJ2OUkj0zibimwYrPEFjuGzReNAiiWMbUoqG7AZSS6p
	 jk+nRi3tR6o5/ybtJOppZyjGm1+PMQ6MjiHp2/pOhRwRum+EvsVYvRGuoUKmbl384Dnk+
	 lYqHuirMnT8r9sYoq1ebt1L4k8mr+CTSKEwirklKgOIZMNBYSzCR/vmZX5F33nMh27nMF
	 ADsl2zHlQpfXZGVGi4wlao0m5GTHf90nzoAwwfuREz4XyWEQ0oEWgoUuvYhjCQtBClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Vxzk/kGH";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08221606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08221606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vxzk/kGH
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac6971aaebso210750a91.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663024; x=1793267824; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNDduFV50mDAnusTfhsrm1AfLUFfYS9m3CckSvA24Lw=;
        b=Vxzk/kGH52HwnpHRiwcX/wEORYwdtj4ZIjQ+osmfoJv4RciHkMQPxrdWu/MzVQquJ4
         OHx62qv8ytZnk3A65uq6tY7sHONyKdsxyuyHmVC6zPop0A4TyKOxFppyyGwYss+MxlID
         y5oavjodc3XmzuufLEDQIZgPuqAvabno1vbPPxV9XYTYaarrlXoiSgw8c8Reo8zF63U+
         VEd/UXTQvqN65K/PlNiRva873sxQtjyfnkufXSinRQkrsTBOuMvvVxtuU+uo9Wfxx8PA
         HB8CnZAkwfBwEE9rf81wqvgVJlDIYJkDbUoUiy+vkeFwKByUk/rC/hWNgIUrJ97YocRF
         9Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663024; x=1793267824;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNDduFV50mDAnusTfhsrm1AfLUFfYS9m3CckSvA24Lw=;
        b=kkspR4A4f1KPFAHZ9aSL2tTTQZlGCxqBvIfGhUDe4s1CX9ZjO/SUOeSYCegmNTt0d3
         6tF+ZYWZvCfq2F6ul5wnWHndkM3z25wwTJhlY6/RWfcDvDTEvk82rpYgppjP6ekOJS3s
         MXz3a67F3sUWG7qnMqQBgykwqrYYFBeiT5HdjEns8UJqzES6iakKoAHaMw1ZcrFlLvRj
         2wWpTHGZh6XULTULnHMjhw8MTKRVdY4b/FCi8C9a0qXm4lHbizZXcHxANFK4HVM8NfxL
         QYhutKveOr1Z4IB1ykYje6mmLj/cwUrXqa5+U+kkWPrzeSAYRInKKbcID3ttg7iUhvGw
         hCDA==
X-Forwarded-Encrypted: i=1; AKwUvBy3AXPRFj5aN/QyyxCtFI5V9Sx1dr0ducIfAWssDxQSREalMp/0CCnxYEWmcAXd+e4d2cpIjog=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqtFjfOfW8Ik7UVky7wyUhX9txNdWlIQ8JnfwuWo0t2jjqRMvN
	PXr/KXz1C70nfAmFbwG6SdiLAnyKoERIsBl97Di2k0CoYTsRvaUb4urP
X-Gm-Gg: AYBFou3PquC3TN0d9Jc7qtwo+J/oGTHs9wWMEuvgp/iA1xEEd6RVVpPMMqKPjCSkBpG
	c77ILakBhBqoWfF4W0VpGtRu1ZY5ug1CjwjEKc1BA9IdY0JrlUuKfZwzM4bKO/NyG/dMZNm3IES
	uMFCFSZJIN/ENFgd9C5f9BS40TiupNrP/EyoAy594hTD+6thXXlfMW4UnRmEL4w45KH1sNJVH/G
	WJECHaFz7SCGrZNdrd3hfFAcxIJrTM+iYr5F8p4RulXvl8dsatBuixcVBZJJA16fVw3YqQDzY9o
	ZWH8UKFFUMnvJWeFArr0A35cV9T1BrXy97n/7RNP2vSqQc1XOFWnoOuoDejo6mdvm48fYpd7zkz
	sYSI6uuzejdUEZflURyx/ewQZryIv/XlV/NvxNc+XMm7LnJ90hQlsuW0DrfuTU15Thil4JWvmmq
	+mKY1dzA1gDIAZ9cW/HOTONvHanRp4llL8+7/9N4r7FE9seYsqf6jzA2QPIZJ45rmpDTF/DjBOv
	0ag0RyhRZKB2thqt50p9LLtkMm9GyD0lFxD10g7exD4Rks6gHXpdXhAQzOsVbSQcDmZMp8A9iOJ
	xRstl0bALt0l2hQxEQ==
X-Received: by 2002:a17:90b:4c52:b0:3a4:c895:570 with SMTP id 98e67ed59e1d1-3ad86eec0acmr6462563a91.4.1792663024062;
        Thu, 22 Oct 2026 02:57:04 -0700 (PDT)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c71sm3742644a91.6.2026.10.22.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:57:03 -0700 (PDT)
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
Subject: Re: [PATCH] mm/vma: avoid broken uffd merge on mremap
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
References: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
Date: Thu, 22 Oct 2026 17:56:51 +0800
Message-Id: <179266301162.763593.1501773594946042790.b4-review@b4>
X-Mailer: b4 0.17-dev

> Userfaultfd often causes unexpected interactions within mm, and does so at
> the intersection of uffd, mremap() and VMA merging.
> 
> When an mremap of a VMA occurs, copy_vma_and_data() calls
> mremap_userfaultfd_prep() to notify uffd of this.
> 
> However, mremap_userfaultfd_prep() simply drops the UFFD context for the
> VMA if the user did not register it for remap, i.e. didn't specify the
> UFFD_FEATURE_EVENT_REMAP flag.
> 
> This is OK for the VMA itself, as upon page table move, move_ptes() clears
> UFFD page table flags, using vma_has_uffd_without_event_remap() to
> determine whether to do so.
> 
> However, this doesn't account for merging with adjacent VMAs, whose page
> tables won't have received this treatment, and thus latent UFFD markers
> will be left around.
> 
> Worse, it'll break UFFD for any VMAs it is merged with. This is very
> surprising behaviour for a user, who will then simply not receive UFFD
> events for VMAs they ought to.
> 
> Resolve the issue by explicitly checking for this case via
> vma_has_uffd_without_event_remap() in vma_merge_copied_range(), the merge
> function explicitly designated for mremap() operations.
> 
> Also update the userland VMA tests accordingly.
> 
> Reported-by: shaos <shawnq1@163.com>
> Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
> Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c                          | 5 +++++
>  tools/testing/vma/include/stubs.h | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index b7dec22d0928..4d605c0967d6 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1211,6 +1211,11 @@ static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vm
>  
>  	vmg->copied_from = vmg->middle;
>  	vmg->middle = NULL;
> +
> +	/* If not registered for remap, uffd context will be cleared. */
> +	if (vma_has_uffd_without_event_remap(vmg->copied_from))
> +		return NULL;
> +

Hi Lorenzo,

Preventing the merge here keeps the later UFFD context reset confined
to the moved range, preserving the unmoved neighbor's UFFD registration.

>  	return vma_merge_new_range(vmg);
>  }
>  
> diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
> index be8f5161f92a..f786a585caf0 100644
> --- a/tools/testing/vma/include/stubs.h
> +++ b/tools/testing/vma/include/stubs.h
> @@ -386,6 +386,11 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  	return true;
>  }
>  
> +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +

Would it make sense to have the stub in tools/testing/vma/include/stubs.h
return a configurable bool, e.g. uffd_without_event_remap, and add a test
for the true case? The existing tests would continue to cover the false case.

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Thanks,
Xueyuan

-- 
Xueyuan Chen <xueyuan.chen21@gmail.com>

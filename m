Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726247;
	b=Q2YNVgEtg2dlIg/cjkhdGpqf6M2iZq60s+hQljfBoYItnHjyO+Ato1ulVKiW6xrZ+Nqk
	 GYabuJAhWhN9L5q2OVtc9kzBNqNa5g6dKB7rDrC2rKFBFjtAIzVopGKUgDfmlI+fbHPx+
	 bMWjmpxPAkE7czxCGh8zOIRmXqHYjEoQojEVpOq4Sx9ZY5MQYGa3jCMQG0Ydwf0Scgopx
	 pkM/sJgGea0aXm3SzP4VdXdulAWORjNkbciO5eliW03DASlDLMIxETkkQpu/rXooUVpkR
	 5Ep7gfkmVxLB4uT8xSGNwZ4J0S1LCUEspSB3BLyCHVWAn111odiQwWBD/v4ZehXn4/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=zIGi8MMXWRGMe2b3LNjOQAhNFelVBzD0TDA4w15AaDU=;
	b=YOY/T103N+/Xb7Q+xXpVc6mCnrpn/DfeC6sKGGNmbh7V1giqqiye8MhC3QrOKnGANcvb
	 PB9X++jVoYa9E70nxml9/ti0oPUq4ztbXW24fly8g3CWK8Z1DMHL+dtGHDKQFDz2egYRb
	 hxh8v+HzkHLaoj7pbMIUeA5/jiutJR3emRBLGOnRVhTC3jDFetNZdOIYVDeueLyqkX0ek
	 XhokjRmbwMfYOIO6r1RlJfhRbZNvVl8Qo487cFPc564FujWFj1cBOdyAVyhFH9DUtEzVs
	 Handfd3J7cagGfRXe53r0c2ogAO/td1dq7hUw5BK8FrL9lQId9xhkbZjggkWco8OiSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zd7fBeeb;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E0606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zd7fBeeb
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8212fce7258so58068a34.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792726246; x=1793331046; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zIGi8MMXWRGMe2b3LNjOQAhNFelVBzD0TDA4w15AaDU=;
        b=Zd7fBeebd1lfpAdRXJ6+JaaGysO3Yu/EcHrtxnqCSaM0p6TEFW0QDtBZt1yJXl+db0
         7+Www+4fxL7At+3HbiTjO7mx5kBphe46M/2RuOyP0+fHckPTfuyOlLoVphddtXSzq+eH
         JXsJ1BvaxshV0aJQc0Dbt7ZkEG26eWuK7Dl58UATjC7SPnuS3k2qKdRIvwgNdzgBG6dH
         X8IugpCPbz4LP1A7MwqxHjzQNCoXhFSsDqteamcaJHVB/Id/w29pudgazxkbzs4rY9Wl
         7LnzIyuBUowkkY2ZssaDe3mHQMVN4MdV89vheVbDUfeMX7ekF+QlqmInsdZ1rcVFaCCX
         6ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792726246; x=1793331046;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zIGi8MMXWRGMe2b3LNjOQAhNFelVBzD0TDA4w15AaDU=;
        b=idgnZ3Xv1Fwj66TWlfAdEc5ZZo3GFAoi3uqzrmaZ7AZ+PABx2pwTkVuM5BG9T5Op6z
         4FvvxvWzIIs6LZr8QsT42NSEV6pHY1TOc4P6qlOcnXTLRo+tiJfDgBpTyFuWnkWF1bVN
         rFFRbUVtzg5J/vMLhvxiwylRRD+d75s3k/wDBhND07uzAS90TdopJhMYS8AemWSoLjbH
         s6k4WCiq742sRmS7xEXAZSP/crCTOIPNB8pGCRLyHBayaZrSyMpfTan78ONQhoCDlZH2
         xj7MIQavA4EDuOzCotzksoSVJ+GJ0FTWjgLw+73cFNRMwVeGkDtXplqqSdGe1BdLIBO6
         PzcQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2kwS6aduqucCwddQzyVBPtaGvnXX1GUWYSK6LRLjITtMI19eEjl9oHH0X+961TXgfOm8WZn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJqmuSFx3ndbMy35kqS138ih0v8bpy6jMc4tqqFYzRo1gYohAd
	lwd5nCy3AjUtMCxYeAWym4A0wmDungLJg6v62b9RXmmGD4LEA7XQT31t
X-Gm-Gg: AYBFou3RGZHL9Y1+lGRr51U9Y3UkJYNvgu1RA6XJKDH9x5Uw+uab7iqWce9aQuCdT6e
	FvxQe8ig91Te9AnMfC4iseWdXFdhpMLcyZ9ONfxEEH5dnoaWD/YopZi11mY65663FGOpqasC2wI
	k7jj9RmRea9BZTmSf53QBcmhHW7LZAXpnKDVeIYYCBpWiNw/Az6OVvKTseeVjZjgBaIpfghjsr5
	E8fMhEuJbcmIRkS04nO14AfrwGwm+YepAJo8SYdIKVyGIaDJPb48kXfyDuCAvNmwHXBQfYyiBzk
	d+Us1BxS9V8hxCtFfxxFKFD4w0Yxh4W73sGporWBL+mqGA0epI7iavHZY7LetWzUwIhSFK2+zNH
	8ObHCHFflMKNI6zF3Tal0y7yIJvnfx7ou4vSphhUcVaCZwDCKnUk87B6KVxr+8bLGTFRaCXrtip
	ywWvWYRt2N03Be8n+ncEsDFeQqvdCazzkCYfl39NVGwaDD965FcbbtyuR7btNi8aeJbQaDHIMiZ
	yQmvjVs+K98vGZtrXWHwMOMxf4XPypJguIVqkana4qnREIgKDyP2/LXyzbuxqDlYWLPcex7GLYL
	Ed8MbSUMmrGAky10TA==
X-Received: by 2002:a05:6870:e196:b0:4a7:235d:b346 with SMTP id 586e51a60fabf-4a821ef833amr776609fac.1.1792726246059;
        Thu, 22 Oct 2026 20:30:46 -0700 (PDT)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a820ab47f9sm697893fac.13.2026.10.22.20.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:30:45 -0700 (PDT)
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
Subject: Re: [PATCH] mm/mremap: populate calculated fields in vrm state
 correctly
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
In-Reply-To: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
References: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
Date: Fri, 23 Oct 2026 11:30:35 +0800
Message-Id: <179272623522.1002865.18403086831547127814.b4-review@b4>
X-Mailer: b4 0.17-dev

> Commit d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
> introduced the vma_remap_struct helper to pass state sanely through
> mremap() logic.
> 
> Part of this state is vrm->delta - equal to the absolute difference between
> vrm->old_len and vrm->new_len (the old and new lengths of the VMA,
> respectively).
> 
> This value is used to correctly charge accounted VMAs.
> 
> When shrinking a VMA, mremap_to() sets vrm->old_len equal to vrm->new_len
> having performed the shrink of the VMA first, prior to any potential
> move (e.g. MREMAP_FIXED | MREMAP_MAYMOVE specified).
> 
> However it does not recalculate vrm->delta, which results in incorrectly
> overcharging the VMA.
> 
> The charge leaks to Committed_AS globally, meaning a mischievous user can
> cause allocations to fail across the system in strict overcommit mode.
> 
> Resolve the issue by abstracting the update of vrm->delta to
> vrm_populate_calculated() and invoking this from mremap_to() when
> vrm->old_len is changed.
> 
> Additionally, update vrm->remap_type whose value depends on
> vrm->delta. The field is not read again after the shrink, but it is the
> logically correct thing to do and protects against future changes which
> break this.
> 
> Fixes: d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
> Cc: stable@vger.kernel.org
> Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Closes: https://lore.kernel.org/all/20261017233527.797191-1-nickolai@csail.mit.edu/
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/mremap.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 2e1ee879f70f..3f645cdc8060 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -887,12 +887,6 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
>  	return pmc_progress(pmc);
>  }
>  
> -/* Set vrm->delta to the difference in VMA size specified by user. */
> -static void vrm_set_delta(struct vma_remap_struct *vrm)
> -{
> -	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
> -}
> -
>  /* Determine what kind of remap this is - shrink, expand or no resize at all. */
>  static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
>  {
> @@ -905,6 +899,13 @@ static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
>  	return MREMAP_EXPAND;
>  }
>  
> +/* Populate calculated fields. */
> +static void vrm_populate_calculated(struct vma_remap_struct *vrm)
> +{
> +	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
> +	vrm->remap_type = vrm_remap_type(vrm);
> +}

Hi Lorenzo,

Good idea to update remap_type for here too.

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

-- 
Thanks,
Xueyuan


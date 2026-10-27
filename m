Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793118154;
	b=oGCpmfjMIS0s6fWQFQU/rsFk22e0vpf1z/LmRMbTOJwzEKDcXFBrmRmS7P86vHMFSKrm
	 DeH79kfJlSXbamSKvJF3fppZw84N6zSGUcjxIS6yaA32CcfkvKYLD8SOCfCxH0oobpQfw
	 uSbvxh/fCc0PzQWoXPHVgOyoLaTxYKIORJw9dvJJkjydb+RsB9kAQc/LCWNCS4MpA+iBF
	 dyaUPRvdBNwqyl1okaoEpreIKf/I6J1ON/Y6BZEMBjDMqOZfXf3tlAXVlEsD4DEh4whIW
	 vXV7kozF7md9o2mAMlaLYm3JksRL5BP3SHWBZK6csd7+JJxx4Oh/PeNgguAkwjzHzUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Je9f2sBUTCO/EZacvnUN8CZNhT1Vz5vHYja71Ddfujk=;
	b=uQdaoH0/ieYQjqdESbIhOksn66TaSnKPpNmJD9LaMAd5H27OilhfU+80r9ow26ayAxPp
	 3Dd9ap0LLcKeDZslkPjeV0Q8plcpvBXoD3qheISzHTm2QwJUVVgWhIDaKv20/DwIB+PtF
	 fmVOpAzeZuvO7W6fcMV3s3BJRlFRIfSQCd2sv0PD9Cdz8UY+Ic/BoJKCIpKR3nmpAtVy3
	 9np6qq4jne9XVnxKZhs6wvJdA9/3mgR3cqD45f+V9mE9hWRGXdAKcqoU+ywmSzKgt/vhI
	 eqliDiExlVoNTTEeEB4qqbv1NhFZ1ov8OwA+GmcWRnmGctVNoj0liOEvyKM2c/Z+Q/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1iQHa5S;
	arc=fail smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDA606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1iQHa5S
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b06c0794cfso37847317b3.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118153; cv=none;
        d=google.com; s=arc-20260327;
        b=kwyqcX9vkCaJQpDN1bdbgUQGp2F4UX6AmeiapNWVP2q8GEKkqNqd7l0rTmgyBKavva
         fRfZ9bnDoOt5vcy+3gPSkuZiye/jm1aeG3m5tF8H1tQNHBa05gAbnUg7vMixzvF3TIzr
         6Ssms6Ts5KKJT4PItuWM5UIxv9/Jlt+Ywzk4LDcv66RJ4NXSEnP48+Od7RuQUhPv4IEr
         2GsHMTqT6gmROltgSzjeiwZmlEpDp60LpbAXruXDECH7KgGwJx9VSK8ZKBBmOfNtvKKG
         ihIVJfR7aNHtavUCqBbICZmcMgN737Hl3PfVQFn/nZj1YpYiu6Zbvwe5GVwkP+O2wF6k
         XEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Je9f2sBUTCO/EZacvnUN8CZNhT1Vz5vHYja71Ddfujk=;
        fh=tcnKt9iSgH2odWdd2AKNaV9Xibk3BtZm54s9qU/j+6Q=;
        b=VtUTAIdT+HmDRXZTuAqhiqDG0g8knAamYrXwV/aM+rqFUhNbAc+2rjSvjDxPU6+AU+
         AfVdtrc+N4ufbjRytWRZ8pF0sxZyb3SFhc2kFjwjpy2WVxmdxwYthCyq6RdmVXUIyPvw
         5gPjgQS639WRUosrNMblSloUALtps9xQ/vbfDD+DJhavfbG1rKyQVpd7atJvC/MZR3Oh
         4s0xi3qPgWeZAhJAcxDtSeuyO8wmezDI2M7hyQ3KXUicu4HNClvrMmZ8+qzbmxNIPBW7
         74mtvj4w/MGzk26MogNq7EzPaT+bfeBo8iuW0TLjzvETtEbnXs5oF240ja+VE3UmLAul
         Mi4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118153; x=1793722953; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Je9f2sBUTCO/EZacvnUN8CZNhT1Vz5vHYja71Ddfujk=;
        b=W1iQHa5SX/Qc+pJyHgnzeP49i7n4MyoEA1Sg3k4vdH/8WuPlX0on9nVDrySw3Zna8i
         VmAyaK3ohLRAwCwDkIuGUhl6lFASHb9v/c6ua/hWP4ZnWIS4Pg/QPxL+h/j2+M/ph6tF
         1vS3HMQklRX7SsooBGhCqQgqAsP87LL1H8P0aiSVUl4bKJTDy8l9YqnJ0x5Ec1X5CdbS
         J+/smu1iGC4WhXJMXPInRtuGzDFJObu3iEpaPAiN+VC9nv1zNGfLCEZH1FiQpKqwIiPf
         VWeWPMWfSjW129zws8g4m5xGzmWq5KHVcVk+cQtM/DXfJbdUlA+dhI85l6M9pPu5/00F
         GlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118153; x=1793722953;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Je9f2sBUTCO/EZacvnUN8CZNhT1Vz5vHYja71Ddfujk=;
        b=eyhhXW2k27j9JkrrQCgUcuWBz1lRui7bYchX/AWzsGV1V0HvaJJ6mJZX/HnaT6S2up
         vIBkHum5LnqlEWaTn0WrYUJR1g3h6/XJv6deeDGKbcXnokRE74+NZKwL5qsUSvTw1YeX
         SgURpy5R6aw/JWEnxLmkeqNewHLvfMzYGmkgH9ugPLWLQjaT8V16L4AJWsQbtlj1HGA3
         ZabLQ9vShBevPLz4mFdLZg2K/EHl71sP14pLeBmtzUA+GIfSvyhCigczCYqf0gOHIVil
         Ai/pBvLSjR5BTjpce7jn71p+LMhTkV9sKIZKApHeU4PVMgu5Gy7UNZqgNFciMrew1b36
         oJpg==
X-Forwarded-Encrypted: i=1; AKwUvBybwY8Gd+3Muy8yZKcLlhmEd5uxXuHDExVv8ftZBpzZMq95nibMvOrbKqtFLD1bS6EVQc29fWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnaPCxarFiVu+eV8LAez+LT436LDj7Rj5MxViw14smyr8+3hm7
	fqdVWTRc0toLRZx40fqze9FXqcUhra0889WkB7F2bZZUhml0V3XMDPRv0T6jEnv34ND5FkbE3MT
	qyBYvG9NdREX+ah8jSaRfBtdbE0ZeJg/H+txwpXJ0FffpZP0=
X-Gm-Gg: AYBFou0jDeoQZa2oV8l1z7+Mqvcg7nV8Ti75cqYWK+bSSwOLmN9zGhWQ5fQX0l31OFg
	7ek5MSf6PiI6RK4Bdtul5z7RjVBH0V6CD4oKBs94Wic/nDPLX8eDYTPpvALJyu4xg1PpAvlVOxJ
	vmWDGLRXi9nYObiITEwnqXonbQ0FXoyd55XhFcFR7nL+uoIWvPtXBaunP+UGFjBlPfrD/Kl8Mca
	d/82dOxsI7VOCUAY/D0q40ZfJCNQWMQMuNIgTj88qFoVyR2dtF6ncDQ3Z3SBBDdlSr+o6a+NAIp
	sKTlcz2u1fCUYEJjPpRtbdhco9HvhmIV3T3cTUcGrZLfnEQqFDBGgMRLuoxbgXYh53BKpXamT9L
	GY+iOcTpkF0YbxlyRzbNxgsGjfcMdIasgLDDC
X-Received: by 2002:a05:690c:dd6:b0:8b0:cee8:53cf with SMTP id
 00721157ae682-8b1669cb374mr84387667b3.3.1793118152555; Tue, 27 Oct 2026
 09:22:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027145313.136305-1-lgs201920130244@gmail.com> <f7d242b6-a401-4ea0-bfac-e988f1497bc0@kernel.org>
In-Reply-To: <f7d242b6-a401-4ea0-bfac-e988f1497bc0@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:22:22 +0800
X-Gm-Features: AclHuK9WhSZ_5Xj4ee9jEQ2X-wRviwNJD5dHM2yTu5byUlkX8Eudsa4g1RS5X-w
Message-ID: <CANUHTR_RYcMEOTevXWRF2iS83oNDc4pXqsbBZKLV7QbSUeYh=A@mail.gmail.com>
Subject: Re: [PATCH] media: exynos4-is: fix DMA memory double free
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 15:53, Guangshuo Li wrote:
> > fimc_is_alloc_cpu_memory() frees the coherent DMA buffer when its
> > DMA address does not satisfy the firmware alignment requirement,
> > but leaves is->memory.vaddr non-NULL.
> >
> > Because firmware loading is asynchronous, this error path may run
> > after probe has returned successfully. A later remove can then
> > attempt to free the same DMA allocation again.
> >
> > Set is->memory.vaddr to NULL after freeing the buffer so the
> > existing NULL check in fimc_is_free_cpu_memory() skips the
> > already-freed allocation.
> >
> > This issue was found by our static analysis tool under development.
> >
> > Fixes: db47622c13ae ("media: platform: exynos4-is: remove all references to physical addresses")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> More of postings by bot ignoring any feedback.
>
> Best regards,
> Krzysztof

Thank you for your feedback, and I apologize if our recent submissions
gave the impression that we were ignoring your previous comments.

We did take your earlier suggestions into account and subsequently
submitted a patch series accordingly.

For the more recent patches, however, since they address issues in
different drivers, we thought it would be more appropriate to submit
them separately rather than group them into a single series.

We certainly did not intend to disregard your feedback. We appreciate
your time and guidance, and we will be more careful with our future
submissions.

Thank you for your understanding.

Best regards,
Guangshuo Li

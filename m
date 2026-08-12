Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCD31A065
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543646; cv=none; b=PuMlRkEn0vfc1/Ew4INEvhA3laeb8z/TAZq61H0e/l5A5IPPJlgMcFti6WA8YAmP+1ux2N5f+VCj0/eO+cPj+0uojUuvFJLLWN9s3gMsTjwdqLrIDPbgGPJJNPa4DReGjnpAv1aF0gaMBm4q3xVVgld3jee0fiwjHYoCfg3vzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543646; c=relaxed/simple;
	bh=3Qg++ZEDDni8bhybUZdY5zrQmLLh3Ryx7y23HJD7h7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9TVhn6SPpY+jRraoEe06F3KfpMorDX9sVxp6Znanr3mD6UGHOQA6YqBllzy5XTJqf7ncbnJr/SorhPKtXSxi3oI07WvC6ZD8qCoUDgQ4VCg2Aff+QZKQXVTMu5w9rWfKrSS6n26sdkdYExOjSSwF7rrqTbJicpsPY3BKA0wMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeFkZ9PF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbN81TsK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeFkZ9PF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbN81TsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786543643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gRtbmuUIT2xEHaBBjzuNZpDsU3g31gki1lemtjtVM+g=;
	b=MeFkZ9PFkUhB1zSOtXoX5g732bdd0AYQmZifOziyueaG2rS781IebS5tkc1evW53a7bw+p
	vFAamxzg+W8g5oZH3TgtKVGi5+QtOrIvtJGqv3FbRtgTNh7SUeKajjR4PLsZEFwwlmLx3Q
	qHav0njpnzU8x6DEceLISSiHuk/opZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-p3-hcLG_N62wW95rNw6fKA-1; Wed, 12 Aug 2026 10:07:19 -0400
X-MC-Unique: p3-hcLG_N62wW95rNw6fKA-1
X-Mimecast-MFC-AGG-ID: p3-hcLG_N62wW95rNw6fKA_1786543638
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so8687755e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786543638; x=1787148438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRtbmuUIT2xEHaBBjzuNZpDsU3g31gki1lemtjtVM+g=;
        b=cbN81TsK6MUnejRq8EbNfqaj16zz8jgXAdvB6WUHpNetmRtMLDIslXxSrf8JJs6jkl
         Rq/yUKrtIXLzLFOOoUp6Uwlm+vGQAeOm/D03n2eD7JHSNdOw7lztBmtAs3tgRrUsvN/6
         zHHXudmh2dq7996exegMLqWaQT5pIbx1yHCnOwDzyuS0aAR3Y+dN13OlhvBpD57/hsUU
         ms5Fz18FJ58iHWLbTnunSWXfr8y91uZq4BCK/5QVuiSBN6PVbygkdXggeMnbKUqobbZm
         Ug/1eXjrUvueT0AxUL84Esum0Bf3zMVeIdBtAceQMN3kbZarZixUFSUKTENXsLniNxCn
         TvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543638; x=1787148438;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRtbmuUIT2xEHaBBjzuNZpDsU3g31gki1lemtjtVM+g=;
        b=KAk6WXZFqpjc12vxWx7Y6dEC0Zr5E+3lXRYbGKDUVWwbuM/+kt1kGxOFn413pedJBn
         B5tWfp4xaLMd7QxURCmU8HNN6fcMXG3+zj/j3MZj1jEUKoPL0x4VA6wboFYq17+2jyQa
         MDm9nFGtgwsqPflx3X9VQvUyGYPp1ZEiH8k3XhSPvoEGK5USNJ/W5pgHr94jyhRdUykV
         3P7rmMoMPSzyXJ01mHUtp2fQOb7d0X4+EWBCKNpL1jdT+3ylX0ntwVyKKMZgWNnJY7W0
         0+5PwQP/KFti001viOdeCDwnolSTCHWSkCukCVg6WoSEtCabv4JCnCPPP24laDUj9PNF
         KCiw==
X-Forwarded-Encrypted: i=1; AHgh+RoPzNixRCUpKClrbyfXipWxnyoMPR4smUc1G7VpALiLLWNnC0oHaj9S8Ty8qqOkwGEF18iVcjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2D2FTzM215WAW/VnfnUzFUU6TtC2XlE5+bNp2u8gfhsonvVGN
	vcrbFuDVZX1BWEONFSbyX1RbbgduQE7PderiReGRDTjQQ0tbjX3DqlA4gTXaNZlu+QfJFKHtcRV
	oUtRHtXa3xnd+NCHlwlQHaAoETPXbEjhD8I48WUpWRAS5Wv3xaAQJOZfF5w==
X-Gm-Gg: AR+sD13VmNAFZmYbCghC3DiB8dZrcR+HdUPXZ4YUg+lUUX9/rb0OmXsxWeyIVqXs0/w
	zm9W94oCEb1GxLkv4wY+q0X5zFrZdxmOVj3JMRJQxS1CDXtURaXEtV3eCgqjJ2Du+FbLlGTNPrC
	5v9DTOy7wnIutRarq3OBksXIF1g5HL3M+e0hGLyMpHabQurPqz8ZPjn2WgYoWekLNAZruDpTz1p
	NzP/TmNhWmBc/eE446euz9fVhCmmrfueEo6RVTaM/G4VEfCnZ/RDCt2l+HFwqVpgCiU4O3Il2ih
	o5K9kLqBndEOuimYdKcnTGIeF/4zpqzvZ3tEJThCkRXuuW68O7tDLsv2I0ENy9BGp6x1fl86
X-Received: by 2002:a05:600c:468f:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4997c14569amr57082745e9.11.1786543638278;
        Wed, 12 Aug 2026 07:07:18 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4997c14569amr57081675e9.11.1786543637673;
        Wed, 12 Aug 2026 07:07:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm61862125e9.2.2026.08.12.07.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 07:07:16 -0700 (PDT)
Message-ID: <ffebbb7b-a4f9-488e-8834-199da3073b96@redhat.com>
Date: Wed, 12 Aug 2026 16:07:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Fix invalid kfree() call via __cleanup on
 pointer
To: Wentao Liang <vulab@iscas.ac.cn>, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ella Ma <alansnape3058@gmail.com>
References: <20260617142632.3298984-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260617142632.3298984-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2026 16.26, Wentao Liang wrote:
> The variable `buf` in `fast_req_dump()` is declared with
> `__cleanup(kfree)`, which passes `&buf` (the stack address of the
> pointer variable) to kfree() rather than the heap address stored
> in `buf`.  This would cause an invalid free of a stack address,
> leading to memory corruption or a crash.
> 
> `__cleanup(func)` is designed for value-typed variables where the
> cleanup function should receive a pointer to the variable.  For
> heap-allocated pointers, `__free(kfree)` must be used instead,
> since DEFINE_FREE creates a wrapper that correctly dereferences
> the pointer before passing it to kfree().
> 
> This is the same class of bug recorded in CVE-2026-45959 and fixed by
> commit d5abcc33ee76 ("crypto: ccp - Fix a crash due to incorrect
> cleanup usage of kfree").
> 
> Fixes: ea944d57eac7 ("drm/xe/guc_ct: Cleanup ifdef'ry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/xe/xe_guc_ct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index a11cff7a20be..73867a5cbe3a 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -116,7 +116,7 @@ static void fast_req_dump(struct xe_guc_ct *ct, u16 fence, unsigned int slot)
>   {
>   	struct xe_gt *gt = ct_to_gt(ct);
>   #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
> -	char *buf __cleanup(kfree) = kmalloc(SZ_4K, GFP_NOWAIT);
> +	char *buf __free(kfree) = kmalloc(SZ_4K, GFP_NOWAIT);
>   
>   	if (buf && stack_depot_snprint(ct->fast_req[slot].stack, buf, SZ_4K, 0))
>   		xe_gt_err(gt, "Fence 0x%x was used by action %#04x sent at:\n%s\n",

Reviewed-by: Thomas Huth <thuth@redhat.com>


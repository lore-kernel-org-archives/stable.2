Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DC3FF1B5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570314; cv=none; b=SBy6ach1HgrQSedSFd3R1QNzQqOjfBfELB9PY6DVhr2/LptvtI8Z7FfyiVlIhpzJuuaEKcJK2XQ3mkLQaJPLFedUxCEBQlvE4izM0XQU294ckF3uenZ3vYKLEZdPUKhNM5kcTJKg/ibQx2GcDbrKE/9NTiGJQt7cbFEVxCkiZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570314; c=relaxed/simple;
	bh=nNIHFubT2cdwMRGC5wo1PMzn8c+9vm4K2D/LERMWOlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HST39bDWSEuqSPzHEiVTogi090KZW5+RK3rLf0lHyzY6E4YXCxSMAuMJ1nXeqgJTxvOSo4r0V7tgI3w9g81Fg3W0D7Do3cmF25mUzT5TgwExJ0hyvTkTx79neGhjxq+RWI9V5PNnTjMVBoLUGi3PPsXIYFqeNiWE/Qkx4DnO6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZeCq6ThX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeCq6ThX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso17585ad.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570312; x=1787175112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wINBx+pfpCyFlfKOWVKljukC1dHM8ILCso1ff2oMmaQ=;
        b=ZeCq6ThXANmi18Gnlj3wFyqPPVfHiHyxTNbXgzLNceY068UotVuJQcfNkdvKJ7rY+J
         nCfeCVy/gdMijWw/iUD8jhyDI0t1NwuAgPe6WbixKF+Lk5EsRiVKpE5+NohE+f6FSnYY
         yCUQofVVzyoZXXR38Bc2MwxD5ScmlGmLTsb0tmjdSlijj9IkWQv9T/zbWUjSGR+J2Dxr
         hOMAbpxQzs4r9i93JWOjBC7dFeL9BEfh3/5XDEfTqmkkdURVvgzF5F2RuWw/puyIkMLS
         0OTrF5taxW4XBzDVCzKndkqgnSKPMOw8xsiBpkv0yMNteR0rCdScqGQo+BXaQuDVLnTG
         fpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570312; x=1787175112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wINBx+pfpCyFlfKOWVKljukC1dHM8ILCso1ff2oMmaQ=;
        b=HdhVooE6aFmQbmlaKs0onptkhuHyJlBULSQthg+DB/RGa6CoIckaYDHEZ03ilHswIW
         lXr3vVfPRDKMaNYOOBs5tdpHueK/7X3kRdy6qVk0sVBMhqxagx9kI0ZNc07Ib6+l8EC9
         qJMfQL/QlYfcJnqNQHNOa/2NBKtpBolHy1viFxCXWjB/m9XfXUbNAt1VZX+BPrbr5rsg
         YpO92I83raat2oIQhzEMEvxDvneaGJ4WQewTxhx4ufPNBetbpMJwZ+O7DILar7qqEGEx
         GdvoHdt+y81J81aEMn0m9j21hpAfAY927EfSzEFbn+SkpkqvkPngdteIRln9EEtaiKGU
         O71Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrhr4PrANLKMf39oOoFnnwv0/bnqiU+CqJxJG9Y+qWGxvTZh/+6wd3IwDtoqZHWX8sXgl61BFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1F0yqfXyP5y7vMYxi1hb7nkX9x8VqWXV1fimgHXDafLq+pMMv
	ME/2hwW9kT3bsoxTmGXYeRwn/Kj+npdvKbXkKfgfGzsP094ai7WMlH+1t4yrd3xAQA==
X-Gm-Gg: AR+sD11vwztEDY+21p3dko/T6GHXJX4SdARDqHZQWeM3UF9zRzjefsf0eU03nZYg50u
	76noTtxwFTImGtYEQ99m+Gj96MU1ldiVVjX+4MFv2g3r02tKX8U1ByDech9MR0iPliQTnEBBW8v
	WucICNnGMcjm8qC3Xcm569vSq7mYfRxnRenFZoOWf20a2jEvQO1NOzg7nCKx3Uoxx77FHDl7PPG
	KSDvgPIx4k+cpmN/guP0fa9npnLX0vmOLSxkEn0HeNXC92kXnWkLa70MBATcS5uCBisqyqB8Yrz
	AIMxhyQN+8p8n170TZFKnBMmxBp9TU1I9ZTqtM6euPBRtVkZza16OCzC6h0R5NwDl2YqI0/O7uU
	1+EI1iapfMCjD4tS8yfMlA89InHCZyAPr9OoEEVCQbqWZACzbfC6veqegEChGXXgvV9TypTCG+3
	XGcuN8I2sQ/CxkJaE68FPVggbsL8he2+Yq6qWneBskRIwyo45Lple2r4nhYo9HSI4ajKkN/UeEW
	IpFq/1m2zvUc1LvPqiqcZWRRZzgdCU02lwBRklGQWj302q+DZD6m+rU4lVjH0fUk43aFhrSdXQD
	4P62rBKJ
X-Received: by 2002:a17:903:32d0:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2d388a6cdb9mr57115ad.10.1786570311823;
        Wed, 12 Aug 2026 14:31:51 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c221d24sm1708235ad.20.2026.08.12.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:31:51 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:31:47 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tomer Pomeranc <tomerpo@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, brauner@kernel.org,
	aliceryhl@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] binder: fix leaked fd fixups on TF_UPDATE_TXN
 supersede
Message-ID: <anzmQ1QGuRqMA3i5@google.com>
References: <20260812195316.259136-1-tomerpo@gmail.com>
 <20260812195316.259136-2-tomerpo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812195316.259136-2-tomerpo@gmail.com>

On Wed, Aug 12, 2026 at 10:53:15PM +0300, Tomer Pomeranc wrote:
> When a TF_UPDATE_TXN transaction supersedes a pending async transaction
> in a frozen process, the outdated transaction is freed with kfree()
> directly. This skips binder_free_txn_fixups(), leaking all
> binder_txn_fd_fixup entries and their fget()'d struct file references.
> 
> The leaked file refcounts never reach zero, so the struct file objects
> are permanently pinned in memory. They survive process exit and
> accumulate across invocations until file-max exhaustion.
> 
> Every other transaction cleanup path (binder_free_transaction(),
> binder_transaction() error paths, binder_release_work()) correctly
> calls binder_free_txn_fixups(). Add the missing call before kfree()
> in the t_outdated cleanup block.
> 
> Fixes: 9864bb480133 ("binder: add TF_UPDATE_TXN to replace outdated txn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tomer Pomeranc <tomerpo@gmail.com>
> ---
>  drivers/android/binder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8f2ef1bd5..f70aeb63a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2932,6 +2932,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  		trace_binder_transaction_update_buffer_release(buffer);
>  		binder_release_entire_buffer(proc, NULL, buffer, false);
>  		binder_alloc_free_buf(&proc->alloc, buffer);
> +		binder_free_txn_fixups(t_outdated);
>  		kfree(t_outdated);
>  		binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  	}
> -- 
> 2.34.1
> 

Thanks,
Acked-by: Carlos Llamas <cmllamas@google.com>

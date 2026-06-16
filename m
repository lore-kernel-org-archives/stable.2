Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510839A060
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596046; cv=none; b=AJKrS5cfadP7XExnh5a0jlTaxjHFCF3V2JE7a9kA4Io8Oo0qmYTPXeXwaADsmplyZMvJdJk8DHvTixySAV7IvDPHzcaThvisti2PyN8FDH14JY2fszqISClhNdwFxmBt1y8M4B/S6U+MGbfZa3gE7j9xIWw02r61lmk5gvZQmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596046; c=relaxed/simple;
	bh=v7cS7tV1ZB1giqpnUuKTjdhMtFofnT8NWeEmxBuRgbk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R59gUutcagykBJ34eX5EfyOFH9hmcYopMrJ+MqMBx7cmiYFmbeSnBN6zc+eT4sHn78nwk5tRoAA+ydSQ4aAsjlwv4Jea3Fn67Nim1W08tGI/hxXUkOnB6KevnTG16mXM7lG0sv9rdjuUBJjnqG1zypfWFt+IvQIdKx/W6DooyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IexJW9zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IexJW9zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74B31F000E9
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781596044;
	bh=qqtBMKKJu4/c3gsuS9X5Bs/vvxTdxGtqh/U3x+JB/p0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=IexJW9zto869MiQzsbziXplkz1U5rFDRcm48gPSPqrXyJ4dp8hCDdwiVLgL/Ocq5O
	 gyjoEMKX8dONUMDRd4xeQmQRqQaD4kAKQrwBuCOX1vyCLpkc0YJNRWGaLGFfC6UFOI
	 pm+rHZc8Z6r6IM40bOV96Ho6Csmewvn8FxjJl+QCwRu2zf08tWS16CPwxssS7tqFXf
	 9QTpGQh/pmg9/1KIiqzDY6+P+fYvc/wWxMdK93dDvkESjQArALsfBoOKuH7hyAxRLi
	 V4IuEs+iEZyUP2vIKhftplPmUgCI+DJyRM6vlzVeEuo6wMcg3382oC6ByY9ZzgjaKl
	 fats3hSoiLkjg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-397e391cb2aso36907051fa.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:47:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9XI65RSjIWzP0uEYjPfldcBRcWGcTBJtiRc5A+XshhBWmMdZBAIxuHHfMb3US3h/ezfm23I1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBQcK5yM2KRWmPnasSNvSL4fsXt+nHky8jcvnlh7XmfsyV3ya
	siuKKGp8KxMP/pBoHLN1wzK6c+lQPMMiXZQNrxqZ7WV8Qbz2xSbjpe9CsAANZy7Pu6ZFm2gJpJi
	7BPH1GDxrdM9B3P9qeOf+/La81HbLwhbe/OnKYZUbzw==
X-Received: by 2002:a2e:be21:0:b0:396:8028:eaaf with SMTP id
 38308e7fff4ca-39935624fe2mr44536871fa.18.1781596043498; Tue, 16 Jun 2026
 00:47:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 07:47:22 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 07:47:22 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260616022226.1655762-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616022226.1655762-1-vulab@iscas.ac.cn>
Date: Tue, 16 Jun 2026 07:47:22 +0000
X-Gmail-Original-Message-ID: <CAMRc=McBkRBcunrdx_Rbs0bhfyx1zfGhWr9c3Yqcivbs72-_fw@mail.gmail.com>
X-Gm-Features: AVVi8CfNxV7pv1oRllhiClrDcrSz4MZ100UBTTlNbpvhphTdM4C6VRG1EB71AQs
Message-ID: <CAMRc=McBkRBcunrdx_Rbs0bhfyx1zfGhWr9c3Yqcivbs72-_fw@mail.gmail.com>
Subject: Re: [PATCH] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 04:22:26 +0200, Wentao Liang <vulab@iscas.ac.cn> said:
> pwrseq_debugfs_seq_next() declares the 'next' device pointer with
> __free(put_device), which causes put_device() to drop the reference
> as soon as the variable goes out of scope. Returning 'next' directly
> thus gives the caller a pointer whose reference has already been
> decremented, resulting in a use-after-free.
>
> Fix this by returning no_free_ptr(next) so that the automatic
> cleanup is suppressed and ownership is properly transferred to
> the caller.
>
> Cc: stable@vger.kernel.org
> Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/power/sequencing/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
> index 4dff71be11b6..1ec4f393994d 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -1010,7 +1010,7 @@ static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
>
>  	struct device *next __free(put_device) =
>  			bus_find_next_device(&pwrseq_bus, curr);
> -	return next;
> +	return_ptr(next);

Wait, why are we even using __free() in the first place? Let's see who wrote
it... ah, yes, I know this guy. It's me!

Shouldn't we just:

	return bus_find_next_device();

instead? Also, the reference must still be put somewhere, probably in
pwrseq_debugfs_seq_show()?

Bart

>  }
>
>  static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
> --
> 2.34.1
>
>

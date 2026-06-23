Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FD388885
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184281; cv=pass; b=UlOECDnBkzo66ZU1wmZuQ1Qz1W3lHIJBhoLzLKRyLaS2vvSvkHGGX9XqOSy80TM9iU0k8iqoWiWoZsCI8fmDucfxRJYgvYWY8WQwGNbkMuKZUUxX9XKtWXjFar770RPU8eAAJkJAcbUOm3uyl8hPSGc05JTIPS9etwsABHoxwV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184281; c=relaxed/simple;
	bh=5tsJG8K11FH33t75X0aMZwkwKArLiDR3LlMxbCGTaK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af36s5iCBEweLo6J5Jb4tBAKXTI0zIIQOcJ00PmwTzE/Viainrb6ynSkfT4cYiq/VuPMuAxG6x1nbuRR5eyFshKt9A+3z+8tD+ukvnMLjRtWlg8N1HjbFB8h+kO61YmCieCsIpKIRRwZW3NDRl3RYNHcE0qZu7tHFworAVJzCIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIvU5v10; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIvU5v10"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so1951305a12.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 20:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782184277; cv=none;
        d=google.com; s=arc-20240605;
        b=JmjAnfGg9Wp3YVISH3c2MmwpSIjsarFZpzccujf6xJBHTJabCJLAyu5ypBWtWyKdYP
         xHT3MZKvsaM+CCVUi7j160lnKTSUVHXkaqUxvKqKobIPokwgrVOIo3bGFpokRLBtxePW
         huz0f8faVgh4fdm6tur+a408rNVHyFrMh4w7Sv/EaocuzeaNG4VHv2UOa2Qh4ega0Nbu
         pwcXHSpoZ6V7YShdHst9zxr+M1MeZVMzex/ramp4uL64fjDYsDGITvhU0+1OZbTwNo6E
         xz+dnIuxkzkGpLcfRfY1ckKt9M/hSQuORK3ianrl6+zTqySF1ziyVbxrgmxpfqdnWJb/
         67Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        fh=t3AXtRJa02EnsKq9vYxfG3TvjdREnqQdtHcH6hEwbco=;
        b=A4rrUUmasWj5u30LFmxIxsNKci0gIXWb0Lw13rV50ha996WIFN3wt3+E8wiLgSZIEU
         MmEuhviRnusTdPrnaelEegI/04Qw1EqiIzEro6lrExa3ZeOMIeGfg6md5p81yPsfMrIo
         OCzWVUnt1Dx/9G7ImsP9Q2GWJhO53S1/8Q9lzxCB+04S87bq2MZgZ00PUEfNCqnkS8T5
         l6j9NJxg0IQ/6X6lVPpSPNuxSzXpagWvdKM7EeDGTwz7ByiqO9wTQwBpR5Tn2liKl0tb
         SVovijw9ao9GTjL9aVvOrgQliYX1K667NgCyqq6djpIEhSxVpkWO+sccAsUFFFK3NDJ8
         myRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782184277; x=1782789077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=rIvU5v10tYjFohKj2Ab21hSM3Rt0+B/gvpNfbrNGzoFmcE23woP0/R7tRHgqvq0pbu
         fWsy2FYn2yCdppbXd2PHnmvuSfNnszKQ+EY3RvnrPLWXPYNSy9HkHmeGnLYYu8+aofor
         zp8jXP2KEs7UlXnORd5Z2drcxT6t1tGkVsMyaeL50dAQav5rMZSfi+7RIqIibh4CEyek
         dlYHRm+sv86RcPbLWgkEwqcmvd/j89h+IWW7gjI9rF25y/Xsr/wyk61DRf1KtbUofBpT
         h4UcHQceGY+w2tKlRM4K8Ek/BM39XdoG3GAjDTaTZ7r36IdnjgofTTxXpFfI/rBBpxRd
         dxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782184277; x=1782789077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=dVDLWUNvWQrMmhbSzIBFnW/zOMmzUbVi6k9zrEQ3xv1aDyVPlTpx+gVzVCbCpFlo/P
         q9tmeF/9L6x2IxK7tYzIjJcNSSn1n83ETy0ri8DH3qJh9SDqlyM1UxCjIDFt8iiDbb5f
         qmQ0opz78PfPU3HQhSAQPvcDSeNTT46kEv4DwhGZn7DYQ6N0ny/uvQkZnNIfbuPyoWKr
         ZrbxF13xjVrjwHvYliWYft6q9kHmM1HxjlCgXmynGJGiqTGAejbWhBnuU2LPoMElq8Tv
         arOn/Si8/vWHsfcuv5du7yQ/7ifqHvAjz9i08D4MqxqBVzUiv91ePQdyI9Ib6li7LcO/
         aIBg==
X-Forwarded-Encrypted: i=1; AFNElJ/awymbjJcT/wJG7VDD03tknsOykEUrreSW5GTXIglnkQO0gmguxJu5AgT/bmfikB3f3KVX6oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvX4oiYGKpMZl+aY5EFzExlI+TCjbgqP0YAOC1uqrK/lCbQDp
	Ur9te2wJDcbS8dCyHK9o7nDC0g2bAT13ylwQZ15MGT95a7HsEMWwnTVkIiqL7a7UQ+isUncvSZf
	+1rIyRkmXyaZt1FZ8FsOEHelf1wMvZKA=
X-Gm-Gg: AfdE7cmgj/Ivmzwptqh9aS5fk5eCqHUZZfdTdukLYF8VO3JKfwB1tqZV/Rx8O/nnx7y
	R2U0J1x8CqfNjsc0zAUx/X2QFYrHULaP8CNBRRIwzpY89u+4VLH1AhoAWTTOT51VhO39RW1bl4R
	zhyoj2beviczQvxaeH4MWzu813D7ij0SkG8lt9NXg0SevLqGjm8By5FOg/+WGWc8MvdfBpw6qvP
	CS0pDtm7TnHmyKDHIsBYFfj1y1DGb5eidaupUqvZM8kDYSZFEYDlpK+/s/L6+H1m52yDy831Vhi
	TFIN5KbywF4EEOI6oXhBMEzQTAt04gdsfgCaufh5gwZeQeeNhoFMeZcwPXQE11jPcPYAODmO8j4
	tRzVKvqpYqLPkpw==
X-Received: by 2002:a05:6a21:6915:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3bc531af581mr15488925637.25.1782184276701; Mon, 22 Jun 2026
 20:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619130305.27779-1-include@grrlz.net>
In-Reply-To: <20260619130305.27779-1-include@grrlz.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:11:04 -0700
X-Gm-Features: AVVi8Cf1oIzvdtEGICckV061Q81IswIClpWIZQWhYHurLRYhBKU5VvvDzlC6Veg
Message-ID: <CAADnVQJ4rpEMdj3jq9d0AFNcZterObQpJQiQ8VLwcYUph_M+sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: lsm: disable xfrm_decode_session hook attachment
To: include@grrlz.net
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Florent Revest <revest@google.com>, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 6:03=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> BPF LSM programs can currently attach to xfrm_decode_session(). That
> hook may return an error, but security_skb_classify_flow() calls it
> from a void path and triggers BUG_ON() if an error is returned.
>
> Disable BPF attachment to the hook to prevent a BPF LSM program from
> turning packet classification into a full panic.
>
> Fixes: 9e4e01dfd325 ("bpf: lsm: Implement attach, detach and execution")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/bpf/bpf_lsm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d..1433809bb166 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -51,6 +51,9 @@ BTF_ID(func, bpf_lsm_key_getsecurity)
>  #ifdef CONFIG_AUDIT
>  BTF_ID(func, bpf_lsm_audit_rule_match)
>  #endif
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +BTF_ID(func, bpf_lsm_xfrm_decode_session)
> +#endif

Applied this fix to bpf tree.

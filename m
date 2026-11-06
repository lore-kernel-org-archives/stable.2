Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793988807;
	b=NUoa+1xC7wfAziXJrTDg0aP7saTFiQELytR3tgCUEWSEuqBgqXqh5pv8sA7pPGq+plfe
	 oSv987UW/siOZEifXbnRjpkI3EG9UK/nozxO4TYSNzmIIEouHYobumRpFhvaMWnHsaQot
	 gp4XmBlLXnzO/0/PH/7TxC8WmPQLMWzwNhKWjSmLJ8rW5SM1BoMqfrf90OUo6cq9E5ZWO
	 5Oo2IH/QIpdFgoeoiavT2cnAMkF3uQEKXi0XSL6nI7nxV/9JUa02fnOEVqvmq18leK3tZ
	 SYLv9iAq2xsXTGejAhZhzajbiGEoTl+Oh7fVRnvtoXTJDhd04Wl64Su4e919j8fAfgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IN6twHDIaLh5ilgymQBvZ60S6ffcPsE8wQzp8ZyOj44=;
	b=V8Xl1VmAwHPV7j5UjHkgsYujL3I7GdFthuK1vdDLchbCErYQNNPJQp2CyjsJos4x1ygV
	 CLQl9UPlhbNrN4FolnOvVL/0hiS2kOSSPJHFFFm5tABKrWP//i20l79pZG4sK8O0j9woy
	 /ypft126ZZOXf+EWI58wtjnDXIUQ3Z3+iMmmrHmXFXN5lxEOb0/l/IWXBrXjS9fvBJjaf
	 9eCc/YFIsb697IqrZDCu4dyq7HIwH7GjF6ipyIDWZ5Kj7OJ5PqoSM98K/9oWwHImPgfjo
	 ubcPcEK3iDqFRNEEWjhyxcXrrV+v/dhvMFbnlqTqIOhBu660CNqNL7TLtGpkvuEVZiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C414606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C414606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso4060a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793988800; cv=none;
        d=google.com; s=arc-20260327;
        b=DBfA+QVVsF3t+GTbZAkCNR8xzn+hZr1Slrblb+CMORcAsaP1wcvZOnrpu/1D6lFSB5
         x0DvXApHQ6/BstdhR3g5IgyrT/PLhFLKWDX0klZsSHxw17p8mWgmDxcKNVN2TECjcfW7
         No2kM3DdEqmNFdSwk6HCFxfimprYchpc4/5i6gnzfLclkaeGFujUMPkALfMEYY5EgvPD
         YLi+OX0SQXpN7MfXcBuQr1yiaHK9QXj0i5HS3viCm8g3XexWHlmOvDulgBPSnJ6ZXuDx
         cFsgrM7YWxWZ35yuvib5YfH+Gt63BXXlac84iECMsdWXxU6GM2+Z+FgF7mjkhtISTVG4
         fmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IN6twHDIaLh5ilgymQBvZ60S6ffcPsE8wQzp8ZyOj44=;
        fh=+gL/d1CncvB7mS2JcyHwcClqXQrttVJz5X0jtf6EYk8=;
        b=F3AKXhJBpFb8qZqA+i3n14N6slbI9OINs12dmttB5yMDtAMp7ns5Te+LxCWhnSQKvf
         OkzZydCvDjLezvOBN7nJx3UptUJEWooVD4HKWmTlzUimDBaAXZTyTt78uoya4crLKrTR
         ah1Gdn2Xrt4G6kirrxIgGtDw3KYDdZ+gYcCk3DTixnl2YgAE3hdt40xevXrxF9ZqWgN3
         QE4Dgmz7/ssdUlgL4p/jwZwA07UX4/CFTX0JE81DS82cagwAmYpf/y7FcoSWnJjr2l1b
         6pDDE7MPfcAohhasgfQmZzd8XYqJnVoaRnElgyhK65fDBtIo/slpYIxwkYPQTQlVoT0r
         eSfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988800; x=1794593600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IN6twHDIaLh5ilgymQBvZ60S6ffcPsE8wQzp8ZyOj44=;
        b=HK0MPhUQzHBTjawDG9wj/rGTowNv2I3dyGJsb+J1METmvGduXf48+rJVnSO9OKq+s6
         Ggq7xoI+tRy4YkdyzDTLDFnVhO8BHrYRtqanv96INfwmwgky3tHXlj73v2/UrtdzS4oi
         fvmX769ugnuZrNKQC1yWl/1FVlPcqZT5A/QrCWkMOt8hPMa8nVqqXxC0RV+eqwUKGH29
         I2DpcxlxgA+q8SwxGHbQ/lkyWHs3uJexUH3dVFQHeRyME09v3Y3L4UmNITZdnpz/moew
         1e3BZH9cM92NF71j8BFrR26hxxaSUGSuWfg4M7kA66b5sm/S/+sEWZC2zeDDnkgZyxNP
         LXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988800; x=1794593600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IN6twHDIaLh5ilgymQBvZ60S6ffcPsE8wQzp8ZyOj44=;
        b=OoY4X8DOujPcTKMwzMFOG7/fONoJHHKAlNEJRwFpeR8nHZsBrnTgQ6c2N1161cPd0t
         Ey6FDhbG0GaeuAkHctwfAudPkZzbjcLdo+N3zz0FP4HYSGo9n/sXDPuF6ZkSrDYQjLXs
         08sV4bUwTRQ99ReF43aNkgsrWRHftAt7IhuDd0eSU/J++YUC6aS+BHtXvy3ReONFgwxY
         5cKSlyBQ+THGCscdTcqKIGDTWfgRpNn2wGJAcvduTmcv0eX7mHFl9J/UNVoezLSh8Bvm
         NRfhRck46wrRKxBdqiQCcn88kSro/0oU4VLOLZVw+1Dlo+pggJ5eehs6mCjdq9bBQMZr
         6lTA==
X-Forwarded-Encrypted: i=1; AL+hErHAP5ITiDEK1bW82ViXsbj13fb+a/RCZO6w8cGm0hLGcL1UCWdX0u0lCy8Q+E2uUQdTfDUUipE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TmSgZr1XBre7r96UKXAGBSEVXm2kAzxhZgWCR+NnozoA2NfNt
	JWFuXOTiSAACPQM+Hdq88vnpn0Uipc/VW9wXdWirmIS3ogzSdYg4ZdWTNxhE21AnGcrWUYKbCg3
	StlR2xMo4rDzYCQZYpLoEZ5NQ3GdjpIuNIPzaLEvo
X-Gm-Gg: AYBFou2Wc38DjCzb18jLOIMygcAq/Q4+2wL8SB/ViptMFXrza7+iRXlzPsYWfMHxdUe
	DmCXdn4WRy2yWW1IBce7Td8gIl/OyeR8naNcvVi1QTu/9B+vsZ58QcpCiotKqXNXTyPES+E2kfs
	Meh9V5s4ag9jdhiUk338bQufpflgtj7mCYj931J6JOyNpQzGiFVNF4+L3KLqmCMYvYGY2IsJqUO
	NYMpK9sBvMLad8MAWyXcM6PEQN2Nw8BAuQ4E0IH9y7BsjNEU97/tuSWnX6F5ZUQPdwqxKD3A7N8
	p8q9ntZSuTpHKLzcEpxkFZ0yAhjsOII9n8XU2+06YHWKfjMlWq+jUte8NQ+oCZ0Sw62zuRcQSF8
	syt9VMy20BzTtVSGKiB7iZqNYyp7njIRO6Z15ioCYT8dxvHhxjnT1/LD5ZiOTZfTpUvcGBM6Uga
	CBJA6eEUWtXeSh
X-Received: by 2002:a05:6402:4025:b0:6b5:70a4:c77c with SMTP id
 4fb4d7f45d1cf-6b6f8405023mr6118a12.11.1793988799653; Fri, 06 Nov 2026
 10:13:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
 <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com> <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com>
In-Reply-To: <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Fri, 6 Nov 2026 10:13:07 -0800
X-Gm-Features: AclHuK8M7aEN7HUd8VzCV7EfdL7Os2jiojoMycd1W00kFFu83GOEk2kpHYqCCkk
Message-ID: <CAF1bQ=TWZ=u1h92Nt9NgGcaDNTo=BOHmUp1DCWEeUMfwBb3WhQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Doug Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Han Wang <nesthanwang@google.com>, 
	Snehasish Kumar <snehasishk@google.com>, Nilanjana Basu <nilanjana.basu87@gmail.com>, 
	Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As far as I know, Profi is enabled in the Clang front-end initially. I
remember reviewing a patch that enabled Profi for the Rust front-end,
though it's possible that has already been merged.

It seems strange that these flags diverge between C and Rust. Could we
add a comment to indicate that Profi is currently not enabled in Rust?

Rong

On Fri, Nov 6, 2026 at 10:06=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Nov 6, 2026 at 9:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Just one thing: I think we should also have this flag for Rust so Rust
> > and c are consistent.
>
> Please see the commit message, which says:
>
> > RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes because
> > SampleProfileUseProfi remains false by default in the LLVM backend and
> > is only enabled by the Clang driver.
>
> Is that incorrect?
>
> -Doug

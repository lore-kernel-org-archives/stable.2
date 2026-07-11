Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B63C456F
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774535; cv=pass; b=r/JiaHiATGeqQ7PcqXEz1Rh/K4j/roDqGAf0PrU49kpfQyqWjCQjkZIJ5RQRrauFhOF4yMG8WhzYkYZRuQiVEPeja4UIe3bjXBvqKse6oE7Xcbp2AlttuVrUqprpvzZamniKBLXLOmr0xkEQOKbGkn6tsDmESuC0/q8ZS6jNgxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774535; c=relaxed/simple;
	bh=Sl+rcNFS4n6sfV7RASsazrAsQq0F5cbeZGTcafT17Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrUgYLNfzY4ohbw68VFbM2FEBFHmefrWLsidNGB21XXnxPrUPlhM2F/tdM9DBAJDT/p2KqZd175JiDl2xScG2RPpsV6oxsbVMUjDJvhMuOrYJY0YBFLd6h6/LUJtHPih1kLaiaVgK+n56O3PoSoOZctPmrdEn7sCjLDCzCs49os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfM/kmN/; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfM/kmN/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381d656c36eso151658a91.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783774532; cv=none;
        d=google.com; s=arc-20260327;
        b=b/XRGi3c1wsB3FSIJHPvdV1FTzTh5TwOPCcuSgYfYH2Lbtd5DgkjzLz7jxrwD0M4Ca
         gqZ47yrXk6t0w//5wGoJunggU1bI3YdCtvSQEftLmU1s564Y+5aeNvYzTFeTSGqoTWX2
         JRREs3U+O7zxA5KStWou5uSCJzHbCPshcW6wnHLdHBKZv7GEvBl/XybQ0XMOrruypkRa
         Vk293bgoFhU5q9NkwPxTm2u14+WaywocxmSymY6HCc6wSTthcQIv+E/BNU4Cchrzk7DX
         5YMB+BzqgQl1NOoEs1EWSKdElDRn/SMBeFRO+9EXhUxua3+6lzc24yfyCvr+ZARzmKr3
         WAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
        fh=s73R/LybCwdTrM2wOD1oAZuE9TJRAH12f1ixH0l7YwE=;
        b=Jz59bGG0q7dVPFUGczraRniDodBUeNgg2Q0CfJYlk4dFRpONV/58KRqBJvPn3GqGOY
         7pI+Y7klPcdi6eW8Ncce3krzf80+aCL77vntpRuB/K2brKRponOl2P1DgzfC6C32GU1z
         nlSj6jT6fTj1vt0wHYd9l+l8mGKmpMOOuIu2NbCmQEKp8AnBMaIBKx6pRHO4UIpONOOR
         vldpS9qSHlKFln5HH3GRkJR+z4g9m48Z57mHVclLdluSHMF4Ojk2I8MicI96ILxs1++n
         RnphGnK6LLVDOgEs3Ex1OLA8MA9P+dDrM9fiA+utW6JXLc8bncMcodTKUwm2ypdPYgZ4
         Ay3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783774532; x=1784379332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
        b=FfM/kmN/tO2vNXlVEHoYYU4Gng3x9pt3bFUHeB17lQNTYT1U7ODfEBW9B6LtFleKVP
         i3NLMWRmDSpf57VeosLE4ZmuaEXgWlH1kAUgg5tbB/WynOpkGfXDLIeEck+RjYlXuNu/
         EXgFjtxaV/jI2ocYua3lwDDL9wR5K7nAGbVLIeZtv3BWy/ABg234I2cX+T7e+O3rnN3v
         2aCo2GB3J+YdiYlnCnv2wA1jqNH/+IwrerF8N72wSXv/cT3G+y/AlYDNO/CCayiLz5ue
         djvgoWIg1BckyiY2RsCczktQUUbvGHYqjr0H1jftRXzswFo15Fw7bVafkSLU2CFq081g
         w5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783774532; x=1784379332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
        b=eJO4R1paQlT5e6OH9nZZVCiCJXnWPsr+SKzpy8bJw5nzmJSaRtpe4kmbzt33LJya4w
         i/BY2saasmlXLleG24DKo+rs49CMDQ7vKhGTZO7BxaaWC9iK3bQ4YMtR8AIIQf/FWPEO
         Ggs3AieVBv3QH3vOJxxzCrMHjunBpklcd4s3AE2QcVL3NyOI17f4k9UP+JyoTXe69jg3
         mK3nCgwxxp/DpfLCWh59Hpvqj/vkCoyAhbdVJZlJr2B+6Tn7CgEUJoTNUj45LvURQh/z
         4d7DpXVDQRWoMfnzmLPNTeLW8rv+NQzhc2oNdt7mpEZYon0O50NRquHS9eMZApOBkDHC
         2kUA==
X-Forwarded-Encrypted: i=1; AHgh+RpD+wVvJGi25BmLUSurNakTsgo9SCGpaGA0fC1tAB2Ld1q2cX26bV6qDnFu7MHbQnex9arLd2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rtwt7hJQh3WlfuuS4mKt39lvXRkz5NJxQUaljyH56goKbROu
	i6y/l7SR3yw7/z10wvcsPeypd+QB2saAp+Yhtsejpwd8IH10x0+jsRPlivzaRXsUJLV1kCIs6K5
	G89XbqPT2M3VDDMpHlElkE33T3ekf7w0=
X-Gm-Gg: AfdE7cmMiffYcxIHkolh5GadCjkKhZATDx058ByYEdNDfR81u6+GgG8X2N6J3m+arP7
	GgcPDwaN0vMrBoqLtQ1YXLB6e/oo6JJN5Tm95nnAQOZTrQdvAL55wjk9W07kwFKnupp/jHXcx+x
	PYiyTZvW7WMZPmUGlgsumvGcRSOJSSyubfmWLAnYJp+WjAdg6PbHADZxom/AIiTHIuo2ohLF4RB
	b/oxYPvDbZnasvfByEQTaD0FI2Lbl9SaIk/8tRj6u6o2nuP4f84Ybnqd/gtSddU1fTsUGqi0N/s
	OItPUi5+yUKCSo5xZxVmZuNxkMzs6IIlD1UFJ4FCAyizOHM6dVC7IFNhbAbZh34gdP6XJt5uUoI
	XHD8F9Y7+2/5p
X-Received: by 2002:a17:90b:3e48:b0:380:7688:fc06 with SMTP id
 98e67ed59e1d1-38dc7849860mr2139954a91.8.1783774532077; Sat, 11 Jul 2026
 05:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
In-Reply-To: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:55:19 +0200
X-Gm-Features: AUfX_mxzrtwl0-qM1WcyDgdPW3fSN_iew-N8VZzUs1Dmg7dy-KYQxeN-HmNLFeM
Message-ID: <CANiq72m9t0y3pfZUw_KbJSjujjQcM=FHxTCLenPoC_-v2udibw@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: guard dma_resv helpers with CONFIG_DMA_SHARED_BUFFER
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Asahi Lina <lina+kernel@asahilina.net>, David Airlie <airlied@gmail.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:53=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Commit 9b836641d3bf ("rust: helpers: Add bindings/wrappers for
> dma_resv_lock") added rust_helper_dma_resv_lock() and
> rust_helper_dma_resv_unlock() unconditionally. However, the dma-resv
> functionality is only available when CONFIG_DMA_SHARED_BUFFER is
> enabled, resulting in the following link error when it is not:
>
>       LD      .tmp_vmlinux1
>     ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>     >>> referenced by dma-resv.h:463
>     >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock=
) in archive vmlinux.a
>
> The dma_resv_unlock() inline in <linux/dma-resv.h> calls
> dma_resv_reset_max_fences(), which is only compiled into
> drivers/dma-buf/dma-resv.c when CONFIG_DMA_SHARED_BUFFER is set. With
> the option disabled the symbol is never defined, so the helper fails
> to link.
>
> Fix this by guarding the helper definitions with `#ifdef
> CONFIG_DMA_SHARED_BUFFER`.
>
> The only user of this helper is the DRM shmem abstractions, which already
> depend on `CONFIG_DMA_SHARED_BUFFER`.
>
> Cc: stable@vger.kernel.org
> Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_l=
ock")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see:

  https://lore.kernel.org/rust-for-linux/20260708082454.1254320-3-mkchauras=
@gmail.com/

Cheers,
Miguel

Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06D331EBA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607309; cv=none; b=Ih9OerLLIwXmBvnHrU53naGSthfL4Km5vwqLyaEOp8XLDI2HbasEOs3bI88lrDfYll66CcswmXczOEuSnFkGC8G/n8NZ8DaeXnRuo35qhemZ3DkQ0WefsLV0iffDtrwdDAFPfxc//CEw5R2VbxeXPb/2vxz9uK8IhKtINcIc6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607309; c=relaxed/simple;
	bh=4UGvmcJWO+vF4ijE0i9D6ZUUiRa1XDumSYloGfIKakI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6nDSmg3QPV1/PvYqR/6u+vU+CAeSht1Yhn69up+PNRGgIGr2If+ph1SvNIiiYZ3MhAqz/UeJ6rEzIZQJvU9aYd2MhkZqOh7io8XGoRCJEwM15++UC1bV3WQT7bkHJPWm+FL13D4nMbrXZaK3V/h68062jvWTaa4VoVmHHtfH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wm6gsbTu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wm6gsbTu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so1776090a91.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783607308; x=1784212108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g8eThvaBRatBKc4k9DT72V3nfTJdvxG/RsPvyVMBgw4=;
        b=wm6gsbTux7p3qJCv0awUjauTBi2lvqeTkI5W3yo8nDpK7nnqnJ9xbPOUIivY+MZdgJ
         L1P6HhJyqjGfBRoTY1cs19+9JQhhWbXGp7QmzTDXXwLBRMR1E2S9b+4ypts4XM1Tbbiv
         buHj6m+z2lXLthZX5yZGLP06+sDFATFEP5FBTNo33i376mqOpefRBS0lmF01txBbMh5B
         ysR9bmZdOcmWArFT3Kexz3RhmEAalcrjcDEd7iQ1kEKUhARDrWgbl7rz9gubFrWeU4tq
         BWpkjYQkLFTOdW6QXqi+QbNI7B3b/gf9kKPk95E9oVYhnGhGhialqvjmUp2srnRbP4x8
         5bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607308; x=1784212108;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8eThvaBRatBKc4k9DT72V3nfTJdvxG/RsPvyVMBgw4=;
        b=JMcre+5mcPZ2AxFEG+jCMDC6lMqO2Il1qxOE5RDsKPQb9YtlmWzdysrzQlM+VE4dmB
         ZSo4i4uvDLktc5uBbd4HGRe/pkqa3VIvAK+BtRh4QdqbzF9nID4Ifg7AJMrcc/Q+29G8
         yU6sSb5NpmT5NDph5SNGROYdLoG5d+/ofTwDgyCPY4DCOpr1ynkhsx8gRWHEJ14ZyOAy
         eY8dKFK/c/AsgTjatdBcJPpfpsVH5lq741M+OWlm3jAH4pXiElaotqyMnbKfElF+J40R
         R/P9RE4PXAAo3G16cOoyfHlw+FCYjrTLpDTYnVJ91Jm685ylRVT/miTVC0mMDBYRiDJT
         lcwQ==
X-Gm-Message-State: AOJu0YyH/wSFm8ECHBGN9cNZIxP+XP8X2XUqeJhPIZEM5AEjRGweuHZk
	XdLjWP1x8lsjB5zeloOLMRPqNeweInDGgG8KuApwawqeTxac47xMm0XpZxFoXdPCst+QKYSeU7s
	M/f3m0w==
X-Received: from pjbbt4.prod.google.com ([2002:a17:90a:f004:b0:381:9321:9051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e184:b0:37f:e8d6:72c0
 with SMTP id 98e67ed59e1d1-3893f694ae8mr6844986a91.1.1783607307420; Thu, 09
 Jul 2026 07:28:27 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:28:26 -0700
In-Reply-To: <20260709072247.3305784-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709072247.3305784-2-clopez@suse.de>
Message-ID: <ak-wCrZ0J-s0d27A@google.com>
Subject: Re: [PATCH RESEND 6.18.y 0/3] KVM: x86: Backports for VM entry
 failure due to stale CR8 intercept
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026, Carlos L=C3=B3pez wrote:
> Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
> intercept on PPR update") with two prerequisite patches.
>=20
> Resend: fix destination emails (did not properly send first version to
> stable@)
>=20
> Carlos L=C3=B3pez (1):
>   KVM: x86: Unconditionally recompute CR8 intercept on PPR update
>=20
> Sean Christopherson (2):
>   KVM: x86: Move update_cr8_intercept() to lapic.c
>   KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
>     mode

Acked-by: Sean Christopherson <seanjc@google.com>

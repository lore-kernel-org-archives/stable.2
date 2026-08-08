Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C53B2FC7
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196321; cv=pass; b=eNwc/YqawLuYfPz/w30RXVSbUPRa6kl4xxQtKgc6Qk3i1aTfKHR9FQJKOn/YZF1SXgJQFgQ4Nag+xYitXA7xy06KMysL0qoGif1vj0NXIPoZFVE4SO+t4lm5Rot/tS+VHB+FoXCLZl0plkOwtf1c5HQQh6HPn0qw/CXnjAjQ1KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196321; c=relaxed/simple;
	bh=71wg+Yx9OeDKkrBSUO/2kzZynVoRWwKwtzXMdscHdNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjYykCURRiNZzRLkTK7hQRcIIv27hcJ9KwDBSkoaTJ1TDXtliP8BK+3VSaAHVWrfjjY/nhbyzmQicMC2cpu4R7rgrkuKBVASL0IeA37QP8U+134RBJ763PKFLqMwRmQ/F2alp9D1jpv3fc/E5OoRqjwknnOhEbSGkZABGwZfHe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=khhJ1WJD; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="khhJ1WJD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de008b020so245919f8f.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 06:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196318; cv=none;
        d=google.com; s=arc-20260327;
        b=XsMDBZ9hxx7thgP172XulUJAkRNdf57RPmS0Uuw5j9goE/8pgl9fjpLROWf0QzGlVk
         S96ozmcUIyBHoIoQzU+5sJLBeljMC2wb1OhnOH+1TO12/9ciC3KGRoHtHtcYgKQ5Fu7P
         ShC0Psb7JPNqMnxE8WnqOQr9BQOXwPjYNHD3F1fIHB1Uw/4G/fsL0kvIql+ZWpbSqEGi
         r0EoQJaeGdQGVWKRERAm3g7k+qFDIABE6oq20AVcQeWIEAq2ACcY61fKz+r5QF7RzpZM
         lAE5GkdhfEm037H4HdHezCS3ZWNYRpJA9Qv2TDMeGTZoFnsCNsuI7bBMnRarM9fOBYsg
         6bKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        fh=KgDtKZzdHnjU/l11bGfrarnalPNxaX++v+jaKq+N/SQ=;
        b=jFYGJxRT9t3UlK21Gi6mZYSONZfEHL+rLeXdLpjyAl5cdjYProXQ23U46ezHmh75vH
         uTnJqAIssj2U9lM3yknrQzh+nAGUn9YAtV26WmhlbPaTpPOXi8k2e/GPuXqCMCILr6nh
         I6GPARM0wPMXcQDkokcc7PBQ+s8uy1Da+780EKYl+H0j2VaCmRouZILmU6sUxd8cEjYa
         GnSyPYrb03Zkui/spjaDGRWZUekQt2og1Hal6kkrEce0FgjKs6uk6BGsXG0GiOcTZqKI
         KqXb9f3ZVF8/PItixZO8gODKV/xIe27GKPgGo4VISmqBs7Hdumo0XAgyQ9x9TOycMlta
         Y+nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786196318; x=1786801118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        b=khhJ1WJDczt2RWIekDh2IxOrvdWhLjoMzqGCQVEIvPqFePLrF8UB9/XWtkaKFxM6ot
         2ohe8ATX/TTMXM3AoNxmweJvdTOJLyHOsuLVwVtXo1UszgGAd5Lo17Q+FXWDLGeuq40g
         GE8qo644YPVCtGdqHOh4G9UPjmJNy0AXNUdhPkqKWAQZgYby3/+4BRUOuaj4yy6B0+R4
         GHx/F0b7OfLA+eXOor4MtQY21kOjQU6W5WfxCCGAzyWsnKhjzy9ZqS5G/l7bekl/REj5
         ec1F2nuhxRkximtsr7rqgsBYbNm/S8zwEgrE7nXVy+cCI+RKcgTCuJXVlbHkgE2aVGAJ
         FSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786196318; x=1786801118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfZyWZCjJ1leqVfT0SG7I+7umcPy1TcL4EPeJOs9ZU8=;
        b=g3yJp5w2jl10NjjLpqEoK1ZDcS9xGsG/0aLQBkrhsGho2b8maeZhv/weCzI8A0w2el
         5l1ApBhvTqNGv4i3AGPoZsdfRshAU5XGx8jn/snW9dt4FSW1pOb/nnyU8DYM5bCCZtWx
         E6Zq4FVa2PRdWjd85ZpdYmJwQPgFRaDn/RgGr/GYirfwAIMTxdHb1EvmcghDAOTxnGOc
         X8x8IDv7FOD4Y+yDSUZUr3GQzPQMR7qqPsTO5P3u3t92GiP+Jzq8AU0IYJ8I0O5PJqMR
         6VEshU2Ga34loVAsdlWxoFXqvuK+GYDjRzzvpYnEzgMT1e/oToy/Yu1YbUAWsOUUx66F
         MANQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqy5jBzHh1CDsJ7vzVv4FVAggwNCVgZPqU6rbY1Wg12tVZNukM1Z1lf9vxfOP0Mlb7nInc0e9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFIsUCDH+LbpplMe3DO/w6pWLkFl9o+zmT4z7VQPOW5jeh0Yg
	n1quYtlBdPWIOUeEOi9bKd+yzUegk/RuP5D7J9gCbpybFd08an7ftarfmF9cibCyJQnpXRqTGoT
	IlbityNoxd2byQUUiCJP6mmamBFuK1z2Mp+Qh8zNTBA==
X-Gm-Gg: AR+sD11t8oKHM0sZO5MzPl6QhCvfmkqKB6Rq8i8Iie9n6BbyMQ2P9B0GwWjJoDaTnwi
	ky3JGvCiK3+2dMnuMyi1//cr5ej1BnCvwELBO8zR3ImaIzxm5hldlcyfaMHfqJrKiM++sTQHOC7
	fQuST41CbY2b73XKbAvk4Ln+yHqETaApDSOEs9oZ3BAHlnI5T/IQMSB/zqg5g5iy0CMHt4Js0Ly
	uSXv+dao9nTBhnNVw/bwk1OwHzoxNBIFqD76xmwfUV/aayl4jGBK66iFcSaiVBg6VK0xOtH0/Ck
	+aKW2NWYqiwPbskR+8EeNx0e7J5/CyBHmrsbe0bDGYEZB1zB9SjiwA0lxJBjXEDPdRxodLlq+ig
	ENZzVM4MMf45wbIYlhl3pFJPVNfGXULlHfD59O1yfJrkX3ay0iWoOiyZaS4mpHOg=
X-Received: by 2002:a05:6000:1887:b0:47f:ec53:1d2d with SMTP id
 ffacd0b85a97d-481319549ddmr7552590f8f.7.1786196318049; Sat, 08 Aug 2026
 06:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com>
In-Reply-To: <20260721073612.137259-1-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 19:08:26 +0530
X-Gm-Features: AUfX_mzyJKN77fdCLGM6gmkcr4GuDsVCUAGD0eNJkavB7H9aI1HM5JR4BzibWXc
Message-ID: <CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 1:06=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> KVM device ioctls are not serialized against KVM_RUN. As a result,
> kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
> an IMSIC VS-file before a concurrent vCPU migration releases it.
>
> The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
> uses the stale tuple. A GET or SET attribute may consequently access the
> new owner's interrupt file.
>
> Serialize the entire IMSIC attribute operation with the target vCPU
> mutex. This prevents the VS-file from being migrated and recycled until
> the attribute access completes.
>
> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

Please address the new issue reported by Sashiko bot

Regards,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de08..2a4f88efe 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -969,9 +969,13 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>         if (!vcpu)
>                 return -ENODEV;
>
> +       mutex_lock(&vcpu->mutex);
> +
>         imsic =3D vcpu->arch.aia_context.imsic_state;
> -       if (!imsic)
> -               return -ENODEV;
> +       if (!imsic) {
> +               rc =3D -ENODEV;
> +               goto out_unlock;
> +       }
>         isel =3D KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
>
>         read_lock_irqsave(&imsic->vsfile_lock, flags);
> @@ -995,6 +999,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsi=
gned long type,
>                 rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr=
_eix,
>                                      isel, write, val);
>
> +out_unlock:
> +       mutex_unlock(&vcpu->mutex);
>         return rc;
>  }
>
> --
> 2.54.0
>

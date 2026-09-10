Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D848D885
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048756; cv=pass; b=V4EZwkGwznorZOCjSOL3gxBNyXppx3592dDNvB/qmq/5F6NUN936wK5sI2auLJNKdlvUtbhKAadRHit6eTF/9RDEvCZ1k5QQ8cmHN7alYnb1WPKdquktCxEkzPd/IMtAQx0UbR28zBg0Jx7q7qVl9TRWHF9dczlkxH337V8lrkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048756; c=relaxed/simple;
	bh=ZZvvuoaYfIXmr8UO0wotjAdQWitg9LH2mpC2WJGAYbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBUjl5SNH/XEbmhY831mkpoE8RQjg7aTOiyWxE5+9WNgnnJueIl54hh9CbajOELJbeey+zpO+vfsSUBoPJO0hO6vrCy+49vah744qY/+8XjGxV9wBhD8Tq/Lfp7oUyNgb5pr84j+iR1nzgxJNfsUIEbqxAljy1mYDZ7WoqIHXnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=ZOm+TsBW; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="ZOm+TsBW"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1479249f8f.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048751; cv=none;
        d=google.com; s=arc-20260327;
        b=H9/rUFyTIOiqyLupUUjGr8de8D3GFHqyygHRUbRb8z/6JVc9CExWzTq1RSOQZ9j7nv
         ff3GOEvavxTZ4Ap6qlFI5B6Bd6uXIAAV6e9yp/FUAKBECjks5Jxh9wNhErxmBW9KmnSn
         T2l4bOMOa98auP8YbkWP63zzVMI91BzI7XfNNSPlqeN/9v5ulbqv2MsdF4lkI+33yaeb
         Kuxf9pK6mTozvF83pBnb5rMr3+YzdXJNOTQa3z7GMZwpPaYgVyg/FaNDjwWQHswjc7S4
         OJ7DOvsbkPxF+5kY1yWgXAast4ylww0Apar6frWu5Cybd8QlFW2WAOBMX7Jvf7g6j4r6
         OnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        fh=xK/NK08EaIbOZLNno4PLV2rrWB6v93ZCUtaA6LYeGN0=;
        b=Lk2+QtWGRlpp4cuPA/RapBeb34gtXmDxzaRcjkd5eqthFYngWKwu/qxufBaqCHX8bP
         Tq5JrdGjBZRNmzRhwTQva35CAKSDhDf0U1uxRU44UcGviKsOUe2sXCxxPMbDwA8Ccgpo
         yP8yviOJmgjRRNorYTZo+WdcjHGfYqiUizHUCK26X72WFUOcECgLUCx6PPLNmWfdL+3a
         Aqt0GoXiZpkU7Xk9s+cBLmIonPqKTmdFCn+/eh51RJTo22JuUx+GtnFQjUkzlp+d0k0F
         lWNaYU7h7xBzQPUQ29On/TxZddkpn/Cv5dZvwVVTFYy8StiOTQ/8eJ3TUh0KnRWRi9G0
         8CSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789048751; x=1789653551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        b=ZOm+TsBW9E6FYiIdVN4eF/oW5j+SgDOQpPiZ8tkY4wK1H4belKr2Ov1LXuAdBTv096
         Wda8bSUSbXM537LBrFoA8lT8sbV7xvjab1AqlmdDwhnaDdBoqtCDD8Hq4FxKDZKYF+KA
         UJs3ohuadmzBsiJ02927Op6M8h2dZB6IrVP97e7tMvKoJ6gYYcxGwLSHAG8VrqWhHvJi
         VgmuOP3BT0H5ofYIuVW5I7E57mMlyzvVyUmJ7JHXQlq39f/btYhsZ2bocXl+hKoxwymx
         lq+FREiVIgfiv+yrTeS92gNkhJbliOKbvlVjX1rIojxU25SPtCGshi9sczB1YDsQ2J2R
         JsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048751; x=1789653551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        b=HkIMEGKYgvWXlwFLXE1cHKpzHvLIe2ws416RDFIDKZzZFFBURabnO929aeISFZH3RV
         uqY38j+M25hW3nSSs1xRO3JXjY7JujzqaCafFWLyJxNE0Ty+ea91nCV07ovbfmKr2Ic8
         TedwaOmeDqVZjTDTS6m2T2khn9BlNO7IMmZEw1evr8H3Or47zDDzmSi+a0LaRXk7qEcW
         PvXd8xqOfkhM0mZdWt9vgVbRiSorVsXgTrWrk82yaLN1F1RqnsEi37XPu1kJrlkCLBxH
         9RFFWIOMHngQnpNiourFvExWxNrBKvFuNPRv8bURiInxB9pPuAZpGCa2XDqawtuQSh0Z
         Duhg==
X-Forwarded-Encrypted: i=1; AKwUvBzBHKnQ23pZ/kqPxxzP4WQvPCCZn+HPES6ERKmuJvRPJ9a4yjkaGhBhPYFVe414AzVPhRkedRw=@vger.kernel.org
X-Gm-Message-State: AFuF++nHFOkMduWbKfR0FVkAjry1sWiZrbWJkCsbWOhrMag8Bcsxiq/+
	j61OJ/GOec7FB3DbGLhDe0lzSwjH5XEaNJHfPBpEu/4s0ztnETRhdQgpNyfIRiPYkDwLDqoowVE
	CO7/v4g46+XlfE7MHJcUuf+84tv2RDDwL2ZaouwdmDQ==
X-Gm-Gg: AYBFou06axU6dRcvj2ARvLwLyEA0FM3zzDC7mxBeJAX4RU84Nz6vOBlbTl8fr3jsEFU
	XOphPTYaH2DpLPMu+58Xc1qB3LvGvCp1b2FsdUhk4L9/HE0Ix9hAek7kuV3tj92IcMhB15xZ0wY
	nh6R3KukDNNVibN8Ox6MYARI2Wg24Wib8TV+5QYHBPmRdQbU0JnIhn7UV5mUEMPEGoknbIiXNjH
	5U7/1RPtii9RS1CApvqnV3QiGvAIX55CsBX/WN0xN5xV2NbCeHMJih97/FplK+FEcSJ4XxATwQw
	BSqggVcxeQBcIp7l3hA2Sq/yt+nBaaYxajjGSakj8hwvF6fLrKQ+IAGsHz9n6eGPwJph7MjnlZ4
	5gmtvfN4cSuoNCDmIv40AubuGeUE9KTXX2yMOH1Bq1zinZ13OHnyuwetKSwRQyI4GkUl9L0CYOA
	==
X-Received: by 2002:a05:6000:402c:b0:485:acfd:4fa2 with SMTP id
 ffacd0b85a97d-485acfd572dmr20259573f8f.28.1789048750919; Thu, 10 Sep 2026
 06:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051544.3953925-1-xb@ultrarisc.com> <20260810051544.3953925-2-xb@ultrarisc.com>
In-Reply-To: <20260810051544.3953925-2-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 19:28:58 +0530
X-Gm-Features: AcwNN1VoynwwDilW3Qq5_YgkFrLdSifis-TkUfgosx4SiSWNhFsAD_CF6I0IGk8
Message-ID: <CAAhSdy16n_zWBudDS0_E8xK=mhKBOvLMz00SRWnY0ArDkJF=qw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] RISC-V: KVM: Release unused page after MMU invalidation
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:46=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> If an MMU invalidation races with a G-stage fault, the fault handler skip=
s
> installing the page but leaves ret set to zero. As a result,
> kvm_release_faultin_page() treats the page as used and can unnecessarily
> mark it dirty.
>
> Track the invalidation retry separately and release the page as unused,
> while preserving the existing return value so that the vCPU retries the
> fault.
>
> Fixes: 2ed90cb0938a ("KVM: RISC-V: Retry fault if vma_lookup() results be=
come invalid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as a fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5e..d189fd5 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -627,6 +627,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         int ret;
>         kvm_pfn_t hfn;
>         bool is_hugetlb;
> +       bool unused =3D false;
>         bool writable;
>         unsigned int vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
> @@ -719,8 +720,10 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>
>         write_lock(&kvm->mmu_lock);
>
> -       if (mmu_invalidate_retry(kvm, mmu_seq))
> +       if (mmu_invalidate_retry(kvm, mmu_seq)) {
> +               unused =3D true;
>                 goto out_unlock;
> +       }
>
>         /*
>          * Check if we are backed by a THP and thus use block mapping if
> @@ -743,7 +746,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>                 kvm_err("Failed to map in G-stage\n");
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, ret && ret !=3D -EEXIST, writ=
able);
> +       kvm_release_faultin_page(kvm, page,
> +                                unused || (ret && ret !=3D -EEXIST), wri=
table);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
>

Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D2479896
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341373; cv=pass; b=Up8Gg6SVExsDXKC+fphWf6+dUJb1XgxZCYlQ4ODDg9G2QLVDz2Wtz+nJhJRvC/Vh7lBmsDA7lt8SnvEvFdjtbGSk7e5ZzPHw+4oFKR7Xg0nmt1M1ItRIc5tdxN8G9p0NIh039BtC6hyDfMV7bONPmc0Pe+lhxsOr593MeLaFEm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341373; c=relaxed/simple;
	bh=uim9oxsNtx9iKvXL6JzquG4OsjGFEgYmoxSJFNCT2Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACbRfnHQ10RoKNFY9jrAkJag1Q04TcQxp8Dd3yUbqwRH2o0BhgnYraD8o09gdeGU7XNM6XsMN5OR/KootW+Kbq+aeN551d2BBWvLEvSwPRe5dl6d3iRdsJVSCCfntZeiq1EQt5LAfmQ/3rwwpYzDApFGQ0cu4H1lyHiOWz0pNaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=u0DU1Xbr; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="u0DU1Xbr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f97d310caso1140888f8f.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341368; cv=none;
        d=google.com; s=arc-20260327;
        b=fxMzjcsoA/Vhe6hfUUR9JiAkvn19uiIA3N4cdM0OIIPKFph4fQA1wDBHPqHitAD8bP
         Bkp2J+G0EuSGb/kY1YKwCvEd5KZVeXroNQQd2h6pcwA/qZ9L0H0wPBlRlSF/WFLi2Ftk
         7veIsLPoEHEQ2zsVi2nvE36zySWDuILVlBfYs7auUgisnUNNxYIooQc6i+wmZsCflhGF
         Mp2yyuqFLyDU0n5PRtMrJUNkPMtXHvwzet9Ba7U5K3IAOchA/vmSoDzlql1LLyyhSi74
         hAinQfaA40EnATJqmJ4w4G2HxnpXJWpnzS5tFxIi3l/Ah3BW/qHrXmdG6YrIxpMMlLL7
         eUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        fh=s7uYTUl4NgtM+ryFNycSB0fAIeHfGBsb62K9mWKlo+g=;
        b=Nal8AxT/x3Kin5bY8N6Fwyj8LLYu715CUFTOZ/8NQbu3nJo5zDYbvwawkjBrbEUQ5e
         ObKOQuZ284cE0pqndUgpIPfhveiQZRFsG0p2PzhliNWjj+N6OqYedCGjmhp/cWweFIMc
         Qs+YWGFe+11wjEEtQrfYrDyzqpOFDgJxMj+fLDVGzIi2ZQQmvNu97v7Zt6TUnS6kKpQB
         pFyuBGpypHtUN424mqShRG/VZ+uAd+hgdbNBL21Z18q3UdoX7jriMSsAiq/CaXwdzvcg
         5+W6aOojYE8Ey99RXoIbZ8uCwedoQA0AJYTFEr/CwnYfb5EUu/CN/j0tGz0CUt1O0u32
         Eqvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785341368; x=1785946168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        b=u0DU1XbrBwPrfrIeNRhk26qKuJBEj6Q9Vloi41PCpa3jdJlorP0bOKoiDm/A0G+gAB
         VkbbkPLJwuANKXbBDFUOn5CzZ0WIX6bG/n4bzZp+nZnDR2s3MjsD88v7B6esw4F+7lFc
         s4yX5GmpzgtGkxoU/NjgIaucN4VPVz2LTZ2/IR9PwRijQvOS3NDCSuBJyz7XqakIeWZ/
         Q3JQWKw2RvUkfsPh1KyXOPEK9+895obo6yIThCPJqsQEaaz8T1VhVvekQWP1NzweD5jP
         uLLkfxUC1jxFqki9fYtLeqHqmFlPfvmT0EoRqs+rswbZHZ20skjK/N47fp0rVyQQP8cW
         z//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341368; x=1785946168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zuC/oQvIKv9ZO7b1iXct9muPojkdOiWtkgZr7atSyM=;
        b=FAKCXPkMRehFMiqUPb1JDFHHFWaynJZhn3mFYE4/DnfP5tLHAynkaoVtAigEaJJy4I
         HiAOcqVqKR41+CAWP3/plJxSR4CfilgS23u08o5XHN5U4HjturYp+yViGUbDYixvh8D4
         6rqihBm0n1hJcUobFYij9aoOWUNv63KsSaOHTW1Yf7eNsfBcsF5r3i2zEBTAp6A/Hcqp
         ZXMPU0V/yR1zAsnMG1VFABCFeqwnw+C1x+B0ytWLlRXRR03Be2rMqgMAILuU3apuFZaB
         HHxaNTpUIkavbtCikCZ6GrK0lwS7jLV/O5ma0636dDdf9LJIrVWBhIfKOaCG5Rz2rT48
         ptxw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8rvM76r/GvXeQOIlWVFmxkmKLzBaBZQyjGJTlupPC7siUAMEcNAIvsjfK40RsN/6aDazxzjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhuGi7epX3Ytw6QB7lBcV6U0aBJ3CMhKvAvDovJ/oR2kco0XW
	xUYN29GE1sJjDTi9IAxIGXq08vIQm4ZwqcindpQwaZslLUtQbIje33hODpC7M76eNcCrla798V1
	5Zh3vK0OwvVOwIQFCBOYD70R/WBBsRNkiliidMFkwAA==
X-Gm-Gg: AR+sD109FTroEFSvo+a/nrc0AyDeNfEI6Bd7FEOla7E5OsoKQOXfZ1rvnY5pCOYSzfB
	bvie8e87IV7/IqVHTEgq6xfjkWodTqqNwZKgsWclgEI3Og4FjMjq44GPzCgoRkWmO1RslLMRuzo
	i+JmrAwjg08ANuB2ASDJhMsw9awghUebnTjOOyYKrPhx3BI6ivMtXPtLwCbsbEdeghFpNE0DlFJ
	zGyGdVeqHYPmPBFDlNIZy2NLfFM+xAI6RVwBzem5AASDzekdnpTCoaTqCld1ucoX0DUXzIYr/K9
	tnZYLwOqPAeGN3ICg1b+vQKrb1N1kjTBhOuDN5pSgQ5rxfNOPDVllqE0Yat15ppkUI4nLuiEvix
	rqngZwaFO2DSrArJCphkQzorl65O/wVjc4OFyiEZ7LbfuY4yf2JkObw7kvG+YD5Xd
X-Received: by 2002:a05:6000:230c:b0:475:f100:3607 with SMTP id
 ffacd0b85a97d-47fb1ee72ccmr9567614f8f.54.1785341367986; Wed, 29 Jul 2026
 09:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-3-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-3-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:39:16 +0530
X-Gm-Features: AUfX_my5C6bC1gg8YQo_QEqDM5Cr5_eRkLpJTSlYIaDahaeJGjleoyTTh0Bt330
Message-ID: <CAAhSdy0Bn3N+weuszLa3VX6rJHRoXRSwqEf3MZEoSJXy6=cwxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: KVM: Use unsigned int for vma_pageshift
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com> =
wrote:
>
> vma_pageshift in kvm_riscv_mmu_map() was declared short.  Use unsigned
> int, the conventional kernel type for bit widths and shift counts, in
> preparation for sharing a common struct kvm_page_fault across
> architectures.  No functional change.
>
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 943d8dc72105..d2a06a54be17 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         kvm_pfn_t hfn;
>         bool is_hugetlb;
>         bool writable;
> -       short vma_pageshift;
> +       unsigned int vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
> --
> 2.54.0
>

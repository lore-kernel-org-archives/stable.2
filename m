Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BB45C6EF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341190; cv=pass; b=tZsvhnUufXrmY1QbguFF8QKU5I65Ilf9qY4Dd10xkXZVueQ0tBjq1Gq23AIOsTVc7iJsH9DNMvlp1S6VgfFFQ53h4QCsgAWMWJ3iLcshXJcQks6I88MjrNUbCwAoFpDj9cbWZASQur64FDIlMgxQEX3LjEu8UOIW3uF465ufbNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341190; c=relaxed/simple;
	bh=OrwyfV74x4bYYJftIgMTXaC+/cQ3WeJ0wBEnzr8oB/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/D70K/sxrFdoZqqdezBKYnoAylP6cR0ZdqMftIRLBirOoytGGxWcIZRQ6J8Z9NxM66xh+XeyfMxKhLgeQpOX+y3vRvxXr87vawH1TgUw52PKjsrWCGoa6kNjuflGK0oiSHJVYwnFrHq8D37HKSRl1NcArqsKOFNt6BQIGN9z/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=AQIKyWht; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="AQIKyWht"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4957eefd361so8215605e9.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341187; cv=none;
        d=google.com; s=arc-20260327;
        b=d8wqIV5iWbl22R+Za7mdt/Y0jaghjVjE0uo5nAXOoZcmpgRSqciUri2g3n1kU092xX
         w/regMJPGLFWbatg2RNA1MmJp4bYilUGJsxneTF4TSBj4QRv+WXu1mFwjacPrjt1DbcI
         ObAw42+/h4YzK7MbR6WIIeAVG38CSTlEi9ikhXm+sHDlXYIdyzUpJTiicO9nMQ8a5tBs
         rM8d7gO18giLHU7zKHond1Tr+y8P+fTMscypYd4q9/W5tmrVsopSkxwTM1Pm+aTJrZn6
         49+MVZfmsHOqsNDe03GZ0en6arEh2Rrit69HptMsKc426HWj9Kp8P1fW1xDjDGTCImz9
         0mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        fh=RFxivujIdt8LeRq1QdwyJqEF31eobL6hnhC16ERq4KY=;
        b=FXGpHSw08V0zErNGJlc5ZWTOuDqN4u6Phw7GMRhycHwYrUl5jipzvPEoPWFtzK/Ohl
         Pg+Ll3zskuEjH9q+pOhOKfZoWeA0aPnTRDUqzxVOhtTmYqnZB47w2SCGNa/GMdj7ui6a
         7XyIZFNfqw/h/Mj5P5Gkc48wkE7JIRcXT0fvdF7mgwJvCaKSOlBXqA6+eWmx6FX+Iuig
         o9vJopEw665bag/+KL0OJew4Y7vMN1hpdWiE8gddTdulVy+bRQdz7yOcjgC9EhS1xsNO
         i8KSvjGUN/QjX+PKh1AV9BvLcjneRWG0k7PQnn/HVVung5EQSiv5ZrK+iyz5qG+p0dpw
         YzFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785341187; x=1785945987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        b=AQIKyWhtCqrwkOhI16aUTnWVNuDGQ+V8I9MiU85et5TlcYpi0D8Nl8hThfcf/JwzHt
         dC56g4GWa9IFFO0ixLNjc8wQ6VUw81j5aWmzYExU14EYLNfAFxTtryNfPIpXRk0l0l0C
         yo8EltW5nocE1d1ecXCJzQZsH3+iN7z745jKi/JWhzPsb2dQ7TL9LujnXBMQt3ywZXJr
         6aMkC6DgvERAkHrHvboq8FqBXelc9+dH3vwaxMvzMq3TroxJjCQI4B9x+q3KkKvoStzr
         b06VStPDMmqckRBKSnJmCgN9tdfcOAhY2UfFrEXNVfPuu6iWvwnFgNWQ2fdoey7fjNVd
         GKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341187; x=1785945987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        b=l/9Cy/YpB6VX8JzaZLq8vQgkRRCJCnePDb9Foz/oPpJvpW/ES0XFt/78HPmwC/V3Cn
         w6qaDf7AJOZgulA4R5AnDdWNySDPT7KdqjZXOXjKq2tOIhe+aaDDL2S/mLCHLijx8SYT
         sDe2HuYf/P6sJjPztC3iHM1DMNF5CaF+3mA4potH+9umFQ9gbydfhSZXfbmLelEbWiIc
         PBuOamJj3d3or+NJMCNQlxBQ24ouEBOw/tqhk7upgSb2a3pygeoDbPRC/55VmHk4XeGP
         QtZZmBZBTG8hdMjRg2c9CwRchsWGYJNRT3l+zIz+P42N0qJ4lbO3CX+UBOkRkDOBEEF9
         AvqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYUrIDmEfr0nWfBUsTWanCLhcbm5ITJCBvwaq5UdM4QozFDNizbTgMcNIW78PcQZy1b1K9MaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKBkEcKPB+1ImovOLEuotM/1F6tgO3B0p3iJgWqd82YPl6ea2
	JHgkz5/Fq1eKjGGC2agHsqfKghZ/xh7aSc2h8hEkuXrN/oC0G0Qk++YtlTqFtcLeBWBqTT/lYy8
	QkdB/UdMxJ8AvB8wWUcNrA6UVyya4gIbzE9rUZfUlXQ==
X-Gm-Gg: AR+sD13udiFBfShX1cQI4JizS+3sKGsVhRZmHyjXhJmLH7fED9EJfOaYmWqlFsYkXPJ
	66IyLVuxhZQwNTCoBVTTGC1CfxahVLybeWsdLv2n/HOKh4JiyQXQGCx48KocLbRujjtUcwJUkni
	fqyXWJjZUcBBgBQ+TubFdlKjyr7Etk/mgJZ82vpHiKa0CVz9clGdrygpEpzY5CuxdyF4Mk7aocX
	o6bzz5ZsY8TSHyLUFjYpkGV+x5yx6Qh7airxj8WBTDhK+tu61JMz18cIB8k8qITdsiWr2TYPR5N
	Ek2PnCnyUVVomWFvMsZNlhfRd/ljZQbgazvBAZQjukNOyia7l5lF1BOO9+2ks/eH6sJlWhND0zq
	8yJhUbddmaDLN3MPLe9igE+4cNnyvO8H00yV/mu0rytYgNX3zyzPhp0/h6QvVM4KK
X-Received: by 2002:a05:600c:8b2e:b0:495:6e68:39bd with SMTP id
 5b1f17b1804b1-496c6597a0fmr96285485e9.28.1785341186425; Wed, 29 Jul 2026
 09:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-2-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-2-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:36:14 +0530
X-Gm-Features: AUfX_mwiSOUOFP2TPHe4Inq1CQye-PgTV4ubVFK-FDwozFalkW3VgzVL7PEKoxM
Message-ID: <CAAhSdy3ziS_1iiUjC5HSVqX9iMgckyS7Yro=xwZyomxXC=MC7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] RISC-V: KVM: Treat -EEXIST from G-stage map as success
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
> When a concurrent vCPU installs the same G-stage mapping while we are
> waiting for mmu_lock, kvm_riscv_gstage_map_page() returns -EEXIST.
> This is not an error -- the page is correctly mapped and the faulting
> vCPU can simply retry the guest instruction -- but KVM was treating it
> as one: printing "Failed to map in G-stage" to dmesg and propagating
> -EEXIST all the way to userspace.

The kvm_riscv_gstage_map_page() return -EEXIST only when a leaf-PTE
of higher-order already exists. It does not return error when leaf-PTE at
same level already exists so this is an invalid fix.

Regards,
Anup

>
> Align RISC-V with x86 and arm64, which already swallow -EEXIST in
> their respective fault handlers.  This also lets kvm_release_faultin_page=
()
> drop its "ret && ret !=3D -EEXIST" special case: with ret normalized to 0
> the regular release path is correct.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
> ---
>  arch/riscv/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216..943d8dc72105 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>                                                 vma_pagesize, true, true,=
 out_map);
>         }
>
> -       if (ret)
> +       if (ret =3D=3D -EEXIST)
> +               ret =3D 0;
> +       else if (ret)
>                 kvm_err("Failed to map in G-stage\n");
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, ret && ret !=3D -EEXIST, writ=
able);
> +       kvm_release_faultin_page(kvm, page, ret, writable);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
> --
> 2.54.0
>

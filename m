Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177535F5ED
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362860; cv=pass; b=umD3Opzx8D+qfVrQgQGDeZOvxBH3x4fF8SnY+y3Zrm6Tu7Gw5vlmx4ajUvtgFdgdh89jrz0XV6E7EsCUDppbRXKCDEj+YjFVv+j2HHl2PMK/u0w7jofdIefn4P7NQB7Kqly5xdiKDhwVXwXeXTnpe3ibtKofTIBRj/xevNeUYZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362860; c=relaxed/simple;
	bh=txys08ETjEf856Lf5y0MJ/SEqvDMNnRTDlYpklG067o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK7eMIYoGJH6yIh/7dhl21+JemidcGzRKzyHWHmLf7iV6vjydBiuJtlAnda7TRqmoPTby9jjY4tbctSUqNeMAG7rYY/7a990lN4wpBOhisY7u7BgLP38fuHQpQQUUYuE5CT3xm/hampnThEv588duQfaMrIyL+UAd5wle2k/BOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=Aj2lb8zs; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="Aj2lb8zs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so14103715e9.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789362855; cv=none;
        d=google.com; s=arc-20260327;
        b=ivdZffweudhbCc2xAHGlYwnG1ZwLLj2MRJnIGt/bUGRXij26lGrpzlhusHgrnq1qz2
         XZR12SvIiEpauLE8PKCxD2ZF345h6Gzlp8CaVx+CL7+S2x8qZ7hiKtom97GsxUuoqwQV
         yo9clSRjar9XY4feiOfwmf2SohE9OjrMp+IdKej2viDWrrf8qQ73+qctlgBgKdfbAeY4
         HEVOJ2amxGliq4tpuqdsVlkw2fU3nQzLR1+qk9sMa+RG7yN9auTfDkQudFDXd4fIS+UA
         yA++Z5oBUf2parB/faPgFiFCl/mUpmq+hT71eFu/t5T4yHXkxHk0r3ANBNu5oIgfsIlP
         hxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        fh=vt7XnT852++2G129pvPvp8gSEd4/TqSViL+Fkzxf0ak=;
        b=qCEgGv4w6ZuDZIdQAH0jkF8XPRiaw3l9ATQO1otHMLSznFgfBwX5UA0Y0asjvV4u0g
         K10cZsW7pMT7RLTaRRd3c/UnRMwtZpju5u7rJy478btLgIUk1kOdH/ZvI6Gx9iHZ6o1i
         rCLZ0wsKh3oWV/wOtsGTgrb26b/Gx21GNKikz7np0KmhT5DOdOgYwT7FuwQkjIazcdbK
         y1jZ8XjobyZSgaNkbJpF6Sl1vl7wMqM98MBfeDp3BrV3GFHtCtpwA6+Y5IuE4nDCenDw
         PN1IMBs0YTiBtxtIX4NAm8yDgySBGoNDJ+xeeOCokBKJgLrDydpHHv6bUCyQTV8S8AZn
         LEsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789362855; x=1789967655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        b=Aj2lb8zsdf0cKJmeb9ML8/3uaFZZ4C4nhc9SHY7Dj7yGCkAOVVWFnAEvxzLFB3Iolr
         yHEK6u06hqAuiwsfoEuY4ESPeNCNnzalH6jp372nEJppgpcKfEI3vqRpeEqGovkQJ4oj
         8ijz2GRWLdHptVVpzKKIuShSOEzafS2oSJ0TiXClHCvOp7YpNvMVFKrx3YBJuQ1tZYFl
         D4MMbyFqVYDQpiSgEN5XOrDEU6uHUegvRsVyo8r/lkebdOLxqSCn3hgNT+fM+3yWGxT9
         854Cps9XIpLDpZ6+ByZWF6zK3FvBb29Zw7ju73cfOtmWjNbPRAmQzQbjfJbqrgbsyf8X
         doRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362855; x=1789967655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        b=kuz6zKjnevNy0ljTbtYNKyR4WFeV3+AOL1cUOaOcE0bW47EDFfluyIFCi0B5E3ThKt
         eic9wZ1pQehnVB4t5KndPTmBk+z6gPOmxIVnDl5BuAl5/6kLZD7WBpgk7Jcu+lIr256Z
         KQSeUTxe9JiS7V1tK8jO6LFisd/DF/VuJvj3np8x3PkvQM+R733nSz3z5rl4Fb9dzF1M
         OrLVzInqn00OzHDYKR+uWbjufVTzeLYYRg7IDsdffHdUcljAow0Mo6Oins5zh4eL29Zc
         ZdxUxMLiXJK3wg34Hs4BdADZH0iMv/Dgu1SsWp6u7HwOpodPm4gNCltU7LmzpyqQ6GZB
         r4qg==
X-Forwarded-Encrypted: i=1; AKwUvBwYRUv0Ja/F/3yi7G2d/NowsuTDqKSfOlMQzEBjXtfhQw/robMX/fup8nDvBxpoVvg7e/VLbv4=@vger.kernel.org
X-Gm-Message-State: AFuF++k4yFIjjqDRgrxu0/bF3Qy1q6Cc8eQ20/WHc8zbqdJDZz9ouepK
	i0PnGXnddtxYx14GDwg4URhL5S7u2mmxx3OSVOLhnzo8Syzf5586Kmh9XbBKpMGbP0ClGAKCcCB
	SAwxVuFczJPo9iDe3Az1ZF4jm2j9tE5PG8kClKH+5zA==
X-Gm-Gg: AYBFou3kzG3B7CZoZbhirk3qpxj60kQYnfXnNBxC+7FbRx7OkndwJ6FF++r2ZE+t0jJ
	3v72u/a7D3w5ajJOjNrsM2XmQwpkuYKP/Dn4HDzIAfr6AES3qC0aykAiMo6A68a7su7mMQHQNuj
	FCb/Ip3sxkBKCZGe4aob+gyoVhZbCtrordWyJSWUdV0d5BsVLwqS7bQifuqMT8BAIdm6ZRNQ/r3
	7cDIokcaQpoHWS7bQsKwq/TcFgjNG/CKAA/d/z0jk/NC+K5SweO8T2rbSbcysomWryJPUKz7qrj
	psTaZg1Wq0KLOeRcSRHrIgRESW9ATNwwXzlPv5bTu7uwnk9E/UYTwbIgBDlNHK9u6HbVGC3ie9u
	ujCBxeydjRmq9rGT1rVZ/W1GU5cMy+UrWeXJNcvpUP8lGUDFAP+DZHocLP4JTDs3oWhbP8CLlhA
	==
X-Received: by 2002:a05:600c:19c9:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49e7a678d7dmr8979885e9.26.1789362855198; Sun, 13 Sep 2026
 22:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914031146.446157-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20260914031146.446157-1-tanchi25@mails.ucas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 14 Sep 2026 10:44:04 +0530
X-Gm-Features: AcwNN1Xv9Q24Kz2JNPc5ElbJduPG-W_3pjLhuvmorF4ZD7AGszu1UnXv2VgFblg
Message-ID: <CAAhSdy3m8iBXiJF_=syKKm-JYpW3ou8P4FpWNB0_a-t+_dTuAg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix HSM hart status error propagation
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 8:42=E2=80=AFAM Tan Chi <tanchi25@mails.ucas.ac.cn>=
 wrote:
>
> kvm_sbi_hsm_vcpu_get_status() returns SBI_ERR_INVALID_PARAM when
> the requested hart does not exist. However, the HART_STATUS case
> returns from the SBI handler without storing this error in
> retdata->err_val.
>
> As a result, a guest querying the status of a non-existent hart
> observes SBI_SUCCESS instead of SBI_ERR_INVALID_PARAM.
>
> Use the common SBI error handling path for HART_STATUS after
> saving a valid hart state in retdata->out_val. This preserves
> the returned error when kvm_sbi_hsm_vcpu_get_status() fails.
>
> Fixes: bae0dfd74e01 ("RISC-V: KVM: Modify SBI extension handler to return=
 SBI error code")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>

Good catch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.=
c
> index f26207f84bab..06a15629c26b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -95,9 +95,9 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 ret =3D kvm_sbi_hsm_vcpu_get_status(vcpu);
>                 if (ret >=3D 0) {
>                         retdata->out_val =3D ret;
> -                       retdata->err_val =3D 0;
> +                       ret =3D 0;
>                 }
> -               return 0;
> +               break;
>         case SBI_EXT_HSM_HART_SUSPEND:
>                 switch (lower_32_bits(cp->a0)) {
>                 case SBI_HSM_SUSPEND_RET_DEFAULT:
>
> base-commit: df2908090cda368b01ff43709f51890076c56157
> --
> 2.53.0
>

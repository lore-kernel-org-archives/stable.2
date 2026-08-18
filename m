Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA247DD51
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071349; cv=pass; b=CECM9S5b7T9zhs/yC8cbGyHSpoccLJ9Af+fnTTU0G0LCQ3DQLe2/620zibaCPDbMEGdwuEsSxlAwcF6W+dvVb3MW33sVQPQVg8del+IlQklk11Kk3EB8FG/+DMQ5GUNEEEjAeP4DBvf3mMZcd2EV7VqseZphtIjtIwlSV1iZz1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071349; c=relaxed/simple;
	bh=jOe/Qgt4xrTB740jyMnCQA6XR47zjyEenVDyBo7Zhk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+plSDdDbCRXosVMVl7HchPrwATzZNDciLjMhIvsT3px0JB9wyH+j/SGKx7K4tz2ZitVXxJ7hyC/pp3IcsYBmKjcsKURsMm+P9h8MvBtyRKcq5/yIRD7HlY39LTfgHaQ1tePM7xyv6ZXqYkdMu7HYTkCHk7tGuC7s1n5tVZcYXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuYk0qcY; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuYk0qcY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so490217866b.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787071345; cv=none;
        d=google.com; s=arc-20260327;
        b=js4B1m+4AQaXX0nbobxRSBA4HVaXOuno6Pr7dglPC8os9cugIEMgsw4XEmvZ++gIex
         7tycHUO2VZZew9ypqCWuci3Z+4YRc/YgMi+uQNMibn8mfljQbgpMJZC1nEJlykbjbv2S
         al4NOAruZp+lt2G1g/rdl8NcLWQKKGkvFt+Xt/nUFEZMXdkLxmVqiriNzZ64VpdT2fV6
         YoBNOOvzkaYytxrtxC8V5zrbSh1TwUqJu4svFhe26DnVzfQtJh2goqDfmoAOPxMgyi5b
         7LcCzJ0hOSSRrPUlVTIid4rY2e+vhBGYuJIVu8A1PGOHKbgJgaMR3RTHiK68H9p2Etxn
         +vIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C1LqKy0ru7P4gjurmwOxAwwAQ13L5hLvH14rjfrn234=;
        fh=80WpxmxdiH2uxFbi/zoAeua6GcAySBOdA0gGlXicRtY=;
        b=rKHD9jVQmyErTMqzSiWlp4FUVcyosM1h+gE4Ct7w3U1fCkXntE7y+dVcYkBKiPDdfy
         ySymw2PgitPv4RrGBUCc8ftrEsPbQ+3ZW9s5lgAb8EW0QQKZEpiY37NCgqHUVfXagqsC
         0kZ0tWkl/vvLnEQVtCWwabrU8tn9AUDoFkFT685aSZLn0qSPWk5zlRTAYSauYDJBmb2E
         zQjnDKNjcjcev9NM1uh8u2JTi1hAgdb9lpR2vuCQByrb5mjw2U8aL1boa2f0Ripqe8R1
         sDRzC0RDSqnC10W09GUTIngDl991mom4oTQ7dmkkkJskC6k8gLAakNNEwXHlZq7etJB6
         hrfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787071345; x=1787676145; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1LqKy0ru7P4gjurmwOxAwwAQ13L5hLvH14rjfrn234=;
        b=YuYk0qcYp+B9Da9akzhGyBvG2mwKu0oPcbyR+lAN3uqA9ustGgs81phGUHsFIOdNC4
         zemkPkWxLyATn4kfUk6YVzoDclod3dJcdKJ8GLIpzSbSVfZ1z4oumMIATu+1F5Kvxim5
         /J+dxgRX9DDUYiueXjwyavosbr2WWQ9LFyO1zPV4J8MxnKbPmG/LcMAFxKwdQASu0t6u
         rcBzFPivg8Vq1xrpjn2OvX9Ub3RO3q3rHkgDuDc03DXbN5pGpB3YSZCh9lR87Ag0Qwgc
         PoHNNGyQNhiuP5jsHSmq7AyG4w5ZXiRlPLeTixxuyP0Syptl7gRUY+0afUESaqEnZ/9Q
         mbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071345; x=1787676145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1LqKy0ru7P4gjurmwOxAwwAQ13L5hLvH14rjfrn234=;
        b=XjxA0sZo+D9yM56OqJ6C4H/T5zs0zCnwKebpckfCj+KuL8r7Xbf3TAhUld4BA6Qca3
         rPGtxihHFfFMZcpc4jFo9rNmMZyyBwSsSXTNKicN7aWBORtrsMtS4mxiTBBicq/grFKQ
         lmCThTRYZV8k4jVfZH/Ub0Ly1FMOBrnrchBNh1r7eMXbtSLXIuYR9jINI9CdNRht8ovi
         ftnQ/8Gs6ANB7qvHAmdaJsqK9MJ3az4kF9KLjo7eyiB0iOIs7fsaXFnd1g1/sKtCEIgn
         24VPgpnP3LBaH+wWLCGiCFYgwLZy5aNOsSp/aJ9FkaPJsSdOc+ncpSmtUbpDMO6bq4v8
         1odA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0XDwiRyI5fy27eCAXzSrIXUY179nHsz5AgDb2pJcATW45a0iDBd0zT6S7M1hcbCiMu9XFxfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymoo7JpZECSjGHzY7dRxbR18+aR65Yxb7/xbdIzEE7QT2L3Nyi
	AXTN5q2G18Km+mA+9VyX2wjTxkjku4BxMUKQaN8BA5Og2hZGHdZFUQ53ZOLhmkR7S5hknh1LzE7
	8a/KVSzkWYihgOuF4HNmyEexM9M0vXgVBXoASo1dG9g==
X-Gm-Gg: AR+sD12lLn2tlqwBGv/GaZgrc/+Ff3IkyIkj2AdXIeBYPaNdq3OEIcObOGNLSu9DTD9
	3bHlYAv8pbm/iY9zlk+74jQzZ8uIrxuFWU2nNkV51KxbsmlgNhOpL7qs0fphO2MoaYnsRLu9oIm
	ZD9ARWSS9HnoeHn6jAfiwcSU+eZFzXKcf33OUut68OlLzUjXFSs9uFUZ3UlZdjrTMcQv+cPtuK6
	dzPSET2kQY54cEj5jDBjAwfd+InYniMeV+139FJWPYCKNvAcaF3zdmSj7+FDgPDNpLu3tY54U0n
	SvorxtzZYqvbIvcFJS0lkehI/HFtD1x32K+sGmiYjnn+RddhWTuYkiP/CH/pjIwcQldl2wR8kq4
	uTiI=
X-Received: by 2002:a17:907:934a:b0:c15:deea:a178 with SMTP id
 a640c23a62f3a-c212a33b977mr1431132566b.25.1787071345467; Tue, 18 Aug 2026
 09:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724025322.2341205-1-sammiee5311@gmail.com>
In-Reply-To: <20260724025322.2341205-1-sammiee5311@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 18 Aug 2026 10:42:13 -0600
X-Gm-Features: AcwNN1W6syuqo9XFENbuqu8SdO9PAKceH7Oqq3zh7WyLsaBRbVXAC33BZH8edaI
Message-ID: <CANLsYkz+h6ONmvhgdfGLNu21J+LrMSySFw9sxRcR4ZxLwPfbsg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: elf_loader: bound the section header table
To: HyeongJun An <sammiee5311@gmail.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good day,

On Thu, 23 Jul 2026 at 20:53, HyeongJun An <sammiee5311@gmail.com> wrote:
>
> The rproc_elf_sanity_check() only checks the image is big enough to hold
> one section header. But find_table() walks e_shnum of them, and first
> dereferences the header at e_shstrndx to locate the section name table.
> Both fields are u16 and both come from the image, so an e_shstrndx of
> 65535 reads about 4 MB past the buffer.
>
> The commit 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read
> past the ELF header") added the same check to the MDT loader, and says
> the header "is sanitized beforehand" under remoteproc. That is what this
> patch makes true.
>
> Check e_shoff against the image size first, so the two bounds can use
> size_add() without an e_shoff above SIZE_MAX wrapping on 32-bit. The
> bounds are separate because e_shnum may be zero while find_table() still
> reads the e_shstrndx header.
>
> Fixes: 400e64df6b23 ("remoteproc: add framework for controlling remote processors")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 94177e416047..da3cddbe7d4c 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -46,8 +46,9 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>         struct elf32_hdr *ehdr;
>         u32 elf_shdr_get_size;
>         u64 phoff, shoff;
> +       size_t shend;
>         char class;
> -       u16 phnum;
> +       u16 phnum, shnum, shstrndx;
>
>         if (!fw) {
>                 dev_err(dev, "failed to load %s\n", name);
> @@ -90,9 +91,27 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>         phoff = elf_hdr_get_e_phoff(class, fw->data);
>         shoff = elf_hdr_get_e_shoff(class, fw->data);
>         phnum =  elf_hdr_get_e_phnum(class, fw->data);
> +       shnum = elf_hdr_get_e_shnum(class, fw->data);
> +       shstrndx = elf_hdr_get_e_shstrndx(class, fw->data);
>         elf_shdr_get_size = elf_size_of_shdr(class);
>
> -       if (fw->size < shoff + elf_shdr_get_size) {
> +       /* keeps shoff in size_t range for the two bounds below */
> +       if (shoff > fw->size) {
> +               dev_err(dev, "Section header table is out of bounds\n");
> +               return -EINVAL;
> +       }
> +
> +       if (shnum) {
> +               shend = size_add(size_mul(elf_shdr_get_size, shnum), shoff);
> +               if (shend > fw->size) {
> +                       dev_err(dev, "Section headers are out of bounds\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       /* find_table() reads the header at shstrndx even with no sections */

Right, but if there is no sections, @shnum in find_tables is 0 and not
arm is done.

> +       shend = size_add(size_mul(elf_shdr_get_size, (size_t)shstrndx + 1), shoff);

Why the shstrndx + 1?

Also, there is no point in doing this check if @shnum is 0.  Please
move this block in the "if (shnum)".

Thanks,
Mathieu

> +       if (shend > fw->size) {
>                 dev_err(dev, "Image is too small\n");
>                 return -EINVAL;
>         }
> --
> 2.43.0
>

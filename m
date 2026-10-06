Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD0421257
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294985; cv=pass; b=k66PImb1f0kkHe+BMfdUNMB+moLXXKqD2P8rTxHKj0kOVaM2JbI/erhZP1PUgj+0uoO3gbft8WIwgppnXXMuOyNWAos7+B5kIu2YOSPF9rcnTgDApWwpJLZKsMnKWch+HAr5hfK5Sp7s4sHepHHbcKP/xCGiVo3YzAeASUb1GH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294985; c=relaxed/simple;
	bh=vbRT6nGrsubTAfIz8i+mXocImBW/c25hWjByl3J0uow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWCfaGmM+lfTv31e+nRNzH6ityEJJGkXw1eG6w+BYoBHgR381RUVGr0nx70DbmvkGruv1gV5R+67id3gyIuP2dY2tOReRFuGd0vRp6ia9RhNvJnRTsfhKV9BZXnMQXGmnqHeSQwjA6qthL3nEYte07Um+6woZi6MDyLeRI5txxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWgLPtGB; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWgLPtGB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab395abf79so6550627b3.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791294983; cv=none;
        d=google.com; s=arc-20260327;
        b=T/RAwifAiznMfOkKR/HwKyGyVYDSsdiR1uMJlVVWvKmHLKjbNh07xYsVZeBAVyvaXC
         gjQP9wJmXrjxrh4JcBQeLKgapPYirgwIcIS+ITsSDKJBBodhTu6FN2CEpXwtFEF5TKQK
         PpSHo7Ut+d7vEa7KiSch/IzJQre6TKucU7wJvBApYhOYGy0BCEIZ8cD+ryzdPSJCRuLD
         5i4OhdQhcrdfuq0dMMsDkjz4uZ0wH6v18j4RMoVt9pycYX1zIDS0oxZEHk+Vrh12fxG5
         obsY0+f72I1QDZNcy8vx9UObNnSUGsrId6mnfXct9J8ua150SQcJTwLCgvn5Qa+AwNcy
         Mtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ydu+elXchGUSJ74vhM8S5kQyLVRWEBSg2Ux9RtIawfA=;
        fh=A8wOE0UN1F1m18Q/esF1EucgrmuubuRYwqcQvkIl92c=;
        b=r9PMezHh3EW5cXXQz4qZ2TKp9nJmvt1+MhjK3+KhtpgpjK48t2U4fTIDAq4anZnRRy
         aBh2SegvjIjcu2XCcQKuz8ATPP5DoZfWv/hlGMreZTR814PUx5spVkB5pvyNKn0A+nbV
         ABZqidYY/TyUBNn8DyVVIaDiIoH89lcUvCN0LehFaQw6gM6J9qfLyq36dpjjQ3yXutH6
         coZWm1kd8SVc86y/krmzjKWW0Q1P84AyXPcasJ1LIM1qBd2d8p2+8ei8yflQm4qcUiON
         dpBY8mkUFrM+ApReFjUc4wnRW0n/uPjv/aWb8II/gJvMRz92s4S0HQAW1qn+Gc6phLMf
         LP9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791294983; x=1791899783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ydu+elXchGUSJ74vhM8S5kQyLVRWEBSg2Ux9RtIawfA=;
        b=cWgLPtGBzwiMGY7rSfq1+75nRh7jC1WaWBuDb3BmTWJ7TOy4fooiVn/lUKmS/jjYwk
         6xu7C98s1Hj5wx1BLMMcFdyyj24nFSfrg2FO/A6X8jHJYE9jjryIUalWec9aLjx1TtLa
         BINRcixxzps2M5S82NcOnt1xrfHunRXh+VmOBaK0VcUGWFDT5T17Mu7V0CN2R/C4hHyF
         l/s9Vi86QZewK2K/NunDGkCv9h4J9N8wXV6u7JaqgT6Ay6qoLMlm2/ul14D/y3Qr67Qm
         tDHcdgJGHTxpyrNa1OtWu6HkPd9a8+2hVWRrO+Uv9wbrXQpZ48rXQjL4Sb+CmeXINIFT
         EKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294983; x=1791899783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydu+elXchGUSJ74vhM8S5kQyLVRWEBSg2Ux9RtIawfA=;
        b=v5YqGAxHfxbd3otPZMe3Vz71UE2fUmTFi38q+sdF7bn5nUOXgj6u98WHeGCR9KRHY4
         stvpImp8q+lI2D4kaaNDBDZv2mG0d5iNHgtabuwk1CvS4yUuyIimQFuDh6F8hsQOfKVy
         jm996OmcVIZBALn25+bFVQjXpscYFndLDyE+Yr56PCA/hv2D30ZmOwSnvRqf3ul7qVwN
         RVVQ1xeblgxN9wJnvB9VCd4GYGuNuVHjFYIsF93VJyxQ/z5a3pDC+mbg+3oKw5i65y9N
         I9vQnRXKXaWHpwaoulAnRlyvW6sKjTbNKcKytfNKiEJ2Jos8JZp5UUnm+L2lHCq1d4qw
         aWFA==
X-Forwarded-Encrypted: i=1; AKwUvBz9zTOyLBnEi8w6dFBNYn6CtOUEVUCvBHG1PtWASCa2Aq1tESfjRwELpPAiYRXWqWmw9PtTkJg=@vger.kernel.org
X-Gm-Message-State: AFuF++lwCK+pOcKb2Z1YDIbS9NA6CtoJnDFPTeXEtqh5T3psGtjnKOQY
	6wM8UMXHgk1U/yL5B809EQ3nHV5LB8Mp/kiapY/+N7vGSTckJ37DPAxePwa2kuUhaOgd0wn0TnB
	+tUtbiD5sc7qK2Yr1rnY3dU64aX/upcM=
X-Gm-Gg: AYBFou2kWsp5PkygqfaokeCI98ztradejZyBj7gBW7yQowE4wuFHUl2Juv2OE8bh/+x
	EQw01eoeOo1mh9+0L4PBP+MbQ3ec8d/b3sDEK7wdYDQyTN7ftehSrevEWQhvTFdGfo0n9ANuspZ
	tT72INfNeG5sDyQ4R/SlLcONohntxR1YgwEmzy6ioCoguOGRpRGY3JskXn4qurFk5cgHWt0QBC/
	4oKgSWLbOtEC9I/I3Kr9ebZiMJKYXuGeUacRU5oBo5h9BqFUJP74mp37HX/1AtS2yC6lDpIgJNN
	7f1UWtdMzW2nU3+8rJT9/yc5WsZBCNakhTGXba6Jhngn5bKO6r9ztz5+/AJmYeDwiFJgDq6Ef6A
	RDcp4jfkVUDRo4bL5ik4XVUdaWli3T9GCnSC+8XI=
X-Received: by 2002:a05:690c:c50f:b0:8ae:7fb9:8cc4 with SMTP id
 00721157ae682-8b04f4d8cefmr7480477b3.33.1791294982904; Tue, 06 Oct 2026
 06:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005041457.3021139-1-ravindra@intel.com> <20261006095628.384343-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20261006095628.384343-1-runyu.xiao@seu.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Oct 2026 09:56:10 -0400
X-Gm-Features: AclHuK-jEawYK6Z4T-kBMGawZzjTV2I3SyCTjKA6Wuad8-SZxYRE9_EtvKz7ESg
Message-ID: <CABBYNZJsiNbgRsknuxYHJG-bX3s5mim6tiP-29LdzuaO_PS=CQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: use managed IRQ teardown
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ravindra <ravindra@intel.com>, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Runyu,

On Tue, Oct 6, 2026 at 5:56=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> w=
rote:
>
> The PCIe driver registers its MSI-X handlers with
> devm_request_threaded_irq(), but remove() uses free_irq() directly. The
> devres actions then retain registrations and attempt to release them agai=
n
> during device cleanup.
>
> Use devm_free_irq() for the remove path and for already registered vector=
s
> when a later setup request fails. This removes the managed resource at th=
e
> same time as the IRQ is released and keeps MSI-X vector teardown ordered
> after IRQ ownership is gone.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Cc: stable@vger.kernel.org
> Tested-by: Ravindra <ravindra@intel.com>
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> Changes in v2:
> - Add Ravindra's Tested-by tag.

v1 has already been applied.

>
>  drivers/bluetooth/btintel_pcie.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 005c77a4f..f8901df7c 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1750,7 +1750,7 @@ static irqreturn_t btintel_pcie_irq_msix_handler(in=
t irq, void *dev_id)
>  static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
>  {
>         int err;
> -       int num_irqs, i;
> +       int num_irqs, i, j;
>
>         for (i =3D 0; i < BTINTEL_PCIE_MSIX_VEC_MAX; i++)
>                 data->msix_entries[i].entry =3D i;
> @@ -1779,6 +1779,10 @@ static int btintel_pcie_setup_irq(struct btintel_p=
cie_data *data)
>                                                 KBUILD_MODNAME,
>                                                 msix_entry);
>                 if (err) {
> +                       for (j =3D 0; j < i; j++)
> +                               devm_free_irq(&data->pdev->dev,
> +                                             data->msix_entries[j].vecto=
r,
> +                                             &data->msix_entries[j]);
>                         pci_free_irq_vectors(data->pdev);
>                         data->alloc_vecs =3D 0;
>                         return err;
> @@ -3101,7 +3105,7 @@ static void btintel_pcie_remove(struct pci_dev *pde=
v)
>                 struct msix_entry *msix_entry;
>
>                 msix_entry =3D &data->msix_entries[i];
> -               free_irq(msix_entry->vector, msix_entry);
> +               devm_free_irq(&pdev->dev, msix_entry->vector, msix_entry)=
;
>         }
>
>         pci_free_irq_vectors(pdev);
> --
> 2.34.1



--=20
Luiz Augusto von Dentz

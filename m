Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827C4028C4
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493389; cv=pass; b=F2NKRNQHj6CXkaiCtUnX64p1ZCfdPW6UrK0sgT2KhfZ/2lV1KosmnmJ1pAkJMPEWKhXCCOqmDHjAnPJMPRv1uhe6mEPw3RENUsfRs7R1gB0W4aujIJFpMrZALnCyn1P68NHXGxLSAvT10Y9dvXjb9PPdo3BI4m29L+/9bb/eSzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493389; c=relaxed/simple;
	bh=sVq64p+ed8U5wY6zQYm0z4iQZCflWAgAFn5l6JcNE44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLIUtO2HDvL3FTQiNYv5r/igwh09/Qd26UI2oHbqa5yiD3GL9p6T0vOpdYMCs3B57Jrlg2lypBLvFO0JHP2VClXGoLGkObTqHgoxe6yTXbHn6czQQMtpjbH0ZsDBuWObh5V6ff0hnDnrXdUvh4eD4F9kVPpQiBZb3jysgYLEe3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3XBysA3; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3XBysA3"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-781d5f20ed2so172687137.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493386; cv=none;
        d=google.com; s=arc-20260327;
        b=RS0YMjEL1AQOr5lMUsvPHIoWNzHZ+Ptk6pXvG+B83PCEDLqtKIDPayqNPDmggXCGOD
         wwlTS3KMKcJUmIatsIPyXU1OvrHRYxnDBKSg6Xciknj0Iqrdf6ZRJNwIKsKoLMPDXGMp
         3FJ8mRVbOpVfim2tE8g4/UsshbHForQ9v5DFaaB9E2x84QZYgW9f/P4l8tQKAL+Z3jDV
         U00pW9aDyfZ5A9LtGwXcAvV+FozxSYMsKsjkZAwOoMgINOXq0ilqo4UzSNNKyFKF2NYU
         9Dogv+65tiUBWaNsf24noKnkqx7vvkMGH3ZNZU2jp/8CgTW2KFWhKtFzvgOiFMFQRvcu
         0ODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
        fh=eqsoh3+7YRyLLfElrs9w50plIQ2HKiXA6SkK3pdzgDo=;
        b=X/rE8738Y3D68vNp0DeMWOj4VwOvdlN43K2wU/1u/0SeH4n8d2a+8bJQs4Ye8uSWLR
         pFe7BhkUxJMdtUj+fdYnWoFgNVC01JRhxBx/9RYoX+syOCTA6lliaQwgaEkgsk/sHCBp
         X5bzlMP9bW72WVnzWx82YOsOEWEBhzwxXuCi7UUvJ7IvGRapXV48CnUSkaC3j9y0s6Lr
         MtgtFDTkK3TML3LDKMUkv7X3sb8iro9NYdf6kEr+Rtbo7iYFBw7mN/601nsN3/pqX4rC
         PmCQeng4LV5MiAeOrcBq2pdA3WAYvhR7Mq26hzUEA0tnScsQh/MYBvwxJd1ggXboHapO
         2ZqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493386; x=1790098186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
        b=p3XBysA3fS+dSv/BGI3UNhRtHdDSr9atOw3vZUdEXf2C4ZEr/n1iG9/Oiky0CH44CN
         e7SiWsJ/YqcuWmBx2gcRhS2bvi14v6NeFrby52hazyi0yJ/H04eK1cJm8DT7fE0+Ac1/
         MZ8VqKJmJBfWei2xrJvpxhC/Pc2BFk2hSiQe0vUT3M5Dc3IbBxoyBnKa54GKhXmNUSNd
         HJNLq49dfuzaFM3DXZUb5ky4VlrJJvIrEsyWpeGebZWLfOGbOqmzewXsy+SEA3L3eIS5
         rbGW1g4gJHMoiBipkfzyTart0kcRSXMGUG1xIrQAZgn0tQIPCSLtRqwa4tGXiDA5O6U1
         bH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493386; x=1790098186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
        b=PbPN8jxEMG4aH5dmIqQZ3idghIWSwO2628jky175mhbpt8DJKq1XPQi6qrGqaiEb3d
         jIkHjEjrpoowUvsVDJ97E9u3FYtTWs8BBki3Z/twqImHBCWT9r1XMXHFoqQUnmiS4XdL
         MOYtzZ0+4yVDtrB742Z9jxeACxLRaWscbOUgGQiKxhi/RPc4ZdOIO0P2yajkB+IyarDz
         xM2hLzHccOCHZsxshku/HC1JJtalBSn8Y4XJDE7kZHpFfMwyQGcOB6uGz9+5eWvYk0Eh
         OPq+mARkKornYhHgN6b+eVAdHX3QT/1elPaYA9MdqLa+ytt1SGtJXkHh7W4EB2D5CgtD
         BOAA==
X-Forwarded-Encrypted: i=1; AKwUvBxSA+xgUqzrI23h8HV9KzqivrXic7L4Ao2BUUXrYXtamusd5OgfjYYIqXnNe/Wr8KLjRZ9D8QU=@vger.kernel.org
X-Gm-Message-State: AFuF++kLbTMdNYeNDd7TMeeQSTGF41zeXrPBLTwGv/4fBZ6hJTqRPB0L
	yE3jztWipxe563WbHVqwjO9NqVhHY4m+OoEfyBZSupqE0xUNgkp1Fujinn9S+jGHTnNt2odQHrD
	O+3CHujyJiMriuHLGsLiXNIDqd7ky7DbxrA==
X-Gm-Gg: AYBFou2FER920YblpGO0F67O1zB0wg+r+x0APo4DCzAqeInfzHWN4IBmQBZ1dtILXQB
	C55Riyvyz632EMYwHF4mvej3yE6mo5eKNfNLeQYZpvuE9QCiPvKah940kvo+J1wKHG3oOSZJRPJ
	p0K5D0pS1Te96A+uQqLbK1pFIiamMgxVVd5AFDSulntZHCiV6PjL3CimcpMxFKaPl3cwSoHUk3E
	e9HOj7CPCHgUQCZPQgDXu2xy0elsGnCQ9sCVCprsE5eHS2DhzQ+3ShmTW5GIj3Gfqaslm6wUJXA
	G9iUNPym02URzchWtJs4/FOwLYaFXa3fcN50YEypZFNuKHNQyCIyWEttqWEbfiiUtXPL3Qx6yUp
	DMLDA1wSe0PvkSD3qLk9D8c6MjTGH93t/Iy6hEF43Q5AdO0WRsitn0w==
X-Received: by 2002:a05:6102:54a9:b0:797:bbf2:197 with SMTP id
 ada2fe7eead31-79b58c77125mr3303718137.1.1789493386428; Tue, 15 Sep 2026
 10:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160932.2118978-1-mario.limonciello@amd.com>
In-Reply-To: <20260915160932.2118978-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 13:29:33 -0400
X-Gm-Features: AcwNN1WggCnKhZSO4Q2ivnkdYn-qdPXO1O6WPVPWUs8MPC-asbPgH8ecQ9WrDuE
Message-ID: <CADnq5_PJ6vrxctfaPVUu8DomnhvY0rUWv7YfqPEb0dLsVu3STg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GPU PCIe link capability reporting
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:09=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Commit eb53125a7ad9 ("drm/amd: Add dedicated helper for
> amdgpu_device_find_parent()") made amdgpu_device_gpu_bandwidth() query
> the first device outside the dGPU. That is the host side of the
> physical link, not the GPU side.
>
> As a result, the ASIC and platform capability masks can both be based
> on the host port. drm_amdgpu_info_device then exposes the host
> capabilities to userspace, such as Gen5 x16 for a Gen4 x8 GPU.
>
> Cache both ends of the physical link during device initialization.
> Use link_dev for the GPU capability and link_partner for the platform
> capability and _PR3 detection.
>
> Reported-by: "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/CAAxE2A4VhsAzzO1QjBjUg+NgnbD04ZzM=
yN6xsUJxjKJHH6hxiw@mail.gmail.com/
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: eb53125a7ad9 ("drm/amd: Add dedicated helper for amdgpu_device_fin=
d_parent()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 ++++++++--------------
>  2 files changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 79b69d74eb2e5..3bad7b8f621cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -626,6 +626,9 @@ enum amdgpu_enforce_isolation_mode {
>  struct amdgpu_device {
>         struct device                   *dev;
>         struct pci_dev                  *pdev;
> +       /* The two ends of the physical PCIe link outside the device. */
> +       struct pci_dev                  *link_dev;
> +       struct pci_dev                  *link_partner;
>         struct drm_device               ddev;
>
>  #ifdef CONFIG_DRM_AMD_ACP
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 44091ac12fa9c..0d277516fd55e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1959,18 +1959,17 @@ static void amdgpu_uid_fini(struct amdgpu_device =
*adev)
>         adev->uid_info =3D NULL;
>  }
>
> -static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *a=
dev)
> +static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
>  {
> -       struct pci_dev *parent =3D adev->pdev;
> +       adev->link_dev =3D adev->pdev;
> +       adev->link_partner =3D pci_upstream_bridge(adev->link_dev);
>
> -       /* skip upstream/downstream switches internal to dGPU */
> -       while ((parent =3D pci_upstream_bridge(parent))) {
> -               if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> -                       continue;
> -               break;
> +       /* Skip upstream/downstream switches internal to the dGPU. */
> +       while (adev->link_partner &&
> +              adev->link_partner->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> +               adev->link_dev =3D adev->link_partner;
> +               adev->link_partner =3D pci_upstream_bridge(adev->link_dev=
);
>         }
> -
> -       return parent;
>  }
>
>  /**
> @@ -1986,7 +1985,6 @@ static struct pci_dev *amdgpu_device_find_parent(st=
ruct amdgpu_device *adev)
>  static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ip_block *ip_block;
> -       struct pci_dev *parent;
>         bool total, skip_bios, early_full_gpu_access =3D false;
>         uint32_t bios_flags;
>         int i, r;
> @@ -2082,10 +2080,9 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>             !dev_is_removable(&adev->pdev->dev))
>                 adev->flags |=3D AMD_IS_PX;
>
> -       if (!(adev->flags & AMD_IS_APU)) {
> -               parent =3D amdgpu_device_find_parent(adev);
> -               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
> -       }
> +       if (!(adev->flags & AMD_IS_APU))
> +               adev->has_pr3 =3D adev->link_partner &&
> +                       pci_pr3_present(adev->link_partner);
>
>         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D KFD_SCHED_POLICY=
_NO_HWS)
> @@ -3783,6 +3780,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         adev->shutdown =3D false;
>         adev->flags =3D flags;
> +       amdgpu_device_init_pcie_links(adev);
>
>         if (amdgpu_force_asic_type >=3D 0 && amdgpu_force_asic_type < CHI=
P_LAST)
>                 adev->asic_type =3D amdgpu_force_asic_type;
> @@ -5880,11 +5878,9 @@ static void amdgpu_device_partner_bandwidth(struct=
 amdgpu_device *adev,
>         *width =3D PCIE_LNK_WIDTH_UNKNOWN;
>
>         if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> -               struct pci_dev *parent =3D amdgpu_device_find_parent(adev=
);
> -
> -               if (parent) {
> -                       *speed =3D pcie_get_speed_cap(parent);
> -                       *width =3D pcie_get_width_cap(parent);
> +               if (adev->link_partner) {
> +                       *speed =3D pcie_get_speed_cap(adev->link_partner)=
;
> +                       *width =3D pcie_get_width_cap(adev->link_partner)=
;
>                 }
>         } else {
>                 /* use the current speeds rather than max if switching is=
 not supported */
> @@ -5906,21 +5902,11 @@ static void amdgpu_device_gpu_bandwidth(struct am=
dgpu_device *adev,
>                                         enum pci_bus_speed *speed,
>                                         enum pcie_link_width *width)
>  {
> -       struct pci_dev *parent =3D adev->pdev;
> -
>         if (!speed || !width)
>                 return;
>
> -       /* use the device itself */
> -       *speed =3D pcie_get_speed_cap(adev->pdev);
> -       *width =3D pcie_get_width_cap(adev->pdev);
> -
> -       /* use the link outside the device */
> -       parent =3D amdgpu_device_find_parent(adev);
> -       if (parent) {
> -               *speed =3D pcie_get_speed_cap(parent);
> -               *width =3D pcie_get_width_cap(parent);
> -       }
> +       *speed =3D pcie_get_speed_cap(adev->link_dev);
> +       *width =3D pcie_get_width_cap(adev->link_dev);
>  }
>
>  /**
> --
> 2.43.0
>

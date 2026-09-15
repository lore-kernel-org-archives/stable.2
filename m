Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AC4BD7A2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496735; cv=pass; b=GieFlCFFwsoDqcBuWCsYDg+By5CvI0rpU0eomiwNP16Y+EBBL/wp4ly9JLlJuBH14TBRukQ8oPSLEAE52w3MdRqxGZXTJy9EKm7r9FSP2dSA2g6bfDbjLBNibdOd6n+hCbT9h0YVM1BBLN3qPb6YTmHBp8RjNYH/E+uVUcSALHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496735; c=relaxed/simple;
	bh=ckQAILf+Ma26Z4bdDNZTiOBE/rOOC6No8hV23PBNF/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXn9F26Vz7Nn97CKCNq5D0T/qJEUwAQFsWfcfM+PbnQTG+Co6t7c28nWp7VfsWUc4nBHv3AoBYa0HoLgvrMskQSGjxBiS0qTFKaVDj6S2SK70tQd+v+EbyUZEQFnfshV+eWYquzOuy6YCsv8jL1D7pE1OxY6sP5EjQhA1ylEqPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdazKRvM; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdazKRvM"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c6560f7a78so1825e0c.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496733; cv=none;
        d=google.com; s=arc-20260327;
        b=QGMqhtDHkqXDAdkqeRBFPH+1hx7Zq4/sJlZncNqTnh56/pxXef/8o2oXgNHBToZOjN
         +hCQ06EwSTK7Uwn3y4LZPftRJ9GFk6QTo4i5R6VbBci6AsYSv4IcnZhmXDt6JmMIc4oK
         OBnvJDw3PayBTcxbH9XOpfXohX9IWJReaY4VG09az3+12o3aWOpO6/RMe7qk12TEjytl
         PD2gl4219GKhb6TFXb4XZV0SuPJt24D5q+Hn5Z0aEQOOlw31h/p1Zt6919tnkZnfG/9N
         T/Un0ygbcTuiVngaeMaldnU8W1aeZqlHuMXkGiIV6dOByhrNTm/O4/L6T5NHaT8nM6Jq
         /t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
        fh=0sMrV8zzrpMq6WGsxroQzO8M5T9KmoBnEtDyTGomeN4=;
        b=H8aX6LUU4oLYRyRsirsqOl98z09Gki/V5GVtv55lRTDGkfj+4FG8Pyr/QuRn8yjLMg
         HaISxah/8wKoxO2TuCvqi6iWKEH1aHO9oEJWVDupNRKKgxfVeH82U73n8DzBzfgMR5sf
         227hPdoceP0wRBFOQrdl7R1hhpx1cXBGGfV8vVQZFONwUYNXYzjGzjBn9QnLF/VrtU8y
         H2r9pttsm13E3kqUNTAWexV8gYpnsJz9Pj1UqUpiyTMhtn63FcBCvRiSRSnx34eDzHo2
         5YqOWGn1hP0OuQXXMAhxdpBFAdRIS2Lm8JZ2fE81RhDn+5kymOojiPwrS+17+YI/OT/E
         nQQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496733; x=1790101533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
        b=gdazKRvMlUfPcPgxwy7LqqhqZ8kminG26fHuYxuWr5SjL9an4B+RpuLEARsJ913yJ0
         aJx/KsIeROVBp/c7LZrPTWmuFXtoF9QQPa01j7/VOeF777zcHxk6BYfY8r6zs5oJ7xg8
         iqtSVY3dwxkZNvFxlTJzhY4mJryB9hsv4BRP5WYCEKQZ6BobgAQRsZd4uHdUop6UjEHg
         84eeKtdfsfjBmRv9C+W2bBh/yLN9p3QsBInhQmAgMpIszyjooSVn2JGxerhbT4LMs16+
         iiJBosHUxXRZLsC+MsEYPxI69sWv+wxbMz02irbDx2CaExHLt5/m79Jy7OQ4qYjjr0Ry
         N/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496733; x=1790101533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
        b=tagdztjYHNMN6/mv0R4aYR34hpASSFAAIN5rI9keTkBXboTnpYUSzS4U7Z9I+XuEzP
         hi89B+i2t+Hm8gP9jl+TgNeQxvzJ8CuquAhU8etO30iFZRnUuktW0zDhHRp03AsPsm5B
         K++zSRHJqrx814inIiJnTD9rIH0nKEURcQexIOc9UycmvaK54xtmPOc+zEv/S31Z5BW6
         GMtiOkUtxuFUgmhCwWkJHmTfFnDbSvKBsxoFpXBx7MkF4Piaikk81n8/KIF+opwC9/hs
         iXKOsKRf+PO8EeDCPhIc+tGyPCQAG+/CfDOU5Szztk9t74aSUbRw9QdZFuiWfy5Inj+d
         TS/A==
X-Forwarded-Encrypted: i=1; AKwUvBxTZFur6r5qlH5I4TxWNIDerksuDtCZyrEmOcLRoVHXeIZW87HknhW+lRwzGPK6wQAtq+o4JxM=@vger.kernel.org
X-Gm-Message-State: AFuF++ntOrrzRXH6hNO7bowKvHTVLhRyhUvLYgMVhAWOMSvTCAVGKz+v
	zvOuvV+PO0aJqDqAoGhoNzZcIRDDui0gjnA1u2gGNlcCK7h+G0g6Kjvx2ir+yRcwrWs1AGF7SaO
	b7q/8muUr9UZ/Ye5hYaj8Y8LhzuX0AjyD5w==
X-Gm-Gg: AYBFou06DKkjoBAYGXgQpQ06UYECwtTIkoYOFTRa/xDeaf0SF4kuyCEd76JtRWs2dXE
	7Vvyo8wyo3zRkXIKbRzEJRIITLKPn7kemcpMnEQK6XxqFtw9tB5eS5jg2LzLE0RpOFB3PSeUBJz
	IDCi06JcVMpNMzz4CZilNB2U6hXGXUDNaZHgsKZdDurXrAjSPNIVFlwNjwgjoERVepdJdsjZcYY
	9Gxuf9Kqr+EhKP6gKeP/jCD4QM1w2hRCTtCSwVJZP/rSdC9aQkDXItwpkYnOZE+baKzBlQFbLE3
	NgmAKXOvUnxvf7zQxnE6aKDovoh4IhjJPu/tirSBQQ6dFdMxDMqOt2qbkmQHugulj465h5VGpeP
	nZYEZH/LcM23J3hrfbGb9GGQ6/RykEhW8+l0AI6N32A==
X-Received: by 2002:a05:6102:50ab:b0:791:33c:9d1 with SMTP id
 ada2fe7eead31-79b5b2922c5mr3710542137.1.1789496733210; Tue, 15 Sep 2026
 11:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915180149.2162871-1-mario.limonciello@amd.com>
In-Reply-To: <20260915180149.2162871-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 14:25:19 -0400
X-Gm-Features: AcwNN1XubN3nOJ1hgbvFZZ5HbS76GvuN9dnHhwQ9WI77yqlr2_GO1PuDcPlSjvM
Message-ID: <CADnq5_PpPft_ctb6QGjkghoDJAEbCxLUztgW3dJbQXdC04GhFg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip KFD mapping clear before initialization
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:21=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> amdgpu_amdkfd_clear_kfd_mapping() assumes that a non-NULL kfd_dev
> has a fully populated node array. This is not true when KFD device
> initialization fails after probe.
>
> For example, kgd2kfd_device_init() sets num_nodes before checking
> PCIe atomics support. On a host system without the required atomics,
> it returns before allocating nodes[0], but the kfd_dev remains attached
> to the amdgpu device. A later GPU reset then dereferences nodes[0]->id.
>
> Require the authoritative KFD initialization flag before walking the
> node array, matching the existing KFD reset and teardown paths.
>
> Fixes: 353f7430d1ec ("drm/amdgpu: unmap all user mappings of framebuffer =
and doorbell before mode1 reset")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5833
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 09feb45584bab..17365cd0a997f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -330,7 +330,7 @@ void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_de=
vice *adev)
>         struct kfd_dev *kfd =3D adev->kfd.dev;
>         unsigned int i;
>
> -       if (!kfd)
> +       if (!kfd || !kfd->init_complete)
>                 return;
>
>         for (i =3D 0; i < kfd->num_nodes; i++) {
> --
> 2.43.0
>

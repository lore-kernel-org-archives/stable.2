Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793636099;
	b=i367P4Pd+thqmD9C2UOHC0bcO+FKnBsep+lAWMzNndxIPjC2IQKGbgGCMXxD7q+1YO96
	 fVdn66xOsMBz88FEhmEFXCOb6N24TheTs5XAQUhIyLLpz0LrnUvFa3Q/1SBmucsdyHE3g
	 bka6iW9pze5pvmK6IfZm2hpnuBQWYunDm5Zh2E9Ff8LJws4s2rM9vLyzz0xSfsJ+cSDrH
	 +Ns83UhhhaDs8C0SBNolAQsDHF2ZyYkn9/4TsYiqYdczmtL2qpCKRbtn7zq7H8RkjrpU4
	 liH7ziczjfcaNwlBu1BZXjR2ft4N/EIGoKcQ9E1NJ2z60b1sZBQgKcLBJg1zl96tLZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
	b=VOL73EN++tvr6STkwimoQkPtf+hpQhS662XblAQUawW8S6bs4mji6lALM7ojjtUGNIJX
	 WE/os4r4rC6GwQif4c7Dh4kHU8U6P8ODsmFrrCQak0+LnHWUc8+jvX0Hb7RLRamW0dR2j
	 Nv/UiQH65WwS6CrEiLM6Vqp+HYGfZ40kLnFgM9SRqtawHb6drDyZrJCIxRTp9kMyUFxNl
	 9xLFWCsekoG/6/x3+3Z1oSFR/UP49yFcQus9NNU1q+E3Nt9AXHu1IiFqSNeo2GROL/8ik
	 IJ1EGQ5TKIZhRCh3W5gUb7h4Y67uX1fsEPuwG7GP04eWy3ErDNqiagHsNF7KL4kTUtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgT70eXS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854E606A90E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3854E606A90E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgT70eXS
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-150b2fbd784so91543c88.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636098; cv=none;
        d=google.com; s=arc-20260327;
        b=pR6MZxytmGMf6Nw1dbNsnxuDpW1e3Lc5yYDgsOtE7orKJfr8oF7RuP2vhkCKAwqmKS
         eBiauvXDNzFoopz9hlTf38vbeSKZUxCUT7GNvK9FxvwV9KWjkF+ieKe9LpmjOGhZsSoX
         IxVPPCpS0bf5D7hxk6CU7LaTDuKH5kmY4Gzsi7kO2PG83KSTkpLSfP2vpo9o+o93Frr7
         lpKuA3lDqxT+dfpA9LfA5Mwr8fPpYd4uya722i5wTfYewtxjbKMI0ff9oqIM88uO2MCo
         vPAqP2NHwOqPq66OjwG+kJV/zIU6EzvzBdCKY9h/6Qq888LVu4Jpiuyw8Sh6Q++Q9Z2u
         S/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
        fh=xPgIbiVchAFNt8lgIQdwE4ilcB+Kt/ZFf50686kLyrM=;
        b=pIVXdrsEfQFcoYbxHraA+78J2V7L2y0xStoKiEQC89T8NtcDpDnfxn6qjXFqRRpUF0
         lCHe0m1REZ52SSFHMx4Iog0+hPJOoqU4CgFe58GZVx3STy0LMOOKRpIRcbA73Jg/LxZW
         PPhw4iX/8PBRLrGlKXfk8JqKYSg+gCar9k0x4CkWuW6BUL2L+k3B8lCDzncNbcc5NRvI
         DwsjQuFxTz+CRSwyr91LsB8LbtaJLRof97CU25m6FkZJ8GdeXt+k5PpZNzoaMslJvtWQ
         Yt4k5gEYaxqmb0wfLMFq9PEFWVnrZ1x3XLtNMuEMn4FUvLmnwtJ83iK8xJWdPbGmEe7m
         9a8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636098; x=1794240898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
        b=RgT70eXS75/abuwsKiT6GAvHxyg7xJIPSP2RQecvAnSSllGPPMl7V1fXBsxotceoGt
         Xk7sCfkTSnr5BNdA4K8x92jmX5GHECO1mkPSuZah1agN7gjapPHv5LFnIyTuB9waY3Oe
         YKaAXBRuQITiWpFRGHsLrfCgxPUZwbTZIwL1WX/pv94RN4SvrcdXPmrpZP8vtWIcW32R
         9+ByglVveUgJgBUDUZP4/SkNF8UqHIyfvi05nK6ZjdFSVINJ6s63OmW8BN9WbGxKVNya
         CF50Wp64PCy9QPFijE0YCNs562tgDFL9LrI3aqGv52kqsj3D+xQJ35+I1fYU9vb0VbUs
         KJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636098; x=1794240898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
        b=EnMR+SBM4tRkySsrQ+84naBCbvkRoUACsq1qucfnw5Ekmk7z55iDShBpBDykBs4671
         b6VEVvMtpzGRrGDvH9YJy4NcxbS2h4FYehVcQL58PMW8uRvb0rJPNtYGz5YyPFNwYeYa
         L65HcHS95Kqc1N45qtZyV+1Cg3jDna4ODojya1GAjyJ57NFvXtTVVGgF6jGxeWK60fha
         qSH63wc36wouRtOkTP/ytLatWo6iEsVlpzYHqq+Ng7q2AQkOaY5H+ONADWyk0nncgVj/
         w3HgYX2/xiYOoy4+Yj9LAolzux6f/HgkYJnQBtvSabW0z6z0aIOwG/n5mSp2+NgGT+N6
         Lj/w==
X-Forwarded-Encrypted: i=1; AKwUvBxFO/3e2njQ9LAzFbqJXuwpMX67Jbgb983nDu5TaS1+EO5C4Lfpm+Xw/t+41Ftw73PuKrtMnaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPVzQWBqLdTxPhfK4OtNJn8vYw8XRiawD6HpQCzoHiak8CLOHC
	c3DV8wp/+P6RCw9hbKqBWMNmY6ZC2cTL1pAVy7j2zuuLGENxTUel6heJDm7xy4emW52OHokemPz
	kPAwt/ws7hYee/hMCzU9VD3LHvpnridE=
X-Gm-Gg: AYBFou0o2TjcYLqfJRgw3P3QbCL5N6dtnefLM5R40o+ouLSR5nBagNRnU/b54jDheaL
	RewE8HJRF0rcDd9BcTK/jdmRO821uIBNwc4A986NzTQHlaIEPnZ9m9F4I8FZVs818CtnfTjGlQO
	CvDOVMelCqLpR9O4eqmcmDD+m+vNPtgojouBueUfDf3O92r5m4KCDhFJQnRzmmwtq8gBKjhVtJ0
	xgiU9NmPOwU2EPbRpIIQAj79sHSi+FxNEZ+QqEYhdLz+1naSLpvYSLd96gKYcNCCLXUPZqmy5jO
	D45vSjQkuJM8Uz/lL26nzVu1nVorStZW9g7e2pcMXXh8/0uFF7e3wAJYHDbs+bq/08PdeoJRzRg
	pzNc03JLgnfy6JUctqXj15OJSYDNGQujaF0xWtfGev/PHodT8xZq3VI2Ds0AY5paTO7x1JRFA2p
	L7j7m15Alc4C69Dt8JiVJG2dbyMuNi8F9LwuUJbl33NWr9
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr26290103c88.0.1793636098164; Mon, 02 Nov 2026
 08:14:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029170831.915318-1-tristmd@gmail.com>
In-Reply-To: <20261029170831.915318-1-tristmd@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:14:46 -0500
X-Gm-Features: AclHuK_JcRVN6W2vlVWf4f1-FWgd_LnG4QSNqF29fy2tI4WLRUhM7uUGnOkvvqI
Message-ID: <CADnq5_P9fh0dDU7-vBiBPEY8iNJ2eVZS1kojvObngsYQzb459Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: validate ATRM return buffer type and length
To: Tristan Madani <tristmd@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed and applied.  Thanks!

On Fri, Oct 30, 2026 at 5:13=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> radeon_atrm_call() copies the ACPI ATRM method return data without
> checking that the returned object is actually a buffer or that its
> length fits within the caller-provided size.  If the ATRM method
> returns a non-buffer object type or an oversized buffer, the memcpy
> writes past the destination bounds.
>
> Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
> accessing the buffer fields, and clamp the copy length to the
> requested size.  This matches the validation already present in the
> amdgpu counterpart amdgpu_atrm_call().
>
> Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX ha=
ndler (v3)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 1da6bf1c17ff3..579ba1c1f23a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> -       len =3D obj->buffer.length;
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER) {
> +               kfree(buffer.pointer);
> +               return -EINVAL;
> +       }
> +
> +       len =3D min_t(size_t, obj->buffer.length, len);
> +       memcpy(bios + offset, obj->buffer.pointer, len);
>         kfree(buffer.pointer);
>         return len;
>  }
> --
> 2.47.3
>

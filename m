Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B821483824
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286769; cv=pass; b=C7LY+uRc4EW+nGbnZLKbpOdkxX4fA3SyxRILqtkO2EDSUV6hjMBn+OTSRpajW94eNoKb0TeF5L/wE57aW0AhM7ateZiFPhlDxEz4xA8PRjvFkC8PR/v7TnYLzGiu5Q9tWIa8ZjyWRD3Egi1ZL+AisfeEVN+gnvwwDv+SJ/fRQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286769; c=relaxed/simple;
	bh=5MoVjcGWD2Gwwyui2ffRscfzcOMfm+L3vnHEanIaSVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyCPn+g40UI8VJIAfN28THIMs9/9Agx1GjvuJsvWq8K4XgOdIzEyiL8Lt2mHNq5sPAt8hUyY/WUO9LWIU8YbnEafLCzHieQNxECHLoFsyZrHMdsMH3FejCadOAboEHOXcdEtzepARkSc4WtbuMaYcK8REo4tUM2qSQbQRf6Jsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFKUwhip; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFKUwhip"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c14c9c8ccso32774eec.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286766; cv=none;
        d=google.com; s=arc-20260327;
        b=AEDbUlisc7E0gEjZXQ6nv6A/7y6ur/L9gLR9V5Lg8z6Vq8fT7nWaWCJIzAV9AODocb
         1GS9l3Lkcy7PT4MbqHn6lXo46C7JG+2zeXP6MY7FX622VgijzBsIh/1OAwasPdaWbrI7
         EVhUqnx15E5ZDPs9aoXilxGHhbFCHy7rkURNcvtoGuM4N2bJZPqw9hL+V9SHtPJnbZFR
         VMJwFy4eMXC3O43s4G7QY6XX6JaKYeJ1dIKXN2xmE1T/vKjl12PCWOSqVw+rDMQDDn1D
         L2dpxwL0eIHo3qsJSZpcEePAerHjYMCtfKUGxHfNYV2Qwv2TxoCtwyn9vji5v/7OveHm
         Lmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
        fh=snrck/yQVZcKToS/InQFDHynL7WP8655qYYuR2O0jj8=;
        b=UeQ8+StH4OdDeJ7wtbxHm/YO/rCVQZnEHRc8+Ddvelc/HZms3zKQPaLN2+wBxP0mv2
         MuQ+nSSCgQA4/960FxSUOn0wGXYNzZZyaC3XQEy5bDLvHFnZdKRkwCk1PEV5QkkCkxOV
         JO10NHeFFhJlE1DD1G7FybW1WiZjI5KLw9kukmLpu5DWidWWycxUKyJXL0XAlN+CX5yV
         qg6U/nTbrx29bYh64yZmzFluBinBD9OxBcheERT4OPs6vnDuNV5hF76h7mfmOy442sns
         kE2FP81jqFgzmUa7XTqetnpCBQgI4MZ2gwzqrInB7b8uKDQbq1VEHi8LBcNHAa9EYtKE
         +g6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286766; x=1790891566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
        b=LFKUwhipJyreOxxk/CD0TMclYjYziT4QLwTniIW3eSg0IU/NESXTlWMe5DL4D0B/W0
         7jvdRxodO+DOWqVqpiorbQQMGIu7ntprm2iuxF7JFETOMfYz1IyLG4ighkwOG+PGyxPQ
         of/Lyn38eZI5fUBrBTaLEqfnBKGP0q4C2SGqBRz1WbxHWUuwz1ig+NITQ+JHQCqqGD8b
         DQLq1ldE67e3WU5G/U3Gy78lmdwsNB7mE6JhrzgEBOiwFPi5bBBgXCqm/qmTOi/MOaT8
         W6l2kyCeL6aUH3QkhQVhfykh7+E1jH/TXnDjFn2icJ3/o01aqkw2KjKjJKpMhaCDKty7
         QtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286766; x=1790891566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
        b=P8v86lWdoqoV7FIg0Urnz6Ex+3/m1CjOe6kMZvU4zgPPVm9xV0NTIwB58bOqcyvP79
         321wJQqtuaHukin5UyF5toLAXbWvQ/DIEs7UbaYr9edlyHjpzZd2MbMapSK5dqllpkmO
         xUJF7cfgRu+yF7ut/hRslweIRmrWUkfaaPbyEuL2xmbC4+hwhgs1l/pgJWrAtuq6TJ0d
         hUQL7NPkiNmSBqPctFB+eu3EYmtzjDS+fW+w+zmIpl8r67YhUPDj1iCjnp7CX7JTVvIb
         cGhQhke2HXdH0yRK6Y84nc3JW+8e70VLoYzJcAa8SbhV2ceahvrv/2pe/BfY/dBT0cXu
         txwA==
X-Forwarded-Encrypted: i=1; AKwUvByphaKiOrTYLcRPvoPF2hDPfFhVavT/3Pzh5Pzr/3bUDLWD/h6FYLG3/US0ZKcXddQBcYv6CBE=@vger.kernel.org
X-Gm-Message-State: AFuF++n0jrzc2ZS9YVY9Fgf7YDM2x+9E7gO2wR2wtVjQuz4cIXUdhFB7
	+IOI2uJ2T+N0d7c6/pPd0CbS+u8Ux8+Ar2maXaLq2XzZ8pHntivJyOy7QsWT5o6BE8DNee7CrsW
	8IT0lS5ulvx+DqP67HNz1R3JfzYP+UsY=
X-Gm-Gg: AYBFou2guTnHz3Fo1kJ2rBHKZ99XrFZojWrYSdDPXZOYfCS1ZthCIMh1bveu5FcQ3lX
	BkruXb92nPSFpiBttAmiUgUjfS/ZxlzCww1YVnKl7CA3Q4QfvVt+TI73RKHEnSFuCnlpU5tFRTE
	C6QQ0Ya4vBF/PYcJGfZv2/E8YKCX6nr/EDCEMIIueLccaP7EW25dYd9Lu9cJxO4n3KeNIVArc1f
	MdEJcRZUWhm3wC1oiUx92wcPX7fB0zHamTq6OvKWddOCcYX4vlk5Oz7MJmnKL/ka35AXnoML/ba
	+1wromdOqpx3BE2ha1wEeTMMaIaXqrkiQ3fjNgpAhU81KcFaMZUamx55kVr6DNItbxIshqIQDcX
	JyXamm9qGgZjoeP0ygsKG/RJiHPhz/10owX+jc41H2w==
X-Received: by 2002:a05:701b:450c:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14503f1814fmr4390022c88.2.1790286766083; Thu, 24 Sep 2026
 14:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com> <20260923154357.1319689-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923154357.1319689-1-qwe.aldo@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 17:52:34 -0400
X-Gm-Features: AclHuK8_S3kMABiU0QTNjcDgoAqPTQebAhSNKvPGJWpzU2O6hEoWY7qZTP4di-8
Message-ID: <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmai=
l.com> wrote:
>
> atom_op_calltable() invokes a child ATOM table, forwarding the
> parent's parameter space with an offset:
>
>     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
>         ctx->ps + ctx->ps_shift,
>         ctx->ps_size - ctx->ps_shift);
>
> ctx->ps_shift is in dwords (set to ps / 4 in
> amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> remaining capacity in bytes. The subtraction therefore mixes units:
> a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> 16 - 60 =3D underflow.
>
> Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> subtraction so the units are consistent. Abort the interpreter when
> the request exceeds the available space so the parent table does not
> continue with stale or uninitialized data.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v3: abort the interpreter (ctx->abort =3D true + return) when the
>     child table's parameter space exceeds the parent's remaining
>     capacity, instead of silently skipping execution (found by
>     Sashiko AI review on v2).
> v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
>     ps_size, fixing the unit mismatch (found by Sashiko AI review).
>
>  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index e0e585f..af283cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx=
, int *ptr, int arg)
>                 SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx])=
;
>         else
>                 SDEBUG("   table: %d\n", idx);
> -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> +                       ctx->abort =3D true;
> +                       return;
> +               }
> +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> +       }
>         if (r) {
>                 ctx->abort =3D true;
>         }
> --
> 2.43.0

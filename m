Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F94E9C08
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626367; cv=pass; b=S10zGi8m+mQnWsqHY1Yybxkfq3Ukng6CdRVuhyslb6NxHGeAPALP3qfezfiR/pQfxgAxZzKjGxpZhVa/0odyZuswiK3ul0h6/K9Av5u/KJlmjmlasyg8GXvo2634ho8po9mrpqmU31gWS3uR85sd24aI7WlTyQ16eSm2aIv0vbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626367; c=relaxed/simple;
	bh=LYplrdyBy/ve1B9b3/A0Q3qNi6+XTJGeLMxYSFaxX+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1dStIAovz1ZcL2xZh1ddSrRH9BL0kLTCNkprSbodALYTEZOE9hlcgDu0cQy/n92LhHy2O0Luk5f39mhcrygXU1FrSXW0stxCcuGYDTaPuuPkuHAyoisPypOxR4o4OzqG7PjDsN/DSfv33CHZZL6p63ppLPT+26S3cDIYrWxqWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFd+iOdL; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFd+iOdL"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so537644966b.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790626362; cv=none;
        d=google.com; s=arc-20260327;
        b=QWrpbdaOBMnspUaDdM3prHfDduoEGPSeJCAH+i9FRM/Aa+E4uwOW3LxxHjLak4IGBt
         Cjzn7YO048PWtBrUIH1eFeRXN+RzIr2+/D2aqzl+vTwn/hZ4KWQrD64+1o5MgegW1VBo
         IL87DxcjlFM/IlBLIwFPwPx2dvTxCZZWLjrK7PFuH+YcDCeji/pgEEd2BrEt9XngpplP
         9c2XTVcH0ffEfGFVAOAsfswfcEjoT3xHFt04bSoR9sYrnx9kgl3Dwimi/qPU4SmbHkRM
         svbIw2gwGtPZHbpAez2jtTSpjnrHyQm8DuQPdN/jTyoyKb2rpUYKMGFbPC69t5FlDy0y
         YqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=op3YdKxjJPB63dQXpqOAe1ZN2m+ULaXvCzt5oEDNYyM=;
        fh=WSdmWuhyWaWnw8jgW2B2eEXI9DIkj4aqSK9XSHNeb7c=;
        b=C35TWUeQI+/nvs7aS05YPyYDfBdGmCKAXz3ekxupTp+E3pDZq4RUtpP/N3mAXl2Dts
         wUUmfBEbWL6m27h4GNGFK3VjpyFUjIwJHvLtPsp9h9pe2x/fDW4j2z6jTioVcwfTjNuo
         ig6O5gl4woL0IQT9irg7d6o68Sg/6wIjAYtMYlglWj555bZrisJueD71IOGOsTlAZJE8
         mXwvCOy115/nPYrnCnSCAijpnq4btsfCXU752olA6u1YVeXydOXU/C5OpMyJPlVSBsNZ
         FVWndbDIidzXiATHQAKK4D4xyWCy51CLVbgkXNKV1urGEliiSieOoeIguakhCY4J+oyr
         fLXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626362; x=1791231162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=op3YdKxjJPB63dQXpqOAe1ZN2m+ULaXvCzt5oEDNYyM=;
        b=cFd+iOdLI45sRnZVAbchIr3Yj+myKDsj5iXol4CaUTAd0+IT9u34qXPGCOmkOQjKtM
         Qid/vorez+NvJnemvwo2x2MWLzXCM3Xxsh/rnJ1LV7A5rNAG8ayU0ePQ9mjpolagtrWl
         GU+FIAUac8Gr2JfE6YqhQ8UugaeWOzCdJJkDbYBVafvk24vyYsWkWwXGKZPEhHZM6Lia
         OaPGHcX4RFzw1VUxmAT8LhaEKMV0MQCwXwdOoFLQbbEfT9PRYR3uJrCGuxwJ3pWOHyqZ
         yf7xtF2SBhqopJXiZFdQhChCd5Ycgcvd0h1F6/0B/LvLh6Yx12O6G8yM2HfBwpaQc3gk
         U3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626362; x=1791231162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=op3YdKxjJPB63dQXpqOAe1ZN2m+ULaXvCzt5oEDNYyM=;
        b=AL355nQItjhXWGjdhZCeOcKCQVzNLqfnxz/jKptJ8puQVaemWEvNXQzNZ/VVuNrqdm
         zUQyA9SQiA7o7doMet8tAMOljhxR4WMx8pBAVTqS1r7D/Mic7nDMOfBC6sP4njpfDt3A
         WHOME1cWWQdswENAbpO/WMcv59vRv18zbUfQ7lUQWvS0dizNtjwg6CZFTwvN5aXICIrh
         W3jRrn/g8EjmpgrFw3F6tnm2wIjKODWNWPhqFKrVXp+1Pf2DtiqJNZHs49qeLYTF/cCG
         bQdIm5Byn70zYUIgFKUpKVfrViJvy2KEUYLp1tSiB9nUMPuKeDIWt3ogNAj+947InQQI
         4n6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwutig92n4uqw8Ku+dgzlxniS34469QsTBvirECXxlBCuRQyTGSndTXHlm+4Bl3qyCVZclnh6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++k7N6lKJdEFsxBWsXci3AH8dM45hPyytLlVtSVUYY1yVNBFJ2F1
	CJnpBNslncyRYQlRGH/opowGxCn0xRK4U7HHDFkUz0vomAX2wBsCdQ+u7I4a/S4PguExguqyV5r
	94o49tXc66LlW+bQ0au0pLC34uezuqGs=
X-Gm-Gg: AYBFou1rwXVsNMhyUB2DURKOW7cH9EH5S48mt+LtiXEgm2NJbDOswxARkdJeeoeNS18
	B26SXMng9kXGANo4YZrWwDfOwWnxXvYRwWBpEAJNxpIRRbUe7OtM07OLkZK/GExGgN3ET0WsOG4
	4jiCGmJlNJH320KGBS18j82/xlkDmM4e3nIv44XIjMxQHulZQwIljuZcRBkb/wbtr3fKmz7gmX6
	+JaLvGA8jHODh73Y9iuN/fpOs1SPqMcAyUUqhp4BU3FXeS3H2xGQBvmFJQLH0Id+IV7wMfV3xqA
	Bg0+2IbiiA5JpK9qzSNYIbtooEnxBqcPkH16C3DHwz/A6Gaw3re3ugV5D49oU9LkGVHD9oNO8hG
	Y1ux+VpbVdEV5zPh2eHauNol44V4ePH1826oDquc=
X-Received: by 2002:a17:907:e8d:b0:c29:f5d8:9c7c with SMTP id
 a640c23a62f3a-c2ac22cb147mr1134942566b.43.1790626361635; Mon, 28 Sep 2026
 13:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d60ef62-a53c-bb13-ff6a-0a195cf2f6f3@linux.intel.com> <20260919060037.84602-1-meatuni001@gmail.com>
In-Reply-To: <20260919060037.84602-1-meatuni001@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 29 Sep 2026 01:12:30 +0500
X-Gm-Features: AclHuK9JUTRFiE1kmA3vX9iGMdGDyovU-rO_D4_8LNq9x5prseHY4a5bJKiRjAY
Message-ID: <CADqcGBm5r0+t44E3fyN5Re4+nL8hm+XxY9knQVqGUy0WmqVh9g@mail.gmail.com>
Subject: Re: [PATCH v4] platform/x86: hp-bioscfg: fix 16-byte heap overflow
 for empty auth token
To: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Josh Snyder <josh@code406.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping.

On Sat, Sep 19, 2026 at 11:00=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> hp_calculate_security_buffer() special-cases an empty authentication
> string and returns a fixed 4 bytes (sizeof(u16) * 2). But
> hp_populate_security_buffer() does not special-case that same input:
> for any authentication string that does not start with BEAM_PREFIX,
> including the empty string, it always builds "UTF_PREFIX +
> authentication" and converts the result to UTF-16, writing a 2-byte
> length header plus 2 bytes per character of "<utf-16/>" (9 characters),
> 20 bytes total, regardless of how long "authentication" itself is.
>
> The caller, hp_set_attribute(), sizes its kmalloc() buffer using
> hp_calculate_security_buffer()'s return value, so for an empty
> authentication token it allocates 4 bytes for the security area but
> hp_populate_security_buffer() then writes 20 bytes into it, causing a
> 16-byte heap buffer overflow.
>
> The authentication token used here is the current admin/setup
> password, which is an empty string by default until one is
> configured. Any write to a writable BIOS attribute while no admin
> password has been set reaches this path.
>
> Fix by removing the special-case early return for an empty string in
> hp_calculate_security_buffer(). The generic calculation that follows
> already accounts for the UTF_PREFIX correctly, which naturally yields
> the same 20 bytes that hp_populate_security_buffer() writes for an empty
> string, avoiding duplicate logic for special cases.
>
> Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
> Reported-by: Josh Snyder <josh@code406.com>
> Closes: https://lore.kernel.org/platform-driver-x86/20260402-hp-bioscfg-o=
verflow-v1-1-6985f8c9e67c@code406.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v4:
>   - Straight re-generation against current mainline: v3 was written
>     against a tree state that had a duplicate "authlen =3D strlen(...)"
>     assignment (one copy meant to be removed, one meant to survive),
>     which current mainline does not have. That mismatch is why Ilpo
>     needed "special trickery" to apply v3, and why the manually-applied
>     result ended up with no authlen assignment at all (reported by
>     kernel test robot). The v3 diff itself was fine, as Ilpo confirmed
>     ("authlen is not uninitialized, so only the early return should be
>     dropped"); this is that same one change, regenerated from scratch
>     against the actual current tree so it applies cleanly without manual
>     intervention.
>
> Changes in v3:
>   - Remove the special-case return entirely instead of adjusting its
>     formula, avoiding code duplication as suggested by Ilpo J=C3=A4rvinen=
.
>   - Credit Josh Snyder who previously noted this approach.
>
> Changes in v2:
>   - None for this patch; resubmitted as part of the v2 series.
>
> Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.c=
om [v1]
> Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.=
com [v2]
> Link: https://lore.kernel.org/r/20260818191120.38556-2-meatuni001@gmail.c=
om [v3]
> ---
>  drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> index 4d94e48..abf8ce2 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -47,9 +47,6 @@ size_t hp_calculate_security_buffer(const char *authent=
ication)
>                 return sizeof(u16) * 2;
>
>         authlen =3D strlen(authentication);
> -       if (!authlen)
> -               return sizeof(u16) * 2;
> -
>         size =3D sizeof(u16) + authlen * sizeof(u16);
>         if (!strstarts(authentication, BEAM_PREFIX))
>                 size +=3D strlen(UTF_PREFIX) * sizeof(u16);
> --
> 2.43.0
>

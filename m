Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D83ED3A9
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565842; cv=pass; b=QKvswtNfvcfo5LyJ0v0v3+xNY4puHY/z3O6DOvs4B0gohn7yolEPTSKaFQq/FE9L4BHksV2f5GUlQEs2OnwDH63N2AXzcbYm9WQUlWxse0xBIp6JwbH0wLTFo+OH6K797AnqI5V/Ilsyq1+TU//xlIf/KlKhNOt6U26KypkHbD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565842; c=relaxed/simple;
	bh=q5T9rZM3Aio5noPxLVxqh4TcJRM+o6ZrEdGuHWqUiHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjgSDm085pK0UGJYmBKk3oXnj2/ZlTRPs5mWVxUjP6ZnkWeKEGmzt/4swvVu8ES7Zd03yldg1N/Nclky60dcN0Pu4VxnS+o+2T2TbJysjMLNZP6jGYSZp4zmuYXnmmiXq4r6y9YqYlHK9v/bzLxR4WjWcq0vJxdry+g4i3IfHAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzzzSDIl; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzzzSDIl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423efd76c8so348002b3a.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 02:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780565839; cv=none;
        d=google.com; s=arc-20240605;
        b=ZViD1/jGLxoOrxncWfPfVqHZHwVwi/qjZzI6CQqoMf9W7z7ns1+VhqfH1ApgqX5gY+
         lJ0tlYtkNW+CzbBkZHnLYzXhITNuoyXlfhYSMnwM2oNQ9hDMdkCkUbH6PEGJ2Bqo35Tz
         2OnaGLelm+7P0wibs+m6B5Q60r3PrQGMO7SyRHNPp+ay8f3eW298mVjO3FaDgQe156sy
         oafpeJFDb+cD+kT+jylviPIu0QPGhdk8t0lTutn4sIj+zYGrkXNWB1v1aqqrb1VWE6DF
         Fk9OPFhXFhEsCOedlXEw0Afrfl1e6nNxnh4x9qGQarcBA0WFd3X5uDL/ZuM7cAxbVbSm
         2IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        fh=fwA1UE9oJLIJb8uOW01x7V3SaW9wndjWzGSlL0UrzTw=;
        b=XaQHYz44wywos46najOTadm3oiDOVx/kednrXW6eSOfOF2POJdiUbIdPODH3Lg5CGQ
         GUho/2acDH0gIR35wh9Sga+XBB2ATAhyXS3dWPRlydnBzy66IMQnRxmQqqUmMaS4sFny
         8HiIbcyNgkXtfHSWzWD3lOS7Tm2zpYXBNZ05gIOREdVlYnzcE+SZndRdfGsXn/1jWMaK
         kRKIWYdQkx721C9cxNbBNmXmkHDdZ88Qlg2bRDuyiEVzC9jaPGsFePDePbyhM0prcoU/
         +wjDRpT5DakBQT/+lLZourU3UkJrLN2Dx1giIYf6KBDNdhLlaD0np0sCssJgOqSFxvLG
         n40g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780565839; x=1781170639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        b=nzzzSDIloSEfI7GLh2+Jy4hatV70I31t1iqG/JJlwGXRBXW2ryRqApFFrkZBSHUP85
         no5DNe6eLGDStWVTLjX8VJM2slXt9vQ88jfT+5USX7FMrjIUMjVijSM64u9o7WzJ+yRP
         KJ1OXb+rQPjiBOES7rqKLqFbfkwdclgjU27HO61JqgFFPOViiPW3GjjCV+8MCYEWT9tB
         2gfu5MTmjfvQXbK9xSj2BOMzA7/Dj6myIscyxs/VfNgmp1ADOWdafXg0CoE7vVsvB9SB
         1bovLiGXoexnP+zpsJx0lYwxZEhRqnQ4SCMewep5NmKocop+VFn9Em5bd6ggeXh5F3hA
         9a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565839; x=1781170639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAE5dsUcOf+50j6c1n0GmreYE4E4GrWSX2T6ZZrsAus=;
        b=D9RSJgODoCVjQDj5up1Hnu/xPh83+iuWUZ8wGpXDismJclQVrhPjShnVHQf0Jql//u
         793AMc3X1/y2zLCDuhUZY2TtQufntV/eTka6y5/18fOZAOeZ9kmYM39tugfwFjZ3PNqH
         k73ma/ie8mj5TGXXFum26pyLWB7HX0Nd1Ogch7MLHcNYSPb+ezN9eHkJ8X7YdkHfaHCl
         k2ov5R4j4O7psBdhzYArAsqJKIy/KH6lwAe0UfS7X7md12EpBr3U14eOZOQkqqDu5j4r
         T7Z9owW/LtnqPmTJdlaJa5aozS4rUufVcvWeCO/I0G+IQV9+bjl1bvt+japkp/KfMtad
         Ax6w==
X-Forwarded-Encrypted: i=1; AFNElJ+8IPqKkExVrnTMj4bfBmDWTtjHOAaPsB3aD9DkABzayXv440jy5BQfpltdL+xVt6xGVme+QLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpJhrO3M6pvihOuVlUmubEzSEGCMvHKb7bGXXn4iOIK98Q67/
	W0BiRsuP3LIMd8UjQZgR0hfJZPleT2AKXIlBvTaX9AGsTUUflgO2c1Q5X2jU2hvNlLY9fijUeE1
	VDbDyFxJuikBjkYJgVp4lqGyFjEkLQyo=
X-Gm-Gg: Acq92OG/DZSKLMLCQM/ReipFqSR8RSL6qmjSo+j4DYTbBW3d6j92dfR/T9G8PosoGe/
	bdIWyMJCl4+IxkgBPprhpWNu/TkxsdaFNpqFIHnKud+SB5I+EfgVt351aF/gzV2r2V0QuSm04Ms
	3r2lE+xdkix3aQhE7jmrcotjK21IgRz50z5hs3wLMJDmjzIRF6oU31piT4mFqAMeaneJIGNk/Tf
	LeprhgAJLVhpiV7HmgIeuuMeANmj/maDl6+1CvF4FvDHSGkvYPQP1QHDKp4bLcJ9dEQWNdeJ62K
	lDigqrF6bgUk2B0bOQ==
X-Received: by 2002:a05:6a00:4191:b0:842:65f8:bb3a with SMTP id
 d2e1a72fcca58-84284dc1e20mr7432079b3a.19.1780565839303; Thu, 04 Jun 2026
 02:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
In-Reply-To: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 4 Jun 2026 17:37:07 +0800
X-Gm-Features: AVHnY4K0i1x-lAIE5B37fSqEfd9RBkopGxh1S9hjIVvMEyOSCUjsLJScERtWN3E
Message-ID: <CAA+D8AMEv4++ZC_xgXxiLrWWBmJS2Xo10Bj9pboDQ3mFh9STfw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
To: chancel.liu@oss.nxp.com
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:33=E2=80=AFPM <chancel.liu@oss.nxp.com> wrote:
>
> From: Chancel Liu <chancel.liu@nxp.com>
>
> When configuring 32 slots TDM (channels =3D=3D slots =3D=3D 32), the xMR
> (Mask Register) write used:
> ~0UL - ((1 << min(channels, slots)) - 1)
>
> The literal "1" is a signed 32-bit int. Shifting it by 32 positions is
> undefined behaviour which may set this register to 0xFFFFFFFF, masking
> all 32 slots.
>
> Use GENMASK_U32() macro instead. For 32 slots this produces a zero mask:
> ~GENMASK_U32(31, 0) =3D ~0xFFFFFFFF =3D 0x00000000
> Behaviour for fewer than 32 slots is unchanged.
>
> Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable=
 bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> Changes in v3
> - Fix patch can't be applied
>
> Changes in v2
> - Use GENMASK_U32() macro instead to make it clearer and safer
>
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d6dd95680892..9661602b53c5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream=
 *substream,
>                                    FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_=
MSTR);
>
>         regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> -                    ~0UL - ((1 << min(channels, slots)) - 1));
> +                    ~GENMASK_U32(min(channels, slots) - 1, 0));
>
>         return 0;
>  }
> --
> 2.50.1
>

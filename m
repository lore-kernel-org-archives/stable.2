Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF83F88B9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922153; cv=pass; b=Mj+qbnP563WCDmeWSK0Ot6C2fOXL8VJseDYHUtbvBlmmsrl+6GiJW9MWSd3QAidv+mu7CJo/aQv0UO6BWgmByqHTNEDDIs/hw9xCRe5IeTb80yiS3ukLodbJ+C184qZ/u9kORLZ+SOp/3koY4/RRISuK85VxL1xdxa4y75HGVHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922153; c=relaxed/simple;
	bh=2CYxhUN06atxgyD+NuqEfp0FHRHqnrmTcjPfadvW5lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae0hIkAkp99uNIwXFc6JvDi2K69XMTIH88POgmDJ77RCwTLZE+Sx7+3eMbvYU+O6iVRzcZ3/vyLXC6TA7KOFLrsPRRsB21YG+LwgUPWkzRUC0aYLRvtfOkIBMCV1eHzeX7ycIukT+wBXz6r9X/QRDrBXMW1AOmE8FvRaxBoMD6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRaHTj72; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRaHTj72"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so1091590a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 02:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922148; cv=none;
        d=google.com; s=arc-20260327;
        b=iOGEb2gKtoX+4pVxy7bzLF7DOvMgklkLqp/H0+pHfo5OTUnoNL/TFE/aakK3ry6wvB
         hYI1puWLZGgwgVfzlFXd7f4rmteGN4Kmg6yrmuDF1cQugNFJdTXWl7t3xAz2G3mezx6t
         h5LsL2lAWTraXgHgtqOa8gmKbyRNUB9VTsvON2rqgCa6WvhWMtuFNmThwTtX+eGkS5tE
         SbQsrBxoBfOjgSNjB1C7XtCOz8Gicvuc+tRL+9ltEscKbIFLTNfj+RT4+67DiON6t/yK
         rBdGJV9t6rBSzXJITcG5lL5zpLzRbv2QfwWWs6QeBkKz6FYFbCas3f1BRSS8kF+RwXxB
         2yNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        fh=Y0VHLs7DfzEOdc7gmsP13V+4frcGcmRLCnQeaZmsfO4=;
        b=ErI5cDCJ61x0P2QYXcNDmTJW9TS+RAJDnZ8WtNeygkUooWroTI6A8Fg6Z5M8wCNC6M
         g5m+hQBSb9PP0+nDBjmtENCib/aHXkLleTdhOupmlPVCnJow0Y4RjhXLim0jbHY/sI6D
         TVJ5+F7NyQ9G6ABAbk5HpuA3Nz4ri9zGn2WQjzt9+vcXo5RaVB2/NMa5X1FrewQ/KYRr
         NS5K2rwHfGMuas3a3klmVFItjJ/Oe1hntxc+1htke49fLN9yc1suZjaeZXymEWYsKHiX
         qUrnSpBUGL4uZnP+WakrwwYSf+LbWJ8jDiwg7BFPwfVzjiaD8GH+U5Q7UrTVQSCCt8xI
         SXQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922148; x=1786526948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=oRaHTj72e/XrckuRkA497cnrlo9Fzk7mRBhBXJ1RaHvG+7+2R4vfQrOftchvPQCl/P
         k38QsTQmHSL+o3EqszzoPmxowRxK5l6gqFLnPydloJ6xxUi5if5535ZIQAYitjcu0O1h
         HPKlnfL3fOxxo5uv/mNQpNaK4C87gz3GvP03hg7viPShIQaEPK4/Va4yQSRtx4yN71sh
         7xebecoFtAEsMGmUSloibOVe69FFBOnuJ2IZeqeYn9PUE0zUR3wALOwo4xTWieb6caEd
         5yxFYxilUTzGGFmWNqfK11/uoPLsvyvM/a6IwhXO5V9wvTsI/+rs65fsWVeKLolF3nSn
         NRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922148; x=1786526948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=pJSgOpMHMbJGTvHYG3jupTja4TI0RlHtOpm3e8pkA2HOn+7Z8V6q1zQuUHtN4JP5DH
         /T98v5S82GoRDHsEksadVOQer+kzNuymcDlDbQ1DKn0E2Gg/TYi3Klw7Ts2MjrIZaMhX
         2qtrp9zeEjDlgp9ydPXh2W+u5OAUPYA5co30zGwFDY9cipH5ZPfRsPZ9l/haLT/Ucm9s
         cPwokX7X6ugGHFEPxEKpSiSi5doj63z7SkKWty54kN+xdmQQ/bRaguMVij0fVmajb0N2
         pz6avWdTXyGmnc0mTpmfp5yKSquFXfPluLsIsIulX8vcYAJv+vohFx85MKuqioRNmKW4
         RH1g==
X-Forwarded-Encrypted: i=1; AHgh+RqGqNygCwRv2WHLWsgbqgwF0LnY+bXEkx+M+wLU50MrY60eElaKlbS6kbzTyewbCb18TSfvN7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5WyeF+HIxq1xs8AK2urdeiHZpWbN0tmEb0Ujsm/uJCQFuNal
	tQpyeKHNlEeOC8nbfvBSmKUpbUI8pHlcoFw0efc3MjPApQI+N/magbYGp5QazcnfqrjtVceRVUL
	Zn1z0ebbT4bFlCtq9ZdHNA1KojeBHAew=
X-Gm-Gg: AR+sD12qVt1fv58i9HjJYmw+IdFvFeJTb+JfYUnvK1i33viCQTmsrEeYxhmHlXlFZ0z
	M5inyVCXFXf7/yKCOsckksW56dg58sA2lR05oeZJEmIxG89RuNhA2I2CoXY9jDb2qi4VFfm/HEz
	56sAjwuXX4AF8kAawDleca9VLRmJGAKf0WzDL7O/LothJgAH2d6Y+x/hpzbAziXJpfHHMCyYOz1
	PgSfjY1ira0yMNPG1vccTIQ5xxTgJcxgWxMNZqd0/aOs5aCp6uKDzbzBQjJxMDwOaUXUGPjc09A
	Bbsi3W29XbL3e0A1GC9r7Y4sYqPieQo680rk8zoGwOPvzCVWhqpvZ5vFjkLfUrYWvI/uwMDpQEL
	YwMWpvPXmD2/4LxswCPxrvhGW7wJ1w7M=
X-Received: by 2002:a05:6402:4543:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a14f2893e6mr2121332a12.21.1785922147806; Wed, 05 Aug 2026
 02:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:28:56 +0200
X-Gm-Features: AUfX_mytZOAo7u-Z1H4SHvHV7AI6aSPHWr2nPnsXtr8HsGmlt0ibWkok5AeeFvA
Message-ID: <CA+=Fv5RaZZeRvixhLYZVmNsWowBw7oWC5Z6AvbL8=c80CM6XLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> ieee_swcr_to_fpcr() converts the software IEEE trap-enable and status
> bits kept in thread_info.ieee_state into the hardware FPCR format.  It
> contained:
>
>         fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
>
> FPCR_DNOD (bit 47) disables denormal operand traps: with it set the
> hardware handles a denormal operand itself, treating it as zero, instead
> of trapping for software completion.  The intent was to set DNOD when the
> user has not asked for SIGFPE on denormal operands, but
> IEEE_TRAP_ENABLE_DNO is clear by default, so ieee_swcr_to_fpcr(0) always
> set DNOD.
>
> Instructions built with the software completion suffix therefore never
> trapped on a denormal operand.  The hardware silently substituted zero
> and produced wrong results, affecting every program compiled with -mieee
> and default FPU settings, glibc included.
>
> Set FPCR_DNOD only when IEEE_MAP_DMZ is requested, which is exactly the
> case where flushing denormal inputs to zero is what the user asked for.
> DNOD then encodes MAP_DMZ, which ieee_fpcr_to_swcr() already recovers
> from FPCR_DNZ, so drop its attempt to recover IEEE_TRAP_ENABLE_DNO from
> DNOD; the DNO trap enable lives solely in ieee_state.
>
> Both functions are in a uapi header, so the encoding change is visible to
> userspace, but nothing outside the kernel is known to depend on DNOD
> carrying the DNO trap enable, and the kernel is the only writer of the
> FPCR.
>
> This must not be backported on its own.  Re-enabling denormal operand
> traps exposes a second bug, fixed in the following patch: those traps
> usually find an exact result, and for an exact result the emulator did
> not write the FPCR back, leaving hardware-fabricated exception bits
> visible to user space.  Taken alone this change would make spurious
> exception flags more common.
>
> The bug predates the git history, so there is no commit to reference in a
> Fixes tag.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/fpu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/fpu.h b/arch/alpha/include/uapi/=
asm/fpu.h
> index cea9eafa056f..d28dc36786e2 100644
> --- a/arch/alpha/include/uapi/asm/fpu.h
> +++ b/arch/alpha/include/uapi/asm/fpu.h
> @@ -101,7 +101,12 @@ ieee_swcr_to_fpcr(unsigned long sw)
>                       | IEEE_TRAP_ENABLE_OVF)) << 48;
>         fp |=3D (~sw & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE)) << =
57;
>         fp |=3D (sw & IEEE_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
> -       fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
> +       /*
> +        * Disable denormal operand traps only when denormal inputs are t=
o be
> +        * flushed to zero.  Otherwise they must keep trapping, so that /=
S
> +        * instructions reach the kernel emulation handler.
> +        */
> +       fp |=3D (sw & IEEE_MAP_DMZ ? FPCR_DNOD : 0);
>         return fp;
>  }
>
> @@ -116,7 +121,6 @@ ieee_fpcr_to_swcr(unsigned long fp)
>                              | IEEE_TRAP_ENABLE_OVF);
>         sw |=3D (~fp >> 57) & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_IN=
E);
>         sw |=3D (fp >> 47) & IEEE_MAP_UMZ;
> -       sw |=3D (~fp >> 41) & IEEE_TRAP_ENABLE_DNO;
>         return sw;
>  }
>
>
> --
> 2.54.0
>
Hi,

The new mapping of FPCR_DNOD to IEEE_MAP_DMZ looks correct to me.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com

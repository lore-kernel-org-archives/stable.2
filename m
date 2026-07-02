Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46B15B971
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958589; cv=pass; b=qjsJDm46lhJF0T3FIsh6PjzZLw3vDzS4G07pU265RC4jh978tWwNuVQSC8qIJnkdVoMSPdLNqWHt/Nd/s3+YfduK7hXZpF7rnmOi7P1AVLtwf76KHIL702m2nfOPGhU/hvJZii/JjwgGlUhvlhgEu7rMm7Gfct4R4yPmsnMmz4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958589; c=relaxed/simple;
	bh=5+E6fxZHhZpMPQrMUi7X3xQvYDVzwgVut3YjfHG2vYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwcBshYiid1C3R9PkQq5EY+YD2XOY2Dtws4DoJURk7LB4yWQmruda76gkLa4QZfTeAHwAaOnXYF+WuX6Nr/WlT+KIXmNMChTXjk1vRGANXJsuQ+yR3PG5WuscBkUtU1Mbe78Cambz6FNbIitILn8CIvEpLNbonfwgfxRvvfWui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuppleXx; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuppleXx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so653208a12.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782958587; cv=none;
        d=google.com; s=arc-20260327;
        b=hiJXVL7CRpTYgbzVZtwLuNHKy5iN2uwcnhSAJlH3IM17aY6kCGvAgnuoZT5c/nihmZ
         HDBeWOiHbAKJV+tZwlceD0e5SRQcGrLrx6C/AVBy6APdq8XEGvaqnblWE+2xl4ucaQDw
         gbJ2A07u3znK3vRMqwJOTyFneiTZ1MHWuokX+MhLZrx0Ti6jgftmM5iEgbGFowJgk4F9
         vABZIhxsZ7fhWGCCuQpCmkibRTzfieRSAB8hB3OABASrMWB+tiB1O6zda5zn+1KSon9T
         pavoFEMRaXV2IYFsQnY3aii8vLrjGpPqyyOpZqO8tz+JNQOQNvTX0MUfHi0ECwQyZNXv
         Na9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5+E6fxZHhZpMPQrMUi7X3xQvYDVzwgVut3YjfHG2vYg=;
        fh=GaepY7hK1FuC6GkrY3zNb83EAbyeWBuABoIQ65K3xBI=;
        b=n785VEZfS9vB3ENOQMFjsS847KBmQPNP27ixr3ORHIzEIS9luTDG7rtap4i6JA6Dbu
         Bh3T1bR1s8ikts2MPs0TfxH8IBD+U1k+8IKZXei2AbOL6Kx9pVtxXRv1jBInEp1xqfXq
         ehkOrNkzBwRLcWFbRLfw5ZakcoRQ1qjasKgUWxaOA8dgNAtv4R8ousOtQUrRMHyiK1Jx
         J9V8NS7POu14cojBFkxUH8eFHTo721Y5Z2E9i6lvdrJiRqbPyJnjOsw7BJUOMDvza482
         11enDkFe5Lm6Ddttn2u9c97Y7rbz8lVi3dx4y57QcM6Og2z7WtUjpmJ+L3wtvqntu30A
         OV9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782958587; x=1783563387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+E6fxZHhZpMPQrMUi7X3xQvYDVzwgVut3YjfHG2vYg=;
        b=QuppleXx7IENM0HYAq5Nknjnjgj/+GIZqLz+ImFHGeV4W6RaSHPz9iUt6Uj3CLWXKg
         xwNULfpX3rmRs1q/kuwKPLWp7317G/lPNtFrF0d1UqiJkKA1KcNrLWscgOg4A2oxa/SS
         S5fWVmfpx7vs4ZlEbvKz1EkcTvgUcNXL8CkW+109msN9ZyHFWoROGFvTbvYuNmO9732A
         M4UUKOJ0FYLF6tKfaKcSIQASYXsdM8LiLZI219FEwG5xMEThXE5TPS/qg2LRNlfPJgKb
         nDHpp4fUhuSrZvblPYY+rTDBOe6sqtE1ouydSL65fR48dShaiKg4Qri2uU9nVUx8ny15
         VnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958587; x=1783563387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+E6fxZHhZpMPQrMUi7X3xQvYDVzwgVut3YjfHG2vYg=;
        b=puckjx7O69sVmsvw+qls5Xlp2PdNitgprDEY9twvMkJGXivzUvRisjM0y079WoAoMK
         Y7UhSe3cFTG1bF9TYvlCe1XKvHHtTim4GdVzZSJdbppm8Pi6SR7no2qozlODSmzz4z5r
         EAHrnNGng2DPUuPunQtdlKpQqZHhP5kOiCRs4yOh4cLNla/QyCs6trDJlcKRA9TotvqN
         YGTsz7mZ2xJbdBTr9k6kowlPENUNxc2kEfqkcMWZH+dDsl52YSg3SBbzIzYKT8jzd9Im
         Lk56D4N0TQtz/3zML/1MXQgMIfpdNHyn/mhYY4HbyYpIQ0x2pd8RW8p4psGBKqwTWSRI
         Th1g==
X-Gm-Message-State: AOJu0Ywd8EwsUl11KGu8F4cG0SHaJ5effMbp4uIheSB/m11T3zZ4SI78
	iZp88Wnm0nSROPrfoHXi2LF7zNltrQjG1AvJ2bvQXsQuXViBIVAAlCBCb9FFOqSIcb6ax4W0smc
	Q0HhhwXN4AhPx1A9+/2tETkudCh673Q8=
X-Gm-Gg: AfdE7clnB/4I5JN1LxEGFyskwcC1Z8XI5Q6cLzLa55xs+bPNIaPBXPSe758+paJpKbN
	q3Z0rv/SEZ8QV4tnknWOVCV29EhokeNmPQL715hhS/igWaeHn3tDE8HpwUEzOuUKj6xyVWAYtwa
	qRf3rnYGDv9M7uR0E9C5IsIM3jkkW1knk+XWZyCktyYWNmy0Evg6esuOjLvx0jcYV22+ll7ornb
	TGFKSGRJajCjXR3e+vNI8/qdPITg+qacRjiZojX9GerKyFtbTZn3KIbI33BRJrARC6AzBk9
X-Received: by 2002:a05:6a20:c784:b0:3bf:6936:4f5f with SMTP id
 adf61e73a8af0-3bfed23ad12mr4987214637.17.1782958587062; Wed, 01 Jul 2026
 19:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701023619.2730136-1-linchengming884@gmail.com> <stable-reply-mtd-macronix-66-20260701193800@kernel.org>
In-Reply-To: <stable-reply-mtd-macronix-66-20260701193800@kernel.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 2 Jul 2026 10:13:23 +0800
X-Gm-Features: AVVi8CfGZpX1FhXQPqVi_FnLTDouMKKJJyWOxj2Gb50T8p0rk49KOiDYNFDb8jM
Message-ID: <CAAyq3SY48RRSO1nN-uRH7HVnXbnvQ1_K823Lc_hRsCyVuf9L3g@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org, 
	mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

Sasha Levin <sashal@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=882=E6=97=A5=
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> I can't take this series for 6.6.y: patch 2 adds flash_info entries
> with a NULL .name, and 6.6's spi_nor_match_name() has no NULL guard
> (only added upstream in ac5bfa968b60), so the legacy probe-by-name
> path can oops at boot.

Thank you for pointing this out and catching the potential issue.

I have verified this, and you are absolutely right. The issue stems from
the strcmp(name, manufacturers[i]->parts[j].name) evaluation within the
legacy probe path. Since 6.6.y lacks the null guard, passing a NULL .name
will result in a null pointer dereference in strcmp() and cause a kernel
oops during boot.

I will add the .name to the new flash entries and submit a v2 series.

>
> Please send a v2 that either names the new entries or backports
> ac5bfa968b60 first.
>
> The 6.12.y series is queued, thanks.
>
> --
> Thanks,
> Sasha

Thanks,
Cheng Ming Lin

Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC21474CC
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787802996; cv=pass; b=QlBPsC1Y3bGiH3pFsKlXxiCgzbueW60L32jWlMGQcWDOy0h+yb4tE8MciObmLTPPtwBKmxP6S2bnLqytITVCziv3ajN2NiIzIgfOV+LUIw/I5/hdsI8LddNsVoc84bHuf9FAqPJnAtO6k6hbRzMKy0cdaRLgRymk4wKuyBJBS00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787802996; c=relaxed/simple;
	bh=4YhYn5FSlPPx84gvttWg80Ipc0md//aTq9lSol72NVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgqP280Pc0Ow2seQznvaxvsYoncJjeG6gNbuwojINbIB+hdtI6qkwHk872TWJkepkU6mNb4NE8mPlHLzZVy5jGUJjtbZ4VR8AGenwGPAKAK+Wg01gz1N7C2K7pW4AUiXGCcvLBRNr6PGxtBxuKxnx3wvBali/pPlZO9vj2myV0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q66HE5R/; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q66HE5R/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c86945164so13718181fa.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787802993; cv=none;
        d=google.com; s=arc-20260327;
        b=JetALNL5pAnQ9xYoMOKm2gsBTnOdMUHn99A5NGATvBI3PP3bzuuaSIz5+ClfPIiJu/
         kMyYV+mmRYE/AtSSnmEl1gI/QmDJ1i5EWEWb8xZ7HiPMEvLD7aJ9soLaoq9VLlYQ5fsg
         2h81ekRXQVoWxD15TGe0dlSzaGxfHozcYwKRu+UWy6lYK5POBvzFaEm2re07YVvmymJb
         0WcTPTHaNxZ8+S9wYsldFPQPxRrY4slS3LuBGmURgf0+m6tNN7BMEbYArxpRsDfwWHQe
         QyCInpFU2jgNJtIfPSvFdr63ROxtaCMjE8k2dtDC6BTrpSskBu52VihC/om8Eki/j0Fk
         eqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhmHfBCxwPWUairZ9+s6ng99fn2LZtkTw0G10u+xfDk=;
        fh=pdoSZ5Xll/ImSIM+NILii6opt2pGZwSRQshvy4h2xcE=;
        b=RcLdUzGPmgjcgzasz+BdWm7ObpHoleX32oqnIHtZZP6FdYL65NCGlTi+GkQ/S16HAM
         GQckaRDnOKgdbTX9Vu0KxzoTiH42Co2hhm0HeojCZhlbyj0L1GxJIe7vuIlMeLd+UQ/x
         73WnFxIgSwxQFOzS49T/C7mREUtl0tDT0Qu/Zp9tfExL3KE40VI4RajpvV/KFpSx5Mfg
         T+UuYqB5Ldoq1rlrVsJbTkAp9U1FgKY1yYdtRBVT1/tlYaCEg7yLEjdBZzgKQNKr66BF
         Fw+yjuiqVbrQkXLKPG3a7f+1PPkSNwcCvxTdl38la4rieAeDjBplshGhhDbrOoabkbHT
         wcuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787802993; x=1788407793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MhmHfBCxwPWUairZ9+s6ng99fn2LZtkTw0G10u+xfDk=;
        b=q66HE5R/GoOX0JjShNlrmv//Lg23/9HXmHDRaqdrglasD7bPuJaLk2zdLWJpUyzAcz
         UHuAlegXqBMXmYr+kBKkNowGmSAHdyVnKr0uhls0oc40dA33TugpD0mY+DCkSprG/JQi
         jdUwjPWj00qb4wwdSiYo0nfHRaoFfogNr0pPm8oXmFplxZBZvUzYJJuHmcwXmr8P2cFs
         OSnNmlYBmUGIAQflafBhgobCrLTXom/jknrwe6q/Nwku4SrdkBz/5OIlFCwixlHeVF1M
         sCyAWT9EHnkGBF2nXBUP4pZyEKq22S61Vc+AkQGli32gYqEharC9O6N18Iu59bcgQbN5
         FKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787802993; x=1788407793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhmHfBCxwPWUairZ9+s6ng99fn2LZtkTw0G10u+xfDk=;
        b=PrAQpMnaCNDam8CTu4etnP+jmqQgPbvEa2/i2lXKwg74TWSFS/J0lKGppeA3Lb/ixb
         Kky6gF1ScD74kOTkXHLpTwSpY3F2SEZzt7ssIGuYyl9r9yryxHfatMlfMklIMQt3Z4h1
         j3NelnuIramYRJ3FTYFreqvQnxS9PGJAcBOX25lAz3bzbC+rdiFaR+EsDnYSJSpYQdH9
         qOxBO1MFJRAVfqKzQZZ+KFyYlovUsudVdrMQ4Shgdh3HC7dfleqF43ttbdZw8tlTwESl
         X4Aa28ZcK1DQpyWb1CBYFSCHzDip1niay/tYK+eG3uvW3PfDvP45FM5Ifd0fhe9lV3Dx
         SSRA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/6fbVKNaNFALWtYaDeKvz6hp9plG6xMvJNOZ5dt2YgWsKbkuinksAjWlfhvXuJVxoa446toQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lYRz+EVStuUDz7Qippc3fPdtxjDJUDMB9nYM1HocsIbeRFovJ0
	+oZZzj6Pvk2pJEsrR89tbfGzSXxi1PxnuAN25H9yFzG4ntdF2Hplrgea7EI468DL50OAcsK1lzn
	nBcD0nFJ4XYcUEgY0ZO+KCw1V/y/2oXU=
X-Gm-Gg: AR+sD1399EqZVZ03f/96UB5QZB721EzQ4QBKtfm77GbbMPoS/dTFZtixxz36u0Sm+p9
	dC7mPB2+cW/SyIsODPDlYZ0rr5mBe5cWHjJ00fLH6MADN99vvVNE9FT6XkcU8Uh2I5/H94Tfc1F
	JJPZYGveEDxbD1JEKydDU63iyvuZb2m5TKcxYQHE9NaYeGyHKRUyfmOBDz2xgi4H301mD0CDRcQ
	BB16don5y3HcunsXRc3l/lHB3BX1pE0W14YtGwRGWySfLMiVkbT75P9V3RSjmDZpq/Ky7DeVwPt
	boxDCe5ZuoaI06/8Us44Ijx3viiuFuPJBJgnEiIpu0Dv6HA0AwAiIQNg
X-Received: by 2002:a05:651c:2124:b0:39f:75f5:907d with SMTP id
 38308e7fff4ca-3a1fd454d23mr24384781fa.2.1787802992881; Wed, 26 Aug 2026
 20:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824075935.170457-1-zenghongling@kylinos.cn>
 <CANFS6bZczfbx3HKO9pN2wOm9Wy8oCX0GAA_uAoXzhu1j34Jo7w@mail.gmail.com> <6A8D37D1.7010800@126.com>
In-Reply-To: <6A8D37D1.7010800@126.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 27 Aug 2026 12:56:21 +0900
X-Gm-Features: AcwNN1W4ADiFsA1DExE0Miz_nGo___YnVaIMS7fjmTlaGnkmeF19MvmI3fsDMKk
Message-ID: <CANFS6bbfYTTyg_3vUi6i42mGczQyAVeQJc59SMvcu2xqOg5y8Q@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 25=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:36, H=
ongling Zeng <zhongling0719@126.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> =E5=9C=A8 2026=E5=B9=B408=E6=9C=8825=E6=97=A5 13:45, Hyunchul Lee =E5=86=
=99=E9=81=93:
> > Hi Hongling,
> >
> > 2026=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:5=
9, Hongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >> When the record shrinks while the payload offsets increase (e.g., enab=
ling
> >> compression reduces padding, making arec_size < old_arec_size, but the=
 header
> >> grows by 8 bytes), moving the name first can overwrite the old mapping=
_pairs
> >> before they are copied. Move mapping_pairs first in this case.
> > Can this situation occur even when
> > it is not a crafted image?
> Hi Hyunchul
>
>    Yes. This can occur during normal operations when modifying
> system.ntfs_attrib
>    on a file with a named non-resident attribute. The header grows
> (adding the
>    compressed_size field) while the total record shrinks (reduced padding=
),
>    causing name_ofs and mp_ofs to increase and creating the memmove overl=
ap.
>
>    No crafted image is required - a valid NTFS filesystem with the right
>    attribute layout will trigger this path.

What I am wondering was whether there had been
cases where such padding existed.
I has been considering where we should guard
against that case.

This patch looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

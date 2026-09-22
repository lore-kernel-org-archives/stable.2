Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B52361970
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040430; cv=pass; b=oMfN95kzQ4dBg1kzIHHGzX/mDkObbVZmR6zs2TD+IE84wFIPniDXrvw4o/oP4qndV3MS8FfSHhdHnOdv7BqsrcTzlnrJLL0kHxkSmrtGFpiPu6h37SV4j3CZrTx9WMjQgaIFhLMzQ1ugfW/t6WorIxhtj/ohPpzbQWgH55yxFl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040430; c=relaxed/simple;
	bh=mGJzwjWcciFg/IdZoQQK2Ap7EfoWAClw2S1eI36ylWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swrw8dRuNMrz3JJ+VePb2gfXf1a1pd3Ivbuwvo3Dc5rof9utrqPLmZAz86GbAJimCTUii54eBb3b6hOTw3gklmh2rfK1qpPEDYtbvYEYmRzRNsbyA4lPLKLTPYx3eQ9AyHjbE/XJxQzP5eZObjQqrTk4YV1xYTdaZ18upQ94lmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhUziFZv; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhUziFZv"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so3487457e87.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790040427; cv=none;
        d=google.com; s=arc-20260327;
        b=Qwm0+qMpb5C6gYoHTT2HiNkmc8BlDH2BxBHXScBJCJl/v8BOWva4s4Hr24fCC8dHyI
         +kcDCXYoLcktyR5ypONtlZMNtMsqytq4qUCHme7fJCK15gdHP980zxipvNsHM8zEu1ia
         G1Rnf3uFTOw/sstvIPBcDoaPlRBBSUaEwInSG9Xh9Z96rd8Mcn98G9AxiKRT+rOGTr9r
         hChE/Aue2AhSb2x7lbgoWpWvUElKesXLSL2pclM188Ov8KLEQ/qFBpRuCAshg8ribrrD
         euru7T3Bc9ReoTa1IuaFwHLR+X2NFtn5sm2XpCcOm5DyOIhhHz4iKC2EASh4N0KD8yoo
         qqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BANAs9OhClkxmYfYq7iCdVo5PmXyftur4GxG4QYIy6k=;
        fh=YLJKLCNTOJ+zwKrK1Pse5prP82z1RUcN459xGEIg07A=;
        b=VMWZ1VmvhtYVXi+OZEDxTw/QSIJRrr0pKUDVRrmXIsazK84VdtLiRDf/giPG4eKmS9
         5tTIavtwF0HqvArc8Wu04W4gvcldUkLWasdu1TfRVbGHWzJOYDENp5T+ke1MxgZRE249
         TQMj87XXNH1ZlRtiiBrbMyqvlFr2ZKcWwCvM91OWwdhsYrKtdM/MKUEIde/kjFGYqvh5
         qy6mbDBB0wIIoYkDlGIPysFxJGegWNMg0Ekz7ZrgyUX3iw3pqAn768V/XfsHBwzTZwHe
         AjVINTjAoijNOHsOAPZPRUYwDf6em1MEOpMg2yZXk6R2QECRKaNMrgKkLGFw4dYtjfFs
         PR+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040427; x=1790645227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BANAs9OhClkxmYfYq7iCdVo5PmXyftur4GxG4QYIy6k=;
        b=hhUziFZvaq2cZLpbA3hOaTjGjcqUVUm1v2MeoK6PYUkSCcAzT+HWh87Qwjxwc9aptb
         RLSlhN4mTIh1cLfoErwppljbeEonUfve1HGh3T79FH0+vxfWpp1bxxghPTKk9Utw8nYt
         TtS1gzI0PyRMPuwa+NzPHmxvy7cPFTFjJVtDkv3u2oD+WJLn5pcWWvgrvacAh3ZS6GMj
         on5YJP3LJGIXBlHMMjd1EPWGAGU/u/Ng3aI+tTXYqk4kVCrB2LjV1GBxVcEkJR3TEvff
         a8Qc8Ek54//tJM3pAhwGJAApAju0WQvmUeC2FIfLyG2wpJw9Wpldhz3hw4fDxXX1J1MB
         vLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040427; x=1790645227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BANAs9OhClkxmYfYq7iCdVo5PmXyftur4GxG4QYIy6k=;
        b=F1JzamjHdU9wnNE0bzg2LN7MosJzQhCBAKlZUyrnRa1c2mkx82vf8nfglKRsT/ZgC1
         8toTcylh7bFVsSjblVpP1lWtJaljGmgle7vtC/b6iAulMHNLQ9K4YabIVOidnxB4FKZ0
         g4ulOc51AbzNfUNshTbFAs2EjWRMx3uRsK6jj7OkS6xvDEw7aQ+VsO6VlGE7yaAxmosA
         54rCvAKr+pPUGC+up3b/jX2+TrEsbjTZkZ7y640UVIZo7vWLk0l086WbGa9d7dTpFbv+
         3rFOADCFPe+1PwvsGHdOwhFFNOzsRkAdeSHsHSluNEqBpyug7OyrlSSHyPyD/Dp7lXJm
         ojAA==
X-Forwarded-Encrypted: i=1; AKwUvBy4yxkzY1AXof2sYPzJXehCCvoqfI9dOp211CllQIV7Fid9ZGboYKa/Zf5HcFOd6ulaFcXwnto=@vger.kernel.org
X-Gm-Message-State: AFuF++mGOKnjrgFuIeUQX2/A6sN77gauhnvFBOsM03FA8Z/Jimh6y5QI
	hh0XSdowasFp/LGtBNayxMmX9z9+wKxTM2/IDTPee8RxRn+VMp/MKpRh/HADLF8Xt4tjPE8gKk6
	f/vYr0R4InmIGqizJp5jYrJDbOIvUhjc=
X-Gm-Gg: AYBFou0Jc96oUb/irgmEjSzwtDmXrg2Sc95GZ2vUA7HaswlimYmXbwDZI++mElV03QI
	W8M8BrvaH2wMDloIK9FbfxAVhPSfLN0vctd/P3GaM2c87ORWJjYaBhqCSzhQEaNMwV6YNrF+dyP
	4yfAdbcoaihVV/xnokeUtBTpr0oGly8w5VeObG2RLoynBAjxm+Y22eOZkKAvsbiA1rjItrv1j1U
	IG5bD2qejXeZhD1Sv7A2ObVtgpan0T40pTvT8raW0dpCn+itpkiiRAd8r2DlmigknXfymlsnrmE
	QRwGXVv4kNPThIox3HHPWOvum5qivLLFH0ahHUG4iYS5ZwFZ6UDiVm0l
X-Received: by 2002:a05:6512:2396:b0:5b8:bc5e:b576 with SMTP id
 2adb3069b0e04-5b8c18521ddmr3616977e87.46.1790040426727; Mon, 21 Sep 2026
 18:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920025955.31209-1-zenghongling@kylinos.cn>
 <04255390-4133-4e8e-81ad-4d2402498431@163.com> <CANFS6bYLBPr+FmE_MVWxBBMw+Qz55EFfy1u6UmBgkTak2CMyvA@mail.gmail.com>
 <4e70c6d0.7644.1a0c34d327f.Coremail.zhongling0719@126.com>
In-Reply-To: <4e70c6d0.7644.1a0c34d327f.Coremail.zhongling0719@126.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 22 Sep 2026 10:26:54 +0900
X-Gm-Features: AcwNN1Va4nHWDaoD6YaeJdDBsOK1DZQvNPVRpGTAPEu1genIzPZ2AwReUginLuQ
Message-ID: <CANFS6bYMbh3oJbSFdFzEOp4NpZh7YmagqamYXTw8iHueFm6KUg@mail.gmail.com>
Subject: Re: Re: [PATCH v5] ntfs: mount hibernated volumes read-only
 regardless of errors=
To: dd <zhongling0719@126.com>
Cc: liubaolin <liubaolin12138@163.com>, Hongling Zeng <zenghongling@kylinos.cn>, 
	linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongling,

2026=EB=85=84 9=EC=9B=94 21=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:30, d=
d <zhongling0719@126.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi baolin,
>  Thanks for catching this. I agree that temporarily setting
>     SB_RDONLY
>     makes it impossible to distinguish an error suppressed by
>     ntfs_handle_error()
>     from a successful check. In particular, errors from optional WSL EA l=
oading may neither propagate through the hibernation check nor set
>     NVolErrors()
>     , allowing the flag to be cleared incorrectly.
>
> Hi all:
>    One question: with errors=3Dpanic, a corrupt $LogFile can still panic
> during load_system_files(), before the hibernation fallback is reached.
> For example, ntfs_check_logfile() panics on "LogFile is too small".
>
>    Should mount-time metadata errors generally avoid errors=3Dpanic befor=
e
> the superblock is published? If so, that seems like a separate follow-up
> to extend the temporary policy substitution over load_system_files().

As Baolin mentioned, I don't think that mount-time metadata should
generally bypass error=3Dpanic.

>
> Thanks!
>
> At 2026-09-21 15:57:29, "Hyunchul Lee" <hyc.lee@gmail.com> wrote:
> >Hi Baolin, Hongling
> >
> >>    If you agree with this approach, could you please incorporate it an=
d
> >> send another revision? I'd appreciate feedback from you, Namjae, and
> >> Hyunchul.
> >
> >I agree with this approach. It looks sound to me.
> >
> >>
> >> feel free to add:
> >> Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
> >>
> >> Thanks,
> >> Baolin.
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> >       if (unlikely(err)) {
> >> >               static const char *es1a =3D "Failed to determine if Wi=
ndows is hibernated";
> >> >               static const char *es1b =3D "Windows is hibernated";
> >> > @@ -1581,12 +1594,25 @@ static bool load_system_files(struct ntfs_vo=
lume *vol)
> >> >               const char *es1;
> >> >
> >> >               es1 =3D err < 0 ? es1a : es1b;
> >> > -             /* If a read-write mount, convert it to a read-only mo=
unt. */
> >> > -             if (!sb_rdonly(sb) && vol->on_errors =3D=3D ON_ERRORS_=
REMOUNT_RO) {
> >> > -                     sb->s_flags |=3D SB_RDONLY;
> >> > -                     ntfs_error(sb, "%s.  Mounting read-only%s", es=
1, es2);
> >> > -             }
> >> > +             /*
> >> > +              * A Windows hibernation image is not a filesystem err=
or, so
> >> > +              * this is a safety interlock rather than something th=
e
> >> > +              * errors=3D policy may downgrade.  The super block is=
 already
> >> > +              * read-only here: the temporary flag taken for the ch=
eck
> >> > +              * above is not restored when the check failed.
> >> > +              */
> >> > +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> >> >               NVolSetErrors(vol);
> >> > +     } else if (unlikely(temporary_ro && sb_rdonly(sb))) {
> >> > +             static const char *es1 =3D "Errors were recorded durin=
g mount";
> >> > +             static const char *es2 =3D ".  Run chkdsk.";
> >> > +
> >> > +             /*
> >> > +              * Errors were recorded during the check or earlier, e=
.g. when
> >> > +              * loading the LogFile.  Stay read-only, like ntfs_rec=
onfigure()
> >> > +              * does for volumes with recorded errors.
> >> > +              */
> >> > +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> >> >       }
> >> >
> >> >       /* If (still) a read-write mount, empty the logfile. */
> >>
> >
> >
> >--
> >Thanks,
> >Hyunchul



--=20
Thanks,
Hyunchul

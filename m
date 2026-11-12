Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794488114;
	b=emxAhrOtZ/r4k2/P/4tnrArwtGiG8JXBBqk7SHX6TsnzmN4K6qXIdoDrzmFt7NnFcrOk
	 GylzJLpfK4E6RfmyIb6WT4tZKFBOx0o+X37uH91+HWucHQOuZZzbluhnUMK4ZrSklZDb8
	 4YAysR3M0Slipl5JC95rDEFeMD0c1eodRXDA+uzLflHeV6zIOtFz+um0ExeMm+ERmluoO
	 5s3koXAn8Kv/Z/IFHdYMIX/bpjmi9BmURO1DXBnwpEjBzIyDOWyDu7z7nFqiEs6Y7pUut
	 D+dzwO+5cGC7m0ce+JItGBSVAl9BEi2dm6NEmPxbXF5688yHBRom0Wps0nXTnpOiX2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PBMKYmwNElZuOIl+rN1DVV8FCfwrcJ3udl/MwzFva6Q=;
	b=IXBJxjQxgduYIhtC6B8gcE5LlbXjX1rzG0hUcpPkkt/LuLe3u9vJ0nJiPyv8pomQQpLQ
	 82FshlFNCDfUGlyTtdBDUeoBMvLiBD6NKX4LSSHVplOdl/GjbSWLkL0PQ0/AZbpT4X8Z9
	 lKFkE+oLb6PKNh4KxNKYpjOFVX281EX5GwcWoXlKVBgR8UnhLTitskCgdGTxR5TSC2RfX
	 ZFAsLf3V1dMHA9bWjgYG7LG3YA+/K+VBaxxinuyy15LOZvsMyQrxjgoUcs0Bhh5rv55t8
	 Mw9SzabQHEw8PX+Js82ibJXwEBvihQkjA8+lRkOKwAtUXHCQO8gCPVjlDp10/VMXDLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgxBjzCj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B0606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgxBjzCj
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b32b2e691aso8125457b3.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:55:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794488113; cv=none;
        d=google.com; s=arc-20260327;
        b=ZW77JdGu93QeLNzu87ppCdi64kNkoAYHXt1rk0mJvASnuEbgU5R7YbAyMrdQr2/vAc
         kTdawieBdCJFl1nr1x0YALXxm8jKD/NgKVbPLRcXMU8KJ43P1ifu9aXaMdlbx9aRD7T8
         6hDjLDLaTFascv1x7y4Z3ao3hQ0TGLEZmU/b0YA6c2wpoxsOwTZIQF8KmGS/562FJHT2
         J+RPpHjNjD6Nkh7FZHPzGRiMx6WkMOkkccyT7IzS0X0zpMGUr1Np2ohA99pw0XsydPpD
         OrJD8Xu4AnzdcDyS3ufqkA1TyCVBaacr+pIoaAeVjx+Rz0uITS95jQ+C9gCODWlRSEP4
         qufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBMKYmwNElZuOIl+rN1DVV8FCfwrcJ3udl/MwzFva6Q=;
        fh=wvI3ZNAc5BS0yNA4Rg0yr+0TOZstoL6Bn/qpGlKCnyo=;
        b=UMxpawz9fKNDXLuh0G45S95w7JGxJx/p6pG2gIX/Gj3mSX61rubpeaGKZ1k5KUxcZ0
         AuoRAMVHSksC6mbASsEqJlUS+3OaAWF6nA9qUFa1mFFkDLp4vTPy/MMEo0nVhvsquVvL
         k0t/EHHodbxMlFTL8tinlXZCqOxxVYDwZaSggGSfgurm8HxxWuAHjRyYR2Ikz3TZKfc6
         N0xHuFTRKwxnRHYIXvqssBnSVTSVONhuuGGZX87QaZHYbC1StpRIUV1/+G+9fX0NTf3w
         H41sDZuJHuAnlpEH97CL2C7k7NMd7psL+buAS5DDgeKiiK7BM3UUI9dQuGAFQ7Q2MhSr
         R7tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794488113; x=1795092913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PBMKYmwNElZuOIl+rN1DVV8FCfwrcJ3udl/MwzFva6Q=;
        b=CgxBjzCjzfJocH+1coRkX4twN1uPlp+A30VBlJWv4aBPEhLhtHvUVSfQ29uPFwLJ9h
         ndKWKT0JfOkTdCiApBcJGbKnoeBlNHLlgd3E61B728F+HMZTBXxP93jMEXLOf1rRVCaJ
         6sCERwq9PYtmxhWvKQviFkLc8Wp0cYO6Kd8yELQ8JPknI5QaM8oqX3w//Ne767Wrt95X
         RBslKs0JKpHNkBfUpqvfXE687FOQd9Z/sDqBwnEJ5onX8DE2scP6GWv4U4TONVygTqEG
         YNB33EU4BLlLXfJgXffkwT7jF/nXaQPrsbXQpztpy2soi7kscuQsc5A1cXRaJRiyggYP
         M8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488113; x=1795092913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBMKYmwNElZuOIl+rN1DVV8FCfwrcJ3udl/MwzFva6Q=;
        b=P0mFx1GcDpSa1rx1R0XIcGFBS1PrlCc5heKLdhTmtH//ybvvrIpi6F1l+D8tCsHpcL
         rHJmnUJfm5dwsw+VuuZOD7M5nHPNJp9CaKKm/zTDzWfoWDaW0DVsU56IszjDDbp4OpRe
         FdBegQzRgrdoLicwXlnvmEO6/iQKsBhfkB8MVWAxiXmmrE2jX7WUXsppe5UcEAphfuzT
         amoGG0iGjGS8MTz7zotoZK4tnQCQIaRPftCbAxGA5/yVCwUGQahqaF6CmVDGPHKBckE1
         tBxcVcOhlEfnvbPgLwF4jKszgZsMYLY2FNlPgZ/ocmTMI8F2g43CiGiFRj1RSS7DFI67
         +IvQ==
X-Forwarded-Encrypted: i=1; AL+hErGSG1egl8suD7sLAAcceQ4+vRmAbc5lP+JAUFnHVvhcjFtES1ea3fWetTqGQyG4vy+bvIt5dwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gtp4iFwBkjyMv7UIMunVPyBAIALmT5rzwZGHBgmXORL5RO/+R
	13gUT0kRuNcnP0Dkb0AvdePW8LfSxW6+GXyI3FcMvS1GKXTmkzytIPkc8JgNhaKmPECd9b0cvdo
	JPbMBYZjwOnxSZEMQ+jbjzSoOjNBduKI0m/yKCHyYcg==
X-Gm-Gg: AYBFou181AdwwCexBkKWJohpNafyD3AestZUfpfAazAFvY8DMymCSI+e2RiGFi3jmlx
	9SU0m0OdeyTMCjnyMHesgBdY9K2I/kniagFakwyCKPSVdzjoAhezG/tAM1uaIKNMY5gSLTvkzaq
	n3aOawk4MHo48D7o1bcO55wJja4tmCNSTUR+YOCeVlKzWNQW7PCVOg0mHO8T7K8vHWDCzCAFDgi
	5U0E+DDFkz2JlOPc5P42r/jZD5kCtnXLWIf+AP/jvTSfIJ/xvA6bZ8MWqXXxAxihRCuLNCA4Dyw
	iDzHrc2gz4uM1t6pAeOHGYqoTXNgKBcMAHkZ/xAwojAadU8OArEEjaN7MkqhNp52nJ9xCjkf1d5
	tWQgAJnN27dcYJoQfWfL6CzpCqDKv7V1DkJRg6aGXm453TAfRH1b48vPsLv8=
X-Received: by 2002:a05:690c:ec9:b0:8b3:50a5:b787 with SMTP id
 00721157ae682-8b3bb28a0eamr19804477b3.33.1794488113399; Thu, 12 Nov 2026
 04:55:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANd6Td+b6ituLFzkhvX09vricCY541fQapNOk3rTa=74zWA5LA@mail.gmail.com>
 <87ld6yrzs0.wl-tiwai@suse.de>
In-Reply-To: <87ld6yrzs0.wl-tiwai@suse.de>
From: London grad <londongrad@gmail.com>
Date: Thu, 12 Nov 2026 12:55:02 +0000
X-Gm-Features: AclHuK8BcHMeGJFNiJTzPTE3SrixMzrCmNJlLHRg_HqhW3ZGuN2ApleDHNjBIsg
Message-ID: <CANd6TdKdRftWyo5Cg_85-fBVGW3oHAntEY-DdCpQCDSyRpOprw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: ua101: reject mismatched capture/playback packet sizes
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, linux-sound@vger.kernel.org, tiwai@suse.com, 
	perex@perex.cz, Xiang Mei <xmei5@asu.edu>, co+24304d323d28f156@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for the reply

I don't currently have a way to revert the commit, but can confirm
that the interface works fine when booting with older kernel 6.8.0-146
from Ubuntu.

The 6.8.0-149.149 series were rolled out earlier this month, I updated
last night to -149 and this morning the interface failed to
initialise.

Best regards

On Thu, Nov 12, 2026 at 12:37=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Thu, 12 Nov 2026 10:25:39 +0100,
> London grad wrote:
> > Hello all
> >
> > This patch may have broken ua-101?
> >
> > Kernel 6.8.0-146 still works for me
> >
> > In kernel 6.8.0-149 my UA-1000 fails with
> >
> > `snd-ua101` rejects the device during probe at every physical sample ra=
te
> > setting (44.1, 48, 88.2, and 96 kHz), leaving the interface unregistere=
d in
> > ALSA.
> >
> > ### Relevant `dmesg` Output
> > [ 2622.796887] usb 3-3: new high-speed USB device number 5 using xhci_h=
cd
> > [ 2622.928793] usb 3-3: New USB device found, idVendor=3D0582, idProduc=
t=3D0044,
> > bcdDevice=3D 1.07
> > [ 2622.928798] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber
> > =3D3
> > [ 2622.928800] usb 3-3: Product: UA-1000
> > [ 2622.928801] usb 3-3: Manufacturer: EDIROL
> > [ 2622.928802] usb 3-3: SerialNumber: ZT02743
> > [ 2622.934792] usb 3-3: playback packet size 560 too small for 15 captu=
re
> > frames
> >
> > Submitted bug report here
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D222261
>
> Could you verify that just reverting the commit fixes your problem?
> It's quite possible that this patch is the cause, but just to be sure.
>
>
> thanks,
>
> Takashi

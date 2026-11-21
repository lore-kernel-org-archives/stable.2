Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222672;
	b=l9sFBnoADtKbRNthR8rv/Dxp91J1mmAGF7KTt1XVeCSN8LUOViXy6GCAXEsU/zYc5XHr
	 /1coEnu2umOuRDhlbHHiSNh6W+5EzpqBNLTyH44Yi48f6jv33tGi+bZ5oeUhiLpnTz0bL
	 twhLl0ewnMz/S9D2nltZzLEFQgbraqaH5R8YfjwpyL7Kr1xmVcUlpHPGH8hiQYh5JcYCe
	 GDo5yCYfkrIcnpPaJwtEyT6dvcKoe4BzwTmSx3AayzdDIiIO9PObopfGGet2lbjbLrqIA
	 rAcbXtdYU54ttghdzDSlwkGZIlNco8DULBpzQ+UpFZ4eY4+yg6XwKCvabJRbv5/bbSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222672;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pYuaPAfIlTcB1O8Ap0wBAp+pFIs1WlVk3EpGd7ruOeQ=;
	b=eC0+ICx+bCXQqtVhNxtbglww6McDZrFaX0fYDM/9FOrM4/MuFW1hYrPRNRrAUeJDSRDk
	 ftFZDN3PAtRm8UBSPuEyQGTZJ2lf7I0r1musdDlcbLn24RaTZQUd5dEEeR61F2mzBm8eY
	 BjzVRecoBIQkGxLtTgX2PFvx3vHc67dPQE40EStHE58UHLVYVUnp+VTcd7twESyqYsyYP
	 MHBYqEf6bJDDKR1lL3+vIjHX90QDvxJWuw6sq2QpaK3pEkO/MlrQ7EHS2R2DX97v1M89C
	 Oui3p79dvUsYtfCXXW05ppjD3OmpX7/R7//6OCIytOOAGVmkcvZI1So+ar9lm4cIoug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrPwbDK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39418606A6A4
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrPwbDK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B2A1F000D1
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795222671;
	bh=pYuaPAfIlTcB1O8Ap0wBAp+pFIs1WlVk3EpGd7ruOeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OrPwbDK8c8VgXaGVC4EZ0R3FQT+UV0oocsU5RvXjR09bMWaxfjfkY3BvOQUioYdHA
	 wvoRyGTzLi6OwFryuRPY/G4wsf/P0xkgH91xeBpW0A6zB/6N6V382gez3ZH8n3t1Xt
	 J1C2Toxer3RzZg7+ZgGHjNa3/Tppvj1EP31XmHh53QF7zDeuYdIsLuA3gr5rF2tGJF
	 t+1DBaU8odFD+f6AI/UVXfm3YiQN/Aakwxlwx7IzLSY6PjTc1b8Vqb6CI2yJuzXHat
	 LM9tQXdRZqlP90apyRqDgFg+kE7VbjceAXMn3Fc+PubgWJbQ44N0yGNOv2kT3yF3Li
	 /cv9N607NiP9g==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2210042a12.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGt+vX0LE1Aw3CQ7Ox1JK8FPgl+A0KgH1VF5ViJrOzWfifDHTTyFJrypCaUAoR7634nyGrz+IU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+HeXLVUaCd2Q20uyc/xcB7J95h9ZiKhxuG5uYpYpApKS14iw8
	DZn015RfShQOTMEiAHkPdlOMkuOBpHesB3EpmOA26/nnVyJDUwtULrC1xkqoEaIj6XcXOZQvmbG
	M/thnHjEcbGQHIqpEfFgL6FXZNKxY0Ts=
X-Received: by 2002:a05:6402:13cc:b0:6b8:854:da16 with SMTP id
 4fb4d7f45d1cf-6ba37e64b3emr3750928a12.18.1795222670218; Fri, 20 Nov 2026
 16:57:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
 <ee94181c-784f-4f9b-8697-cca5abec6b07@163.com>
In-Reply-To: <ee94181c-784f-4f9b-8697-cca5abec6b07@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 21 Nov 2026 09:57:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8VV8hjeEqRLJ-HBDA3Dzw9bX45e6dWpie4soeZ8TBvDQ@mail.gmail.com>
X-Gm-Features: Aa3M54rjQHmBi5vJgpb0m5wm04L5meK5CixRNCQCinayId8QPwf-7sPCDRN0boc
Message-ID: <CAKYAXd8VV8hjeEqRLJ-HBDA3Dzw9bX45e6dWpie4soeZ8TBvDQ@mail.gmail.com>
Subject: Re: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only
 after $MFTMirr record 24 mismatch
To: liubaolin <liubaolin12138@163.com>
Cc: "d3nchk@outlook.com" <d3nchk@outlook.com>, "ntfs@lists.linux.dev" <ntfs@lists.linux.dev>, 
	"hyc.lee@gmail.com" <hyc.lee@gmail.com>, "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:26=E2=80=AFPM liubaolin <liubaolin12138@163.com>=
 wrote:
>
>
>
> =E5=9C=A8 2026/11/20 20:49, d3nchk@outlook.com =E5=86=99=E9=81=93:
> > Hello,
> >
> > Resending in plain text because the previous HTML-formatted message was=
 rejected by the regressions mailing list. Apologies if this creates duplic=
ates for other recipients.
> >
> > I am reporting a regression in the in-kernel fs/ntfs driver (NOT ntfs3)=
.
> >
> > Environment:
> > - Distribution: Debian 13, backports kernel
> > - Working kernel: 7.2.12
> > - Broken kernel: 7.3.4+deb13-amd64
> > - Device: /dev/nvme0n1p1
> > - Filesystem: NTFS 3.1
> > - Cluster size: 65536 bytes
> > - Mount options: defaults (including errors=3Dcontinue)
> > - Driver: fs/ntfs/ntfs.ko.xz
> >
> > Kernel log:
> >
> > ntfs: (device nvme0n1p1): check_mft_mirror(): $MFT and $MFTMirr record =
24 do not match. Run chkdsk.
> > ntfs: volume version 3.1, dev nvme0n1p1, cluster size 65536
> > ntfs: (device nvme0n1p1): load_system_files(): Errors were recorded dur=
ing mount. Mounting read-only. Run chkdsk.
> >
> > This volume worked read-write with kernel 7.2.12. After upgrading to 7.=
3.4, it is forcibly mounted read-only, making normal file operations imposs=
ible.
> >
> > Windows chkdsk has been run repeatedly, both through the GUI and comman=
d line, including dismounted-volume checks. The issue persists after reboot=
ing into Linux.
> >
> > I suspect commit 749357bd48c16c4cdc09093450deca609492f012 introduced th=
e new read-only behavior for this case.
> >
> > There is also a potentially relevant NTFS compatibility issue: modern W=
indows may not keep all $MFTMirr records synchronized on volumes with large=
 clusters. Here the mismatch is reported at record 24, beyond the first 16 =
records.
> >
> > Please investigate:
> >
> > 1. Whether the comparison of MFT mirror record 24 is valid for modern W=
indows-created NTFS volumes with 64K clusters.
> > 2. Whether this is a false-positive filesystem corruption report.
> > 3. Whether errors=3Dcontinue can be honored for noncritical MFT mirror =
mismatches, while retaining mandatory read-only protection for Windows hibe=
rnation and genuinely unsafe filesystem states.
> > 4. Whether a fix can be backported to the Linux 7.3 stable series.
> >
> > This regression prevents normal read-write access to this volume.
> >
> > Thank you.
>
> Hi,
>     Thanks for the report and the detailed logs.
>
>     I checked 749357bd48c1. It didn't introduce the mirror comparison,
> but it did make errors recorded during mount force a read-only mount,
> even with errors=3Dcontinue. That explains the change in behaviour you're
> seeing.
>     There is a known compatibility issue with the comparison itself.
> On volumes with large clusters, Windows 10 can leave later records
> in $MFTMirr out of date.
>
>     ntfs-3g already handles this by comparing only the first 16 records,
> or fewer if the mirror is smaller. See commit 85e208176ffd ("Stopped
> checking matches of MFTMirr against MFT at record 16").
>    fs/ntfs still compares the whole mirror. With 64 KiB clusters and
> 1 KiB MFT records, that means records 0 through 63. A difference
> at record 24 could therefore just be a stale mirror copy, rather
> than filesystem corruption. Your report looks consistent with
> this case.
>
>     I'll follow the ntfs-3g approach and limit the record checks and
> comparison to the first 16 records within the mirror. We'll still
> read the full mirror and check its location, and leave the mirror
> writeback range unchanged.
>
>     This should allow read-write mounting in this case, provided
> there are no other errors. We shouldn't need to relax the general
> errors=3D handling or change the read-only protection for hibernated
> volumes and other unsafe states.
>
>     I'll include a Fixes tag and Cc stable so the patch can be
> considered for the 7.3 stable series after upstream acceptance.
>
>     I'll send the patch shortly and CC you. You can then give it a
> try and let us know whether it resolves the issue.
Okay, Looks reasonable to me.
Thanks for checking this!

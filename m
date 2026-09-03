Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5D3B3C11;
	Thu,  3 Sep 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429699; cv=none; b=f/2Q8mYu5CRN22wstWrQ4LXaVjjv5gTt/J8ypvB4gcWNahqaNHDk8uoIuFy/K/BFdjluak19kopyLa4/kJDkR5q7M2kw16b2zCjj3IjQwyjNAoaJ94cJ4HgECpe+LxyzjB3S6qOfQLl1FRV0TQyJIY49jchtA80Erw2s7BSPnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429699; c=relaxed/simple;
	bh=GH3CzqGYy8DHLJD2SkUKUQsn8Gk6wieYL0uqvzjySG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DspxJnMtl4Zp9hzoEhfK7BS+4Xc0k6GAJEHgasigLHDR/FF3d8V1kX4HhufXGBnFz/5HSd4reNrZTzk++1N9+dnk3t2AvEicvDHvJscrA0PAZWo0J/clAjGJplWK6ihvGhxGws9XBsCfYNXg5KWoF+akQSALuLP3ey4I4QlHxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QG13max6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QG13max6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D55354E414EB;
	Thu,  3 Sep 2026 10:01:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A778B602B8;
	Thu,  3 Sep 2026 10:01:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 589D411C792CB;
	Thu,  3 Sep 2026 12:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788429694; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GH3CzqGYy8DHLJD2SkUKUQsn8Gk6wieYL0uqvzjySG8=;
	b=QG13max6Ym4fBRgbJpbZbnv6VJMWqqu357US/ep1+2zQ2OX4F++h8b3xs7CTxrILtZnxm4
	a3cs+nBV4C0iDg5DpcjxMdo2uwzOMYa6wtnEH0+9nSSN+H8niCE8dDVizZLHGsru8gQX7c
	5GICTTsvt0yM2sxEY1oVfyA1GOLk3//xjGAQh1kBxC47NTNul0n59a9vyQTuL5Nt6oBvyR
	e82FsU8wI4GLPN2AkiiI7sEM9ROcnuL4a7Xv/kNqewy6Gz8FPmHR8JbPy/n0oxUOtzaxIK
	graFW6kBImpJMVsGMGnmMyWkzWBy2MkptNeLyApVMGTpz2aqdgKAUWtOT7WLZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?B?5p6X5L2z6bmP?= <ljp1205831794@gmail.com>
Cc: linux-mtd@lists.infradead.org,  richard@nod.at,  vigneshr@ti.com,
  linux-kernel@vger.kernel.org,  Aohan Mei <henrymei@tencent.com>,
  TencentOS Corvus AI <corvus@tencent.com>,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: inftl: validate MediaHeader partition geometry
 before allocating tables
In-Reply-To: <906239c1-e78c-435c-954f-1198595d62b2@gmail.com>
 (=?utf-8?B?Iuael+S9s+m5jyIncw==?=
	message of "Thu, 3 Sep 2026 17:43:04 +0800")
References: <20260902124044.3942821-1-henrymei@tencent.com>
	<87h5k67ocd.fsf@bootlin.com>
	<906239c1-e78c-435c-954f-1198595d62b2@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 12:01:22 +0200
Message-ID: <87y0di4psd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 03/09/2026 at 17:43:04 +08, =E6=9E=97=E4=BD=B3=E9=B9=8F <ljp1205831794@g=
mail.com> wrote:

> Hi Miqu=C3=A8l,
>
> On 02/09/2026, Miquel Raynal wrote:
>> > is evaluated in unsigned 32-bit arithmetic.=C2=A0 With lastUnit < firs=
tUnit
>>=C2=A0
>> lastUnit < firstUnit? Did you even read that sentence?
>
> I should have made the arithmetic explicit in the first place.
> All three fields are __u32 (struct INFTLPartition), so with the
> crafted header used in testing (firstUnit=3D7000, lastUnit=3D3,
> virtualUnits=3D100):
>
> =C2=A0 =C2=A0 (3 - 7000 + 1) =3D=3D 4294960300=C2=A0 =C2=A0 /* u32 wrap */
> =C2=A0 =C2=A0 4294960300 < 100 =3D=3D false=C2=A0 =C2=A0 /* sanity check =
passes */
>
> Execution then continues with nb_boot_blocks=3D7000 as the loop
> bound against a kmalloc_array(lastUnit + 1 =3D 4, 2) =3D 8-byte
> PUtable, and the boot-block marking loop writes ~14 KB past
> the object.=C2=A0 Reproduced on v7.2-rc4 with a RAM-backed fake
> DiskOnChip MTD device carrying that header:
>
> =C2=A0 =C2=A0 BUG: KASAN: slab-out-of-bounds in find_boot_record
> =C2=A0 =C2=A0 Write of size 2 ... 0 bytes to the right of allocated 8-byt=
e region
>
> That said, the reachability is admittedly narrow: this is a
> mount-time path, so triggering requires root (device
> registration) or physical control of the flash contents;
> unprivileged users cannot reach it.=C2=A0 The intent is only
> hardening of the MediaHeader parser, in the same spirit as
> the sanity checks already in find_boot_record().
>
> One fair point about v1: the new check runs on every partition
> entry during the scan, while only the selected BDTL entry's
> fields are actually used for the allocations.=C2=A0 If entries with
> lastUnit < firstUnit can legitimately appear in other slots
> on real media, I can respin to validate only the selected
> partition (and drop the boot-record-unit check if preferred).
>
> Happy to send a v2 along those lines if you think the
> hardening is worthwhile; otherwise I will drop it.=C2=A0 Either
> way, thanks for the time.

Since this is a root-only exploit, I don't see the point in going
further. These "hardening" steps just darken the code from my opinion.

Thanks,
Miqu=C3=A8l

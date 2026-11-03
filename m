Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725009;
	b=RwOtw9lZgnPVSqsJgUw6Ob+rrj9OZUaV7OshVB2PZN0z1l+E1Synfk+qZu4xGp0d4+Ex
	 Mtw44001FlU13JW3j4VDWnq97u407bmw6UR654vY3cjOCkHFO9b0BRs5EqiMN75HK7/GT
	 xJ2MC0xQJdzveyVRjtpwoSJ02RFRrx7QaUDwZAIeppo3g1LdM6dHgktG5VXStf5azs/V2
	 59jIoAY7q4T2JPz10WYJofGY38Pl9W+22pBn5/8C+RDeMWiNshdtMc60IQ3lAU9W4hs/c
	 593hRjE2jyNrBn3dw2LQo2kgIp/LD8PXlQxPYe+HZwisfH4VK5PpG2QDe/NgQk/2flg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725009;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u00v9p+RUdxqIPRxo9/1l1Zn1bcxXIjHtPQI/MyY3yY=;
	b=3p7nZO73uvE6f+GLgH5DLBUMOTz1Zsd5R/LvfQ4JkMxWkLWJlvD+yb5VNkBw/h+Js4Nq
	 pPNWog0XK7vcgUzHtCMqEL5+v4vaWTOziU4Wq1voPwJ4Nf/0WiTPhDmiUwhwv+5FYRSzg
	 7TvgXH2Z/fvusB3Y21s7dESGEDuVAdvOoa2ekEtRZ7ke9oWIWAS2sQP2E/depY77UzzvT
	 COpZx1kO2MrPk14M7cmpBFuS4EBQvN5oJ7fFX0QQd37xHfdCycR5/d+Re3G0zPKohQVK7
	 vcHxX769s1gsvqnx9+5rXlJTFNSnEUMCTEqj/TzZc6eVUQiR4Zn+oaD2Y/rjuSNQvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaGj5T09;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430B606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaGj5T09
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE85C1F00A16
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725008;
	bh=u00v9p+RUdxqIPRxo9/1l1Zn1bcxXIjHtPQI/MyY3yY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TaGj5T09XEEWEnyjikMKxMV1836N9QpBHuKWrweBYQpN3iKprg6L4fcTCpIdOXpYq
	 0mvicIGADIBHtz40mVAwdl+7pTgAyPL6EZlogJJGjUsXt8m7TBAxsqV8Hw2iDRBAR7
	 /LrJJAVttrwClFBLNedpfFGSeIjwzIVuNNZeKC0o8yWzT2324w44hz9URT22L/K52v
	 u4h59cBWjMIDX75dxvNGTqb53+7u5yjdxkn1V3O78APlGPEamdY2V/neW9jXTZVeBr
	 v9BmLRWBpY2eQ4FhBm62LBrAEWPMwaGMNODv5qgUCer1qD3FQtdxdMuFlLFrosT2Ul
	 RQ+ci67HBOEJA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso4487313e87.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:56:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx4nQ+BtLsmPi/iW13CIzwDIxexAt/MvUihKcSMOUM4H76rJxy8ZlsO+iFRANmUU9yfdE35TZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8puQoPfpyUJMAQFTa4XB6qeQ5mFpH5DPVZwzhV4N+uW4Dp6R20
	H7JDBqRczzZE48FxHWk/DxONeh4nkkJVWg4V8pc8hLVahDW/0hjnjghSkoTLvGO5Xnu6si2CcW+
	hylG9m5Q9Xa+m7uZ60va8yziQHXMcewE=
X-Received: by 2002:a05:6512:10c2:b0:5be:4340:d588 with SMTP id
 2adb3069b0e04-5bfd9566e55mr4813488e87.31.1793725007020; Tue, 03 Nov 2026
 08:56:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029035253.2333852-1-yaojiale02@163.com> <20261029035253.2333852-2-yaojiale02@163.com>
 <aunzRO9rxFUlC0Ym@red-moon>
In-Reply-To: <aunzRO9rxFUlC0Ym@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 3 Nov 2026 17:56:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtab00kmvS_1RoQHr=PKV3hj=AEP5hS_B-udj5KrQjsg@mail.gmail.com>
X-Gm-Features: AclHuK9IaHYinCfEPEj9175Cpk8zU69uV-UMGla90QOFlwHtZeWz8-rFk4SmMeg
Message-ID: <CAJZ5v0jtab00kmvS_1RoQHr=PKV3hj=AEP5hS_B-udj5KrQjsg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] ACPI: irqchip: validate MADT entry bounds before probing
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Jiale Yao <yaojiale02@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, 
	Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:44=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> On Thu, Oct 29, 2026 at 11:52:32AM +0800, Jiale Yao wrote:
> > IRQ chip probing invokes validation and probe callbacks after the commo=
n
> > table walker has only established that a generic subtable header is
> > readable. A malformed length can leave callback field accesses outside
> > the MADT.
> >
> > Validate the generic header length and ensure the complete declared
> > entry is contained in the table before invoking IRQ chip callbacks.
> >
> > Fixes: e647b532275b ("ACPI: Add early device probing infrastructure")
> > Cc: stable@vger.kernel.org
>
> I don't think this patch fixes anything (actually you don't know, it
> might break kernels that are currently booting).
>
> Remove the stable tag (on the whole series, though others might have a
> different opinion). If this gets merged, goes to stable and then
> we discover it triggers a regression (on existing platforms whose
> ACPI tables are broken but the system is working) it would be very
> annoying.
>
> > Signed-off-by: Jiale Yao <yaojiale02@163.com>
> > ---
> >  drivers/acpi/scan.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 0b17a7e51956..10e8d736f44b 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -2896,6 +2896,13 @@ static DEFINE_MUTEX(acpi_probe_mutex);
> >  static int __init acpi_match_madt(union acpi_subtable_headers *header,
> >                                 const unsigned long end)
> >  {
> > +     unsigned long start =3D (unsigned long)header;
> > +
> > +     if (start >=3D end || end - start < sizeof(header->common) ||
> > +         header->common.length < sizeof(header->common) ||
> > +         header->common.length > end - start)
> > +             return -EINVAL;
>
> This is a check that AFAICS could be done in acpi_parse_entries_array() o=
nce
> for all (where you also know header->common is what you need checking, bt=
w).
>
> Actually, what's missing there to avoid peppering the kernel with
> BAD_MADT_ENTRY checks is the entry size (that we could add with a LUT).
>
> The downsize is that by centralizing it, if anything breaks (which is
> possible) we have to revert it and therefore remove the check for all
> consumers.
>
> I don't know. Rafael, all, thoughts on this ?

I have concerns similar to yours: It may break systems that currently boot.

That said, I can imagine a hostile host trying to crash a CoCo guest
by exploiting this missing check.

It might be better to try to use the actual length instead of
header->common.length if the latter is too large though.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3EC37754C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315987; cv=none; b=nAHQZT63OJt8/BMO1RM6VXBELeGfFt0/J8WFwCUHLYYeQvEPUzQ/FA2U0aiPGCH0jVFL8NS5QCL7o5drJUm3jrNePQD20pHXUC9SoIjRyIpwhzQMMVQ9B6WHuuT9XNUd0gymzgvtqwPWH9iVOyVFY96I1fcr7jKY2UpXL1NcIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315987; c=relaxed/simple;
	bh=EE8zdxlLBdtyKVtNHQ/sE40G22wZ24fiw+1NNUBUNpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He2jaD3sO6UMId9IPupXmMXIYi/I6jOTbZJYp4qSBXDtUzcvB6lHPYRbffpuYbOEMjOLltuqouNjyO3zO2QymDvSi+3HrgAe21fzqlXnuMKhOieKoJJdU3P35A4lT2OfSlMMo4VzveJy5nLnaoNQMwGeyppxD6HE8j91dkLUrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2qU3NBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2qU3NBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201141F00893
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780315986;
	bh=EE8zdxlLBdtyKVtNHQ/sE40G22wZ24fiw+1NNUBUNpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H2qU3NBtM/mlzuAdg6nLaOMgdeAdLKOaLMRVE4Aru6bbdHooNwDd7oind7K6DaIEq
	 BLTNKgeOI4prrqPiQtgd6yPrqcQ4+pGeomwtLHXSeAWARs1rtjNfy7AR0Aw2V7fuqo
	 A4If/KdC6/28etvsDNvSbE5enOTnEiF1wKmjQi+ZU96FPltzntpaEM5xpp4O7a440t
	 Gvi6OZbAmemC1nw6MCIZMNa1GDPbN5Kf/bRdKLAF07q9aSM0+Mmz+xVmoyuCs0rKwR
	 W/ApjlKFsxNS+PQpNWWYsA49NEvusAFeCv3+TpOwk887BV7Cgh2RFsiVwgKWi7kahv
	 h4pXsWkZwjTIw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68e66128so1187521e87.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 05:13:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+uqKD0wwQVyEsEmcwuco+snsh6LzHigroPCmOjjO55KasrbfJ7TdK1sjBwwrnHe68XeW8EI5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KQdGzjl7J98YNHwPIA9+CT6tJ56nVwBis5YSSqxvVl35S5IH
	gkVDPPuQbq2umJzBCytZ1LYWsUTHqzSVHkyho6H9EXlGByC+UxT7Dgr0Ez0NLMt1blmubptio67
	z98Vf6nwiUZ94KrgrlNnQuJ2IFd7pbsU=
X-Received: by 2002:a05:6512:b0f:b0:5aa:b6a:6028 with SMTP id
 2adb3069b0e04-5aa60a737f2mr2825770e87.45.1780315984633; Mon, 01 Jun 2026
 05:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk> <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
 <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk> <eddc6acd74abcea6131f3cfc606bc596@kousu.ca>
In-Reply-To: <eddc6acd74abcea6131f3cfc606bc596@kousu.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 14:12:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
X-Gm-Features: AVHnY4K_Z822qHW2vwRtmAL8a7QwaDE3vDxsro5_34x72v0jljpMM1KGU6NiT_I
Message-ID: <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: Nick <nick@kousu.ca>, John Veness <john-linux@pelago.org.uk>
Cc: linux-acpi@vger.kernel.org, johannes.goede@oss.qualcomm.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 10:35=E2=80=AFPM Nick <nick@kousu.ca> wrote:
>
> On 2026-05-31 11:17, John Veness wrote:
> > On 30/05/2026 14:34, johannes.goede@oss.qualcomm.com wrote:
> >> In case you've not seen it yet, Rafael send out the test patch
> >> publicly later that day in another email in this thread:
> >>
> >> https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysock=
i/
> >>
> >> Regards,
> >>
> >> Hans
> >
> > Thanks for the pointer, and sorry for missing that! I had only been
> > looking in the archives of platform-driver-x86@vger.kernel.org which
> > for
> > some reason didn't receive the patch.
> >
> > John
>
> On 2026-05-31 11:25, John Veness wrote:
> > I'm not Nick, but I have tested the patch here on my old Toshiba Tecra
> > Z50-A
> > and it seems to have worked - I now have Fn+keys working fine, after
> > losing them
> > in a recent kernel update (apart from Fn+3 for volume down, and Fn+4
> > for volume up,
> > which for some reason continued to work when the others didn't).
> >
> > John
>
> Same here. All my Fn keys work except for Esc through F8. Glad Rafael's
> patch worked for you too! There's a newer copy of it at
> https://lore.kernel.org/linux-acpi/2046403.PYKUYFuaPT@rafael.j.wysocki/T/=
#t
> by the way.

Thank you both for testing!

The patch is there in 7.1-rc6, so it should propagate to -stable
kernels over time.

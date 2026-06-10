Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49ED1AA7A6;
	Wed, 10 Jun 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079711; cv=none; b=FzTzh7gW6bYOeXiXNnh0lmPkfKhpeNr6ZWMXneXTxbTcE6nSss5QODqZOLs68oqRej6CJVbeIiaI7zOXDs7E9V8JBykOY96f3iMazFR/FHEx/tdaP/1i4wCHjRSdLf+4ISrBAJOEbZvwQWzqTFVjwPPO5Y7JP7Jd0x17deOqTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079711; c=relaxed/simple;
	bh=C0h+y7JtbSMOxZwmdlPvnEFLZq3EEBOzI6YtZ3ifQco=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tr2WYYtJZ95XtIXEpWdq8z1Y0lI9isk4PBfCAVOy5pnZbwWwqsE9udgtueEh2jI7Q7h0UqYIXfq44chLogU+Y3YICNxqAVYRkldQa/BzHgKZigluGToQYJfMww0XDqbWFgJZPvz5N0l2STgWOmYX1rUv7c7VkwMF1TMlOO1Wpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWQSdY4i; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWQSdY4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781079709; x=1812615709;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=C0h+y7JtbSMOxZwmdlPvnEFLZq3EEBOzI6YtZ3ifQco=;
  b=iWQSdY4ic2J76beVYeZilcGb9NIwcp4CBHwDSloCL2IaUC5TRfHYeqa6
   at+hPceJpStYQl5NtEol5v9ChRWkgowECEbPTsIb8Ebw5bJ0HE7/v1f/G
   Pq+8cd+hRx8u1SKysjAFb9rUjz182CD3nA25Ih3+CyYokZi1DP27iTQ3o
   Q9Bh725i0xbzdjGw0hhHdjWEkcSZ6ySrgs4E96ipGsqtQzfAAG8mZHFAT
   icC76eKiHNEkFiPE1G5ssVGEbhv9d9kS2aMoCXDJUa1gJA6fhMRKi7pYh
   nl7oswOfIYZS4iuyIM5mEIngiXh1oOhQ9E1fHCSm70fvLq6nJCXypiACO
   A==;
X-CSE-ConnectionGUID: Tg6pZ3QUQc+doudV+XEvkA==
X-CSE-MsgGUID: KZxQAcQQRJ6qSHp4w9kx9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93352724"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93352724"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:21:49 -0700
X-CSE-ConnectionGUID: Xw/HE5tfQICCuDv6NJXu1g==
X-CSE-MsgGUID: bgIPv8MoQK6pQgnz1hCO7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246127817"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:21:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jun 2026 11:21:41 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Daniel Gibson <daniel@gibson.sh>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Sindre Henriksen <sindrehenriksen93@gmail.com>, 
    Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
In-Reply-To: <91af1da1-e2d0-40c1-87b0-452b48f4a2b6@kernel.org>
Message-ID: <ded3840d-fa7d-d6dd-a265-daca1e9df7a0@linux.intel.com>
References: <20260609105756.2813669-1-daniel@gibson.sh> <20260609105756.2813669-3-daniel@gibson.sh> <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com> <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh> <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
 <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh> <5b684d9c-2477-488d-a89b-323ca3e51207@gibson.sh> <91af1da1-e2d0-40c1-87b0-452b48f4a2b6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1106137832-1781079368=:1359"
Content-ID: <30689ad3-5265-e231-3866-3e32e4150f86@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1106137832-1781079368=:1359
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7aea5198-8748-3826-9a20-d78d8c57d5bc@linux.intel.com>

On Tue, 9 Jun 2026, Mario Limonciello wrote:
> On 6/9/26 10:36, Daniel Gibson wrote:
> > On 09.06.26 17:06, Daniel Gibson wrote:
> > > On 09.06.26 16:40, Mario Limonciello wrote:
> > > > On 6/9/26 07:07, Daniel Gibson wrote:
> > > > > On 09.06.26 13:46, Ilpo J=E4rvinen wrote:
> > > > > > On Tue, 9 Jun 2026, Daniel Gibson wrote:
> > > > > > >  =A0=A0=A0=A0=A0 },
> > > > > > > +=A0=A0=A0 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
21383 */
> > > > > > > +=A0=A0=A0 {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 .ident =3D "Zen3-based IdeaPad Slim an=
d similar",
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 .driver_data =3D &quirk_s2idle_need_su=
spend_delay,
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > One more question.
> > > > > >=20
> > > > > > Sashiko noted, that amd_pmc_quirks_init() can overwrite
> > > > > > disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_=
data
> > > > > > provides quirks. Is it okay in this case to not have .spurious_=
8042?
> > > > > >=20
> > > > >=20
> > > > > Good question.
> > > > > So far I haven't had complaints that sounded like they'd be relat=
ed to
> > > > > this quirk not being active.
> > > > >=20
> > > > > (The only report about things not working as expected on detected
> > > > > devices was something about "ACPI event storms" after resume:
> > > > > https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no=
 one
> > > > > else with similar devices could reproduce that, so no idea what's
> > > > > going
> > > > > on there, and it doesn't sound like that IRQ1 issue)
> > > > >=20
> > > > > I can test if explicitly enabling .spurious_8042 in
> > > > > quirk_s2idle_need_suspend_delay breaks anything on my device, if =
you
> > > > > think that enabling it by default makes more sense?
> > > >=20
> > > > Famous last words - but we haven't had a need for spurious 8042 on
> > > > recent hardware so I think this is unlikely to be a big problem.
> > >=20
> > > FWIW enabling .spurious_8042 didn't break anything on my machine, but
> > > didn't improve anything either - only visible difference is that when
> > > resuming by pressing a key without that quirk both IRQ1 and IRQ7 are
> > > reported as having triggered the resume, and with the quirk only IRQ7=
 is
> > > reported. But it didn't seem like IRQ1 triggers a resume when it
> > > shouldn't.
> > >=20
> > > OTOH I have a the latest BIOS (from this year), so it's likely fixed
> > > there - maybe people with older BIOS versions still need the
> > > .spurious_8042 quirk?
> > >=20
> > > As these devices are relatively recent and still sold I hope that
> > > everyone affected can get a new BIOS (which they should do either way=
).
> >=20
> > Anyway, overall I'd say that the patches can be merged as they are - th=
e
> > affected devices are known to have serious (-ly annoying) suspend
> > issues, so it's unlikely that a currently matched devices has working
> > suspend that breaks with them, so things at least shouldn't get any
> > worse for their users?
> >=20
> > The patches have gotten some testing already on different devices (from
> > my out-of-tree patched amd_pmc module on Github) and so far it looks
> > like the spurious_8042 quirk isn't needed.
> > If reports of needing both quirks turn up after all, that can still be
> > easily added in a few lines of code (maybe even just one).
> >=20
> > Cheers,
> > Daniel
>=20
> Even with all that testing; it's only on hardware with problems.
> We don't want to have issues exposed by these patches for people that did=
n't
> need the patches.
>=20
> So my 2c:
> * It's "too risky" to pick up for 7.1 final

Definitely it won't be happening.

Also, Linus effectively only allows regression fixes during -rc phase=20
anymore (he stated his policy change around -rc5 timeframe). I therefore=20
moved even some of queued new HW support patches from the pdx86 fixes=20
branch into for-next.

> * It's a "bit late" in the cycle for 7.2-rc1 (usually new content stops b=
eing
> added around rc6).

I usually only stop accepting large series around that time, with some
exceptions. (We've one such exception ATM because I was a week away and=20
couldn't process patches, it would feel unfair to penalize other devs=20
because of that so for the series which have been around for awhile, I=20
still try to process them during this week, this one included).

> * This isn't "risky enough" to wait until 7.3 (basically after 7.2-rc1 me=
rge
> window is done)
>=20
> But this has been on the list for a while now, so I would say this makes =
sense
> to put in for 7.2-rc1 and we should all make sure we test well once the R=
Cs
> are posted.

My plan is to take this into for-next during this cycle.

We can always take a timeout and revert it during -rc phase if problems=20
appear because of it (and even after 7.2 release, if situation requires=20
it).

I'm not convinced testing pre rc1 really covers much when it comes to=20
platform drivers, those few people testing linux-next, as valuable as they=
=20
are, cannot really cover that much HW diversity.

--=20
 i.
--8323328-1106137832-1781079368=:1359--

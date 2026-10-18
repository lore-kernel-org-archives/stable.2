Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36494C10C5;
	Sun, 18 Oct 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333495; cv=pass; b=l+WhNHdh6aTR3OOoANucWpQWxBxy9TWuPwaCe0ueZSFmrlJ+faeEy9MHHR7r7jSZektO14XsOiw6bsssb00u8D9IVpyYjfYwnR3X8dv4s+ao0YDeMfvoWIageDSzpTrx94z84NiVkPs5YDO4ZgG/xwdkSb7dlLf5JxyjV+HVwMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333495; c=relaxed/simple;
	bh=TxqCclwgwahYNCJUlgKptCLHJGaqlm3iNCsgB3td/Zo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=bCWY5GhC82tSzkyj7diLO7lFBdgflCubO324M/Nts3Z36sF4LnVY76SVmF9hKwqnF2tG/VRVSTkfp8vwmhmaLtl0dQ05whANzkei2kwNmdIE3G8ChU/Nm28FGZUngjOkH3BcjNrxJ56zK4/+yCkisDFRkynj6Ck79Krj7fMqzIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=CTzA6aDh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="CTzA6aDh"
ARC-Seal: i=1; a=rsa-sha256; t=1792333483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQbSPfc68q2fP3U+ZrSt18pf3da5NuruogR24UVDEdpXafWcP4T2j6BQ2pKzSclNKT0P4Ef4ksomnKFLaH44y8aAslDtmHcHCriaIdQyJg31aJQaavb+RRoEg9dzPbAWtzepB5okPG1y16gUWFDhsVp40h2usN1EXFHOKIHx7no=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792333483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kbctbg+bk9Le87fq+d7TG72Faw2pL9FiXkPz6pgGzjA=; 
	b=EgXmII2ZBNlJyOQbV60BYS/SK0PTq1M3KK7Ksw5zrz/bdgoPtT8GvjDOXtwmVsXaQokg8tbZtH7qYpRfkIEBVQUpMz9V0/rhw3ZfK6XIjSTYDEvfOONhjdjdiOgJCF3q7MmXcB08Pa6+S47T9p4/KGgJ02IbddpwXgKDRgipCbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792333483;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=kbctbg+bk9Le87fq+d7TG72Faw2pL9FiXkPz6pgGzjA=;
	b=CTzA6aDh70lw1RWgfC+lR2iJ3VV6bGuX5aFPTbOK+XWKFiTydGSwtFRQTXlLKN8N
	mNZAGF8SzZoPyfb2F72tYGqtC9Odpkt+4MYaNVU9dWf+Nw+8+EZIqMGZKlN8+nPkdFh
	kBhgXdkoG4QINFFM/PtkxtwD5aunVgxO9OtOK0uPDYHd776A0TH9DLSOhyG5DLDzINP
	mhvpGv0l4TGn1jxDQvMeIiFjP/iMzH9p1tLcRku65dDbeU8wfhj37qTkYftB8iLJFed
	TvmTq52FeEFtNIewJqiU/lLch4Bmw9DLkTuewJseffsgezyFZC+e3vv+H4QTseXHIec
	W3Plyp01mQ==
Received: by smtp.zohomail.com with SMTPS id 1792333480583189.62194695259757;
	Sun, 18 Oct 2026 07:24:40 -0700 (PDT)
Message-ID: <e7e6423eb2a358faa0d2a26fddd0f992e3d03448.camel@rong.moe>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Fix unexpected
 charge_types on probe
From: Rong Zhang <i@rong.moe>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>,  Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de
 Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
In-Reply-To: <DB59F3C0-040F-4663-9750-C387963DCFE3@gmail.com>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
	 <DB59F3C0-040F-4663-9750-C387963DCFE3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 22:19:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Derek,

Thanks for you information.

On Sat, 2026-10-17 at 22:30 -0700, Derek J. Clark wrote:
> On October 17, 2026 4:16:17 PM PDT, Rong Zhang <i@rong.moe> wrote:
> > It was reported [1] that some unfortunate combinations of BIOS and
> > Lenovo utilities (e.g., Legion Go 2 + Legion Space) may enable Rapid
> > Charge and Conservation Mode at the same time, which is very out of
> > sepc.
> >=20
> > If both are enabled during a previous Windows boot, ideapad-laptop will
> > see both bits set and correctly shout "unexpected charge_types".
> >=20
> > A planned BIOS update will address this. Before that, if unexpected
> > charge_types are encountered on probe, enforce [Long_Life] to prevent
> > the device from operating in an out-of-spec state. On check or fix
> > failure, skip registering the battery hook and the conservation_mode
> > attribute.
> >=20
> > Note: the switches never enable themselves autonomously, so there is no
> > need to fix it during runtime.
> >=20
>=20
> Hi Rong,
>=20
> Note that this isn't strictly true. A known bug in multiple Lenovo device=
s is that querying the EC too quickly can cause it to reset into an invalid=
 state. I.e. some games run under wine for check the state of the AC adapte=
r multiple times a second. In such a case they can reset and then report bo=
th modes on.=C2=A0
>=20

Could you confirm if it's a completely different issue compared to
https://msgid.link/58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe
(i.e., an ACPI mutex ABBA deadlock cause the GBMD method to return
garbage data)?

> I don't believe the device re-enumerates in this case. This is documented=
 in the driver [1].

The comments and the relevant fix was added in a patch of mine. They are
about yet another different issue, in which querying the EC with an
interval < 50 *us* causes the EC to shut down the platform.

Then the user must press the power button to power on the platform again.
It's a cold boot. All kernel drivers are loaded from scratch, so the
probe-time fix here takes effects.

That being said, as far as I can recall, running into the issue doesn't
set both modes to enabled. Besides, userspace checking the state of the
AC adapter multiple times a second must have an interval much larger than
50 us, so I don't think the issue you described is the same as the issue
described in the comments either.

>=20
> Lenovo ha mentioned to me a BIOS fix for this issue will be coming for th=
e Go S and Go 2 at some point as well, but this isn't exclusive to Go model=
s. It may be prudent to fix any time an invalid state is detected.

I am OK with the fix-whenever-seen approach, but in this manner it'd be
better to wait until
https://msgid.link/20261018122348.679126-1-aliamemis@disroot.org is
applied to solve the ABBA deadlock issue, so that false positives during
runtime are reduced.

Thanks,
Rong

>=20
> Thanks,
> - Derek
>=20
> [1] https://github.com/torvalds/linux/blob/32c52ec87d6245ee2d12ed5dd509e4=
0062939b50/drivers/platform/x86/lenovo/ideapad-laptop.c#L286-L296
>=20
> > Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:Fa=
st (Rapid Charge)")
> > Closes: https://github.com/ValveSoftware/SteamOS/issues/2876 [1]
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> > Rong Zhang (2):
> >      platform/x86: ideapad-laptop: Factor out charge_types methods for =
internal use
> >      platform/x86: ideapad-laptop: Fix unexpected charge_types on probe
> >=20
> > drivers/platform/x86/lenovo/ideapad-laptop.c | 113 ++++++++++++++++++++=
-------
> > 1 file changed, 84 insertions(+), 29 deletions(-)
> > ---
> > base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> > change-id: ef28eda4-ideapad-fix-charge-types-067d46d08945
> >=20
> > Thanks,
> > Rong
> >=20

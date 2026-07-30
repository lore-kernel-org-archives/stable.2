Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310A4499AA
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434404; cv=none; b=JONBnYdnn8w1H+XeQy8FGZbTBaMxuV49UpSW1d3FQOMO3pm+jLPe2nAI2waAEx4jBiS8U+jsX+3UhtBNvghhL7PKzqhtFuMRy46e8srKrMuSVfj6TnzfDI0nNPF9JCIoleXg9qHlYfdfLICc9r0M3BkJDC+RBW6ulFj8AzaHmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434404; c=relaxed/simple;
	bh=Xl/KBklYTTrLCNDdvWQxbvELY1eguSQbqDgfYkn8y9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzN/x/5rOnYeudDqknWWmObSXj7mXt3WQcNrKS6kw7xbDvBinC82CBv1Xi2ciRBaIYAfkVsvEQ0JC2/EHCLA/VUR2WjMK8MuTJv/EDB3Ud7xK0Dzy40qu8/1NoY5W+M6BMs5gCFrE0LZo1gipX8nhDv5+MtBXMziKnu6rliMt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqzXaZjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqzXaZjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73741F00AC4
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785434402;
	bh=ggMb29DTDO03PyVm6GwHOcbMPnV/eDpnqYpVTLhUtME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nqzXaZjDAD76c2M1C1utCNdMGpms3uugm7B1M4h1WJfR3kh4VqkUKSSaTij0GALLl
	 rjv1r2YXJ3P1zDZ192Bav/MOqb6oSLr72gY3qL35OnRw0GD6tbCHKQ6h0xLBHviPa8
	 gDd9WOz/ilpN3jY3f9S4dQGBfVhIx78XeVzdGUtHmjq84ZJAoGbGIOVAYS3HQOGaI8
	 dH9CcE9xCz3mjyPoYxpL1wenhbaYlTKBEExlt+P8J74a3qagc0qm6j/6KFRnJvgEst
	 0hq3A85/480+9wI9epEyYGX5iPIzs7aXN9sCh1OdIbvYpSDwfbZFB9q9dDc4yq2559
	 /0/GIlGNAC/7w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso59596e87.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqF9FlSp9fj2k/0SE3drlTon6QT5qGwiKB/gi33iqOEC+sL5H+dsF9UHalGpF7hhP8Sbf6iY18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFIe1BtjlTJbO28Gi//mK4KzM8lsYp4JNbqd50x6h5oNQqNPGe
	3Wd12bNAvFooN9jd4ecYqLuThfI40Eocb6j6xiqTM3zfuz7QnK49dpsngEiiFqlM4BrV4uwC9X3
	LVrVc5cGONRQm9BCstUECUnLUnyABAbI=
X-Received: by 2002:a05:6512:39c2:b0:5b0:1108:c575 with SMTP id
 2adb3069b0e04-5b2db3457a7mr700029e87.7.1785434400246; Thu, 30 Jul 2026
 11:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev>
 <CAJZ5v0hWDKHXO5d-rgp_TMiS48fHY-cTxf5r5rGg2eBNpNtVig@mail.gmail.com> <fe8a69c9-83a4-48aa-8904-73ce70ef7a62@gmx.de>
In-Reply-To: <fe8a69c9-83a4-48aa-8904-73ce70ef7a62@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 30 Jul 2026 19:59:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHQhbVDeZZGraNE3h0kzLog3Xq2x6Z=BxOTqsGJoyQwQ@mail.gmail.com>
X-Gm-Features: AUfX_mwaI3GLhLzRMWwWSa46p2a1j7z_xihXD4nSf0wLudvoKINpvxcrHBNqeH4
Message-ID: <CAJZ5v0jHQhbVDeZZGraNE3h0kzLog3Xq2x6Z=BxOTqsGJoyQwQ@mail.gmail.com>
Subject: Re: [REGRESSION] thermal: per-zone hwmon names break Steam Deck fan control
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Matthew Schwartz <matthew.schwartz@linux.dev>, 
	regressions@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Linux PM <linux-pm@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:46=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 30.07.26 um 11:33 schrieb Rafael J. Wysocki (Intel):
>
> > Hi,
> >
> > On Wed, Jul 29, 2026 at 10:50=E2=80=AFPM Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> >> Hello,
> >>
> >> After upgrading my Steam Deck OLED to a 7.2-rc kernel, the userspace f=
an control daemon that I use stopped working. I bisected the regression to =
d6323469bcfb ("thermal: hwmon: Register a hwmon device for each thermal zon=
e").
> >>
> >> Before this commit, the ACPI thermal-zone hwmon name was acpitz, while=
 after the change it is now acpitz_0.
> >>
> >> The device profiles for fan control rely on the exact `acpitz` hwmon n=
aming like the below code snippet:
> >>
> >> devices:
> >>    - hwmon_name: acpitz
> >>      nice_name: CPU
> >>      max_temp: 90
> >>      temp_hysteresis: 0
> >>      sensor_name: temp1
> >>
> >> So now, the profile fails to load with:
> >>
> >> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> >> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> >> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> >> fancontrol.py[40528]: Traceback (most recent call last):
> >> fancontrol.py[40528]:   File "/usr/share/jupiter-fan-control/fancontro=
l.py", line 606, in <module>
> >> fancontrol.py[40528]:     raise FileNotFoundError("Failed to load hwmo=
ns after 10 attempts.")
> >> fancontrol.py[40528]: FileNotFoundError: Failed to load hwmons after 1=
0 attempts.
> >>
> >> Because initialization fails, the daemon never enters its fan-control =
loop or writes the requested fan target.
> >>
> >> This change was also backported to Linux 7.1.5 as commit 996957016bc1,=
 so the regression is present there as well and has led to a userspace ABI =
regression. I can look at accommodating the change on the userspace side, b=
ut it still seemed worth reporting as a kernel regression.
> >>
> >> Thanks,
> >> Matt
> >>
> >> #regzbot introduced: d6323469bcfbda91f0aa89b7b39ad45fe822ca5d
> > Thanks for the report!
> >
> > I think that commit d6323469bcfb will need to be reverted.
>
> Would it be possible to instead make the new behavior depend on a Kconfig=
 option?

Yes, it would, but I'm not sure I want to go down that path.

There is a major weakness in the new scheme, which I didn't take into
consideration, that it builds hwmon interface names using thermal zone
IDs which span all of the thermal zones in the system, not just
thermal zones of the same type, so what user space gets basically
depends on the initialization ordering.  Granted, this can be fixed,
but then is it really a good idea to register a hwmon class device
under a thermal class device?

I'm still thinking that in the future it would be good to give parents
to thermal zones, in which case hwmon class devices should be
registered under those parents.

> This way we would give userspace time to adapt to the new behavior. Remov=
ing it completely
> would mean that userspace will newer adapt.

But IMV it would be better to ask them to adapt just once.  So if the
plan is to arrange things to register thermal zones under specific
parents, that is what user space will need to adapt to and
intermediate adaptation episodes should be avoided, so to speak.

In the interim though there is the bug causing thermal zone removal to
deadlock due to the misdesigned hwmon interface which needs to be
addressed in the short term, possibly without disturbing user space.

To that end, I'm thinking about creating a faux device called, say,
thermal_sensors that will be used as the parent for all of the hwmon
class devices created automatically by the thermal core.

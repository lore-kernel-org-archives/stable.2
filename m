Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF727727;
	Fri, 10 Jul 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709161; cv=none; b=Cr58zz4kTweFa8zSjdgpvrIsMz3watGSqhDXXVd2Ry06fUUc5dQqu1sNDTdY1PfgepIj9kP38oZPSUf3ziGoLZvZwpHqhUschtO5TaebYXmrk+PF0NIbwrY7iRKoxyWbVQlur0CjscdijRGfl7qcO/Ah/ErqQa9mgBoCtxuuOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709161; c=relaxed/simple;
	bh=z/PAgDsGv3sHVcaDpjNcWANCT+tvjsUNAbpH7k7Psi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYh6mRJ7ANtb6MBgYhydijus0DbkWmuU5UyRB9Dqs/GUNo0tfrlbFXpkE+pzdkl2b1+zVx4CyEuLJz3xlkm01fhmNcxs5xeo3TxKuepkCQcLsE9l4itTqaWE8gvTJRPx9ulVqg/ktFuLq0iXDzyjWP4uNYk56dRPTNbRY4Ti+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=m+Pb0Y3k; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="m+Pb0Y3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=nCtzuEwPT34MKTvCPVuZBQgIMot0RWS9od/hRanH/WM=; b=m+Pb0Y3koF99BXJURgDkAOKWKu
	HBm/TufqtxA+v4Thb6ojwwTE0B0QCe9r01FZwGMSR5Hyy4c5YnBfLb89unScByHHMw1S3wXb0efF0
	/A5DoE4QMRk7hbzL3xptAUnif2AGH6Du3itdR8rea7N4Xz5w9ZUqhmHWDn8G1zpXu+i0rDIodXkYM
	Y9kz22aUUyltXz/kaEA1gu/l2d+0ElHVl6cUDGj+Fy0wrQhI/Gg7mvfd84GDO5wMYLXqt24EcUnay
	3ufozMmSn7pbvunFXi+PKntMVekykjSTTyRUBfi5k+8oJcD2rE+JTSdjZH9rIJsxibVcX1grVuchS
	ViUDMhaA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wiGEM-004gRe-0a;
	Fri, 10 Jul 2026 18:45:46 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7EFFDBE2DE0; Fri, 10 Jul 2026 20:45:45 +0200 (CEST)
Date: Fri, 10 Jul 2026 20:45:45 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Denis Benato <denis.benato@linux.dev>, Ponali <ponali2k@gmail.com>,
	Luke Jones <luke@ljones.dev>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>, 1141604@bugs.debian.org,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1141604: linux-image-6.12.94+deb13-amd64: does not detect
 ScreenPad on ASUS VivoBook
Message-ID: <alE92R40JwcluApW@eldamar.lan>
References: <178340264407.17924.10135409461303815312.reportbug@ananaspc>
 <178362762638.911488.8564892548331679884@eldamar.lan>
 <98dc115b-1dec-4fbb-bab7-2588e8b74bf8@linux.dev>
 <0ff0385e-50b0-bfae-cedc-05cfe9c6cbc7@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff0385e-50b0-bfae-cedc-05cfe9c6cbc7@linux.intel.com>
X-Debian-User: carnil

Hi all,

On Fri, Jul 10, 2026 at 03:31:08PM +0300, Ilpo Järvinen wrote:
> On Fri, 10 Jul 2026, Denis Benato wrote:
> > On 7/9/26 22:08, Salvatore Bonaccorso wrote:
> > > Control: forwarded -1 https://lore.kernel.org/regressions/178362762638.911488.8564892548331679884@eldamar.lan
> > > Control: tags -1 + upstream
> > >
> > > Hi,
> > >
> > > Ponali reported in Debian (https://bugs.debian.org/1141604) the
> > > following issue after updating from 6.12.90 to 6.12.94. First quoting
> > > the report:
> > >
> > > On Tue, Jul 07, 2026 at 07:37:24AM +0200, Ponali wrote:
> > >> Package: src:linux
> > >> Version: 6.12.94-1
> > >> Severity: normal
> > >> Tags: upstream, regression
> > >> X-Debbugs-Cc: ponali2k@gmail.com
> > >>
> > >> Last known working kernel: 6.12.90-1
> > >> First known broken kernel: 6.12.94-1
> > >>
> > >>
> > >> Dear Maintainer,
> > >>
> > >> I upgraded all my packages through apt, which also upgraded the linux image
> > >> from 6.12.90 to 6.12.94.
> > >>
> > >> I expected the ScreenPad display to continue to be detected and exposed as a
> > >> DRM output, like on 6.12.90. The ScreenPad being the trackpad with a screen,
> > >> which came with my computer (ASUS VivoBook X532FA_S532FA).
> > >>
> > >> After upgrading and rebooting, the new kernel caused a regression where the
> > >> display of the ScreenPad fails to get recognized by the kernel. The touchpad
> > >> functionality still works. Usually, the ScreenPad would appear as "HDMI-A-1".
> > >> The DRM connector for it still exists (/sys/class/drm/card0-HDMI-A-1), but
> > >> "status" reports "disabled"
> > >>
> > >> I could not get the ScreenPad display to be recognized again on the new kernel,
> > >> so I configured GRUB to automatically boot to the 6.12.90 kernel through the
> > >> "Advanced Options". The ScreenPad is recognized on older kernel versions, so I
> > >> am still able to use it (until a new LPE comes around).
> > >>
> > >> To replicate:
> > >> 1. Boot with 6.12.90. The ScreenPad display is detected as HDMI-A-1.
> > >> 2. Boot with 6.12.94 with the exact same hardware.
> > >> 3. The ScreenPad display is no longer usable.
> > >>
> > >>
> > >> My main display is eDP-1 (1920x1080), though it isn't essential. My GPU is an
> > >> integrated Intel iGPU, and the driver used for both screens is i915. I have
> > >> booted to the new kernel for reportbug to get all the information
> > >> automatically, but i will continue to use the old one until the appropriate
> > >> time.
> > > Now, Ponali did bisect the changes between 6.12.90 and 6.12.94 and
> > > found that the backport of the commit 8d95d1f4aa5c ("platform/x86:
> > > asus-wmi: fix screenpad brightness range") changed the behaviour.
> > > Bisect log is at: https://bugs.debian.org/1141604#22
> > >
> > > As this change was backported to other stable series as well I asked
> > > Ponali to please test 7.0.y and 7.1.y and confirmed that both 7.0.13
> > > and as well 7.1.3 show the hehaviour.
> > >
> > > #regzbot introduced: 8d95d1f4aa5c76202b0833a70998769384612488
> > > #regzbot link: https://bugs.debian.org/1141604
> > >
> > > Is there anything Ponali can report back to further debug the issue?
> > Hi Salvatore,
> > 
> > The commit incriminated is this one: https://lore.kernel.org/all/20260302174431.349816-3-denis.benato@linux.dev/
> > 
> > As you can see that commit changes min/max of the brightness range, but 
> > does not touch the detection at all, 
> 
> To be more precise, it DOES change read_screenpad_backlight_power() -> 
> asus_wmi_get_devstate_simple() but AFAICT that cannot make things worse 
> because asus_wmi_get_devstate_simple() used in both cases, so I was 
> left to wonder the same thing as you.
> 
> That being said, it's hard to see how bisect could point this to a wrong 
> commit either because good/bad should be pretty obvious.
> 
> Did reverting the suspect commit on top of 6.12.94 result in a working 
> system?

Ponali did test, and reported back in the Debian bug at
https://bugs.debian.org/1141604#60, quoting:

> I have found the sysfs attribute for brightness control to be in
> /sys/class/backlight/asus_screenpad, and it appears on both 6.12.90 and
> 6.12.94.
> 
> On 6.12.90, max_brightness reports 235.
> 
> On 6.12.94, max_brightness reports 255.
> 
> 
> I have checked out to v6.12.94, reverted the suspect commit, and found
> the ScreenPad to be working as intended.
> 
> 
> Regards,
> 
> Ponali

Regards,
Salvatore

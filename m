Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC23B7A8;
	Thu,  9 Jul 2026 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627737; cv=none; b=E1+ynN1eV7/Bqb7isGR8wzo6sJpCISUzQWCElxTKKbszPdf2pf1kg3ttDmsi+Y2DEhlVKoZMZxMxrXR/jPZgdvC0sfCJlRorHqS6o2eR0O3Nbp96A8FZ7CM5tJevEZ4L2otRExFebFVo1mENojiS8axZsIsCrakiL8Ellhw0Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627737; c=relaxed/simple;
	bh=EfYOK7Sy1TgfQBQOKyfNPQB6LLiUoztQ+EFhabf7mKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB0oLg+C+ULaQ57YXqvev/7Gmi7DK9/rWqRxwrxQZPOwyXLSY81ttfbSuJLjJUzT0sJMO8I1OyBaFPhARf5+EJRLfIagsmndk4huJWILWgBTvi33Ixj8T1mhBGaQwaeqwAn4D4rXTt39NfPyggi+kjZp4CP4wrO/QVfGAuj2xi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BPBUyPJc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BPBUyPJc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vS8Z4iMknQQExwiIiHNFXxXzKHQSZuZ7acuTsu1JCFA=; b=BPBUyPJcudTGV4mZa7f7OvJW5N
	rUjF2AjpzMv0iT6UX/ejEh/bSC/tVmehBddlXaFPTETqjtp1BtDg2Hf81zJbcSvLJUBDuok59jiJg
	8jDOhYsciQJEaKcYcbYa9ELhnphPEEcVTVVAPWa2WtmGnZaejIomqbn5zAtGXlw8hV2obiwYftY0a
	/JuPHJnTXnCNfQIQ0TVWbWJnKohXahX4UaHrj9urMo32EKSHx44/HA74mnR9CCpZrrvbU/r4/IpB2
	P+7xRG9uJKgtGB21dVyZyqjer9G+hSfa2MJ74NainssunPiEFyPk0prFKfSlCi/tSzUu3GFCvMr6i
	Xfv8kCqA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1whv35-003xSm-0S;
	Thu, 09 Jul 2026 20:08:43 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1136DBE2DE0; Thu, 09 Jul 2026 22:08:42 +0200 (CEST)
Date: Thu, 9 Jul 2026 22:08:41 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ponali <ponali2k@gmail.com>, Denis Benato <denis.benato@linux.dev>,
	Luke Jones <luke@ljones.dev>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Cc: 1141604@bugs.debian.org, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1141604: linux-image-6.12.94+deb13-amd64: does not detect
 ScreenPad on ASUS VivoBook
Message-ID: <178362762638.911488.8564892548331679884@eldamar.lan>
References: <178340264407.17924.10135409461303815312.reportbug@ananaspc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178340264407.17924.10135409461303815312.reportbug@ananaspc>
X-Debian-User: carnil

Control: forwarded -1 https://lore.kernel.org/regressions/178362762638.911488.8564892548331679884@eldamar.lan
Control: tags -1 + upstream

Hi,

Ponali reported in Debian (https://bugs.debian.org/1141604) the
following issue after updating from 6.12.90 to 6.12.94. First quoting
the report:

On Tue, Jul 07, 2026 at 07:37:24AM +0200, Ponali wrote:
> Package: src:linux
> Version: 6.12.94-1
> Severity: normal
> Tags: upstream, regression
> X-Debbugs-Cc: ponali2k@gmail.com
> 
> Last known working kernel: 6.12.90-1
> First known broken kernel: 6.12.94-1
> 
> 
> Dear Maintainer,
> 
> I upgraded all my packages through apt, which also upgraded the linux image
> from 6.12.90 to 6.12.94.
> 
> I expected the ScreenPad display to continue to be detected and exposed as a
> DRM output, like on 6.12.90. The ScreenPad being the trackpad with a screen,
> which came with my computer (ASUS VivoBook X532FA_S532FA).
> 
> After upgrading and rebooting, the new kernel caused a regression where the
> display of the ScreenPad fails to get recognized by the kernel. The touchpad
> functionality still works. Usually, the ScreenPad would appear as "HDMI-A-1".
> The DRM connector for it still exists (/sys/class/drm/card0-HDMI-A-1), but
> "status" reports "disabled"
> 
> I could not get the ScreenPad display to be recognized again on the new kernel,
> so I configured GRUB to automatically boot to the 6.12.90 kernel through the
> "Advanced Options". The ScreenPad is recognized on older kernel versions, so I
> am still able to use it (until a new LPE comes around).
> 
> To replicate:
> 1. Boot with 6.12.90. The ScreenPad display is detected as HDMI-A-1.
> 2. Boot with 6.12.94 with the exact same hardware.
> 3. The ScreenPad display is no longer usable.
> 
> 
> My main display is eDP-1 (1920x1080), though it isn't essential. My GPU is an
> integrated Intel iGPU, and the driver used for both screens is i915. I have
> booted to the new kernel for reportbug to get all the information
> automatically, but i will continue to use the old one until the appropriate
> time.

Now, Ponali did bisect the changes between 6.12.90 and 6.12.94 and
found that the backport of the commit 8d95d1f4aa5c ("platform/x86:
asus-wmi: fix screenpad brightness range") changed the behaviour.
Bisect log is at: https://bugs.debian.org/1141604#22

As this change was backported to other stable series as well I asked
Ponali to please test 7.0.y and 7.1.y and confirmed that both 7.0.13
and as well 7.1.3 show the hehaviour.

#regzbot introduced: 8d95d1f4aa5c76202b0833a70998769384612488
#regzbot link: https://bugs.debian.org/1141604

Is there anything Ponali can report back to further debug the issue?

Regards,
Salvatore

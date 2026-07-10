Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB08CA6B;
	Fri, 10 Jul 2026 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686679; cv=none; b=u8qkpc6k/H6GFRutDRd3YSLRiYJRSX5qRLcadd/DRfqPxX18+Kn7b/lbDfMvlKVmEAOamcvj4XTOPATDQKN4AP/NhUid+znYW1iSrK3q/MJxUdtszZhoQFT4FvvI8A5UBzTYvt675aEL2/oy+9M65lHP8ejtQzLCMLI26bZ2SlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686679; c=relaxed/simple;
	bh=fJQiBCYxAPgM6Wm8FMkCt5uuxtAmYrI+HaFJhT9sXD4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bp30zxVwcHi+bKfPNXcTmjvwqqE2DxswYcHcgK7Pk3bah005pxSDn3pi9i7mVVH0cF0/maWE0pGiIsz7NbkSv4xaVvjlKav+OQlTY62GSmNiC7EBi0ARcWzhzGP17TbXBtN6Wy1YolVAXCDHebTOsFOUR4FZ3r+ZovPXQqjSOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6hHosFY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6hHosFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783686678; x=1815222678;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fJQiBCYxAPgM6Wm8FMkCt5uuxtAmYrI+HaFJhT9sXD4=;
  b=C6hHosFYaZAlAx7wfeD4rk1bKKY8DS7mk7YsDjBgtNxBUCJVVag6ObiW
   MCp6keQSniDEAGKqKQueA9FSM4Rcu6RtZaSjIgjg98cEMYkYinLaGVtDt
   8JQ8l53TQIr6fqecM7M2ynGd91rxkmQQ30t7G7b4Q6r0ZtKT7RaaGKHC9
   xm5/u6hVlmXk2C7BmFnPPZ8D61DpQISBaOOevi+goAbMgm8MvXs/nOVbb
   gXA+dXtNoXMNZcZaf4C4PQqCCaW8BfPdl5xrKCvzo96h0CrrzQm+1v3Tv
   0z9jtmWjn2oIDf63bQYw+panjxmGma4Chf/z+ybPlngq9CS18rHgdxvGM
   A==;
X-CSE-ConnectionGUID: yJT1eWjySeWM+aZtIagk/g==
X-CSE-MsgGUID: brGXupgmSNqfF5xPZK2prQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84353572"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84353572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:31:17 -0700
X-CSE-ConnectionGUID: +RUHRk5xTsiMS/zRKYgNRQ==
X-CSE-MsgGUID: UkI6aFfbRkO+GmI5lirZpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253145675"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:31:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jul 2026 15:31:08 +0300 (EEST)
To: Denis Benato <denis.benato@linux.dev>
cc: Salvatore Bonaccorso <carnil@debian.org>, Ponali <ponali2k@gmail.com>, 
    Luke Jones <luke@ljones.dev>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, 1141604@bugs.debian.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Bug#1141604: linux-image-6.12.94+deb13-amd64: does not detect
 ScreenPad on ASUS VivoBook
In-Reply-To: <98dc115b-1dec-4fbb-bab7-2588e8b74bf8@linux.dev>
Message-ID: <0ff0385e-50b0-bfae-cedc-05cfe9c6cbc7@linux.intel.com>
References: <178340264407.17924.10135409461303815312.reportbug@ananaspc> <178362762638.911488.8564892548331679884@eldamar.lan> <98dc115b-1dec-4fbb-bab7-2588e8b74bf8@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jul 2026, Denis Benato wrote:
> On 7/9/26 22:08, Salvatore Bonaccorso wrote:
> > Control: forwarded -1 https://lore.kernel.org/regressions/178362762638.911488.8564892548331679884@eldamar.lan
> > Control: tags -1 + upstream
> >
> > Hi,
> >
> > Ponali reported in Debian (https://bugs.debian.org/1141604) the
> > following issue after updating from 6.12.90 to 6.12.94. First quoting
> > the report:
> >
> > On Tue, Jul 07, 2026 at 07:37:24AM +0200, Ponali wrote:
> >> Package: src:linux
> >> Version: 6.12.94-1
> >> Severity: normal
> >> Tags: upstream, regression
> >> X-Debbugs-Cc: ponali2k@gmail.com
> >>
> >> Last known working kernel: 6.12.90-1
> >> First known broken kernel: 6.12.94-1
> >>
> >>
> >> Dear Maintainer,
> >>
> >> I upgraded all my packages through apt, which also upgraded the linux image
> >> from 6.12.90 to 6.12.94.
> >>
> >> I expected the ScreenPad display to continue to be detected and exposed as a
> >> DRM output, like on 6.12.90. The ScreenPad being the trackpad with a screen,
> >> which came with my computer (ASUS VivoBook X532FA_S532FA).
> >>
> >> After upgrading and rebooting, the new kernel caused a regression where the
> >> display of the ScreenPad fails to get recognized by the kernel. The touchpad
> >> functionality still works. Usually, the ScreenPad would appear as "HDMI-A-1".
> >> The DRM connector for it still exists (/sys/class/drm/card0-HDMI-A-1), but
> >> "status" reports "disabled"
> >>
> >> I could not get the ScreenPad display to be recognized again on the new kernel,
> >> so I configured GRUB to automatically boot to the 6.12.90 kernel through the
> >> "Advanced Options". The ScreenPad is recognized on older kernel versions, so I
> >> am still able to use it (until a new LPE comes around).
> >>
> >> To replicate:
> >> 1. Boot with 6.12.90. The ScreenPad display is detected as HDMI-A-1.
> >> 2. Boot with 6.12.94 with the exact same hardware.
> >> 3. The ScreenPad display is no longer usable.
> >>
> >>
> >> My main display is eDP-1 (1920x1080), though it isn't essential. My GPU is an
> >> integrated Intel iGPU, and the driver used for both screens is i915. I have
> >> booted to the new kernel for reportbug to get all the information
> >> automatically, but i will continue to use the old one until the appropriate
> >> time.
> > Now, Ponali did bisect the changes between 6.12.90 and 6.12.94 and
> > found that the backport of the commit 8d95d1f4aa5c ("platform/x86:
> > asus-wmi: fix screenpad brightness range") changed the behaviour.
> > Bisect log is at: https://bugs.debian.org/1141604#22
> >
> > As this change was backported to other stable series as well I asked
> > Ponali to please test 7.0.y and 7.1.y and confirmed that both 7.0.13
> > and as well 7.1.3 show the hehaviour.
> >
> > #regzbot introduced: 8d95d1f4aa5c76202b0833a70998769384612488
> > #regzbot link: https://bugs.debian.org/1141604
> >
> > Is there anything Ponali can report back to further debug the issue?
> Hi Salvatore,
> 
> The commit incriminated is this one: https://lore.kernel.org/all/20260302174431.349816-3-denis.benato@linux.dev/
> 
> As you can see that commit changes min/max of the brightness range, but 
> does not touch the detection at all, 

To be more precise, it DOES change read_screenpad_backlight_power() -> 
asus_wmi_get_devstate_simple() but AFAICT that cannot make things worse 
because asus_wmi_get_devstate_simple() used in both cases, so I was 
left to wonder the same thing as you.

That being said, it's hard to see how bisect could point this to a wrong 
commit either because good/bad should be pretty obvious.

Did reverting the suspect commit on top of 6.12.94 result in a working 
system?

--
 i.

> while the user is complaining about "the display of the ScreenPad fails to get recognised by the kernel" and I can only thing about two things:
> - I got the range wrong and the kernel is rejecting the device due to wrong min/max
> - It's not true that the kernel fails to recognise the device and instead it's userspace refusing to expose it (this happened recently with upower for the battery so it can very well be a possibility)
> 
> > From the dmesg logs I don't see kernel being angry and rejecting the 
> > screenpad so I am leaning on the second option: may I ask for the user 
> > to try identify the sysfs attribute responsible to control the 
> > brightness and get me the range of min/max? Also I would be curious to 
> > know if changing desktop like KDE or GNOME changes something. 

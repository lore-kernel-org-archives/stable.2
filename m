Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80E423E9C;
	Fri,  9 Oct 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541502; cv=none; b=DFw2cFgbH+QB3axY14aR4YdY6TFir4Tum2jnX7u0OXf5Jmnebg9u/8VEqZzMZc5CmNGRBkKsDl3XfVHBphQ32dFREL3HFGYJnlEpgGaKh5O/i9UbJZWI8b8GgAW0pMu66k9SYM+LUn6JTVGh8Pz4TgJVN5grF5NZUjwNW3Ldehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541502; c=relaxed/simple;
	bh=yv6/ee95iQU11uO3xBn2CtXJqeyrdqA3Uk/fkdv3RWw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gKHYrVAWmuL/TBptN198Tj/BVuPAj2rgfqoRk9RmMEf1qYirbCNKabAj+JHs6uph/Lyfc1bn6VrtitZ/WC+Dm+ebKEp8GYq17syhIDxHzWXXQw3YxlRbIs6A04V5Ndm1Z4GBty9fLN70AhqKQizpZIhfPMBdWWHNkFx027PdxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St+uDfmX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St+uDfmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791541501; x=1823077501;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yv6/ee95iQU11uO3xBn2CtXJqeyrdqA3Uk/fkdv3RWw=;
  b=St+uDfmXLvCLQhzbKoTVuIya6K9+hcHZDOPB2ayofWdlwZjKq+IGIJmc
   kAs1xCayFyc5T24m/0hjMveAweiK6Nd4kKXK41uWoU44FQER9f2YJsN5e
   19k3qFazgQmOl6MEMdN7CKpwFZWDh5yd9PBwmZ/TFCrdxXoYQLHprUwh7
   igVMQB2CDekRFp6TDT5/I1JbFU1vFqENLDzG7HaGfWWXY9V/dXqDmXaHN
   oeq3a0+lVxuot/WsHpVmeocbzNVkymPxoYr2vDLCIZhMxs3ZhTaiwmQyx
   KIKHE6FAkr2HKiNQDVinb6XYArKWUdBFvyyWiABuzeeYbyoLbL9KjfDpz
   w==;
X-CSE-ConnectionGUID: HYcq44QLTKixAseOTphmDA==
X-CSE-MsgGUID: u4EaIvCqTpuWLAcDnyzTTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="346767"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="346767"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:25:00 -0700
X-CSE-ConnectionGUID: pYwYdo41TUu7DL5KRkXjWg==
X-CSE-MsgGUID: EsaxCISfRyOmBX62Zyh3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="224898"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:24:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 13:24:53 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Perry Yuan <perry.yuan@amd.com>, Hans de Goede <hansg@kernel.org>, 
    "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
    "Borislav Petkov (AMD)" <bp@alien8.de>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
In-Reply-To: <ed80d662-663d-40a4-abae-1dca9cf8e97d@amd.com>
Message-ID: <e668010a-7ddc-7347-e4e8-394f3c986c2c@linux.intel.com>
References: <20260921082609.244774-1-lgs201920130244@gmail.com> <179148103665.29028.12297507526234628809.b4-ty@b4> <ed80d662-663d-40a4-abae-1dca9cf8e97d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1657633669-1791541493=:3462"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1657633669-1791541493=:3462
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 8 Oct 2026, Mario Limonciello wrote:

>=20
>=20
> On 10/8/26 12:37, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 21 Sep 2026 16:26:09 +0800, Guangshuo Li wrote:
> >=20
> > > amd_hfi_init() registers the HFI platform device before registering
> > > the platform driver. If platform_driver_register() fails, the functio=
n
> > > returns the error without unregistering the already registered platfo=
rm
> > > device.
> > >=20
> > > Since the failed init path does not run amd_hfi_exit(), the platform
> > > device remains registered and its reference is never dropped, prevent=
ing
> > > the associated platform object from being released.
> > >=20
> > > [...]
> >=20
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo-next branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> > local branch there, which might take a while.
> >=20
> > FYI [if applicable to your patch], as per Linus' policy change, also
> > fixes are mostly routed through for-next unless the fix is for a
> > commit introduced in the most recent cycle or is clearly a regression
> > fix.
> >=20
> > The list of commits applied:
> > [1/1] platform/x86/amd/hfi: fix platform device leak on init failure
> >        commit: a15d58ff15a6ede327e3814c791c6912b973e434
> >=20
> > --
> >   i.
>=20
> Hi Ilpo,
>=20
> Did you see my follow up comment that this patch should be unnecessary?
>=20
> https://lore.kernel.org/platform-driver-x86/652e3b3b-0f56-4d01-8fd8-e4a9d=
dedabfe@kernel.org/

Ah, now I recall that. I just didn't notice your reply among many useless=
=20
replies that this patch happened to trigger while processing the patch=20
queue.

I've dropped the patch now.

> Basically pointless call torn out by this series:
>=20
> https://lore.kernel.org/platform-driver-x86/20260921170411.1149960-1-mari=
o.limonciello@amd.com/

I'll get to this, hopefully today (I'm almost done with processing simple=
=20
cases from the patch queue).

--=20
 i.

--8323328-1657633669-1791541493=:3462--

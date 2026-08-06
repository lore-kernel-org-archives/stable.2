Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D28433BD9;
	Thu,  6 Aug 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010297; cv=none; b=R5m0ard2J371AAWjEz2+7KuHJ3JpWoLYQ1uFEnANTTYJsDRkbUy5PhWooPfuQmBVXCH69zrmw5bLFsai8GCVmzbn5WpAUSa8dyZPdiCqUeiPc5E8mqdN4TlC8xbBErr2JN9tnamdTrOriHnhuOL009EaOzAZcytgRk/MG7fr4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010297; c=relaxed/simple;
	bh=rvL6ONRaJnIUNbo16zkLP3O78BOW1GGoCuNtVKsUJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt9aT54kWpARZSGR1f/xD5WnLw2uYDOsMj0Sb7XZeNpeWiLZnAg5301q8weJmWnkcUxLfjAyXP0PVFMZNZEG8ma/3k9ifBqw7z0Qb+VIl2OtfSDTLkNT0to+cQJH6f/Rg692hS8iCtlvCHYTCYc00/d06fvTN3tPa0CdDgJqzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyFSDop3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyFSDop3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786010294; x=1817546294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvL6ONRaJnIUNbo16zkLP3O78BOW1GGoCuNtVKsUJQI=;
  b=GyFSDop3V8IZfSHRs8KJSSyRt+TVX4dMwfaDipC1u17Y5/Kn+SFlEQzo
   109gXqL4oWo9F/x0EtxePnJcVGWwvu5tHPBbDBOJ+5DHZ4u/z8EpmPcIV
   /788roceTOSGph0AKC+yH6eBA4xXXWIOOhxNgsNx84icXD8X3YcfopOj5
   t5Cb3cztJ2S+e8t1uQCC5wcYO7iWg2fddo6GTYUz8T9JRA9C472VX40Wq
   dEo6raWcY2cJ5/LMahU0wz5A9sWWd5JeKYYZJD7w+iyble/nL8Yi0ovDs
   m0CTaMzPwuxuIgvDFr39i1OPHh23CtwLq5f9T8MiNaF3Rl5VI6Ez7BL3/
   Q==;
X-CSE-ConnectionGUID: xnIlv75nQwqRrzUDqFCEYA==
X-CSE-MsgGUID: M/KODaYHQ0aiX6xPsXmstg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86474370"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86474370"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:58:12 -0700
X-CSE-ConnectionGUID: H7NnenOZT5GvfTnOzZHQQg==
X-CSE-MsgGUID: O6ffZKpiTOWOjTSqoETsbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="262683929"
Received: from inaky-mobl1.amr.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:58:10 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 54F27121BFE;
	Thu, 06 Aug 2026 12:58:17 +0300 (EEST)
Date: Thu, 6 Aug 2026 12:58:17 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Serin Yeh <serin.yeh@intel.com>, linux-media@vger.kernel.org,
	jimmy.su@intel.com, sarang.sapre@intel.com, bod@kernel.org,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Message-ID: <anRauS-k_PTOdrZa@kekkonen.localdomain>
References: <20260806061804.1359700-1-serin.yeh@intel.com>
 <178600597076.2317790.15882507123821898906@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178600597076.2317790.15882507123821898906@ping.linuxembedded.co.uk>

Hi Kieran,

On Thu, Aug 06, 2026 at 09:46:10AM +0100, Kieran Bingham wrote:
> Quoting Serin Yeh (2026-08-06 07:18:04)
> > On Intel platforms the sensor is enumerated via ACPI, and an INT3472
> > "discrete" companion device (the power-logic-control driver under
> > drivers/platform/x86/intel/int3472) registers the sensor's
> > reset/powerdown GPIOs and the regulator supply. These resources are
> > therefore discoverable and usable through the standard gpiod/regulator
> > lookups at probe time.
> > 
> > However, the driver guarded both the GPIO/regulator acquisition in
> > ov8856_get_hwcfg() and the whole power-on/off sequence with
> > is_acpi_node() and skipped them on ACPI. As a result the sensor was
> > never powered or reset by the driver, and probe failed when reading the
> > chip ID in ov8856_identify_module().
> > 
> > Remove the is_acpi_node() checks so the GPIO/regulator resources are
> > acquired and the full power sequence runs regardless of the firmware
> > interface. The driver now behaves consistently across DT and ACPI
> > platforms and initialises the hardware correctly.
> 
> The calls to get GPIO resources is 'optional' but regulators aren't I
> don't think. Is this still ok ?
> 
> I think it is - and we can't run a device without the regulators - but I
> don't know how it works in ACPI land.
> 
> 
> Sakari, could this cause any regression ? I think it's ok - I just have
> a niggle of worry here in case there's something I'm not seeing.

There should be no need for explicit regulator control on ACPI systems,
however the reality isn't always aligned with how things should be. So on
some systems you do have to control regulators, even on ACPI.

> 
> 
> > Tested on Intel platforms with kernel 6.17 and 7.0.
> > 
> > Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock helper")
> 
> Is this accurate though? I don't think that commit caused or added the
> ACPI checks. Was this just the first line that matched a git blame ?
> 
> I suspect the blame might lie further back.
> 
> devm_gpiod_get_optional was still guarded by
>  "if (!is_acpi_node(fwnode))"
> 
> before d2fa1134a48b, it was just a bit higher before
> devm_v4l2_sensor_clk_get().

I think Fixes: could be dropped altogether: the patch is simply adding
support for systems where you do need to control regulators on ACPI.

-- 
Regards,

Sakari Ailus

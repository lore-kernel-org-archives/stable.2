Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991E405C3F;
	Thu, 30 Jul 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409429; cv=none; b=cUX9Jj9xr94n3uvZtdingHhID0hGc/YAQSJ/scuWe10hcEMukTiulnD9iDDTaccQQRRjXAb4ar/B7qOChoNVpGMJZD7Jsu7MF//Nv6pJ4lofSgGYGg4QsWZPvXKwTlyGa/VoYHvLghzAB1fmhL6qbld0Lvs2KsPEPL6Ob05s5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409429; c=relaxed/simple;
	bh=vR3KOP2wNni1PSsIaEaFJckIWBDQP1BYlMo4rQ2E4NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCVcyYZ4LzQ9rXnkItpsxU8UmPRMikgovVRSS0EFcMLqxV7KqehqixQWwVi6L9wggB+fr0/MrUBgAfx8PTkyR0rd3DnwAHrTmvwpR5/pf9lXoQNemkZO2UbMn7h/VLPwGsVwTpRn6xoctgK0BGGlbVkCUdLhisSqQBdJEy4sJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHOUfCx4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHOUfCx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785409428; x=1816945428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vR3KOP2wNni1PSsIaEaFJckIWBDQP1BYlMo4rQ2E4NA=;
  b=NHOUfCx4NHSOU6afwgQH7o6gdMN37ybfWzw7Q1pBkkcj4uHZ5SQ4KJPN
   gE4Ks2LZjpa0vCOrl/e20ziSYGcy2LBvCo3EzTpSo3dvZx0vdLq175Fq2
   e2PWS427EAgY6QKF0ZGG2F7ej1vHin/cx4oPKR6Ja3M9LEbDuBSZ0KDoo
   +OSCgJQGiXDdYC/N51FLARPpmOsuMdpcwhkEF3x/8a9fHy+/oU0EBe23a
   mTR5ZRGpk1erYqTaeH7enA3h9RApVlMbWwuWStYQXETe0S9g8VZ2MxfrC
   U9MzE9+JDqTpLAEGxzirQj61ujZqwnuzj0ZgJ48DsokHvibOkCw/1ctcI
   g==;
X-CSE-ConnectionGUID: sysherMiQM2uzsA0onMH5g==
X-CSE-MsgGUID: 9N2ysVSxQoOj+KlO9C0lOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97182103"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="97182103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:03:48 -0700
X-CSE-ConnectionGUID: lnFdRTJDQ8+JwW2klVOUzg==
X-CSE-MsgGUID: 0/0RwJK1TSax64VhvQt5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="256933272"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jul 2026 04:03:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5AF4999; Thu, 30 Jul 2026 13:03:43 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:03:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <amsvj5ARbbGDiWp-@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-4-heikki.krogerus@linux.intel.com>
 <amodgov-jMqxPiwV@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amodgov-jMqxPiwV@black.igk.intel.com>

On Wed, Jul 29, 2026 at 05:34:26PM +0200, Raag Jadav wrote:
> On Wed, Jul 22, 2026 at 03:35:54PM +0200, Heikki Krogerus wrote:
> > Some platforms make an assumption that the i2c controller's
> > enabled state indicates also the power state of the
> > controller. This can create a problem when the controller is
> > in disabled state, because the hardware may assume
> > incorrectly that it is then also in low-power state.
> > 
> > To fix this, the controller is kept enabled by taking over
> > the IC_ENABLE register. The controller has to be disabled
> > when the configuration is updated and when the target
> > address or the slave address are assigned, so disabling it
> > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > then re-enabling it again.
> > 
> > Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> I'll rely on Andy and Mika's disposition on this one.

Mika should be back from vacation.

-- 
heikki

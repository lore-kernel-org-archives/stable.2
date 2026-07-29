Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD748EBEF;
	Wed, 29 Jul 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339276; cv=none; b=IlxATN2vuhLR9aUEbwDgkIcy70KAiUHnU3C4Zd1QddY+t0I0diR8pKR9nhChIoz87XOXvZrZTXBX22ydasT3MB7c60ZJoAO/WNc00YLbxTJt2e01a1BnfPppibGVFINJv3X0h1mavmWk18Y12MaPitiLYVeGHL928XV7XhbCo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339276; c=relaxed/simple;
	bh=DcXiM0YjfvTd8FCo+yjKRVGvxoViQMnPMrkLHYDFAQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJDTFqrJxSLpvrxXVJ1muvLXcAsWc4Y9vaET2zXUBEONApzy7/7Jh0rYyiugAzA5JJaszX44Fo+mLBH9xdg1KhEkNXhC4H118zDuf6Hg88mgZT+OgVXmLhuEqhxcpoLXOrxYiKYrP/Qj555hylFnA1eXfj26RtdxfBDiT5uB+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv15NV7h; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv15NV7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785339273; x=1816875273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcXiM0YjfvTd8FCo+yjKRVGvxoViQMnPMrkLHYDFAQg=;
  b=mv15NV7hA86wFt/UfNhU8A1DlqayPpDx6D2dPXxVr8T4g4NUHU8NmwrO
   +xAlfM/nVPxXXpk7xkWWQdzHn6edeiVqWIg4vSiHm/J1gupw7dCYZSIZB
   U8jJnQbMRw8vwJ48CGMeJwvJPSpc5iodoxCYY6Ysp7vKMvmufCLFoV6D5
   eqD0U3gUB2/SHWn8gAlPDLdmY8kFmcHuLWyMxXTH9So/6lHu/92j4OdqI
   GvVBau0VW5mX+OxkxVVLUC8Mz98DrFNzE4AVS+YrwxL7hObrnnmhRyf8+
   MEuXATlIkAJbNeDL6mTjwllAqwb5jPWAhJLTRAUrHNcqtmbFGFpHNzdvj
   g==;
X-CSE-ConnectionGUID: VDVtNMDMQzOoScxU0ywnhA==
X-CSE-MsgGUID: 1nje16TgS+ap085NsZz3jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85985052"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85985052"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:34:31 -0700
X-CSE-ConnectionGUID: MfVhvtpfR+6oenkZMr0WSA==
X-CSE-MsgGUID: F3eBR584QHSAkKEn1S9pPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="263851686"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:34:29 -0700
Date: Wed, 29 Jul 2026 17:34:26 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <amodgov-jMqxPiwV@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-4-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722133554.2079612-4-heikki.krogerus@linux.intel.com>

On Wed, Jul 22, 2026 at 03:35:54PM +0200, Heikki Krogerus wrote:
> Some platforms make an assumption that the i2c controller's
> enabled state indicates also the power state of the
> controller. This can create a problem when the controller is
> in disabled state, because the hardware may assume
> incorrectly that it is then also in low-power state.
> 
> To fix this, the controller is kept enabled by taking over
> the IC_ENABLE register. The controller has to be disabled
> when the configuration is updated and when the target
> address or the slave address are assigned, so disabling it
> when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> then re-enabling it again.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

I'll rely on Andy and Mika's disposition on this one.

Raag

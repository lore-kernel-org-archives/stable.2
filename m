Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91D45517C;
	Wed, 29 Jul 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339063; cv=none; b=tedAxgDnriUxlaUltC+WYhyh1Jz9rwEJKk42JjJlRMelkGGvlz/kkunMMbX+y6lCj2VPPhA1gYJhiNoCa0PNAvQxfjcWc6pfmEHBnOLgjYGss0nSzaUUnBfQz7NXsaJU45P40HHhBhHVeSvSiDfO7susPlxheyxTiukT4fEl3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339063; c=relaxed/simple;
	bh=UQYh//v/OZZ8x9qRtEKztvsAkHsJ2fm3i4llQjIYcms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb89y5GS7rZ/VYnAwm3vc/vsSOYSiAccR+RtnfK4cHyj4nikt1Q3IBmflCMNhfXz9gsyG2TWMBQvHpWL5R4u2eSM3K/VqoauRIJ1pXWJTC4tMVBem5WmwIxA+UM5dIRnJSHaWvrcdF/UXoLuDRHJiFX0J06d5LGvvAw9/l84i7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m08ILuHw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m08ILuHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785339061; x=1816875061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQYh//v/OZZ8x9qRtEKztvsAkHsJ2fm3i4llQjIYcms=;
  b=m08ILuHw7B/e64b7eA601VpWPWyGw87a18l0LFPz5xhIejBKDunY5kK5
   IlYN1WOfA9yDEInPot9iKefEATOs3UvFxlR4faxOcVVy0Nv2nPEME0gDw
   SJsWJL2ii2Tm6eRbdlqYiS9wdxiKNRjIk+VwHICFrTmWBOTwtKc95Y7zU
   uvo4ej4REyavIgSWi2aQAPvpCFiH/sI2adPBNDbMYJB2qpkzcikdP6ctD
   7g5OGgJEqyX1BZP4Qju9jzwE9yp4Ni8d7j/Cy/0ZCkoRCg4qs88og6HOm
   wUansQCphs4HSx6ABBj7r8n87FBdEd6CtuLHgJEg8qe86iBD7mLvThYs5
   g==;
X-CSE-ConnectionGUID: yF4UBkYxTt+QzNE4Zao/Ag==
X-CSE-MsgGUID: MtITyVwFQ5+jfgMnIbPeug==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89627000"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="89627000"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:31:01 -0700
X-CSE-ConnectionGUID: OsT/OjzXQTyZMW9blDWJDg==
X-CSE-MsgGUID: ykCgXDpVSZeLCaP4tSi9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258798455"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:30:59 -0700
Date: Wed, 29 Jul 2026 17:30:55 +0200
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
Subject: Re: [PATCH v6 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <amocr6YvYCux0ylv@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722133554.2079612-3-heikki.krogerus@linux.intel.com>

On Wed, Jul 22, 2026 at 03:35:53PM +0200, Heikki Krogerus wrote:
> The platforms that support the interrupt from the I2C
> adapter can not handle the amount of interrupts the adapter
> generates because of the way the IRQ is routed in the
> hardware. The I2C controller driver has to be kept in
> polling mode because of that.
> 
> The AMC MCU can still generate critical alerts that have to
> be handled. The interrupt from SMBus Alert is left enabled
> and handled separately in the Xe. The alerts from the AMC
> will cause the device to be declared wedged for now.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ramesh Babu B <ramesh.babu.b@intel.com>
> Signed-off-by: Ramesh Babu B <ramesh.babu.b@intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Assuming no further changes came up during validation

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

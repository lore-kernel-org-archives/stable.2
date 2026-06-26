Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2F26B973;
	Fri, 26 Jun 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477169; cv=none; b=ToH/nraFFgR6+3D+aT35Y+haBGGrnRsZyhzAXJ0rwrksZw5EMqg/ccv1FNx7+F+UmZuJKxtUVwrcKg/stNKdyJ4EJC/OeOzVaSCayvqUX6m3cNKBN8GOzrOw+08aRjTN3SIDRc4tlG8lKCadSjFAjMBGHF2upUA0Oms+NeAHxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477169; c=relaxed/simple;
	bh=KcZgACwtmX+SVYeSnRzH9eljl4Ne8+uOz5GEYaGLwJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHCp0HJPg4NLNFOPHNJKsUMutFR6iw+vvZ7PfdJBu7GRoI4KEeUXKLVCOe/Faql3d9GXsLKGLt/2G/XLu1a/altsM1U7kMYoQKMLpE9l3ySYJ1h2yb2Ngozzb+dn3ir4SziC+6VtUVImGm0ex+ZSZSTe6u45ru4dErDIr5LyS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NorX4JAl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NorX4JAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782477168; x=1814013168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcZgACwtmX+SVYeSnRzH9eljl4Ne8+uOz5GEYaGLwJY=;
  b=NorX4JAlF7OboufltQJA7Eo5Dg1SuKScBbrs9aA5IzMIndlQ5vhgdkPV
   Qe+yBVVmV88k/4s8JfNZEuXr3BDQrsyQz6pOwMQf67cLxROiar9x4y58r
   JiBRCdbgVuGD/6ee8+rDu4GJ30gdlOHWv4tvr7wLHe7/5VEuxxHks3NVf
   APU/cY5jMHPna1qsuK6eo12Pi4/So/YJ6myYI0FoBKm/bhFwRUFgSBUL6
   LKnuKwmaY1j0AIjdyuTO4Jt8NRJY3Ci9aDudX3DSH/s1h2PvvkQvSGjOV
   BxnDU7oE35f7oZ0zrlqLuDHaAHkPKA3s3C6BPSAB8JLJn2PWPdzlS4BoR
   w==;
X-CSE-ConnectionGUID: VB0rk8g6QAqjdRbtStzTCw==
X-CSE-MsgGUID: 5bxxXJKnRka9coxpx6j1hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94417418"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94417418"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:32:47 -0700
X-CSE-ConnectionGUID: d63zfJFfQVeB/pl+AWWgSQ==
X-CSE-MsgGUID: H6vs7KUrSeahz+oWRGy/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247948579"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:32:43 -0700
Date: Fri, 26 Jun 2026 15:32:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>, Kees Cook <kees@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Mel Henning <mhenning@darkrefraction.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 2/2] drm/nouveau/gsp/r570: Never enter Gcoff state
Message-ID: <aj5xaeHusBhWhDK1@ashevche-desk.local>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625231252.89684-3-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:10:55PM -0400, Lyude Paul wrote:
> It turns out that the only reason our previous fixes looked like they
> worked for this was because we would occasionally set the Gcoff state to 0
> in the normal S3 path, which fixed suspend/resume on desktops - but not on
> machines using runtime suspend.
> 
> The proper fix is to just never set this flag. Our current guess for the
> reasoning behind this is that Gcoff likely coincides with GC6, and not
> literally power off.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
> Cc: <stable@vger.kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mel Henning <mhenning@darkrefraction.com>
> Cc: <stable@vger.kernel.org> # v6.19+
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same comment here.

-- 
With Best Regards,
Andy Shevchenko



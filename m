Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FF4A33ED;
	Fri, 21 Aug 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321987; cv=none; b=THVjQvpFnozQ488p7oySoYMMvHpKHhO2+MPc1yydMI2hvY2UtUETfnEHKfWms3rAcfh8D6UAdF927Z1dzBZBJmwMRgAWYhCVExYOlAfZaku5BRHuUDyT2pv7zA2sBW1Ie6pgb8y5ScA7i9GEVE1M69LeuDl0zLZU9rMqh+yFnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321987; c=relaxed/simple;
	bh=z8iAxAemn/0JgPj6PTSNSzKHXE5ttv1nlKOgH4UXlm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5XECGy5kDE7sB1MaE8/5wyVKBDza5rzXyGcA5VgRrtvdagfuTkoznQaqRsN+Vk56XMwGHNzf8N9xMkOghTCyisisesPBlOyRkbjX6JY55zR6LTSPJuQZF0g+JOFvu1337Fakep1uWDeRVQkzE6MNtDJOlb9UaYUVHbFHTJQvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By29JeCu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By29JeCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787321983; x=1818857983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z8iAxAemn/0JgPj6PTSNSzKHXE5ttv1nlKOgH4UXlm8=;
  b=By29JeCuRTobaYhar3chWXsfBir37LIYmJCTSzVBaP6eGj9ODygjQgML
   tfEeUb0DxuDH9Io2yfeDakVSBD2MW6xcK8rbgGf2L36Y+Rh/iT0SmCakM
   2+VrwuFIfnWqnojW9zip2EpfLq1k0KfaKxhojHT9BQm+y8evrZonctT2F
   uYcabk4gJ8pNCgcxz8v54B+0u/k6pv5QX6qzqG+G7pRlvqKUGfeTAnfN0
   7J4Lv+GLrov5YqyvxX/sa+BBQIsKuPoAVcRPk+Es784NoQfzYWLaXWegb
   8tEadEONvVp2Ujgr+jCW8ZPaZaWKyNCfR5BR+g7xC+TISsn20rPV9Y6Yr
   Q==;
X-CSE-ConnectionGUID: E4RcGwZQS9+Kqrx/DExk5Q==
X-CSE-MsgGUID: HMVzLKmvTnmUDslp7CXLRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99227885"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="99227885"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 07:19:41 -0700
X-CSE-ConnectionGUID: Z41FSKHpRRClrP8NuXTugg==
X-CSE-MsgGUID: JRl2iDgJTUeeglFRpLcyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="269840184"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 07:19:37 -0700
Date: Fri, 21 Aug 2026 17:19:33 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Chang =?utf-8?B?Smlvbmco5bi454KvKQ==?= <xspeed1989@gmail.com>,
	intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	"open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS" <intel-xe@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3
 in bxt_sanitize_cdclk()
Message-ID: <aohedWm6CXXBWf-G@intel.com>
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
 <20260816062344.796615-1-xspeed1989@gmail.com>
 <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
 <c779c8e8fc78c68aea12c2022b2d8c64541ca173@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c779c8e8fc78c68aea12c2022b2d8c64541ca173@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Wed, Aug 19, 2026 at 12:33:56PM +0300, Jani Nikula wrote:
> On Tue, 18 Aug 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Sun, 16 Aug 2026, Chang Jiong(常炯) <xspeed1989@gmail.com> wrote:
> >> Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
> >> without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
> >> CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
> >> comparing against the expected value.
> >>
> >> However bxt_cdclk_ctl() does not include the CD2X pipe select field
> >> at all on DISPLAY_VER() >= 30, so on Xe3 (PTL) the normalized
> >> readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
> >> never match the expected value (pipe field 0). The comparison now
> >> fails on every boot and we always take the full CDCLK PLL
> >> disable+re-enable path with the BIOS framebuffer actively scanning
> >> out - exactly what this code was trying to avoid. On a Panther Lake
> >> laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
> >> "CPU pipe A FIFO underrun" during probe and persistent full-screen
> >> scanout corruption for the first KMS client (the SDDM greeter);
> >> the corruption lasts until the next full modeset.
> >>
> >> Only normalize the CD2X pipe select field on platforms where
> >> bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
> >> check.
> >>
> >> Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Chang Jiong(常炯) <xspeed1989@gmail.com>
> >
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8569
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8901
> >
> > The first one has a patch from Ville that is identical to this one.
> >
> > I'll try to kick CI to get this tested before merging.
> 
> Okay, the patch is against some stable kernel, not against the current
> development tree. Please rebase on top of the drm-tip branch of the
> drm-tip repository.

I pushed my original fix and closed the other bugs as duplicates.

-- 
Ville Syrjälä
Intel

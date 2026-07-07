Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CF377555;
	Tue,  7 Jul 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446253; cv=none; b=bZWFETnr6fUa1foPkpYtw+Nc/czmckdi4xTbfhGfMWjIeyPqLauObuSIKP8r77OA/BoGnsTE7yhcO+bMChr/HkQhlXppcpU9FXB9nlurRo1xcjcSpRYtkCCYSRRxPijIgDMlYkF6qY1ALkoWTR96fZdBeYuMTR5MTYKs2vgwCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446253; c=relaxed/simple;
	bh=JwMRdMNLvGOfIf5Mj5GnwBA9ZduvEGXn6YIytSxmE14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0NYPst57KSTaqCSCTcxRf8vWphHBmzv8WTtNts0wJUyXaB24NcxSv5uf/Py1VAEOSVoFU2V0e317RDSYlZJ5BVZUNpPAhpQDkT49sBKavK03lbWW7XbFBfvuVqlx4R+2R0fDyth1p5pwtES1G6sgXouh+ESBcFIG6DfBdzuMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D957RX0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D957RX0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AB81F000E9;
	Tue,  7 Jul 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783446252;
	bh=Zt8E+1trE9oRAcQDrpe/0wnlVS0OZnmKDKkcj23hYuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D957RX0IpErWZM/MCZ+ps2XaOcETGk2gKfxVfzgiLneaVo7T+VH1Uc9StyaeZB+je
	 PHDetHBGPW/SHtcjF4t8RGP6sJmxXpu0ymGHAY5I4vfXa9jhJOAmD+TbsyLiOjF72k
	 nvnoTwZ41987n85WR17vI7qz+SZc2HX3xOd8BzQQZOmIzreGfN86ZXoVGbUwv4DbbP
	 4fUj77fsRVx+FGU9QdrOJQUxxTOOIxPTrkKhZMr7AjtWT3nboRC8bMj24Btg+kX2Gb
	 A0C6OznbzqpN+jV6FYxbHfLGdDQ3Mr3WU4IVtpudOEunxW0rNtgJ5AK8yIGYSEFljD
	 mgkxYa+7Q6dVA==
Date: Tue, 7 Jul 2026 10:44:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wende Tan <twd2.me@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260707174406.GA991448@ax162>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
 <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
 <20260706210158.GA73349@ax162>
 <20260707080753-4e88aca1-b88d-4f6c-b37a-f7f3064bda5e@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707080753-4e88aca1-b88d-4f6c-b37a-f7f3064bda5e@linutronix.de>

On Tue, Jul 07, 2026 at 08:10:19AM +0200, Thomas Weißschuh wrote:
> On Mon, Jul 06, 2026 at 02:01:58PM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 01, 2026 at 11:21:22AM +0200, Thomas Weißschuh wrote:
> > > With LTO enabled the compiler assumes that the vDSO functions are not
> > > used and optimizes them away completely. Currently this happens to
> > > __vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
> > > __vdso_gettimeofday() and __vdso_riscv_hwprobe().
> > > 
> > > Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/
> > 
> > While this change seems correct, is this really the fix for that report?
> > It seems like that error happens in clang but I would expect this sort
> > of issue to only appear once LTO has run through ld.lld?
> 
> At this point the vDSO userspace library has already run through ld.lld.
> That has optimized away the futex symbols, which means their offsets are not
> defined when building the regular vDSO *kernel* code.

Ahhh, thanks for the additional clarification! That makes much more
sense, I had missed that we were in kernel code, not userspace.

-- 
Cheers,
Nathan

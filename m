Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8540FDB9;
	Thu, 30 Jul 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409636; cv=none; b=Y85/dtCisDmJ8ZndtO8aeG+BSogpNzby4kR0vO2kb3eY71b5h9PpjgHJcVecnSPqRic643VOeq7n2P3wlQVJ6hsvsn1pi8v/CegZ4IriFnuetqPSwwhnTzVBGPahw5Vez6MqSBjysje+IDVmM+j0XFcHLHAgOxmrOCe7AG0fKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409636; c=relaxed/simple;
	bh=/o/SerpQauclJcfqXGbAFVcRHiTES4S4YrbmywNJjDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUOoUTKdrqC8Pzg9Kb0DXxC3ZsHybq7bFnJC8Jfrlz3sd/Sj4m7gKInqJuUV5FYtW2W3TeEjx3dcbUaZyKDojvJVPp+zhBhrNB8DrNXwYXMRj4MGYlEg1xPvTRdZdbxrGNQ5SdwAPAUuffEqpWn1YLhdY//BdzuEhBzM0WkenQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBaJ71Cb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBaJ71Cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785409634; x=1816945634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/o/SerpQauclJcfqXGbAFVcRHiTES4S4YrbmywNJjDQ=;
  b=WBaJ71CbE1J22fnkMqgGuOeAyYWrdi1uV7CgZXREvK9y5pfMOBz3Hxy0
   YVHxpsKALrlmYbKZg/CvAkCZbK6SCgpGOJ8hw3Yf+4bcPmT92CpwsKSfR
   eeBKS20MunU0a9nmlZrh8VnLlFMCiu7viwJbQ6qLyxz9lEkEGHU+XSo0W
   Evbl2a91EggwFBNEN/lC150dvaMjxeK7A83Pawb9wlY+YJ65IJmhA3W2d
   fEef7oiorIO4Z+gGw4y08xc02KS9QEBcyA4TuU8xa/MnjQNWAlszdW1cJ
   AYpdvw7n28GvRAMMZ30LubWUkQVZwEeNBwy3W+ts7cuDJ8O4V1Zg495sB
   g==;
X-CSE-ConnectionGUID: iOKTtyj2TWyCI91PguY0Cw==
X-CSE-MsgGUID: ASdbuVdzTjaJ9hYKNPhHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103563820"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103563820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:07:13 -0700
X-CSE-ConnectionGUID: JY0UaRYwRYmdduBRbuko5Q==
X-CSE-MsgGUID: gBlLHJBnRWGMrUoThehMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260337059"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 30 Jul 2026 04:07:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AD50599; Thu, 30 Jul 2026 13:07:09 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:07:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <20260730110709.GE20844@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-4-heikki.krogerus@linux.intel.com>
 <amodgov-jMqxPiwV@black.igk.intel.com>
 <amsvj5ARbbGDiWp-@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amsvj5ARbbGDiWp-@black.igk.intel.com>

On Thu, Jul 30, 2026 at 01:03:43PM +0200, Heikki Krogerus wrote:
> On Wed, Jul 29, 2026 at 05:34:26PM +0200, Raag Jadav wrote:
> > On Wed, Jul 22, 2026 at 03:35:54PM +0200, Heikki Krogerus wrote:
> > > Some platforms make an assumption that the i2c controller's
> > > enabled state indicates also the power state of the
> > > controller. This can create a problem when the controller is
> > > in disabled state, because the hardware may assume
> > > incorrectly that it is then also in low-power state.
> > > 
> > > To fix this, the controller is kept enabled by taking over
> > > the IC_ENABLE register. The controller has to be disabled
> > > when the configuration is updated and when the target
> > > address or the slave address are assigned, so disabling it
> > > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > > then re-enabling it again.
> > > 
> > > Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > I'll rely on Andy and Mika's disposition on this one.
> 
> Mika should be back from vacation.

Looks reasonable, no objections from me :)

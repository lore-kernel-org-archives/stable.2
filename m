Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906588;
	b=jr2Tb946+wLvdXH4teRVYP27SokwThYRdU1OlyYewatBEOHGbPF5AKAw3zfGrpEae42v
	 L62mQtTfe35d9I1y7vfzJXsmQmq9bpxaiEgwktSSIg7PMlVHleW0czcWcGt73i0JO1ukv
	 mkW4tiYZGOM+v5IiATn73uxwX4QPZeP+W17LsSkSGFGgIIke5clUZk9T0VeUzZdni8uLP
	 WCdKBm1sN8V1fRQJ62miS1cb7FiDPBK0AHvCh/tmQurdlsYDvGrbak3GFfALx5fLoYiLn
	 sMGM6jMI6wSSrq4Ygmj3x0+9KgtWiBiVknKPed8P735Q/4gumMCH0Xix2e+OuPq40/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906588;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sIMzr7tCCswzGqhee5Qd9BWq1x2xlpXll4Iq2ZTzjHQ=;
	b=tCcUsThXDGe7RjWATnpzdzh/p6Sc73IqlFqbvZDpRvdcSzCBURla0XRR50QX6SHHxOvO
	 CozbRfKoOCxJWr3s6SHTcAsYlkYdwtwzgu+XqEg+BJ0Ad/MPHXtsExAHtM0KfzqOLgTaU
	 5TUPWQVnFSprq5LWtaECvWpbkcnhAjACPg93tvqX2wtuIzBVCUQE4dyCZsCejOwKj+P4w
	 yFARC/S/LmKVEwhotGtSXQOJ4KYipUl5F9WKWRvOU1LCpdhnRzHhqh1ZCHe23L4KUpf3o
	 pGNZ5J31Yhz576PzrWeGiJZmnLvAYzS1R8fwWZzCwA39oM4oD4eSZLi0tQKtBNVe4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBI+fODT;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98114606A336;
	Tue, 17 Nov 2026 09:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98114606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBI+fODT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794906588; x=1826442588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PPKhAbu/xd5BU4QocBM56BpTBxKFlcrRJZeYTqJNWMI=;
  b=iBI+fODTLSLfpfTX9KzskzY4b/o1FP5jE0LF14rwFLh+ZbEpGdXlGiYd
   Nf1c/vwN4OoeXZ72uUi+YxndD7uaJcu/rqbB0Z5PeHcBNnvKU+tRemjyv
   cQR8/0p9E7oCQo9s5fLl6oJrnO9xPJj79y0v8T+/5x5aBVj6sM3eSF7YF
   pWEPBZHsRZvDtNvEvse3/urK9GHmVaelFYUnr57Ieo0o0I6pXP0k6/25M
   CumprIPNk0LW2chxIpibrjal11dn60ymSR4toKm1Wl0l1pfJ+HghbOXBb
   y7HDJawuCnfxYoKxOfQXkbXSyakG8FvBxyduxgs6tzl3bFkaBmBEeeAOV
   w==;
X-CSE-ConnectionGUID: myyKszQISMeH4b08ick4bA==
X-CSE-MsgGUID: 5FdJzY/YSQCalaH3lLPmSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3685819"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3685819"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:09:47 -0800
X-CSE-ConnectionGUID: kNqUTxWMTuy7VFcZ4JmM/w==
X-CSE-MsgGUID: yJ7sZknoTJyvRC7xH0tvOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10191074"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:09:45 -0800
Date: Tue, 17 Nov 2026 10:09:38 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: linux-media@vger.kernel.org, paul.elder@ideasonboard.com, 
	daniel@makrotopia.org, linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: rockchip: rkcif: Don't reset the hardware
 in runtime suspend
Message-ID: <avwZpcF8fti2vVI9@mdjait-mobl>
References: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
 <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
 <df61d7d2-7ad8-4b68-b3a0-7a03513ab5b7@collabora.com>
 <avsBed-E2RPJnZ6k@mdjait-mobl>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avsBed-E2RPJnZ6k@mdjait-mobl>

On Mon, Nov 16, 2026 at 03:30:33PM +0100, Mehdi Djait wrote:
> Hi Michael,
> 
> On Mon, Nov 16, 2026 at 11:58:35AM +0100, Michael Riesch wrote:
> > Hi Mehdi,
> > 
> > On 11/12/26 19:32, Mehdi Djait wrote:
> > > The reset in the runtime suspend also resets the VICAP IOMMU.
> > > 
> > > When the IOMMU driver accesses the IOMMU registers inside the delay window
> > > between the assert and deassert, e.g. in rk_iommu_zap_lines() to shootdown
> > > IOTLB entries, the system hangs.
> > > 
> > > Drop the reset and the now unused reset control.
> > 
> > I agree that the current situation is nothing more than a crude hack
> > that happened to work in most cases. But I doubt simply removing the
> > reset is the correct solution. Recently, I saw some downstream patch
> > that makes the reset a shared one, which seems like the right thing to
> > do here. What would you think about that?
> 
> Do you have a link for these patches ?
> 
> I also agree that this patch will not be the solution that will go in
> but the situation needs to change.
> 
> The VICAP_GLB_CTRL register does expose this:
> reset the VICAP(except MMU/AXI MASTER/REG FILE)
> 
> The Rockchip-bsp kernel exports the disable and enable functions of the
> iommu driver and calls them in the rkcif driver, see:
> https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/media/platform/rockchip/cif/capture.c#L7269
> 

I mean, I of course don't think this is a solution to be considered, but
this is what I found for now..

--
Kind regards
Mehdi Djait

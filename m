Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E121559C81;
	Tue,  8 Sep 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880148; cv=none; b=jbx4qwGC4bfEAi6DJqmD7z3Q6v6Oxrb2dgyyVy6/Zn5V4MS68VHPj25Qx+4eGtB9i3LHskvdpO36HcBww263j6vcVKrxVT7A7Z7u+k1SAlLWuD1liy0FDgXxCPiAaaF0/DF2Ol/RCUef/Jf0gAAWaed2y62sbR+q0RvkGpQNfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880148; c=relaxed/simple;
	bh=suDetCt/PEGpqD3P+OPNU181LrJxjMPV1YiajX/hHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOGam+6Phjq3JXDX/NtuSu8PPmc3nYKhir/awE6xks9AaaohPjx74uw3Sb4h25q1xgL1lFvfTv511+bsL3aQXIBGnr1gKF80bx484Hnz0WyiNhpajLJv5dSEkJYT4ubUZEnmTd0RBmm7XYeQ8Pp5xyTVSbVPhqTnaTGEH4/PBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZRQe86C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZRQe86C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788880139; x=1820416139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=suDetCt/PEGpqD3P+OPNU181LrJxjMPV1YiajX/hHf0=;
  b=bZRQe86C5t+s8iuppC+Sfebk0bnp60F2LzkAoJrrd1zfvMPo6gcp1g8E
   ePoulbJvnr7NfWDauliYbZNAZ+qaltCh3VkYNRenfmhK74oM+kDmhXFTf
   QVOKYKkz68g4WjR+dUgLqEl2rI9xD6F37YZsBo52pf/2wpf8CBWgtGzh9
   Hxcz7dMS3ZbsbgfYY5PWzPxzRQZtQtjeXPAvm4i/aSxuWXqKls/zALdKV
   BJhuPCnDWFddhiZ/xP99Yt8juIyphfgSlAdZovfwDhYu0DWNv/4wzIJbg
   eufT1h8J3WDZREoyY1zrbEfxzsml6pCTV7T+joTACqDmD942d8uWtbT6C
   Q==;
X-CSE-ConnectionGUID: 4TKVKjcAT+O/unYWGtceeg==
X-CSE-MsgGUID: IjAkxXLqTBCaQ8SYO0wJBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="92983746"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="92983746"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:08:54 -0700
X-CSE-ConnectionGUID: 0/Nu4V/tSP68SngOGwNaKA==
X-CSE-MsgGUID: MlMABm/hTnCSXMYQmR2Opw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274833375"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:08:50 -0700
Date: Tue, 8 Sep 2026 18:08:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
Message-ID: <aqAlAJEJPrglb2E_@ashevche-desk.local>
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
 <CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
 <20260908150311.00000da6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908150311.00000da6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 08, 2026 at 03:03:11PM +0200, Joshua Crofts wrote:
> On Tue, 8 Sep 2026 15:41:23 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Sep 8, 2026 at 2:41 PM Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > >
> > > The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
> > > macro.  
> > 
> > Is this a problem?
> 
> For systems using devicetree, no. For legacy systems using spi_board_info and
> this stuff, yes.
> 
> If you're referring to the mark for stable then I'm fine with removing it.

No, I'm trying to (implicitly) tell you that the commit message misses
the answer to "why?".

-- 
With Best Regards,
Andy Shevchenko



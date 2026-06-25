Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951493074B1;
	Thu, 25 Jun 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369801; cv=none; b=BpmizkXl95MzEctrpGvtWUZtflrEurQBnQXY/GusvAKZ8l6Lx3ZN8pJBvDt8LlfF8ANDDCrVGzIQz4E5jTZZbWch4Zn+S9lk5ParF4cr0XXYCkJ12EuDaJIWlme0y8/0SKYWMRQYR9L9blTOeSSV9VymAbyMDxw1nqJh7T4o2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369801; c=relaxed/simple;
	bh=ZkCZ+PvKSsAlrWKiWwS9avQLygO8V0+UtEp5WRMVUPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCIFtrzE5AwwShLJi0C0JCi8iAUg3FeDVvLDLVy1Vf0tw7lmpbTlDSSKSX7nkv3NRv8fMVOpcA2bkDfjR0Qtsqgl9SBz8gzRO6SaqFTKy3oX5ysJOeCr1NlzFiD18u6tw8kRH7pAPNiUd2wkDl8mJTN08bH4ui+QSLit/4pLgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2RikE/x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2RikE/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369800; x=1813905800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZkCZ+PvKSsAlrWKiWwS9avQLygO8V0+UtEp5WRMVUPw=;
  b=O2RikE/xif0LANMdjCyga36GHXmO3Nx3xoRhFifUcXTBgo2x+bLuFca+
   hONqIhUQlnECy7XgxTTUxQD0HjU4Kn5S4qBppdV/7A4uGV8i59rEHNbqn
   9kuZecy7Eg4vZFGWsD7QuNSi9KiYXzfyv8w4xiC7XPVr7w3Yw/BuRRuOp
   qDuJ9jjQt/JLzoB5YscIc+oQsALDwOX6UEoEL/TDsH2aFHZxKDgctZb7I
   IV0dbax1gN1ib8yxcqtCruKWGPKVc5ajnzWJl4BtRZ1lLt7YWCIs7gVDc
   AKWJMOMaehca02rZhDtDZPhThK5AC2fRD4f2xe1sKDPIIMYsyjS8IR7ly
   g==;
X-CSE-ConnectionGUID: X5aRDU9rRwuN53uvpRAz6g==
X-CSE-MsgGUID: Ku/I0+/BTmeyrS7WLoTupw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86984214"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="86984214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:43:20 -0700
X-CSE-ConnectionGUID: i6IUU8G9RWyn2fO2A9vzlA==
X-CSE-MsgGUID: PROuEBAvQ0mYGYFWFy9iyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="247926035"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:43:17 -0700
Date: Thu, 25 Jun 2026 09:43:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: Build mlx90635 with CONFIG_MLX90635
Message-ID: <ajzOA3MGaCqrgCDp@ashevche-desk.local>
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
 <20260625054259.76774-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625054259.76774-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 01:42:59PM +0800, Pengpeng Hou wrote:
> drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
> the Makefile currently builds mlx90635.o under CONFIG_MLX90632.
> 
> This means enabling CONFIG_MLX90635 alone does not carry its provider
> object into the build, while enabling CONFIG_MLX90632 unexpectedly also
> builds mlx90635.o.
> 
> Gate mlx90635.o on the matching generated Kconfig symbol.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



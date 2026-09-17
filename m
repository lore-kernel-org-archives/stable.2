Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422479CD;
	Thu, 17 Sep 2026 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628268; cv=none; b=W6bc3xUm0lioCZROZtileqV/KK2I/sxAu2NFlvTEGm6W20L66QXhmLRHv0KCBGBCyugp+tGiRnkSPAYVaPj9BECMMndN746HreHzFXZr0wb+Q+o2WNBwAENnjWUVsfCki7/JiG7qFr26UaR/MbxD8c6/Dawnvll4SmSVRmYMbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628268; c=relaxed/simple;
	bh=d+j6sRCIMCL7jTmbiPfcwJKDQLoJglY1jAVWQeOicMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF7t7JRaXEMqzp8gAzfcC/FU8Xyg00TgSe0nkYmO1NWmotNJn0hzvau44IRnDsZiuemD75WEDCYia5a9BYolsd1OyHIJVWD0Ybv0vwSMlnGorSCzsB1T1WRAzq24Gs+UfLJOsZdzJVA7SIuKVp3yXpDdHx+HP+UyAGcyE81MAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIQGS9Sv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIQGS9Sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789628266; x=1821164266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d+j6sRCIMCL7jTmbiPfcwJKDQLoJglY1jAVWQeOicMU=;
  b=hIQGS9SvFiqfsTfoOTuSpf9TLkG2+zp9VF+H6SO3wHnPgdge162dxkmn
   eE/jO8JqqlklCl/gO03d1ZQfI0rryeFT8pYNTniAjtIKpiCV7k5K/c4QD
   QgSkfN49cnNX/D7zTAzMN6AE4UmdlzcpDbEBvugahK8ZxXU4qZFMhDAGQ
   K6EhJ8zx7YsBVVUoWtKKSMlt7ZTbxM/qHXefGkh/hEmOmiOPopTVhxlwR
   3x2PrTMPDN/4/0YpXIFZmmNGta6eTLCes24YjynK8sApI0H4yWmaVynee
   IbA0h1owfnXcWIa+mJ1c6vwmP9Kuz37YbHQXtV4ddCvWtbb2JAhVRP+PV
   Q==;
X-CSE-ConnectionGUID: Pogs9a6PSoehKzVoH+aoeg==
X-CSE-MsgGUID: 1raFZF/3SYif3UgVtZG71Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89887009"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89887009"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:57:45 -0700
X-CSE-ConnectionGUID: dsrwRVcxSZqijTofHs19BA==
X-CSE-MsgGUID: JwSfN43XQ7u08exarL/CWg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 23:57:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1CB0599; Thu, 17 Sep 2026 08:57:43 +0200 (CEST)
Date: Thu, 17 Sep 2026 08:57:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy.shevchenko@gmail.com, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	westeri@kernel.org, wsa+renesas@sang-engineering.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Fix adapter reference leak in
 i2c_acpi_new_device_by_fwnode()
Message-ID: <20260917065743.GZ106095@black.igk.intel.com>
References: <20260916155507.2074970-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916155507.2074970-1-vulab@iscas.ac.cn>

Hi,

On Wed, Sep 16, 2026 at 03:55:07PM +0000, Wentao Liang wrote:
> i2c_acpi_find_adapter_by_handle() returns the adapter with a reference
> obtained via get_device() in bus_find_device(), which the caller is
> responsible for dropping. i2c_new_client_device() stores the adapter
> pointer without taking a reference and does not release the caller's
> reference on any path, so the reference is leaked.
> 
> Drop the adapter device reference after creating the client, like
> i2c_acpi_notify() does.
> 
> Fixes: 53f8f7c5cf14 ("i2c: break out ACPI support into separate file")

I don't think this is right. The issue existed already before the move.

> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Acked-by: Mika Westerberg <westeri@kernel.org>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591170;
	b=Rqa4tRklDIGTTgeTqLkCoyfs7PD0Lg/W1CxTuqjUC2fjhBv2Kop2c+Dw4DvtJooe6kaF
	 6JBV+rh7LWWEDXCzHSXAnXjNhmfNXoevDsWSkutNkqbQbxsr4biVG+ifCHm09B6m0t0OB
	 ozVXmbmCBY50H7oPbOvgJCb7OXuJkjGMiwQPPcfX8S5TXskKIIK48Pagig0+eOJqPZkar
	 9fOnhaH2zSu5Xy7auDFMGWSrcHabMZb4WrelqYAwW009553g9krzBIzXr/Qg5daYh18+5
	 /3s/gCUM7b9BAe5FopZsCbgcnuJ3D5i59MC31LXp/zY+TsZmRXCemC282ryk4TrzA4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vSQoDagxyihYP1vKF332R0mDWULHguDgjqStaVIqJ2A=;
	b=BlluvK7A4FRK/p32RfLb1TJQep7wQNQ8wZ5VqfpfZbmbOX1eaFHFMyg4uddTaLI2G/rZ
	 xrsI9j1Hx5E0WixoSwTiDkkQY81ajOl9mwcMD65DAqQ3KNyURgjH6X554G7wjWdxPYqS3
	 +ZEk2pOvLHsbOT8EYXQPSlu4py7QMOl0bAIfqa/XLtu+P9AvJJCvdf0Hu8f9AtrSgWg9h
	 5P6FAq7e7nN2P5c0Yvyp9AtDI1MHyeuSwF3y8G+0MP/hU5PMqxojlPU8v/WZnMSgMHSO0
	 TO8NhIoqkxcfa9vdRFbKFXCx13XU9X5RfHvttXHFJzCIdjqAhQ7sZYwplbL409XT+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jlaWwBHT;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8999606A322;
	Wed, 21 Oct 2026 13:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8999606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jlaWwBHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792591170; x=1824127170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cSJg9Z7Z5EWOwDOoxGRpkWaMzNjsyTtcg8uwY5IxO9Q=;
  b=jlaWwBHTrBbBF16DdnZ/NfHf2+jAziWQr4/5u3asI/AW5RWKSdAJdOmi
   zFHIqWYN7+F5UyYq3mAW/CPckXAts9a6v2Ju3CBV6c12D+EV1+dMxfVOX
   KolxDyzQy345TPyfWOqqjAQuUZhvkb4fG6pK9daanK0qiemaENmAMhQx1
   QhbLrT2WGRTMf6AtHoJ66c9USN4PqvsOCHQLB7fLmv5UbWk9rS9ddhjV5
   YYJTKhPl92dGGGHw6XNDkBwLTr2RHxZpXPgMW0EsvEO6zPUz0YBaiocmd
   bRCYu4C2HNZ0WztVUIv2J84CBJODAnJy1I8f0xYKVNO4sRdPot9QR1s47
   A==;
X-CSE-ConnectionGUID: 8eHpBGfvTY+OFSU9/h5uig==
X-CSE-MsgGUID: ieZ1J2JbTleGPosIsfEtcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1213465"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1213465"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:59:30 -0700
X-CSE-ConnectionGUID: ciTB+8E+R0qbpDgaesEwxQ==
X-CSE-MsgGUID: HsysuqszQaWK8Bv8PtdAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4897123"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:59:27 -0700
Date: Wed, 21 Oct 2026 16:59:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Corey Minyard <corey@minyard.net>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/28] mfd: ls2kbmc: Cancel reset work on teardown via
 devm_work_autocancel()
Message-ID: <atjFPeEWbPT6SnUr@ashevche-desk.local>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-3-lee@kernel.org>
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
In-Reply-To: <20261021121245.3111563-3-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 12:09:25PM +0000, Lee Jones wrote:
> ls2k_bmc_init() initialises bmc_reset_work with INIT_WORK() and
> immediately requests the PCIe and GPIO interrupts via devm_request_irq().
> If an interrupt fires and schedules bmc_reset_work before a subsequent
> step in ls2k_bmc_probe() fails, or when the device is unbound, devres
> frees ddata whilst bmc_reset_work remains queued, leading to a
> use-after-free in ls2k_bmc_events_fn().
> 
> Initialise bmc_reset_work with devm_work_autocancel() before requesting
> the interrupts so that devres cancels any pending work after the
> interrupts are freed and before ddata is released.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
assuming you will add Reported-by: Sashiko...

-- 
With Best Regards,
Andy Shevchenko



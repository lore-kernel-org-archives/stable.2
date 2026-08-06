Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170C431A30;
	Thu,  6 Aug 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011637; cv=none; b=L1fjgGXYYJcgB57rq9YbcL+RslgiBfsZd9aSqlfTtIw0X/DTCQzLBu6/UCBjZZW9t9qQd+g0lflkjbZ1+wv/4kg65E2xxu6TEYptwIDWHqk+ZESCbqS16k8srTaskeoNH9aOWjFRJKWKODo3CSBCtCRujmCDX9InwftYwmYcHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011637; c=relaxed/simple;
	bh=0Z3G2DDCw2Ynj7CP+6kvB+n6rjbaVNl1nvdmRYu6Y7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCKFdeQJJusLIADZfgbniV87RXappGq9YIksKMXQSJPpRdXxt+GrLM0z4BGTDBqrHa9TUFG2cnvG96/lpCTjTAdWJD32w071Z7IyQse304klTTczYUCiXEVRDCmKEZ2f9JkIOogNNZYgVdPWPnQRrVO/9xF9dSI9CcYv8FM3LyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aISl/UsU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aISl/UsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786011633; x=1817547633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Z3G2DDCw2Ynj7CP+6kvB+n6rjbaVNl1nvdmRYu6Y7U=;
  b=aISl/UsUyt0hB+HWddHhEIRbNQjXoDAzklTIaUIX2HoORuWA6RZxOLt1
   HVkhcPgdpE0no+AC8kXrpzCqm2OOZRSxpoAppkjZckDSgfayx/w9tnFv8
   C02dovTqVj4ONIst++7M5GfMvohGqKomLQ1ej12oWBpo8sc7PvF4vPPgR
   dEJdoiKDhNhHAyP+aU+uK88JaolTNh9/E4xGAvergfIFJACkgA8rAZvVN
   5F276lQLvkgjdtOAwIxs7whGpShOfJOS+B7Pq11iyQAerl0KpEZzVgN25
   4z8zFuDRoz4NDBgl6CGxY84ZXw4H7f2pzYpcN9yzhn/InSmokNLm4nsWt
   A==;
X-CSE-ConnectionGUID: UsPGoDONR/yOY+kubbqfPA==
X-CSE-MsgGUID: /YRUKMXRR0KCkipJZ8fjIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104138197"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="104138197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 03:20:30 -0700
X-CSE-ConnectionGUID: r2xSz7FbSyiQi0hlwNyVUQ==
X-CSE-MsgGUID: MwmMfc7JTP632CIckauNRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260808694"
Received: from inaky-mobl1.amr.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 03:20:30 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D1B7F121C0F;
	Thu, 06 Aug 2026 13:20:36 +0300 (EEST)
Date: Thu, 6 Aug 2026 13:20:36 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Serin Yeh <serin.yeh@intel.com>
Cc: linux-media@vger.kernel.org, jimmy.su@intel.com, sarang.sapre@intel.com,
	bod@kernel.org, kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Message-ID: <anRf9Jy6BcygUk8d@kekkonen.localdomain>
References: <20260806061804.1359700-1-serin.yeh@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806061804.1359700-1-serin.yeh@intel.com>

Hi Serin,

On Thu, Aug 06, 2026 at 02:18:04PM +0800, Serin Yeh wrote:
> On Intel platforms the sensor is enumerated via ACPI, and an INT3472
> "discrete" companion device (the power-logic-control driver under
> drivers/platform/x86/intel/int3472) registers the sensor's
> reset/powerdown GPIOs and the regulator supply. These resources are
> therefore discoverable and usable through the standard gpiod/regulator
> lookups at probe time.
> 
> However, the driver guarded both the GPIO/regulator acquisition in
> ov8856_get_hwcfg() and the whole power-on/off sequence with
> is_acpi_node() and skipped them on ACPI. As a result the sensor was
> never powered or reset by the driver, and probe failed when reading the
> chip ID in ov8856_identify_module().
> 
> Remove the is_acpi_node() checks so the GPIO/regulator resources are
> acquired and the full power sequence runs regardless of the firmware
> interface. The driver now behaves consistently across DT and ACPI
> platforms and initialises the hardware correctly.
> 
> Tested on Intel platforms with kernel 6.17 and 7.0.

Only testing on current kernel matters so this is rather redundant. If
there are no other changes needed, I'll drop this and Fixes:/Cc: tags while
applying.

> 
> Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serin Yeh <serin.yeh@intel.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

-- 
Regards,

Sakari Ailus

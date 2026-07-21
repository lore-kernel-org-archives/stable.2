Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033D4611C7;
	Tue, 21 Jul 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629479; cv=none; b=sFiu+Wp31Ofk0tghNIpMPR/whO74pyDGOhLKwswWG7EWPzf1p7RQ7CjWJE+KKlH+1+ANmIlgIUAHkfSRiTpTfDoSAGWRjq8A4zK4p8xNRf2ugCY7n4NzFrNAkB5DBi9/Yg/JYjT+sv1c2lrDdET7MBNlDRzZ57D8/YFOXB8glB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629479; c=relaxed/simple;
	bh=w+QCs7/PtircRe0e6UhnPZUwxnm+QR57pLfRt5nVixc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V4rHxKdorq5GP14rLJsPMjcRtMRyz9blziXxAX8TXQO2RKzq0RTHmmTqhON5dXZaKBCwSY15YRyETv/YvvQqHuvaImHMDRMklGn711QZvRjEpiElLGGNCsK6rE/SNreelw5GJHID7qgq4Xukjx3lkhttK71mwqaNwnY3Pamkw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUlOJL1T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUlOJL1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629478; x=1816165478;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w+QCs7/PtircRe0e6UhnPZUwxnm+QR57pLfRt5nVixc=;
  b=VUlOJL1TK2qCyDc2a3ND5kEt79P5rk1BB+s9eVb4BF6zxcQ2vkCEHwak
   cbAuuZZsjcBfuW5Hfwv9JAcoQyK3s7RG3QTMqbh33l+KYt//f6JPMEOhC
   5pZg1ikpHCawJ2T93onejOdp/WYFFxLqoIUIkCKZD0q+BILRwSzWs4Zlv
   Ljz7BXe/pxj6Psu2c1Ex5LPm3+aYJI2QczhiGJTHoWaf+sZAJGl40bZFE
   8/DfgrTk0BLrNIjqjQSZBIlXNfJlKUEheLLdMyJCkWkIZF7LtNnuqIDsE
   19KbidFvI9w0h6EQQCPttSVrWaV4OrYffuk13O46GvuKAtEmRqsMqNyr/
   g==;
X-CSE-ConnectionGUID: fzDv+01JT0uQY5yUh2+03g==
X-CSE-MsgGUID: XPC9/9/UQvqMrgfKctuj0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85241951"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85241951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:24:37 -0700
X-CSE-ConnectionGUID: Y848cS0WS2+OJshr3DIcWg==
X-CSE-MsgGUID: BECveOkhT2av94s5AcAK1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="295931620"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:24:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 13:24:32 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hansg@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
    "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, 
    Francis De Brabandere <francisdb@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] platform/x86/amd/pmc: Fix error handling in
 amd_stb_s2d_init()
In-Reply-To: <20260717162023.956346-3-mario.limonciello@amd.com>
Message-ID: <54655f38-edf4-e756-e24c-5f4cb041d63c@linux.intel.com>
References: <20260717162023.956346-1-mario.limonciello@amd.com> <20260717162023.956346-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Jul 2026, Mario Limonciello wrote:

> amd_stb_s2d_init() has two problems on its error paths:
> 
>  - The return value of the S2D_TELEMETRY_SIZE SMU command is discarded.
>    When the SMU refuses the command (e.g. "SMU cmd failed. err: 0xff")
>    the failure is only noticed indirectly through the telemetry size
>    check and reported as -EIO, masking the real error.
> 
>  - dev->msg_port is switched to MSG_PORT_S2D before issuing the S2D SMU
>    commands but is only restored to MSG_PORT_PMC on the success path.
>    The early "return -EIO" leaves the port stuck on MSG_PORT_S2D, so all
>    subsequent SMU communication - including the s2idle prepare/restore
>    handlers - is directed at the wrong mailbox.

If you fix the second one first (see below, it seems another place needs 
similar fix), the first one can be fixed on top of it in own patch.

> Consolidate the exit path through a single label so the message port is
> always restored, and propagate the SMU command error directly instead of
> inferring it from the size.
> 
> Assisted-by: Claude:opus
> Reported-by: Francis De Brabandere <francisdb@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
> Tested-by: Francis De Brabandere <francisdb@gmail.com>
> Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc/mp1_stb.c | 28 +++++++++++++++-----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
> index 753d630f3283d..6a048cb2605ec 100644
> --- a/drivers/platform/x86/amd/pmc/mp1_stb.c
> +++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
> @@ -289,7 +289,7 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
>  	u32 phys_addr_low, phys_addr_hi;
>  	u64 stb_phys_addr;
>  	u32 size = 0;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!enable_stb)
>  		return 0;
> @@ -306,13 +306,17 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
>  	/* Spill to DRAM feature uses separate SMU message port */
>  	dev->msg_port = MSG_PORT_S2D;
>  
> -	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
> -	if (size != S2D_TELEMETRY_BYTES_MAX)
> -		return -EIO;
> +	ret = amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
> +	if (ret)
> +		goto out;
> +	if (size != S2D_TELEMETRY_BYTES_MAX) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  
> -	/* Get DRAM size */
> -	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
> -	if (ret || !dev->dram_size)
> +	/* Get DRAM size; fall back to the default if the query fails */
> +	if (amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true) ||
> +	    !dev->dram_size)
>  		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
>  
>  	/* Get STB DRAM address */
> @@ -321,12 +325,12 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
>  
>  	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
>  
> -	/* Clear msg_port for other SMU operation */
> -	dev->msg_port = MSG_PORT_PMC;
> -
>  	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
>  	if (!dev->stb_virt_addr)
> -		return -ENOMEM;
> +		ret = -ENOMEM;
>  
> -	return 0;
> +out:
> +	/* Restore the default message port for subsequent SMU operations */
> +	dev->msg_port = MSG_PORT_PMC;

Sashiko (correctly?) points out amd_stb_debugfs_open_v2() has the same 
problem of leaving from msg_port.

To me it looks like having ->msg_port in dev is design error and it should 
be a parameter to the relevant functions instead or with some wrapping 
given by those functions that actually need to give the non-default port.

-- 
 i.


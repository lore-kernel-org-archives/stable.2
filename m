Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC873AE19C;
	Tue, 21 Jul 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629184; cv=none; b=GwBOgSrE2Q8Qu5TP7JR0WlQet+txjwF8+LMyYb07tJvIy8n+kyNNYmN3gJLeFs70K5nldjpdDm5VhVYeyt87OLdeS6H76yfx7nsBxraP4DaHzvoAHI/TqNEbGQM45p3QLy1HCXmazvUdHqIJD2CYjtjFOClEm8DHVlvmJaY7wmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629184; c=relaxed/simple;
	bh=JNbDPvZlLqNKzFvNH+8QFfcsJvoWiygaXJJa+SetBN4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GUS10imMvdABuq4eN+Je6hqiWi9LTGzyfSI+NMbZDTC0DlReei3s9pAwomLao9Oj3xqd+uXRwf1UuZJ7ATVdX11aUB2rU6vrCx1KxeJ5Nwycvby5tLXeCvBSGPUxC8kDOEGgOWiRLXRsYfObfb/1tzErFaX1vCLT3iR/DQZTpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1V8JHWo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1V8JHWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629180; x=1816165180;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JNbDPvZlLqNKzFvNH+8QFfcsJvoWiygaXJJa+SetBN4=;
  b=I1V8JHWoC50RmgbZzU4Oa+r2hoOBD/Xe7u8FnsIOagzdgWaIbiBUomrE
   B2RmljJwQ/vT3YfV5KxrJBt0OsM9NyX7Pzeoce2ZpvQ3rcMhPsgrEP6zQ
   m52gHVHDtKGXt0yMGbOphlYETpnHTLEyF912Zv/ex6V/H4/dfDLCbm/4+
   TtXr7OkSxL3qwgYDr8LltPItIELq4WgEDgTJDOFrzocRXj72x+r5HpAme
   YjOoxADCZlx6ZX7s9GiQZ4/eqJ7V5F5EhW5FF6B34lSkbKNEyMVJzRfDY
   yH+dmz/Kk+a83QSeR30Dk3nnom5JY6KRH68qLcSUSt3QIsw7n4ComeHJo
   w==;
X-CSE-ConnectionGUID: YuLCn6HPRZuIPbFAL1zZ6A==
X-CSE-MsgGUID: qr+NEYWKSPusRX8d4l6B0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89049318"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="89049318"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:19:39 -0700
X-CSE-ConnectionGUID: W6SVnmIaTeWof6lfnYwRrw==
X-CSE-MsgGUID: 1zvDLDZwTe+Jz/P0S5C9Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255938269"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:19:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 13:19:33 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hansg@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
    "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, 
    Francis De Brabandere <francisdb@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86/amd/pmc: Fix LPS0 and debugfs leaks
 when STB init fails
In-Reply-To: <20260717162023.956346-2-mario.limonciello@amd.com>
Message-ID: <2d61d763-8e4b-ed5c-2040-38e48894ae69@linux.intel.com>
References: <20260717162023.956346-1-mario.limonciello@amd.com> <20260717162023.956346-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Jul 2026, Mario Limonciello wrote:

> amd_pmc_probe() registers the LPS0 s2idle handler with
> acpi_register_lps0_dev() and creates the driver's debugfs directory
> before calling amd_stb_s2d_init(), which is the last step in probe that
> can fail.
> 
> When amd_stb_s2d_init() fails (for example the S2D telemetry region
> cannot be ioremapped on a long-running system, or the SMU rejects the
> S2D setup) the error path only calls pci_dev_put() and returns.  This
> leaves amd_pmc_s2idle_dev_ops on the global lps0_s2idle_devops_head list
> and leaks the debugfs directory, while the devm-managed resources
> backing the handler are torn down.
> 
> Reloading the module then walks the corrupted list in
> acpi_register_lps0_dev() and hits:
> 
>   list_add corruption. next->prev should be prev, but was NULL.
>   kernel BUG at lib/list_debug.c:29!
>    acpi_register_lps0_dev+0x44/0x80
>    amd_pmc_probe+0x224/0x380 [amd_pmc]
>    platform_probe+0x67/0x90
> 
> Even without a reload, the stale registration means the next s2idle
> transition calls into torn-down driver state.
> 
> Unwind the debugfs directory and the LPS0 registration on the
> amd_stb_s2d_init() error path.  acpi_unregister_lps0_dev() is safe to
> call unconditionally here: it is guarded on the same conditions as
> acpi_register_lps0_dev(), which is exactly what amd_pmc_remove() already
> relies on.
> 
> Assisted-by: Claude:opus
> Reported-by: Francis De Brabandere <francisdb@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
> Tested-by: Francis De Brabandere <francisdb@gmail.com>
> Fixes: 83ad6974dd3b ("platform/x86/amd/pmc: Move STB block into amd_pmc_s2d_init()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index d50ea62fa2f3a..630a664bdd2f4 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -919,13 +919,17 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  	amd_pmc_dbgfs_register(dev);
>  	err = amd_stb_s2d_init(dev);
>  	if (err)
> -		goto err_pci_dev_put;
> +		goto err_dbgfs_unregister;
>  
>  	if (IS_ENABLED(CONFIG_AMD_MP2_STB))
>  		amd_mp2_stb_init(dev);
>  	pm_report_max_hw_sleep(U64_MAX);
>  	return 0;
>  
> +err_dbgfs_unregister:
> +	amd_pmc_dbgfs_unregister(dev);
> +	if (IS_ENABLED(CONFIG_SUSPEND))
> +		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>  err_pci_dev_put:
>  	pci_dev_put(rdev);
>  	return err;
> 

No need to change this patch as this looks to be using reverse from the 
order they were init in, but amd_pmc_remove() is using different order
and should IMO changed to match (there probably isn't any good reason 
for the other order).

Sashiko mentions a few low value pre-existing problems that too would be 
nice to address eventually.

-- 
 i.


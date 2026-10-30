Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385557;
	b=SG0jnG3EA8AK1fe9+zIfQ7kerjOd6YLaUmJHCPuLCazpn4nWPUX1UlXmlus9TNQ35SHN
	 mCcGgx11bZNPw8yEK6AubUBtY0dpQfH3soycGonPSGtqRiC2YjejGQF9rxQLXe7KnaNEh
	 //AEP/ffzdQ6HR460YQZxbMLhOepTt/vm5M0XpLgpctijyv4jJqjyw8kA1mAikJ353USH
	 8swd37Xm6kFiKWzJRcy8Cuoi40enbc5VfJ1UiBiTsy0anmc8yjxi7i76M+0n5KHRSPJLF
	 mwHadBaGHdiVLB1rMamVJzEOhTS+Ky2NnLl53FT78gjF+HO+WxDQfuZqepVTYEiLn7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2z4n8t7UyAs2zhyh3rfLcTEvPoKHSDEFmDtIMhUC/uE=;
	b=DnLuZXtLcpuEWpaoqzgZS6uLqmrmIuDvgukEwmaMxldvjKshxG4SVVnMqxBJyXAH/uQJ
	 +oFOsIBpt+QsDAAItFuJw3AXK52fWYL7LExrmt21KSXWlpYBVB4y9bmgpHiDK3MfPWoxD
	 9ufa3fcWWCz0kb/K7OZQcqeGqTn4/9TKJg8CtK1zZVqNJib0b8G2Kuy9NCaq0EigSMEr9
	 O+KxO8GpND3jhCY1X4FheXY5iwl5wcpWl46eYP730qCIYcd4oyXPQALT2/xUaFhv4mdrb
	 OUh6W3eKeaCC8Up1L0TyXuMwbTNz3f8Mii+8aoFviNIYNgQsFSfU3gH5c7HL2HYG9vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MmDOkdg+;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D252606A321;
	Fri, 30 Oct 2026 18:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D252606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MmDOkdg+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793385556; x=1824921556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZXo9VbuOZo50mRPjcb/rvfj7jmkkuUo8q7gJTPgUEBU=;
  b=MmDOkdg+Sej2HYwYOn1hN10BGNuZpvBHG5yGciiKM7lIcpWYO4pxEnlU
   l9RAvEG5jhEZiMnsHJ+v3wd6L4xulfZ3PsGR1GK/dYOPjA2bQ6qY4qwhg
   HCzYoscd0VcekHbSgs81Qvbxp9MfOrPeek/g2Gglsby77pg8bl1X63xj0
   hvSGGHypjuNfyjWqVL8K3LxhNXGk8LwGwsyem4/TvmZ5ROtM+sIwtcx01
   cowzMICqtCU4f+5WzGLZRW/A6i5Fcm5nINFRAx9l65m6lCYbIkP8slHz4
   lVqFBg1D1xbQnD3lX9/aXhMCY4yf0P6TtjPMbAUF3HX7fNFM2nwwxNdnC
   g==;
X-CSE-ConnectionGUID: fehLtUT8TyehxnFh806cOg==
X-CSE-MsgGUID: FQty7XgXT8m9ERc9Wt74LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2181906"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2181906"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 11:39:04 -0700
X-CSE-ConnectionGUID: uYjgqvqKSCCDcv98GxIy5w==
X-CSE-MsgGUID: 2Ze/VbxbTR24Fehux7Siag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5504989"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.85]) ([10.125.109.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 11:39:02 -0700
Message-ID: <2f2fac75-eb91-408a-a436-f7e2494f7e3c@intel.com>
Date: Fri, 30 Oct 2026 11:39:01 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/core: Create einj_types when EINJ becomes
 available
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
 <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Jonathan Cameron
 <jic23@kernel.org>, Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Cheatham <benjamin.cheatham@amd.com>, stable@vger.kernel.org
References: <20261029065629.333949-1-yangyongxin@kylinos.cn>
 <20261030032050.787682-1-yangyongxin@kylinos.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261030032050.787682-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/26 8:20 PM, Yongxin Yang wrote:
> From: Yang Yongxin <yangyongxin@kylinos.cn>
> 
> The einj_types file under the CXL debugfs directory is never created when
> cxl_core is built in.
> 
> cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
> from einj_init() at device_initcall level. With cxl_core built in, the
> einj_cxl_is_initialized() check in cxl_core_init() therefore always sees
> false and the debugfs_create_file("einj_types") call below it is never
> reached, so users have no way to discover which CXL error types the
> platform supports from debugfs. When cxl_core is a module, module
> dependencies make sure it is loaded after EINJ is up, and the file is
> created.
> 
> Create the file from every point that can tell EINJ is up. cxl_core_init()
> covers cxl_core being a module loaded after EINJ has been initialized. The
> cxl_acpi_probe() hook covers cxl_core being built in while cxl_acpi is a
> module, and is the only hook that can work on RCH/RCD hierarchies, where
> the single dport is added by the ACPI probe itself, too early to help. The
> dport probe path covers the built-in virtual host case, where the dport
> added from the memdev probe is the only hook reached after einj_init().
> 
> The dport probe path can run concurrently for different parent ports, each
> holding only its own device lock, so serialize the check and the create to
> avoid a duplicate debugfs_create_file() attempt that would only fail with
> -EEXIST. Reset the cached dentry in cxl_core_exit() so that reloading
> cxl_core starts from a clean state.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>

Couple more things. Can you send a new email per revision instead of reply-to the previous post? Otherwise it's a mess of email threads.

Also, please update email addresses in your submission. Many of them have changed and are now bouncing. Check the latest MAINTAINERS please.

DJ

> ---
> Changes in v4:
> - Scope the problem statement to the built-in case: the file is only never
>   created when cxl_core is built in, the module dependencies take care of the
>   ordering otherwise.
> - Replace the "no dport is ever added" rationale with the RCH/RCD case, in
>   the changelog and in the cxl_acpi_probe() comment: a system without any
>   dport cannot do error injection at all, so the file is useless there. On
>   RCH/RCD hierarchies the only dport comes from the ACPI probe, so this hook
>   is the one that matters.
> 
>  drivers/cxl/acpi.c      |  9 +++++++++
>  drivers/cxl/core/port.c | 41 +++++++++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..ca7741203740 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -958,6 +958,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
>  
> +	/*
> +	 * Create einj_types from here as well: with cxl_core built in,
> +	 * cxl_core_init() runs before EINJ is up, so when cxl_acpi is a module
> +	 * loaded afterwards this is the only hook that can create the file,
> +	 * including on RCH/RCD hierarchies, where the single dport is added by
> +	 * this probe itself and cannot help.
> +	 */
> +	cxl_debugfs_einj_add_types();
> +
>  	/* In case PCI is scanned before ACPI re-trigger memdev attach */
>  	cxl_bus_rescan();
>  	return 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..76ac612b514c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -802,6 +802,35 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  
>  DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
>  
> +static struct dentry *cxl_debugfs;
> +static struct dentry *einj_types_dentry;
> +
> +/*
> + * einj_types can only be created once EINJ is up, and no single hook is
> + * reached after that point in every configuration:
> + *
> + *  - cxl_core_init() runs at subsys_initcall level and cxl_acpi_probe() at
> + *    subsys_initcall_sync level, so both create the file when cxl_core and
> + *    cxl_acpi are modules loaded after EINJ has been initialized;
> + *  - when EINJ is built in, einj_init() runs at device_initcall level, so
> + *    both of them are too early and the only hook left is the dport added
> + *    from the memdev probe.
> + *
> + * The dport probe path can run concurrently for different parent ports, each
> + * holding only its own device lock, so the check and the create need to be
> + * serialized to avoid a duplicate debugfs_create_file() attempt.
> + */
> +static DEFINE_MUTEX(einj_types_lock);
> +void cxl_debugfs_einj_add_types(void)
> +{
> +	guard(mutex)(&einj_types_lock);
> +	if (cxl_debugfs && !einj_types_dentry && einj_cxl_is_initialized())
> +		einj_types_dentry = debugfs_create_file("einj_types", 0400,
> +							cxl_debugfs, NULL,
> +							&einj_cxl_available_error_type_fops);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_debugfs_einj_add_types, "cxl_acpi");
> +
>  static int cxl_einj_inject(void *data, u64 type)
>  {
>  	struct cxl_dport *dport = data;
> @@ -822,6 +851,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  	if (!einj_cxl_is_initialized())
>  		return;
>  
> +	cxl_debugfs_einj_add_types();
> +
>  	/*
>  	 * Protocol error injection is only available for CXL 2.0+ root ports
>  	 * and CXL 1.1 downstream ports
> @@ -2501,8 +2532,6 @@ const struct bus_type cxl_bus_type = {
>  };
>  EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
>  
> -static struct dentry *cxl_debugfs;
> -
>  struct dentry *cxl_debugfs_create_dir(const char *dir)
>  {
>  	return debugfs_create_dir(dir, cxl_debugfs);
> @@ -2515,10 +2544,6 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> -	if (einj_cxl_is_initialized())
> -		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> -				    &einj_cxl_available_error_type_fops);
> -
>  	cxl_mbox_init();
>  
>  	rc = cxl_memdev_init();
> @@ -2541,6 +2566,8 @@ static __init int cxl_core_init(void)
>  
>  	cxl_ras_init();
>  
> +	cxl_debugfs_einj_add_types();
> +
>  	return 0;
>  
>  err_region:
> @@ -2560,6 +2587,8 @@ static void cxl_core_exit(void)
>  	destroy_workqueue(cxl_bus_wq);
>  	cxl_memdev_exit();
>  	debugfs_remove_recursive(cxl_debugfs);
> +	cxl_debugfs = NULL;
> +	einj_types_dentry = NULL;
>  }
>  
>  subsys_initcall(cxl_core_init);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..b9245261ee39 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -926,4 +926,6 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  
>  u16 cxl_gpf_get_dvsec(struct device *dev);
>  
> +void cxl_debugfs_einj_add_types(void);
> +
>  #endif /* __CXL_H__ */


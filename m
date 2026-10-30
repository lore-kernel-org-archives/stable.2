Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385208;
	b=zGre7l082SWo9knS/ltK81qJzcqS3OidHNLfG3Xip+TaXO2JLn9Ol/OAtkwTrD/WRFHx
	 bbLbsaD58dXVtFlrs2+KzNgEL8IizXcm9vDSgYUzyskQ1do5/PowGuI9LTA7fyVJJNuFi
	 Wd+LBrZ6EJ+9ePaAcFGgyOqYrQVdItEIrCXPy7AeVl7rIa9I5afLgfVNQGdfuA8J7yZLo
	 TXCpbE9zYikOyCugRWEk7ZYHum5VvcFKAhD7/SN6zgGn/s9j2h+sv2sVnP81tDVbzmyyU
	 0r8LuUcuiAas7zJkxPe24tpihLDHO1A0kUpjLLfI6RX55qh/cUoNiutArpAneSCXpgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ufF6t5hjYWrklI4qHpLBwXavVvTj5i8GVnRkPzAqVRI=;
	b=eLI/JMhuNx2fEh4SE9BZD5Vl/BmzjZe/TXMjMSmUmP81CGRSc1u9iqo3TccHqYe05oHU
	 gZCIVIh3OXTAaxsWVNWFxF8lfT7UgElAyu9dEBwItzSVaJzz0SU+t7dZtphg4eboJ2Hjc
	 dv6ASB7JIDOci895fWRinMOo8L30Q+9VkDuVtq5idG2rowcrctDupXDoLpU+MFyvTH83B
	 OXtJ8+F6iTPtmJ+t7a/Tl/RKtlsqBKF87wqEc8w6YZl47OhOJgz+SscBC2Fjma9OpOqcR
	 IUdqNLq4fITsmeQQMWuCZ5zr4q10RDdGnZ5kI13evz590YcNXCue4QDTrWS2UrIfvew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mK9KG3UC;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D18606A31A;
	Fri, 30 Oct 2026 18:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mK9KG3UC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793385207; x=1824921207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lQiboPHxn6YNj6yeBHmrszgvChgzTtz1jM8g9AE0HhQ=;
  b=mK9KG3UCrM4cZniCkrvYu0rLf2QuZf5O42RHeuFoKenf8WwzfWD8IE/M
   Ymjpjf/KjY/rVHFjytA8idJLRa1BfLBsBE2Zz+K/aLJy96WxoLyFOB7MG
   6HcnDksr4e6g+86PnEPxNGFaCFc4mx5x2GtwSN0CiqbLKv2Lyk166n1g3
   xG0RK+jeTmhcCreYpqY4McAqs0cjXheDUUStYmoPPAVWClgCwxLQtV93a
   wNRZH/eSawIP+v9hWsf1ZvLrmbcvtYYnufL4nkrCumEioPUPfIlx7jZ4s
   3/WH8BuX8De+YJA1OnqrFIkzJOI6whwBcBugE5TbTEWiGOeAalMEvN3d0
   g==;
X-CSE-ConnectionGUID: mz+d8RQER2eVkesBm8MBew==
X-CSE-MsgGUID: mpEQv94wS9CM1MREvl+5Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2181447"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2181447"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 11:33:26 -0700
X-CSE-ConnectionGUID: Dxioxu46SEO4QOvYWIon1Q==
X-CSE-MsgGUID: cV6q6+JyRzS1BGEd7puL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5504451"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.85]) ([10.125.109.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 11:33:25 -0700
Message-ID: <89885d4d-02b0-4c4c-8568-fc3d41623d51@intel.com>
Date: Fri, 30 Oct 2026 11:33:24 -0700
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
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

That is a REALLY wordy commit log. Maybe AI generated? Can you please condense and simplify it?

> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
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

Maybe drop the cxl_acpi_probe() hook? Host bridge dports, RCH included, already go through __devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() -> cxl_debugfs_einj_add_types() inside the same probe, so the hook runs at the same time and adds nothing. That also removes the export.

Also, the RCH all built-in case still never gets einj_types since the only RCH dport is added at subsys_initcall_sync. Should the commit log say so?

I do wonder if it's simpler to always create einj_types in cxl_core_init() and have einj_cxl_available_error_type_show() return -ENODEV when EINJ isn't initialized. That covers every config without the lock and the extra hooks. Any thoughts Ben?

The NULL resets in cxl_core_exit() aren't needed. Module reload gets fresh .bss.

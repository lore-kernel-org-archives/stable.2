Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857B2367DF;
	Tue,  9 Jun 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965328; cv=none; b=s1M4fOMXX87sSCowhkbPs1PkL7VoSDCNArJi5rBOiIvH3xv8vnHqLTqCtrd3TEQD5kFZ9B2afCpt3bXCIqeDrZgll29jHIx8xECV428HBqea8MkYm+TXmf9fwVne0ij4phBDUq87RprgYV5zQjh1xdyG9GJALqGwrrsa6be9CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965328; c=relaxed/simple;
	bh=QKHoO8e5c8FR8swGpDYxOOaMBa8G81Ok0vtRgrBmI0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+u3MNjaf7EW9Eh2bCOrOkNG/Q6E/ejKgWIjm8jtnYmQnx8Rgk4GwQIY625tkWE76CLS4XviEW6YssFSm9fenPAVE2gu12Mb4LRWsXkh12ZDMM9+Jp71ETpkzzSGN56YWYL/dsG0CBrJ9gEUCfqA0DZs/mEKZMgLMlCSCKEEG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEqGFoxM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEqGFoxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780965326; x=1812501326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QKHoO8e5c8FR8swGpDYxOOaMBa8G81Ok0vtRgrBmI0U=;
  b=BEqGFoxMFbfhoXL6/mO9C/FmDerF1y6GswyqnCxruMKPN7Sb/yhxTby/
   7AhJ8CXf5JzE5272tGXtiPUT1Pas3BWSDpuhM9Azh0WHm5huG30f+ueGN
   K6w9e/fZ55RHeixsG/ktY1K6M20A3QFQDXmomZtRBMPGZaw9y/PC9mD0G
   TBXhuPoS4kLdzLpfVVtKTGqG1WtfcFWXdpSPocE/Ehn8kDufnYzjUPR/7
   llK71KR+whN/xNj7WcLaQeYm7hBwnS0htb4Dgixn8qiPS4+UFS0esgASC
   yV+0uDzdqu0go+nl6XObvjimsvPWLp1eiJ3n6VLfQjmBvhGWk/NHC5Ngf
   g==;
X-CSE-ConnectionGUID: V33pPwjHQnadYY9K2YeRIg==
X-CSE-MsgGUID: 1mX7QechSOm5mBwGzH6YPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81570002"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81570002"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 17:35:25 -0700
X-CSE-ConnectionGUID: /uvkMsD6Th+Joy8g49ZUUA==
X-CSE-MsgGUID: y45UGOB1Rn2ECTSM9PxAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="250625698"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.162]) ([10.125.109.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 17:35:24 -0700
Message-ID: <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
Date: Mon, 8 Jun 2026 17:35:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Fix missing port lock in cxl_dport_remove()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, ming.li@zohomail.com, rrichter@amd.com,
 Benjamin.Cheatham@amd.com
Cc: Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 PradeepVineshReddy.Kodamati@amd.com
References: <20260608223533.583278-1-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260608223533.583278-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/8/26 3:35 PM, Terry Bowman wrote:
> xa_erase() in cxl_dport_remove() runs without the port device lock,
> creating a race with any caller that does xa_load() on port->dports
> and then dereferences the returned dport pointer. A concurrent
> cxl_dport_remove() can erase and free the dport between the xa_load()
> and the caller acquiring the port lock, causing a use-after-free.
> 
> For non-root ports the port lock is already held by the caller on two
> paths:
> 
> 1. Driver unbind: devres_release_all() is called from
>    __device_release_driver() which holds port->dev.mutex.
> 
> 2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
>    before calling del_dports() -> del_dport() -> devres_release_group(),
>    which synchronously runs cxl_dport_remove().
> 
> Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
> the port is a root port and the lock is therefore not already held.
> This matches the pattern used in __devm_cxl_add_dport() for the same
> reason.
> 
> The write-side fix to cxl_dport_remove() is necessary but not
> sufficient. Callers that obtain a dport pointer via cxl_mem_find_port()
> use a lockless xa_load() and must not dereference that pointer until a
> lock that excludes free_dport()/kfree() is held.
> 
> For root ports, dport_to_host() returns uport_dev, so all three devres
> actions (free_dport, cxl_dport_remove, cxl_dport_unlink) are registered
> on uport_dev. __device_release_driver() holds uport_dev->mutex for the
> full teardown sequence including kfree(dport). Holding uport_dev->mutex
> on the read side therefore excludes concurrent dport freeing.
> 
> Fix rcd_pcie_cap_emit() by passing NULL to cxl_mem_find_port() to avoid
> capturing a lockless dport pointer, then re-fetching dport inside the
> uport_dev guard via cxl_find_dport_by_dev(). The previous guard on
> root->dev was wrong: cxl_dport_remove() releases root->dev before
> free_dport() runs, so root->dev does not protect against concurrent
> kfree(dport).
> 
> Fix cxl_mem_probe() similarly: pass NULL to cxl_mem_find_port(), then
> re-fetch dport inside scoped_guard(device, &parent_port->dev) for the
> VH path, and re-fetch again inside scoped_guard(device, uport_dev) for
> the RCH path. This closes both the TOCTOU window between the lockless
> xa_load() and the guard acquisition, and the window between the two
> sequential guards in the RCH path where a concurrent surprise removal
> could free dport before devm_cxl_add_endpoint() dereferences it.
> 
> Reported-by: Sashiko
> Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
> Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/port.c | 10 +++++++
>  drivers/cxl/mem.c       | 65 +++++++++++++++++++++++++++++++----------
>  drivers/cxl/pci.c       | 17 +++++++----
>  3 files changed, 72 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..0b8f144596e8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1092,8 +1092,18 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	/*
> +	 * For non-root ports the port lock is already held by the caller
> +	 * via devres_release_all() during driver unbind, which holds
> +	 * port->dev.mutex throughout.  Acquiring it again unconditionally
> +	 * would deadlock.  Use cond_cxl_root_lock() which only acquires
> +	 * when the port is a root port and the lock is therefore not yet
> +	 * held.
> +	 */
> +	cond_cxl_root_lock(port);
>  	port->nr_dports--;
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	cond_cxl_root_unlock(port);
>  	put_device(dport->dport_dev);
>  }
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..345b56f215ff 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -70,9 +70,9 @@ static int cxl_mem_probe(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct device *endpoint_parent;
>  	struct cxl_dport *dport;
>  	struct dentry *dentry;
> +	bool rch = false;
>  	int rc;
>  
>  	if (!cxlds->media_ready)
> @@ -107,8 +107,7 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	struct cxl_port *parent_port __free(put_cxl_port) =
> -		cxl_mem_find_port(cxlmd, &dport);
> +	struct cxl_port *parent_port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, NULL);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
>  		return -ENXIO;
> @@ -123,21 +122,57 @@ static int cxl_mem_probe(struct device *dev)
>  		}
>  	}
>  
> -	if (dport->rch)
> -		endpoint_parent = parent_port->uport_dev;
> -	else
> -		endpoint_parent = &parent_port->dev;
> -
> -	scoped_guard(device, endpoint_parent) {
> -		if (!endpoint_parent->driver) {
> -			dev_err(dev, "CXL port topology %s not enabled\n",
> -				dev_name(endpoint_parent));
> +	scoped_guard(device, &parent_port->dev) {
> +		/*
> +		 * Re-fetch dport under the port lock to close the TOCTOU
> +		 * window between cxl_mem_find_port()'s lockless xa_load() and
> +		 * this guard acquisition.  A concurrent surprise removal can
> +		 * free the dport in that window.
> +		 */
> +		dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
> +		if (!dport) {
> +			dev_err(dev, "CXL port topology %s not found\n",
> +				dev_name(&parent_port->dev));
>  			return -ENXIO;
>  		}
> +		rch = dport->rch;
> +
> +		if (!rch) {
> +			if (!parent_port->dev.driver) {
> +				dev_err(dev, "CXL port topology %s not enabled\n",
> +					dev_name(&parent_port->dev));
> +				return -ENXIO;
> +			}
> +			rc = devm_cxl_add_endpoint(&parent_port->dev, cxlmd, dport);
> +			if (rc)
> +				return rc;
> +		}
> +	}
>  
> -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> -		if (rc)
> -			return rc;
> +	if (rch) {
> +		struct device *uport_dev = parent_port->uport_dev;
> +
> +		scoped_guard(device, uport_dev) {
> +			if (!uport_dev->driver) {
> +				dev_err(dev, "CXL port topology %s not enabled\n",
> +					dev_name(uport_dev));
> +				return -ENXIO;
> +			}
> +			/*
> +			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
> +			 * is held for the full devres teardown sequence including
> +			 * free_dport()/kfree(), so this excludes concurrent
> +			 * hotplug removal through the entire dereference.
> +			 */
> +			dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
> +			if (!dport) {
> +				dev_err(dev, "CXL RCH dport not found\n");
> +				return -ENXIO;
> +			}
> +			rc = devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
> +			if (rc)
> +				return rc;
> +		}

Still reviewing the patch, but thoughts on moving the two new big blocks to a helper function?

DJ

>  	}
>  
>  	if (cxlmd->attach) {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..710a62a66429 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -708,10 +708,10 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>  {
>  	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *root_dev;
>  	struct cxl_dport *dport;
> +	struct device *root_dev;
>  	struct cxl_port *root __free(put_cxl_port) =
> -		cxl_mem_find_port(cxlmd, &dport);
> +		cxl_mem_find_port(cxlmd, NULL);
>  
>  	if (!root)
>  		return -ENXIO;
> @@ -720,13 +720,20 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>  	if (!root_dev)
>  		return -ENXIO;
>  
> -	if (!dport->regs.rcd_pcie_cap)
> -		return -ENXIO;
> -
>  	guard(device)(root_dev);
>  	if (!root_dev->driver)
>  		return -ENXIO;
>  
> +	/*
> +	 * Fetch dport under uport_dev lock to protect against concurrent
> +	 * hotplug removal. uport_dev->mutex is held for the entire devres
> +	 * teardown sequence including free_dport(), so holding it here
> +	 * excludes concurrent kfree(dport).
> +	 */
> +	dport = cxl_find_dport_by_dev(root, cxlmd->dev.parent->parent);
> +	if (!dport || !dport->regs.rcd_pcie_cap)
> +		return -ENXIO;
> +
>  	switch (width) {
>  	case 2:
>  		return sysfs_emit(buf, "%#x\n",


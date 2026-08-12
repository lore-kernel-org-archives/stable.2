Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856F33B97D;
	Wed, 12 Aug 2026 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527465; cv=none; b=sL3VSnhds5ydStV9x4WakhDDMi4KL9+GG8icqWLRBmWAOjOkzw8d2xnD4CEVADKbtJJi7X3nYkSlyE8iBihQIPfvC/AsFQSLqg6jX552mNwzFBqDTV99U24Sa6VEc/CZ1MrE7KIeZ2ISEdXdKfPV4TmyXWmi+lHPO/Wi1XLRfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527465; c=relaxed/simple;
	bh=Tvb7zsQQLcBCDwFGCjb3RT1c663KgCpuM7+RojAuo2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd2KYfLz37Av/i7MduZo12NVIu2bKtzqlnIil9V54oKR/YDMpFF4YedE5E6ZpLtyxoyWB+ATGIs92J9EuZyq0g6GW1pMypgfQGxNG0iggDD8Ckk8dPmZ7RlDYCHAg2XLAItBXFvx85iM+KeL+4/Ky5IFNa0TQVXyIOCrS6ERnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVstlXkz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVstlXkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786527463; x=1818063463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tvb7zsQQLcBCDwFGCjb3RT1c663KgCpuM7+RojAuo2s=;
  b=XVstlXkzJWUKPOITsS3wcSafcnBANhMDs11F2EWj6h8QCVZylldk67Aw
   Dups2ftI5ZPgNgu0zLzd3wKRufcaZZ4P77Omn1xm/evgkYIZ/6bGNykku
   0n1GgYG8aWZx5Z1lp167QMXSnq+WFulngOkuNkJA11tz3wognbNE76uDU
   qZNDBqvhopgtLFwTXH2FHKSULcqIUC/TlpfaybQQGXCGt97aCafemzHpf
   NMSVT/3ImPYcnYH79pbOokKDn1x0WTBvRdS1ow2mBJrXzzanND7vwkWqT
   6NqcJQzUpiETXw28JJbq5wxanxhF+JSpZBhBX+0FQWfsly4CsXgtiX4Rs
   w==;
X-CSE-ConnectionGUID: xwZ6RY8DTAGzTa7SF7LjfQ==
X-CSE-MsgGUID: ja/dJ6ydQOmsVUWQK8glZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="74612821"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="74612821"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:37:42 -0700
X-CSE-ConnectionGUID: NwuUZsgSQ+mkuYAzRqRiyg==
X-CSE-MsgGUID: +7/zRKDsQdqeVy4Kcm/KLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="262285725"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 12 Aug 2026 02:37:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 1638799; Wed, 12 Aug 2026 11:37:39 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:37:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: gregkh@linuxfoundation.org, pooja.katiyar@intel.com, johan@kernel.org,
	pmenzel@molgen.mpg.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Add ACPI_COMPANION() NULL check in
 ucsi_acpi_probe
Message-ID: <anw-41p6cVPQyrDP@black.igk.intel.com>
References: <20260811095827.1001654-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811095827.1001654-1-luoxueqin@kylinos.cn>

On Tue, Aug 11, 2026 at 05:58:27PM +0800, Xueqin Luo wrote:
> Add NULL check for ACPI_COMPANION() in ucsi_acpi_probe() to prevent
> NULL pointer dereference when driver_override matches a device without
> ACPI companion.
> 
> Since every platform driver can be forced to match a device that doesn't
> match its list of device IDs because of device_match_driver_override(),
> the ACPI_COMPANION() may return NULL, leading to a NULL pointer
> dereference at adev->dep_unmet.
> 
> Test steps:
> 
>   $ sudo modprobe ucsi_acpi
>   $ echo ucsi_acpi | sudo tee /sys/bus/platform/devices/alarmtimer.0.auto/driver_override
>   $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/alarmtimer/unbind
>   $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/ucsi_acpi/bind
> 
> which triggered the following crash:
> 
>   [ 6599.180948] calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 24208
>   [ 6599.181198] initcall ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] returned 0 after 207 usecs
>   [ 6729.051074] BUG: kernel NULL pointer dereference, address: 00000000000005f4
>   [ 6729.051102] #PF: supervisor read access in kernel mode
>   [ 6729.051113] #PF: error_code(0x0000) - not-present page
>   [ 6729.051122] PGD 0 P4D 0
>   [ 6729.051136] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   ....
>   [ 6729.051300] PKRU: 55555554
>   [ 6729.051306] Call Trace:
>   [ 6729.051314]  <TASK>
>   [ 6729.051327]  platform_probe+0x41/0xa0
>   [ 6729.051348]  really_probe+0x1a9/0x410
>   [ 6729.051364]  __driver_probe_device+0xc9/0x170
>   [ 6729.051377]  device_driver_attach+0x46/0xb0
>   [ 6729.051390]  bind_store+0x77/0xd0

I don't think kernel can protect the user from everything. I would
rather keep the NULL pointer dereference than silently fail in this
kind of cases.

Note that you can use the driver_override like that also with a device
(not UCSI) that does have the ACPI device node. In that case the probe
would just continue pass the condition you are introducing below.

Thanks,

> Fixes: 1f3546ff3f0a ("usb: typec: ucsi: acpi: Check the _DEP dependencies")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 18286d3e9cc5..b4a783217dc6 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -188,7 +188,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  
>  static int ucsi_acpi_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *adev;
>  	const struct ucsi_operations *ops = &ucsi_acpi_ops;
>  	const struct dmi_system_id *id;
>  	struct ucsi_acpi *ua;
> @@ -196,6 +196,10 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  	acpi_status status;
>  	int ret;
>  
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
>  	if (adev->dep_unmet)
>  		return -EPROBE_DEFER;
>  
> -- 
> 2.43.0

-- 
heikki

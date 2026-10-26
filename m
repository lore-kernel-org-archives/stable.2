Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014818;
	b=t10tGmdaFnqizjmk9qVjdRMkr1z0/mKKEoae70/UWe3o2dDnwUUMXCWvXzfsdlu6a3YT
	 JXFItogHrlIBh9G6XUtIe1xwIHJQ3iqK8ZurcSTPEOTxdZBfcQ4AhcebnX1DP01XNfVu8
	 SMeSEplt1ZhzOzBPu+g9WwL5x+hLLyNihRQ1GhnPqhnf02V2UiHoqCFqAZNVnbftBw0qH
	 piYzS6aqLCRegrs1X3WZ+B4PxmkWyVgQbXjKamn9HwY8KZJtyHT2BZnX5WzAKU4yKYhy0
	 8xjXOxeOxtCXi4B9+5RGEtgVPYHiSCuI1ZOCJ56Df/1dfJLFRz51Khrlau0rxiW+YcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014818;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yxPgJj5K6wdtvZ3s/cYaHrSQ/IJo+WJ9LqzDhRY/Pmw=;
	b=J/sae4JyJk5gUF6G0kIuteaj063xGK+jCqZ3hHnSeXXqjhjXpWm+WiY1qm2L/PmwJ3eY
	 z78JYFWRzOCc7HlXjzkqj1TprirCEQFV0AYnes15zX6eaH/COPQYWo40VMIzoUsg43nxI
	 hWwwrQMLzCCzjSAO76Hpu0WYDf2pXE6GTImvmXLhlUgxgTbQ4HG0XXnEPGX72x5AwKwSZ
	 jWUdIT5eP51ykbsmFLGZeBvfYgVs03eyOtFdrtlf59ncv2WCASzus6XpCDwPxYF3ZgZRz
	 uQ7G/1oSIKSK/gpkhMG6ecYlo6ih8itk+1yKx1tWe+SuZD88sNmAlCTKjpTRlZzWqsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ijaaStTW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50021606A31A;
	Mon, 26 Oct 2026 11:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50021606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ijaaStTW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793014817; x=1824550817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtCSgBz6BjUkGziz506cC24Aq11ze1Q6fumnwvlLF7U=;
  b=ijaaStTW+4/2SsypYmRfgUd+AIv/R6H6AbWcceJCxU7XwWhf/KI2jtHR
   Z2ss0KE7aebNGmzl+z/4XRd8tAuHn95CRq+QNjXscCRLJU1kbJdrCLj/x
   cK3h2eFKdh499WPK+NLuMIe7Cof0YQs2fG3E9uMAwT67Rfnz5YKvJZSvo
   7htzkURXDdjlCu9i2KjRck51Ya9Yy2vE4ZXNUodpBE/bLznrtEUalt5a3
   egKof9Rsyyn2XFKsubv+8486pZNhk0yHk9qwNveeZCdVSp3nPHkxJZnq4
   QCwzf5QM6QNipQ8fzrMrEBkbF4vyQpmgxYbOs6pLO1ZmaafUOgBUBFo54
   Q==;
X-CSE-ConnectionGUID: 6w7DAgPcQ/K/AAgYu+shrQ==
X-CSE-MsgGUID: 8D55mBm3Tb2EzBfTtvVj+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1769474"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1769474"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:40:16 -0700
X-CSE-ConnectionGUID: 3fhEqgJSSZaeaPjt+YrBcQ==
X-CSE-MsgGUID: 0MQO2kbPTs6DCXlf74SOYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6065364"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 04:40:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 043E499; Mon, 26 Oct 2026 12:40:14 +0100 (CET)
Date: Mon, 26 Oct 2026 12:40:13 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bertrand Jacquin <bertrand@jacquin.bzh>
Cc: gregkh@linuxfoundation.org, venkat.jayaraman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power
 level debugfs
Message-ID: <at88HU4YlGSAJGoE@black.igk.intel.com>
References: <20261010120357.4937-1-bertrand@jacquin.bzh>
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
In-Reply-To: <20261010120357.4937-1-bertrand@jacquin.bzh>

On Sat, Oct 10, 2026 at 01:03:57PM +0100, Bertrand Jacquin wrote:
> ucsi_register() creates the debugfs entries right away, but
> ucsi->connector is only set by ucsi_init(), which runs later from
> ucsi->work and only publishes the connectors once the PPM has been
> reset and all ports are registered. Until then, or for good if init
> fails, ucsi->connector is NULL, yet the peak_current, avg_current and
> vbus_voltage show callbacks dereference it unconditionally.
> 
> On an Intel NUC13ANKi5 whose PPM never answers when CONFIG_ACPI_EC=n,
> reading those files after the failed init oopses:
> 
>   ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
>   BUG: kernel NULL pointer dereference, address: 000000000000045c
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:ucsi_debugfs_register+0x291/0x420 [typec_ucsi]
>   Call Trace:
>    <TASK>
>    seq_read_iter+0x1e4/0x4c0
>    seq_read+0x12b/0x160
>    full_proxy_read+0x9a/0x1f0
>    vfs_read+0xba/0x320
>    ksys_read+0x74/0x110
>    do_syscall_64+0x79/0x240
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> Return -ENODEV from those callbacks while no connector is available.
> 
> Fixes: c851b71fd6cd ("usb: typec: ucsi: Add support for READ_POWER_LEVEL command")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bertrand Jacquin <bertrand@jacquin.bzh>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/debugfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
> index 77a0dd75edd3..911a151ac16a 100644
> --- a/drivers/usb/typec/ucsi/debugfs.c
> +++ b/drivers/usb/typec/ucsi/debugfs.c
> @@ -92,6 +92,9 @@ static int ucsi_peak_curr_show(struct seq_file *m, void *v)
>  {
>  	struct ucsi *ucsi = m->private;
>  
> +	if (!ucsi->connector)
> +		return -ENODEV;
> +
>  	seq_printf(m, "%u mA\n", ucsi->connector->peak_current);
>  	return 0;
>  }
> @@ -101,6 +104,9 @@ static int ucsi_avg_curr_show(struct seq_file *m, void *v)
>  {
>  	struct ucsi *ucsi = m->private;
>  
> +	if (!ucsi->connector)
> +		return -ENODEV;
> +
>  	seq_printf(m, "%u mA\n", ucsi->connector->avg_current);
>  	return 0;
>  }
> @@ -110,6 +116,9 @@ static int ucsi_vbus_volt_show(struct seq_file *m, void *v)
>  {
>  	struct ucsi *ucsi = m->private;
>  
> +	if (!ucsi->connector)
> +		return -ENODEV;
> +
>  	seq_printf(m, "%u mV\n", ucsi->connector->vbus_voltage);
>  	return 0;
>  }

-- 
heikki

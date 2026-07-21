Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65353AFB11;
	Tue, 21 Jul 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622476; cv=none; b=ddviHfQkbf7AvhyJuvI3eFW9vJHoJJrTF2+695i9J6fV1nUnkzQLepxt9/qRyYJG1otoRoao6XfSMT1EGOKyEoV6v9kl9EZ6BwZPWTU3QSz5a2LUR5VCfnAoU9iao7t+AMONrt9owJhXV++1t1AB6uC/m5IVM04JAyuKENShaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622476; c=relaxed/simple;
	bh=I/vMGRd75TJpfjjxiwarY6Z2eil3P+UTMdj4rv7moGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaBgVaRybMR2BihkzqiEtTJIZCB6kqemjs216boCeHhHYJqRp/IVaJ0rYA3f9ODKh4YkOKZbk4DDxkZ2i2deQjjA47+eNXfg6exNaZ6XRUK4RwmJV04QRvRhaYadqiyjLsfmdiWb9FxgdYLsG/gO+OWAHtvQC7v5Y0hCGVZ/pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmzeq2ig; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmzeq2ig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784622474; x=1816158474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/vMGRd75TJpfjjxiwarY6Z2eil3P+UTMdj4rv7moGw=;
  b=nmzeq2igK9YZT+C4MPEtcXoaYtM8g7yKPnrBLOXRka1CxfanEsai/7B3
   1GeoaHj1pAk+1Oc4M9MAkDuR2kztn+l4EF+FKIGtjuLooT+MCsWjB+IpV
   inhw12/fB5d1YLtZVc7lPBWXW2K4+c8na1NgL6dvKZfLpdTxQYoXCVr8h
   3Ep19jO8UEb/NfwVDBhgG01l6zmDmMtZ3WcQgJxu9B9mCOQrJSGize/2g
   84DkQlAKJ474oKEAR2TgDfeIWsOXhmnG11nDe8EkbaQWTo4CfmFJbTtqV
   0im2mCPrsSJvWmPT/0Xiv68kxam9U+Qt6nL66hGbdGFuySgX/XHcK5ezb
   w==;
X-CSE-ConnectionGUID: ns3N0sIvTfCTmleekP8zIg==
X-CSE-MsgGUID: cIT9+0POSwyOqNRisgKMsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85070348"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85070348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:27:53 -0700
X-CSE-ConnectionGUID: RPy7Oo6zSiOTqzhitVTA4Q==
X-CSE-MsgGUID: Sk+2eojAT5KiA3c0gUw4LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="280967124"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 01:27:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 43EFF95; Tue, 21 Jul 2026 10:27:50 +0200 (CEST)
Date: Tue, 21 Jul 2026 11:27:48 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Fix use-after-free of ucsi on
 remove
Message-ID: <al8thH8aWmMOUuAZ@kuha>
References: <20260718021142.3146566-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718021142.3146566-1-fanwu01@zju.edu.cn>

On Sat, Jul 18, 2026 at 02:11:42AM +0000, Fan Wu wrote:
> The ACPI notify handler ucsi_acpi_notify() calls
> ua->ucsi->ops->read_cci() and ucsi_notify_common(), both of which
> dereference ua->ucsi with no NULL guard.  In ucsi_acpi_remove(),
> ucsi_destroy() frees ua->ucsi (kfree) before
> acpi_remove_notify_handler() is called, so a notify dispatch already
> in flight on another CPU may access the freed object after
> ucsi_destroy().
> 
>   CPU 0 (remove)                    | CPU 1 (ACPI notify wq)
>     ucsi_destroy(ua->ucsi)          |   ucsi_acpi_notify(ua)
>       kfree(ucsi) // FREE           |     ua->ucsi->ops->read_cci(...) // USE
> 
> Move acpi_remove_notify_handler() before ucsi_destroy() in the remove
> path.  It is kept after ucsi_unregister(): ucsi_unregister() cancels
> connector work whose handler issues GET_CONNECTOR_STATUS through
> ucsi_send_command_common(), which waits for a completion that is
> signalled from the notify path, so the handler must stay registered
> until that work has been cancelled.
> 
> acpi_remove_notify_handler() drains in-flight notify dispatches before
> returning: it calls acpi_os_wait_events_complete(), which flushes
> kacpi_notify_wq. Because ACPI device-notify dispatch is deferred to that
> same workqueue (acpi_os_execute(OSL_NOTIFY_HANDLER, ...)), the flush
> guarantees any queued or running ucsi_acpi_notify() has returned before
> the function returns, so ucsi_destroy() frees an object no handler can
> reach. This mirrors commit 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix
> use-after-free of ucsi on remove"), which moved free_irq() before
> ucsi_destroy() with the same ordering rationale.
> 
> The probe error paths already order acpi_remove_notify_handler() (or
> omit it, when install failed) before ucsi_destroy(), and are unchanged.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 60b12961e..1d56eadc9 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -257,10 +257,10 @@ static void ucsi_acpi_remove(struct platform_device *pdev)
>  	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
>  
>  	ucsi_unregister(ua->ucsi);
> -	ucsi_destroy(ua->ucsi);
>  
>  	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
>  				   ucsi_acpi_notify);
> +	ucsi_destroy(ua->ucsi);
>  }

I don't think this is enough. You now create a window where the ucsi
is unregistered, but you can still call ucsi_notify_common(),
ucsi_connector_change(), etc. So you'll end up with even more problems.

If I understood correctly the long explanation (I'm guessing generated
by gpt-5.6), the problem is that ucsi_unregister() disables the
notification, but it does not flush them. My proposal is that you fix
that by setting the ua->ucsi to NULL after calling ucsi_unregister()
and then always check it in ucsi_acpi_notify(). You probable also need
a lock for that.

thanks,

-- 
heikki

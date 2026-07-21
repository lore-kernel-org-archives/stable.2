Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4444611C7
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627640; cv=none; b=LS8oa2SLowP6n8sI6KwNjP9embB3YoL8LqJteVX9HuuM2eVCDKtZLh5x18WXkTz5PFe24MU3bHRo4E8po+QVBP3Si1c8i0kkoiOnTjx8MIRZFdmQ34jKWOAxAgwCKNZgKNLIWekyKLjJDzRj7PT53JbGSBwlNY/pvTwaWgDZFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627640; c=relaxed/simple;
	bh=p8ebJ+s6tUBSFA6OOoUjonfq60HAi6dMVKTcva4/jyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G63BD7iJihxijvVWhIwUaxHVI9lDadMEqMLWU6YZzFIdt837V/9BwBpdRx0GdOSWg7q0mVBE/OTnTpbnLMD25OLAGxWbwVpe8KM7LQgrTRXA4uBq7K7/hsZQ8PBroEmxkv2UxXdCTnVywYbstSQp/WHFSdumLut12UkR4BHVZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Oqmy+knm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAr9Ci1y; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Oqmy+knm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAr9Ci1y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4453DEC010D;
	Tue, 21 Jul 2026 05:53:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 05:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784627637; x=1784714037; bh=UVnlPlEpD1
	hrHpNqPmceeedSv9aEp8d7bNRBrUu4pSg=; b=Oqmy+knmfQNQOCrxSLr7EQwm5b
	4ZDXPNt6prGGDGV8jJfuMDkHI6JWc6DHDAjAPAYxVTTIvMTSiCZ24A99DHzudut5
	wBTxMUq93MJ7eZ/E+UdKz3ZUeqaB+qkFHqwnIjGXEcntgSSq5ke+ZWe6qJKQJYJF
	64UZYVVTFBelO75heZ3011nOecG7gD6CPjsFS2PTDiMQqB25uyDlUDeeDrlsi7b+
	uTeiGANvMsxx0JopW7SIrV+ZeVCk6o3+leW/VWOzTlU8zJMiJrIj8mfzNAWHWRdz
	vqQK1RVlTIf0upR5/By6eahKsoE/ICIDfE59BxF6HzdUk0SQJefE17uAGd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784627637; x=1784714037; bh=UVnlPlEpD1hrHpNqPmceeedSv9aEp8d7bNR
	BrUu4pSg=; b=DAr9Ci1yLD3vXeMIhcFaKj3sZop4ogwEiRimNkYjrnjng8uAZT3
	soZ+fxpEcdEJATNvIIujZn8OHRuGijGnQE8YPaWaBrdtsMV3xI4Xs4pyTLh3S958
	GmT4e5iZY5c6PRaXsGEpyoAXF6MQFb1YlHFKV+OxDIAv/cWep0tgjNujEbex0YoU
	gJeRG5qsvQaxz5VsJrTIuvXAi14t9ZbVaBpOdaeix6vMGr4eE5FfG8LF8AcFx1sy
	+iRCMjbpM0NgEwIHXTSP5ef8NOOqwksPzkXY4aUKqVdi8xJQGpSDdSjsuAOXgBKW
	FlEa8mkl8leA5K/+jCx6cz0c26OUfPrEzng==
X-ME-Sender: <xms:tUFfar38d4gZaVYw11hU2BKEyjB1RZWvMNYDKUzPtTOcJ3-NLa0csQ>
    <xme:tUFfakGITUHF-sstqZ0egNt3ql6NP5IcV_T1mz2Rhi4cd9lRkVWlm0PGbueAgp8xj
    Qt198B9S0SccfKuiLw2-xmsUjRHcm1uWPbc5Wwq4t3mMwZt>
X-ME-Received: <xmr:tUFfaij4l5gNGzYyDwN-ArCdHpkxO7YDxnjgIlwx5LP1QaC9OFSekTdNYCu7jUKzgdjDF4omen_8FzcR81wk6ZloKQ>
X-ME-Proxy-Cause: dmFkZTEAb5E4mX+esymkIgJlXodZ2YWbVVyPvKRRFlxMiPkfNjyzLX00/F6LLBscwCiVOn
    /2rk0/vEt1TUGotawL33usNKzXHviGXgo4vIawfs9vZUkP7CddgW30xXJ8Gz2bKh8ks48a
    Ih/Hs6PcooGDfQHZXFeHLUoPovMfWpOkNRUH+W5p0AwSQazJiIAnkZwsEsBpUP2ahUhMm+
    2oC58wi9V+fc6hmEmPkf6GoxtX3DQa5TBVca/rSPzspKo3L3J33l3QOXXIpx7ziAs3VFNH
    +C+AxptmJurAfPRpKBFsIhpr/tXAX/VCOVe7HA3PujZTu1ykuFMjHyeeDN3m2B35KiF6Is
    DJMscim8H3FEP/1sul7qz9urvHOS5DtfDXYqs/jizl9YGoXG0bcBcGXdm1zjM7rFaOwwRn
    pVWRH0aFQP1JY6UkJvC8g4TiTxVqpd89pWVwSCxyCB3TMYUZf4RiU0C43SDIPH+Cs4zm2H
    U2JtnoLSqMlOS+gzMlRzfPmN/F3HMvft8Y4tgiq+GE1ply9Ktdfxwz8Rp/YOIerU5rylS4
    tGXXW2f4D6YWOISF3RIWcr00XLbGp7AcbnzJBthQJ9uM49AUi/hVksWLQMAibs9u80og96
    Zor6ilRr6sy/mRFNLCz3mBnkFAr9VG6hkGGEmEgkywo7ZpWsnxL2jXjZPKyg
X-ME-Proxy: <xmx:tUFfavCWQNcKC1eNjabXoM3RLwrl4fBMJ6wsWFavjHrpOhwTqbDonA>
    <xmx:tUFfasQ0H3ZeHtXuaYi_YkF-Ly8jJjAO29ZrryxNKTmFh33KPpQzSQ>
    <xmx:tUFfasVvFSS-uHtn747MDxUKIyd8UxnHF1ZYmiZKgCfUmG5zt1j-5A>
    <xmx:tUFfatdpRQZKN2eFCCuwbTxWl1iX59a_iCAqn-b-AY6uSCWjaGkRKQ>
    <xmx:tUFfavNV8MYRzAFk3vAW1on_cI7WtVoZhBgAhoXp8O8m4NiHeNfDbHFk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 05:53:56 -0400 (EDT)
Date: Tue, 21 Jul 2026 11:53:47 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 7.1.y] ACPI: NFIT: core: Fix possible deadlock and
 missing notifications
Message-ID: <2026072141-mastiff-grope-7747@gregkh>
References: <2026070930-zipping-atom-8ef2@gregkh>
 <20260710133226.80782-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710133226.80782-1-sashal@kernel.org>

On Fri, Jul 10, 2026 at 09:32:26AM -0400, Sasha Levin wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> [ Upstream commit 18a00ed0e718473f5c3fcfa49df46c944575e60c ]
> 
> After commit 9b311b7313d6 ("ACPI: NFIT: Install Notify() handler before
> getting NFIT table"), ACPI NFIT driver removal may deadlock if an ACPI
> notify on the NFIT device is triggered concurrently.  A similar deadlock
> may occur if an ACPI notify on the NFIT device is triggered during a
> failing driver probe.
> 
> The deadlock is possible because acpi_dev_remove_notify_handler() calls
> acpi_os_wait_events_complete() after removing the notify handler and the
> driver core invokes it under the NFIT platform device lock which is also
> acquired by acpi_nfit_notify().  Thus acpi_os_wait_events_complete() may
> be waiting for acpi_nfit_notify() to complete, but the latter may not be
> able to acquire the device lock which is being held by the driver core
> while the former is being executed.
> 
> Moreover, after commit 03667e146f81 ("ACPI: NFIT: core: Convert the
> driver to a platform one"), there are no sysfs notifications regarding
> NVDIMM devices because __acpi_nvdimm_notify() always bails out after
> checking the driver data pointer of the device's parent.  That parent
> is the ACPI companion of the platform device used for driver binding,
> so its driver data pointer is always NULL after the commit in question
> which was overlooked by it.
> 
> A remedy for the deadlock is to use a special separate lock for ACPI
> notify synchronization with driver probe and removal instead of the
> device lock of the NFIT device, while a remedy for the second issue
> is to populate the driver data pointer of the NFIT device's ACPI
> companion when the driver is ready to operate, so do both these things.
> However, since the new lock is not held across the entire teardown and
> acpi_nfit_notify() should do nothing when teardown is in progress, make
> it check the driver data pointer of the NFIT device's ACPI companion, in
> analogy with the existing check in __acpi_nvdimm_notify(), and bail out
> if that pointer is NULL.
> 
> Fixes: 9b311b7313d6 ("ACPI: NFIT: Install Notify() handler before getting NFIT table")
> Fixes: 03667e146f81 ("ACPI: NFIT: core: Convert the driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: All applicable <stable@vger.kernel.org> # 9995e4404ea4: ACPI: NFIT: core: Eliminate redundant local variable
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Link: https://patch.msgid.link/3420096.aeNJFYEL58@rafael.j.wysocki
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/acpi/nfit/core.c | 71 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 9304ac996d41ad..1c592a01d825d5 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -56,6 +56,8 @@ MODULE_PARM_DESC(force_labels, "Opt-in to labels despite missing methods");
>  LIST_HEAD(acpi_descs);
>  DEFINE_MUTEX(acpi_desc_lock);
>  
> +DEFINE_MUTEX(acpi_notify_lock);
> +
>  static struct workqueue_struct *nfit_wq;
>  
>  struct nfit_table_prev {
> @@ -1710,9 +1712,15 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
>  	struct acpi_device *adev = data;
>  	struct device *dev = &adev->dev;
>  
> -	device_lock(dev->parent);
> +	/*
> +	 * Locking is needed here for synchronization with driver probe and
> +	 * removal and the parent's driver data pointer is NULL when teardown
> +	 * is in progress (while the parent here is expected to be the ACPI
> +	 * companion of the platform device used for driver binding).
> +	 */
> +	guard(mutex)(&acpi_notify_lock);
> +
>  	__acpi_nvdimm_notify(dev, event);
> -	device_unlock(dev->parent);
>  }
>  
>  static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
> @@ -3156,11 +3164,10 @@ EXPORT_SYMBOL_GPL(acpi_nfit_init);
>  static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> -	struct device *dev = acpi_desc->dev;
>  
> -	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
> -	device_lock(dev);
> -	device_unlock(dev);
> +	/* Bounce the notify lock to flush acpi_nfit_probe / acpi_nfit_notify */
> +	mutex_lock(&acpi_notify_lock);
> +	mutex_unlock(&acpi_notify_lock);
>  
>  	/* Bounce the init_mutex to complete initial registration */
>  	mutex_lock(&acpi_desc->init_mutex);
> @@ -3292,10 +3299,17 @@ static void acpi_nfit_put_table(void *table)
>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	struct device *dev = data;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
> -	device_lock(dev);
> -	__acpi_nfit_notify(dev, handle, event);
> -	device_unlock(dev);
> +	/*
> +	 * Locking is needed here for synchronization with driver probe and
> +	 * removal and the ACPI companion's driver data pointer is NULL when
> +	 * teardown is in progress.
> +	 */
> +	guard(mutex)(&acpi_notify_lock);
> +
> +	if (dev_get_drvdata(&adev->dev))
> +		__acpi_nfit_notify(dev, handle, event);
>  }
>  
>  static void acpi_nfit_remove_notify_handler(void *data)
> @@ -3310,6 +3324,20 @@ void acpi_nfit_shutdown(void *data)
>  {
>  	struct acpi_nfit_desc *acpi_desc = data;
>  	struct device *bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
> +	struct acpi_device *adev = ACPI_COMPANION(acpi_desc->dev);
> +
> +	/*
> +	 * Make notify handlers bail out early going forward.  The driver
> +	 * data pointer of the ACPI companion is only set once probing has
> +	 * succeeded, so it is still NULL when this runs from a failing
> +	 * probe, which also holds acpi_notify_lock, in which case the lock
> +	 * must not be acquired here.
> +	 */
> +	if (adev && dev_get_drvdata(&adev->dev)) {
> +		mutex_lock(&acpi_notify_lock);
> +		dev_set_drvdata(&adev->dev, NULL);
> +		mutex_unlock(&acpi_notify_lock);
> +	}
>  
>  	/*
>  	 * Destruct under acpi_desc_lock so that nfit_handle_mce does not
> @@ -3341,16 +3369,21 @@ static int acpi_nfit_probe(struct platform_device *pdev)
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_nfit_desc *acpi_desc;
>  	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct acpi_table_header *tbl;
> -	struct acpi_device *adev;
>  	acpi_status status = AE_OK;
>  	acpi_size sz;
>  	int rc = 0;
>  
> -	adev = ACPI_COMPANION(&pdev->dev);
>  	if (!adev)
>  		return -ENODEV;
>  
> +	/*
> +	 * Prevent acpi_nfit_notify() from progressing until the probe is
> +	 * complete in case there is a concurrent event to process.
> +	 */
> +	guard(mutex)(&acpi_notify_lock);
> +
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
>  					     acpi_nfit_notify, dev);
>  	if (rc)
> @@ -3371,6 +3404,11 @@ static int acpi_nfit_probe(struct platform_device *pdev)
>  		 * data in the format of a series of NFIT Structures.
>  		 */
>  		dev_dbg(dev, "failed to find NFIT at startup\n");
> +		/*
> +		 * Let acpi_nfit_update_notify() run in case it will need to
> +		 * allocate the acpi_desc object.
> +		 */
> +		dev_set_drvdata(&adev->dev, dev);
>  		return 0;
>  	}
>  
> @@ -3408,7 +3446,16 @@ static int acpi_nfit_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Let notify handlers operate (the actual value of the ACPI companion's
> +	 * driver data pointer does not matter here so long as it is not NULL).
> +	 */
> +	dev_set_drvdata(&adev->dev, dev);
> +	return 0;
>  }
>  
>  static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
> -- 
> 2.53.0

Does not apply at all, something go wrong?

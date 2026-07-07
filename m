Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101E37AA9F;
	Tue,  7 Jul 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415232; cv=none; b=lX5RBg9jsAZRNIv9da29JaA38Xg7IDmiJMW3iKtQYkiQOpMcnUtRw7k/7IrXoxAaq+bITaUf4c3dKAlcCJLVmpRRfXc8nltArUMtnbI9mgg5Yp64neSiwaaoRusqAmZwDuLbFqItoAoGCgwHQUirCZ+RUfWcRzegSzyL00YOM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415232; c=relaxed/simple;
	bh=gVY3iRWoJPje433nYucl93kbMIGsxUeX/697NT+uj6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p++CxF8nDLbBRujq1/MuRT9Unfs0l2roDrl8LD+iVkZyWvcydryfT+IOM1ufD5DcfbKLLoCty8HDH5hrLWXGmeWt+glZTcVurlZx0fOVF05EBsM0MxHdbqdlmZ8uLKpxxG9O40qELzfIDXF/YXGDEwJBBZUfxaxxhkDe2/yFv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0o00ujl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0o00ujl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783415231; x=1814951231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVY3iRWoJPje433nYucl93kbMIGsxUeX/697NT+uj6w=;
  b=Y0o00ujlsdweZAQQOcLnr/0V/G/zOaRCbbRnGvmOqv2L6cy7Lu0+CFrE
   6L2PXgLDBRbL1QQLXx9dlIHKCmRzq8TcRW9qQWsRVQJR4LNB1SuV5O02r
   +mNLdFH+goNZAhGv4klK99UAlEo0KgzmNa21C+MAqz3hfymAQoGSPryAb
   BtZ/I08iQXR73N8fiLmjWJHUb0taTqkzHGtd5MeLxnK3AIgmdpEuqKodd
   s/gscvkzkmuXBO1qHCoutmtgmGqFtB5g9yW4zQU7qbREFz99zlpq6/I+N
   DNkPjKWoTN81R5s8HqOvIhWvNLQj7wz0RfRWKN8/WbNMycaHoJHjYSB/q
   Q==;
X-CSE-ConnectionGUID: F+eiPi34Qg6EM0C75cOITw==
X-CSE-MsgGUID: sEL7zRZcTHebAS0qh5djuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87740981"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="87740981"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:07:11 -0700
X-CSE-ConnectionGUID: CIM2WCXfQH6G4eHBrtF8Bw==
X-CSE-MsgGUID: s6S0Sy4+TAelQsVBP8aVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253474346"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:07:03 -0700
Date: Tue, 7 Jul 2026 12:07:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com,
	stable@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v10 01/11] spmi: Fix potential use-after-free by grabbing
 of_node reference
Message-ID: <akzBtOjs0Blb1pnF@ashevche-desk.local>
References: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
 <20260707083730.33977-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707083730.33977-2-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 10:37:20AM +0200, AngeloGioacchino Del Regno wrote:
> As noticed by Sashiko during a review run of an unrelated patch,
> in of_spmi_register_devices(), for_each_available_child_of_node()
> is used to loop through children, and to also assign a node to a
> newly created SPMI child device.
> 
> Problem is that the refcount is dropped at every iteration so, in
> the specific case of DT overlays, a use-after-free may occur when
> an overlay is dynamically unloaded!
> 
> To resolve this, increase the of_node refcount when assigning (in
> function of_spmi_register_devices) and release the reference in
> spmi_device_remove().

...

>  void spmi_device_remove(struct spmi_device *sdev)
>  {
> +	if (IS_ENABLED(CONFIG_OF))

Unneeded check.

> +		of_node_put(sdev->dev.of_node);
> +
>  	device_unregister(&sdev->dev);
>  }

-- 
With Best Regards,
Andy Shevchenko



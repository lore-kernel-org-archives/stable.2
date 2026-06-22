Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCB326945;
	Mon, 22 Jun 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140682; cv=none; b=Jb4gwgBDhvUwKyDcnlThgVInWKP/f3HwVqt+LVqe1ZJQa+lm/IH4CI24L9xwlcybemwMWP53CjH5sQpNKkjALKMo3OuWyGA5LVjMLE6tlXWgS8gjqtpTHwrvsbCwWIf5oCye/q6O8wdQgqb/CfM2nDYq0Jgx5Or3qA//DOsEMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140682; c=relaxed/simple;
	bh=ggoK9rJ/xNRVxQ/PfgcSzYDOQgbNl4H3XBAyywGAyXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqUCxRr+ArkaG8st2yU3VWZcuQROQ1oX3ki/F7QMqY7yzc18OodGe8/PgtDN5TNMwzuHkIHMBXlaQfnO22ntiEmZQ8bUlo10op1TNOia9zTxeiu7FmAwziFfw0gR8uR1IEBcG++Z3hetUX/7URup5KjFZzmdwMheSx7evHkSI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjWOeg23; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjWOeg23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782140681; x=1813676681;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ggoK9rJ/xNRVxQ/PfgcSzYDOQgbNl4H3XBAyywGAyXs=;
  b=WjWOeg23qlUlAV46YSN6H3KM9eyDJZpJ5lAAneldDItHV7RqoiZimbUz
   AjWL7HZZhmOrNca/IcLWFKAjY35xgA6Di6nUkHHvBRCXSsLR+o3+gMoDe
   /dsEJAPXQwK6gKRbaeChvnsepVRkAhZPeFpRlmnm/ogJfSPq96po4D3zL
   c8TgTDuIf/d3Z4Cyo0L9H5gDDtUFS3ghETvLHcvZdLX4yljCzNeSjr6Sa
   PQtoVGkxg0nABXKRrSbR90Q4tDncLtNSKaTlxSLg7LfXZdhU7s8ANngqR
   d135uzFoS7G3zzqRlvz0m2XubsTyJbAWWVq42+xPkS4mIl2jniPVp1Lhj
   Q==;
X-CSE-ConnectionGUID: 4MZNVLwFQeW23wUDsI7eOw==
X-CSE-MsgGUID: W6NiEzvNSgefVSvkHOvffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100423307"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="100423307"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:04:40 -0700
X-CSE-ConnectionGUID: fQbYDY+jReKfkJfsMW0O6Q==
X-CSE-MsgGUID: yVfqrxArSNqpYSY7wlmorg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="249105435"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:04:41 -0700
Message-ID: <5f34e8cbff2c92f58831cbac9239c3251389da53.camel@linux.intel.com>
Subject: Re: [RESEND PATCH] platform/x86: ishtp_eclite: fix ACPI device
 reference leak in probe error path
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ma Ke <make_ruc2021@163.com>, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, sumesh.k.naduvalath@intel.com, 
	mgross@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Date: Mon, 22 Jun 2026 08:04:40 -0700
In-Reply-To: <20260622070352.689982-1-make_ruc2021@163.com>
References: <20260622070352.689982-1-make_ruc2021@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 15:03 +0800, Ma Ke wrote:

Why Resend?

I like the first character after ishtp_eclite: to be upper case as the
first version of the driver (Later than convention broke). If you
happen to report for any region, you can change that.

> ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
> acpi_find_eclite_device() but fails to release it in the error path
> when acpi_opregion_init() fails. This results in a reference count
> leak, preventing proper cleanup of the ACPI device.
>=20

Change is good.

> Calling path: acpi_find_eclite_device() ->
> acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
> bus_find_device() -> get_device().
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Cc: stable@vger.kernel.org
> Fixes: 7b6bf51de974 ("platform/x86: Add Intel ishtp eclite driver")

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

> ---
> =C2=A0drivers/platform/x86/intel/ishtp_eclite.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/ishtp_eclite.c
> b/drivers/platform/x86/intel/ishtp_eclite.c
> index 93ac8b2dbf38..bca7e217878b 100644
> --- a/drivers/platform/x86/intel/ishtp_eclite.c
> +++ b/drivers/platform/x86/intel/ishtp_eclite.c
> @@ -600,13 +600,16 @@ static int ecl_ishtp_cl_probe(struct
> ishtp_cl_device *cl_device)
> =C2=A0	rv =3D acpi_opregion_init(opr_dev);
> =C2=A0	if (rv) {
> =C2=A0		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init
> failed\n");
> -		goto err_exit;
> +		goto err_put;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Reprobe devices depending on ECLite - battery, fan, etc.
> */
> =C2=A0	acpi_dev_clear_dependencies(opr_dev->adev);
> =C2=A0
> =C2=A0	return 0;
> +
> +err_put:
> +	acpi_dev_put(opr_dev->adev);
> =C2=A0err_exit:
> =C2=A0	ishtp_set_connection_state(ecl_ishtp_cl,
> ISHTP_CL_DISCONNECTING);
> =C2=A0	ishtp_cl_disconnect(ecl_ishtp_cl);

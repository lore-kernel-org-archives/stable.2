Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564950;
	b=PVoFQ4knJV2/nY/X0ZYsA8S7s/oY/hNNgxi1KE33CBnPR6KgxwWvsOpJcwPh9vIdNl2n
	 UqVbf7NS0u+b0JYtVa5p8raOmXR+5kkVjFD9YIkUaKmYTmPLYqKECvQuUmaPs2/fcr5GT
	 Dxa6yCwaYGBJOJO4/mnfWfrfIuyRtzZHKyrq1VR0RrkoMDOHZng+0SuwKSeUj25/nAMuF
	 +M3s+vs6vg8Ns/0p1w58mtwbv4/Ok+oXUirWZkgfd92LQJU7Xrb9x0baRVs6eI8/sg01N
	 G2s3RHy+LZo6Hg0+NeKuqvU/LLUxcJbPvWMvmux2jdauOVnPMpHPHlBFzH46BkYfrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564950;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=P5Qh9qW/+Ju810c4VDZfB+2DBWmN3dBrCSMEnmUX1RM=;
	b=hMBC34g0hOgNFVH5F3NBMb0Nnitp/O1BoUIYAfVm3zQ27oteLxAMlaQ58J+GmBE0Prwm
	 tELacM55jpS/lD1r//7w7EAj9vmOXjedM7ZtBm2Et2xsOBFkd5qFMAYQsQhV+xrnJ997z
	 yK9Veq16xHm2/tzFOs7aOx9uKdVc4c3yhwQ6XZBav8q9HJTSr7rVNrexsnQ4WoXj8Qv1o
	 +19Dypqh/5d/PVuH8XvsDiqn+4JJNxHxmpUQb3G1NIocfD+A83sXLPSowyBvV12NipHHi
	 Qm/2Xi2JKbCOSvcZRoCBEags1ABjOvtjMbI1PDxALjaRtyUMi/sC6brunNzNn7xNJiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJnDaTl3;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BB606A338;
	Fri, 13 Nov 2026 10:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1BB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJnDaTl3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794564949; x=1826100949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eYzEcy33qmGlhN38956oty9IuuGWX2i7eY9WGNxoZvk=;
  b=iJnDaTl3armevXS0nMGY17vqEf+RxLyDXI5mJ9Gpedht63mx9RoJrdh8
   GUhHsipE88ly0me9Grpd4ptqzo+bB2SwY7oOtxG1y7yNjVr8ykfcVU6gS
   VicH4mR5OUztSSNbDiJyR9Bi5eEUDqph3VPSJo3mYKKR0LtssLesTfGP4
   6e094n93Vep9SPU9wJoq75NzSWxgPM4XEB8cZXe9jGxmgDymSR0NomViU
   aciMVqyoVFV4PlWoAVqhjYuPHGRWI69kMtlh+EMxD0XasHjhnGU3bOC2c
   yD4TZdHEkbThfV9zHHsGK01DdHGtMI+bT7dGoZeAADPOF5ghyLw4g4kPu
   g==;
X-CSE-ConnectionGUID: Wldz7em6Rt2V5lOnwJ4VZg==
X-CSE-MsgGUID: Jk+T8IZ/RF2fUguXdghW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3238321"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3238321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 02:15:49 -0800
X-CSE-ConnectionGUID: MHIuKf8mTWW1AtU3zCtbjQ==
X-CSE-MsgGUID: 0bM3YITwRq+1sfDa+KSFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9049891"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2026 02:15:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 609A699; Fri, 13 Nov 2026 11:15:46 +0100 (CET)
Date: Fri, 13 Nov 2026 11:15:46 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Changyul Lee <lcy8047@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: Check the alternate mode ID allocation
Message-ID: <avbjUqq5P1Vrollc@black.igk.intel.com>
References: <20261111154503.3621477-1-lcy8047@gmail.com>
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
In-Reply-To: <20261111154503.3621477-1-lcy8047@gmail.com>

On Wed, Nov 11, 2026 at 10:45:03AM -0500, Changyul Lee wrote:
> typec_register_altmode() stores the return value of altmode_id_get()
> in an unsigned int without checking it. When ida_alloc() fails, the
> error code becomes the ID, and the alternate mode is registered under
> a name such as "port0-partner.4294967284". A second failure on the same
> partner then fails with a duplicate name:
> 
>   [    0.423055] sysfs: cannot create duplicate filename '/devices/platform/altfail/typec/port0/port0-partner/port0-partner.4294967284'
> 
> Return the error when the ID allocation fails.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - Add Cc: stable@vger.kernel.org
> 
> v1: https://lore.kernel.org/all/20261111041446.3072716-1-lcy8047@gmail.com/
> 
> Found with a static analysis tool we are developing.
> 
> Reproduced in QEMU (x86_64) with a test module that registers a port,
> a partner and 63 partner alternate modes, and then two more with
> failslab (task-filter) making ida_alloc() fail with -ENOMEM. Without
> this patch, the first of the two is registered as
> "port0-partner.4294967284" and the second fails with -EEXIST and the
> error above. With it, both return -ENOMEM. Same result in three runs
> each.
> 
>  drivers/usb/typec/class.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 54c7810b563b..29fb13ca9f28 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -641,11 +641,14 @@ typec_register_altmode(struct device *parent,
>  		       const struct typec_altmode_desc *desc,
>  		       const struct device_type *type)
>  {
> -	unsigned int id = altmode_id_get(parent);
> +	int id = altmode_id_get(parent);
>  	bool is_port = is_typec_port(parent);
>  	struct altmode *alt;
>  	int ret;
>  
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
>  	alt = kzalloc_obj(*alt);
>  	if (!alt) {
>  		altmode_id_remove(parent, id);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.43.0

-- 
heikki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3F3E3179
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522074; cv=none; b=Jz9lK+vdZ63OfylrmIX8nnUh3cGDpo1t680UG63tOFMkuniSEQL1abvYBbI4dPQHrBscJtW71jAbpVRgWZAnDAyHwA32s8D6lv/L/IpWe26cq14JDheBviM6/pCF3U+X2x1odwIJAzJDFJCbIbhkIXWeHZo7J8qxcjNUbL6szfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522074; c=relaxed/simple;
	bh=LibXhyMWEbKvNHjik8IFLmy2/nZh6PunuZu7k3YS+z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PC5XFbTTMDYpuH82Z3jCbx+NPQDfXzdlBrjsJY1vNfPnV5Va/utgM7KA5gUSLyWag3yletPgCX10rEckj2q49YFm895SLxXoa8ok9JYfOpAdpcQh6mUJo3x/W1aOwwyXEWdzJyS3lMH6Tcq0F1rK07MiRtoxQ65dgWxdcbROzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc6VJmRd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc6VJmRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781522072; x=1813058072;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=LibXhyMWEbKvNHjik8IFLmy2/nZh6PunuZu7k3YS+z0=;
  b=hc6VJmRdPgj8TN5o6bc4r215ASX+04hSiGNOp5loTH1DXg9ifOokqmjT
   ez+sjMRL5ugzzBr9oGrWdtAhd3foLPRQXXeUeTBQguT4wJ9bmfue3zmoG
   b16YbO+fMO8YBUJPoBRJkU2v0yOSguuR3Z2iNTwLAkF7sy7odF4NVw4IF
   OQOZTwXIJWy6RtORL0xkKfTbflidVgFPjTTnvT1JmmOMNTYfRbIdXNauk
   pwb5rEnKd6z8m/4Il6uNOnHK8NsvMUKLZSoK0LhGKYL5RY1LNNbRIQx7y
   IylYCnhx7X5yL0Q8xrCFmcbuNjLaF8U1tqN7XSFxdzx7BtWhcJ6Kh8sdV
   Q==;
X-CSE-ConnectionGUID: euv9aDswRaafpPUy0es0yg==
X-CSE-MsgGUID: qa8u+8q0QyqgkeLQsu/OzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82158851"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82158851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:14:32 -0700
X-CSE-ConnectionGUID: iKcVKx5yR8+DuAT4tOIruQ==
X-CSE-MsgGUID: htb7nWH5SkSRTdP0bB6xIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251363199"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:14:30 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
In-Reply-To: <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610141549.555605-1-jani.nikula@intel.com>
 <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Date: Mon, 15 Jun 2026 14:14:27 +0300
Message-ID: <dcce02bcee216f44cbbd4e597a2a0b3e4e9977e4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026, David Airlie <airlied@redhat.com> wrote:
> On Thu, Jun 11, 2026 at 12:16=E2=80=AFAM Jani Nikula <jani.nikula@intel.c=
om> wrote:
>>
>> The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
>> Block consists of three fields:
>>
>> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
>> - Tiled Display Product ID Code Field (2 bytes)
>> - Tiled Display Serial Number Field (4 bytes)
>>
>> i.e. a total of 9 bytes, not 8.
>>
>> The DisplayID Tiled Display Topology ID is used as the tile group
>> identifier.
>>
>> Update both struct displayid_tiled_block topology_id member and struct
>> drm_tile_group group_data member to full 9 bytes.
>>
>> The group data was missing the last byte of the serial number. I don't
>> know whether there are known bug reports that might be linked to this,
>> but it's plausible the last byte could be the differentiating part for
>> the tile groups, and fewer tile groups might have been created than
>> intended.
>
> I pulled out my spec, and indeed I can confirm this is the correct readin=
g!
>
> Reviewed-by: Dave Airlie <airlied@redhat.com>

Thanks for the review, pushed to drm-misc-fixes.

BR,
Jani.


--=20
Jani Nikula, Intel

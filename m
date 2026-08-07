Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EF4756D7
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106764; cv=none; b=Gb2otODPxae2E5IloGmtlLKkbjwosjk31kZlU+kY0jjtv43daugF1W+8kf582kCs3YE/Y2oJysgGtwSmHInx8iL5VibUjU3y+seilYNhLCg0NS1/PkW6OqZQOlA2+zgLLS1FgnJbYe7/Mzs4kg7U93vYXdMswiZS7LbkNJui8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106764; c=relaxed/simple;
	bh=lJBJIWfnlJuBrmy0UBwJ59rfYvxzSekY2abk4IjTU/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQ2PC/+KS0coA2f5AK9HGO7/loSBUGVJG/kgY9XSZDdg7x62R7/2M5eJkuZ/3D22usrKqxAWAAlORXLoF8E62GgmSk5oKoRIgMerZeQo1UoRWqkrlscfoDmp2YAYIkd0fq6+bEM1uoq780ASZf+RI7PkGRMdnXgOMLSvHcpxwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv7c9pVE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv7c9pVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786106758; x=1817642758;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lJBJIWfnlJuBrmy0UBwJ59rfYvxzSekY2abk4IjTU/4=;
  b=bv7c9pVEkCH5/Q6zUFfI6BkR11CdCINP765YatEuGhFk+TPDA2ekW/VD
   HZ9BAdociVOsAw0PA25joIXn+B/X1eAJQf3+2mZOW9w2htBRK//IOzoPQ
   LRz6gqaXOHHF1A9388y9T7abxjlqlqHJAjVFlao0GbgdxZE+N7VEbY2YD
   AAlhkS0B9yZM2k3fIPVerFVq4wpogz6LNMOIVB44WgOxrW8MHvgsSumlo
   wv1a3A3XrkOEcgCyr/xubgLgpEGSRoL1tBEIjeuobp/WQGfhjThZ3IvPy
   Gqxh3n7JarFJmcGKN0tOt4+MFuJ2RaZ47yrlePnsNvzdLhrhKobpwe0Gh
   w==;
X-CSE-ConnectionGUID: tTav609eTbieSJXix4QmTA==
X-CSE-MsgGUID: tABrWE4NT92DqbU2x/YNJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85683577"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="85683577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:45:52 -0700
X-CSE-ConnectionGUID: eZDgOUZgSIOAEME3x7UdNA==
X-CSE-MsgGUID: JtUTtpvMRH6WFFyuV9CSiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="263019122"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:45:50 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: Limit max joined dotclock on pipes
 available
In-Reply-To: <95cc059b-056e-4aa3-8431-1e497002f58d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260806143738.2710312-1-jani.nikula@intel.com>
 <ca6f4f3b-9c94-4b24-a8e4-7c351e730429@intel.com>
 <788a51d6-4eca-4365-bad1-037d25f388d0@intel.com>
 <95cc059b-056e-4aa3-8431-1e497002f58d@intel.com>
Date: Fri, 07 Aug 2026 15:45:46 +0300
Message-ID: <65d9cdfb093f5e1e048738aaf1b20131f18ed16b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Aug 2026, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> On 8/6/2026 9:19 PM, Nautiyal, Ankit K wrote:
>> On 8/6/2026 9:15 PM, Nautiyal, Ankit K wrote:
>>> If fused pipes are AC or BD this will still give us 2. Perhaps should=20
>>> have a check for atleast 2 consecutive pipes from=20
>>> DISPLAY_RUNTIME_INFO(display)->pipe_mask
>>
>>
>> ^I meant :=C2=A0 if fused pipes are B or D, resulting in A,C and B,D=20
>> respectively, as available pipes...
>
>
> Correction (typo'd twice (facepalm)): I meant if the available pipes are=
=20
> non-consecutive, like {A,C} or {B,D}=C2=A0 the count is still 2, but=20
> bigjoiner needs 2 consecutive pipes.
>
> So we should check pipe_mask for a consecutive pair.

Agreed. The more complete approach at [1].

Thanks,
Jani.

[1] https://lore.kernel.org/r/20260806143738.2710312-1-jani.nikula@intel.com


--=20
Jani Nikula, Intel

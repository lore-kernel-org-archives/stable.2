Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47232361DD2;
	Tue,  2 Jun 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416785; cv=none; b=dzoglzAo2C4SIQMA3/Y8QbQTZyqDiRa5mz1MpKhPOru5dSo8Y1iOSIBteITogdL+QQSDmbggjimd4aipw8rPRK0Kq4p4GhO+FH8EvVz5HY5QwmKCyGmvHwkzg3o+OXSnA5fsA24C4bSrZxGNeuskFOiyiRV1b7q2thqroHfbtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416785; c=relaxed/simple;
	bh=cOPM1YNayNKcs9C+ah1/+0Ulam/zhO7bq6tJQ2j06lI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXg4tC2B6pSGDACaep9/0PAQ8OcF7hW3lyGPI7aEEivQnKF2O1k3M4bT3lLlKa6yb39WLQClsCIzkiQ+O1eutPY23vBMDIwL9jAPVfrMCCmWSYSAd/uQdykSOKjto/d0lGUd/ccw51FYwrIo0jcw18KNqwBBHnIQbpQvV0o/PoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJfOyYEm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJfOyYEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780416784; x=1811952784;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cOPM1YNayNKcs9C+ah1/+0Ulam/zhO7bq6tJQ2j06lI=;
  b=mJfOyYEmCn0u42Qn3A/hnYMvj/FTiJWhsIuZGB+KlZpGgq/wftvaMATJ
   Ix8bNxVxHIl2hZM7rlFlRZLNglIPnBbMWNH4k/FWbNCFj9b6RHN34YZf9
   cjecjNyk/avKo5j66YD+hViw/A0y8y/xdGPgQIoM1gSFREUmGMMMbj+Ho
   h7w1iT+vBcMvebwdDdeziR0qD7GQqL12iQZtyphabz+RoG8/IRFVGA6VF
   rBtRwuUCGJ37pQ78wgnMEHgg7tKKMTpx15IqLhsQAA12mq56vDCBsCFq/
   lx3whmeHetQxOV+EmGHLlQo1sSd4z6Sevz/JBjzp9rnOfl1XUmELrzsSv
   w==;
X-CSE-ConnectionGUID: OeOMAC/wTuixSwCDBy72BQ==
X-CSE-MsgGUID: igLHndMvTVa2A4QILe2wcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81238118"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81238118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:13:03 -0700
X-CSE-ConnectionGUID: 49BM95/+RjCH2QOO2zArUw==
X-CSE-MsgGUID: wPUF6LifS6+hLL0TNZWiIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240956285"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.41]) ([10.125.108.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:13:03 -0700
Message-ID: <db99c3312d96656d90788444ee8cf0105ac988cb.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz
 after CPU hotplug
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Guixiong Wei <weiguixiong@bytedance.com>, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 02 Jun 2026 09:13:02 -0700
In-Reply-To: <20260602020752.3126-1-weiguixiong@bytedance.com>
References: <20260602020752.3126-1-weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 10:07 +0800, Guixiong Wei wrote:
> When the last CPU of a legacy uncore die goes offline,
> uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
> re-add, uncore_freq_add_entry() still populates sysfs attributes
> before
> assigning the new control CPU. As a result, the current frequency
> read
> returns -ENXIO and current_freq_khz is omitted from the recreated
> sysfs
> group.
>=20
> Assign control_cpu before the initial read paths and before
> create_attr_group() so sysfs recreation uses the new online CPU. If
> sysfs creation fails, restore control_cpu to -1 to keep the error
> path
> state consistent.
>=20
> Fixes: 4d73c6772ab7 ("platform/x86: intel-uncore-freq: Conditionally
> create attribute for read frequency")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> =C2=A0.../x86/intel/uncore-frequency/uncore-frequency-common.c=C2=A0=C2=
=A0 | 7
> ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency-common.c b/drivers/platform/x86/intel/uncore-
> frequency/uncore-frequency-common.c
> index 7070c94324e0..f8137ee92e47 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> common.c
> @@ -275,15 +275,20 @@ int uncore_freq_add_entry(struct uncore_data
> *data, int cpu)
> =C2=A0			=C2=A0 data->package_id, data->die_id);
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * Set the control CPU before any read path so entry
> recreation after CPU
> +	 * hotplug can populate read-only attributes from the new
> online CPU.
> +	 */
> +	data->control_cpu =3D cpu;
> =C2=A0	uncore_read(data, &data->initial_min_freq_khz,
> UNCORE_INDEX_MIN_FREQ);
> =C2=A0	uncore_read(data, &data->initial_max_freq_khz,
> UNCORE_INDEX_MAX_FREQ);
> =C2=A0
> =C2=A0	ret =3D create_attr_group(data, data->name);
> =C2=A0	if (ret) {
> +		data->control_cpu =3D -1;
> =C2=A0		if (data->domain_id !=3D UNCORE_DOMAIN_ID_INVALID)
> =C2=A0			ida_free(&intel_uncore_ida, data-
> >instance_id);
> =C2=A0	} else {
> -		data->control_cpu =3D cpu;
> =C2=A0		data->valid =3D true;
> =C2=A0	}
> =C2=A0

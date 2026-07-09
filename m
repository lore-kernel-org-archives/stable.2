Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50822E5B29;
	Thu,  9 Jul 2026 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604431; cv=none; b=lNuVnuxxA8Hu1+60p6FlxGvfwA2b1s06Gt/cc/z+whfOnNV9YcWn9Zi7ifuOfqzSB927qAr0Ja6P7L1ZuL0Z06KfLoeN8FJq7X7P7GtcgscOXcmSa2AlHySmbbB9FeiuiUzZGPjyOAtCmnR9eZ9PKldFPcJNf7SPK+hZ7JABdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604431; c=relaxed/simple;
	bh=jpefKvU0o97D+6rCm0jc5GzsU6oTwcJQuPrlRAo/6Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bg12xODBXsQxUPoP0eWDbQmQJazVdSKhO67XcRxkoBYw7wFUlBX4aBF5DvzRFfPKe5Kq1PCx1l0nLs/T7ODdmr/8YVzpK8n+mxZYICyoZhWNNBempCts4goyUoP3kvXTbJwOEFOZPTGTNRiSgPKcAX+fSUBkV/sWytKgA/gc4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqQtquNf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqQtquNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783604431; x=1815140431;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jpefKvU0o97D+6rCm0jc5GzsU6oTwcJQuPrlRAo/6Mo=;
  b=nqQtquNflnHdvAARjnTOk5wIW/rPYPHhYTz1y+TNT2s9do/QvMVp6HsG
   66LSlfAzaVENGhI30gXoy3XRPKsvWmQFeq2PyaKolcc5sjezsNE+PYffX
   poAKnKoRrGHg1a/XF1yFOHfvuSTc4DhgqOdFHeufY7Rsp6+0UYpGIzHIz
   LVNgDz1XX2FTGppakeWIseLqH2Q+ZyuWF5jWCDY3Nh4hRnSl3aGDrz5OT
   R6o2WbQY/8Nrnbu1ysyVgKGzmWk/5BZwGZAlrWJNIodyI4E/gKrOGmB6G
   SjBAZ7Y5OVJp3uUAWL2vpJC/BvCabcvUYgV2KMAqYUGBrQJvzC2rbN/nm
   Q==;
X-CSE-ConnectionGUID: IId8Z0fvQtideNiT/KcZgw==
X-CSE-MsgGUID: Y5leJyPXRk2xWpXjaNB8MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88199819"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88199819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:31 -0700
X-CSE-ConnectionGUID: m3gMdyMjQV+Npm09YUIV3g==
X-CSE-MsgGUID: UtZc74/3R8C/6cQiIwKdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258195457"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, hansg@kernel.org, 
 mgross@linux.intel.com, sumesh.k.naduvalath@intel.com, 
 Ma Ke <make_ruc2021@163.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20260624014910.1226446-1-make_ruc2021@163.com>
References: <20260624014910.1226446-1-make_ruc2021@163.com>
Subject: Re: [PATCH v3] platform/x86: ishtp_eclite: Fix ACPI device
 reference leak in probe error path
Message-Id: <178360442228.12613.11058614783929144446.b4-ty@b4>
Date: Thu, 09 Jul 2026 16:40:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 24 Jun 2026 09:49:09 +0800, Ma Ke wrote:

> ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
> acpi_find_eclite_device() but fails to release it in the error path
> when acpi_opregion_init() fails. This results in a reference count
> leak, preventing proper cleanup of the ACPI device.
> 
> Calling path: acpi_find_eclite_device() ->
> acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
> bus_find_device() -> get_device().
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: ishtp_eclite: Fix ACPI device reference leak in probe error path
      commit: e65e4242cd8babee019e575d85dd21261a68e4e2

--
 i.


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF734B1A7
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071866; cv=none; b=uxbI4Nc3/MKaDemKiI62vPh2IV0Zhsj7sUDdLfHTg0xvwbSm7GF0jvmy4Q+54lS+LAIkUpyDQ4L7ZLq2iAB7FA3KoqJnCUfP07eYtK1fXrvPalww0bTjaezBGjWX+OZGdlT21AxGz283p4WaWn/F4p1ftlLHZVPaZOqRaiygPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071866; c=relaxed/simple;
	bh=T4PLCV/Au02rSPIrD7i86UW7KEfAeOZVAklV1H4aAPU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=l6G/AsF/iAVV4VIODDPafzwgvVTts0R0ydiQSS9dnedzQ+afcaLPLR3ci2J8aXFcUXVc6BFfwfiu2TAYTQSxOfONuQ4NGKSDqWA7eBetydp9Gpn7V58d1lq3Zi+Z7SBGe2mOOYOzjRtMA727imoO+aVcdC70OPG0XC6EAUUZoKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sjk0oTor; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sjk0oTor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781071866; x=1812607866;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=T4PLCV/Au02rSPIrD7i86UW7KEfAeOZVAklV1H4aAPU=;
  b=Sjk0oTorO38FLtCbSRuawDHcjEwzTiqrfQUVmHI4MCzGbJK0wOWddM2t
   GXts3T8qC1x9xOvLD1xP0kIrfsWef5kUVWF6sjUf6AWcsK9jX7lYcKLFC
   qOOX8AOQAN7BvNcD2Na2QsrWwvnQQlJe4sGuK4c3huVVmV0RSzCkEyfuX
   sDCTNSebos2qeaOAyqdlgt9NUsIG4uYbW1KBt4QCO4ig9UoRtCBqhTOYV
   E/e6UEg9d2yC/d6Dr7VceyAqRJnzjXJHJlujnNrsGhHm5rvr9pgZEi0sY
   1hoPdes+t01O3/N0ApnUAr1ILLXJ5JBd/VZ4MG9GONWHUp/jxCt1WdZnN
   w==;
X-CSE-ConnectionGUID: anaRcV8wRoKLF/7boWLpmQ==
X-CSE-MsgGUID: Eo7B1wbTSDyOW9nMWx1xQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92962645"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92962645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 23:11:05 -0700
X-CSE-ConnectionGUID: j1Eh5tCDRrGC8NbEcy/+hw==
X-CSE-MsgGUID: U0DO/QqVQIKsdbxl8t6LLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="241941084"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.208])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 23:11:02 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260609183002.1051500-1-jia.yao@intel.com>
References: <20260609183002.1051500-1-jia.yao@intel.com>
Subject: Re: [PATCH v4] drm/i915/dg2: Add per-context control for Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jia Yao <jia.yao@intel.com>, stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>, Matt Roper <matthew.d.roper@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Maciej Plewka <maciej.plewka@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
To: Jia Yao <jia.yao@intel.com>, intel-gfx@lists.freedesktop.org
Date: Wed, 10 Jun 2026 09:10:59 +0300
Message-ID: <178107185934.29382.9213110661861924376@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Jia Yao (2026-06-09 21:30:02)
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed for that context.
>=20
> LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
> the correct value on every context switch via the indirect context
> batchbuffer to avoid leaking state between contexts. The old unconditional
> application of Wa22013059131 in intel_workarounds.c is removed.
>=20
> v4:
> - Add a link of the userspace using this API
>=20
> v3:
> - Kernel-internal context will not change workaround settings
>=20
> Bspec: 54833
> Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds=
")

This is not a fixup to be backported to older kernels, this is a new
feature, so please drop this. It'll cause unnecessary noise.

> Link: https://github.com/intel/compute-runtime/pull/919
> Cc: stable@vger.kernel.org

Definitely not for stable for above reasons.

Regards, Joonas

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AC1DF736
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300326; cv=none; b=me+Nj559AvWFdXz3xgRI1Lg8qOz2dUXhs9N3Nn8ls8HZxlYDC5PwcHpjbGh2ogqvU3PjCWneI4tAOvdpCAoVLdSsLQ4XiKKbtjy0l9UugbM7P8C/Ue1gmYmHffpw4aiEo+IcluogHdtpzeGLe38Iktvs3StH0/cWpiOPcD2VfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300326; c=relaxed/simple;
	bh=m0LGuB5FkxF5rC95tT6VWj2lo/0s5OKsb2zVG5v554c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aYgSnTaEk6Oats88jp8cKAs1ALF6j7NNxnKINMsy7qvlmm87SHicW+k4pq5xO8wWm8AvMdyYsJwEoqa3vswUGzGmxMRpVxmp1fOye7BjR47OLa9IIiuDgFapAjUMbFZE1lcq446FFBfLh8u8GdLU5FOXgNn2gFtxiTSiyrnD10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYrm/AIU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYrm/AIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782300325; x=1813836325;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=m0LGuB5FkxF5rC95tT6VWj2lo/0s5OKsb2zVG5v554c=;
  b=BYrm/AIU47Ek5ZcO1OgEmX1ypyEmK2YPLV+02p0kI2UPhR7Fdw1PMWMZ
   4qLLkjZDtOAU2iIHTC2HmIKTufity5WKTwUiizfEIUo8AKLbIsABjMlAd
   yJMFD9jkoqzgpoRFe5U1NiihoBu4yGTpiL3fIBjO5+ey4K3KsmA0xHMDK
   CZnfmdmjAV+kGK7a0Rp0R3r0K3/v4ybOeAwyuqtybclFOgsJlDr3tnLTZ
   l6YNRjHPzbpGsYn94wtJGxMO987csrOC1aC8ModrLcxtB2v2ywcN+p/4X
   JrbofQ2kYRX6RZXKTXGqNv9TCGnqpYWDS6a2sq0rqVMx3nEv9TqLpKU7P
   w==;
X-CSE-ConnectionGUID: AdSJ+xAtRBaTB4b3bLNwXw==
X-CSE-MsgGUID: LFYYMwDNTLCF311FYkI5Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83179435"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83179435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:25:24 -0700
X-CSE-ConnectionGUID: fkOWmZXwQsmh7ccCZI1tXw==
X-CSE-MsgGUID: TqyTHdScRTOqgz9Z+GuXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="279978009"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:25:22 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Date: Wed, 24 Jun 2026 14:25:19 +0300
Message-ID: <178230031953.112641.4817434529385736057@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Pushed to drm-intel-gt-next, thanks for the reviews.

Regards, Joonas

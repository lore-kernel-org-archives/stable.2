Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104191;
	b=lD9D97uIdylKfgK1VWDW2a8BYRZvW7j+SnJxDoSZGCmByMG2uf2YfMoSEqErUe8v827i
	 6YZWafttOcHlNQZxc86LrWJwRuEO9+VIJgm8XKrtBtUIrXghGWsJnNm46FgVNYXbeiRxD
	 /F9CxO6nDj+41Kz4vuAwmHsMTpG79KzMKqqG6dixCu73gGuZpP6djTzKxHp1JrSX6WTHf
	 rPTPRnjS6NY3Bpc509esL8rE2lOYJ3JlL6MEkAHCFVup64WP2JuwILzJkbxyWFuo/eS6l
	 GOtd1DzcPsmMgoG87TiDT43rq4OmIPnGLmJySph8LBh3iogGQJWiKH2X6JhAXB8JcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104191;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ZEuZOC5eyWUu0W/0P4LA1qekTK2eHdfizQnodyDXm80=;
	b=Uzk7CCYsrLSmeSuLTwkVQQ6ZCSsBhXJS7dJT1X+KlEPuC7sN6tQNx+M14DvYjkJlyWbC
	 FdTZ5qNP9hmhdREyWLcqP7+tfHIFxXe0lepwBp7Kf/bZy1Jwe/pg7pQG0DMg6KaBAmpMI
	 Lo3rPp9QKj1BK4sRWT56QhQFE9c2AnEPmZyH8ikxPy5HUFyTRZHn1xdNILX/+oRVSdFAB
	 pJwGF0kM2PdLL/03xdTe51Zeh5iBdFgQjNH4J7tCW//+HAIeCB5WfiY4BjYWTssWNfxK2
	 VwkKW41/4yjnO/dE834X84XfI+jjB+w9LNG/j8OPNZKcvAMrYeSnuwgMOzCIA6fnJOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="j9jUD/yq";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70C606A335;
	Thu, 19 Nov 2026 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA70C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j9jUD/yq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795104191; x=1826640191;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=aKIYVp0HF7RoYlDQ9Z1YxNxs6aSGy49KFvQMa1mVgXY=;
  b=j9jUD/yqL9hGbCORWvnjf2cpru3Ti6Pwt2xsH310xdPrwsDVr3oXlgfC
   qHKM6RewHyzawr+jzQ5QQgKRf2FfATnr8v7/cXrmCv9JpFMyIxEMpp+Cm
   A0NmDFkgEcemETy+ZxQWixmkVC8sUeNcUDdnxNP0UanMHb7meAM7kj415
   bo81Yr2u1fkJ64T2PId5lOwvPalNq5kITf3KmyWaXYoHwUMTy6aY7Cw/6
   l4WiUfu0sQ0ppzmOluHHWvOzymS7kas9kEHqACIt5SHeAMS5uC9w7PdGJ
   TDQYp49om/EA8wCsQlznGXjP15xaDYkUUK53nbIMSN0qxt3ni06Hb4l8F
   Q==;
X-CSE-ConnectionGUID: N8TlsAObRyCdKqsafcqJeA==
X-CSE-MsgGUID: Vu5DuIyHSsmZjhnpw6dxKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3874211"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3874211"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:03:11 -0800
X-CSE-ConnectionGUID: 9kmDwDmGQ+OkVjFS0nO1ZQ==
X-CSE-MsgGUID: D1knF3rKQG2Ihtsiw3NJfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10371027"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:03:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, Awal Awal <awal.nova@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Mario Limonciello <superm1@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261023-amd-pmf-npu-leak-v1-1-798e7161bfba@gmail.com>
References: <20261023-amd-pmf-npu-leak-v1-1-798e7161bfba@gmail.com>
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix memory leak in NPU metrics
 query
Message-Id: <179510418102.21358.12243474789880136526.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:03:01 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 23 Oct 2026 10:08:45 +0200, Awal Awal wrote:

> amd_pmf_get_smu_metrics() calls amd_pmf_set_dram_addr() with
> alloc_buffer set to true on every NPU metrics request. Each call
> devm_kzalloc()s a new metrics table buffer and overwrites dev->buf with
> it. The previous buffer stays on the devres list and is only released
> when the device is unbound, so every request leaks one buffer.
> 
> amdxdna calls amd_pmf_get_npu_data() for its sensor query, so any
> userspace monitor that polls NPU utilisation through
> DRM_IOCTL_AMDXDNA_GET_INFO leaks memory for as long as it runs. On a
> Ryzen AI 9 365 (family 1Ah model 20h) laptop with a system monitor
> polling about 1.4 times per second, the kmalloc-512 cache grew to 5.8
> million objects (2.8 GiB) over 38 days of uptime.
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
[1/1] platform/x86/amd/pmf: Fix memory leak in NPU metrics query
      commit: 3f1be6b854af29f030e3199d85e79d28cfe766a6

--
 i.


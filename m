Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38B353EDF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894023; cv=none; b=Dt8DCTYxp29a43MSex55qQRV66DMY40m2Isalcr9n4ZpHEr41T+nR6gkN8ZEqHzAiMZKQj+W0pScut1ybJMRCwUV3n4HZakS/ueJON3wkRYH72VLuoMaPVmM/au0IP5WNJfg1RdKuG1W2wYcTmo8ecXRpBAe4EouDuprYvJGK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894023; c=relaxed/simple;
	bh=oX6JHShf+A4wt5UT1G/S4uiehydQF5BapdOdffR4Lok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvJJTT3LQAh4XiCzG9Bdn5Z3X10fvDJhd8b1tUmpbM4jGzctwpRKhpBypexC2oI7lOuMVQv/bfiSf2zhW9T4XqRC0+jZMV3GVFLsP4JkkfJeELwNc3D3hJpl06K7uthIHuKS7fl+Lst57iYo/bd4/X4SIkYFHbuAEFydvPYlZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kq8AMZU3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kq8AMZU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784894022; x=1816430022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oX6JHShf+A4wt5UT1G/S4uiehydQF5BapdOdffR4Lok=;
  b=Kq8AMZU3IWZYxy0R10uXaROLrF15EQ75XlSkr1Ijh7bY60VXTc3I+oNt
   X0tFkPWOSa5ZZ/M0GPd7v5EVeP6BjYZFtNn9tOSOROmmQJ4IgeLM7MNOc
   HUIcU3BuCM3Ed3Flxu+re2tNC8cFLcAETo3j6njCEmZOMiGyuLATjk9ds
   Ub4xG5YqkK8JGyFIhUyM7M6HRMjNkTf1FVEzPyshqDcn+khr45x9fQy2N
   nzamE3dfE5pmkGfXj6Ao+owknjMSDwp0/ZVQ5LYRUm1zTYvT8Ngg+6Lyt
   +PeLJVtyDNRXj1bWKNXo5qGKiOQHu1fejlXX1uk3h0oc/X931SibiH5iF
   Q==;
X-CSE-ConnectionGUID: pXUL6ftnRsST/YtF2Ei24A==
X-CSE-MsgGUID: TtzAiHnLR2CoCD9AvHbPqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85574327"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85574327"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 04:53:41 -0700
X-CSE-ConnectionGUID: IQFYNb41RSOkT3mZR6t4hg==
X-CSE-MsgGUID: SP9cpHtLSNKXXBtv7tTp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="259351205"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.7]) ([10.245.245.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 04:53:39 -0700
Message-ID: <b877896a-188d-4183-8543-5460cf9290f0@intel.com>
Date: Fri, 24 Jul 2026 12:53:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Add memory barrier before H2G tail write on wrap
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260724003108.1561414-1-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260724003108.1561414-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 01:31, Matthew Brost wrote:
> When the H2G buffer wraps, it is padded with NOPs before updating the
> H2G descriptor tail. However, the tail update is performed without a
> memory barrier, allowing the GuC to observe the new tail value before
> the NOP writes become visible.
>   
> This can result in the GuC reading stale H2G commands, potentially
> causing a variety of failures. Fix this by inserting a memory barrier
> before updating the H2G descriptor tail.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

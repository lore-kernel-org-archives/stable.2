Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77E404BE3
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876085; cv=none; b=i6fyhZDrD7oAVMGuONzSSU7mvZAj7fC6X8Njgpq1EqDwguSiMn1rLQslbovr15J7SjvoZNcPoQx2VRCd8Uem5zGKxPsPga25HZKGpNRp/MH5IxKhakFo8QM/yhNR1HPkbwREidsMKCVAF619O0oW9Z1M4xbU9ZsBlpcIo/WU/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876085; c=relaxed/simple;
	bh=Xo6UHjWsVLM0Nkkoj8sdGO+2Ka0wElQfBV+oBSFOuyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+429zMXwjk+RSqVR3VWGUE1PVwbvuUHdNLDLeXV8G6zhxaf6QZdojn2elAEu4YlJUnsbbku3TJDyzeAlWbXT5vUdRxVWrUDoMRLYJpbS+MOVFfk59JmvC47YFxKPaFEE808cyv55/XdypUtZolAF4Ri9wmVR45Qc/HDA54tUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYA+/GPn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYA+/GPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790876082; x=1822412082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xo6UHjWsVLM0Nkkoj8sdGO+2Ka0wElQfBV+oBSFOuyw=;
  b=nYA+/GPns7qx8C3VKC1hT9Dt0oW8Fwq6lh6ZJwJa3EgacyU+z3Ek+K72
   SpNQJUyrq9XMCDu1jW12QMRhohszsRnLifL6Ko3Qev8kjFCEauW+TTT0t
   ykKS0+KaHFu9ox037GYc0smhoboR3P9exRS4cgd52mjGRKvE1jo4iDLXx
   Nq4SBCO9kQkU7w67IHBfIcZ7e+cdSPxQSKJ0/9kJPudh9JVmHU4W0j9rF
   +rL8nh07K0uNn+9vT4EPy3ymKq12NzpF1XsbCRVcIeX64iZ5uHVeZz0Ro
   0DLxZs658khcA8a+OU9wLtMDmpx6mZGruNvwyXz292mrLGnAA4tvOerI+
   g==;
X-CSE-ConnectionGUID: bjZ9Got5RwqMqsNhC2QRwA==
X-CSE-MsgGUID: qH16kGpcRga5e2Ib64rSTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101803984"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="101803984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:34:40 -0700
X-CSE-ConnectionGUID: Ui4ED4q/Q0+0LuwR/ccflA==
X-CSE-MsgGUID: tFu3J6Z3SmKu56z9537ZqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="276107560"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.54]) ([10.245.244.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:34:33 -0700
Message-ID: <6aed4ffa-bfa4-44d0-a4a2-5181e9208016@intel.com>
Date: Thu, 1 Oct 2026 18:34:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Fix shrinker accounting double-subtraction
 on nested external pins
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20261001134018.111553-1-thomas.hellstrom@linux.intel.com>
 <20261001134018.111553-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261001134018.111553-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2026 14:40, Thomas Hellström wrote:
> xe_bo_pin_external() and xe_bo_unpin_external() support nested pins,
> since the underlying ttm_bo_pin()/ttm_bo_unpin() maintain a pin_count
> refcount rather than a boolean. However, the shrinker accounting calls
> xe_ttm_tt_account_subtract() and xe_ttm_tt_account_add() are invoked
> unconditionally on every pin_external()/unpin_external() call, instead
> of only on the transition into and out of the pinned state.
> 
> An external BO (dma-buf) can be pinned more than once while already
> pinned, for example when it has multiple attachments/importers, each
> independently calling xe_bo_pin_external(). Each such nested pin
> subtracts the BO's pages from the shrinker's accounting again, even
> though the BO's pages were already removed from consideration by the
> first pin. Symmetrically, each nested unpin adds them back again
> before the BO is actually unpinned. This desynchronizes the
> shrinker's page and object counts from reality, and since they are
> declared as signed long but interpreted as unsigned long in
> xe_shrinker_count(), the underflow can turn into an enormous
> shrinkable/purgeable page count, causing the shrinker to be invoked
> excessively under memory pressure.
> 
> Guard the accounting calls with the same pin-count transition checks
> already used to guard the pinned_link list maintenance, so accounting
> is only updated on the outermost pin and the final unpin.
> 
> Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v1
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>


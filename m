Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3363C4557
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535105; cv=none; b=aRUAdBleUVlrLTt+zR+rc6oupWlvcc1RTpRD1Bfc+qA/6PujtJXLKiYyj0uxrrDztxFAn19iBGwohMb40B8Gsd0Ejh0h8jRR+5ge9oEKOpmJ8ozQgg+VY+CKmBRXE8DJTkjpzZxIQ5VHntwH0AFB66B1Bs1Bg7FRvtx3LvdXb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535105; c=relaxed/simple;
	bh=RgfmfUsh/qbFRrW/VWnHmvrkAUepoWwPIzLEVpWCgVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfOuIleEOaA+i1VxMG2CbwAMyGkohbtE9cWmYowViRdchTYT+OnyS83TezIMOncx6MEiajPpRoZJElbLl7NRMFNnoozMya/hjHoXoqbDaLPgfKi9YKhSWMetfUx8VWaGzLskaWFvEU9UEfsvffqtEM0WPB4l2mEjHVmgQ+BsWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHxHzn94; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHxHzn94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791535104; x=1823071104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RgfmfUsh/qbFRrW/VWnHmvrkAUepoWwPIzLEVpWCgVw=;
  b=oHxHzn94S7lKuVOHrMyKs8i+H7JoHEXaSdhbpSZMtCABlYN+753Tgb9G
   W0V5kx0TVtW2ZMIhm4DKjgk5ZPhmTYHiuSas5wjMN/sWamyENoubR1yBN
   PrjliYzu5NbgHyRNYbyyL6aV62YS7TTdqxA9sJ2sNRCi8GMBRu6wKAizv
   fZHiPopCFXmMq2SZEcM7L0pruXegWEtA/Jaos3Cv/rQaeXZW3uIUTcK9S
   gNVeiNJYym8YSeW+413XRFUbdGDMg3nh8OKLmWq7SH5suK5d0NlaCa+VX
   b+JI81PGCWwH5Za0lJ7fGrCLeksUyc28xftBxAxULa3gCKTezJ6x3k7LM
   g==;
X-CSE-ConnectionGUID: 04I8tPwxQ/C88wW21xdftg==
X-CSE-MsgGUID: 0YtykGakS9qxGm+cxU4hlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="218743"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="218743"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:38:21 -0700
X-CSE-ConnectionGUID: ZdMWIKC+Th2CTB3Xp997ww==
X-CSE-MsgGUID: HlVBXEw0TAuQRDrPRYhKiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="601383"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.244.25]) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:38:20 -0700
Message-ID: <c7c817ce-338c-4640-93d6-ad5d6ec6c444@intel.com>
Date: Fri, 9 Oct 2026 09:38:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Don't transfer shrinker pages for pinned bos on
 purgeable state change
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20261009070053.7790-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261009070053.7790-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/10/2026 08:00, Thomas Hellström wrote:
> Pinned bos have their pages removed from the shrinker's shrinkable /
> purgeable counts on pin, and added back on unpin according to the
> bo's purgeable state at that time.
> 
> However, xe_bo_set_purgeable_shrinker() unconditionally transfers
> pages between the shrinkable and purgeable counts. If the purgeable
> state of a pinned bo changes, for example by userspace madvising
> DONTNEED on a VMA of a bo that is also pinned as a scanout buffer,
> this underflows one count and, after unpin, leaves the other one
> permanently inflated.
> 
> Only update the purgeable flag for pinned bos, and leave the page
> accounting to unpin.
> 
> Fixes: 536a2ead3a8f ("drm/xe/bo: Add purgeable shrinker state helpers")
> Cc: Arvind Yadav <arvind.yadav@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v7.1+
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

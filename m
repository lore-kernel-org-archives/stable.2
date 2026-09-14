Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE748122C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396818; cv=none; b=fjoC8J5vJM0n2+MLe36Sqekku0YGbl0a9QxM5IMaYYgPCb5mHHcmpOj4URbU0oonR9WTKkaE4tAGavzAmhiAbj+Y3bfdUjWMQTZuAwybPmznXYqY2WGJfvcv8g+zFZCJhITZsXGoEoRUcVy+8XxIKbkFQWOtppABGObzVcbSoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396818; c=relaxed/simple;
	bh=D2l8PAgI94DSZ+VUCwal/hbYJBcp1fKGhzfhgGmzocM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyJouZ6XiPUzGpKk6pTD9MX4I5QM7wBmlbTvZZStHgDmTgaKP/kADbMO2bOzUPcX3OZiAczp4o8XqBeSzJ92si3EkiRojB8r/UOiXbYJvY2HGoR/R8n1WoFBhd5/Mx48RYsB/+oyIOq8EhTtMgPDFmPzzmnm54UrvQUjVUh3jwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxE0794R; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxE0794R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789396816; x=1820932816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D2l8PAgI94DSZ+VUCwal/hbYJBcp1fKGhzfhgGmzocM=;
  b=OxE0794RtzxnydkTCDp18uyabHphTNwwUTzT0lhBTfJ3wfFqK/SpBfGL
   3+klzCxB6FhMVZWso3LP5ewG9+ddRLeP5MNPreT0wdRpbul4QFVVFjz3T
   L6ugF912z/kmLpwcR+tqPp06hx2ggprwmP1Bm3usKdWnsprZJqfOwKD/A
   ryAdoXcgp7taooGIzonlBC/QtcmLVOd7plPaoIJHu5vJmvZypFEuhAjTv
   wV78Ehz+66hBzmVdXwpmM82OXuqEun39zyiHf/A9mxMUrnac6eDZo7Ybi
   esge6Bw338ghQZDWywIaNPQmyajcdsbzUP23fThKrdg85jBogovASwMY8
   w==;
X-CSE-ConnectionGUID: YY0fZI8eRNOQ1tW7SPgu/g==
X-CSE-MsgGUID: OpHDAl/pTX601W3x5mN28w==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88690711"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88690711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 07:40:16 -0700
X-CSE-ConnectionGUID: gm5pGuJvTDuunFslT7R7Eg==
X-CSE-MsgGUID: oD2WaTGgRaeUTlwWkPAvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277925831"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.118]) ([10.245.245.118])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 07:40:14 -0700
Message-ID: <4d5b3732-948b-4260-b40c-41461d40bda3@intel.com>
Date: Mon, 14 Sep 2026 15:40:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix shrinker accounting double-subtraction on
 nested external pins
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20260914134540.385186-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260914134540.385186-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/09/2026 14:45, Thomas Hellström wrote:
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
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

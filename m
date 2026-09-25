Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732441D21F;
	Fri, 25 Sep 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360697; cv=none; b=KxpHcgof/rWd9WyehqUo9yPhg7zbhgRjZ9iWILscKzbH5dMESnjhgoK/fkYdamS0u6vExWcS0Kzm93naICj8yTH3klfVag5agl6wUftaKbDEk+OFtWv8UY/qgZeOmpZK6mAX7ySDDvjIqVTILXev8WRZp/jsV3LTWmr7pWDEFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360697; c=relaxed/simple;
	bh=QkfjOc0sQlINp0dlL4tsqbRzARDUfMnXVuM6+kbNa+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swZ1C7wJvBh5Ce8Pc9XG4Ygp+noumwkgCRibb78sm34aaEI9/JSYpYKkfmZznXS8pt4ynsjUljwJ1TYz7x3YPEthdvj3Iz7SB3v2rqKeKkJKDSqWkKFLvrxUungwpqly2GPEsS3892LLBtvoK4dlIFGgU43xJyHy8dxUqw4DSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLl9aLLI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLl9aLLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790360695; x=1821896695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QkfjOc0sQlINp0dlL4tsqbRzARDUfMnXVuM6+kbNa+M=;
  b=aLl9aLLIDJf6tMR5hbxhhfrCu7I56Q646JaCMOjth6sGDkQgCSJp5G9s
   tYbZFQ7RCXfoXaWbEWPW3R/qIEsPr9Dg638C6y93FD5o0mPhDF60scyZE
   o/P0Txcex4ekYpXgBV4d3xmH0AjS/0ipNE5QwQ8YxcJrioq3k2iqkbr9f
   2d5HFFsfZYu74MFcuQP62vrnCN5VmvNFypVRp/qfV0iDReWc1AkWUfbX8
   +EiZzXyvre7HRbyqbRLI18yfR924GcdC6fG9FDf+PRmdBeK6NzZIWnR9p
   fQGAq8RPcv7i7Q2B+gHsKKKlAOCQB2IGw5q7FPpTgF6mZANAlLuTbn6+0
   Q==;
X-CSE-ConnectionGUID: Dcz6oi03R7CQInQbrgVFMA==
X-CSE-MsgGUID: ErCI3hRwT+C0Y8LQYqUIOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90370718"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90370718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:24:54 -0700
X-CSE-ConnectionGUID: CbPUjuojTVKmcaWccXdU9w==
X-CSE-MsgGUID: MHDen00fS6+3za6IRsAvZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272205388"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:24:54 -0700
Message-ID: <4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linux.intel.com>
Date: Fri, 25 Sep 2026 11:24:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
To: Priyank Rathod <rathodpriyank@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/18/2026 10:24 AM, Priyank Rathod wrote:
> When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
> APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
> ghes_estatus_pool to store the aer_capability_regs registers before
> enqueuing the error record into aer_recover_ring.
> 
> aer_recover_queue() returns void, so ghes_handle_aer() cannot release that
> buffer itself; ownership is handed to the AER code, which until now freed
> it only on the fully successful path. If the record cannot be enqueued, or
> if a dequeued record cannot be mapped to a pci_dev, the allocation is
> silently leaked. Under a sustained error storm this exhausts
> ghes_estatus_pool, which then breaks GHES hardware error reporting
> system-wide.
> 
> This series fixes both leak paths:
> 
> Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
>          aer_recover_ring (capacity 16) is full. The rejected entry is
>          freed immediately via ghes_estatus_pool_region_free().
> 
> Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
>          an active PCI device (pdev is NULL). The loop is restructured so
>          ghes_estatus_pool_region_free() runs unconditionally for every
>          dequeued item.
> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---

I'm fine with the current approach. aer_recover_work_func() already
owns and frees the buffer, so freeing it on the enqueue failure path
keeps the ownership in one place, and it keeps the stable backport
minimal. It might be worth adding a kernel-doc comment on
aer_recover_queue() stating that it takes ownership of @aer_regs,
which must be allocated from ghes_estatus_pool, so future callers
don't trip over it.

For the series:

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes in v4:
> - Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as
>   well. No conflicts with the Advisory Non-Fatal Error support that landed
>   in the meantime.
> - Added missing Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption
>   when error status data has multiple sections") and Cc: stable to both
>   patches; that commit (v6.7-rc1) introduced the ghes_estatus_pool
>   allocation whose ownership these paths drop.
> - Patch 1: use braces on both arms of the if/else and fix the continuation
>   alignment (checkpatch --strict).
> - Both patches now build warning-free with W=1 and CONFIG_ACPI_APEI_PCIEAER=y
>   (earlier revisions were only build-tested with APEI disabled, which
>   compiles neither of the modified functions).
> - Explained in both commit messages why the caller cannot free the buffer,
>   and when the missing-pci_dev path is reachable.
> - Cc: Lukas Wunner, who has been active in this code.
> - Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com
> 
> Changes in v3:
> - Resent to fix threading of the series.
> - Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com
> 
> Changes in v2:
> - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
>   is called unconditionally for every dequeued record.
> - Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
>   buffer overflow.
> - Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com
> 
> ---
> Priyank Rathod (2):
>       PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
>       PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
> 
>  drivers/pci/pcie/aer.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> ---
> base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
> change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
> 
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE649233935;
	Fri, 26 Jun 2026 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782436372; cv=none; b=gg3Db/h8JIFlYBmUEk2HQetn3SOtLBfA3y3Wsj6pcTr0RVDpka8WguhvwanbbyfPWW1abhoPJqYmjj0PSp/4BktHS991PSGtUzgrdQXlrv515wJO0eb8PS6eS7zSZu9/rzaTYPMaAUmXgrde/KRmtwf6NeyBa6w2AHbqjlDf7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782436372; c=relaxed/simple;
	bh=TOK5er6z8RnLK1wxERVSVTn+/wf8GqQqz+JAXpZD300=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ0taldmLdX9HQYspxb/i5FTaaJYrzGopj2mpge42xaS/atEknoKwJD9gGCF2i3IzcuyNSuzgN4noM+6aBa2aFfHqKGcNNmUaJJSsuQ5V6RFILVNZi6FfffGypynegcbLii8Gfrk8/3tEUgoTJui/zcEKffzoEvxh5oV0U8OHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdbXZgEy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdbXZgEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782436370; x=1813972370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TOK5er6z8RnLK1wxERVSVTn+/wf8GqQqz+JAXpZD300=;
  b=XdbXZgEyefLyLVl7j5sp5kg8YXi0IhQ4H9gEQqaxgXclyjmOTdW/LeG0
   sZYQw5cXND5NUMf8eIwr9f5t2GhKFxcRP4BUhY9RaYGrVZKwwdiuEglPE
   3pzrLLnfdKhDNMy+LvNlRQkunBEUq1CoR003RIQxUEcx7DWx1uoFtFTPR
   WUeT9HUfpemM4dJ1L4fM7RSK/cujfQ83mq1uqO+YoXZUcqYL5yt7i11lk
   TFFm+Spt7IQMT9cHsr3QYsC0A6zAbRWDiWPPwvEaWyGGwamQVPfiib/Ba
   9c1pcf6aVkTvm5+XjL/J3+e9pVC8+1HBBhY/vz2TW1zW3+7YFg2pMdRAT
   A==;
X-CSE-ConnectionGUID: Ewc0Q//zQW6cBF6aT3qTuA==
X-CSE-MsgGUID: QWkixAsDSO+wv1VfNcqPHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87080311"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="87080311"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 18:12:50 -0700
X-CSE-ConnectionGUID: vPSAy6kXSx+hPPg9P9X9MQ==
X-CSE-MsgGUID: U6UvCDR6SL+TASq726Evgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="251363928"
Received: from unknown (HELO [10.238.4.11]) ([10.238.4.11])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 18:12:46 -0700
Message-ID: <08340bd1-c115-468b-8145-dfc7c4eae3e2@linux.intel.com>
Date: Fri, 26 Jun 2026 09:12:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix reference leak in
 discover_upi_topology()
To: Wentao Liang <vulab@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, tglx@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625075311.45599-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260625075311.45599-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/25/2026 3:53 PM, Wentao Liang wrote:
> In discover_upi_topology(), pci_get_domain_bus_and_slot() returns a PCI
> device with its reference count incremented. The caller must call
> pci_dev_put() after use.
>
> However, the inner loop overwrites dev without releasing the previous
> reference, causing leaks:
>   - Between inner loop iterations within the same outer loop iteration.
>   - Between outer loop iterations (dev from a previous ubox's inner
>     loop is overwritten at the start of the next inner loop).
>   - On the normal exit path from the while loop (the last dev is never
>     put before falling through to err:).
>
> Fix by calling pci_dev_put(dev) and clearing dev after upi_fill_topology()
> succeeds, so each reference is released immediately after use. The error
> path (goto err) already calls pci_dev_put(dev) and remains correct since
> dev is set to NULL after release, making the subsequent put a no-op.
>
> The similar sad_cfg_iio_topology() function does not have this problem
> because it uses a single pci_get_device() loop and releases the last
> reference correctly in all exit paths.
>
> Cc: stable@vger.kernel.org
> Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out topology_gidnid_map()")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 215d33e260ed..1561bda43835 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5499,6 +5499,8 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  							  devfn);
>  			if (dev) {
>  				ret = upi_fill_topology(dev, upi, idx);
> +				pci_dev_put(dev);
> +				dev = NULL;
>  				if (ret)
>  					goto err;
>  			}

Thanks for fixing this issue, but it looks this issue has been fixed by
this patch
https://lore.kernel.org/all/20260602144908.263680-4-zide.chen@intel.com/. :)



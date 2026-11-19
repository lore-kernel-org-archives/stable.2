Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066472;
	b=bTbtcGOldRZKo3Rl6UCeonvA8EbshuP0OJ0yQ6H1k1yhJZP6H/N8cZfS3+hjRHFqD7yR
	 hcT29HvewG9+l+F9U+bB80VtusKHi0+AgYy0TZ0ob7CxMWSbd1zJdwEd0EtAseIyfKWCc
	 ajUj6kofw0PEahfsQlvh8X6gsGHqBx3ZJPQd4yLp2UQqRGFHdI//+2RxvbKtQ0r5IeZrp
	 ozQZXI/BIUEerXMnt8FgyyG/JmI9BmnxzX/2KLl2JqN8HFoVwl0GmcojK18iDhH3CEY0q
	 XR2OiD/k5NPwgHJC6e3MG6hv269EoSgB+9udN9o06q4FVZaS9qdV8v0UWjZynlX9YBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066472;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=sUm28NBEI8QdUcbAWjXVqOi6TtcynrsGNpW9kOPR6sU=;
	b=dN4piOP2B2+KpIJ00mud+mZVxzCWa9JbtqQ2ZvQp+CSqkNXliBPACU+JZ8zyhGG8qkKV
	 q/KipL/4rjHHe6X6C7TqQbOmCk1rh0FbFPCSPh4CuQ0J86WT/9tWNVouLwFAzvgwl9XxP
	 EyuoyH/HrVunrad2lHwSr2LrWtTMMvABjvOaszl07FZml1SDFKB6hK4h1xwGBlv0X7OMH
	 kadMwMBJ5hgtxGvtdT/KhsmizIO1gcPDopxmo9lfml+ZozUNkXXF7qFOa20/8uEnBmTkT
	 iB0D6hsbDVHSaasahjGt+nz8r7MUKsh3POSdFw6gS8vii15xqHJvApU2kXi+BDer2hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="XE+/yYfZ";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F31606A320;
	Thu, 19 Nov 2026 05:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F31606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XE+/yYfZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795066472; x=1826602472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTsTW4kEMQr4QBUjx2DW6amdx7ltkLl3V/OgbUtLJGc=;
  b=XE+/yYfZjalEdTPTRvXMyt7cUf1TElDEvFUVsdky7FuZ5OqlOXqTQ5c7
   APJV1gov8RdMbxb2LjPsvOPb+ForI/Yg7bGD440iLIjaFSDS8vj5tKV/D
   3cIIJgKKlaiF4XPe6FAyDR+3+j1SJwqQ9FQc57XepVBFkqmRPlWrP2Ufc
   Un6J8CZ+xzD7lpSmEChNa6qaNUzJQXifRZpMhiR8QLhpUnAZIum/xikT0
   pxOsUAVSxfgy4fo8ySwZnnCggx2Vvq56ZXfHrNkD0HjP9Sq/F5SWrd/DQ
   R1WBEXkT8TCFbbKil0WqRzwS+zUGYYsb4UNg95FwjT3lcQjp/5ccLfNka
   A==;
X-CSE-ConnectionGUID: 3zrGYlNIQH+tY7e6ZisQFg==
X-CSE-MsgGUID: ZXelbqMETTanlhr2WYk7nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3787124"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3787124"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:34:31 -0800
X-CSE-ConnectionGUID: cSLNnqkWTieyxgNhn9/JRw==
X-CSE-MsgGUID: EZkk9YSRTRKpwDi2+3z9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10231899"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:34:31 -0800
Date: Wed, 18 Nov 2026 21:42:30 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: jez@sfcompute.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andrew James <ajames@sfcompute.com>,
	John Ranzie <jranzie@sfcompute.com>
Subject: Re: [PATCH 1/2] thermal: intel: hfi: Disable HFI on shutdown and
 kexec
Message-ID: <20261119054230.GB7495@ranerica-svr.sc.intel.com>
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
 <20261028-hfi-kexec-v1-1-956234dcfb2b@sfcompute.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-hfi-kexec-v1-1-956234dcfb2b@sfcompute.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Oct 28, 2026 at 12:14:45AM +0000, Jez Ng via B4 Relay wrote:
> From: Jez Ng <jez@sfcompute.com>

[ ... ]
  
> +static void hfi_syscore_shutdown(void *data)
> +{
> +	struct hfi_instance *hfi_instance;
> +	int i;
> +
> +	/*
> +	 * Hardware keeps writing to the HFI table after a kexec, into memory
> +	 * that the next kernel owns. Disable HFI in every package, and keep it
> +	 * disabled: user space runs until machine_shutdown() stops the other
> +	 * CPUs, and kexec enables CPU hotplug again, so a new thermal netlink
> +	 * client or a CPU coming online could otherwise enable it.
> +	 */
> +	mutex_lock(&hfi_instance_lock);
> +	hfi_shutdown_done = true;
> +	for (i = 0; i < max_hfi_instances; i++) {
> +		hfi_instance = &hfi_instances[i];
> +		if (cpumask_empty(hfi_instance->cpus))
> +			continue;
> +
> +		smp_call_function_single(cpumask_any(hfi_instance->cpus),
> +					 hfi_shutdown_instance, hfi_instance, true);
> +	}
> +	mutex_unlock(&hfi_instance_lock);

Using guard(mutex)(&hfi_instance_lock) would read more simply here.
However, this patch is tagged for stable, and kernels older than v6.5,
such as 6.1, do not have guard(). It is probably better to leave it as
is.

I tested this patch once on a Panther Lake-H client system (one
package, 16 CPUs), together with patch 2. With a thermal netlink client
subscribed, a kexec left HW_FEEDBACK_CONFIG at 0 in the new kernel.

Reviewed-by: Ricardo Neri ricardo.neri-calderon@linux.intel.com
Tested-by: Ricardo Neri ricardo.neri-calderon@linux.intel.com

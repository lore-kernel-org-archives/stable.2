Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16F3E833E;
	Tue, 18 Aug 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053966; cv=none; b=JhAuKIX1dKFbBl1/DDqr70vKyd3Bv9hEyKB/gpkETeEL5JUXyVTBD+pcQVdJBiL7qb8e+qIg42hPgxez+tObDpuen8UzXThJpe/4xDGP9frM4/I80HMckPcM8FUt1uLdo4cCL0LMx5W5JJ+IZ86TniWhloenf8MSfmMmdgx/CDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053966; c=relaxed/simple;
	bh=Ow3f1qpRA2hrnhnSZ2Acc5SriPtU02W5FyWyujUmx7Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WCzctsXPrM1zgLnni1cBGjukK91R8GNg9onwqcVv8N4H7JRILmi/pXMZ9I9mE0pFyrMKF6mw0UrnTmXTBNRUgFjJnfPZh4EjSMUt7nH3sXC/J8F+LxLaBfwVX09uVXH+tnSyjs6OlY7FY84L8h8Syvwl0VgKKjfU9aQXhNNsgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSx+VBP0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSx+VBP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787053963; x=1818589963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ow3f1qpRA2hrnhnSZ2Acc5SriPtU02W5FyWyujUmx7Y=;
  b=lSx+VBP0jzUIqFo9zWXoGUMSkn70TzBW7LO3QgX/4yjOHNvb5LtKBxQ6
   hFe9aR588A9gaKUhNls/4GNMS29RuUsEWqy3EwdYuamINMhGdlOLwVnbn
   eW7mj2nLUkIQV0HU081gQ7ZJfILhZ+5aOFIC3UX3HyiCDsHpq3XJfMEDK
   PmSBas1pp/yaUVMbE2hHrmxG2r7VU4MiFllawvN99hN/2oorEEFBJBhCi
   Z5n/JCu7pDohdkPBFDnKaStIxcq+mhRix5VNw3Tm1HFZjtTtPWxqzYi4V
   bgBgE5y2t0kAQQdGAoCncMKrGOclRLozxlNz4iG+YYRSjGiAaA5URbVbM
   w==;
X-CSE-ConnectionGUID: MhR3YSQzRB+6GluxpsPhZQ==
X-CSE-MsgGUID: sEawKmUrRkaIh0p3mdDcDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="99064002"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="99064002"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 04:52:42 -0700
X-CSE-ConnectionGUID: RlPeevTlRcOT9kNa8i9Rwg==
X-CSE-MsgGUID: okHSi8d3R6K/laWEnfgo1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261923665"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 04:52:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Aug 2026 14:52:36 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/9] platform/x86: hp-bioscfg: fix off-by-one heap
 OOB write in audit_log_entries_show
In-Reply-To: <20260812111829.172273-6-meatuni001@gmail.com>
Message-ID: <52ade3a2-d703-6707-2136-172c0ad6a7da@linux.intel.com>
References: <20260812111829.172273-1-meatuni001@gmail.com> <20260812111829.172273-6-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Aug 2026, Muhammad Bilal wrote:

> The per-iteration guard in audit_log_entries_show() is:
> 
> 	if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE)
> 		break;
> 	...
> 	memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> 	buf += LOG_ENTRY_SIZE;

Hi,

What about the preceeding check:

	if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
                return -EIO;

Is the second check dead code or how can you get i large enough for it 
to ever be useful?

> At i == 256 (PAGE_SIZE / LOG_ENTRY_SIZE), LOG_ENTRY_SIZE * i equals
> PAGE_SIZE exactly, which is not ">" PAGE_SIZE, so the loop does not
> break and instead writes another LOG_ENTRY_SIZE (16) bytes starting at
> offset 4096 of the page-sized sysfs output buffer, one entry past its
> end.
> 
> This needs the BIOS to report more than 256 audit log entries, which
> already exceeds this driver's own documented LOG_MAX_ENTRIES of 254,
> so it requires a non-compliant or corrupted firmware value rather than
> the roughly 85 million entries an unrelated integer-overflow read of
> this code might suggest.
> 
> Fix by checking the bound against the offset the write is about to
> reach, (i + 1), instead of the offset already written.
> 
> Fixes: 63e8f906e94e ("platform/x86: hp-bioscfg: surestart-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> index b57e42f29282..6b63fdb84606 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> @@ -90,7 +90,7 @@ static ssize_t audit_log_entries_show(struct kobject *kobj,
>  					   HPWMI_SURESTART,
>  					   audit_log_buffer, 1, 128);
>  
> -		if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
> +		if (ret < 0 || (LOG_ENTRY_SIZE * (i + 1)) > PAGE_SIZE) {
>  			/*
>  			 * Encountered a failure while reading
>  			 * individual logs. Only a partial list of

Since this block uses break, the following else is unnecessary and should 
be removed in a separate patch.

-- 
 i.


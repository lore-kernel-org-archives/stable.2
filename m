Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3463DCD9C;
	Mon,  1 Jun 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338966; cv=none; b=uftnow93J6lsWiTeFH4J4vcV4SQfLrHrho58eP9wuVOWPbx7NViZd29dQH0MwOKDpFDbIydBqteEKePLv9eSLzb2OeN3enRCDBGPu26DtpyN9/kQBStfBHrPEqW+3TnEFofet8tZUouKNjjKKRH9egh83SUwQeY9ROetG3/R5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338966; c=relaxed/simple;
	bh=jenn7I20NCdJlbj10XSmpXB6s906sLiVHK08GuoeAl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CinsxBMI9VP7Sd5mvsZReUebbxjWG8ZdHmZDfCAsB5mpl2ilCgw6gaRFYCwmaUbxsvy2AB9qRbyeJ2B1tJd1QTHarHwfoK1ZdSPizkpvkMise4wWxZ/J4amETxa+6Yf2M/BCUd+TFGeR4I0ILgJ9m8mMqfByJOjoBfNkjKE3OsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pq5t7mS0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pq5t7mS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780338965; x=1811874965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jenn7I20NCdJlbj10XSmpXB6s906sLiVHK08GuoeAl8=;
  b=Pq5t7mS0tqBz4Qg6C9MXOvLIQdEyU5t9QSHQr/rpfaRkhIYgoAw2Fb3i
   W8SkkH0HxwRcu89xrwU/RLfqtGdhBoaSkovBvLJDT8wa3bVQPvwPNhfd1
   913umI5KueYRBZqO+Js2FUJc4+mROHCpq5VRyrUGpv3B+e6C096fKsvmG
   EyRtrLTH64Sl3l/BzQkLCegwcXyXhg9Mmo7jDXSK0VqgPOkYUZkwrc3ZK
   qum8UiFashdPxhJYI1SgEfckYL3MmIWtQftqipJsd73xlDBKMEtCBP/Ij
   B8fdF+2BgDeGqH9UPrDoAIJYhl/5q4TsRqrxXppG9iHdD9k+nWG8Qks6W
   Q==;
X-CSE-ConnectionGUID: XU5ieRbpSBm69xc8TisEwg==
X-CSE-MsgGUID: oqLywgQyQ7qRUVOS/m1lMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91677933"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="91677933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:36:04 -0700
X-CSE-ConnectionGUID: zIG4o9SVR/uVdLmPR84CeA==
X-CSE-MsgGUID: 4uKTD85oSjyhqPJl1Ypsmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="241146782"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:36:02 -0700
Date: Mon, 1 Jun 2026 21:36:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
Message-ID: <ah3REJeg8KMB694A@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
 <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
 <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 29, 2026 at 11:21:40AM +0300, Matti Vaittinen wrote:
> On 22/05/2026 15:38, Matti Vaittinen wrote:
> > On 20/05/2026 14:08, Jonathan Cameron wrote:
> > > On Tue, 19 May 2026 08:48:13 +0300
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> +#ifdef TEST_FORCE_IRQ_NONE
> +       /* HACK, return IRQ_NONE and see if IRQ gets disabled */
> +       if (!(first2 % 1000))
> +               pr_info("Hack, return IRQ_NONE (%lu th)\n", first2);

Hint: pr_info_ratelimited() seems better?

> +       first2++;
> +
> +       return IRQ_NONE;
> +#else
>         return IRQ_HANDLED;
> +#endif

-- 
With Best Regards,
Andy Shevchenko



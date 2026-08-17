Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CE3F8EBE;
	Mon, 17 Aug 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980226; cv=none; b=Lm5ZDGtvXAY+e6txGUTRZgoMfoPhlH4sBiqXshqZr3RU1JzXtE02r+bWNyfHYSDYK8i5tkG4VC9zSEukjgqWOb5aJAIKSjBj51LQgLS1DkhFD9fQT+3/W9CMXSQtYdjVgI+JX7bdpRWEkj9qs7yQAhDLmJIzz+B8euijvNsgpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980226; c=relaxed/simple;
	bh=msl28pOI/fIME2wOC1gRmqujU8+8NPSO78hDxF33EKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6XF1sJyR5c+eACvCGKA+yXO56lSsD4YY6Vt8Km9wOh0xIp5dlfjcX7k2Gavam8y6fIsWo0TUqf/+WCiDSBZJt6Uc5h8ymuQmOOpx+DKLDW4zoURP4JQXGtL4YRo9kN+X2fz65+IRfe/2ST7buioLRqe1yzwG7IahkmsdOcRueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTJFx4d9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTJFx4d9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786980224; x=1818516224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=msl28pOI/fIME2wOC1gRmqujU8+8NPSO78hDxF33EKM=;
  b=WTJFx4d94Xt5SocJ+XOvsPYbkIzIJqug7jmi9pS+sTNSlNTmi1JntZcI
   4Q80EEmXR8jy3tkpSHZERVpkNob17atpIPOI2KsEWuMwF2O/dtFcOfA5r
   W1KMnLo0GNTItMQlSShtHXltquP8Priuxc549j0xk18RB8XQSHC3ylE03
   y8XPecwqRt4EGNCRedUgPJsHavpQR4Ywd5+wgBNSpq2VRECjUncpXyEXm
   abQhqTsFnm9A8zi0j0oky/jS/CLDUZ35TGAnHteB94VPWp8jF5JSFyLYK
   j6Ib/u11jQ8xuk8he673hlRDGOVqCbsz7JdBZW9aC2yBnIZ3ocEXRtRPv
   Q==;
X-CSE-ConnectionGUID: 3QTYP/McSaimCAj6dnsX6A==
X-CSE-MsgGUID: eJC78q/MSZ2UetkjxabJ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="74989006"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="74989006"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:23:43 -0700
X-CSE-ConnectionGUID: wBEASFEzQSuiNDwVEiCcow==
X-CSE-MsgGUID: YZhT4dB2R96XbM/i3gQ2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="264486862"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:23:42 -0700
Date: Mon, 17 Aug 2026 18:23:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Xu Yang <xu.yang_2@nxp.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers: base: test: Depend on OF instead of selecting it
Message-ID: <aoMnevcLHdUEZr9-@ashevche-desk.local>
References: <20260817-driver-pe-v1-1-7003ddb9e400@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-driver-pe-v1-1-7003ddb9e400@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 11:54:44AM +0000, Ricardo Ribalda wrote:
> Selecting OF instead of depending on it makes it impossible to
> disable OF when KUNIT_ALL_TESTS is selected.
> 
> The purpose of KUNIT_ALL_TESTS is to test everything with satisfied
> dependencies, not to force dependencies.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Shouldn't we also handle this in tools/testing/kunit/configs/all_tests.config?
(maybe in the future).

-- 
With Best Regards,
Andy Shevchenko



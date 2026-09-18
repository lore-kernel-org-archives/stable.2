Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838C5C613;
	Fri, 18 Sep 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713514; cv=none; b=A/4qeuVjqvCtUlHrmVPe5dNvn0MYxU+mGkMqWf0vuLpa7rhCTI/a7WXSEcfJjCFyhynNJ8ZR6mXOIDmrkrMlHJt9n48lXPsaL0Ws/6F8gSmvd/egz0Z9ULNqUtnRF07f+KN5+hsqM5lAxPVxx7s00V3GO056/baNsFOhB9Jljbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713514; c=relaxed/simple;
	bh=L9bvzIPM+ftK2bxDWRtS5jd/RgMKrldKEwiztXhRBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxMjRZGmYnVUMnwvKGxMpImDbA9kDdKQ76pK7XGER6BhM1R4nsOQkrXHrbxHavBelAsgbs5c3piejX1DcjvXOyI/i/1sNlHXkUD2XKHq0j1texgDelqVM78jx2/v/5MTBZ0O6xmCM3B9QGCKGE/OLsN+iVAVB+FqnFtGCreXb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TncbaiR6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TncbaiR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789713512; x=1821249512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9bvzIPM+ftK2bxDWRtS5jd/RgMKrldKEwiztXhRBqA=;
  b=TncbaiR6o2E0XC19all3o+N8MhLwQ4DxYdXodXt/zNciIg7aE9xQRpJ7
   aBDCk+GANTkCrkl6Re1WC0Nb5X8Y/d8xnXwYeVoiORFFpjB+Zj535AX4y
   Zs2j3jmHtqKp7tSJfqSn4PPq6tGIH0Mz2SD07OGCMz+B0zygBlLyZjoeq
   OUoIWWd0z8HOSdMtja5WKulL6b7a16LALW7VJ1rvi7kNrOWNJ9WfTzpi3
   FC4YYyrIYKc6roPwH+JxUwezudo1iaHfnqykdBdUWMeJdgxICJubiMtuR
   FRBvIMfoepIkLTgyIrmIGdkFXVK3da3RM+0I+9IgourBHO4jqI507Onu+
   g==;
X-CSE-ConnectionGUID: 9xHbcQQnSXq6aZlSfNoExA==
X-CSE-MsgGUID: sFMWokhASFSryUJNrxiZ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90063035"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90063035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:38:31 -0700
X-CSE-ConnectionGUID: 16zabr9TRyyP+M/QWOEnIQ==
X-CSE-MsgGUID: bsmVT5NNRnqbrTyfZQM6Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299344374"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:38:29 -0700
Date: Fri, 18 Sep 2026 09:38:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] gpio: cdev: fix kernel stack leak to user-space in error
 path
Message-ID: <aqzcXsWQnhOprEHp@ashevche-desk.local>
References: <20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com>
 <aqwEeLLuIC1AoLQ1@ashevche-desk.local>
 <20260918032743.GA29370@rigel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918032743.GA29370@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 11:27:43AM +0800, Kent Gibson wrote:
> On Thu, Sep 17, 2026 at 06:17:12PM +0300, Andy Shevchenko wrote:
> > On Thu, Sep 17, 2026 at 04:39:05PM +0200, Bartosz Golaszewski wrote:

...

> > It might be not obvious for a reader, perhaps a short comment why it's done
> > here?
> 
> So we should always add comments highlighting initialisation of return values?
> No problem with adding one here btw, as we do it elsewhere, just
> wondering if you think this should always be the case.

Yes, when return value is initialised in case of error. We know that we are
going to return an error, why would we initialise? So, the answer here is
because we don't want to leak kernel memory to the user space. A short comment
makes sense to me.

> Hmmm, after some sleep and taking another look, what does bother me is that
> when the guard was added the behaviour of gpio_desc_to_lineinfo() changed,
> in that it can now fail, but its signature did not.
> As a consequence, lineinfo_get() and lineinfo_get_v1() now return
> empty/zeroed line info and success when the guard has failed.
> Elsewhere when the guard fails the operations return -ENODEV.
> So, while this patch no longer leaks stack, it would be better to propagate
> the failure.  That could also make the memset ordering mute, or even a
> trivial waste of CPU time, as it could prevent ANY line info being copied
> to user in the failure case.

Right, this can be done to cover all cases at once.

-- 
With Best Regards,
Andy Shevchenko



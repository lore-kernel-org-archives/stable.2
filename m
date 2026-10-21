Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565421;
	b=5Nyf3+t1tJPsstP89RbyonFpXMnJP/eDUGmXji8v8tWVoHQh3MujDkwTVv2gxEIBd6th
	 W7UgCHKNye6xUBCjS4au7a77xBuBi8Euuai9Vy/qLi/K+wvSyU/o8rUW/CU8OlkkUW2zF
	 QjBvYiXdiT6eytU/A4R5K8AQZgyccFzjByvPVMnnaIipArRt71ekQzlF9LQW/WZTWG8u+
	 rZKwZ28aknY5V4+3TZkOM2Qd4LM8YhUEE+RUScQrQPnCq7gh7rOzmPFNB0FCj0iodhDvI
	 nsMFfb6NUPSwds6PhvGmv44tfsAn6NQXdn5aEVhejfgxK5X9UiPjkEln2sCMCF/JOJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565421;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7kQE4TQnW0veqMKpVRhTHkPQx9WW9lXS7O6FX9MB2p4=;
	b=fMtmoRJ6oieauyqlvduiKVEw9j0+WB2PyDkXwkT+iuYDGC880A8IKclRhi1caXarpXAt
	 EvSw5jDMRzOUzamj6lGUg2WAzU9GdhiX6P5IyTtc/p4mrtBZI/r2BgBhrqyBgPAG6lupp
	 JdvK8M7AzfovcrpddebY/lzLbbSdMecxMLjcSM1agUsBGkM25rHLsEJ1mUSuJDQaQqkDg
	 et8JcNE7s4vFGfokhr5vQISOJpzHr0LRy6duVH0w7B8KJXJrREfiEE1u4BhYeaMP++3l7
	 bUHstQn0kJoPwh+csQbiYsJRkJ7RDFrAckyTdOg6SbLa3K8Q7Hteur9UiCNV5aWGj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dcD+wETg;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AABC606A319;
	Wed, 21 Oct 2026 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AABC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dcD+wETg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565421; x=1824101421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ACsbaDSti7txFjwPOQeTX5xC13w/ML4tO/kZtijTxCA=;
  b=dcD+wETgbvWkfBOToyrGFXaEDXCYly272NTsLdeASL9KBoePdCSROpwS
   lCRMG1UWNvBsP6d8S1QRzDsHvjuF/uFzrJijya0upwzPITJmu2EyH9gDX
   NwIQ73oEaqmLqLQIwy8qV/yvFVBJqpp8EbQ4OcXFvfUjHmS4H9c52/531
   Lrl7tqiwLZIO1druWBaBwLotF/+jVdlMnIvC7j/e2ujVMidSSjyFh7hy8
   osg/9bzKudMOPlCHthpLiISbesxuyvfrug29dFcQFVxTfem3ia9eVtY5A
   sAzQ1nCfyyCRY2DDI3t9dlwU0QryamanmCk3tFIUXJv6Xnl/q6tL6IcKo
   w==;
X-CSE-ConnectionGUID: 5HUg+ZmDT2GTpe+RBLnEnQ==
X-CSE-MsgGUID: mcolg8Y8TbmKLNcDItb1XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1295955"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1295955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:50:21 -0700
X-CSE-ConnectionGUID: x0DZkoITSMWPAoXg31+X4g==
X-CSE-MsgGUID: I50wtKsxQNG9M+/qAkC2hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3065130"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:50:17 -0700
Date: Wed, 21 Oct 2026 09:50:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: cdev: don't leak the IRQ name when the
 chip is removed
Message-ID: <athgpsDd9oIusdx8@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com>
 <atIpg2E8PeJ0oGNS@ashevche-desk.local>
 <20261020125921.2896041-7-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261020125921.2896041-7-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 03:59:24PM +0300, Adrian Ambrozewicz wrote:
> On Fri, Oct 16, 2026 at 04:41:23PM +0300, Andy Shevchenko wrote:

...

> > > struct line {
> > 
> > >  	struct linereq *req;
> > >  	unsigned int irq;
> > > +	char *irq_label;
> > 
> > Have you checked this with `pahole`? Is it good layout?
> 
> Yes, on x86_64 (with gdb's ptype /o, which reads the same debug info
> as pahole). struct line already had a 4-byte hole after irq, at offset
> 20. irq_label goes after that hole, at offset 24, so the struct grows
> by the 8 bytes of the pointer and gets no new hole.

But if you move it up, can't you get rid of the 4-byte hole?

...

> > > struct lineevent_state {
> > 
> > >  	struct gpio_desc *desc;
> > >  	u32 eflags;
> > >  	int irq;
> > > +	char *irq_label;
> > 
> > Ditto.
> 
> irq_label lands at offset 32, right after eflags and irq, so no hole
> here either.

This sounds good, thanks.

-- 
With Best Regards,
Andy Shevchenko



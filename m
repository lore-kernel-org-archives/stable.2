Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207D3A963D;
	Thu, 11 Jun 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210223; cv=none; b=kf9n6qGh9c6klJX2qVQP8loFiguKMmXWxrgOIunFR6oqJbhrX3RNXXfKgAASqOjI7FhKTBOOf3g9oCd6xMksFLW43eapFBjECmnTVUinHcnLe3CQI4LLyTD0wxQ505qPXb8KDMuqIVbVdMgUQCV7ZLxsdPOXQDTqP8OFpyfwI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210223; c=relaxed/simple;
	bh=zmuYxNoO49Z6dGqQN/+hEW9eG9UPTi7S93B8ZJn4NeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1tLNjt537tXALJPFvr1viUNnquEtF6NNstOcWyxxAQByaZQB9PSsJQeGcfum4EMvCtiwYUcYMPnJIAtBM53/tWw5PryyO9lyzVum9H+TBTax9v/9yB9dBmDqJ7S6RPkmrEi4zst7JS29fwyLVs/py4TipN/u3go7FfI8ndZDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb1rMS3q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb1rMS3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210223; x=1812746223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmuYxNoO49Z6dGqQN/+hEW9eG9UPTi7S93B8ZJn4NeE=;
  b=fb1rMS3qXC6vZqv/HaW71uiFkF/BFwfT5aBEIvVR0mXF5C8XJCVDakR6
   UOv3G4/OfaTdKu6uqr1YZRBtZSKmrX82pnGJAEvepYqbw2fM19zHALQRG
   ZA0bGq/CGtlv6tKzZdF/3Ik+rQp5zFafNyTb5vHThKFsKkas5hZtQSQOX
   P62OLY+Wyd2Xb3Ru+Qj+II4rRHLAWDILrJmI5MzFfTjeNGNcI0KuWeBtc
   Iu8pj5ZjLTxgorxk65y5fs6h32sQB3oIrUB74yhM50GBEZwUP3MwmujVx
   LZ4mc+jnp+nt2ZcLj13QREZhbHuoYNolR0S617VbRc6ZWCNTbZpG0KJmo
   g==;
X-CSE-ConnectionGUID: BRRYky2NTz2zS1P0D6THXQ==
X-CSE-MsgGUID: qRHDiYwjSmegU+V4D6G45g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69582204"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="69582204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:37:02 -0700
X-CSE-ConnectionGUID: ZV91wnH5RzScDS+Uy4+6qg==
X-CSE-MsgGUID: fAtgtQsvQAye6Wjrn18a2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="248498299"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:36:59 -0700
Date: Thu, 11 Jun 2026 23:36:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <aiscaI0B4ogb15T7@ashevche-desk.local>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
 <aiLmN2yUsqLadbSo@ashevche-desk.local>
 <aiLw0bLKiipMCZC5@ashevche-desk.local>
 <i7jdx4j4kd6dcntitqrcz74d47wfqv5iwc3zdlwx7rs7xoykql@ivj6mxr2zyva>
 <aipsAxc4j68D2YCz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aipsAxc4j68D2YCz@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 11:04:25AM +0300, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 10:41:45AM +0800, Xu Yang wrote:
> > On Fri, Jun 05, 2026 at 06:52:49PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 05, 2026 at 06:07:41PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> > > > > This series fixes two issues in the fwnode child iteration logic when
> > > > > a secondary fwnode is present.
> > > > > 
> > > > > The first issue is  a refcount imbalance in software_node_get_next_child().
> > > > > When a software node is used as a secondary fwnode, the iteration code may
> > > > > incorrectly decrement the refcount of child nodes that do not belong to the
> > > > > software node hierarchy. This results in refcount underflow and possible
> > > > > use-after-free.
> > > > > 
> > > > > The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> > > > > by improper handling of iteration state across primary and secondary fwnodes.
> > > > > When iterating over children from both primary and secondary fwnodes, the code
> > > > > may incorrectly resume iteration from the primary fwnode even when the current
> > > > > child belongs to the secondary, leading to repeated traversal and a loop.
> > > > > 
> > > > > Both issues are triggered when mixing different fwnode types through the
> > > > > secondary mechanism, and stem from incorrect assumptions about ownership
> > > > > and traversal context of child nodes.
> > > > 
> > > > > ---
> > > > > Changes in v3:
> > > > > - remove software node patch 
> > > > 
> > > > Hmm... Maybe I was unclear. My question was to investigate the way to actually
> > > > move software node to use the swnode APIs (and not fwnode ones) and be on par
> > > > with what OF code does. This series does the opposite and adds a hack to the
> > > > next_child implementation.
> > > > 
> > > > > - add a kunit test case suggested by Andy Shevchenko
> > > > 
> > > > But thanks for the test case!
> > > 
> > > I'm preparing another patch (just a clean up) and I see that your test cases
> > > indeed fail without any other patch being applied. Also noticed that the test
> > > cases are not fully compliant with the requirement of the "primary"/"secondary"
> > > fwnode flavours. But this doesn't affect the execution.
> > > 
> > > I will play more with this to understand the problem better.
> > 
> > OK. Suggestions on the fwnode flavours would be appreciated :)
> 
> I think your approach is what we should go with. I will send a v4 with my tags
> and some amendments.

I sent a v4 here:
20260611203537.1786399-1-andriy.shevchenko@linux.intel.com
Please, test and confirm it also works for you as expected.

-- 
With Best Regards,
Andy Shevchenko



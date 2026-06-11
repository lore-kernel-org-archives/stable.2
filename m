Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA27375ADD;
	Thu, 11 Jun 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165067; cv=none; b=bunH6zC2Dz+VqeeaO3wdAlQFSiK47V4pN9UZippq54Ar+xJgCvmPtucVdfoPcqQCXcZzyrWIsEA/H0H4PlvV+l3YsKZUV3e341wIfQjmS4UEliNHpedS3rjD5L4BsiN5qh8puLfdxkSb/emfk1cM9lucolRie5reypMXJ4naTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165067; c=relaxed/simple;
	bh=8I0iQXtzmbYpwaKqv7BAaOeoUpon4RYkTTw50nyXEJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoESXYLkIZvaIRm6R2LLMjEvp5LYkYjCxJznaeROYlY9K//JYBxeRSdkOL1OoV9tDC6g0yKiGcAWdbUQr3psqqriWYyuIr1TbF1746n6xLO2YyMfeNI/l8OoO3wam3NCVK1MYL8hcJTdDETboi7FB6GRt1mUOyY7Rrzgk4MncKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+2RmXCG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+2RmXCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781165067; x=1812701067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8I0iQXtzmbYpwaKqv7BAaOeoUpon4RYkTTw50nyXEJU=;
  b=i+2RmXCGTZaJ8o3aaHObNrXfItaswTuVjKOmphIJ0ORsjqPa5YoQGNVi
   TVL7Jk52VdGhWeRWhLYWkBdBE5FWXetY8HTKZusu97aSbqwXLOBCuETMf
   idKiJaLV/P3iPEJREt1anZaLcqSOc+xTcSVvOr6evfPYH3SiRk75XbOuN
   BgxMRVLeEGOFadZnnzGiOLT8qhQ91cCHXli7W5I6zbjfP/IIgQudySCIR
   /Hefu9DutUu+2w0YF9geajmn3BmZWQyZoHw4Yu9oicP3pfFVbQ33+ekMN
   8vBxY4ctJeFYvHWohd2uTCdLxGLwynup45CFc0SL4cxd/taL94cOFB/CD
   Q==;
X-CSE-ConnectionGUID: nT868B2STbGtJ9nyM5P2Kg==
X-CSE-MsgGUID: D5wY/pzHQb2UMGrJrkpxDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104639814"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="104639814"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:04:26 -0700
X-CSE-ConnectionGUID: Eweveop7Qo2lRMbNTzKlgg==
X-CSE-MsgGUID: L/M0HBSLR6yv36luZgxdqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="240068633"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:04:22 -0700
Date: Thu, 11 Jun 2026 11:04:19 +0300
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
Message-ID: <aipsAxc4j68D2YCz@ashevche-desk.local>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
 <aiLmN2yUsqLadbSo@ashevche-desk.local>
 <aiLw0bLKiipMCZC5@ashevche-desk.local>
 <i7jdx4j4kd6dcntitqrcz74d47wfqv5iwc3zdlwx7rs7xoykql@ivj6mxr2zyva>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i7jdx4j4kd6dcntitqrcz74d47wfqv5iwc3zdlwx7rs7xoykql@ivj6mxr2zyva>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 10:41:45AM +0800, Xu Yang wrote:
> On Fri, Jun 05, 2026 at 06:52:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 06:07:41PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> > > > This series fixes two issues in the fwnode child iteration logic when
> > > > a secondary fwnode is present.
> > > > 
> > > > The first issue is  a refcount imbalance in software_node_get_next_child().
> > > > When a software node is used as a secondary fwnode, the iteration code may
> > > > incorrectly decrement the refcount of child nodes that do not belong to the
> > > > software node hierarchy. This results in refcount underflow and possible
> > > > use-after-free.
> > > > 
> > > > The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> > > > by improper handling of iteration state across primary and secondary fwnodes.
> > > > When iterating over children from both primary and secondary fwnodes, the code
> > > > may incorrectly resume iteration from the primary fwnode even when the current
> > > > child belongs to the secondary, leading to repeated traversal and a loop.
> > > > 
> > > > Both issues are triggered when mixing different fwnode types through the
> > > > secondary mechanism, and stem from incorrect assumptions about ownership
> > > > and traversal context of child nodes.
> > > 
> > > > ---
> > > > Changes in v3:
> > > > - remove software node patch 
> > > 
> > > Hmm... Maybe I was unclear. My question was to investigate the way to actually
> > > move software node to use the swnode APIs (and not fwnode ones) and be on par
> > > with what OF code does. This series does the opposite and adds a hack to the
> > > next_child implementation.
> > > 
> > > > - add a kunit test case suggested by Andy Shevchenko
> > > 
> > > But thanks for the test case!
> > 
> > I'm preparing another patch (just a clean up) and I see that your test cases
> > indeed fail without any other patch being applied. Also noticed that the test
> > cases are not fully compliant with the requirement of the "primary"/"secondary"
> > fwnode flavours. But this doesn't affect the execution.
> > 
> > I will play more with this to understand the problem better.
> 
> OK. Suggestions on the fwnode flavours would be appreciated :)

I think your approach is what we should go with. I will send a v4 with my tags
and some amendments.

-- 
With Best Regards,
Andy Shevchenko



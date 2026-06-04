Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41F2F7EF4;
	Thu,  4 Jun 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595423; cv=none; b=G6i4Qa3kmmuRxBDrf/McdRQj7W7j6cdhTGigC0pShpAD28cf5OqACiqcV1XKSYSlX71tbMi4WZigdBDbyl2++tV2pSYjTo/BkqCKArdowUUszLmPDRiEbf5DP+LVdkWIbRUR96TnA3uoDsuSdLU7NYa0tOll6DyFbHeHXkM4tQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595423; c=relaxed/simple;
	bh=WjtubiHa3cJ7jMf0W6sVoi71Ivaew3vZJn4hBLnwwI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvERIRkPvX13Zsp7iT0ZEckLDQX0nheIMSfvQroFav9KytosAMMVRj01nS7Mvjcmu33crAc3oTdDG3erlGZFPWTpJ2ugKi1fgT6SNJcZOAVqWZ8LbLNv4CKnmwsLmIkWwFF8wOzeWxvWJO5m9RuF79VFLTnjW1xZZnY/enJq7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXYNdBwW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXYNdBwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780595423; x=1812131423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WjtubiHa3cJ7jMf0W6sVoi71Ivaew3vZJn4hBLnwwI8=;
  b=FXYNdBwWMh1r+0Pz5V1c30YjQsoGBV7cEpharrZ1DEdP69lrL66LSaY5
   rMQz8cVbtCWzMeH284yZKhMou56+gYGrV1euSUWIWqAjDRCG2p7hSs29m
   9Z3r6BSVYsGOTROx+1yo6DKEckOa6FKtTL8auu3MKjBRbqyYAT0xQaJ1C
   doUOIaG/IN5AsBeCHjRLuktV7UCDTwzE3Z/H+7HBuippg+fF9jDSIslCj
   hJhf6+H9Kk5bVmZaULB9zlr4pWMdEpuyRG8cK+ezVWvgPLxaPy8VDkB/m
   X0ikth8XL35wCn1GBAe7tAF1hCtSkLRyZ68bKXA2GkZEyRd2mrLeDHufK
   w==;
X-CSE-ConnectionGUID: 68zzZwbiSqq3bWgKqMXOqg==
X-CSE-MsgGUID: tnubJkp4RwadPZI8wPj31A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81172570"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81172570"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:50:22 -0700
X-CSE-ConnectionGUID: qDoW2zT0ThWDz6Bn4YwyKA==
X-CSE-MsgGUID: a/AbENlmQMCagHqmolBVOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="249529043"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:50:19 -0700
Date: Thu, 4 Jun 2026 20:50:16 +0300
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
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] software node: fix refcount leak in
 software_node_get_next_child()
Message-ID: <aiG62GXa3tYhhMBQ@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
 <ah_2i-jWq2kBRJpe@ashevche-desk.local>
 <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 07:15:26PM +0800, Xu Yang wrote:
> On Wed, Jun 03, 2026 at 12:40:27PM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:

...

> > >  	struct swnode *p = to_swnode(fwnode);
> > >  	struct swnode *c = to_swnode(child);
> > >  
> > > -	if (!p || list_empty(&p->children) ||
> > > -	    (c && list_is_last(&c->entry, &p->children))) {
> > > -		fwnode_handle_put(child);
> > 
> > Wouldn't be better to use swnode_get() / swnode_put() instead?
> > *Yes, we might need to add some NULL checks there.
> 
> It's not newly added by me. The software_node_get_next_child() has been using
> fwnode_handle_get() / fwnode_handle_put() before. In my opinion, this should
> be fine since they do the same thing here for a swnode.

It doesn't matter who added that. But according to the point of this patch
(correct me if I am wrong) is to avoid bumping or dropping reference count for
the nodes that are *not* of swnode type. Moving away from fwnode_handle_*()
loop we make the point clear.

See the of_get_next_status_child() implementation, it does *not* use
fwnode_handle_*() at all. So, making it here to use same approach should
fix your issue, no?

> > > +	if (!p || list_empty(&p->children))
> > >  		return NULL;
> > > -	}

-- 
With Best Regards,
Andy Shevchenko



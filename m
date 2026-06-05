Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88743FFFB9;
	Fri,  5 Jun 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672860; cv=none; b=hiqzkVhCqMa5LDIrip8mcxntmtuPrRkTCk2tDFDGbeXWR1fvMR4WyoVge2pejEGE3uewlzZnF0H9lW5l0/jcL1fZgXkOGiPNGGSUT7J3mAQnZLqobHFU2gjJh3nTD1mRvxfg+Rq6kQjbxkFQ9MiCnAkanJdhcNpSNYnJ1Ltd6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672860; c=relaxed/simple;
	bh=OmArnAhkQIeJyjgo9y32otIfNDJ7MZbWItZkKOm7I9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6YqdiIf7ugjCNkX3xJ0keOuuYHMy+ZrhHiJPfH2KSIwAsNQLinlvqt/yhcmRnyEtH3AVsR4VkM5Rd5xEmfjJyE2aj+ynWzNsDlAEqJ5O9dibaYz7CUsDVF67arFkaA4+55RU3F3nmp5XeaEcZfqE+4kcsBsh2XMwkutqqGEZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdEAicgy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdEAicgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780672859; x=1812208859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OmArnAhkQIeJyjgo9y32otIfNDJ7MZbWItZkKOm7I9E=;
  b=PdEAicgyRWR6bVPZNIcn1NDHiMLHkjjI2G5tiJFbJKnNpy7/hUSunYgf
   gShFDnlb1OR/bJiAGNLMHWBlFKSAcorl6FeE08Va1y4RqlO94yN4UGUBL
   A/Gnr+UKRMfnLNABVR+sZbNijlVHS1Wgegu7IZrfVpyR/BEa+VeBYzG6X
   cxJYJnbaSnSkxVwCTBLFI3FPVyPeK7SL8f95Lf2LvzbNZTjTqKmBu39dX
   gH6rcIYScOtYmgYY2g3a2MjDjfBjWPK6csvKVbtC41+6/wC19Na4RmRct
   gkoeJ7X+AtBE3H9egXGd95fGDi99UVDDjbSzzX9Xg+stS5JdrAMEXu5E8
   w==;
X-CSE-ConnectionGUID: fLn4Y/SGQjiL48QoZOIJTg==
X-CSE-MsgGUID: aU+Luc8/TIaVxmNzlvW7mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92881826"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92881826"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:20:58 -0700
X-CSE-ConnectionGUID: k9VI6hpJST+hcGFF3dbpNw==
X-CSE-MsgGUID: DtJ8HAlWSnaN/H7u6L6j+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244984658"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:20:55 -0700
Date: Fri, 5 Jun 2026 18:20:52 +0300
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
Message-ID: <aiLpVIjws1DO9l4J@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
 <ah_2i-jWq2kBRJpe@ashevche-desk.local>
 <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
 <aiG62GXa3tYhhMBQ@ashevche-desk.local>
 <6keyevnyndjeovbpiiufp7ejrtz6sfelu65evhg7odgb2tyxrf@xtmiqmko2kuo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6keyevnyndjeovbpiiufp7ejrtz6sfelu65evhg7odgb2tyxrf@xtmiqmko2kuo>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 05:16:32PM +0800, Xu Yang wrote:
> On Thu, Jun 04, 2026 at 08:50:16PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 07:15:26PM +0800, Xu Yang wrote:
> > > On Wed, Jun 03, 2026 at 12:40:27PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:

...

> > > > >  	struct swnode *p = to_swnode(fwnode);
> > > > >  	struct swnode *c = to_swnode(child);
> > > > >  
> > > > > -	if (!p || list_empty(&p->children) ||
> > > > > -	    (c && list_is_last(&c->entry, &p->children))) {
> > > > > -		fwnode_handle_put(child);
> > > > 
> > > > Wouldn't be better to use swnode_get() / swnode_put() instead?
> > > > *Yes, we might need to add some NULL checks there.
> > > 
> > > It's not newly added by me. The software_node_get_next_child() has been using
> > > fwnode_handle_get() / fwnode_handle_put() before. In my opinion, this should
> > > be fine since they do the same thing here for a swnode.
> > 
> > It doesn't matter who added that. But according to the point of this patch
> > (correct me if I am wrong) is to avoid bumping or dropping reference count for
> > the nodes that are *not* of swnode type. Moving away from fwnode_handle_*()
> > loop we make the point clear.
> 
> Yes.
> 
> > See the of_get_next_status_child() implementation, it does *not* use
> > fwnode_handle_*() at all. So, making it here to use same approach should
> > fix your issue, no?
> 
> You are right. I had also noticed this before. Actually, the difference between
> OF node and swnode is that OF node uses to_of_node() to filter out non-OF type
> fwnodes. Similarly, swnode uses to_swnode() to filter out non-swnode type fwnodes.
> So replace fwnode_handle_get() / fwnode_handle_put() with software_node_get() /
> software_node_put() does fix the issue.
> 
> When I reviewed patch #1 again, I found it already fixes the refcount leak issue
> because when it switches to the secondary fwnode, it no longer passes the primary
> child to secondary fwnode. So the patch #1 is not needed anymore. I will remove
> it in v3.

I'm lost in here. My expectation that patch 1 should fix the issue as it won't
let the fwnode_handle_*() be called against wrong type of fwnode. What did I
miss?

> > > > > +	if (!p || list_empty(&p->children))
> > > > >  		return NULL;
> > > > > -	}

-- 
With Best Regards,
Andy Shevchenko



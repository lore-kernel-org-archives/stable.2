Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933943E491;
	Wed,  3 Jun 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480317; cv=none; b=s+XgcJXFG+SCtMkCW7zhX/kChiNkqx6oI0UZgOViNhfF8JIi72hSfZkY3HafqV5bTt4qAMSDdwIyXPNTxiBoIBHytRjl1RlbgL/eT7bXMKOYLUMtHO5FxBmbDtfqhnuM7wyYthP5wxTpP2MpUlL4CnQe3NhJ7hkBnPlwdT14wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480317; c=relaxed/simple;
	bh=+yYJ9M3cWQke6Ap4V+FpaDtyY0grkOGm2ALwGnwOKas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTcAigVjpezYiLvOeGYVl9DjnwxvxYY8peSwOF7nYkzYSX2bjQLL4JYrrJde9krfFQtnpLjO0TVQgC9Q8i3sZvG4NDy5DR5r3b1o3EWLXDA+OC0HGUyC9XWoJyT9Zl/uD0lzexIKYQZXS7R7sg3iiGK0vsAcSKOnf2r29Ikp3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBrQoABV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBrQoABV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780480317; x=1812016317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+yYJ9M3cWQke6Ap4V+FpaDtyY0grkOGm2ALwGnwOKas=;
  b=gBrQoABVtqewkAAo6/6vd+nI5DjXfo8uTJmXD42lvNOl0AZGpIP8goGy
   RBI5W4RT9ASJGcwfIIkHuZB0gmoX2q/NAybQMtuM2A/d9qlsnH7AzAcV4
   8ZiN5VLAm59Lejij9Run70yiTn1dm+iXJW4RJVGDbGGDNnro0jgXGU9cO
   +i0NRHTCPv6oKszdC7hrEqPbyivlUHprrniHWAu1s5Pb6K4UQX+axcw8p
   Z7TYjcot5oS6p6feJI0evW29v/KXfMCWOILwpQdTiLLzanSJO9S4tRPpr
   OTPoZu2R5A0HHSNBZ5BX8tv90Vwm2Ch2EJqCU3R3/462bohhoDkU9Yd/O
   w==;
X-CSE-ConnectionGUID: PG9e2t9nSNqN/nzZqcKhJg==
X-CSE-MsgGUID: kNoQDS9xT1GoqVsGDrRB7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84908122"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="84908122"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:51:56 -0700
X-CSE-ConnectionGUID: mzM++ZaYRZey/cpohpjAwQ==
X-CSE-MsgGUID: f91owUDBRi6JhlqNDSkpag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="245993532"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:51:52 -0700
Date: Wed, 3 Jun 2026 12:51:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yang <xu.yang_2@oss.nxp.com>, Bartosz Golaszewski <brgl@kernel.org>
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
Subject: Re: [PATCH v2 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <ah_5NgZPc2U0_FPO@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 04:44:32PM +0800, Xu Yang wrote:

> When iterate over children of a fwnode that has a secondary fwnode,
> fwnode_get_next_child_node() can enter an infinite loop if the secondary
> fwnode has more than one child.
> 
>                        Parent        Child
>       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
>     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> 
> In this case:
> 
>  ┌─> fwnode_get_next_child_node(FWa, FWa1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
>  │
>  │   ...
>  │
>  │   fwnode_get_next_child_node(FWa, FWa3)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
>  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
>  │
>  │   fwnode_get_next_child_node(FWa, FWb1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
>  └────┘
> 
> This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> 
> The root cause is that when the current child (FWb1) belongs to the
> secondary fwnode, calling get_next_child_node() on the parimary fwnode
> incorrectly returns the first child (FWa1) again instead of NULL.
> 
> Fix this by dynamically checking the parent fwnode of the current child
> before calling get_next_child_node(). This approach follows the pattern
> established in commit b5b41ab6b0c1 ("device property: Check
> fwnode->secondary in fwnode_graph_get_next_endpoint()").

...

TBH, this code becomes twisted and complicated. Can we add some test cases to
show the problem? Also we need to add other possible combinations (somewhat
about ~5-6) of the different types of fwnode in a relationship.

-- 
With Best Regards,
Andy Shevchenko



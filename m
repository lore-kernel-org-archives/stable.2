Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588F3B7B6B;
	Fri,  5 Jun 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672063; cv=none; b=gx5cHs6rjuToWb/SX4DLxM8i4v+r7tucpHuJg1glcYmTpU0VB8cRyTSUY+PmX6f9dFB2yedd6bPwIF4J4CHfBcoxc+gS3a67RjgBam1fELiro6V4BLv8+UjU9e2yN7uJ1FSQoljAajXqlWhhxxLhXBXgsJqFdnjsUFNrt/ZQ2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672063; c=relaxed/simple;
	bh=5atTLPjnE9S852x4PJXNKcq2v1uDEWn+k9gepXfoAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTb2Ip17Za7WuNNUK+CNaIRBLwsKupaxCx/lMz8uvUuFaugVDXSqm9v7i0wAdHouDaf/EzO3P+D7BbQ6hea2IFTtVwcuRE3/zNaqGclzElWKN+lmz7TEJVT6KImirHHY4EIfpqmNQF3HQ+Go5o3131elc+KTyWvK8YYmtiTW1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aobjTqUF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aobjTqUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780672062; x=1812208062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5atTLPjnE9S852x4PJXNKcq2v1uDEWn+k9gepXfoAOg=;
  b=aobjTqUFgoxztC5SSNoX48u75lMqQsMVkXA7Pjjix+3s8Mbtj40BJ6qD
   3QRF9tm7Kn+zb1B9nUpVVDqUiUMsMutPcYg591jW4tNX7c7zmsLeLiRfh
   89qKihaYrA3hob+IFaCX9X7VVWKRsP0LlhbzuMQ9J4CYnaboh6j5ELeGq
   rb8o0ylQleuR8hEvE4MJWKW3PMQLSXb/cU+23OYCbOJRGyXMTmYyTFumS
   aObXahE3M9fmSqzhyIuqTXC6TzOJB0Z/FLzR+zIJ34i6KIrZcVJerIRkJ
   gfK1Hqd8l/aAhJxRZ6aiXOAuFKIZFQSz6k+uMzDrgivaKkTpcoWg6V2hL
   A==;
X-CSE-ConnectionGUID: D2l4m9YUT4+Dw4/F2q83Tg==
X-CSE-MsgGUID: ETCUyBnZSRC4drEbUeaqsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81539538"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81539538"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:07:42 -0700
X-CSE-ConnectionGUID: fh00xKyeQYqVjPTQXqOXZw==
X-CSE-MsgGUID: Ov4szmWHR+2Msk3Ka0oe2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="248793546"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:07:37 -0700
Date: Fri, 5 Jun 2026 18:07:35 +0300
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
Message-ID: <aiLmN2yUsqLadbSo@ashevche-desk.local>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> This series fixes two issues in the fwnode child iteration logic when
> a secondary fwnode is present.
> 
> The first issue is  a refcount imbalance in software_node_get_next_child().
> When a software node is used as a secondary fwnode, the iteration code may
> incorrectly decrement the refcount of child nodes that do not belong to the
> software node hierarchy. This results in refcount underflow and possible
> use-after-free.
> 
> The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> by improper handling of iteration state across primary and secondary fwnodes.
> When iterating over children from both primary and secondary fwnodes, the code
> may incorrectly resume iteration from the primary fwnode even when the current
> child belongs to the secondary, leading to repeated traversal and a loop.
> 
> Both issues are triggered when mixing different fwnode types through the
> secondary mechanism, and stem from incorrect assumptions about ownership
> and traversal context of child nodes.

> ---
> Changes in v3:
> - remove software node patch 

Hmm... Maybe I was unclear. My question was to investigate the way to actually
move software node to use the swnode APIs (and not fwnode ones) and be on par
with what OF code does. This series does the opposite and adds a hack to the
next_child implementation.

> - add a kunit test case suggested by Andy Shevchenko

But thanks for the test case!

-- 
With Best Regards,
Andy Shevchenko



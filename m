Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D137DE84;
	Wed,  3 Jun 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479794; cv=none; b=klh6QB4OVMHQ8modasoI4KucMNbw7owOnJ8/YbloLohVMje1JzLqA9BHmz7vZz0zLnyviprQA8pqkc3a2oShW1gsN0IMWHR0031BDWMylkQlFk4g3QgqMyMTjOxBGMmlswnGyVtmIYVgMGE+LurHwq8aTScb7f1ZZJXKPWM+uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479794; c=relaxed/simple;
	bh=8bNzNUe0EPkXw8Eq49JT2Xi8WmbBUioPJtvyT5UKnoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC8WT9ldtqSLmmHrgMibwxNrqGALRN/MgGS6u+w6w5DKA67r4KRWSI+oHi8ra2/ITmIm9Waynca8MevKlYRAIsfpaJZ3PgBkpfcE8W9Iheyrvx/1syc0pNjzMdlfFkWl61vtknim0NXsoH9PH6UeCj1omPkSmjGmjxc3hXYjt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODzwrCzE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODzwrCzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780479793; x=1812015793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8bNzNUe0EPkXw8Eq49JT2Xi8WmbBUioPJtvyT5UKnoQ=;
  b=ODzwrCzEOrJtooRpkKv7u8Zcw6WCMQQ/bswiuiu/f6BEMAOyUsoumQhL
   +Jt89ZCEGkp90gJ0xK48EZycWUqF0DyFTJxi4SWRgeZkL2c6GU7r3MMrI
   sAuWBg/ORiWc4SFjm45DwAeL0DYlrG/dGe17mlQuuwk2qs2rjh0YJKL76
   TumggA60PRs4b+wwBlhgnEbuomrxTkhJA0J/L60VHGm1odt5zcRzhXmDu
   MkJDRNcKoF3xuLv0l0ggYE3i2HHK+A0dEowwcWqiSlQsgxBgP61z4QN1v
   2l0zcFc1rCE8I2fEQmLQRT5IU+z7mYhkoa4HgdA+CnZMT/6vZPstezhQd
   A==;
X-CSE-ConnectionGUID: /y38JE0cQPmmxI36Rso8Pw==
X-CSE-MsgGUID: 7/TK8I+PQrCTbNUT+DNZhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81277216"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81277216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:43:13 -0700
X-CSE-ConnectionGUID: VHX5HPpmT/ycjHjvUH2lvw==
X-CSE-MsgGUID: TJC0/umvRtCRxm+IbeSz7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="267818157"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:43:08 -0700
Date: Wed, 3 Jun 2026 12:43:06 +0300
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
Subject: Re: [PATCH v2 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <ah_3KmASlE44X4Xw@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 04:44:30PM +0800, Xu Yang wrote:
> This series fixes two issues in the fwnode child iteration logic when
> a secondary fwnode is present.
> 
> The first patch addresses a refcount imbalance in
> software_node_get_next_child(). When a software node is used as a
> secondary fwnode, the iteration code may incorrectly decrement the
> refcount of child nodes that do not belong to the software node
> hierarchy. This results in refcount underflow and possible use-after-free.
> 
> The second patch fixes an infinite loop in
> fwnode_for_each_child_node(), caused by improper handling of iteration
> state across primary and secondary fwnodes. When iterating over children
> from both primary and secondary fwnodes, the code may incorrectly
> resume iteration from the primary fwnode even when the current child
> belongs to the secondary, leading to repeated traversal and a loop.
> 
> Both issues are triggered when mixing different fwnode types through the
> secondary mechanism, and stem from incorrect assumptions about ownership
> and traversal context of child nodes.

Please, Cc Bart who is heavily working on software nodes these days.

-- 
With Best Regards,
Andy Shevchenko



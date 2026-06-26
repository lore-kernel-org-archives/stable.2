Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7D72627;
	Fri, 26 Jun 2026 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477112; cv=none; b=ZSu73swN2Arjk9zfoqZo4dmPrpKopGBuj+qBDqq8WCWJpKPlbiKhrKtO9BtKVuglyfF8BwXfjQfYA7asBseCI2YW5K2SNxA6De+gYpPqixxDPOsbavojAawhKDv6r2Cj4HRtV+Zt+X59M0hct7DSGlin0pFf6oaKFEEQmAGeeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477112; c=relaxed/simple;
	bh=of9D+QDbplk76SptbJ/9PEF9tc3vwD6lqMoVlMFoRmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4oHYqki214eEIm0HqWuODRgc90zJo/47x9ww4ZlwHn7G8lFPPxY/dird07302lYnY7ggvPvlA38FuVlodyq/ZrVHP1ANEjHlC5G0VnzidTsKrEv6W4eJnN+grGx0oVnwbTwaaSSv9VNOJHGQdvakNvPaQOFHYWvgbuHvCx34+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deEkf0Wg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deEkf0Wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782477111; x=1814013111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=of9D+QDbplk76SptbJ/9PEF9tc3vwD6lqMoVlMFoRmY=;
  b=deEkf0WgZ/zT5CPcImZmOmE+ROc7gTOfxhuCSTrqkODhpzS3RHrB2wq6
   o2J2azB9RAnTdG7zZq3JXlzXxOaNfuYveBtdhFa4MGOeFtGoYigZT+k8r
   ncUO97aAZ9/D0cxMgKEorLBianm3dwPnigT4xTVSEyXkFicN1O9QlwI0G
   VuZqOcCFGdOAxo/+3JszrEKf+eBIFvoGbgFofCMDP1LRLJhw1Quc05k7J
   4GqewgNyizU9hjDYKyM5NeNvBKjOgqq89n1vGKDc+ZzxvdRD7thLaCqdN
   7hWpnwl6oy9eHj/B0N98m8CcpJkywvQI+FRaoSgZM/l1wutcGUPw8lriL
   g==;
X-CSE-ConnectionGUID: 2nDGf2cBQHqV/Z4JFPFa7w==
X-CSE-MsgGUID: L9P2uTcvQtmey8JTr4WLvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93924824"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93924824"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:31:51 -0700
X-CSE-ConnectionGUID: x4OkPwIWQxSYQC+zEXBj+w==
X-CSE-MsgGUID: f4x1A97GTyWq5FhmyP+BMQ==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:31:47 -0700
Date: Fri, 26 Jun 2026 15:31:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>, Kees Cook <kees@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Mel Henning <mhenning@darkrefraction.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/2] Revert "nouveau/gsp: fix suspend/resume regression
 on r570 firmware"
Message-ID: <aj5xMVbxOlzb2fyS@ashevche-desk.local>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625231252.89684-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:10:54PM -0400, Lyude Paul wrote:
> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> 
> It turns out this looked like the right fix on some systems, but it's not -
> as this causes runtime PM to actually fail on many a laptop.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")

> Cc: <stable@vger.kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mel Henning <mhenning@darkrefraction.com>
> Cc: <stable@vger.kernel.org> # v6.19+

Two times Cc to stable.
I also recommend to move the rest of the Cc list below cutter '---' line.

Will be something like this:

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org> # v6.19+
Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
---
Cc: ...
Cc: ...
---

This will reduce the unneeded noise in the commit messages.


-- 
With Best Regards,
Andy Shevchenko



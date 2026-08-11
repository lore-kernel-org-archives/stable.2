Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886523264F1;
	Tue, 11 Aug 2026 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429272; cv=none; b=eHVEroijh+3YOWVggl/FtM7z3nfOWjFS5guBfOd2Hol72nNA9Zz444QqpU3417pnI6Gke7QqwXbY3FzbbQjCwReYw/nFar52IsuWoIQl02TcAL1+O+QMAbyQQfnIpbJSGAxxE9zjVJNJCv3Mov/RSy3PBvtsP7VoCh+1Zl26p1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429272; c=relaxed/simple;
	bh=5UNSxU/UKmAsbrdTkVA2ZhQ5W1myfYaPe7pn/5DsPmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDMLY34xTY3MhUYv+RT1HFF8BABweGG3luOVoXTBWZmzO8R7+WVQ9dJZ+ceFpXub2nqYJmxEWlAFEj8XeiP/t0l49midWQSIVsSySHiDOkOlCm6JzG4jMsmdnA7d7a8tu3Yhjor0OUufTp0qknmyX9KgG4sMRnm7Uki/q2aNk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3GyLxUt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3GyLxUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786429270; x=1817965270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UNSxU/UKmAsbrdTkVA2ZhQ5W1myfYaPe7pn/5DsPmI=;
  b=N3GyLxUtiaeBKIy+qPuO8VDd6f+UqfvdMes39AN9nTshpPrNG+TBGz9T
   HJ05Qyiks/AjY7JC86dSt8Dh3kAfDxfUq9U3cpWkSy4tFAOX1wSWHooN9
   wDWQHTWbeo9x8yBRm2lZw/ql1x2fz1BrgUTpMDikcROhLFKsI2Qk/Mo07
   BEtn8q2ftXjVgtaEEUF+s30ilFml5uDx5Xgx1hSu8XYgEIHPq3ZW+ysUG
   v4/+78UDRrxRIeQWF5f+dn7jVLCRpZ3GmFZebc9w460dtQ9EgqhwoeHS8
   pa3ML+OQHJ7zXmRwq6jzfuszs9DJWU5HHLhPmpIHJ8WP59gka7SUJ08dj
   A==;
X-CSE-ConnectionGUID: dUTFAdKSQ+iqnSBXHM1I8g==
X-CSE-MsgGUID: /X1nYZp9TKegDHKUH1ScPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86808134"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86808134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:21:10 -0700
X-CSE-ConnectionGUID: EuURLWMZTNOqHD/we2APqg==
X-CSE-MsgGUID: 0RHaYDKRQSubA2oXL8mYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="287955758"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:21:09 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 78EF011FC6D;
	Tue, 11 Aug 2026 09:21:07 +0300 (EEST)
Date: Tue, 11 Aug 2026 09:21:07 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-async: avoid deleting unlinked ASC entry on
 link error
Message-ID: <anq_U0kj6EfTN_cj@kekkonen.localdomain>
References: <660DEFF8A732CF1A+20260810095012.2213444-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660DEFF8A732CF1A+20260810095012.2213444-1-raoxu@uniontech.com>

Hi Rao,

On Mon, Aug 10, 2026 at 05:50:12PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> v4l2_async_match_notify() creates ancillary media links before adding
> asc->asc_subdev_entry to sd->asc_list.
> 
> If ancillary link creation fails, the function jumps to
> err_call_unbind while asc_subdev_entry has not been linked yet. Async
> connections are zero-allocated, so the list entry still has NULL next
> and prev pointers on this path. Calling list_del() on it can therefore
> dereference NULL instead of returning the original link creation error.
> 
> Do not delete asc_subdev_entry from err_call_unbind. There is no list
> insertion to undo on this path; the bound callback and sub-device
> registration are the operations that need to be rolled back.
> 
> Fixes: 28a1295795d8 ("media: v4l: async: Allow multiple connections between entities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Can you resend this, please? Somehow Patchwork didn't pick it up.

-- 
Regards,

Sakari Ailus

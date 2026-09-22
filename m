Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478853ED0A;
	Tue, 22 Sep 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079436; cv=none; b=kI5SFqS93BPSXQ2K7fj0ak0LTDoNNMzMGYm49y8drXxcK4B9GTJdLbYhjib1QY/anE2Xdnkct+W8MoWV61Z1Ay2VQf91mkXD9hRaaxcaBj9UaaSX0Zczc8e+LSGjUTkdBvel+/MBshf+X9K98gAG2GKCrGY1ynexIJYZS7nNj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079436; c=relaxed/simple;
	bh=rMI6B+D6SZSLJn+SA1zuRmeZYw8aPU/OrVYykgg7/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur6Xesrp2yjZ7dBC0BNHnn03Vo+A9L7Ojlqqc8KEwx55CKXoOXu5EFF/v5MWBe173QGY1+tYcdLXhhuYnULsqQtIyov2yMuB3YIqNUdkllcP+34OEHgz59WQnP/l56qj9sKRcmkLnuDPKatDcBKlQ9aX2FbxpVsKAhWPo4k2cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZ/dkR1D; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZ/dkR1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790079434; x=1821615434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMI6B+D6SZSLJn+SA1zuRmeZYw8aPU/OrVYykgg7/bA=;
  b=IZ/dkR1DbZraV/xCbOwneOwjRvd4FshaKT1Z34xVT0iyEgm6qyCCRE1+
   jHqqYisuTxHqCwr3PmqDSMWXSjtdq21Gkw/lbkdvt3cXu7sghAy85qdzB
   NPs7ZnYCgDFXre1aOJ/NjVt0wLMSkW+NT3aQ+JO99I9uw/ndCBkt+HQwX
   0T3UgibrwVBy5sxvksZFchbzyxIg5U+7Hb2eUYfFyjynif5R3BGCbLByb
   CMNPcPvSYIfKEMSa8+2df4KMDq7EnniaoktJkr+K2Izxmcag1mL9fctHX
   gJkx8Par9bSuM62B6V+Hh6Y1JWzrRZynA/VYbVy+HN7JoND44XiPyfPg4
   w==;
X-CSE-ConnectionGUID: dhZDtFPSSsKeIUX5r8xdeg==
X-CSE-MsgGUID: /uNBnPYdQgOI/xQPgLjSLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90697888"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90697888"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:17:13 -0700
X-CSE-ConnectionGUID: 3d26ICrWTM6w/w3d6setew==
X-CSE-MsgGUID: cuipcsZ0SGim99igoxD8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272603919"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 05:17:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 63BFD99; Tue, 22 Sep 2026 14:17:07 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:17:07 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Get the connector fwnode based on reg
 value
Message-ID: <arJxwyOeMuSUc4HV@black.igk.intel.com>
References: <20260916042808.2879079-1-prashanth.k@oss.qualcomm.com>
 <aq0B1fbrqk5_ppsv@black.igk.intel.com>
 <81666138-d6b4-460d-90fa-3b372e9da99c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81666138-d6b4-460d-90fa-3b372e9da99c@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 03:03:55PM +0530, Prashanth K wrote:
> 
> 
> On 9/18/2026 2:48 PM, Heikki Krogerus wrote:
> > On Wed, Sep 16, 2026 at 09:58:08AM +0530, Prashanth K wrote:
> >> ucsi_find_fwnode() currently maps UCSI connectors to Device tree
> >> connector nodes based on the order in which connector child nodes
> >> are described in DT.
> >>
> >> This can fail because the ordering of child nodes isn't guaranteed
> >> in Device-tree. For example, DTB may contain connector@1 before
> >> connector@0, causing connector numbers to be associated with the wrong
> >> fwnode. As a result, role switch and Type-C notifications can be
> >> delivered to the wrong remote endpoints.
> >>
> >> Fix this by using the "reg" property of each connector to match
> >> its corresponding fwnode. While at it, if the reg property isn't
> >> present, then fall back to the old method.
> >>
> >> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> > 
> > That commit does not yet include any kind of support for DT.
> > 
> 
> I understand DT wasn't added at the point where this commit was
> authored. But this is the base commit where the bug was introduced,
> that's why I added it in fixes tag. Do you have any other suggestion ?
> 
> The patch simply distinguishes connectors with and without <reg>
> property and uses different logics, hence it should work for all targets.

Fair enough.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

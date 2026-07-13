Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554F3BF66D;
	Mon, 13 Jul 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933206; cv=none; b=PbS7LyVJIA0L51LcNITVZg+GPTIIxVZ0e30iEs9l505E7Ux8R/3cXfebxwiUhzkhYZHYF5FqJfAyn1QcDziGRRew07jhzmNjGENjjRxb4IkhHxuKQ6sCFzX5fB9fRfl9cG4sAxMQGeoVaxqAAWgdZyPdFdzAEzTs4UY23ZxlQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933206; c=relaxed/simple;
	bh=UuziIpDu90kRuOD7/BOwxh2+So0PzZ6qVPJ5csO42uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce5rxoW0U/17nIkHPBk4M0ypMEO6yU89jRefJhIl7e2rQD5gxwBvr1dfVoVOmVRc+jhGWvE8Xyt7ZpJSM/0B+jtQyCj1jXX0wY5rIUZB7cwVMAOu/kHq3Vkt2dOJ05cDwfhZ+eYChEKRWkYpp/IL7QVYUBJxL1PDYUpWl5K7r98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTg2yDqU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTg2yDqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783933205; x=1815469205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UuziIpDu90kRuOD7/BOwxh2+So0PzZ6qVPJ5csO42uA=;
  b=UTg2yDqU+GwnisYCSy4BW4j7qTPZ9ny9DFnPw5ckbL/tSrC83S/37bRP
   zCCKs38h1PdxqtgPYsTz75LSyPxg49VAPOHW7DxD68j7ZWHCwVfYDQo5c
   n/aLt4gV9Rj20mJvjCixG8XThFCxGYoZxLiPMa6vsdbd+ZrFZ6FOlIuMu
   7o38gTq9LynZ2pxdu46eSKdM4hj7s3yo98Ia9uFBf02agTrGU8JHa3pgP
   L9wJLfrJqJdOYskwwB207YrzE9kJO3g8TZlDmMN1232A6949AbmaMjLyt
   Up/Fbzg8ZfDrC5752puQF2QBYxn/LfTIl0OhxZymiuxKkgWDnOFGv8tSX
   g==;
X-CSE-ConnectionGUID: bzn/dBNnQQ2TzAFceAaKjw==
X-CSE-MsgGUID: tNTNPBTNS6yDvlnvpfxGYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84416122"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84416122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:00:04 -0700
X-CSE-ConnectionGUID: SONFLOagREuCQH2CVMlSAw==
X-CSE-MsgGUID: BeKHladpTIOjpCNEL1MGnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259074510"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2026 02:00:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B5EB495; Mon, 13 Jul 2026 11:00:01 +0200 (CEST)
Date: Mon, 13 Jul 2026 12:00:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/usb/typec/altmodes: dp_altmode_probe:
 missing typec_altmode_put_plug on error path
Message-ID: <alSpEMgcTJx398UG@kuha>
References: <20260627034143.59224-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627034143.59224-1-vulab@iscas.ac.cn>

Hi,

I hate complain about trivial things, but the subject line has a bit
too much information. You have to improve it.

Please take a look at how the previous commits were written. My
suggestion is that you change it to, for example,
        "usb: typec: displayport: Fix a plug altmode leak"
or
        "usb: typec: displayport: Add missing typec_altmode_put_plug call"

Thanks,

On Sat, Jun 27, 2026 at 11:41:43AM +0800, WenTao Liang kirjoitti:
> In dp_altmode_probe(), typec_altmode_get_plug() acquires a reference on
> plug. When the data role check fails (TYPEC_HOST check), the function
> returns -EPROTO without calling typec_altmode_put_plug(plug), leaking the
> plug reference. Other error paths (ENODEV, ENOMEM) correctly release the
> reference.
> 
> Add typec_altmode_put_plug(plug) before returning on the EPROTO error
> path to fix the leak.
> 
> Cc: stable@vger.kernel.org
> Fixes: 41294342fad7 ("usb: typec: altmodes/displayport: do not enter mode if port is the UFP")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

-- 
heikki

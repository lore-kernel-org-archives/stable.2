Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D105326C0;
	Tue, 22 Sep 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075152; cv=none; b=u2c2g7zltvTnvGZM/0TyRiSp6421Pft+dOXnXgAuYdLwZM/5P4iEJUbsIZffcbe7LHL1LeoWrwBUVybk9Z95noTl9zpFczjKICkKSF1xO11e6gESVSAoYWGKxRWxve5kQyPRnQDW3ZvDfQGvky+6aSGOEllxbifsGDP9LX16N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075152; c=relaxed/simple;
	bh=vV34eP6bm9T5Z+5yq/BOI+DgHf66pJwOrOlm2cfh2uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THjWWPCefX7sOV8a//PhZybui38j+tGSFSD7pZc/H01lPdo4pEBzR66PH4TlSIYOiW+mnYPkVyn8emwUWuwJ4joXO/49OSRP4cHdGwqB9TwnLom1oFM3cJg9Qsf2hhjSBhj2qiiP2dMovnuhQVMYiHhlA5ZajaGeXTLJxpSoCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWL/iqNJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWL/iqNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790075151; x=1821611151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vV34eP6bm9T5Z+5yq/BOI+DgHf66pJwOrOlm2cfh2uk=;
  b=gWL/iqNJYWMqspXJsc8u0VIoYlt27TqhsFNFLu6yEDxx43GyAw24GX4P
   uc4/ZItdOzU8LIpkwjcXVmEb3Tf4tqrdUURE2uDHB6IeyEhjZzWs201xu
   NAGuDPuNy7SCdX1iToZB7OsHl2s3aCyySHT/lWdKcSQFsvpOnvhuf0GTl
   MDfslLILqjtnAxcZvONG+DiVtOUi00Y2+VIvYV8OzSHQUTP/S0W0UILFk
   zVfw8Oo/cJ/BAVU67bb8wa439MciT16Wb7+RYOfndFlnkp9DqhYHkWw6S
   5nqxLPgb0HSId5knADtpJuOtDd+LFyFnH31VL298hcDHOrS+yuipEuPeg
   g==;
X-CSE-ConnectionGUID: bfHnUs0SSpW53M0c1Ki99g==
X-CSE-MsgGUID: rp8Nxo9BQ9eCpp5FkCfiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116190197"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="116190197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:05:41 -0700
X-CSE-ConnectionGUID: +4GedhJQTeihT3XqW17Scg==
X-CSE-MsgGUID: wed8DS20ScyjBCG8KRMkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="269607111"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 22 Sep 2026 04:05:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id CA67399; Tue, 22 Sep 2026 13:05:36 +0200 (CEST)
Date: Tue, 22 Sep 2026 13:05:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] usb: typec: mux: ps883x: disable USB4 on
 incomplete USB4 platforms
Message-ID: <arJhAGzIxGpIhAfC@black.igk.intel.com>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
 <aq0ENUZzJYKZ6V9f@black.igk.intel.com>
 <35f0856d-2f39-4a03-b056-fa22b1e56589@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f0856d-2f39-4a03-b056-fa22b1e56589@oldschoolsolutions.biz>

On Fri, Sep 18, 2026 at 04:38:36PM +0200, Jens Glathe wrote:
> HI Heikki,
> 
> On 9/18/26 11:28, Heikki Krogerus wrote:
> > On Mon, Sep 14, 2026 at 08:05:03AM +0200, Jens Glathe via B4 Relay wrote:
> > > From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > > 
> [...]
> > > stays inside the kernel and can be removed later without creating ABI.
> > > 
> > > Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapati@oss.qualcomm.com
> > What's the purpose of that link?
> > 
> > I think you want to make a reference to the commit 0c8ee850572b ("usb:
> > typec: ucsi: Add UCSI_USB4_IMPLIES_USB quirk for X1E80100"), right?
> > 
> > Is this meant to fix that commit? If so, then please use a proper
> > "Fixes: 0c8ee850572b ("usb: typec: ucsi: Add UCSI_USB4_IMPLIES_USB
> > quirk for X1E80100")" tag.
> 
> Hmm its not a fixes tag. It is a residual of the thinking process that
> prompted me to go looking what goes wrong. So its semi-related. Since you
> acked v3 with the link in (thanks!), do you want a v4 without the link?

Yes.

Thanks,

-- 
heikki

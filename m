Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013158;
	b=APuuvKWy/fCxvLrNXPJByqXlme7hFDi4o8+kFY8cfaFuNDKOdWLb7tYJCg+suUoItZRh
	 l+ASstVIaDISKZ8AUF0Lp6y41QOqK4QeOt263G0njUQtwkO03IyFcEofNCHFJuUKvbpY9
	 gFOl1YclA7aT0cl0sd1l0CXXh8+zb9yOsKKPVnGGfqBTzJo0XkvZBvdY0zEaQiAb4veoG
	 V02fsY2ncRkl9DWFiLuj2540u9IYWPN50GVQQPRwBjn44WrfRDk7gPTLfJGBtBzuIEUGT
	 ZZQqWScS/vaQtxG8rI4WhrtZQldl4/SWbnCeeUIxVg+TodboAZ5dyZnEhr/IXtMOVlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=awi9M7IT8Ic4AtvdFdMv1w+M3I6RyURIykEhjn0ByU0=;
	b=Gki4uqMhQXwsqY0j07ZakBfbg9gEdk7DKbXJoJdwFNfPIYsvBEGhu5JPYOmUqJG/a7w8
	 fHzhW2Dv2f41nnQt4BgE8Afqu+Zr7Vf1SEwBmQEB8b8GuDkw+acTJskLZS+0y8Uhdpc9d
	 ov/3JxMCe42gZaNg/Nacv6x8F6+aZ5Ezo/JG9HbFPRfyaO7Aib6yR5/yNUSKDpox6b6yV
	 ZbaJ8CMTthf9t/jehK53N9BpiD0OQUYdaas+jxQwqrw3jSdEEUwZoNl/Osvm7Wuxt1b3m
	 uUOoB+rYFA9ld0ioxlds0qIJsFAbsJc6BHn5bwkyhpWIWxsiu2xcXlfyG2M2Lu6tTnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="lNnTqK/g";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DB606A31A;
	Mon, 26 Oct 2026 11:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 605DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lNnTqK/g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793013157; x=1824549157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ha2HzH6ORm+RxJtnLaMjfjb5ZYTVlXBbvlXlQvs0LGg=;
  b=lNnTqK/gNupNFY0nwX52+rtHjLXbYbdApys+a0I43plfnigmv83rp+E/
   O4eQMgTy18b06NIAWZjcZ5OTmkTgAwEJgDYc5BxklvrM7/v/ZgORqDMtQ
   hxinGCsxW1mILDwv0S/i4np0BTS3ukW50slQvYfW94qVHXwT1Q3amUeS6
   yhmyK9aabjncPpr/PpHXmKXoZ08C2VRYaPb4MZQ8aWPZQvUD/4W9vTgHl
   BmFITbcsP2NUStWGnEsBWXZLp8CYIAFXvd1dS75tfkPxA2x11W+z4r8yE
   6fXm8twShxey3RgLmkb3Bv06DptYsdKgIy26USXzKSIcvGtcXTKqi1hOh
   w==;
X-CSE-ConnectionGUID: Hpc49/HjTg2VioYYQ3VUUQ==
X-CSE-MsgGUID: 9Y4xcgUJRCuAUjTnWeqVSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1584355"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1584355"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:12:36 -0700
X-CSE-ConnectionGUID: aD3ZJxFaS76hIgw4W1BCAw==
X-CSE-MsgGUID: NGuyxjBtQc6sgslpq2Yr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4347917"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 26 Oct 2026 04:12:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5F5AC99; Mon, 26 Oct 2026 12:12:34 +0100 (CET)
Date: Mon, 26 Oct 2026 12:12:34 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Iv=E1n?= Rodriguez <ivanrwcm25@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fan Wu <fanwu01@zju.edu.cn>, Wei Huang <huangwei@kylinos.cn>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: acpi: fix use-after-free on driver
 removal
Message-ID: <at81op42aJC5NwNq@black.igk.intel.com>
References: <20260903030356.58597-1-ivanrwcm25@gmail.com>
 <20260903232121.271776-1-ivanrwcm25@gmail.com>
 <ap6mHnPJKKJFapsO@black.igk.intel.com>
 <CAO4EdiSv-hqc4WMoTa9F-ODs+TCzDG8ZEmAvx0z55wGhLdFJCA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO4EdiSv-hqc4WMoTa9F-ODs+TCzDG8ZEmAvx0z55wGhLdFJCA@mail.gmail.com>

On Tue, Sep 22, 2026 at 07:56:58PM -0700, Iván Rodriguez wrote:
> Hi,
> 
> Little ping on this patch. It has received RB tags from Wei Huang and
> Heikki Krogerus, and I don't believe there are any outstanding
> comments.
> 
> Please let me know if anything else is needed from my side.

Resend this. Don't send it as a reply. Start a new thread.

Thanks,

-- 
heikki

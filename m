Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EB4570E4;
	Tue,  4 Aug 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833922; cv=none; b=OeRA+qLADO6NgnGSIVS+ebJbJtm0iTNX9T+Kc5gJpmYg51QD9648xj/ihMMTr9sdCSct97cfFdJhB1SbdFhyfrfwYXW+mWPoDTC4dEjrYXMxw0Rq4LnTCoaM56nwnhmuMN+przmtDp6OlUzeqb7hdMBaUrkUlLTJ+tqeL2T8ZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833922; c=relaxed/simple;
	bh=b/DuuSsvmuVlVPKJOLHepnTtFA0rRYDllpQumRKUE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0BESuLFSSC5knG3rIXEs924hTQKkbCscZeIB2o3To2N7xYUGb+wRvIAkWAQXMMVldnmF3Zp2ppbvv3rYB2XNGxjy5H6t3MjQLoH1HtZwq7ozfRS2ouaA54gtm9+0s/bvuQFGKWiQBzROxYH+iuTEYkBtoCRfnZOO9pbSXXjNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol9u3KU+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol9u3KU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785833921; x=1817369921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b/DuuSsvmuVlVPKJOLHepnTtFA0rRYDllpQumRKUE84=;
  b=Ol9u3KU+c65SN6qg3s4QSogps+saH/j+gZTPo79uy0/unQSFo+3N0uCm
   ArIuhOfjM9oRMEubAWIKgs8E22ub3PmQ1LtWXBfgMuDK926DkGS98m7dI
   5gNGCCHnZKNsC3btOAwZDcVlQrLoYya3TWGHI9cIg7lxoi0C8IFq2IuR1
   n4bN4eRcW7dQ4PoQl2GJqkRSpQm9gh1MNuJZ7IvhI5J7lJbb2MRV7Cu24
   jZySfb7KYb0UyrogwdQ63LQf1Ew4jV8FCpWzuQTr5uJnaEkLCBx6/qNK6
   1Bn6PFw5ZTMhBdaMBe22ddz22DVzmv6TJhvxCm26cDRLgtc/IWB1mUIZ/
   A==;
X-CSE-ConnectionGUID: sEwXaHqiTF+vywzwegzrcw==
X-CSE-MsgGUID: zeTiZcTFQ/6pviVBQBL0/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86390006"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86390006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:58:38 -0700
X-CSE-ConnectionGUID: KSkW1hF3SkiMvUK3Z3y95A==
X-CSE-MsgGUID: MgL4lDeeSlS8X4ZxLl7ISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="257123845"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.141])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:55:33 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7C633121197;
	Tue, 04 Aug 2026 11:55:37 +0300 (EEST)
Date: Tue, 4 Aug 2026 11:55:37 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Antti Laakso <antti.laakso@linux.intel.com>
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>, israel.a.cepeda.lopez@intel.com,
	hansg@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usbio: check ibuf_len against rxbuf_len in
 bulk msg
Message-ID: <anGpCYRxnqtxWonR@kekkonen.localdomain>
References: <20260722101810.458634-1-yijiangshan@kylinos.cn>
 <amtDubB1yNk1JGXG@alaakso-desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amtDubB1yNk1JGXG@alaakso-desk>

On Thu, Jul 30, 2026 at 03:29:45PM +0300, Antti Laakso wrote:
> On Wed, Jul 22, 2026 at 06:18:10PM +0800, Jiangshan Yi wrote:
> > ibuf_len is the bulk IN (receive) buffer size, but the EMSGSIZE check
> > in usbio_bulk_msg() compares it against txbuf_len — the bulk OUT
> > endpoint size.  Both are taken independently from different endpoints
> > in usbio_probe(), so the check is wrong when they differ.
> > 
> > Use rxbuf_len for the IN direction.  This matches the buffer that
> > actually holds the response data.
> > 
> > Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> > ---
> >  drivers/usb/misc/usbio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
> > index 3c2474dca810..fe093e7760d5 100644
> > --- a/drivers/usb/misc/usbio.c
> > +++ b/drivers/usb/misc/usbio.c
> > @@ -265,7 +265,7 @@ int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
> >  	lockdep_assert_held(&usbio->bulk_mutex);
> >  
> >  	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
> > -	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
> > +	    (ibuf_len > (usbio->rxbuf_len - sizeof(*bpkt))))
> >  		return -EMSGSIZE;
> >  
> >  	if (ibuf_len)
> 
> Tested-by: Antti Laakso <antti.laakso@linux.intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

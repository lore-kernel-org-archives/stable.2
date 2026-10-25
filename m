Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962457;
	b=wxZq4SL/TY9GWQSIgtAgLzuaijvOrS8eXruw2dQXvgGPP784SW1bWYynHMwpX6f6L1oG
	 7BPv+QtLVE9jL278qLs8ayuDCJbcW8610O7vFy4ScZswobGalbub3EG54TT28WGyvSkg7
	 k778xdOUWlX2DTPSKEL96hKuOID6HvuTWrcuaOcvj7Vl+r1eo4aNsFNob0EM/ctO39tSv
	 SzjZ6GH4njJi+KvLx+O+GFlmNHXOdT1SSugePOmYQLsQ7dqZprThdVkGb4cGHy8IhNKSW
	 9sJy5PBZ9pRojo0sdLzJdIw72z09kvazUgSTY5aCxOOXL3iqkkVVyyu5gvMhjYlW5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962457;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oQ1jy5NHZSKUkQZrbFs9Md2chhaAL2EFHqeXKzzHcug=;
	b=J+JYvLXizBSf3/wCTQMYsOMwrpMg1CGO7Pr8RtNcGuSszXidBOXL3AA3wFJO4YFZ+43f
	 4WtiQCFRzX6Sv/Gb+9UnA+EqQtyviQIABEfvjLRG6gCeCR2vHtrR0WNBpGQ6GIjwJPxTp
	 2lOCK9XVOcbJHDdp9NjT1O+MpS0BfWSWgXE3rrsGaRCG8nnSH6Tt3Ub2dp3oQJUeytebj
	 Cf7owvKnkmcRp2JDFlZ3dliihY01H43TaczVYeZvCAXE2MSZYstCZ5pSIMLPvrr/t1r67
	 uj6FQqOk/AFiy7kGnxE0t6OGVd2ZBFGSF4wb/xJtT7izOWy3enBzeptSIMHwb+/77VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MnQWIUyj;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E8606A31A;
	Sun, 25 Oct 2026 21:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 430E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MnQWIUyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792962456; x=1824498456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ddWQxm6Atu+dpnsKbez0pegjNrnEQpsq06K3nYaoOOs=;
  b=MnQWIUyjyVWPoJ14cc1uo+QsRNZuWXSUZExjbI8ncoJwTVh3fN7l3t77
   /9trM23NRUwBW4ilNLalC/KzaIre/BcxUpiZjhCR3siQX+fit41ImgWwn
   CvKDGP7ZHXgBsyRGl5LMjRi4zY1M/Lgh+w6a6A0zMB4GFn9WiLOs7Faqk
   JPArFl5X6lQyuUQBrzG1mQ4dqwnoBYMfM/KJ5GiV0xHKFGfDsktJXCxAj
   mBtxwNcdiNf5zGzmv9ZYLnpGGgMvGvfCX98D19gSUPnttLqcGfIwwTasT
   WI9qs7iQKGfOmH5qTrA9vDUL9wvfxVGGncMv+3XjCDBu/iatjWNQYuuVW
   w==;
X-CSE-ConnectionGUID: 0sLYVXVLR7+5J76z5Mkp6A==
X-CSE-MsgGUID: pBZgMK/CSRyrMD/QwP7QDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1514109"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1514109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:07:35 -0700
X-CSE-ConnectionGUID: sgMveGRQTQOhuTPzd0cSRw==
X-CSE-MsgGUID: qQ9NNatxSFWhJWZNFvpeNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4496870"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:07:32 -0700
Date: Sun, 25 Oct 2026 23:07:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <at5vkvXrFNw-0xxq@ashevche-desk.local>
References: <20261024214423.865635-1-devnexen@gmail.com>
 <at5ogu8JaXFbQpHg@ashevche-desk.local>
 <CA+XhMqx5jusLqo8G2XCY9gy_P=3-jAwTacgzrR4XFyjpagi8dA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqx5jusLqo8G2XCY9gy_P=3-jAwTacgzrR4XFyjpagi8dA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 08:50:16PM +0000, David CARLIER wrote:
> On Sun, 25 Oct 2026 at 20:37, Andy Shevchenko <andriy.shevchenko@intel.com>
> wrote:
> > On Sat, Oct 24, 2026 at 10:44:23PM +0100, David Carlier wrote:

...

> > >       case IIO_CHAN_INFO_RAW:
> > > +             if (val < 0 || val >= BIT(data->chip_features->resolution))
> >
> > If resolution is 32, this will suck. (Yes, this is a bit theoretical case.)
> >
> 
> Hmm true.
> 
> > > +                     return -EINVAL;
> >
> > Not sure about this error code. Do other IIO drivers use same in the
> > similar situation?
> 
> Yes other drivers for every out-of-range check IIO_CHAN_INFO_RAW.

No doubts. But I asked a different question. Can you answer it?

-- 
With Best Regards,
Andy Shevchenko



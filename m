Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963535;
	b=J0Aar18L/rgBLYq2Tutq9kbIgceN2pQ1ZFTZM8iQ0GOjmEKt/566PgHD9RfUIDx1AgYT
	 fAn7aavszjbXtqgeTFZAR9uPaKvLXSr7d2uJH1lAahslfXBmC9tKKDZSY8frw7w+aXu9+
	 riiZb1V6dbaTxUvDwWRablYaBAvvEX4DcwKQsb0G4I2QhZtu1vhhdDWyw8/d+o7d1jg3w
	 lzCqne8C49K+e17If5HZUWYgangUISINbccUGuzRRIlb8teydBcAsd/JKvnX0KuFA7Hs0
	 CMaGGBAJl4mGTSIUkAX7PCeWYx7BDMSoqM9/0XIAb7cCd0B2uK6IVQ6SA6D0dEi5wLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=t+BqxG3HVAhoGJrM70de7f096CHmRv9KEclC9Qj+gN8=;
	b=1DkYzgfCEU8r3yAY67kJ3w6KxvrvcY5llzV+T5Jf2jmRKKmQ/TdCwdjABhFTbzDgb0YF
	 32S/OKJccD8ZphFRCuMeITlRdO57yVNfpguKIEQzFS988Z0LJ07yIaGknUYQQ3COqJMpZ
	 mpzbzgKZMZ6imEHru4rxq9iC5BQx2Mfa6Qa+7e5ezShnokKokb8qgbR8ZW3vdC71Jp6DJ
	 EzqDnX1rK41cyt+eTbAhDHA8eQtxsGliLJG62zm/rkvEeMOOpIPAMe1/fwGcy3GX2WUgS
	 /T84+zATH0s317E69RhCSoWsRibKKzU5u0UVt+xyeTzgoXWop0qLldou3nx+8C5LQvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zu9cvyLb;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025E606A31A;
	Sun, 25 Oct 2026 21:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D025E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zu9cvyLb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792963534; x=1824499534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83xQ812e9QnDEp/bpxz3IoBuNXtilkJbm2j+50bJfvw=;
  b=Zu9cvyLbKuSqkX+hx1d7VjsEMREW72inlcw9u71wOmeGwsmGaQj7yloB
   Kab75GKvpwTEMNnNYTkm05QUNpbMtyJLpSzdroT1GWJLg7qqobIwLp+KM
   cmYDXTJ7MUvUM2bBaEBlXtYGKiueVv8PU8ij1OSoRrldzhSL2ZbmNZX8m
   Nyzz4GEva6OQapOr5tYi99ScQHDb3Rlz7dyM0cA4yj5K68AerukoWKkQ6
   cbOUB+T4+iQrY7Eb61P9S1CvU36/D+kLwSzt/hqh4HdXkwuM1U7Nqgr7S
   TefSgtD3iTAkoJIzHADTI/E12d5OaS7kk5rbar2Po/QFVvXj1uK+F4ZXA
   g==;
X-CSE-ConnectionGUID: lux6lmiQSSifmWw5Qjd7bA==
X-CSE-MsgGUID: JYLOEmGoS32CSBfI4bXQkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1535769"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1535769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:25:33 -0700
X-CSE-ConnectionGUID: hVurh8aYSreJIMi1XleQbw==
X-CSE-MsgGUID: kNdkUle1TN2IvX2H4ppgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4498849"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:25:31 -0700
Date: Sun, 25 Oct 2026 23:25:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <at5zx4M5Hj5qms3s@ashevche-desk.local>
References: <20261024214423.865635-1-devnexen@gmail.com>
 <at5ogu8JaXFbQpHg@ashevche-desk.local>
 <CA+XhMqx5jusLqo8G2XCY9gy_P=3-jAwTacgzrR4XFyjpagi8dA@mail.gmail.com>
 <at5vkvXrFNw-0xxq@ashevche-desk.local>
 <CA+XhMqzZZyN80nP2ER3jyTsM9UC2xMRLiqdCsAtp+K=hDbqtQg@mail.gmail.com>
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
In-Reply-To: <CA+XhMqzZZyN80nP2ER3jyTsM9UC2xMRLiqdCsAtp+K=hDbqtQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 09:11:16PM +0000, David CARLIER wrote:
> On Sun, 25 Oct 2026 at 21:07, Andy Shevchenko <andriy.shevchenko@intel.com>
> wrote:
> > On Sun, Oct 25, 2026 at 08:50:16PM +0000, David CARLIER wrote:
> > > On Sun, 25 Oct 2026 at 20:37, Andy Shevchenko <andriy.shevchenko@intel.com>
> > > wrote:
> > > > On Sat, Oct 24, 2026 at 10:44:23PM +0100, David Carlier wrote:

...

> > > > > +                     return -EINVAL;
> > > >
> > > > Not sure about this error code. Do other IIO drivers use same in the
> > > > similar situation?
> > >
> > > Yes other drivers for every out-of-range check IIO_CHAN_INFO_RAW.
> >
> > No doubts. But I asked a different question. Can you answer it?
> 
> I meant in this case the other drivers -EINVAL.

OK, thanks for confirming!

-- 
With Best Regards,
Andy Shevchenko



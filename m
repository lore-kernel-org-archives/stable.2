Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572534825C1;
	Mon, 19 Oct 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399914; cv=none; b=pdAM1VJO96z13PKYLGJ6U6uGnMRzN0FHmj2C6CXdHM6+4NtcLmo9j+6MFlYPqNTpT0/TIr6QlOe9OeYmBmenfsJ9L1W0yyep9VTLrf8yTuatDuxTzu8Unlvm6MZT/0vpgr+vhQ4/BygA7tpN49d79Cki/SOO96yG2nvDNzUBK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399914; c=relaxed/simple;
	bh=dB75+XosuaesEMSkBOPHFQEz+haY5wzpgajQQdAYqXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnbKLMm+4vhMUqMwweGNgt+euqWXitQXcTjsl1XKqaYfwPQxgOoF0oZnuJ2DAFJzUMA5Bdw2yr6OmjW0Mol5stnP5NoxNj4J2NR7rRt0d6/lxdv5vDId0cOaJzi1YHWo+YItYf3y519UTIf45k/zKlzhE4ZYRONVvXjB5c0p3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjBH+2eN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjBH+2eN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399913; x=1823935913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dB75+XosuaesEMSkBOPHFQEz+haY5wzpgajQQdAYqXM=;
  b=MjBH+2eNxeyGFQNTGI0sqNeC+swD2mZ1YuAKs8NnOxbDvYURYmXxpmO/
   UtcVi0G6UyKson8869Nm6FqKCUHrzsvpwoORcMMhsGM1ntMjHgUZVfdaV
   gBuNWH9kyKi8urXn0a1ONxFTRUY7Y3o0cDA+CqVazv9lWPt/n66NqYguw
   artZanYFbLuZy57BQ2XIwiNqPRpD42sEcaExelWItpKnVi0KH9QE0CO5L
   TsOpJDj1LvZw/97Xt9PsavUl9dzkqG/hOfa/WV5lM+1MgQYdltobhucvf
   NXKbt2gQJSwoR4D4BmoypjkTN02UfaQfeXWscbs+LsYWNFO0qc/PGt6Un
   A==;
X-CSE-ConnectionGUID: ln0DU+ptRV+LLwsi50ksxg==
X-CSE-MsgGUID: +uWbpCewS8avHPNkWI4HuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="957938"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="957938"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:51:53 -0700
X-CSE-ConnectionGUID: fRcld3oVRamN5fqSUbpIew==
X-CSE-MsgGUID: 13NPNy1fSZG8yTCM4b4jbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2542725"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:51:50 -0700
Date: Mon, 19 Oct 2026 11:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dingisoul <dingiso.kernel@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: add missing trigger cleanup
Message-ID: <atXaJLb3Tr7ECfUn@ashevche-desk.local>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
 <20261017192151.15986386@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017192151.15986386@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 17, 2026 at 07:21:51PM +0100, Jonathan Cameron wrote:
> On Sat, 17 Oct 2026 07:19:19 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > This series fixes an ignored error return value that causes the device
> > to behave in a weird polling state and a subsequent use-after-free bug
> > reported by Dingisoul.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Not sure where signing off on cover letters came from. There is no need
> as they don't form part of the permanent git record so DCO doesn't apply.

It may. I often use `b4 shazam` for the series, and cover letter become
a content of the merge-commit in such a case, so I'm fully for SoB of
the cover letters.

> Series looks fine to me but given others have been actively responding
> to previous versions I'll leave it a while to pick up some tags.

-- 
With Best Regards,
Andy Shevchenko



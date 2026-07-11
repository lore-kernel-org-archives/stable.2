Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B337A821;
	Sat, 11 Jul 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758636; cv=none; b=kvPcbGsonhm7wtUBIo0ob+ABqu7OuIkFvdmCi529pZunJ2InbgDPK0htyyQni6GUdyhyT4vKMxZOvS+RC0+xmPCMOebusrPyiSQ7RtTpGB9qVQU+nlKuw743Jv/spF2cPW7EM0xO5hCXsyxnoyTyQ22bskh/ak7NJAl97NrnMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758636; c=relaxed/simple;
	bh=i2U+zAgesSnqNI6vmnD2mvPH0KzXdQ3VKUIhAkuYBgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJTzRxMzUNOVzhOkXpKe+QfR9Mlcj9IDWyyI6PAmTEfWh12g0fv276Xy4sIRYUQAr9rX9cVUqzWjdvYekYpiAHmy6Aqsyn2/lIBdXUD/QHkgCYj4R5Sr37WI++Ds0eEu/ebie4De6nRGlEnEY5zzOXRAKkt1MC19GrrrOpGY5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZZg9X02; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZZg9X02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783758634; x=1815294634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2U+zAgesSnqNI6vmnD2mvPH0KzXdQ3VKUIhAkuYBgI=;
  b=ZZZg9X02WZFNr/bbOU9DY3i/YRL4ImuU+LJLoe/Wvuh1wk/97NtFbeTy
   UPwU0ZIYPW7qbsuCtCbw6dYjF2qfvRoscqUDShnYPoaz92X/LIMw8Z0/o
   QKpQikkf/wI7tcBY7yBTulaKcrkMeN7W9bQhia+L1uYA6sewA8HMoMdnD
   GlaPNCSq1sa2HZEwcVqZLiv8zvTAHcqYyWdc27C2NqhJU72jDRxus9MrI
   +NKRaN4x+oFcvs/l/3R+ZKsEsKuFkxES0oUNGXqpd0ndMNDXm9Ym4SqmG
   sk3zTebIdM1kfNh7mRjiKjBFhzUawn/QZyx3DsRYrOjtmqzkdfS3KtuQG
   w==;
X-CSE-ConnectionGUID: RVbr14SETiySHcmqZLY5fw==
X-CSE-MsgGUID: I4GgZSQPRKuepmbxIGIffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88129119"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88129119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:30:34 -0700
X-CSE-ConnectionGUID: +M6bVKBgRQGw/doFPsPE8A==
X-CSE-MsgGUID: bLtXORdfSSCsZm+NGtjpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253963603"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:30:32 -0700
Date: Sat, 11 Jul 2026 11:30:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Message-ID: <alH_JR1MbGCJxsv3@ashevche-desk.local>
References: <CAMyXUJm4CHm6cX5s+0=MabQJUA7hve1UMzf-MaaJPMvf4XCWEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMyXUJm4CHm6cX5s+0=MabQJUA7hve1UMzf-MaaJPMvf4XCWEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 11, 2026 at 08:25:58AM +0545, Laxman Acharya Padhya wrote:
> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.

> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing
> functionality")

Actually the tags are supposed to be "one (full) tag per line". In the second
message it seems incorrectly wrapped.

Also see my reply to the other email of yours.

-- 
With Best Regards,
Andy Shevchenko



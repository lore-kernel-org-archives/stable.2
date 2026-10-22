Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687996;
	b=ltkCK2WlffWQrha7Wj1EsVHbC6r5BXLIRBAPJM9qm9ZfWOCVO1xUoh5p6kJKLZ+sg2nZ
	 orvAq39aZifuOg5ifB306e7MQ9+dElPag9miUvZYXiAPBoSgkEb5VLjtKa9mj5X1yIOLt
	 jm1aaXeoQ8b/UjrwmQ44j5fsv0QGxsgTCVEWrwnocrdoV1fKtxKYfhuohIlcB0Re+RPyE
	 vI0mrhL73bOWQxqaHoGnrWAnPcXfT4mwXl6X1ofktZZq9kn7GDAnK7DN5Pho5bNq/qacB
	 Ba7O6OtALhXjn92f8S6+b5iWkSht+KGbCxwn31p52nZ6iccGWXWbNbWLfZtY6vQAO0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687996;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RnjTwDdPL27OkjVG+9TQeoWZzi+3hlrocYUpqRLD/jM=;
	b=2PdNycjv6TTljQFiNyhDxAYAMy1rsM9HhzKS3EH2+gEVGZMfIFEP8Pud+2kwsybAVk8A
	 GNpgAkeBckfzmhS7FPw2DQSI4TDgdBChVt/e7g8m6Z69zWSPRxbwo3/AQO7pcpDvKv7xC
	 ly0wIN7/dvEqLJxaTkSC3UdAFFx+0nK8zELi1yqkwKsVtG9ZXBwsC4wcDyA7u4Ij06sGW
	 qn6ae95Ukfh81X0MOO0cOGmMzA8sIVtyaWj9gr/yDKX/xaiTpaDL7/tPbyZ9Pqe2KVC1g
	 T9OigWveE0NdNLW95a5nZbl5ZmT0QgM2KsEVrRG8sFNORNZdVqF6bjF0wYLykud4Rlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dx5Ttdm1;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866B606A31A;
	Thu, 22 Oct 2026 16:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E866B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dx5Ttdm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792687995; x=1824223995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apdNtBYS9jQOXfTQEStHFo+xPC6oHGEMoFVfhkq3zl4=;
  b=dx5Ttdm1H3T1LhAzZ2JyvQLOKAbg/2NmvHIGiw5mmNDUVpjVwwGv4sZ0
   zT3KaiwjO0QuI10tVSyqBDcBtjtLx4alU7a0J9NmMmWQDtqw7TeLs4rrw
   sb7R1HYTqkjn8AB/pngK+z3ueZIaLYK/EeNrJ3br5MiattiM5WQgR/ON+
   m7mmHBvqpg/CD8nEIrZ5z7J1NWJTlwjYldKxlccVfl4cXu3hYfSEZ7PGe
   r8a37U7UjhJYKBzn6euaMxkCR5XndSoS8ahZUH97ihI62m4NtVtJBm9eV
   kBUHGZVfxoyAUC64eWHlA1XbMuxYSSzlWnbMHylDJHb3XQ0bINQ+nVFfP
   g==;
X-CSE-ConnectionGUID: xSVZM/IYTQGZvWKxy6bN+A==
X-CSE-MsgGUID: yxQN4dhuRn+FzZxDluy4zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1456456"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1456456"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:53:14 -0700
X-CSE-ConnectionGUID: FmLqOjvvQi+F4RF4oLFx+Q==
X-CSE-MsgGUID: t6Hx7mIGQEitWksXE5gsaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3799455"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:53:12 -0700
Date: Thu, 22 Oct 2026 19:53:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: Re: [PATCH v3 1/4] iio: light: tsl2591: don't divide by zero
Message-ID: <ato_dUykpQ7__roU@ashevche-desk.local>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
 <20261022-first-patch-v3-1-b792e89a429a@mycroftmind.com>
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
In-Reply-To: <20261022-first-patch-v3-1-b792e89a429a@mycroftmind.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 01:53:57PM +0200, Jan Remes wrote:

...

> Assisted-by: LLM

Kill this tag everywhere in your patches.

-- 
With Best Regards,
Andy Shevchenko



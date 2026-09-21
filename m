Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4681ACD;
	Mon, 21 Sep 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949753; cv=none; b=HDAXzeUmjcDXr7dgUcvxH82+aUilgp7h/xljD36Xc4NnegZLs9s/UZb/fN+YSZm58B8eCf5UKITdYPRtWw9GAHV6O+GCp/gDy9k6dwdYql/E3cBV+YNsQqDWAefvKxPb+UB+/bHL4sYiDKyi2j8ahKFdwGVnru7w9etT3pC9wVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949753; c=relaxed/simple;
	bh=Clo5Q7ZKpWjMNzquRlfNeVxxiwFXRrGGSsYi03MJ1Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBT1ST2ZrPO3MxV6e7x1Totevwc3er4DtaFEBklpXkF4GunaEkHmcTKkiVBYxNuDlAU1TXMJBvRJiQ0iFG4jDnGQ4Z0/gXAM4HpBnl7ry/XzcdrBroksLhLKWjQ7qc21Af+coWe45+18wnjBXY5B54veoZQ/ZtxNufnn0nq0Mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai59kb6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai59kb6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B801F000FF;
	Mon, 21 Sep 2026 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789949751;
	bh=Z0y0iKqkoDH4ID/1W9jrSb7Dm4EYVJh0udefr0qJ8Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ai59kb6jTqkDSKs9I7Yq/ALk7AeqSUU8wxsHmwTwIlrcdvJCP9go5g98kxVIe2Fvd
	 2MyIH8vy3lh5bqmXbO3zQWHzIrlmAHRKRHV9Yz0fj7fkypOzx1vVfL/aDCgbhC1xfr
	 wj0jlnSTeArcyEVWK7iYejsUyMqNsVDEYZXEm95u+3e/PeRDY/eODxLHxzqijAEr5h
	 D9a9QJf9zr1GtWdoUu/keNbgINRCt9iJNfwz2lzSnDo3QhYQ1EwCahQfD/rr9FfL9p
	 r6We5e99qjPBjp9nfqaHyy/uwl55XOiilvXwFodUbdFj1vWM6Yb0qO6JV1hTigkcZ1
	 7b3zxdufTDUBA==
Date: Mon, 21 Sep 2026 01:15:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: stm32-adc: fix possible division by zero
 in processed channel
Message-ID: <20260921011545.138903c5@jic23-hlaptop>
In-Reply-To: <aquKpzrNNpX0gy1c@ashevche-desk.local>
References: <20260916-adc-fix-div0-v3-1-bedf027a6e7e@foss.st.com>
	<aquKpzrNNpX0gy1c@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 09:37:27 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 16, 2026 at 07:15:04PM +0200, Fabrice Gasnier wrote:
> > In case the conversion has failed or returned zero, processing *val
> > can lead to a division by zero. Need to check for errors, or converted
> > value is zero, before processing the data. In case the converted value
> > is zero, e.g. the Vrefint channel, this should be considered as invalid
> > in all cases.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the fixes-togreg branch of iio.git.
Note this may well not go upstream until next merge window.

Thanks,

Jonathan


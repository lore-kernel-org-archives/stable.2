Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160D49F11C;
	Thu, 17 Sep 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635864; cv=none; b=o3HGu9KoDQ4FpGwjxc2Kv8+VwYO2yvSzR2zRhLwhFBNnbZUdopJoDr1luXGhMM+/N6mKOG2k39KLawbEWXZbEFQsruHRyvtFhoh28NI640o9Fhz7UCVZmoEtF9eKH3TLVue+OjFiYH9yEerqKu/oqGHv7ZyTvYzAoFYSzH4nuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635864; c=relaxed/simple;
	bh=G6dHEfk8WHXToA7ldyHgGCuJdMeYP71R5eAb2G/V4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeGBdkqAThOT3PDITjqPmEs2vvTgYTyEXcwHLDZnnz7RwtDrXvjfda9eXiddM0xKoHn01Ls3sOfiCus6KC8YkR4fI3ws0wfiBxs2RU3wPNq45FG6WRXlbzpow8MAFTq4/EtTBFiFMphYZTi8JnWqQkK7dZ1UWbsCRxhazQrf5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvy17cxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvy17cxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A3D1F00893;
	Thu, 17 Sep 2026 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635862;
	bh=ymP/UhkCDKeTv08RSn1yGKVRNdel0vasRa25fRZYwr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bvy17cxb/K2XUH+dqGP0NmjCNMAAiVBzwivakSPWX/Th2aIy48brK3DCbmufBlum9
	 YaA5xZZzolhNRh9a7N/fl3c6Exf0D5VnQ6Qh51Qvyh76mRIDLlwius2TNBzVXZrgBd
	 1Fa67O8KpYCUIoi6dGc8tkCLOb4QoB01EQ/P5cpQISK29yxIkkhrxMZmIkUA79q+aA
	 lI8EiWl9ZrjvjecC3h3zKJlNr5l+7ERqQMwOVkdbVE6Av3mAI2Sy3KZ8kn1e9WGXE0
	 fMBW2jiUxpYXfpRBDQglkKgzabWKo12RbMuZKzh5NTGjYCfys4xzUPDEDHG+7WjAmF
	 alUGZ64Ro8ymA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x782V-00000006Q1d-3iaA;
	Thu, 17 Sep 2026 11:04:19 +0200
Date: Thu, 17 Sep 2026 11:04:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: usb_wwan: Fix urb leak in usb_wwan_close()
Message-ID: <aqutE84DMjEPuDT-@hovoldconsulting.com>
References: <20260916165608.2085613-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916165608.2085613-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 04:56:08PM +0000, Wentao Liang wrote:
> usb_wwan_close() drains the delayed write urbs with
> usb_get_from_anchor(), which returns the urb with a new reference
> taken. The loop only clears the busy flag of the urb and never drops
> that reference, so each drained urb keeps one reference forever and
> the urb object is not freed when usb_wwan_port_remove() later drops
> the port's own reference.
> 
> Drop the reference with usb_put_urb() once the urb has been found in
> the out_urb array by unbusy_queued_urb(), leaving the reference held
> by the port's preallocated out_urbs array.
> 
> Fixes: 79eed03e77d4 ("USB: usb_wwan: fix urb leak at shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Also looks correct, but again, how was this issue found and fixed?

Johan

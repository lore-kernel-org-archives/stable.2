Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71B363C45;
	Fri, 12 Jun 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255905; cv=none; b=PkRqrPYEY3M7xxfP1ijLr0y2vEbWBmcED5DYd6N3Yp6jQj2AgRm0dvDyiB/oYwl1mSTGu0GdUvMHZBW8rQgwsYOavVrOUAnAGo7AHdVIWZhf6ZhNIr+lPv7bGuAS388NH2731KYLP/sc0QHMqLtA+ZGFzWLjpL9QWhkq6G0COYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255905; c=relaxed/simple;
	bh=p6mLgEebamRSmFLInTmIJ8H8nKUH3M3khSkpNIeMo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKCgR+wTB/EMia2O2eEnvtT4adIBxm3kMpNxOc88dQZBXVnwnRtceZ56Bru6ZmrCU+X2+e0DHNDHuLwRstLpgMdXNvPBBgN1cHBhXUbUDoyyUAfEVBsDQJaYuCe62zSinrK4IZN4VQ80oKKa8qLi5XtPGnvDqh9qhiV0Xg/spYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNKKriFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNKKriFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516721F000E9;
	Fri, 12 Jun 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255904;
	bh=+C4NgQq6SCabqH2BMmWykUbryNnQiXiiBgq8CnIfvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oNKKriFSCHWU/6nj6/FY+Wsn/qE1UuPYL5xwMEsu9hbCAtOFk9MFnUkUpTwvaj27G
	 gPUWwE4zmNY8l4ThHGsQccuWydyXj2MKUSNrKJW0I86DFk3vn3dm4ijxea4CIFuH9X
	 4A9fvrmwbelc4d3iB5yYNcHh+6PbxydCqRbK/2FL4VF52oB0S5HKPMe9rSR/uYWRU2
	 wkihsEsQxcpPoJ/5b9D/P/SAz++9KXpk5TPcCzSykd+Ws5kgKnv1K7vzde4BX8mmrT
	 4mxsefEfFe0n2Rnhd0thsp7I3O+0hZajx/JJd4cxUPZsIpI+TW72L8DeMXSSXjsJSO
	 V+SwS6Dd9Ltbg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXy1u-00000002AFE-11eJ;
	Fri, 12 Jun 2026 11:18:22 +0200
Date: Fri, 12 Jun 2026 11:18:22 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix refcount leak in xhci_port_bw_show()
Message-ID: <aivO3rqbF6Mkjoxs@hovoldconsulting.com>
References: <20260611132120.83185-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611132120.83185-1-vulab@iscas.ac.cn>

On Thu, Jun 11, 2026 at 09:21:20PM +0800, WenTao Liang wrote:
> If xhci_port_bw_show() calls pm_runtime_get_sync() and it fails with
> a negative return value, the function returns the error directly without
> calling pm_runtime_put_sync(). This leaks the runtime PM usage count,
> preventing the device from ever suspending again.

A failure to resume to the device will generally prevent the device from
ever resuming again in itself.

> pm_runtime_get_sync() unconditionally increments dev->power.usage_count
> before calling rpm_resume(). If rpm_resume() fails, the usage count is
> not decremented — a well-known API pitfall. Add a pm_runtime_put_sync()

You are using pm_runtime_put_noidle() (as you should), not _sync().

> call on the error path to balance the reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59d50e53e070 ("usb: xhci: Add debugfs support for xHCI port bandwidth")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Again, how was this issue found?

Also, "refcount" in the summary is a bit misleading as it makes it
sounds like you're fixing a memory leak. Please use something like
"runtime pm (reference) leak" instead.

Johan

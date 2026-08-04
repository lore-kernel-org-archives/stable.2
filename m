Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5621767D;
	Tue,  4 Aug 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824784; cv=none; b=mfhwuwH4W+x0LHJHg9SxxCMGWXVIZNDMViWUpiN1XC6SHjCGf5MgsiP7hPWfnmb13asw/KQ18QMv0Kiw3gJUiXGJQZaxqPCGU6K8YZ1ms8NJ1maRPVhE+xY4xu0aLMHqriX9ypuwi3o1BBn0JouKTBlodx27exmSjzvg4RW7jrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824784; c=relaxed/simple;
	bh=c7w9zmE87QSB+Fi2WqrLag1E4Sr6WjMNT5E4OEo81hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvM6J24x3cHwURz9giaEWWpJC9n72KQCJexQPovnHFYQSFwbdcdUhPEl5PlS4B3FMBtJt06dhAX8FloSYKy9sK3AuIe4vv99lG25/7/xhb4OedyH3tWH7K6WCdcrygHPglTZBqjyJ2hEh8WEWFkRHDrJft19V4t6oFSpIHi3VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A6HsTikc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A6HsTikc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68531F000E9;
	Tue,  4 Aug 2026 06:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785824783;
	bh=u7ScsXC9B7i6Ms3pvR7Shh6wb2KMsAsSGvEVyKiqgxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A6HsTikc3UFM2sx8zRg53QccF7EnFU60iVdFXdkV7gF5PupJJ7gIzqj8v1FotzhBi
	 RThwkyrp1WQ0PiaHVIwKOtUIVkRFD544W+Ks/HWoUE1uxDbMVRPAZvMkSI2yn3BioV
	 i/BCX+6ZcSfWqOV1Tkg1cAwHT5yA6epqsGxkGDSc=
Date: Tue, 4 Aug 2026 08:24:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: fix uninitialized typec_partner_desc
 on stack
Message-ID: <2026080439-elusive-lushness-2165@gregkh>
References: <20260803171521.3381942-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803171521.3381942-1-radhey.shyam.pandey@amd.com>

On Mon, Aug 03, 2026 at 10:45:21PM +0530, Radhey Shyam Pandey wrote:
> tps6598x_connect() and cd321x_update_work() pass a stack-allocated
> typec_partner_desc to typec_register_partner() after initializing only
> usb_pd, accessory and identity.
> 
> typec_register_partner() copies attach and deattach from the descriptor
> into the partner. With those fields left unset, garbage function pointers
> may be stored and later invoked from typec_partner_link_device() when a USB
> device is linked to the port. Uninitialized pd_revision and usb_capability
> similarly leak stack data through partner sysfs.
> 
> Zero-initialize the descriptor so optional callbacks remain NULL and the
> remaining fields are zero.
> 
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> AI code scanning identified this issue; the possible call graph is shown below.

Nice, then please use an Assisted-by: tag.

thanks,

greg k-h

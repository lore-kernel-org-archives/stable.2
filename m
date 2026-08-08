Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D22941A;
	Sat,  8 Aug 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173170; cv=none; b=i2sn+zy+aJcxq4zPUaYgqXZZ21avybRvAhBN3MkqBb2q4Kb/++mZmPcm33p3GbA3rdVF70a7fHrxM01waZd+lHMmn9TQxJm6AGUe1sf20ny0wiRyyENH1mYPGIMQxDyNBURxgEU1voarYoIb+St/sxtTbIkps9PAXeh+OvnsWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173170; c=relaxed/simple;
	bh=8QmR5cV69n7w7ZQvrPYhefR0mCB3jimmYadgVsEBvig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOhYh+RrT+r/fOu9w2uCaO2BMCMkmEFogUjxHKCzC/V/ZZ5cxt71spgEZ5y8kRtEbKgos+yWBf6GtOlrQcKRzgCz01tlgt8D3bMCk0fB2yzAyJUoanFoAIxETtYSGl7mR+F2lYr3+LpiPz7V488Te5iNZs26nAyu2QQ7vPkx3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGNgrLcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGNgrLcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3108B1F000E9;
	Sat,  8 Aug 2026 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786173168;
	bh=/Tr0twj2QYdtbM/E724s3dCEesgbWT+UymFnBaiAMwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGNgrLcfgRPGqrLTrpX44PJcTXrtIzeAm+yrssOx+wW44zLBQMqC1nqK3ujyOONfw
	 3RwN/xu5WgL6IconGdOJ4YVq6oUtQUp2AJrhH0LWcpoXHryx7jTQh0ZjI2xCfZZRfZ
	 t3noMGnte3sWazfqwAO7D5rkCnIMxy6oNQ6ZS2aw=
Date: Sat, 8 Aug 2026 09:11:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tipd: fix uninitialized
 typec_partner_desc on stack
Message-ID: <2026080849-quench-earwig-f998@gregkh>
References: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>

On Fri, Aug 07, 2026 at 11:16:58PM +0530, Radhey Shyam Pandey wrote:
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
> Assisted-by: claude-mythos-preview-high
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")

Two different commits caused this issue?  Does that mean two different
commits should fix it?  How far back should this be backported?

thanks,

greg k-h

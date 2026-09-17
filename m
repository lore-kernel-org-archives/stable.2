Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9A4A2A40;
	Thu, 17 Sep 2026 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635978; cv=none; b=c1ykuSAYywvHd+T19pqPyFr5WmPOMO9LdjDs8xyug//sX0CC4G5lS+7LdmiS7tPoO8ALChnzMejzHDcbvbW7eXIcNIwvAUnJRB/cF7mr/1HRtuhD/CC5pXVdjYvGPD3bVeLo0iNCb4G4JulB5BkI35eXnkFTnzfQssl73eK0Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635978; c=relaxed/simple;
	bh=luzwTue/EyfXK0lvHQL4HqlcJiKgAv7mMv6HReCMCfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ6oEWGtLw+GVWdH0+lMWP1HeNIvueEwiJnZNYjkUQ3XpeF43kVXK4Mb68udRxpyImssWwDlExtVllr20NYIbG1AZ8ruTFcTwXAnyTVnGdEzVD2USsicQZtHm2SPbr7QJR6aiCoBOtVgBusbYx/i1Fjy3orjlYUZzJINXG79Yq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNpsQhaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNpsQhaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1479D1F0089B;
	Thu, 17 Sep 2026 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635977;
	bh=D1dzZSMQoor5WxDgmU6pkWzdLC0sKh1ZPgMCeaheCQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YNpsQhafqr1EvEeoYqrKLXsSzAsdKcCvvT7WIrFGwW0GQ2Reh0sZvwWK2gaCokx+O
	 rmL9ciujJp5WosPxdAJdtKg6vU7BNqFshxaFn2WAUx/5/et8JFN0y7td/INs6jS7sY
	 klAgBFNteIRi6UkIloaEcfhCCndyi/sMvG0ShoCl68VXdOSOK9F2YGSpn3NG7RyLBJ
	 opSgtysMZpLsHIFHIGCUSONwQMXg8l3zYGIfh4OxQccbltNDPfjFMHk6kt+mkuYogg
	 KJ+TPoeXfyFk/E+s801Y6bDfgdP7hrnE6oAr7a4Rb9FhQO7jGL4OezrbsgRaUXHix4
	 l/gHcRxqKM2aQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x784M-00000006Q3u-33pt;
	Thu, 17 Sep 2026 11:06:14 +0200
Date: Thu, 17 Sep 2026 11:06:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mjg@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] USB: usb_wwan: Fix urb leak in
 usb_wwan_submit_delayed_urbs()
Message-ID: <aquthjH6E8DQCzg1@hovoldconsulting.com>
References: <20260916165846.2085791-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916165846.2085791-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 04:58:46PM +0000, Wentao Liang wrote:
> usb_wwan_submit_delayed_urbs() takes a reference to each delayed urb
> with usb_get_from_anchor() before submitting it. The reference is
> never dropped, neither when the submission succeeds nor when it fails,
> so the submit-delayed urbs keep one reference forever and the urb
> objects are not freed when usb_wwan_port_remove() later drops the
> port's own reference. The urbs are not anchored in this path, so the
> USB core cannot drop a reference on completion either.
> 
> Drop the reference with usb_put_urb() on both the submission failure
> and the success path. The urb stays valid afterwards because the
> port's preallocated out_urbs array keeps its own reference, which
> matches how usb_wwan_write() submits the same urbs outside of
> suspend.
> 
> Fixes: 0d4561947b8d ("usb serial: Add generic USB wwan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Also looks correct, but again, how was this issue found and fixed?

Johan

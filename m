Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52F443E43;
	Wed, 16 Sep 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546145; cv=none; b=tGq75RgK437ZWCWfWvaRk6+wH5n9Xo/P7K+OVM7NHbGAIfxsMTCSs2vREWbILHfJzse+tLnV1huw6Ia4OyDvLWf9EM5OtFTZUMrUHDWXsersAInurysHIIyRu4wPPmGJ5YNmO5CIiF9QPSenY0Xdu2iioAkLBRdpn41atUngA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546145; c=relaxed/simple;
	bh=Etx9Y8OTOZ/8F4MzHeEG4MIQDoSG9ljGZS+1aM01keg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOZjyXdsfBDiwdxQxVIFUkXj7RCiCCX6s8l2DUrN+mNZ9ADD8m4EPgowU6YK7bfjszHwhTbc2LFACm+GWaxY1sbCnbKV6uAOiMCU+xlFpaSuWhLRl4VF0NMWSjuCgRoHUMBm02B0Dd0a5O/zJHPRaJSLvbPIvkJGi/qhJDOxZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca4k+47D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca4k+47D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A701F000FF;
	Wed, 16 Sep 2026 08:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546135;
	bh=NGsPUd4c4/jiwAM0z4uKJZVSAM5wKncJVyzSk3d45QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ca4k+47D8o+zL7G76OczRVJ7a2qkrBHqI1/Od4RNEPo8JwVuyHFH1drWChaxTzMVx
	 rzivByJWrrPNPjNcwUROqglLsqdxSI0Pwmt1OseLUucgoLpZ6SRxGJAcuiyqTiQHgH
	 YhCxZ8D0YfcysSM37Do7LNFweJjSI3JpPOJxaljmY9aJVkzqysWBGY7KK4f3zefMZG
	 snx5LEIMjOywY6TRK+DA37/AmXX6lVZ3X1YMjyTYXQsOX5FB995aGl+U0goeoEuPbF
	 9Rxdbw2kP1zJ5MLILiUJoPaSOnDceCxHNZQWqEYkj12JmbNv67cRA7nTXw0pl6pDsD
	 UOROGyIchJRQw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6khI-00000005w7O-3XCS;
	Wed, 16 Sep 2026 10:08:52 +0200
Date: Wed, 16 Sep 2026 10:08:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: core: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <aqpOlKtxeROh-G_s@hovoldconsulting.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915090223.1346-2-joshua.crofts1@gmail.com>

On Tue, Sep 15, 2026 at 09:02:18AM +0000, Joshua Crofts wrote:
> The fail label in usb_new_device() disables pm_runtime on failure, but
> doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.

No it does not, as the device itself is about to be freed. Sure we could
disable autosuspend again here, but it does not really matter.

You could consider balancing the runtime pm count as well, as I guess
both of these could trip up static checkers (cf. [1]).

> Add the missing pm_runtime_dont_use_autosuspend() call.
> 
> Found using Coccinelle.
> 
> Fixes: fcc4a01eb866 ("USB: use the runtime-PM autosuspend implementation")
> Cc: <stable@vger.kernel.org>

But this one should not have a Fixes tag and does not need to be
backported.

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/usb/core/hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3345b3298daf..dec6d5c49759 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2745,6 +2745,7 @@ int usb_new_device(struct usb_device *udev)
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);
> +	pm_runtime_dont_use_autosuspend(&udev->dev);
>  	pm_runtime_set_suspended(&udev->dev);
>  	return err;
>  }

Johan

[1] https://lore.kernel.org/all/aivMnTkZ-jTRH2Jy@hovoldconsulting.com/

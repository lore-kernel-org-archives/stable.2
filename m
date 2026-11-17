Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910726;
	b=Ea/m58tZZTHj6uhQR7ui4L7hGclKioaJXJKfxtQiWexqx+ZVc0nPFyYoKNyyysDF+bnh
	 xqf2fMvS9JNCO9uDdwEhXYeYJ12hETjJZOUGGeQRpxydTriO6EQv4r6ShLQaq7NLbz4Sq
	 sJfzAk983lTV9MxHsFZ59zez9Usw7jWn0DyyAEmyOF7771LfryJ7jq87PvwM4Qzp4ccb1
	 K0G0RVAlFJpEfec929myiaWaqPUexgUwV9yK5mVGMXmz+qhqnSX04TBM6YYOWU1rz9Gj/
	 xyVpS2cHOYJZKcJgpxtkJTQfhsMnu+s3cLJxB+jK7+pXqzkI7Yxa0Glcfn2p0jyEl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910726;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=A+KMP5W36d9989qmwo/N1+/FiGMgR/evvb5hza9hock=;
	b=UKxBU7qHmeSpAgwJjkSaYYprSm8qAqeni3R7YMtErpdV84253g/wt0LMd176InraJHgQ
	 hy7pJIQqHyd/jXPhz8I0hivnnyMLzPeEH0Mrn4OrSwvCH1msi2/4ISiO3KO0Yg7fYf8jV
	 9ryRUlcwsnLlvvybKVxviZgqWMRKwFu0eKRbYMoJePS2F8u0YaGGy6FOnIzDV8SxCHzjv
	 aBZOOwEYSJjm+gz/AYVSqkhdfI3Ay313HZOg71O+ChnmZfb4WPbCOJFQVoZLxsGrX2CYq
	 lV24ph+OS61AKEK8+Lu7X93DPI63IbDpYiX9eu6HgBX3nSBlsO6bhfmvjIxFfmOE9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="O3/X27Mg";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B755606A323;
	Tue, 17 Nov 2026 10:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B755606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O3/X27Mg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794910726; x=1826446726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wn7SQPPOp4A9m11PWF5ke+W3KEz3GzCrHS1msl2nmNs=;
  b=O3/X27Mgihdx/34+F7hmwtKKTbaH1rT2BsrMQ+KVLGxdOYSPhUeiVrnx
   Uy8/QbJIa3daLn/IzpSKpfRTqKH6uTWyjyGQFEbprxG86YqLtUNoSwlb5
   odsvjxNXGGIEgHo7rVS+hbKe187WByWnIG0XBb2Rvwt8iAiAKg41zU2r+
   YT/BCBGCboV+kdExVYqasqMF484/kq8qOFDeA7qzsMYIts+iOHt6MMN7p
   KD9EQazrMFnNeE1ZrLV53foIfb1x7OkOAtxUdkbB7rE1C3Dzrvq5uYVnA
   M6j/h3snJCA+iCA2tLvG6uz5EtYeSLrM1X+s8iZvE3C/HRPDvJ6fW+mml
   w==;
X-CSE-ConnectionGUID: MqN5DSalTXSelhxohQzvLA==
X-CSE-MsgGUID: TNdqAWhKR4+xHFj9v7UMFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3529047"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3529047"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:18:46 -0800
X-CSE-ConnectionGUID: gFHjx4TnSGy8/bh6+z2MXQ==
X-CSE-MsgGUID: wqnJfffpQJC34xULFxnDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9878616"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2026 02:18:43 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 9D98F99; Tue, 17 Nov 2026 11:18:42 +0100 (CET)
Date: Tue, 17 Nov 2026 11:18:42 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: hd3ss3220: disable the interrupt before
 unregistering the port
Message-ID: <avwqAvnAKoDkTggQ@black.igk.intel.com>
References: <20261112065613.34182-1-mhun512@gmail.com>
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
In-Reply-To: <20261112065613.34182-1-mhun512@gmail.com>

On Thu, Nov 12, 2026 at 01:56:13AM -0500, Myeonghun Pak wrote:
> The devm-managed IRQ remains active while hd3ss3220_remove() unregisters
> the Type-C port and releases the role switch. A cable event during unbind
> can make hd3ss3220_set_role() access either resource after release.
> 
> Disable and synchronize the IRQ before teardown, matching the existing
> polling-work cancellation. The ID pin IRQ needs no change: its GPIO and
> regulator are acquired before it, so devres releases that IRQ first.
> 
> Found by a static analysis tool under development.
> Not tested on hardware.

So why still use the managed version of the function to request the
irq? Why not just concert the driver to "normal" request_irq and
free_irq?

Thanks,

> Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> 
>  drivers/usb/typec/hd3ss3220.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 60d6de9ba339..19c5dbdc97a1 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -554,6 +554,8 @@ static void hd3ss3220_remove(struct i2c_client *client)
>  
>  	if (hd3ss3220->poll)
>  		cancel_delayed_work_sync(&hd3ss3220->output_poll_work);
> +	else
> +		disable_irq(client->irq);
>  
>  	typec_unregister_port(hd3ss3220->port);
>  	usb_role_switch_put(hd3ss3220->role_sw);
> 
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> -- 
> 2.43.0

-- 
heikki

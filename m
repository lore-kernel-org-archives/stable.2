Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2108369D55;
	Mon, 28 Sep 2026 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597886; cv=none; b=OKz5RtjbEF4v9N11Ipt3m+wm3aou/Iu3H7KWC8FeN02ZWvRqH+ieOfFOyoaV8KhxbX76l4bAYmP097Ij/tsbRpJQ0mReXVWWg6r31vgfYUJL5QMWB8Px14qEULMECp3wdOOwWYmg+OrLWP2PAodbVMIa/Ha6l8G2K+gXaJRyFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597886; c=relaxed/simple;
	bh=JQEE0XknVc0fEuMcsvBOzKGCaiHKEqByeRPYrpTX0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUJM5y3HoHkjqBgEFEDLZlDArmpWltmVy0tKTqgTZmquP6ZmaPmp6V68EaAvJsxbGfgpMt4+I/HgUTzytkL6WXaleGUH4wr4JIMRUpg8yD08COr1fmQJKMxVW5WXyZqTOqo/v+NccneFXWgfoREfDP2RUMPQ11LI0YlqEBd0204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4+SstB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4+SstB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20EC1F000FF;
	Mon, 28 Sep 2026 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597885;
	bh=HkPDpdBMAitfUwc1AOOl6sEey11003xrR1vQqpB7ctE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4+SstB21Uq3Jt1QhG3V1e9G5ahdKA77KSZjlqFh5svvUAxVCu/OSWirt/R20KNij
	 3QCy4rvFNDd7J90jmLFwmOrxHyCuf/oA+YpcJxTZnYux6II5QK4+4pZCo7jWfxphvN
	 E6xxehicPfwjUUxksa5qHLAHIdVEyfQ5vBCO326AK0TyM6off7oRz/Q1rE+lVglrZm
	 YPwSCJWwg49k7YSomTYv+VPOBC1z61SWN2DK8iAdz3ETiCtRsoooV3QLISPee6Eakq
	 rez6o7eQnVaqHW/7jcj3VhXXRlhbz0hEHu8xA1cbw2MD5o3GGIoCcZclTYPRjfiyBH
	 T+fFfEajXKjgQ==
Date: Mon, 28 Sep 2026 20:18:00 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Stop altmode work before
 unregistering ports
Message-ID: <arpa-Ps8l8LOwbbx@tzungbi-laptop>
References: <20260917204209.97699-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917204209.97699-1-mhun512@gmail.com>

On Thu, Sep 17, 2026 at 04:42:09PM -0400, Myeonghun Pak wrote:
> partner altmodes. Disabling also prevents a partner callback from
> requeueing the work while its driver is being removed. Use the common

Would the work be scheduled even if the driver is about to remove()?

> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 50a68819ceb7bbfbd888ca919d678d4c75237c26..e91bbc219c077067294935dd5602c1aec636cfa6 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -378,6 +378,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  		if (!typec->ports[i])
>  			continue;
>  
> +		cros_typec_altmodes_stop(typec->ports[i]);

Shouldn't this be called in cros_typec_unregister_port_altmodes()?

> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
...
> +void cros_typec_altmodes_stop(struct cros_typec_port *port)
> +{
> +	struct cros_typec_altmode_data *adata;
> +	int i;
> +
> +	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++) {
> +		if (!port->port_altmode[i])
> +			continue;
> +
> +		adata = typec_altmode_get_drvdata(port->port_altmode[i]);
> +		if (adata)
> +			disable_work_sync(&adata->work);

This is a driver teardown path: cancel_work_sync() should be sufficient.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E62314A9E;
	Wed, 14 Oct 2026 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953202; cv=none; b=Eb/S7eCyvaDVAQvhBwUb5CXxaTPWQ4frPio8tEsE2KGuvHBoqLoX9yGW5yzweXxS5HHzxSZmgpRDgxYfazdW/D49hK9uPXTErsBzDYkw6imCQ0fGFs6U0t+SZmuTuBEyIMO/NpfkKy5u4wq14UaZJ6u2BnL81LTEqp6nh2tn640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953202; c=relaxed/simple;
	bh=z+5ZMn3fpleuplli6InpsVoBmL1g/Reef68FDihNcic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSdF3hQK0EqupUSeckRJr5SAckDidFtqIN4OIZkpaNCOMuKK8p6It5sJhRosIuCx6outZWuKpMBDe63XDtd9+Pq6E64dkBCQjXNfXvSeNg6qQMLe3GmD/CuV+7HLVIiF2JY5TBuBl2II10NwsGbrp0716IIaBUOvLq4PL4vB3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBbywHTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBbywHTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2015A1F000FF;
	Wed, 14 Oct 2026 04:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791953200;
	bh=gfEZCA8VL6uz6TcvhscsscR7mUB9fi+NvnfvwC8x5AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LBbywHTepEkYAWh2SSkLXaLQQW52OzKD3JYyd5woPCHjKtNuJwZjLvqgjrWhmOGRO
	 9a3LxYhoF18DeV9h7OW8oMY11dRyjfyztKvIgYzxqDV0RtGlSTr6oeNNsyfTGX0Via
	 GS9U63mriIYUNYhB9M5KI7vMDflrOrR+PJlNjpsI=
Date: Wed, 14 Oct 2026 06:46:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
	hch@lst.de, axboe@kernel.dk, hare@suse.de,
	linux-kernel@vger.kernel.org, security@kernel.org,
	stable@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable
 by root only
Message-ID: <2026101434-wrist-playing-51b3@gregkh>
References: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>

On Tue, Oct 13, 2026 at 01:32:41PM -0400, Martin Belanger wrote:
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Change the mode to 0600. Writing the attributes was already limited to
> root and is not changed.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Cc: Daniel Wagner <wagi@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
> ---
>  drivers/nvme/host/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index e1e3dcfd084b..e0cb34545b97 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -864,7 +864,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(dhchap_secret, 0600,
>  	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);

DEVICE_ATTR_ADMIN_RW() perhaps?

And no need to cc: security@k.o for public patches.

thanks,

greg k-h

Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772F18DB1F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874064; cv=none; b=AuSDChrprQcADBB+EHnYxRX2GXVVZlED314EosrnaTmT5hVKDCn7Orm4KX0d36QoPMVZnbDYtcnNkjC7/MZhxrtttPjxnjG5xdDUZqugzaFywXSee7nr46lE6N3adYPunMIg7Xum5U/p0qqd7Tf2VZMT032+sXMY7ng//bYqZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874064; c=relaxed/simple;
	bh=mqDh8Taoi/5OosStcy5PCLFM6IlRW4x/WEjWfMzbF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIXkIUYThDz7UYEM8tiqOF1aRA1YQ1UJV8TmcGUP58lk8q2JBpwKvOswqQi1Ai+Q0se0o8xO8Nq+jwaj/WNUI7JZG71OjdeUwqBiKbyBDT/IUnq08rksRGd3VttuCZJXZrzdQ5uHmX+MSYGRgwShj1LRzReGYOX5oh1hWiarXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kailuf/9; arc=none smtp.client-ip=95.215.58.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kailuf/9"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mqDh8Taoi/5OosStcy5PCLFM6IlRW4x/WEjWfMzbF+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791874059; v=1; x=1792478859;
 b=Kailuf/9q2bG6WqYicwnQ+YVBXzXY9wEGzMcfX6H3w4EPpRr8/OaDT7tDjcJedZkZD+dAO9t
 +whBJOApDkGDuSLqswUqGnDCmUdxTWWfFFDp3eKcKF2GpTeUtK7z0XBDaLyDE03EceWqFdWoA+V
 QR3omZ1MsgpPBI88HlBXoLo8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 12800683dfe4e02b;
	Tue, 13 Oct 2026 06:47:39 +0000
X-Mizu-Trace-ID: 12800683dfe4e02b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 14:47:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: avoid NULL dereference after failed probe
Message-ID: <as3T_XTQtC5-S8Dq@fedora>
References: <20261012135941.78329-1-stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012135941.78329-1-stitch@zju.edu.cn>

Hi Jiacheng,
On Mon, Oct 12, 2026 at 09:59:41PM +0800, Jiacheng Xu wrote:
> device_register() reports whether device registration succeeded, not
> whether the matching driver's probe succeeded. If nsim_drv_probe()
> fails, the driver core leaves the nsim_bus_dev registered while the probe
> error path clears its driver data.
> 
> new_device_store() subsequently marks the nsim_bus_dev initialized. A
> write to its new_port or del_port attribute therefore passes the init
> check and calls nsim_drv_port_add() or nsim_drv_port_del() with no valid
> nsim_dev. Both helpers pass the NULL driver data to priv_to_devlink(),
> leading to a NULL pointer dereference.
> 
> This can be reproduced by creating a netdevsim device for which
> nsim_drv_probe() fails and then writing to the new_port or del_port
> attribute of the registered device.
> 
> Serialize the driver data check and the port operation with the device
> lock, and reject the operation with -ENODEV when no driver data is
> present. This also prevents driver unbind from freeing nsim_dev between
> the check and its use, and follows the locking used by sriov_numvfs.
> 
> Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
> ---
>  drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 41483e371f05..0ab51306ad0a 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
> -				addr_set ? eth_addr : NULL);
> +	device_lock(dev);
> +	if (!dev_get_drvdata(dev))
> +		ret = -ENODEV;
> +	else
> +		ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +					port_index, addr_set ? eth_addr : NULL);
> +	device_unlock(dev);
>  	return ret ? ret : count;
>  }
>  
> @@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> -	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
> +	device_lock(dev);
> +	if (!dev_get_drvdata(dev))
> +		ret = -ENODEV;
> +	else
> +		ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
> +					port_index);
> +	device_unlock(dev);
>  	return ret ? ret : count;
>  }
>  

I remember you had a reproducer in v1 patch
https://lore.kernel.org/netdev/42315c2c.15f85.1a01853d723.Coremail.stitch@zju.edu.cn/

In v2 we talked about try unregister the device if failed. But looks not easy.
This patch only rebase to latest net tree. But no version tag and change log.

Over all, the code change looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

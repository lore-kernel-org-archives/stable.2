Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DF223336;
	Thu, 15 Oct 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075969; cv=none; b=c1+ez2WRL+iwhjkbBZOadcBIKTIQIprTKxjlYu7y9+D5JAI2csuteuzERiXkeR+J3/Uh80YbFxw/hOkwcCi1Y6mdaw4wqRFzx5AkmU71yWclStzGqHqP1iXGor30vuMrYc4aYzU4SWXhNEATst2Q0BoonDpuIc1OExmN6Jnrxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075969; c=relaxed/simple;
	bh=WUD7ZmFpEH5pp45xghtynRttTm+KE9DanMZl0k9Dhzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPPm6xAJRzcePAISBScYhHhx/npjVE9NLlXqATaZQi6pXX2848tGyXJB8j3b7LjBg8Jciv9KC9qKa9SvFe9cZIa+BtYhwZWe92DTMiDcw33yM4QULAAidt+chLmNFoIZbCf3yopRPXxaNl/3cFhpUH6O99duCTDbGFs+Qo2TCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCSKPFoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCSKPFoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5D11F000C4;
	Thu, 15 Oct 2026 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075968;
	bh=Ei46+KxB+IHBh4EjqfXrbgGpc7y+UFCPlOwCEn9c6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iCSKPFoj/AukWTunBsDJA/3NTgkG89Hs1yjswr5NFYg/KmdSkBAgchB4Lto1NE7X/
	 Y0/JfDkPDbLHV/ReJEI029Q6/SV6FVKAcEycLHrZgyUDDIOOlvVDk9ezg/SuKlBurM
	 /xY992S/kuAMx/O5zs04x3hSnfb4UouGSsObcNF7QhzXvc7KqVgITf6m+kcWMsC4KO
	 8N3uBNosC1wVtI1QNNJJwFzKLJgQnScmBzWz3O8t+W9mD9qpXhOq8k2c277fPxT3Y3
	 fSZ+88QWZB+ylrhesoXuAaQCYdP+ZJoOSdLsngVegYEGX+xf5Sds0e/PMzOzBQ6GHu
	 DDqlPfzKzKHvA==
Date: Thu, 15 Oct 2026 15:52:43 +0100
From: Lee Jones <lee@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Mike Marciniszyn <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Message-ID: <179198456306.839288.14631216021466477145@kernel.org>
References: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
 <20261001131206.2513248-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001131206.2513248-2-alexander.sverdlin@siemens.com>
X-AI-Review-Draft: <20261001131206.2513248-2-alexander.sverdlin@siemens.com>

On Thu, 01 Oct 2026, A. Sverdlin wrote:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> When hw control is active, set_device_name() takes a reference on the
> netdev via dev_get_by_name(). The register_netdevice_notifier() failure
> path frees trigger_data without dropping it, leaking the netdev.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/20260914140045.B8F4C1F000FF@smtp.kernel.org/
> Fixes: 0316cc5629d1 ("leds: trigger: netdev: init mode if hw control already active")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v3:
> - introduced unset_device_name() as a counterpart of set_device_name()
>
>  drivers/leds/trigger/ledtrig-netdev.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 5b0132484594c..e2a6c95a0dc97 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -324,6 +324,13 @@ static int set_device_name(struct led_netdev_data *trigger_data,
>  	return 0;
>  }
>
> +static void unset_device_name(struct led_netdev_data *trigger_data)
> +{
> +	dev_put(trigger_data->net_dev);
> +	trigger_data->net_dev = NULL;
> +	trigger_data->device_name[0] = 0;
> +}

Given that both callers immediately 'kfree(trigger_data)' after calling
this, why bother clearing these at all?  Wouldn't calling 'dev_put()'
directly in 'netdev_trig_activate()' be simpler than introducing a
helper here?

> +
>  static ssize_t device_name_store(struct device *dev,
>  				 struct device_attribute *attr, const char *buf,
>  				 size_t size)
> @@ -776,8 +783,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>  	led_set_trigger_data(led_cdev, trigger_data);
>
>  	rc = register_netdevice_notifier(&trigger_data->notifier);
> -	if (rc)
> +	if (rc) {
> +		unset_device_name(trigger_data);
>  		kfree(trigger_data);
> +	}
>
>  	return rc;
>  }
> @@ -790,7 +799,7 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
>
>  	cancel_delayed_work_sync(&trigger_data->work);
>
> -	dev_put(trigger_data->net_dev);
> +	unset_device_name(trigger_data);
>
>  	kfree(trigger_data);
>  }
> -- 
> 2.55.0
>

-- 
Lee Jones

Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0938E119
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989579; cv=none; b=r8jC18wfkK/cYe3ySpRQn16SgVaP6t7Dc5CWTbC6kr4ES/9z6u0dxJlhbiwasuUFZHSK5LxDh1WPDx1S1cPTqLIiRAl3p3qrAgyKk+4GQMkwakORzxQSAk8ekWpxcqCZpLh9bEZl65tzhUZZxTeHiborv7qBpx3HXP5ftoVuruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989579; c=relaxed/simple;
	bh=e8Xi16HfWrvgPspbbKSP+C4MvdQsWoCxCU7DY5jFEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZBNQl9OmkOtp3rTPKfpmC49iQUUHDEm+4myIKQDvEjq1euuGRIweuItpSrS+HiUrHB56+p+BdRMW0MI3f78YIKkbdlujjmVSoQvdEkNy4BiKN9idjq0Z4kpNvpVhPe3OezUPElsybpq4uJDcuUAvnd43Io0dbDiFbwgr1fumok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ktua+9DO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ktua+9DO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535d60d850cso10862891cf.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791989571; x=1792594371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FW3DR6i678zqHGzzWm6Z4Z10DNttvlGomhp81JEBMU4=;
        b=ktua+9DOPH2zignKrjWw4FluRn0GMkvrn25/Tg8SnbWv6/TK4UGw/igxPl2bvphvaK
         XHoIatyxEBu5OkKL97uTArcoHKyTpwgMPLOzioc43XEQC7ImC3diRZ9l5QFJ0Q19d/f8
         prUj7hJbHt3t6aM54PhaLPPCv8R/m23z6yzECejnf/W7xKXwqLhhu4R4M5MRqlSyEMOg
         7M9NZ/HeyL32Ga8iz48fE+HcQeYdDoN9OhDwdxb/lbfTq50CnwdcOUzuy8XqTnFBgMA8
         zh2CpmCKqci1bCv+Ahk5bCsAdsAtA3j0nArTGq8GCgAP5y/4wpueEU/ABaXvFMBx2XIv
         BvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989571; x=1792594371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FW3DR6i678zqHGzzWm6Z4Z10DNttvlGomhp81JEBMU4=;
        b=nijlq+eVbTGJk+7NlsHE1lTEkZR6SvkqANZ9yuLU8tF/tQIoNMTTJmANdP1uNBb5+6
         TxqG+hNZ+T2qDsetXKyo9GrPSVscbnSBdQZZX01RHo1WGtCi++O1Bkl2hGPynFEaa778
         KbAnTHNXEUecKcS7eGNVkkhdh9HZX0l+32NLVA5LukM98yDQhWqRKm1yeeax26vree3r
         WizMWCWOnd/OFuTPB56S5Bq43U/0jGYBYR4ranIHc6WUnTedYTIz0E/3ag4V2sNCLtPq
         lWPEj4bCapO3L6ED2M0JuADr3OoCM1ls+gck1bBVvIYT+LSTyzYncBjiicvQ4MRXgXdI
         eb/Q==
X-Forwarded-Encrypted: i=1; AKwUvByPeivPhBp+MBX6i7Btk3tKY9r05Cv73aYVs+rhhwuEqyXZ3PcTxVZHSZn8uRyFfDb2406SCuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ38UR0Xb7ttuN5XB/VE9L7PSbBn8ZFaceJksQoT1WPDryPV46D
	w/yirUl5j60PgNK+qBcnWtRmR1r3w2hJKqhpF2fjPp0r5Z8dBsKR9oOWx1mpQozOtXsyDavsDc3
	dpRCQBw==
X-Gm-Gg: AYBFou1+pjSs/krVm8hT1gDkmLu/Cv83AcTuS8ms/f9uaXw0/pjoiIt+jqMyYbydtjk
	NVH5GEfivUCzJeHZlFYhb+oSaDgu8GUCzEeFYyYoQQ8ZtHk8GwmRt7lKL2uUlcKUZDN2fGqkbSB
	QYjjstQNQaIKuStqq2kwwSZ17GNyIH97Y4daXgeZER3jma1SC8cHfI9uG3thjCaNvH5ngTFV1vp
	x0FUAHpVLl1mpMLfmjMNTD53H+Bil7yWwgnUp3xigI/YHDkFuOIvlkICNmX/TMahrV4BLuFHJzU
	3WPR6IRR8tSK+VrI9hLHp0qvYS4x2NhDJdAGMzRHAnFq/a/XYWShfDaLCtbLWNe3OPNDwSZUwdP
	LjubjByJa3DgbosD1UXGrLSlYK60DrWkn0coTbwsPKEgmDp1/Q/ohutPxydiZ7PjdufpICUwIUw
	cfDYJOWrM3NBNxhIXuGCykYav9/eqEEXQtWADvcfGc7V72F6CjCemxfPJPsT5GHNdW6R3XFpL0Q
	60u8qS9SQt+c1Cu
X-Received: by 2002:a05:622a:14d3:b0:535:e4e:4c60 with SMTP id d75a77b69052e-535a60cdf2amr251194681cf.10.1791989571387;
        Wed, 14 Oct 2026 07:52:51 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b740fcesm126108971cf.14.2026.10.14.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:52:50 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:52:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mario Peter <mario.peter@leica-geosystems.com>,
	driver-core@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] driver core: take parent lock in async device
 attach
Message-ID: <a68b8b6c-c84e-44a2-baff-aff56824a465@rowland.harvard.edu>
References: <20261014133109.1392265-1-johan@kernel.org>
 <20261014133109.1392265-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014133109.1392265-4-johan@kernel.org>

On Wed, Oct 14, 2026 at 03:31:09PM +0200, Johan Hovold wrote:
> From: Mario Peter <mario.peter@leica-geosystems.com>
> 
> On buses with need_parent_lock set (only USB), probe() must run with the
> parent device locked. A synchronous attach after device_add() gets this
> from the caller, e.g. usb_set_configuration() holds the udev lock while
> adding interfaces. __device_attach_async_helper() runs the probe from an
> async worker instead, where that lock isn't held, and only takes
> device_lock(dev).
> 
> With async probing enabled for the hub driver (e.g. driver_async_probe=*
> or driver_async_probe=hub), this races when a multi-TT hub is
> configured. For multi-TT hubs, hub_probe() calls
> usb_set_interface(hdev, 0, 1) to select the TT-per-port altsetting, and
> usb_set_interface() creates the endpoint devices of the interface a
> second time:
> 
>   usb_set_configuration()           async worker
>     [udev locked]
>     device_add(intf)
>       queues the probe  ----------> __device_attach_async_helper()
>                                       [intf locked, udev not locked]
>                                       hub_probe()
>                                         usb_set_interface(hdev, 0, 1)
>     create_intf_ep_devs(intf)             create_intf_ep_devs(intf)
> 
> create_intf_ep_devs() checks and sets intf->ep_devs_created without a
> lock of its own. If usb_set_configuration() has created ep_81 but not
> yet set the flag, usb_set_interface() skips removing the endpoint
> devices of the old altsetting and creates ep_81 again. With a
> synchronous probe, hub_probe() runs inside device_add() with the udev
> lock held, and usb_set_configuration() then finds ep_devs_created
> already set.
> 
> Single-TT hubs don't call usb_set_interface() from hub_probe() and
> don't show this warning, but their probe runs without the udev lock as
> well.
> 
> On an i.MX8MM board with an onboard USB2514 hub this hit 11 of 100
> boots:
> 
>   sysfs: cannot create duplicate filename '.../1-1/1-1:1.0/ep_81'
>   Call trace:
>    sysfs_warn_dup
>    usb_create_ep_devs
>    create_intf_ep_devs
>    usb_set_interface
>    hub_probe
>    usb_probe_interface
>    really_probe
>    __device_attach_async_helper
>    async_run_entry_fn
> 
> It also shows on v7.3-rc6 in QEMU, with dummy_hcd and a raw-gadget
> program emulating a multi-TT hub: re-authorizing the hub in a loop,
> while a SCHED_FIFO task preempts the writing task at random points for
> 3 ms, hit the warning in 29 of 6000 iterations.
> 
> Take the parent lock in __device_attach_async_helper() as well, like
> __driver_attach_async_helper() does, and move
> __device_driver_lock/unlock() up for that. With this the warning was
> gone in 300 boots on the board and in 6000 iterations in QEMU.
> 
> Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> Assisted-by: LLM
> Signed-off-by: Mario Peter <mario.peter@leica-geosystems.com>
> [ johan: switch to async_schedule_dev_nocall() to avoid deadlock if
>          async_schedule_dev() runs synchronously when parent lock is
> 	 held ]
> Cc: stable@vger.kernel.org	# 4.2
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

...

> @@ -1118,8 +1150,13 @@ static int __device_attach(struct device *dev, bool allow_async)
>  	}
>  out_unlock:
>  	device_unlock(dev);
> -	if (async)
> -		async_schedule_dev(__device_attach_async_helper, dev);
> +	if (async) {
> +		if (!async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
> +			put_device(dev);
> +			ret = 2;	/* retry synchronously */
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> @@ -1146,48 +1183,20 @@ EXPORT_SYMBOL_GPL(device_attach);
>  void device_initial_probe(struct device *dev)
>  {
>  	struct subsys_private *sp = bus_to_subsys(dev->bus);
> +	int ret;
>  
>  	if (!sp)
>  		return;
>  
> -	if (sp->drivers_autoprobe)
> -		__device_attach(dev, true);
> +	if (sp->drivers_autoprobe) {
> +		ret = __device_attach(dev, true);
> +		if (ret == 2)
> +			__device_attach(dev, false);
> +	}
>  
>  	subsys_put(sp);
>  }

These two pieces do not seem to be related to the changes mentioned in 
the patch description.  Are they leftovers from some other patch?

Alan Stern

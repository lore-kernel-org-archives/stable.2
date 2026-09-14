Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313E48095A
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399819; cv=none; b=jxMY8kZENT46V1exiM8PYG1e5l0piF8zN29lf1nVImuVVsWRtUdTcl9WjEDRHBioTD4MKbcorMjI1jgIlgstbvy6f1yQ2zm+21F+Sgk1QT8SLCHWCXf9Cjigylp1wZQjm0do7tm0fnbVuEbycwrIDZwaM5FkVEMc5FWclFqOHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399819; c=relaxed/simple;
	bh=h/wDH6nToVf/TAYvuwPjg2RAFl5iJ36CneD4aSoPqTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJEkNAbVlylJpp8OR9Xd3+Ap/lsSgdnwWdnTJ2IkrjsvAfNeTiMYd4e92PGETP/eHmIk8/dxe3gfCpbcm0FB4eQU+KrNdrEAcGxt7EO2MXDx4n5wAnw0bEUptedEXcFIo1VJxBcrsANSljAzxN48dzW2MD7GGjKtu4xEUc95oGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWEKv4fk; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWEKv4fk"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334ddcso21736675ad.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789399817; x=1790004617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Az8tNuJvyLtzVr3TXGzXDdP8iMuPRIZTqheTTOwSHa0=;
        b=dWEKv4fk4ZwbkYulN4HVXxzUvwe80b3iGC7osKGmhrxiWUVUjYjuTExddjCwWUXrph
         paCp/xCBnvIctXgHtHaF6/1NnuVwQp/dqoW+wpGfZ/I6UvyrYQiYUfMNxJkcv6UzBQDw
         WI+I+3M2NWgqsql5EIICGdLOPJ8Xg80Jdb2IWWm8EWUQrQy4W89jjqbXTwem9zUlabS+
         nB2WEcAFbRq0msiSpdmBDXkd0l0W6ok29MGf9bZ9DjZJFgv4y2WDg9BUKXQ918AQ/0SH
         mZramtUEoiP9z8zRo+NPymU6NqUa5MZfRM/EsxIWz/ARJBOWo43BjoFhRd8Kds89Bm1T
         /QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789399817; x=1790004617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Az8tNuJvyLtzVr3TXGzXDdP8iMuPRIZTqheTTOwSHa0=;
        b=hf7CCX8tMLcvFa8K5uedVrjbntGGUJLtcFkFkWBvv6QcyBnh4mXtsD5RxQdI9nnCSR
         K0GeYOoUzyRZoUg8ISREu2mk7xbPyGvra22rVY/BY14hfZzcbyy/SvEwE9753zYnihzu
         Z8LiDqeqMHG9d0DpYl2uVjn6u9vGJi0fT1zGhEXXpMvF9IrrJ09AbTZrmSnleHomhbsK
         sX9HrnXKsHHhJek4ztyM/SC3bq8aoD6X3sKeDmT7JcxTaK1+YqbbSqP4KAKtGuOklRAi
         5VjsWkyA8K4XI+lTSRiUF/ktZtMFGQRhhqdc3XcC/C1liiaDOTbzsbsITutTTwiUt+mu
         Vzog==
X-Forwarded-Encrypted: i=1; AKwUvBxTDOnCKG39jq/l+DIggS45RQJWfuuPB0+IF25FN+jIP9uKhrsX0O4oANlBCwF3LwABOqLgqtY=@vger.kernel.org
X-Gm-Message-State: AFuF++kBRylqWH3a0TVSBk3V4lht/eLWkpsNye79quwzLp14EFCDPQbT
	gD6KmnQolx62OvHaqRIvC7sQiVQ3w5G327u7YiAlA52t3rlTDF8G2Dgf
X-Gm-Gg: AYBFou2kuH/H5+SfGvlM0dw/kAgD5K3xtH73zpuQDZQ1Gk8fHwqkpiQ4Kbjatu1K8WR
	0Par+F5e4JwkWhWtibyrR+w0BtZj2J54/7kX8OhxILM5XMD4a5VjxHVsFwvkspDsNHhdPtB0qD+
	sxRXtT6YLZDPLxOLKGHhldWCCUPU4hy+SHXnxqZzmMJunrHuwsTFKK4YSRIUluZdCs9j3d2Tuq7
	PRce2zhL8U/t0WEaifhQOhB32GKpypQhW0mW6QENhfe5WtrdPC9Jl7gtTQ7ydXiezSw7nOqpHtm
	p+W7hgNK028rpXuRTcPw/0+ozsU6DsG5cB40+q8MRT+ofoCcbzq9Tln7znce5k/o5ddga+drxNd
	f87vpIycZSvv5N1azBD0ibZ14+R4vG63tBiZxshko26E/XYBxU+S+hdp3/J3MTvu3E+B7ZKTo7M
	rtL1rx/0I223XqvnyIJ5l35v4kZSOMEMZ8f8LM7QdVd2pHj32E88MuyA3JiA+4RH7CRTDS2iQ36
	RKA/aEpYF/EWw==
X-Received: by 2002:a17:902:f64c:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2dd6c6fef53mr67714745ad.16.1789399816489;
        Mon, 14 Sep 2026 08:30:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce92ea4sm51503935ad.20.2026.09.14.08.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:30:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 14 Sep 2026 08:30:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>, Jean Delvare <khali@linux-fr.org>,
	Hans de Goede <j.w.r.degoede@hhs.nl>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
Message-ID: <c5416dc9-f814-453f-ad2d-497d21dd8dd4@roeck-us.net>
References: <20260914062809.1650538-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914062809.1650538-1-lgs201920130244@gmail.com>

On Mon, Sep 14, 2026 at 02:28:09PM +0800, Guangshuo Li wrote:
> When the fan/pwm 4-5 pins are not used as GPIO, w83791d_probe()
> creates the w83791d_group_fanpwm45 sysfs group on the I2C client
> device.
> 
> The probe error path removes this group when a later initialization
> step fails, but the normal remove path only removes w83791d_group.
> As a result, the optional fan/pwm 4-5 sysfs files can remain after the
> driver is unbound.
> 
> The callbacks associated with these files access the driver data,
> which is devm allocated and released after driver unbind. Leaving the
> sysfs files behind can therefore result in accesses to stale driver
> data.
> 
> Remove w83791d_group_fanpwm45 during normal teardown as well.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 6e1ecd9b8f13 ("hwmon: (w83791d) fan 4/5 pins can also be used for gpio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied.

Thanks,
Guenter

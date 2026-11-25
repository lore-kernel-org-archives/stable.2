Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601212;
	b=sPpKlI7ASqHAFyetVBTblA5n0yC3VGxTGJTN4Z4eN3qxClG1/uoUvqgjn0qGKyjqaqDi
	 Y7NMhclGTeyC7YdfaCThSS7kNgbsbmmfelFOcTwbNHO9EjZc39vyYFQJ7tiiExpbp/TQ9
	 GFNfur0vbQZXc531FT53rHKvvP3Gw2o8NP00sxIuhiv4fHT9cszHlVQM+c9vm1mYSguOx
	 uu8Y1+EbuzzQpWF3BNHzVxQmKcANiG25BMIIsUWBgt0zLLMUf7G6ZFgslXnDdi3lArJVq
	 FS/3CBFJndrjbcl3oYchRyMP6/0W3/wSjgbnYvp+1frSAu2rudRaqEWiyiIg17SJpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601212;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mb8DCRE76DWOdbtmnIQjZ/3ynSFV08NzvwegmdoVrvQ=;
	b=Cywh3Zp9jjD1X2WH7kUhiaM+mAtUurOr+fQCSxMUUI9AdkeXGeZakf6SeoavuSJLtkX8
	 F3AydEJSKtVqDwZgUWOYVUfK3reMj+34nX+EPNtNxPjpuzanyzYu9gNqfmgGidMxOLcrl
	 de9cPZepDwwAQ58PvH/BYR10zpqBlVItnEbUrLnFsvyIMvhOLCFFh7Eli9j4AIomktE+L
	 MZJKAKI5oUtcExmO3ya5F0EFkxS9v4JF4T8vn7EEdqDjQRsi8hlRe9JU+AEgD15LNDuN8
	 BH6aO1EnqzJahf3mwfu/Nu6Dm9YH1D3/ZIjCZIISUREti1CJ4nmWu63M74qm4gkKUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="1n/mgmUp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF2606A321;
	Wed, 25 Nov 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1n/mgmUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E01F000C4;
	Wed, 25 Nov 2026 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601211;
	bh=Mb8DCRE76DWOdbtmnIQjZ/3ynSFV08NzvwegmdoVrvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1n/mgmUpxhr+78K2lhPKLJHCQgzNRSUiE0beilrYWUd3RKKjAm+ngcOvEg+WfU1SW
	 c9vCiRLHPB48z2SUZS38UiIfS+zDojL5ymYRY4cNvfkaYArWV2puzFZVf1a8W9dAPL
	 b1XESgaMtwjG2RkreDj0DGjZGExvEbdyiYJOTXnU=
Date: Wed, 25 Nov 2026 11:06:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhu GuangLei <zhugl3@xiaopeng.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] misc/pvpanic: share the shutdown handler across
 devices
Message-ID: <2026112558-shirt-supply-0cf0@gregkh>
References: <20261125080635.112699-1-zhugl3@xiaopeng.com>
 <20261125091520.173803-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261125091520.173803-1-zhugl3@xiaopeng.com>

On Wed, Nov 25, 2026 at 05:15:20PM +0800, Zhu GuangLei wrote:
> @@ -141,6 +151,8 @@ static ssize_t events_show(struct device *dev, struct device_attribute *attr, ch
>  {
>  	struct pvpanic_instance *pi = dev_get_drvdata(dev);
>  
> +	guard(mutex)(&pvpanic_sys_off_lock);
> +
>  	return sysfs_emit(buf, "%x\n", pi->events);
>  }

Why do you need a lock to read a single value that could change right
after it is read?

thanks,

greg k-h

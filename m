Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90E4C042B;
	Fri, 25 Sep 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363702; cv=none; b=UMjD/jpEoHwuGY5b4tlMDFhkSUHxDfaG/Pcr2Xu15WikyL9tcegzOtkxdPTyp6S895JrllAES3b2nQMXOxK918mKcd7Go173vtBxg0ZZ1uzSHA22jea+EQCc+M5+4BvjzZ1Fz6jgX8IqFKSWQNqo+PjfhJgne80vsmj8C32I9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363702; c=relaxed/simple;
	bh=9KGo63+065R3TzAMwuW+6gaA0Dr/lqRsuE4X/BLCLok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixNCtVfxNQZQi3lMkAXXsJgbef5rwwdynEdoe4YQdHUozHjKBTUTtjmFZKMHQtZsrp8Yzu4IG5BVUb+W5hbpLZr59l4dg+3Xrzn5by1yHjI8N8tUq4WQDktYU8tGUwaelQReC94mJeC9r5QLIcXxitw5/wBjcixBwlwNKGQBKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZGvvyIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZGvvyIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A661F000FF;
	Fri, 25 Sep 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363698;
	bh=zNgcmoTAloeowmHUNmz4bNSxZPU+SKZPCG1qfNB7cQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LZGvvyIxiNWJZjCtd6ZbM5i121zIeALk94bSDu6UNfB/8XmteDrSkiLGcwSPnwFHG
	 2OklXmL/E3RnXEznUsfjMqxK+A1NT3V8YAkItzfsmilkFDigM3KxusRan3y181dgOE
	 f8IXw+KRfdpaKEATK1iHX+0a0gcylYVUjHN/PfnlZ3sPZDpyFLnwK0gsePN0tOTK2w
	 RtlrBlUYA/mk8SmxnGl7SzKiCXwyMWBDjCQSdGzoO3GGSckrl3dZJEbrS5JkZwKjwg
	 1ZZJ5KPZ8tuK/jmXzvwnMz2FQfqoEEjHd10TouHvfF9IfZTkIjUAgNtsWeqqvpteTJ
	 aYZS89yzKkYlQ==
Message-ID: <2bcd44fe-eaf8-446a-b825-9fbe0adf7c31@kernel.org>
Date: Fri, 25 Sep 2026 22:14:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atmel-isi: release unregistered video device on
 remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260915112511.2397941-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260915112511.2397941-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 14:25, Guangshuo Li wrote:
> atmel_isi_probe() allocates the video device before registering the
> V4L2 async notifier. The video device is registered later from the
> notifier complete callback once the remote subdevice has been bound.
> 
> The remove path relies on the notifier unbind callback to unregister
> the video device. However, if the remote subdevice is never bound, or
> the complete callback fails before video_register_device() succeeds,
> the video device remains unregistered. In that case the unbind path
> does not release the object allocated by video_device_alloc(), and the
> remove path leaks it.
> 
> Only unregister the video device from the unbind callback when it has
> actually been registered, and clear the driver pointer afterwards.
> After unregistering and cleaning up the notifier, release the video
> device directly if the pointer is still present. This covers devices
> that were allocated but never registered while avoiding a second
> release of successfully registered devices.
> 
> This issue was found by manual code inspection.
> 
> Fixes: d12c9088c0b2a ("[media] atmel-isi: remove dependency of the soc-camera framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
Reviewed-by: Eugen Hristev <ehristev@kernel.org>

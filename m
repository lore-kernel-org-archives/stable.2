Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0904A4830;
	Mon, 12 Oct 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819965; cv=none; b=ekRk8jo4OU+VznqE0iVkANgVhX84vCclDqIIMBZwsFrsUVR+GBSK5NoTGu8JC031/Nq1bGXTCLmmt5YSzGWmKhzjXW6sgcMrnQsXw/vdr0OIv3SzvM4hgTtVdVWF+SLYK9AemGbaOkyNxLWGZMa5GfK/GsAJp/2CGXN5jTJqFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819965; c=relaxed/simple;
	bh=vAtwzVVEMN7ViYzjxev2teLqUJXMDTV8YhHJcC5YniU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IapCjC39moJbfNkyEHJBbJjr2Oe2M/GxfSkbXO0UJwpNPyhSfuy/S10f/DQyKjKDhfHP6tSKvGqho1jlcFhoXRLZhmda6TiLlwb+bQu4rr5q+wThgYL3r+QSHiXNLRIFAzHIt619aqPjk4pUH1+Xj5rTjneizXFQ5O0q5sCTKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjL2vW/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjL2vW/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE871F0089B;
	Mon, 12 Oct 2026 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819963;
	bh=ka8TcM+6T34eu+vzuysDAS0t/Z43sjGbumdHzP6fyMc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UjL2vW/IBhWZlgwcwKaMOK1iF+A2BoAWP7OKl5zPfvSy/gRV1cLQgiaLlQIaO76td
	 mGRXEnlPYsbacpBamv26npV5sJs5TxkI0Vi8pUMcQb4mINwUu7vgvgO3+XWuKI3SN5
	 IhYDAvxzSMZPcTcy/ieOAG0TJQxUYe1TmjEcYt9QNWfliM7HlKmBvNmw/osG3Ih0Th
	 Jz7fZGotExxzIknBeCqI3UH8Wto6/uCS0SSfJ0XDfB0SNSB0xvKg1Wd0QfuY73CSYT
	 yBKLqM5OsJmZv9SbrNH13ge9CVjTQUFGIkXV8DWiyg2ypecwi+03J/Y9pel0jaxEAA
	 +Xzxg98PkejrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6F5C3CE04A0; Mon, 12 Oct 2026 08:46:03 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:46:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <40aa9190-df23-449e-b547-165b8826db8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com>

On Mon, Oct 12, 2026 at 04:49:55PM +0300, Adrian Ambrozewicz wrote:
> desc_set_label() frees the old label with call_srcu() on gdev->desc_srcu.
> gpiodev_release() calls synchronize_srcu() and then cleanup_srcu_struct()
> on it, meaning to run the pending frees first, but synchronize_srcu()
> only waits for a grace period, not for callbacks queued before it to be
> invoked. Once the srcu_struct uses per-CPU callback lists, a label freed
> on one CPU, for instance by gpiochip_free_hogs() at the start of
> gpiochip_remove(), can still be waiting for its invocation timer there
> when synchronize_srcu() returns on another, and cleanup_srcu_struct()
> warns:
> 
>   WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
>   Call Trace:
>    <TASK>
>    gpiodev_release+0x20/0x60
>    device_release+0x3e/0x90
>    kobject_put+0x67/0xf0
>    release_nodes+0x3a/0x60
>    devres_release_all+0x8a/0xf0
>    device_unbind_cleanup+0x21/0xa0
>    device_release_driver_internal+0x1c6/0x210
>    bus_remove_device+0xea/0x180
>    device_del+0x152/0x460
>    platform_device_del+0x20/0x80
>    platform_device_unregister+0xd/0x30
>    gpio_sim_device_deactivate+0x26/0x80
>    gpio_sim_device_config_live_store+0x254/0x3e0
>    configfs_write_iter+0xc2/0x130
>    vfs_write+0x252/0x530
>    ksys_write+0x6c/0xe0
>    do_syscall_64+0x109/0x5d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> cleanup_srcu_struct() then flushes the callbacks itself, so the label is
> still freed, but the warning is what the comment above that check says
> srcu_barrier() is for. Use it.
> 
> A gpio-sim chip with one hogged line, set live and back in a loop, warns
> within 4 to 60 cycles in three runs on a 4-CPU guest booted with
> srcutree.convert_to_big=1; with this change, three runs of 1000 cycles
> pass. With the default srcutree parameters the srcu_struct only goes
> per-CPU under contention and the loop did not hit it in 3000 cycles; the
> warning was first seen that way, once, on a KCSAN arm64 guest unbinding
> a USB-attached GPIO controller whose firmware node hogs a line, and
> since then on real hardware with v7.3-rc5 arm64 KCSAN kernels, when
> unbinding a USB GPIO expander whose driver is not yet upstream, built
> both as an out-of-tree module and into the kernel.
> 
> Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>

From an SRCU viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

In this, I am assuming that the comment is correct, and that we only
need to wait for pending frees, not readers.

							Thanx, Paul

> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 772c6f04f489..1984f3416437 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -895,7 +895,7 @@ static void gpiodev_release(struct device *dev)
>  	struct gpio_device *gdev = to_gpio_device(dev);
>  
>  	/* Call pending kfree()s for descriptor labels. */
> -	synchronize_srcu(&gdev->desc_srcu);
> +	srcu_barrier(&gdev->desc_srcu);
>  	cleanup_srcu_struct(&gdev->desc_srcu);
>  
>  	ida_free(&gpio_ida, gdev->id);
> -- 
> 2.43.0
> 

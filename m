Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816528;
	b=qP6KopehnuyTE+kbGr2p5ZSnkt3BtR7McNDj2vdOIGzoXb7rvNfy1ejXJ9EwwBf+g/T/
	 7Mj82dW7HMvTHKbxeufBy54IKSNL1MhxbW7AeDoP/nuzLipPxBJS8ffVgXIpMCTb7Zq3a
	 Ak5kgWxH6fYJff1On4dkiQ2nP9qwzn0mEfOT6ilOvUy6yXJ7m/ggZ2gMSpQ88cZ9Q39/q
	 zNTILsisRGzQ9crov8o/vQdS421GLaDCuRco+TrTZA6+YYMXoJ27RO0KTWbvSWGa0OeYy
	 BC6aerYdvNx09kbPYr/YuNnLgzEBW10Tm9YFnb3SKV4MbafLx2/VJpMcF8aVROE5FOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816528;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=JNs0M1imMEHipxcpvSbptLi3SJicLaqdT0Bu4i3250I=;
	b=1zYQKYJXvKbNGBO2wSg2ZjYODvnH8KDpBL2j3yRsBazBEXBf6sxOhFiS6Muhacfgj2WI
	 xEjckkA+adimuWtZwJx5sGhcM+Ep2qyfbzvDgOXiGcS2DWn/IgsrZVDTKBXVxVZm4dTlH
	 61YBKIbnCbx1zBMNamo9sUxRotg0IAHo3T/hAnIVr2wlWpW4PdG7ues44D2Dbg1z+q2TQ
	 qJcxjb/a7h4fqiA3w24QHoQPfFEVwexSaJVsIuk+S5G4ZtUJ3hp1kNs+np+H70aXYigaV
	 1RydMAD8YgZFwGFCm71ih03DFGwwvwTPNKq/2rN0WD45IBYV9P/T6MiIjq6B5Ii4uXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ0KZ36u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685866082BC2;
	Wed,  4 Nov 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ0KZ36u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C001E1F000C1;
	Wed,  4 Nov 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816528;
	bh=JNs0M1imMEHipxcpvSbptLi3SJicLaqdT0Bu4i3250I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BJ0KZ36ua1ERZAwaHDvovWlKa7f23khTkrQPL5k65bz6FSIoYbbmapOy9lqzOn2f7
	 WfqR+GsMWTtjK8jLPpjGjTQdgKgnI2RPmQBfsjX1DXIO+yfk9QaAV2/Xgv5bT1sR5l
	 rjx6U9XKQHzOvWXPLmSiD7XBtuaFotfj7gR8rCQ1EXB5WNsIEbqDT/KqL0gJ6aHsZ5
	 sXD96zRFMmGlHWmQ3nDXwisZUEI7zSoIG2qvt7hVYV3sf4APwjKTDrm6V34AmLHmgh
	 3netpB9dPGr9eATxIJ5UxUxAFkUDmvgsBx7WzIlm6WBc0KtMkq1KaVgrcU7mlVktLH
	 WpsvQrZFA8grQ==
Date: Wed, 4 Nov 2026 18:22:04 +0000
From: Lee Jones <lee@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: tca6507: Fix use-after-free on unbind
Message-ID: <179370065155.793788.12273630752864277064@kernel.org>
References: <20261028174348.64014-1-danishkhateeb03@gmail.com>
 <20261028174348.64014-2-danishkhateeb03@gmail.com>
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
In-Reply-To: <20261028174348.64014-2-danishkhateeb03@gmail.com>
X-AI-Review-Draft: <20261028174348.64014-2-danishkhateeb03@gmail.com>

On Wed, 28 Oct 2026, Danish Khateeb wrote:

> Since the LEDs are registered with devm_led_classdev_register(), they
> are unregistered only after tca6507_remove() has cancelled the work.
> Unregistering an LED that is on turns it off, which queues the work
> again from led_assign(), and the work then runs after devres has freed
> the chip:
>
>   BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
>   Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
>   ...
>   Last potentially related work creation:
>    ...
>    queue_work_on+0xb6/0xc0
>    led_assign+0x223/0x340 [leds_tca6507]
>    led_classdev_unregister+0x26b/0x340
>    release_nodes+0xb3/0x140
>    devres_release_group+0x247/0x470
>    i2c_device_remove+0xbf/0x1b0
>
> Set up the work with devm_work_autocancel() before the LEDs are
> registered, so that devres cancels it after they are gone, and drop
> tca6507_remove().
>
> Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
> Cc: stable@vger.kernel.org
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>  drivers/leds/leds-tca6507.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
> index 9afe2722986c..0f987e551f03 100644
> --- a/drivers/leds/leds-tca6507.c
> +++ b/drivers/leds/leds-tca6507.c
> @@ -71,6 +71,7 @@
>   * not recognised when matching.
>   */
>
> +#include <linux/devm-helpers.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/leds.h>
> @@ -735,9 +736,11 @@ static int tca6507_probe(struct i2c_client *client)
>  		return -ENOMEM;
>
>  	tca->client = client;
> -	INIT_WORK(&tca->work, tca6507_work);
>  	spin_lock_init(&tca->lock);
> -	i2c_set_clientdata(client, tca);
> +
> +	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
> +	if (err)
> +		return err;

This is replaced in patch 2.  I'm not sure I see the point.

Why not do everything at once?

>  	for (i = 0; i < NUM_LEDS; i++) {
>  		struct tca6507_led *l = tca->leds + i;
> @@ -766,20 +769,12 @@ static int tca6507_probe(struct i2c_client *client)
>  	return 0;
>  }
>
> -static void tca6507_remove(struct i2c_client *client)
> -{
> -	struct tca6507_chip *tca = i2c_get_clientdata(client);
> -
> -	cancel_work_sync(&tca->work);
> -}
> -
>  static struct i2c_driver tca6507_driver = {
>  	.driver   = {
>  		.name    = "leds-tca6507",
>  		.of_match_table = of_match_ptr(of_tca6507_leds_match),
>  	},
>  	.probe    = tca6507_probe,
> -	.remove   = tca6507_remove,
>  	.id_table = tca6507_id,
>  };
>
> -- 
> 2.56.0
>

-- 
Lee Jones

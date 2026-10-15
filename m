Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB4524B1C;
	Thu, 15 Oct 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068043; cv=none; b=NbNJIDEPG/MmLW+nxmdFUhvO/H7gblvD3Q8U04ObB9r4QYnL+5pE5B9joZIfvt3kHcxRjOBlYNk1/nBZ/iIuX800b0bKVQsa2+SprYHx0xlIU1fRZN4XH8oyJIp+X401bvtmcBypcGoRXZ9dHHqjAOgFsnve2DXvx8KjqO8jaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068043; c=relaxed/simple;
	bh=Cevq8m4biap8mXnqmeOT5z3NEclaoSR37+Xq0JCgVJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boYOCKs8yWUIWidUjPY7q3UaN3gGUi3LWf1c6l1mleq5LupdULtw8Eko6iLOK5xaTPMdtGPCA0wxXphN4lNak7b0myJX+TyULV4ITz6vFMiJh1Slj64o2i9Ez2rWSRQrXeQXrlddrRKxjPj6n4oa8Mn7BtefYCP58X+3ErST0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuB4upJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuB4upJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC341F000C4;
	Thu, 15 Oct 2026 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068042;
	bh=4jYUWj1Z8lVtLtLhT03lBD4WoGFffEkFo9Ee1+0Henc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DuB4upJWt1qSCI+i7geWSb9+9TPb4HM2H1uDDt/DNXFkVyi1gl1Xv+4+gJCLfxwih
	 hYpKqczX3TB1U5YgRg/C1t0r9JbvdlEY/MrL7Fne2jvEpSd3xA70Go3tciTrwSOxA1
	 kalGW3Smei/DH/1n3KXifHX70SxiGk8amkResDIYdYc6dfowmbrZoP5nC9u+ZKVUh1
	 JgtsD5vDBLRPpOyXk93xbiZ8lgCPl47/VpdgjNWpydcJi3fDveV1+HtAb+Nxo2Gwc5
	 Mu3BK/RAGCUstfXTCynrIKpY1fT9HjTi3mi+0LwdwRVL7A+/rBFDlpOdCVOzohoIY4
	 3o5dlaNfq5hNA==
Date: Thu, 15 Oct 2026 13:40:38 +0100
From: Lee Jones <lee@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: pavel@kernel.org, afd@ti.com, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: tca6507: Fix use-after-free on unbind
Message-ID: <179198531901.839288.3981290104893464587@kernel.org>
References: <20260926172115.543800-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926172115.543800-1-danishkhateeb03@gmail.com>
X-AI-Review-Draft: <20260926172115.543800-1-danishkhateeb03@gmail.com>

On Sat, 26 Sep 2026, Danish Khateeb wrote:

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
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>
> Notes:
>     Tested in QEMU on a next-20260925 KASAN kernel, with the driver built as
>     a module and a test-only module that adds a fake I2C adapter and a
>     software node for a TCA6507 with two LEDs. With the LEDs on, unbinding
>     hits the report above (38 reports in 20 unbind/bind cycles), and so does
>     unloading the driver in 2 of 3 runs. With this patch there are no
>     reports in 20 cycles or 3 unloads, and the LEDs come back after each
>     rebind. A W=1 build with GPIOLIB is clean.
>
>  drivers/leds/leds-tca6507.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
> index 9afe2722986c..503a465a07f4 100644
> --- a/drivers/leds/leds-tca6507.c
> +++ b/drivers/leds/leds-tca6507.c
> @@ -79,6 +79,7 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/property.h>
>  #include <linux/workqueue.h>
> +#include <linux/devm-helpers.h>

Nit: Alphabetical.

>
>  /* LED select registers determine the source that drives LED outputs */
>  #define TCA6507_LS_LED_OFF	0x0	/* Output HI-Z (off) */
> @@ -735,9 +736,15 @@ static int tca6507_probe(struct i2c_client *client)
>  		return -ENOMEM;
>
>  	tca->client = client;
> -	INIT_WORK(&tca->work, tca6507_work);
>  	spin_lock_init(&tca->lock);
> -	i2c_set_clientdata(client, tca);

Nice catch.

> +
> +	/*
> +	 * Unregistering the LEDs turns them off, which queues the work again,
> +	 * so it must be cancelled after them: set this up before registering.
> +	 */

Correct life-time ordering is expected.  This comment is superfluous.

> +	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
> +	if (err)
> +		return err;
>
>  	for (i = 0; i < NUM_LEDS; i++) {
>  		struct tca6507_led *l = tca->leds + i;
> @@ -766,20 +773,12 @@ static int tca6507_probe(struct i2c_client *client)
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
>
> base-commit: 05b4738b0078f7d6f154f68068a11c8a0635e9df
> -- 
> 2.55.0
>

-- 
Lee Jones

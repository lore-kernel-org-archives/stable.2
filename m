Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190595;
	b=0M/A1NS7E+VxOVoLf1jAaNBB5MaOrtTgaGh/JqwBLqjZXZN+3Z2fPUIrnNRMlgATlqGU
	 KmLj8kZM4wqmCmD7BIsk1x18fszLiKmD6HyDdtyFrJL2sdXt4Qe7WEYbNSW3Z1ueC+9PN
	 MN9urIOF8WhUIzgnvqc8Npx7zlgmM2o/XgvtvT0/mVg7HfNl1BG3dTOCNdEV7dXOI7WUb
	 hG8BwQ2YfeEs1NM3Aog/cG3l8xkSFnGUE98P9LqNJ8hRbrz04WZ/epni9WtAy3m/A4ipj
	 PE7fEtyU+jlPy2RUUyOU3aorY2slya3AcOsLL/fsM+x/U0M9wVv4ebnuJcFmnrnNfkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190595;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=QQ6ryj6wxEaWrQOLX8GVV94I03IXi50AK/ppVCfDOCY=;
	b=L0ogVIrUrxBQMnGg/td7mQ9Rd1XVbKzek3cpqNatTT3UryhrMg2lXd9c29rd14/E10G1
	 1a3h8tAnvwLc3yn7qGFyc83viZuJedfcR9qa4+7mDVDHzosTiNsGeQdT31HzcZJpFedLW
	 yo1+7+64RJ/qv40xMMRRVnzwZglAPqqkmQRmvpMEOFLjuPFyaGOC20snQzBEUK0ZRuMCH
	 gBzpAphpUYj6MNQdunhm7wmzLuVs6a0Ngw4pIWkw4zkBJk4H4NYd7Tff6MIRbAmU2kj0Q
	 CCPCixTcY1VF+pCkiSwsjhBMSO1U6iSYp3RbI5VOrwlOTFbi76S/umyThSzD8Ffu1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcSffzHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CB606A31A;
	Wed, 28 Oct 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcSffzHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC151F01825;
	Wed, 28 Oct 2026 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190594;
	bh=QQ6ryj6wxEaWrQOLX8GVV94I03IXi50AK/ppVCfDOCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcSffzHMfjKyFtwnFYsLgam+DiDOpjLX31Q8yYPac8tTrcoK9IP/hwDyoklAQlYUL
	 9I2a7znKpOvK2ysVTauJCS+lsZDdVfRlrp8upFETyQCAxJwl2JMw/CSmujG4KaoeUz
	 LlssXLETM5jcZgLRBRKoXT2RgkDYJ9KPJFDzvkXOI4VUPQiHsZN+5jVv7busSlFilR
	 uN6n5t/jeAUQpfN1Zv/3eGIwJhARt1+Ne1c9myAoTZ3LqZnDuouBEvtBB+B+60qnQ+
	 t6ukOqpw7OF8GPMOVh5ryjishjN8XEixUb1TUC6VvXBa2lw6DWHIIr09lA/Jk1OaZl
	 JFjKhSoTVf4nQ==
Date: Wed, 28 Oct 2026 12:29:51 +0000
From: Lee Jones <lee@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: tca6507: Fix use-after-free on unbind
Message-ID: <179213356828.2581328.5085333261240588869@kernel.org>
References: <20261015144033.56519-1-danishkhateeb03@gmail.com>
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
In-Reply-To: <20261015144033.56519-1-danishkhateeb03@gmail.com>
X-AI-Review-Draft: <20261015144033.56519-1-danishkhateeb03@gmail.com>

On Thu, 15 Oct 2026, Danish Khateeb wrote:

Please review, explain or fix the Sashiko review(s).

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
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>
> Notes:
>     Changes in v2:
>     - Move the new include to the top of the list, where it sorts
>       alphabetically (Lee)
>     - Drop the comment above devm_work_autocancel() (Lee)
>     - Add Andrew's Acked-by
>     - Link to v1: https://lore.kernel.org/all/20260926172115.543800-1-danishkhateeb03@gmail.com/
>
>     Tested in QEMU on a next-20260925 KASAN kernel, with the driver built as
>     a module and a test-only module that adds a fake I2C adapter and a
>     software node for a TCA6507 with two LEDs. With the LEDs on, unbinding
>     hits the report above (38 reports in 20 unbind/bind cycles), and so does
>     unloading the driver in 2 of 3 runs. With this patch there are no
>     reports in 20 cycles or 3 unloads, and the LEDs come back after each
>     rebind. A W=1 build with GPIOLIB is clean.
>
>     v2 was retested the same way on next-20260930: 39 reports in 20 cycles
>     without the patch, none with it in 20 cycles or 3 unloads.
>
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
>
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
>
> base-commit: 05b4738b0078f7d6f154f68068a11c8a0635e9df
> -- 
> 2.56.0
>

-- 
Lee Jones

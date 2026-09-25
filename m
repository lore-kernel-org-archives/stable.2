Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727748A2C2
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374698; cv=none; b=DrfUYRhSBs/Z8ftaOG0dIQsqYk9mXpoDWVmB+GKRjxy0xJ457e+wN54a7FEUaUqVe646BoRfXyx7S+reH3vtshasx0gPCZTanhTWqtctGG8lnJsfbsRU3RVqQlQIxv/bp7dq7ZOqOgPx0AQ8c7qKF3kgue2Bi3gw+UYf36EUP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374698; c=relaxed/simple;
	bh=lUyCqvIhkx+oa2eX2J77bBkV43sFd/DsKxrwXJcJW70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN9EyhDw3Z45IoDMZ2HbUAu+qGyc2nQ3WCt7/b/Bc1kQWAhkNt1AC67CGRssDRqyW4lI1dplgE3q8CAvrqbaNEadYyLLl7Hdl6bZ/WQWvIvB6cH7Tb4wjiFcBaLUyb5l1IAkGSM98lJX5pxvnQ3+/lU6Qxfn2b/qlnvpKgUgnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqK0M+3r; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqK0M+3r"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f9160b81so499991c88.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790374695; x=1790979495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayLp4Jx22xan0yoaXXO0H5UJI37HFonSA4zUCdy+nIo=;
        b=jqK0M+3rOKmnvbUCAihw+0CnJmxPVScYGgTauAfdDzHWgiMVfW72Ga9i6+HDuThXuU
         4U6sFRkMObqrl/wYTTFVVwBGXcDlP4Ionpv3mxDVzBZBrL3CGEyawwTfbl7qsr/kkPi2
         V8rM7wMyJh7B7UEj4XvR38+CmkaSV8rSb8X43A5qDDJ2ZJZdbBL/zaQj6JzmbxjaM8Q6
         tyVfcVJuBqXBVv4lf27RqQgS7vb+erG9qGWfQrDnAkKb9SWQi1pyVkq7wCG/UZw82zsi
         gbTP+KsDDWiW4JtEnBiVkF60eSmsEizKkfT7x4EWNyrknbhgaiyDF5/6Vv62aTTPX2xp
         BrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790374695; x=1790979495;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayLp4Jx22xan0yoaXXO0H5UJI37HFonSA4zUCdy+nIo=;
        b=W4ZB3oezha5G+4Ca1kd8sM8B2sUrk4ZE+rk3AzaZghuc7BAx43aNelMZQoKJLeRHX9
         k57c3ErnFfh1t/fd5iUfyL6a7QlrWDRdHm+Wl3XOecLukUt0ojyzwzP4AiLkzULbbzEF
         AL9WwHLcYaBCE8uNo46o6J95znCQOJYt1mglMvaOjM2lRbcuPNaQGDsTYrQ+PkFe05zD
         W1OxtVQp5brtEUGQ0p5TyEfmr0HZdoqI/p9vX9RkG289VevkZipqs7dDtZbb9FvZPhAm
         kpuFNaFoAEW3jPCdvssz2Y0ADYyYclZRd6sTp2SIQA9OUs4fyS0rSa5pVGVzhCFuYHEM
         52KQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1LwCubrzAOZncRxCHim9Y3kwVzqyzWKfNqtEPurU8t2FEaGQgHzllaBSwHMh6ic30W2OPXt8=@vger.kernel.org
X-Gm-Message-State: AFuF++lF2L5Mp5J6FBQ3S4VWs5A/9VlqZSJE3cKPeF82MeGHfmFfRU3j
	ppHp5pd3TXNQXiXAN1oVse+h5pwu0dFiFq/jCHnaoey2UBMD/ZJK2/Mv
X-Gm-Gg: AYBFou2Asok+XxqgU0m2Eo1guxIRFy31sYYjmsFsvPAiPjFtj/E/zlh73cxrlxE/Nn/
	3HgHWsS4U04h6gUOxrt6nyeGwtUrR4DwLgt38tDG7MuD357pvxIiFgStrmBVwRasaub/fmbk6Z3
	ghR7pBJhXVEaodIO7FE/4WuhbX9uHvUv3Hnoh3ZHI8hnOiWM4l0XXRt3Xn1hHmk/jSXPxwg25Fm
	ZQkAhEc5feq8fEHTJCXwe8HE4QNAD3Ur6sxCoiUZVyVDGfHod4XgfU2r7M7q9KI0gOKARVfX4IG
	PjmHvA5BkZsouy3yYTYdiFImpUDL1WB3oF7mneYUle1AiRzB4QJZiIV0ztpQ6jZBYlcDOOV2/em
	zLa7tVVX3gkocPBWVuCXUUfuQlm81JrC6/Vq7/81EVVAqNl3holzFEZ5CUGrkDCRNrdZCZ00QG2
	DcM0u2EMa752wAHwF2aacwBKupn0ZLhJXL+IM/qedNR/6pwV4CY8yxLfy9O9TahSFUtSl72BnBW
	IvusXjtuaT0hYK1MNXS2kJm7bnbk1olofr6g50=
X-Received: by 2002:a05:7022:288:b0:138:3613:dc6 with SMTP id a92af1059eb24-146ce67ee45mr1270576c88.14.1790374694857;
        Fri, 25 Sep 2026 15:18:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb6b9sm7166213c88.1.2026.09.25.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:18:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:18:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 1/5] Input: stmfts - wait for controller ready after
 reset
Message-ID: <arbyyscK-3xYlj6H@google.com>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-1-0fcf49e2c85f@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-stmfts5-v8-1-0fcf49e2c85f@ixit.cz>

On Fri, Sep 25, 2026 at 11:22:19PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> After releasing the reset line stmfts_reset() sleeps a fixed 50 ms and
> stmfts_power_on() another 50 ms before the first I2C access.  That is
> enough for a warm reset, but when both supplies were really cut during
> system suspend the controller boots from cold and can need longer.  If
> it does, the first read fails, stmfts_resume() returns an error and the
> touchscreen is left powered off with its interrupt disabled.
> 
> The controller posts a controller ready event once it has booted, and
> the event parser already completes cmd_done on it.  Enable the interrupt
> right after releasing reset and wait for that event instead of sleeping,
> giving the controller 300 ms, the total budget the vendor driver allows.
> Boards without a reset line keep the old timing.
> 
> Usually phones such as Pixel 4a and Xiaomi Mi 8 needs longer delay, so
> without this change touchscreen stops working.
> 
> Fixes: 8a1f9de80e45 ("Input: stmfts - add optional reset GPIO support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/input/touchscreen/stmfts.c | 60 ++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> index 972687797f826..1720202d6186b 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -59,16 +59,18 @@
>  #define STMFTS_MASK_X_MSB			0x0f
>  #define STMFTS_MASK_Y_LSB			0xf0
>  
>  /* key related event masks */
>  #define STMFTS_MASK_KEY_NO_TOUCH		0x00
>  #define STMFTS_MASK_KEY_MENU			0x01
>  #define STMFTS_MASK_KEY_BACK			0x02
>  
> +#define STMFTS_RESET_TIMEOUT_MS	300
> +
>  #define STMFTS_EVENT_SIZE	8
>  #define STMFTS_STACK_DEPTH	32
>  #define STMFTS_DATA_MAX_SIZE	(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
>  #define STMFTS_MAX_FINGERS	10
>  #define STMFTS_DEV_NAME		"stmfts"
>  
>  static const struct regulator_bulk_data stmfts_supplies[] = {
>  	{ .supply = "vdd" },
> @@ -538,25 +540,16 @@ static int stmfts_read_system_info(struct stmfts_data *sdata)
>  	sdata->chip_ver = reg[0];
>  	sdata->fw_ver = be16_to_cpup((__be16 *)&reg[2]);
>  	sdata->config_id = reg[4];
>  	sdata->config_ver = reg[5];
>  
>  	return 0;
>  }
>  
> -static void stmfts_reset(struct stmfts_data *sdata)
> -{
> -	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
> -	msleep(20);
> -
> -	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
> -	msleep(50);
> -}
> -
>  static int stmfts_configure(struct stmfts_data *sdata)
>  {
>  	int err;
>  
>  	err = stmfts_command(sdata, STMFTS_SYSTEM_RESET);
>  	if (err)
>  		return err;
>  
> @@ -582,53 +575,76 @@ static int stmfts_configure(struct stmfts_data *sdata)
>  
>  	return 0;
>  }
>  
>  static int stmfts_power_on(struct stmfts_data *sdata)
>  {
>  	int err;
>  
> +	if (sdata->reset_gpio) {
> +		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
> +		/* a short delay before powering up */
> +		usleep_range(1000, 1500);
> +	}
> +
>  	err = regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
>  				    sdata->supplies);
>  	if (err)
>  		return err;
>  
> -	/*
> -	 * The datasheet does not specify the power on time, but considering
> -	 * that the reset time is < 10ms, I sleep 20ms to be sure
> -	 */
> -	msleep(20);
> +	if (sdata->reset_gpio) {
> +		reinit_completion(&sdata->cmd_done);
>  
> -	if (sdata->reset_gpio)
> -		stmfts_reset(sdata);
> +		/*
> +		 * The datasheet does not specify the power on time, but
> +		 * considering that the reset time is < 10ms, sleep for 20ms
> +		 * to be sure before releasing reset line.
> +		 */
> +		msleep(20);
> +		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>  
> -	err = stmfts_read_system_info(sdata);
> -	if (err)
> -		goto err_disable_regulators;
> +		enable_irq(sdata->client->irq);
>  
> -	enable_irq(sdata->client->irq);
> +		if (!wait_for_completion_timeout(&sdata->cmd_done,
> +						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
> +			dev_err(&sdata->client->dev, "controller not ready after reset");
> +			err = -ETIMEDOUT;
> +			goto err_disable_irq;
> +		}
> +	} else {
> +		/*
> +		 * We do not know the real controller state (was it powered
> +		 * off or reset). Let's hope that this is enough time to
> +		 * initialize.
> +		 */
> +		msleep(70);
> +
> +		enable_irq(sdata->client->irq);

Sashiko gave me an idea. What if we do this:

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 1720202d6186..e147a27f57b3 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -578,6 +578,7 @@ static int stmfts_configure(struct stmfts_data *sdata)
 
 static int stmfts_power_on(struct stmfts_data *sdata)
 {
+	unsigned int timeout;
 	int err;
 
 	if (sdata->reset_gpio) {
@@ -591,9 +592,9 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 	if (err)
 		return err;
 
-	if (sdata->reset_gpio) {
-		reinit_completion(&sdata->cmd_done);
+	reinit_completion(&sdata->cmd_done);
 
+	if (sdata->reset_gpio) {
 		/*
 		 * The datasheet does not specify the power on time, but
 		 * considering that the reset time is < 10ms, sleep for 20ms
@@ -602,23 +603,29 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 		msleep(20);
 		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
 
-		enable_irq(sdata->client->irq);
-
-		if (!wait_for_completion_timeout(&sdata->cmd_done,
-						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
-			dev_err(&sdata->client->dev, "controller not ready after reset");
-			err = -ETIMEDOUT;
-			goto err_disable_irq;
-		}
+		timeout = STMFTS_RESET_TIMEOUT_MS;
 	} else {
 		/*
 		 * We do not know the real controller state (was it powered
 		 * off or reset). Let's hope that this is enough time to
 		 * initialize.
 		 */
-		msleep(70);
+		timeout = 70;
+	}
 
-		enable_irq(sdata->client->irq);
+	enable_irq(sdata->client->irq);
+
+	if (!wait_for_completion_timeout(&sdata->cmd_done,
+					 msecs_to_jiffies(timeout))) {
+		if (sdata->reset_gpio) {
+			dev_err(&sdata->client->dev, "controller not ready after reset");
+			err = -ETIMEDOUT;
+			goto err_disable_irq;
+		}
+		/*
+		 * If we did not reset the countroller ourselves continue
+		 * even if we did not receive "ready" message.
+		 */
 	}
 
 	err = stmfts_read_system_info(sdata);

No need to resend the series unless there is more feedback on the
bindings.

Thanks.

-- 
Dmitry

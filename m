Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E240862A;
	Mon, 27 Jul 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171469; cv=none; b=LIiLxgTvTTVJGesZSzxEwSpU8A2lKQ1ikb3BveT323QXSXzuYYj+WKWEZJE7v/CbHJAeKqA1GQMJYGRLHYEBRFRRujWvvyYBOEP0tdhl4PAlnqNkWFSQcH6o683g/o5lqdeVTXCV1ST5ItqpuNpha1Tkgk/JLyfhHss9Xbz2MfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171469; c=relaxed/simple;
	bh=J8lEPwWOzGMXT5ri9Fg7inIP+3JW2xNUWRVSHgySlQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2F7wVcEgkLKXtwubxebddITluZxHQ0ian/ZjDD6F4TqbVOq7sfZzfd/DofgFSN26Pu2X+hJincl28dUK+TLm3P8cTbMoV+rv24/LjsK8Az3xBfU2C/B63oBRy6goRgT8I7ANKeZ8dAKV59cW8H0Y6CXXYdeG4f2QaWg48DRCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cty/9tza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cty/9tza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415901F000E9;
	Mon, 27 Jul 2026 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171465;
	bh=i/GWdPWbOsYF7ZeNnFC7gBeIf0IiDtImhHbc8ga2vgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cty/9tzaDnGufpHUW8VWqJfHvqhBoPriq5oQIzpZXTdgqgvagmM7IvLM2nX8QB+ir
	 Xg7uqLuKR0UNDcacI9irf2EkZIyHCOyZeyvq47bqXWFztePtqzwUjkijGFeNBVuRtt
	 zevH7m7TwREJYxdwGMCSaOHoPRF/xaFp5q+k18hrNoFJBhFNaiJRn/boNP1/Zj+15l
	 QzaUQGbmfMOZijaI+VbXFlzm6yyMTMAH97Qx2vr9gYpjq3+C+UGauYdNHzPRAh024f
	 2s3G6WLKswZehE0Gc+GWeGMJyzkxZbCg9LToR3Qz1KBV1InhQE42mysumcH0aIXOby
	 zyJwKHqgNZttw==
Date: Mon, 27 Jul 2026 17:57:41 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, mgreer@animalcreek.com, sameo@linux.intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: trf7970a: drain timeout_work and keep trf->lock
 valid across teardown
Message-ID: <20260727165741.GQ418547@horms.kernel.org>
References: <20260721133539.3195899-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721133539.3195899-1-fanwu01@zju.edu.cn>

On Tue, Jul 21, 2026 at 01:35:39PM +0000, Fan Wu wrote:
> The threaded IRQ handler and timeout work can wait on trf->lock while
> teardown destroys it. The timeout handler can also access the digital
> device after it has been freed.
> 
> Synchronize timeout_work before releasing the digital device, and leave
> the embedded mutex alive for devres cleanup to synchronize the IRQ
> handler before trf is freed: devm_request_threaded_irq() is registered
> after devm_kzalloc(), so devm_free_irq() runs before trf is released.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/nfc/trf7970a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index d17c701..fa2f75a 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -2206,13 +2206,13 @@ static int trf7970a_probe(struct spi_device *spi)
>  err_shutdown:
>  	trf7970a_shutdown(trf);
>  err_free_ddev:
> +	cancel_delayed_work_sync(&trf->timeout_work);
>  	nfc_digital_free_device(trf->ddev);
>  err_disable_vddio_regulator:
>  	regulator_disable(trf->vddio_regulator);
>  err_disable_vin_regulator:
>  	regulator_disable(trf->vin_regulator);
>  err_destroy_lock:
> -	mutex_destroy(&trf->lock);
>  	return ret;
>  }
>  
> @@ -2226,13 +2226,13 @@ static void trf7970a_remove(struct spi_device *spi)
>  
>  	mutex_unlock(&trf->lock);
>  
> +	cancel_delayed_work_sync(&trf->timeout_work);
> +
>  	nfc_digital_unregister_device(trf->ddev);
>  	nfc_digital_free_device(trf->ddev);

Hi Fan,

The AI-generated review of this patch on sashiko.dev [1] flags a number of
issues. Most of them seem to be pre-existing and I think those ones
can be treated in the context of possible follow-up.

But this one stands out as directly effecting this ptach:

  "Is it safe to cancel the delayed work before unregistering the device?

  "If concurrent operations from userspace (like bringing the interface up)
   happen while the device is still registered, they can execute
   trf7970a_switch_rf() and trf7970a_send_cmd(), which would re-arm the
   timeout work after we have already cancelled it.

  "When the re-armed work executes after we free trf->ddev below, won't
   this lead to a use-after-free? Should nfc_digital_unregister_device() be
   called before the work is cancelled?

[1] https://sashiko.dev/#/patchset/20260721133539.3195899-1-fanwu01%40zju.edu.cn

>  
>  	regulator_disable(trf->vddio_regulator);
>  	regulator_disable(trf->vin_regulator);
> -
> -	mutex_destroy(&trf->lock);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.34.1
> 

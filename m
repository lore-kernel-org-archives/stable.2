Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80E42123A;
	Wed, 12 Aug 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535604; cv=none; b=e9DZQhmM7GoTQ4Z5F70+hPqQohe/NL9N/o/6XgnjTd5+mlOoatoZxhR598i8DT3Lg2Yt2ZmZECWqCnf6dR9vYbjQZrz23qRY8Nd4vR1WkDETvpa41Hk5UyOcVDPEoscxU0jfNPecVUKRvxqsrNXFbIBtclhFh9EjoOUY1LCbMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535604; c=relaxed/simple;
	bh=mCt7T+q5ckM4Ec2RGeG31h03mXnJZAQnLvsoW0zfjoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv3N2hSMZkasnq6+1SecgFo5xaxhd3MeleF/+RNGuY0rvURdTTaulDuMly5x8mbjYfKM/clonZt+1Jwbg6IZ7QYot601lLT9GEuJviTJeNtPVjh3Y/hpXHtJd6SNvqKSp6UdiBuj+gN8nDF8fJwFonmqdvTJuCjmW7aHg0zNOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQDqkDXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQDqkDXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D511F000E9;
	Wed, 12 Aug 2026 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535601;
	bh=ipwD5mVGCJ7usQHtP/Xb+NpujWtiVz809Yc/rGyGlYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQDqkDXzTEmfjgikqw8qnrPt2RVIOAbWtzH/+M2YmkbMNpxJTeDA96SOxQ9DCGvtm
	 W80PG5NyeyMqcfMuTl48588faGTw6JrtCZgtM2pb9QEV2hC0cZt9Gkx4d88muN7oHT
	 sonRv98Tsd7L273nULRxawD77DYaun7wcb13M9CNelNHt0UQmKH2p0JSH+3wQm8Nw2
	 DqAm5J9SRd9n8dMUxM20q8q/qztF3866dovxVf4J4PALPSXsHK3GfNKvDyc6DlURAh
	 k85qJxgHqyZ346/1WfhEOa78/w7bdhAUE9bFG2Mx8JJb8xr3gUMDNp3PIfdQiDJdrF
	 12HEvtLsdKhyw==
Date: Wed, 12 Aug 2026 12:53:18 +0100
From: Lee Jones <lee@kernel.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Support Opensource <support.opensource@diasemi.com>,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2] mfd: da903x: cancel IRQ work during teardown
Message-ID: <20260812115318.GM1072730@google.com>
References: <20260728065557.1517-1-getshell@seu.edu.cn>
 <20260806152032.894-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806152032.894-1-getshell@seu.edu.cn>

On Thu, 06 Aug 2026, Hongyan Xu wrote:

> The IRQ handler disables the IRQ and schedules irq_work. Releasing the
> IRQ does not drain that work, which can continue to use the devm-allocated
> chip and notifier state.
> 
> Add a devm action after requesting the IRQ. The action disables the IRQ
> and cancels the work before automatic IRQ release. Run the same action
> before removing child devices on normal detach.
> 
> If da903x_add_subdevs() fails, it removes already-created child devices
> before returning from probe. Release the action explicitly before that
> cleanup so the work is stopped before child-device teardown.
> 
> This issue was found by the author's in-house static analysis tool.
> The patch was reviewed by the author against the latest mainline tree.
> 
> Fixes: 26b8f5e1e2d1 ("mfd: add base support for Dialog DA9030/DA9034 PMICs")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/mfd/da903x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git "a/drivers/mfd/da903x.c" "b/drivers/mfd/da903x.c"
> index e86b39de3303..f3e983bd21b0 100644
> --- "a/drivers/mfd/da903x.c"
> +++ "b/drivers/mfd/da903x.c"
> @@ -421,6 +421,14 @@ static irqreturn_t da903x_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static void da903x_cancel_irq_work(void *data)
> +{
> +	struct da903x_chip *chip = data;
> +
> +	disable_irq(chip->client->irq);
> +	cancel_work_sync(&chip->irq_work);
> +}
> +
>  static const struct da903x_chip_ops da903x_ops[] = {
>  	[0] = {
>  		.init_chip	= da9030_init_chip,
> @@ -484,6 +492,7 @@ static int da903x_add_subdevs(struct da903x_chip *chip,
>  	return 0;
>  
>  failed:
> +	devm_release_action(chip->dev, da903x_cancel_irq_work, chip);

Manually calling 'devm_release_action' here and in 'da903x_remove' somewhat
defeats the purpose of using managed resources. Should we instead register
the subdevice removal as a devm action as well?

If we register the subdevices' cleanup as a devm action before the IRQ
cancel action, devres will execute them in reverse order during cleanup.
This would allow us to eliminate the '.remove' callback entirely.

>  	da903x_remove_subdevs(chip);
>  	return ret;
>  }
> @@ -529,6 +538,11 @@ static int da903x_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&client->dev, da903x_cancel_irq_work,
> +				       chip);
> +	if (ret)
> +		return ret;
> +

If we transition to using a devm action for the subdevice removal, we
could call 'da903x_add_subdevs' first, register its cleanup action, and
then register 'da903x_cancel_irq_work'. This would guarantee that the
IRQ work is cancelled before the subdevices are removed during any
unwinding or driver removal.

>  	return da903x_add_subdevs(chip, pdata);
>  }
>  
> @@ -536,6 +550,7 @@ static void da903x_remove(struct i2c_client *client)
>  {
>  	struct da903x_chip *chip = i2c_get_clientdata(client);
>  
> +	devm_release_action(&client->dev, da903x_cancel_irq_work, chip);

With both cleanup steps handled by devres in the correct order, we should
be able to remove 'da903x_remove' entirely, simplifying the driver.

>  	da903x_remove_subdevs(chip);
>  }
>  
> -- 
> 2.50.1.windows.1
> 

-- 
Lee Jones

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119663;
	b=v+OgzrE8pw3v+/fFiMTgRNwcWho9822w5AjBfb8+RU3BmqXCnmlp8XK8qCjufy9ePvN/
	 fNx5eji5jbDhE7pi6eez5ioz0q8NBXfi2+ZW5/shgEn1YhEBCqiOkeePnKZalbPbrDtXk
	 9ETgtBHnwG4r7+yGyWEVMoTlSYehfnv1wREJr3VcTU1Di+ZHX3hNvzlT8fyJ7mLA1yEVt
	 UnKCyZE0nppq3/aS8ym/YDXffDnnssRJvJjrJwCO6WaPQra1U+adFakc3sh1w6LE9IiuQ
	 dDIHjIqYIBGszRyVsOWZJWExNBHfbZ7k94ONAeRK04WAHZsD8kmDkVrDqPM0Hzcz4AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119663;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0sC005GcKM377GTiHOuPAcvdGYQ3vuMZ7FcYBR6FIjo=;
	b=33bfgpuxjL0BqcXcuagXTN0p7nwbho2y+L5ae/24GQmgSjYobnHu4yLb/iRjDqFH8SNp
	 mRC8Nrt87d/PLIbBCYzCzy38NwcnO0xJz2OhjXb4gT4d6TEtktVNgALdRUDSc2jBw003a
	 SuBZp2alCLmOUqjzaDXqTsR2qMYwTw9FlQhO+02DcXXboFpVVBaERbD1U6P3Ida33Cj8V
	 MaNr+0B/AxwvENf9k7fROA44JUudAUAU+CS4RlifkQ2YnmBAM5vd9gb7i+Ty9fcIoEPZo
	 Gy5ZU7cj1Feu1aiG15UPhvVacEfH4XhC0yqANLUGEH1cSKVfTQMDUGkEGO61VeRY68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAxGp9zl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA76606A322;
	Tue, 27 Oct 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAxGp9zl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2041F01825;
	Tue, 27 Oct 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119663;
	bh=0sC005GcKM377GTiHOuPAcvdGYQ3vuMZ7FcYBR6FIjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WAxGp9zlDcVvkx1U+jPVffH/pA34ZBzW59aj/Lg/rqqV4wApXEGwzq565lRGDz2qS
	 yyt2CbbYFgo6a52mmLoSV6w2KhQL5UWkkMJTjrzU6HHJFRyzwgC0CZZFSsWk89Y4KD
	 VmyzSbFIdqjPdLyO5f/n/GN9cBrMfTE6AhWqHfYJ7HYRFiw7ybdj4/XQ1yj8z3GuUI
	 OPGH6T58iz6Bf5yLddiU9bRhNdQbjlGKwERk2emTiyD+ix7wXIICHvxMQDuN2/6qW7
	 ccFsYUvimDIKigvulLjVF/cyN/+CZVUEB68OUqb31XM13d8XFHKcxO/RbLJViumVuz
	 /DGGSF7OmgEqw==
Date: Tue, 27 Oct 2026 16:47:39 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org,
	Michael van der Westhuizen <rmikey@meta.com>
Subject: Re: [PATCH] mailbox: pcc: Complete the transfer when the platform
 flags an error
Message-ID: <20261027-impartial-nano-sheep-5ccf53@sudeepholla>
References: <20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org>
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
In-Reply-To: <20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org>

On Tue, Oct 27, 2026 at 08:19:14AM -0700, Breno Leitao wrote:
> A single error reported by the platform stops all later traffic on a
> PCC channel whose client relies on the controller to complete
> transfers, such as the SCMI PCC transport. Every later request on the
> channel times out.
> 
> When the platform completes a command and sets a bit in the Error
> Status register, pcc_mbox_irq() acks the platform interrupt, clears the
> error and returns IRQ_NONE without calling mbox_chan_txdone().
> 
> No other interrupt arrives for that transfer, so the mailbox core keeps
> it as the active request and holds back every later message.
> 
> The chan_in_use flag also stays set, so on a shared interrupt line the
> next interrupt raised for another subspace passes the checks in
> pcc_mbox_irq(), since Command Complete is still set, and runs the
> success path on the failed transfer.
> 
> Log the error and complete the transfer with -EIO instead, clearing
> chan_in_use first as the success path does. Skip
> mbox_chan_received_data(), as the shared memory holds no valid response.
> Use -EIO rather than the helper's return value, which is a positive
> acpi_status when the register read fails.
> 
> Clients that wait for the rx callback still time out on the failed
> transfer, but the channel works again afterwards.
> 

Nice, finally good to see this driver and various error paths being tested
on real platforms. Thanks for finding the issues and the fix.

> Fixes: 9c753f7c953c ("mailbox: pcc: Mark Tx as complete in PCC IRQ handler")
> Cc: stable@vger.kernel.org
> Suggested-by: Michael van der Westhuizen <rmikey@meta.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/mailbox/pcc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 14dc4a187bfc67..e5df604b367a4a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -315,6 +315,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> +	int ret;
>  
>  	pchan = chan->con_priv;
>  
> @@ -333,8 +334,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	if (!pcc_mbox_cmd_complete_check(pchan))
>  		return IRQ_NONE;
>  
> -	if (pcc_mbox_error_check_and_clear(pchan))
> -		return IRQ_NONE;
> +	ret = pcc_mbox_error_check_and_clear(pchan);
> +	if (ret) {
> +		/*
> +		 * No other interrupt arrives for this transfer, so complete
> +		 * it here or the channel stalls. Skip the rx callback, as the
> +		 * shared memory holds no valid response.
> +		 */
> +		dev_err_ratelimited(chan->mbox->dev,
> +				    "PCC subspace %td: transfer error %d\n",
> +				    pchan - chan_info, ret);
> +		WRITE_ONCE(pchan->chan_in_use, false);
> +		mbox_chan_txdone(chan, -EIO);
> +		return IRQ_HANDLED;

Since we are returning IRQ_HANDLED, can we merge this path with the code
below ?

	if (ret)
		dev_err_...

	..
	if(!ret)
		mbox_chan_received_data();

That should work right ? The reason I prefer this way is the comment for
WRITE_ONCE() applies above as well. Instead we can reuse the path. Let me
know what you think.

-- 
Regards,
Sudeep

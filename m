Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195482;
	b=01Yx6VqV6r2m1PTEmJpH+h2HvFqgbn1+mAGF4beT4LTEqjnq0AJ5LLf9GsHIb1YBaKkW
	 52BYF85y3Fvihr9M4IcndCTVNvfeMrMq0yfqgCvRo3ncMpCkRjtSmgKrFjn/hr4oRoF+4
	 lmJWkPXH8/Xa3On9bG1zS3VpYrPCYcUtKWDHSlwn/R3KU6YcgHtxUHbUTf32votluML9v
	 RL2m6HcMwP7Pd6zyHPCjLcOaR/gpvubEJuJiLUKFzgDBUDF70Dg8HcXQLFnLhu0e4TT7S
	 6FuOanVRs6BmFTMRYe0xfIAld1jFFA1sxgQfMPX8TJLS4xWK5yX1BKmlKv7h3Dq9v8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qEPuHbLUFhIg7Nc34gvGhjfwD/qRgaDyFG1QfwzOiQs=;
	b=Ewffxr3XLODq+YMEGMzGU/ZMOzzdwK+yYm19kZqUtjecMi1SQm/XyCdvtw+VBj4FZHwA
	 PibO8K2EOOnNmVhZ7iI8Z/HepgW1HbiFyTdyCYCtuqc7MasXVsI9mzdy/g6I8Qf5m/baP
	 5nsmvoada6suid3t/V1+slvWjBkyqJ1A5pBn8CRlypUABTQsRKYARWnZShqRLMReWfSMC
	 hn4/0N4Rge9COlnS9o5uLfcga7dZi/eVlchuOn8PC0Rbp0TQL9ECeOeG2iW+NZeiadnE6
	 kPzXQHFsrMnZFg3AsMto7Wd7jkKH2umIEhDT29QdL+utW06fj6gh9EB3Tt51fyGqemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGerq6Fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94919606A31D;
	Wed, 28 Oct 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGerq6Fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36AF1F01825;
	Wed, 28 Oct 2026 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195482;
	bh=qEPuHbLUFhIg7Nc34gvGhjfwD/qRgaDyFG1QfwzOiQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gGerq6Fq3OYM1kw4OKAZUncDjtiLc5GXcpJm8VKfS8UqPoETGNz0SFzANMb8L7RQ/
	 trz+01mvssquECjtHRyUtkr8hNtv8817eplVkB8YL8bpINIJGRXTqp30siSHJHlF6m
	 Ef8b3N2AG8pJdagpzEnSoKYqE/vATLxfgybfevNaDcD8S8/fhMRQfbiYpV3P5Iz79Q
	 RX+QXjWoNP6ptgVNvWdAyjbgz3tFL4WxOu7CAh1/SypgcVYYVLbQKMFVHhs0rCoiOv
	 dhet41JxEJLi7uk1GDI8wEe+naX2vXuIb857i8i6DLMT1bbmT6KY6sXJX2hBCGUH2X
	 98KXRe8l4rFEQ==
Date: Wed, 28 Oct 2026 13:51:19 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org,
	Michael van der Westhuizen <rmikey@meta.com>
Subject: Re: [PATCH v2] mailbox: pcc: Complete the transfer when the platform
 flags an error
Message-ID: <20261028-agouti-of-noble-shopping-35e61d@sudeepholla>
References: <20261028-pcc_error_txdone-v2-1-4ca7ba3e45c9@debian.org>
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
In-Reply-To: <20261028-pcc_error_txdone-v2-1-4ca7ba3e45c9@debian.org>

On Wed, Oct 28, 2026 at 06:35:30AM -0700, Breno Leitao wrote:
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
> Log the error and fall through to the completion code, which clears
> chan_in_use before calling mbox_chan_txdone(). Skip
> mbox_chan_received_data() on error, as the shared memory holds no valid
> response, and complete the transfer with -EIO rather than the helper's
> return value, which is a positive acpi_status when the register read
> fails.
> 
> Falling through also runs pcc_chan_acknowledge() after an error. It
> only acts on responder subspaces, where the platform notification is
> now acknowledged but not passed to the client.
> 
> Clients that wait for the rx callback still time out on the failed
> transfer, but the channel works again afterwards.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

> Fixes: 9c753f7c953c ("mailbox: pcc: Mark Tx as complete in PCC IRQ handler")
> Cc: stable@vger.kernel.org
> Suggested-by: Michael van der Westhuizen <rmikey@meta.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Fall through to the completion code on error (Sudeep)
> - pcc_chan_acknowledge() now also runs after an error, which only
>   affects responder subspaces
> - Link to v1: https://patch.msgid.link/20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org
> ---
>  drivers/mailbox/pcc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 14dc4a187bfc67..0d36aa511a9d02 100644
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
> @@ -333,8 +334,11 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	if (!pcc_mbox_cmd_complete_check(pchan))
>  		return IRQ_NONE;
>  
> -	if (pcc_mbox_error_check_and_clear(pchan))
> -		return IRQ_NONE;
> +	ret = pcc_mbox_error_check_and_clear(pchan);
> +	if (ret)
> +		dev_err_ratelimited(chan->mbox->dev,
> +				    "PCC subspace %td: transfer error %d\n",
> +				    pchan - chan_info, ret);
>  
>  	/*
>  	 * Clear this flag after updating the interrupt ack register and before
> @@ -343,8 +347,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	 * the lockless update observed by the send and interrupt paths.
>  	 */
>  	WRITE_ONCE(pchan->chan_in_use, false);
> -	mbox_chan_received_data(chan, NULL);
> -	mbox_chan_txdone(chan, 0);
> +	if (!ret)
> +		mbox_chan_received_data(chan, NULL);
> +	mbox_chan_txdone(chan, ret ? -EIO : 0);

This works as well, you can ignore my last suggestion.

-- 
Regards,
Sudeep

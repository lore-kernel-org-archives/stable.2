Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193124;
	b=DA+gfZk2ND6QS8x4Cj2+OnXnASqNSEHFc7Qx5rVmoHZKDjcn7Y1SKvcHKvBEH0KMgmTG
	 EoLBbkVUc+HZ1tXTYLQLlgHXYuN4HJy4/ZkhI4AY3ntQt3I/gQo/UQvLlJvihLk4mH4e2
	 7Mot9kLjBKWcmPD2M+05pRzZb5Mg7VRAqWW0nruj6ACDCK4Qn6K3Czec+3PAATpsEPtco
	 2FfRGJBPMaRJsI62bM+PcPQpSleO3E2Gd762tkt8pL7wuzjEQGmZMnaHF8+HV9hQPyJA3
	 +x5nrreUDBbgwe4KLcKluyHpdie7LPO9j6DQAPc/1o0ncMsnFea8OPIkOBpb3RSjcIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193124;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=Bp4vJGBpqKH9AbKEW4/olf2F1j4LMnQbDmSSb8E21Pw=;
	b=lN2/PhFjMHIDLM3xCMqwuVi1SiU3TuYXpJOMmG7BknkMN5FTk2FYe6pu5QHc0lQesDIs
	 R9UxEsFqahCdNK58GEYllOsb7Lf133L2PAx1E7YCr1gbKNYBkO47RoeoNoIiACn02+WuB
	 DmSQFmZKfChuO7vZIJlmdRxiLZhJLbARFkNs5/Yhrtu3+y/fV4kOIOGLp1H5CCMXIJw1G
	 d31EZMsHcsxm0FY4Y89dAIHfaGYgy6Nx8l9BvAbiI018dvT4myoBnUPv3d3hAdtuy0oOE
	 mWFN1eawt8D8vFaBP8Yt0JI90vsughF2zGaZ0qc0fWJURYAwDE36gDDLMFw5FuxidAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MdQzamkR;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BB606A31F;
	Wed, 28 Oct 2026 13:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C20BB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MdQzamkR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bp4vJGBpqKH9AbKEW4/olf2F1j4LMnQbDmSSb8E21Pw=; b=MdQzamkRsBI3qQToGXMCk1wbBp
	Jd5qGzWKjEb4wjHIZ7EDrjXpqJapTEyPZflb5wJUOOATATafft8JUIco9xy+Oln4CsuG0oB7pYIuM
	rqut3rOFHR/snrt83cjkxCVf6lonuJ2qi+6WdhgJaF0i8kfVzhGHLK5HjLzNiXCQW2ilUq5fEQiYo
	R5CrEYmyDRFQkx7Thxvz8NwSqjkFCz6HGcs9QL9LOjLldHDGNco92iEMBaEUn4KRjde3iKeSotrxg
	D7SifpaEl/yUYdXOL5ahaRPdVWrZPR3CnMEuxJ1RpaPwKpvtewLUYV29W1j09nU8Q2ISlAsIWd7ar
	cRCIN2Xw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xM3Rf-002GYk-0K;
	Wed, 28 Oct 2026 13:11:59 +0000
Date: Wed, 28 Oct 2026 06:11:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
	Michael van der Westhuizen <rmikey@meta.com>
Subject: Re: [PATCH] mailbox: pcc: Complete the transfer when the platform
 flags an error
Message-ID: <auH0RK4oBOd3JxFU@gmail.com>
References: <20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org>
 <20261027-impartial-nano-sheep-5ccf53@sudeepholla>
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
In-Reply-To: <20261027-impartial-nano-sheep-5ccf53@sudeepholla>
X-Debian-User: leitao

Hello Sudeep,

On Tue, Oct 27, 2026 at 04:47:39PM +0000, Sudeep Holla wrote:
> On Tue, Oct 27, 2026 at 08:19:14AM -0700, Breno Leitao wrote:
> > Clients that wait for the rx callback still time out on the failed
> > transfer, but the channel works again afterwards.
> > 
> 
> Nice, finally good to see this driver and various error paths being tested
> on real platforms. Thanks for finding the issues and the fix.

Cool, this will definitely get more eyes now on.

Michael deserves the credit for finding this and proposing this fix,
honestly. He is looking at all of this.

> > @@ -333,8 +334,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >  	if (!pcc_mbox_cmd_complete_check(pchan))
> >  		return IRQ_NONE;
> >  
> > -	if (pcc_mbox_error_check_and_clear(pchan))
> > -		return IRQ_NONE;
> > +	ret = pcc_mbox_error_check_and_clear(pchan);
> > +	if (ret) {
> > +		/*
> > +		 * No other interrupt arrives for this transfer, so complete
> > +		 * it here or the channel stalls. Skip the rx callback, as the
> > +		 * shared memory holds no valid response.
> > +		 */
> > +		dev_err_ratelimited(chan->mbox->dev,
> > +				    "PCC subspace %td: transfer error %d\n",
> > +				    pchan - chan_info, ret);
> > +		WRITE_ONCE(pchan->chan_in_use, false);
> > +		mbox_chan_txdone(chan, -EIO);
> > +		return IRQ_HANDLED;
> 
> Since we are returning IRQ_HANDLED, can we merge this path with the code
> below ?
> 
> 	if (ret)
> 		dev_err_...
> 
> 	..
> 	if(!ret)
> 		mbox_chan_received_data();
> 
> That should work right ? The reason I prefer this way is the comment for
> WRITE_ONCE() applies above as well. Instead we can reuse the path. Let me
> know what you think.

Ack. Let me update and respin.

Thanks for the feedback,
--breno

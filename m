Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193577;
	b=Xm3tC3mhhOyrEywu7kcYDvegueDHRsMnRsaABnfHlBbUKwFdC8xxoW0jd9dYSfiiaLyf
	 gEpyH+QLL6ITIw5/vCY01CgW84SPHfvZYlJhSAjUAiv0YBonKwQAWFEW2Vnr0ra1bkdo/
	 2WwhDLc2t8oq+8IT6kdFIn15iemAn/r2iIdNv2a+BMnlf760e4yx65YVOh/0/eCzOWBBd
	 A0MQSgnVtU0X/JBUc0T0DkIGojYz3hoVGxfkw/dIzmXdQdripX+mMOskI6sWQ5Ss2jY5K
	 GAv0oDJXuazY8b/wnBEOxnPUxYliG7IJW+BPj0qHMIOs7ApceWr02qzRns+0hG5vDeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O/Vr2VTjLRR5tcfRRxSQ0QkmIHWcbbub6EAxBlCYM5I=;
	b=FQaPLRU4MvgqY/5z1Rg7Hy+YJ+EpxAjc4L+DUjNLbVfTMWjzAKZrrS812eXg48mH0CRc
	 TzxmMWIQd9CqIAgtSKsRw+V1B04vIZCroFpPpRywveulvIK48uUnWESNf6Ew/HfOgYXJs
	 8jTT2vT35ScbtG+xlKCTK91BMwB5O5FYbpeOQyk46t59U563ZUgaQTwYDGKhv6JiCQLhR
	 m6ny5nbWA1/fKDt5U5vBwjvFmhTRTfUvftpr/wexBI1BocAnkc07Sa2oxeSGUWh45Cs5t
	 zOoNGBjabXW3sXMFBi2Jd90wDtnd8NaXe7l2IzCnxIhko5rtKbjX0pfRV18+hL4bTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ab2kUtEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E148606A31A;
	Wed, 28 Oct 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ab2kUtEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CF71F01825;
	Wed, 28 Oct 2026 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193577;
	bh=O/Vr2VTjLRR5tcfRRxSQ0QkmIHWcbbub6EAxBlCYM5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ab2kUtELL9MchJORZk7KUxyXZf+U0PIDubjlKMvw4mSIp4w77qg8vqnz+hExlYgI5
	 7JVsgDFJAng5kZJIMoeL+Ngjohe7klpBv2WAANQAudz8reKRWCYCdrA5I8RUuv19pn
	 D5X0Q0pe/uf/hr0vJgJ/nUevJsSh3Z7Sps/thAHHzDPdNokw8cFb0jP62nrkANvkq0
	 SU1QtFb+zFbeBYmpFjNRXREssSldquy5HtAInaXS6HQynLbvvsjig9wxSQHBsI0YH3
	 M/nImGGaS89OODSTa1GPP0chwe2Bs5RgGbs+SLx7jhZL15TCc/V11CpWIKtulewtMs
	 VX/Bz9O8KwdIA==
Date: Wed, 28 Oct 2026 13:19:33 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org,
	Michael van der Westhuizen <rmikey@meta.com>
Subject: Re: [PATCH] mailbox: pcc: Complete the transfer when the platform
 flags an error
Message-ID: <20261028-terrific-manatee-of-enhancement-9da7ae@sudeepholla>
References: <20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org>
 <20261027-impartial-nano-sheep-5ccf53@sudeepholla>
 <auH0RK4oBOd3JxFU@gmail.com>
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
In-Reply-To: <auH0RK4oBOd3JxFU@gmail.com>

On Wed, Oct 28, 2026 at 06:11:53AM -0700, Breno Leitao wrote:
> Hello Sudeep,
> 
> On Tue, Oct 27, 2026 at 04:47:39PM +0000, Sudeep Holla wrote:
> > On Tue, Oct 27, 2026 at 08:19:14AM -0700, Breno Leitao wrote:
> > > Clients that wait for the rx callback still time out on the failed
> > > transfer, but the channel works again afterwards.
> > > 
> > 
> > Nice, finally good to see this driver and various error paths being tested
> > on real platforms. Thanks for finding the issues and the fix.
> 
> Cool, this will definitely get more eyes now on.
> 
> Michael deserves the credit for finding this and proposing this fix,
> honestly. He is looking at all of this.
> 
> > > @@ -333,8 +334,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> > >  	if (!pcc_mbox_cmd_complete_check(pchan))
> > >  		return IRQ_NONE;
> > >  
> > > -	if (pcc_mbox_error_check_and_clear(pchan))
> > > -		return IRQ_NONE;
> > > +	ret = pcc_mbox_error_check_and_clear(pchan);
> > > +	if (ret) {
> > > +		/*
> > > +		 * No other interrupt arrives for this transfer, so complete
> > > +		 * it here or the channel stalls. Skip the rx callback, as the
> > > +		 * shared memory holds no valid response.
> > > +		 */
> > > +		dev_err_ratelimited(chan->mbox->dev,
> > > +				    "PCC subspace %td: transfer error %d\n",
> > > +				    pchan - chan_info, ret);
> > > +		WRITE_ONCE(pchan->chan_in_use, false);
> > > +		mbox_chan_txdone(chan, -EIO);
> > > +		return IRQ_HANDLED;
> > 
> > Since we are returning IRQ_HANDLED, can we merge this path with the code
> > below ?
> > 
> > 	if (ret)
> > 		dev_err_...
> > 
> > 	..
> > 	if(!ret)
> > 		mbox_chan_received_data();
> > 
> > That should work right ? The reason I prefer this way is the comment for
> > WRITE_ONCE() applies above as well. Instead we can reuse the path. Let me
> > know what you think.
> 
> Ack. Let me update and respin.
> 

Thanks, I just realised, I didn't express what I was thinking correctly.
Something like below to be precise.

Regards,
Sudeep

-->8

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 14dc4a187bfc..d7239efe4aba 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -315,6 +315,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
        struct pcc_chan_info *pchan;
        struct mbox_chan *chan = p;
+       int ret;

        pchan = chan->con_priv;

@@ -333,8 +334,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
        if (!pcc_mbox_cmd_complete_check(pchan))
                return IRQ_NONE;

-       if (pcc_mbox_error_check_and_clear(pchan))
-               return IRQ_NONE;
+       ret = pcc_mbox_error_check_and_clear(pchan);

        /*
         * Clear this flag after updating the interrupt ack register and before
@@ -343,8 +343,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
         * the lockless update observed by the send and interrupt paths.
         */
        WRITE_ONCE(pchan->chan_in_use, false);
-       mbox_chan_received_data(chan, NULL);
-       mbox_chan_txdone(chan, 0);
+       if (ret) {
+               /*
+                * No other interrupt arrives for this transfer, so complete
+                * it here or the channel stalls. Skip the rx callback, as the
+                * shared memory holds no valid response.
+                */
+               dev_err_ratelimited(chan->mbox->dev,
+                                   "PCC subspace %td: transfer error %d\n",
+                                   pchan - chan_info, ret);
+               mbox_chan_txdone(chan, -EIO);
+       } else {
+               mbox_chan_received_data(chan, NULL);
+               mbox_chan_txdone(chan, 0);
+       }

        pcc_chan_acknowledge(pchan);


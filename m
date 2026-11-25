Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587820;
	b=V1PkE6BEI90YnBEo2/mzaLHzfqVTTfOjEKn7yArudDw1E8+hOvz35OvkorAVfAkuJ/z5
	 g+brZMutP5CBpid6SO/sI6lp3Bs6ej1OgsxAqNrus3OkfbQI3NURDPf6b43vPqMmuK7cD
	 NB4FvaH9SkaOc6xRy0d+EyOgV2C5nmbAqu5rOl2MYHIo6TPcCxHqt0EPesvkd8rkiCJtK
	 TYSAw+znIjwsZOvgsex1hQdUGl5LtajSxvl4nFUgG6ayx0RIwhc1wQfbe7dsVOqVFR/ax
	 4t/pr+TpYdckUyHzMsxIPtBJufCLUa8Ylsn/+uYOSSJbW90kh4aDlW8IOcXv0lQ7Q8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587820;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s5PlVsi6j4PvwLFvzjlO8NbEFYTNc4HGfVml1EHrjaA=;
	b=ST7ZZKpp/UQom+LZQqAnzRJMl4AgSbLDeZ4tSgZ4O8FSHjpifeQ+jeFTynXi2hht2cy6
	 r5yDjrY9xJTUBUzEEbOX83+F3V6aWJjKwndLm69/CeyAzNJNdIPLjL7yCjVr3/d0qIdJp
	 Ua8VgDOJa+J7JQuRIA6IRtpu0Fgv7aQKBOIb+qUON1xfQrAc8hc5Dvht9cgUsAiru5Pju
	 ddH95W2OLY3ecbqkFOVvxoF7Kpp+3wiGXicWwcxPBoNHgeOavBTcGBofQ7HwP0UphPd/6
	 9mLqqSeQf18LGIxA80ybSTEtlG1O7q7TT53Vsd3tH7KaCg4nJjLCeuP9BkvsH0lpZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dOMkWo0d;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F91606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F91606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dOMkWo0d
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y3jaNmWJOqYutmStsJnp8wnWyR5lazjqbdgklsvcTjE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795587817; v=1; x=1796192617;
 b=dOMkWo0d8gIR5V+S8JNxea0btYSs2W7dv1iQsDXKmQWAuokF4ruaE8AussKZ5h4RlBEimGjC
 pakPKqptB/Oc2x0CK5dQJETwixSy1kb/lYAnTWLm7FAn+Cxer8CVYl1q2QpUGAJPLyIHMD/5QKi
 JPzhrU2ylRf378a/D2Wtg6Aw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2629535c16105de2;
	Wed, 25 Nov 2026 06:23:37 +0000
X-Mizu-Trace-ID: 2629535c16105de2
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 07:23:34 +0100
From: Richard Leitner <richard.leitner@linux.dev>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/10] remoteproc: imx_rproc: Avoid stale mailbox
 pointers on request failure
Message-ID: <awZ-XC1efo5QQvNI@bombadil>
References: <20261123172140.3547896-6-lee@kernel.org>
 <20261124032344.5314-1-peng.fan@oss.nxp.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261124032344.5314-1-peng.fan@oss.nxp.com>

Hi Lee, Hi Peng,

On Tue, Nov 24, 2026 at 11:23:41AM +0800, Peng Fan (OSS) wrote:
> Hi Lee,
> On Mon, 23 Nov 2026 17:20:49 +0000 Lee Jones <lee@kernel.org> wrote:
> 
> > imx_rproc_xtr_mbox_init() stores the result of
> > mbox_request_channel_byname() directly into priv->tx_ch and priv->rx_ch.
> > Because mailbox channels are freed on stop() and detach() and
> > re-requested on start(), attach(), and system shutdown, a failure while
> > requesting "tx" leaves an ERR_PTR in priv->tx_ch, which is later
> > dereferenced by imx_rproc_kick() and imx_rproc_free_mbox().  If "rx"
> > fails after "tx" succeeds, priv->tx_ch is freed without being cleared
> > while priv->rx_ch retains an ERR_PTR, causing subsequent calls to see
> > both pointers as non-NULL and skip initialisation, leading to a
> > use-after-free on priv->tx_ch and an ERR_PTR dereference on priv->rx_ch.
> > 
> > Request both channels into local variables and assign priv->tx_ch and
> > priv->rx_ch only after both requests succeed.
> 
> I think Richard Leitner <richard.leitner@linux.dev> is working on this.
> 
> https://lore.kernel.org/linux-remoteproc/CANLsYkx=M_TXN10qAcQC0be065TYnzfOae6E8ss-9DTj9MzogA@mail.gmail.com/T/#ma2f8e4c332d47e5bdd1787f82f4dd2feeafc67d6

AFAICT my series fixes a similar, but other problem. Mine is about the
free'ing order and a possible race when a kick occurs during
cleanup/close. This one is targeted towards the setup/initialisation.
Therefore IMHO this is a valid, fix for a different problem than mine.

What's your opinion on this Lee?

reagards;rl

> 
> Regards
> Peng
> 
> > 
> > Fixes: 99b142cf7191 ("remoteproc: imx_rproc: Request mbox channel later")
> > Closes: https://sashiko.dev/#/bug/linux-ac0f248a-bdfd-41da-95f8-44b8f1f7091d
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 581bb07f5893..a77a3342e1ed 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -875,6 +875,7 @@ static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> >  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> >  {
> >  	struct imx_rproc *priv = rproc->priv;
> > +	struct mbox_chan *tx_ch, *rx_ch;
> >  	struct device *dev = priv->dev;
> >  	struct mbox_client *cl;
> >  
> > @@ -900,18 +901,21 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> >  	cl->knows_txdone = false;
> >  	cl->rx_callback = imx_rproc_rx_callback;
> >  
> > -	priv->tx_ch = mbox_request_channel_byname(cl, "tx");
> > -	if (IS_ERR(priv->tx_ch))
> > -		return dev_err_probe(cl->dev, PTR_ERR(priv->tx_ch),
> > +	tx_ch = mbox_request_channel_byname(cl, "tx");
> > +	if (IS_ERR(tx_ch))
> > +		return dev_err_probe(cl->dev, PTR_ERR(tx_ch),
> >  				     "failed to request tx mailbox channel\n");
> >  
> > -	priv->rx_ch = mbox_request_channel_byname(cl, "rx");
> > -	if (IS_ERR(priv->rx_ch)) {
> > -		mbox_free_channel(priv->tx_ch);
> > -		return dev_err_probe(cl->dev, PTR_ERR(priv->rx_ch),
> > +	rx_ch = mbox_request_channel_byname(cl, "rx");
> > +	if (IS_ERR(rx_ch)) {
> > +		mbox_free_channel(tx_ch);
> > +		return dev_err_probe(cl->dev, PTR_ERR(rx_ch),
> >  				     "failed to request rx mailbox channel\n");
> >  	}
> >  
> > +	priv->tx_ch = tx_ch;
> > +	priv->rx_ch = rx_ch;
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.56.1.750.gf70dc682cf-goog
> 
> Sent using hkml (https://github.com/sjp38/hackermail)

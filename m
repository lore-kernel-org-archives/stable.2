Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F954A8A02;
	Sun,  4 Oct 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147579; cv=none; b=SwgFA9HxYUCBwEmy8BwKo7N8iBq83GK4FOgz3neRdkFt1Mxu6v84LlVk/iL4ro3fFqGiVuH9l8WRkAr2uF9ovl7sBdYXLRPWtsSblIc0zX/gXeTUgvrex0mrbpK5um28I546FxYsXlKEBozd0iHVa6ODbX8jaQO8NxpKuu71Lbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147579; c=relaxed/simple;
	bh=XkDIK+kDMZoux3wnyYUju0oypJWXDgUzUM8XZO01LvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zg88aWLn43+G2DJEI8GAlbYZjwFNHA2hiQVobwEqC266HNCL7u85AkznWyVZM6ItNavJSmfDwwpLLsX4n0DmehhNAAhpEsz2CCL8mCkJd318jViyybR+O2WfTUgUimZq3Ay2tRAP5/iCLZ+WXd3D0Ic0+8XgYE6dX5ET8bMmVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R5MhibdL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R5MhibdL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9CEE04E41168;
	Sun,  4 Oct 2026 20:59:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FCD2604FE;
	Sun,  4 Oct 2026 20:59:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 743B51032820F;
	Sun,  4 Oct 2026 22:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791147575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vohrb5V1KeZjWFJvnekJSowhri1TxmAAFkd3CYedWM4=;
	b=R5MhibdLhAsyV1FnhLgjHtfcNcym/8vBxbj/AvI1Gao4xBKStMY9IY/AzrImfcmb5iycnk
	/Jb97mzekLhAhgCSv8yaV0HdItyruCxpUOtbUuY6rsQvXOVMFHXDmGBS6xG/uiP3TrNOVu
	EYHYHroYChOYE5V+rEBtykSjyAftXBwZYpBHw+W7T+dW/Al0rogHu/d4gWieDmCT2mucXD
	adSj/kVdBpUTtcI8SKYdBTLnLuIv5AuGlzOX4ucSRoC529pdw8rAgc656hCM6nc6MEWK0l
	7pJj4ZkkiQ7IrfrNgqMBC7VdzkEPHkAS8GzX52HtQaqWdCwJ014z2W7RhMEYQg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  David Laight <david.laight.linux@gmail.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length
 upfront in ca8210_skb_rx()
In-Reply-To: <20260930071914.421586-4-benquike@gmail.com> (Hui Peng's message
	of "Wed, 30 Sep 2026 07:19:14 +0000")
References: <20260930071914.421586-1-benquike@gmail.com>
	<20260930071914.421586-4-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 04 Oct 2026 22:59:33 +0200
Message-ID: <87pkxpji6i.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Hui Peng,

>=20=20
>  	msdulen =3D data_ind[22]; /* msdu_length */
>  	if (msdulen > IEEE802154_MTU) {
> @@ -1778,9 +1774,25 @@ static int ca8210_skb_rx(
>  			&priv->spi->dev,
>  			"received erroneously large msdu length!\n"
>  		);
> -		kfree_skb(skb);
>  		return -EMSGSIZE;
>  	}
> +
> +	if (len < 30 + msdulen ||
> +	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
> +	     len < 29 + msdulen + sizeof(struct secspec))) {
> +		dev_err(&priv->spi->dev,
> +			"received truncated data indication!\n");
> +		return -EMSGSIZE;
> +	}

I'm sorry, but this is pure AI illusion of security. I'm pretty sure
this check is tailored to match your very specific need but has no
meaning except just covering the very specific case initially
discovered. I don't know what to propose, but I can't send a Reviewed-by
for that.

Miqu=C3=A8l

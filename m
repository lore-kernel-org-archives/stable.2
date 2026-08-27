Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6B3DC4D7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821911; cv=none; b=nl5CZOcjN/lbLasAvHHZLfLXHoD5sLfrupyqEIrLlUUr6Yb3UtnGvCAAZYZthOuzSoEZNxMo+pYDqG2tP2SQoQDWNNwIkGIOA5eYU+bqAFQHfq/3dO/jHFjDBk4T2zunDbPyAvNPTpQ5zhgR6ANGLaQYTd0GeINCXzMu5y/l4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821911; c=relaxed/simple;
	bh=I/g6L0lTHz9tiQmU1+A7hAz8H6hXJSgJy/sNvVa3BPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGjf/Vz2h1ild+2srEEc3ltDPbiRQ6MKHB4UN822JFXW4GrkRkpqPtNm5rm0ZVtaa0PCM/b9ZIl7mea1Um6b/Sferok37eMUF+JR0eqpARWV1c1yT6TzYK6tgFbaTXsHUWmsokQVKggkLwFaasMBkPAmegXwxr1qtjIER19WrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u7K2y7p0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u7K2y7p0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 134161A1860;
	Thu, 27 Aug 2026 09:11:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D3AC9602B8;
	Thu, 27 Aug 2026 09:11:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 528E511C783F8;
	Thu, 27 Aug 2026 11:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787821902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r/gaq+SrX4PzjOnu9XOJafoc9PyaO05ymSFA8G0Ye2w=;
	b=u7K2y7p0e9SWlptuGTekg0xfDj97seqbyXVCHI6OyL4P5Q8IedunWzYt1XonpmA1NL9H7r
	x+1A01RFWT1CwTwAFbaeIJmsTG9K3JikIF8MmMPWjvJppxahiAcU6zkirl9BCCOO4iaB8T
	txXgNjM9ZpeT9R2WCXYLIBSdXAH9QQ1KtVZ0iPZQ9PTv7H+JpSA59/m/okRLiArDrjj76+
	FFxM88gLTtQIfBU185H06O4V0rS/Fv3C+5y0csZF1Mzqn/1f87mBspyI0S7XbEpfWN81ba
	1zJiHB8VgJ3CHYDk3JR+2tpaUGcxpGGPRriSELXIzEc0tzmFbHF67V44iki33w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: fix data race and NULL deref on
 local->assoc_dev
In-Reply-To: <20260826225959.682483-1-skwkevin@mail.ustc.edu.cn> (Kaiwen Shi's
	message of "Thu, 27 Aug 2026 06:59:59 +0800")
References: <20260826225959.682483-1-skwkevin@mail.ustc.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 27 Aug 2026 11:11:37 +0200
Message-ID: <878q5sdj1y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Kaiwen,

>   - cache the coordinator extended address instead of retaining the
>     assoc_dev pointer, as suggested by Miquel;
>   - use a plain spinlock to serialize the cached address and associating
>     bit, including 64-bit address accesses on 32-bit architectures;

Can you justify the choice of a spinlock vs. mutex here? This is an open
question, not a request for changes.

>   - reset the completion under the same lock, recheck the associating bit
>     in the response handler, and complete before releasing the lock;
>   - use the response payload in the debug message;
>   - add Cc: stable@vger.kernel.org.
>

...

> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -578,9 +578,11 @@ int mac802154_perform_association(struct ieee802154_=
sub_if_data *sdata,
>  		return ret;
>  	}
>=20=20
> -	local->assoc_dev =3D coord;
> +	spin_lock(&local->assoc_lock);
>  	reinit_completion(&local->assoc_done);
> +	local->assoc_dev_extended_addr =3D coord->extended_addr;
>  	set_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
> +	spin_unlock(&local->assoc_lock);
>=20=20
>  	ret =3D ieee802154_mlme_tx_one_locked(local, sdata, skb);
>  	if (ret) {

Shouldn't we also make sure that accessing assoc_status/assoc_addr is
serialized? Typically, I believe the IS_ASSOCIATING bit should be
cleared earlier in mac802154_perform_association(), just after the
wait_for_completion call returns. This way, in case we get two responses
for the same request (maybe a malicious one), it will prevent the
possibility to get incoherent assoc_status and assoc_address.

Thanks,
Miqu=C3=A8l

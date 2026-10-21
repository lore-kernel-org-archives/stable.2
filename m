Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585841;
	b=tXYTRdDdjmJ19Lsa1KX6FXJNX0EUyZ3oBjnlWZ+3uuHj7e/t57PO9q96By9gVlR1sUNo
	 zcTW4PeF4yU6srzoyWoz7FNzvWL8oc58v/nPfAcUJEm3IpC7ZnWzlHcWyvoyHXuEZTypq
	 bFpeaGFFo3iCKFYDLc949N1wEv+1B67boojb+Y3UMmWFRL4PkBZ4ibmR7YXm1elhxWYhq
	 Jc+P0HWBp3j990h9rtnTcwx6ZC6ZU62a1H2p1I+DYKmUH9hM2Skspi7n1BztXWA4MB86a
	 2S7nPj88mJZAcfVkAS1AUcZlJX75R94IHm3ptFLPWH0VG4t/GNtDPCZfeU0Ro5T1gOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585841;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PsGZ3bmzdFosUneF9Bvm3soEaaPgbEeBsx0mbJ6pWlc=;
	b=x08rPRwPeAYdHy9ELo3CICSV6uuYkwyd8xAA/kn+gPz7QoyaZaTeLaE6lMxh/9Lc4hsd
	 wHPq+tUqa6gpA6sTkGqRLAtBGD97V/2Hnm7HE4n4LOaCO1LI8v0w+Jt3wLADi1PPb501B
	 dVYBnQ5nP15Pqju4piHHRRZEKy7+Viry74g6b5PnQqevgbbJArbM/SNOlgOC0QEFQAd89
	 PRlbTwfRg64S8NCV4NDatSetB9vqWzraUs87/uPuuobKwyVdIcnAR97jhxGp5AZAD92j4
	 Hcwf+N0jrEijrEehBaKgN51psWOUEMnzSwfRc7zxN2Yd9IFn8pJ9b3YYvzLwtX60WZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FWgNutN2;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3487606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3487606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FWgNutN2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 111F5C5CD75
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F5C6606E3;
	Wed, 21 Oct 2026 12:30:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF74810328D6E;
	Wed, 21 Oct 2026 14:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792585836; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PsGZ3bmzdFosUneF9Bvm3soEaaPgbEeBsx0mbJ6pWlc=;
	b=FWgNutN2qAEPMNJGdAofQc9hgKJSzgB6tXbIPK5+hb0aBQG9oKs6LmVjTbvQNVIsh+wUuQ
	gqlsVg4opqbBu+s56nCLY+4B/RrlaAMuisemypNXyEWeYiQpUarebgrMeVnsEcDlE356TJ
	2MMeWdF3wAkEUfiFQcuKoqQYMYZnWdJoXFnT/2Gl8nv+HyFlSMc60ghNAkUH4VB2Q85Zzt
	mJZaFungZwORn6okQcRfZZODhXTq16VdIPaXwGRcjcESFbLkK43bBUIZ3teaH5pSgAz/Vj
	meGp3av0rxUYxR1usT2vquMX95/Gd9fyPuxDmK0xJEHKxV/GXfZoEfOEYznzHg==
Message-ID: <9f8f371c-0953-4cb3-a99e-8361a5cc8821@bootlin.com>
Date: Wed, 21 Oct 2026 14:30:29 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] Input: byd - synchronize timer deletion before
 freeing private data
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <2026082046-impound-leverage-8771@gregkh>
 <20260824162612.4144698-1-sashal@kernel.org>
Content-Language: en-US
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
In-Reply-To: <20260824162612.4144698-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi.

Is there a reason why this wasn't merged ?

Le 24/08/2026 à 18:26, Sasha Levin a écrit :
> From: Linmao Li <lilinmao@kylinos.cn>
> 
> [ Upstream commit c83e79c0842ed29860648bcce5022ef0ba5001c6 ]
> 
> byd_disconnect() uses timer_delete() before freeing the driver's private
> data.  This does not wait for a running byd_clear_touch() callback, which
> dereferences the private data and its psmouse pointer.  A callback racing
> with disconnect can therefore access the private data after it has been
> freed.  The timer can also still be re-armed by byd_process_byte() while
> the disconnect is in progress.
> 
> Use timer_shutdown_sync() before freeing the private data: it waits for
> a running callback and turns any later re-arm attempt into a no-op.
> 
> Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Link: https://patch.msgid.link/20260720061259.1601281-1-lilinmao@kylinos.cn
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/input/mouse/byd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index 6e0c5f5a2713d..1a0956520dcbe 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -426,7 +426,7 @@ static void byd_disconnect(struct psmouse *psmouse)
>   	struct byd_data *priv = psmouse->private;
>   
>   	if (priv) {
> -		del_timer(&priv->timer);
> +		timer_delete_sync(&priv->timer);
>   		kfree(psmouse->private);
>   		psmouse->private = NULL;
>   	}

-- 
Miguel Gazquez, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


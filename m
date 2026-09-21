Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23148423E;
	Mon, 21 Sep 2026 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988182; cv=none; b=nG5ycVVXw2ryhl6iRlYmChA3TlqRNQlMrF/ICFFgG11K8xj5+IHEvKhtZrgsL+6d59f5e2+uQfObc0se2RC9admrIVTutoUKnjA+WRWAFTZK9NWdCAV1nqdCRlHKntUXghm+l4ZT5EoEylFjIV7/EpB6JD6T6pqGSQ40xIDLqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988182; c=relaxed/simple;
	bh=XA7yLRTHKzsOdPV86wDpXUHdWDORDWcHWXfbX7Dq/Tc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=q8yLOI7gnZQWLBJge3yhVq2jB60u7Ofhts8oP3v3G2fhVkGkmIFrxuCriCstdy1szpZjJLQkqlRJ5WtDSrTT15vxovCKMakI1YLsDYuW/3c00lx6Yqo/MUjo/dlTv3zEtUFEw9YJAKSXluz9fcPd2xduF+g8jz1nNUdmXecTE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZT4wOpu2; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZT4wOpu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789988177; x=1790592977; i=markus.elfring@web.de;
	bh=Q6dRm7Wr07litGPh4mmsrg9Bi7ASZFoOKwCZE7Ifdtw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZT4wOpu2KjWHHskrAu0gCEB8jggrfwUHjnXmqCnPUsLNMrVsc1FN4NiJPwa1cSPb
	 fzVUXhvsRqXt20gFQBeq8bUbhgoUAmbogPy8IrlL5OLvgJUswwRvzWURPT0sOnFbh
	 NaEicFhBBNf7B0lEeUSKcAwASkycaoaIALOIklI1KMrgqtEqY0zEtYSdidD/waKE1
	 qrjIowt9Oxvg5ZB/QS6QBBrhaq6DCdsOvYinE/pvrq+FUqTbA76ib66t95zY7RHQ0
	 Bfc9EvaNFRcZ5GhlqJdvVVuNWRDlMl/emCVbKv8cz39jf3h3TQGm+iOJ1aRkKLg9J
	 EFjS2SlkSuBuiZ62lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVet-1wvBTz0cIz-00Aetp; Mon, 21
 Sep 2026 12:51:02 +0200
Message-ID: <2784d61d-99d7-41f0-8c51-7736b788dc6c@web.de>
Date: Mon, 21 Sep 2026 12:51:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>, kernel@pengutronix.de,
 Thorsten Scherer <t.scherer@eckelmann.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260919181051.3751829-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] siox: fix master memory leak on registration failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260919181051.3751829-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CvWO059vf6bahrb41c+Qkfeqoi43nHfQBb3DLG/MvYYCDB6WrIL
 GByskS0v54VYfQlgxgyIU53vRg1Zc9nA2Dz53SDRimjRY5Ym/KLltP0eqiWsQXE2NIatJmm
 UX8lAm5p2X5Nt4klrrnbDlCXISWTRo5IdiDAh39xguf3jWcuDXp1UFxW/wgEfmw5Zqeq9Ts
 bIDvRW4Gfh6ZUVB/rGIww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bQJpiok89XU=;8rpToTnnbgMu+KjrcpQzZpOFt87
 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

=E2=80=A6
> +++ b/drivers/siox/siox-core.c
> @@ -753,14 +753,21 @@ int siox_master_register(struct siox_master *smast=
er)
>  	smaster->poll_thread =3D kthread_run(siox_poll_thread, smaster,
>  					   "siox-%d", smaster->busno);
>  	if (IS_ERR(smaster->poll_thread)) {
> +		ret =3D PTR_ERR(smaster->poll_thread);

Would it be nicer to use this variable assignment directly before
the goto statement?


>  		smaster->active =3D 0;
> -		return PTR_ERR(smaster->poll_thread);
> +		goto err_put_device;
>  	}
=E2=80=A6


Regards,
Markus

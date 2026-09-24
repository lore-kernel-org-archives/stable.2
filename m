Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DA36A37F;
	Thu, 24 Sep 2026 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267921; cv=none; b=owuOkB6TKRY8jk8MudiJFWQ85cSS0ixJw6QttPa/9Mw8t2Z46kK1SdVTalfnahr/p9GSjX3zYZDlZT2d2LIsvIcPeGUx0zjB8SaSNbIw1vWfceYDji5oa+6oSMJU4rdez3pEOeht1j6ZZpKydh1Mlp/vcAcsInYg3/RW8QCx84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267921; c=relaxed/simple;
	bh=4PU8vO1bg/eJnVSNkrB2Wg1Cu9iFo1x0kHWrNrkS6UM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j1tKsfYSLH99Z0vqQo92EoGUqPbMy/rfQJoSY3RBp4I1KxUuQ58cL/Y+B/RRQb5qNrzhPwD3yOHNbLY16P6l1y7D+O2WJ5zK6nLKcTCyY8T6AEAupIx4QnFsiH1Qf7xrvXT2ILt2GdEtmXtCNc/ixX+d1OY2m1tFbbDOKaWsHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l+kqF4OU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l+kqF4OU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790267901; x=1790872701; i=markus.elfring@web.de;
	bh=9f5H1Z3B0a0jnVtq+O8qDRhqN7LtN5A8JATyg5/FCGw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l+kqF4OUPrdsWBKD2ADP1t7+eJdKDOKpnEX88dtvV/YSJYlYyovfk1d5OUmiQ1nF
	 ezbeSAVmEEuNPHKvStiXVVmFeZLKgGBekaI2KQkQPbzdttML5A17wYI9V965hsuqG
	 hLTMJ3qRXwMdlcfCO/1i0xzukurqvZQyvvk4S0J4uZFAPbP92si209RXCdtxGGw/g
	 nw5lPKjjy0L5huVzcd1npWWj6S7CIUASZAWMVYW8Dk597jCvFscpHYWELdjMp4PYF
	 jjSJ4/9e/8amO7/FMgWS4OOipYC6cm9TbN9jKNFD2oAirRy2NTSiSSD7H1H80b9rv
	 QuhK1VzZ/Peqlvyg+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP382-1xO0S92Q8K-00KodJ; Thu, 24
 Sep 2026 18:38:21 +0200
Message-ID: <c5ae1aed-08f1-4ac6-92d5-57b475e56488@web.de>
Date: Thu, 24 Sep 2026 18:38:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>, linux-media@vger.kernel.org,
 Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
References: <20260924135514.1591658-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] media: rtl28xxu: fix SDR platform device leak
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260924135514.1591658-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVO32fcYS6dXjZG93dQvMXzA/tKnAp6Ten7S3YKqnV0A5Xj5+lg
 n915Vo378Q+rB2pBg9XqKpgQdJeoAnED+nBXroWB9AC7kSMMnr8JAes/ZQjla3eeNxK8Kdd
 lNDz0JznnBw7/1jBsEniP7wqHSJgcm8BzYnN2rde26+I09iO1JQQItZadMPkmRWN6tnf5z5
 8INQR0matr2O4tD0nGNtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kx7EF9duoE4=;Xbcw+loL059NsSiPucqSEcrvRv3
 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

=E2=80=A6
> +++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> @@ -1391,8 +1391,16 @@ static int rtl2832u_tuner_attach(struct dvb_usb_a=
dapter *adap)
>  						     "rtl2832_sdr",
>  						     PLATFORM_DEVID_AUTO,
>  						     &pdata, sizeof(pdata));
> -		if (IS_ERR(pdev) || pdev->dev.driver =3D=3D NULL)
> +		if (IS_ERR(pdev))
>  			break;
> +		if (!pdev->dev.driver) {
> +			platform_device_unregister(pdev);
> +			break;
> +		}
> +		if (!try_module_get(pdev->dev.driver->owner)) {
> +			platform_device_unregister(pdev);
> +			break;
> +		}
=E2=80=A6

How do you think about to avoid a bit of duplicate source code
by merging two condition checks into a disjunction?

Regards,
Markus

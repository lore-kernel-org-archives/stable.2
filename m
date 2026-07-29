Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038233B0581;
	Wed, 29 Jul 2026 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339320; cv=none; b=fvk7l29xR42JR/3eW4o9aotPV/Hwub7adMzPz9L4nES08y75bJhlTq/I8PVEFKJIEOo1vPDbUzPai9mPdZ+J5x7D8oa14/E+t22IinLXKgjGQshyA5FHEdMKqWhr9iRUU9GfLwuHH7OFqeelL86aofS9I/yRJod9Re0q/OewFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339320; c=relaxed/simple;
	bh=a5TwtrrwK5h5mn2aNFZrPucbQYXJObgiMGlxlMQXiDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpunthfL5Af69I3PDS9BJrBXFsqvP/BqqLnSIIrt4mvuuU1/g4LHWNVS3gbi0gwqbbmkz6MwJM9TZdtdCv45HlsJ8VqUwyx5Wa8kcvM6zAUcYeyq4krYfafHSBbudq7idTzy2+IYwz52P5ec0TPM9nogugIL2BA034wd/1dbx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l6D2SS5C; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l6D2SS5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785339316; x=1785944116; i=markus.elfring@web.de;
	bh=/mufJLKxb7GkvLH7gZN9ZQ92/Uqj+M1yPKOE0DtNGpU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l6D2SS5CWtNEVPWi5rew1jLPAGTy/QrlguFcViUEu+O9W4fVk7QYNPy9+/HwL7vZ
	 LSdFYjZPNp4QcvhfFQMRJFsItJhBQdnXG8IizoJqUOwPQFOLyXHfjitvcLcqDy6kW
	 bUDwvBpfgS2e+coXXtrlo3dII/mD6D/Av5przvRUxtmDG8c6InoE3dNbU1GCq0DkE
	 HuZVrYLiAtpbAcY728CL/9LKr4i2a6Dbz9jhRiBLiN3HhlDKGh0vkz3IWxgL2mB0a
	 4M0Lqc89O9db+/VtbaWOPqfNqfG7pp2NYj27JxJ4M1CerIgx5W5dZ0A/vCc44Y+X5
	 /yK1XkhM0ADgrjBbaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmymp-1xGUZI3sON-00iTNO; Wed, 29
 Jul 2026 17:35:15 +0200
Message-ID: <c2c63b12-2906-4d0d-bb66-cafaa042093e@web.de>
Date: Wed, 29 Jul 2026 17:35:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/15] media: redrat3: Error path leaves device in
 transmitting state
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1785338381.git.sean@mess.org>
 <92bf1bf1bbdcac248de159a1670bb8bc1c7fab14.1785338381.git.sean@mess.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <92bf1bf1bbdcac248de159a1670bb8bc1c7fab14.1785338381.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7oxNt5yTtsRlPxNSXAMDFZfAnYUfWUbQYMu/zDWw7XlQiFyNcvU
 lIG8HXi0zfT3ColqmjOxwtQFqdmjRITGIxB/WdV9xiBS2jGGmsN81cbHoIs828ducSk+ibj
 fhEt0mshsQorFb0Pijef7O1QOKCgDsIOsk+zNBvy2XcDGNipd1fbWbfKk5aGRKAq4HvFaVL
 3oJmROrJsyExBoR7XMEyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJEtJUSVRbk=;pL46cZM6ywj3xTrDNjSoRFjCgZH
 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

=E2=80=A6
> The transmitting boolean is only used for interpretting firmware errors.

                                            interpreting?

Thanks for another try to improve the change description besides mentioned=
 implementation details.


> Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kc=
alloc() in redrat3_transmit_ir()")"

Can it be that commits were improvable already before I dared to adjust
also this function implementation?

Regards,
Markus

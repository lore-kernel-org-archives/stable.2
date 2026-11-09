Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243403;
	b=sW0FG3HCejTywU2WqGsmP0zCgj0UrVsSnZE5+nKni3MNhheJF/FKTH/Y6pGthGdKAO8x
	 BH6KaMQEFopBkftGzOWM/eMKA4nHQKMWa6g4aplACb09plRENGEDrbtIxtrRm4OJjmCqH
	 y9TVEByGQnETaUOjB3nGpIIBNzQZ2celH71Smp4xg5yueSo2Kg19z5ZCON4yUkHYA5ja1
	 cXNWaKv3gcUZ4m/by/T6EU1vdYKlaa2tJcfvO7YPBsqhNhRmx0V9fpt+ZUBe86VcbZA9b
	 lCEW0XN0/6d4Dx9NQHXTKUlmhjCZQCtjr3R2jGxVCbSxdc98OCMgZuwpPph1XNrcbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243403;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
	b=jebprz0lWsHnsjJqymatygqwhsAJ/5ddejESOyaN1vqon+IW5a4sLUffiDxoM0F+3RBO
	 m+q5pLLFkb0guWTZM0tRYQCnLKOT0dWXt3Dc5fxKeZ8+jnUBjBFR8jh/6l8pNOAe0z4EL
	 WyGJiRBQj6P60DV0krH0MuP5kRidxiNcB93qqQcp1VBnm9UAeI9R3uDlQojzk8NDPJmzk
	 daYvdE0eqoIE9KW7cRpj1QXFmuvHZkdDD9P7ldyjHDQoIL3oIpTt6hmzq4wMICAPWahC1
	 FrqPzWzyG5deSA2jJBzkLhkvxTjkkJmoLU+74ywtxaqXAT7M4Y7cdkhJ4j/pF39q69g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJBIw2O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT4z5lWm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DD606A880
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24DD606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJBIw2O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT4z5lWm
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFOTx335108
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 16:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=; b=QiJBIw2OU6JQAqiU
	IMu7SnKDA3OftsxroKU651JnYMXGvtAhKqm8lUqV0hVVp2hmPU+q3i7f4whlRUOI
	YvXg0QOnXhc1K0yOU9bv/Nf4HdUaNhfkLLHcPby1SbLnuhDDmiI5pVL5PyTUeasK
	FW7r1WYSgOdB4oWTkMkr2hIhZAwpll5EwmvR5vAMR2HzXJVtRPlp4cpKjYfo6J8r
	R0qGYD2TqVshl+5jyoMe+i6MDxYo90oARsbOFp1m9Uct8s+ME+zWk93rZbrKOB4S
	saWCw/K9sLLsdDIYM/6lYwQeSQlLG/qAOFQoYh0pZjZpRXYo2P/6Qk/MCB+QCONL
	qOYkwA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf595vx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:56:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so712939a12.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794243401; x=1794848201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
        b=MT4z5lWmR0DsHtst152koLdxtSSi3Sn1/hxACAwZIt4vqcahn/YmTL2Uh+qj13SBQW
         Q+7G/MFlpMZRikj4yFrdRO8SXgoBeCjNJ+2xibL6xCKX3joQW4EtPoUD6FINndrHISXd
         6p0z8Oyh/tPRa/OAaB8vCEYLiagtCaEqx/OF3ouYDPM87xXVVSke49vo0KmAKtw6Qyxa
         AIylDNwBNYyne5eXuLnGQj/axsi2Fi1goj4nFVAsyrd1hep4KlzYXYT96vs9qHR3gles
         kd+pBiJUyQ7U0tMG0BOU7Ib19n4+xkIUyipvghNMCKTWsWy3TTm78HW6AJ9ixwILeF7v
         C87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243401; x=1794848201;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
        b=XbfcFh243vGov94lBeZcSw6fcJYFuZteCUbPVp4X/edGMi+xDN2o2+I8zcC3DORh2O
         05eAlUwVR/hVslGpLGwAEItlR75sn9ToMpwz4mC5n62CFMuT9prmmk2BuMJgVcNHcTwa
         du4H5+bf/vvrnX+A9taZlX2RkdNevlEC6NztbUSpWOK60OM13+grnukp+V9RC0Ac+vdM
         ATN9gHHE1YU8MTmz38ED3YHOCiQHECkfmA8YEyYI/gFihWbe1Xvg0JRLi/KVbMw4NB6a
         wXdN3XCgAQlyPRZwQsEZ0Eg4BLhVaKG5Cz0sSZLSGlcpD95CfowcjBCkPaDdWUUD7nBg
         B25g==
X-Forwarded-Encrypted: i=1; AL+hErHkWUxeFyVHdXkrx+clSLa01R5laTp1GZYqSZ7NTZQ+lHhswJ9GyLtpk2AWe2t3lrQwk1iJFjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z914y4JY9Wr0D08A5u7L/l0i7Q8RmgxlgKcIJ3iJqgg+4E6mThe
	Pi1E6wYglfH+v5il4Xi7U2oupqcX963BHsEBkgXDrJHrHdlwXDLVz7EmoYepohrV1iIrJjOp9bN
	Z9KaWIxG+V9r5omg3/6zFKd8LXOJQj5oQSaTnK7y5k0DfLx1JcXyh1SNDvn4=
X-Gm-Gg: AYBFou1qmjJqwHaWWIPKRvGK/m0i0g2qYaKTpX7POD4KvfSmjqBcuSKmrlbx4rJCpkW
	yCtPexHYjaQYsx8XOapLJqkUX3YFM8h/XObq77LQR359Q8NkqOWllc1Fc5KfY0JwneLEg2eHjmM
	Ja7EKZsFIR+pmC680FOomWtPs1mLR4LOyKnLtnAFNrtU4FBmhyG46OFOrChDXll6jKdxvDegaBZ
	MAaIh2Ri0gS5yoCUXJ5LaWdz2tje380voU2+VgJIaySJIJWaigCTG04sI5U2UCWQhN6c6OkEKJv
	sh3YV/UUdfchmTL3+uISFW8l6PdenPIeDqOjqLxIroy/JAsb3+FYR3qBAKTnAfMUEYdOPfJiZcO
	SsYrKuXfkeXwuELSnU9iCp6cmGm4ip/nm/RsJPNseqhNA0CJ9TpsaMPwz2N4TlhQmmra9Fi1j0F
	mVd6BL2yimqxhBwIn9790ggg7GqA==
X-Received: by 2002:a05:6a21:908f:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3eed202212cmr5000500637.12.1794243400713;
        Mon, 09 Nov 2026 08:56:40 -0800 (PST)
X-Received: by 2002:a05:6a21:908f:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3eed202212cmr5000479637.12.1794243400209;
        Mon, 09 Nov 2026 08:56:40 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64933fa2bsm1688177b3a.21.2026.11.09.08.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:56:39 -0800 (PST)
Date: Mon, 9 Nov 2026 08:56:31 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Per-Daniel Olsson <perdaniel.olsson@axis.com>,
        Kurt Borja
 <kuurtb@gmail.com>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt4060: fix inverted own trigger check
Message-ID: <20261109085631.00007485@oss.qualcomm.com>
In-Reply-To: <avHsKUE4xJ0vdu6P@nsa>
References: <20261109024746.1253593-1-jic23@kernel.org>
	<avHsKUE4xJ0vdu6P@nsa>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jcbjceHj8GVDC0UURyHXpKZgHkpRE6v-
X-Proofpoint-GUID: jcbjceHj8GVDC0UURyHXpKZgHkpRE6v-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX6YkdYaowmb+k
 JXatSwR8deQ9a7jSMdCiWEjXnY4goD8IKbYT5M1hHIqoOJhjMoWeUswbgwByhRUTSgGlaOKVHTQ
 8V5wTXi3bLrm4BaijcL/SoBswZuYjMc=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af1fb49 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Yv6QgJ3ExnuNNy9BQ7QA:9
 a=wPNLvfGTeEIA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfXwgLs8UiR7Cfq
 eT9Qfyh5EzLpZJtppFjarTvO7M0YNVPi68HMU//KtTsQiKKCa+YJrZ8iBM8qLGe+cPBEaT4oWya
 phLKtfbjmWbV3dXs13LOOgGM/1f9x7vD09tdpt234H0lnVssUDowQcbgpzCQmvVJ6Zeq99CjvZ9
 5rO8r2I0ZhPKn+W03T3XLycZnQOHddVk2hoz0GhmFCxD9RMfXu1kAzVxNsT/BeXcoO9ZCjpPLMM
 5AzjVYiVM8kg0ds+P0/N3y5U2PEya4FSWWiVfdQD40Bv2H0rldFv9e/d+HbvHaTQPbcs6Qn1Jxs
 9rdyi3DOEoK0KJ5LBUNMg/eo5mQrIRr3zhNgiEQd/iEEM/ms1LGyL1FFAHR644Gb0A2PX7ytj3p
 RFRIcyfRIq456d//Y9pjJULbMP3yjw4eJFd7blTRaj5jqlMksi5BsS2he/g1JnG6Z6jgGYzIZiF
 NRczuiJ4rXzfnxksDLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090067

On Mon, 9 Nov 2026 15:52:31 +0000
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Mon, Nov 09, 2026 at 02:47:45AM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >=20
> > opt4060_set_driver_state() is meant to keep sampling and the interrupt
> > on every conversion enabled while the buffer is in use with the
> > driver's own trigger, as that interrupt is what fires the trigger.
> >=20
> > When converted to use IIO_DEV_GUARD_CURRENT_MODE() the negation of
> > iio_trigger_validate_own_device(), which returns 0 for the device's own
> > trigger, was lost. As a result, with the driver's own trigger in use,
> > enabling or disabling a threshold event switches the interrupt to
> > thresholds only and buffered capture stops. With another trigger in
> > use, the one shot conversions requested by opt4060_trigger_new_samples()
> > are instead forced to continuous mode.
> >=20
> > Restore the negation so the code matches the comment above it.
> >=20
> > Fixes: 8284a4985416 ("iio: light: opt4060: Use IIO cleanup helpers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> > This was found by an LLM whilst doing a refactor of related code.
> > Indeed seems there was a change of behavior in the sited patch that
> > wasn't as intended.
> > --- =20
>=20
> Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

Fixed the linux-iio address.  I'll probably post a v2 so I can pick these up
as normal though.=20

Thanks for the review Nuno,

J

>=20
> >  drivers/iio/light/opt4060.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> > index 8253a6a8bee4..1a7d429453be 100644
> > --- a/drivers/iio/light/opt4060.c
> > +++ b/drivers/iio/light/opt4060.c
> > @@ -310,7 +310,7 @@ static int opt4060_set_driver_state(struct iio_dev =
*indio_dev,
> >  	 * IRQ and sampling must go to or remain continuous.
> >  	 */
> >  	if (iio_buffer_enabled(indio_dev) &&
> > -	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> > +	    !iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> >  		return opt4060_set_state_common(chip, true, true);
> > =20
> >  	/*
> > --=20
> > 2.56.0
> >  =20


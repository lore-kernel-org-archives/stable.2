Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2243FF1A9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657970; cv=pass; b=EnMrSOab9e44IG7GUHolPq73MeaIxl35gr859ChizaQ5hIQku8O0nMgdeFvj9tQmoHywshg9C5PxtajOLQhXwB+tDgDfiyOk4FQRSjKtxTUxFRBgcjQPLNI0BaP1t74OMB+nxIHxtu7+sz38YmQ6DQAHc20WGuFgBo3JdGbqXhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657970; c=relaxed/simple;
	bh=BeLdhDF9y5Q5SXx19u1tkJ61xmtxMDfJUSUet9PV9+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWsbxpjunNOQGbhPJ1l4HBwBKFWMriPIxxIR2ThLHcn+KhrbFT5Bsm8QeZ6cvT7JssFrBNKhPULyJ/So1XcxJMJm0/lP9hOU6+yb+gii9mFtDFWAu6YL/NXrHEsE0c9PSl/ndDQj6t3/rLwvuZZTIA5Icr75fYYdyhwR9c/UhQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoK2SJnA; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoK2SJnA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c95395230so41167931fa.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657966; cv=none;
        d=google.com; s=arc-20260327;
        b=YJ5DNir8Lv9IbKRXYsi5mGzLcj66vXYDYcPPSF5QRCZp5jRJEMqfr5f/K+vOuM5CJq
         qmY+w2sM1WZuyqpYo+pUp1lMSa7vI77LHXZ0prvN2JWsQ7Jm4DgHFja1l3lJkmVcSecX
         rmmoZbGKlvMtNnr0zxexKaBTsdhfRAm2rmqn3CqjftmS3gpdVJhaU/lS1v6IsIKiyr/o
         qC5KbjBSFFwbx581C8eMrfu1IyrJghFebWjdVM5bH7KHsxS1K6Aosd5V92RK9DyRtL1s
         sxWbbsUgH8PArZERWg4NDGl+hL9DBkcLJusAr/N/U3dlecOqw77iHvicFaDjMmHFNhRS
         nhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        fh=yg6C3yvFqYmr8rnOeoEkNqCoJcNnq7z38FuUn0894cs=;
        b=ewP6BtesUKKM3qyTYTJlR00jZr0OfBCWuWvzaL/RFTw4TqQw3+Sg0xMsxOueYE6QPp
         fdmCjYXFnownTrEEiF3VHS8NDC6XXyAo/pMIY4ohCLxHaFRkXxShzx7HPBwGPAY16jcv
         y1QptoVxHSt+0FaMHyHV8vs8oHOnUrIZDYv61l25TIK77B4zF45TH6n6/RWkGcovXHhI
         o8T12umwU/sMoQvnjOTO0um/xqemkEWdpTYp5ZBuiSUhP0/zIDXQgDIH6ypQqaBZiE5k
         hZF+5AtT5YvD4MNEgWv8AV0MXB0A1MCRz43jP52gLjclLctqeprqGQemoHnhOL9t3RJU
         rssA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657966; x=1788262766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        b=PoK2SJnA4H4PrKFogJeWbClORhi22fcfiBs0m+alBjP/si1st1UvgHO19hZ+9mZrd6
         luz7q4GTUJppxU19RnHeqSeWWXQP1HkJARdpqWbOUeiejhvf5PiG8zIoLyJu3UbtzoJR
         OZT4fKSwT5M6Ma1qGY68vvXQCl5sanU1XpchVHpU+nVlQQyHxvL3LYvGtEOhPcromEAT
         4aiVYzAUKNTGLKAfS0fU+SMzQr4h0ncGxAVUEbopvJAD6pSDKhH5LV2z6g57Bv74ozrq
         4FON4hlddPzA22PeIX8u2wCbD5/bTQDdo1YhTh+0JBgha5aWJSVPgZN0x6KjF2SkFY9J
         KJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657966; x=1788262766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWG+md4j2PNcfHubRAWpkT3PHkqwBg1+dLd3rsTqY4Y=;
        b=qJLY0cinawdDdI2boP9Zvu6dYFB0TOPbWq8jiW3xa3/z8RuD2L3VYNfpwMUyY03hqW
         zpSKkHlTDf04wcuXX+HV+LdDJ77GB8BmPuQGvvUqbRd24Dtk/cB3Siqpwb7twrgwDDwA
         8f9SfEOnK/v/yaPNXEyHAtL/B+KBy6Spxq0fxZYs24Uay9kMS6tkxZQFgqwd66ZuhSut
         JX4kQQh7Kzo6N27Z1eZUFgtaRsE3in5ncO8PdnX5Gq18dYjoeVdvQFQcoZ38C8CIeE6Y
         j/jPYVCMdx33ZSgVdl837al4Ltu5bvkXHnKCyziGxAkruOSKeUh+EZwf/CeIrcye68la
         Rg6w==
X-Forwarded-Encrypted: i=1; AHgh+Roz+s8lgPDByEc8oBlSY9vpB3GCprj4NK9M6u8xrjSpHZATd1dfEo4J2ammbt0os4SilvgOB14=@vger.kernel.org
X-Gm-Message-State: AFuF++n+74XiqO88R1huTzF143kS/EDZKaFPH9EKXHGtG4eMrnmlfJcA
	OfV7MDy2snKROozLD29DCXG1/KhNZ5WMaRD38b1a7QZeCR/YFeyRdv5UqOkTOcpF4SDR77lffXy
	/KHDbWHU80YWnm9EaQ+0rtNSpc61fr7uHYUtnAXA=
X-Gm-Gg: AR+sD12f6PrPezmz2yef1OM0ZHeyxHXc80EOM2e6RSUsPuxpYYimV00WDn/bquf6RNl
	TQZxRsRBTF1WDN2jUSXU2GI/9b24ZRbfq9aFmSlz4JMcCn3M6W94l2YHtDyB0WJyTU3dwOwoCw0
	m6DYcRi20HykYCGd9Kk7KlR8QmKODs7U2tnnQIkgbEiN8Apa/mbCcDEIkXKvGtAdUUHURO09K6+
	ZehgpdPK8B2HJ9fZcVSWrE44z2ivICFrkvoJ2/pb07VpmVuefIMLKdBmhn1JSanb/5bczOqZZZp
	xs+8EymbqQ8MBUn8s9oS2/uZZaQz25Om7q2BJQQ5J+tgnm7y+RFTrlorL6mXnE3cFcyokPkVu3f
	DvrnzmFyRlv/pxmhXDLYULiTifG4A697Jn1AstUFp9YcY2J5kJ3mGVl1Pndc=
X-Received: by 2002:a2e:be0c:0:b0:3a1:ee15:309a with SMTP id
 38308e7fff4ca-3a1ef375f45mr11041461fa.7.1787657965390; Tue, 25 Aug 2026
 04:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
In-Reply-To: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Aug 2026 19:38:47 +0800
X-Gm-Features: AcwNN1XjQjXxu_LWWSVa3JvUT2ke1vsS37UH-HzsyAnH1vl-dmsN4iUGVuJN_ak
Message-ID: <CAL+tcoDM1WD+Nbc_KXiOb-ZvfBT+bFjb+czDkGF6Nz81MS8paA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix spurious TX timeout after dev_activate()
To: Breno Leitao <leitao@debian.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org, 
	Nicolai Buchwitz <nb@tipi-net.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> While debugging another issue today, I found out that my TX queue is
> reported as stopped for 4294907392 ms (49.7 days), on a machine that
> had been up for four minutes.
>
>     bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 2=
3 timed out 4294907392 ms
>
> 4294907392 is not an elapsed time. It is the value of jiffies at that
> moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
> short of wrapping.
>
> dev_activate() runs transition_one_qdisc() over every TX queue, which
> resets trans_start to 0, and then stamps only queue 0 through
> netif_trans_update().
>
> Stamp jiffies instead. A queue stopped across dev_activate() now gets a
> full watchdog_timeo of grace, and is still reported if it is stopped
> that long.
>
> Fixes: 9b36627acecd ("net: remove dev->trans_start")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

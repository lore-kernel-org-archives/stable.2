Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794158176;
	b=ZU7BStTWrlOWA4aGfq6Xd4Eee77/hkMFUrrc1QNQbkQAZcuhksKF/lcVIyfKu1hD8otk
	 JPOnbkkczksPpYjlx032j+Uufa5VfLY9f+NikOwRnbY0IoWsj1YnFpQP1E692bwSL4bC7
	 0/8YF4rn7xo/4UV0beyCA+ZkvZk92ntoZPyzaUCvRiyzx7rznbkWFfxbxYr8j1/SRBAMZ
	 muBUmD672/3wzK4C16Ps+lCbspSd1cN1fdhj/1RwhDs2FjFuVfS5P29zxbXJfz7I/eyOP
	 lcgFynO+8nND4ov84BrTLIma1ZuA30kAsQKgvUwYSUcZLy931X2ubyqbthjkGl7PSow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
	b=3G/JBgCCZKNNW2cjcra/Yw7RAUaoH/vrH4IZ6+HASV2m0kFdLGudJCAufwaA1TrjeIuX
	 sREyz5824YVnbMHqCgoQHdFplee0J6fJwmQmdef6S/QChlP6dyF+a8VAdnFE3gWf2BkI/
	 WMk6SHMktluq0rv+AyLxUicE648tQMhKUDPfAJBct/3tymNsU60wfis0VBfb84caYuOcP
	 /X7k7gtI6s1YfZcVFoHXPrFENWjMP8fXymOd2GrNF2kWE2uNxRaAvxCpTAgpnLamLgDGR
	 9hHTR3Pr+fKJCNbCaeb4OqvfweN7u/2m1eLn7PeUpqrrhlBNtL2XAhluY63PhVqK1bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYLXAc8y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1B606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C1B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYLXAc8y
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3712b6d9843so16984eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794158175; cv=none;
        d=google.com; s=arc-20260327;
        b=rN5AbEDHZ6t8X4Uo4bUW8D5ieptmY27XGqferCL0Vteqce0EFNSklzr3ESDg2BZDFG
         1kEUOnp/W39N3sBgZAP7elWq/pgyemStRcX6wT+YGBdId3voJ5HQwaT3gAkWT/NiB0T1
         /woDqUCJCKS24VAAlHGG6OJ8OGduv7kHAkcSQnaV8qf6WpuSIulNF661f/sx5gBTC9yN
         AYgqPh0Nit4ptXwReyufhAG/PVrhopM0GHY3po3TY19ADBWBV01QOnDWuUTtlTr74I62
         F33saZUaMzxfTd69mXgAtW8IHRWs0ccQ0g8owUwSYoitUkYmk7emvYC68bFikwx7Ulq9
         3Y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        fh=OvYR9zp9xTDk1Ua6APjb4SiT4tJjOufq02jTXmF0oag=;
        b=BOKpKkaTxYvC5V9o6Bi8VJDHVpaAK/WuQh2gz8KJk461khqOmgiiRNbkmPTnarG6hM
         tUhRuiv050hU9X1h5HulxdNcxXBvj8Vc+wJdZFnn1pSt0CgwV2GYosQ5RphvsiXGvAUV
         +TiTLZ7+oA9U+a9xEtU/hU4af0oR4Jvgq/tEgxMKz5Qrc+zhnd5T4BTo7R9mwe3MEblI
         f9twCEWEc5unMMsjOp77ui4ZiFLn8oNCqeqRv+K5zleU5koWwdgVaBV8WQ9VJeRubcTq
         5SSJc4H2VixpoxmJmdXSVcOsFVMbdAn6LaFxXqmheL1Vc8ho5ThwAtldmV9+fiUOPobk
         kdVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158175; x=1794762975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        b=QYLXAc8yuXsOoWrvJlkiHmQWKNxQNVXqZ/9ylB/rN4Cot0HhpnCGHWRWB5TLLG6B1N
         LK0YMd5sTR68WUSj/cPopOlL9xKyKcWuNk4asxAVXIio/GPOPgY+eikT2z2ZwlleqWYc
         Nvq0DstLNjdv2JelaJNYDpJ0IKCLL08ZWNle5ZviC77x5Wr38IMh6zMPSl6XpBwARBDC
         bDMjQITwR17Rm/3cxPvhz6IsJhF2RDpMU0t0XDYChIigwm3rCSIEFbcH9xgl9A36UOCs
         zO83E+GGWC0dEm9d1f7gGoVxhSSkEjNzd+ZZDm+V0kGQr9i9AbbG3elHWqpHWrpKrlK9
         vcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158175; x=1794762975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        b=UmAudOsABI0DU1wamnO4VsTstPMiRxMWufcyjb23ty3EUP2gtnuYBthe4mPIuQEsHL
         WLyGMTvHIoifoMNcWj6iq8+i3+43TpyU1qdPVCW91JpFQeDwPb4F0IdQkicGXTg5Y7jg
         9gzIWZ9tilbVeVU4Vwm6hsDnCs97LJBn8xdwvu53zaMPB1BIQtiQyNDbMU1xPHOgKp6e
         L6ONTnqKmkLuqlnnmG+VNQxjrXM71WNmmmxn7CkFshw9kl6zpjjo8RePt3MqPihAz+FW
         Nxm13AhZgPRYFZ236ViqFoGqZ1+6bwI4egLUJK7EZEfFmyWT3aw/8OT0GtaL1nte6t7n
         EtTA==
X-Forwarded-Encrypted: i=1; AL+hErFrqhmCXyYdhHci/cFtRmhe4DeUurtmBCsACpBpSnWMBQMaXIEARF+a7yRf3i8ztzghrSstPmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nGn7LNn9EJTn6dUBcFX2gfMVyZqwbtao+TUnk85K07GteYG45
	VJiVRwg4bLqay1mhspOYgOvqS2aeAYDEu8xYnnhAYA8JO+B3D6PEineXjrN/7vLLJ5YZ6/wY3jZ
	24xxRWAdrf4Xx0PB3Usz0zq8H7CCKFq8KqGlb1Ws=
X-Gm-Gg: AYBFou1umb0YJLD8NHmqnmsWXvG1NCZmNLpq3CJpXNhtCkZn/wFBeLD7DbNMZi4kQZL
	1Yh7CS1CyJUf1NvfsFqDVN8yfUnpfe8N4l+gYUjHS/1E+U9vV0su7NQF7xD/3ZMtvO42gLgBVtI
	jg0V96Os/s3mIWrL02MsXF3pefJCFKVyp16AsvzhpwhxstZkY3tY97DgXW4NgPg6UPtDdEkHqoS
	XHxnsq6HjqKIDulWUulo0dzihX9U+GLP0LrpB8Nm1FYpQdy2p6+JJ2ReMYEWWI/WpkVqb8uwFGi
	WZySHa1CPKESKDCM97U4koj63oZ2tGuGYsNr5KClDmmsJj5Oq6ujONxF9uoWxOFbq1rn5We0omK
	WAME5nPeYNyDrZ7E0us8N/h/KC5vIlu1PPqQ5iZIC9HEFsXQhK7vPhILJpHMMjJzuFGRU2codA/
	ArEgG3FblDMXCK8ng=
X-Received: by 2002:a05:693c:42c6:b0:359:8492:20ff with SMTP id
 5a478bee46e88-37254d9a084mr3476444eec.12.1794158174728; Sun, 08 Nov 2026
 09:16:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107142006.3711973-1-hj351016@gmail.com> <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
In-Reply-To: <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 02:16:02 +0900
X-Gm-Features: AclHuK9i40GCpnkRR0bNNPrQH8ExOtzwwehbWdVg6Fmq930oRUagKnaGTsJ4ME0
Message-ID: <CAGr5VtOKK=FA_PJWvXr16r-RH426M7trfsXCXGNgPZ20ROYgVg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: twl6040: cancel jack-detect work on component remove
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rebased onto current ASoC and resent as v2, thanks.

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 2:05, M=
ark Brown <broonie@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Nov 07, 2026 at 11:20:06PM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > twl6040_remove() frees the plug IRQ but does not drain the delayed
> > jack-detect work that the IRQ arms, so the work can run after the
> > component and its devm-allocated private data have been freed.
>
> This doesn't apply against current code, please check and resend.

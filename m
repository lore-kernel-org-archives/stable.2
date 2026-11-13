Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794550085;
	b=w/hpqXWQcpgvNGeqOau0E7cmt8Bj/KNd2vNLiftSaAwUM+FNySmClyYhSKGBad2OAGg8
	 SVJQ3lNeTChUxKMQlcJh7d+47Kac7T30P8+DxTqa6VNRyyAgvUXKgfkm+IoWunGF3xyN1
	 nY/JZQ3x5xgiWEaH5WEtH+OjlVJCD24mfxMQ2WnyTy7sgHRfoTqm1vxafGa19QBFcTKmf
	 Mgf2pZFd5OniHPiAhk0Td4RaNVcf0GzN4lc3N4AMnysJGKrMnfMkwtIww86v2nvihXgGx
	 hxVNwPAg+GMFaTfWPvXdJ0fPpUBpo/MWlDOeA0M1Ix3h42G2qDTQO3jb3bMdw0s+m9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=26A4aPgJxTCdFcMyIZSLE7eGxsYpBIDGl9yj/Yls13k=;
	b=fchx9KpstXlPPMdiz2HveXYQuZxbytfF5llLbsygfgUh1g41jgtGQaHcqnEgemSEI0a4
	 L68RpONJ6XFAfZPzUMkigqephrEOYJjuo4rqomg1DC10cC2PE4ibvvXn8IqHvjmvNYF41
	 IOvIcX12lEGHR7j3CN3TBASxmDe7X52TxeQNQ7M3m+D2VqHAVqlapEuvPgOMMhr8MioFw
	 USjHg9g3MqyGEpokCREh8N6UKaGflLU7CmTeOL90vtNeECW1e9NADHx65u4oq+sJoIbOV
	 6WixjLSNT5tr3iKG9Phw0JV6zjKTz/NzebrIzppaDnCmdjL1i/JQ4LtlmJ+gI0CS3oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XqQPAg2w;
	arc=fail smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50634606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50634606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XqQPAg2w
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8bef8d4fb90so79417b3a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:08:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794550084; cv=none;
        d=google.com; s=arc-20260327;
        b=MQaMkD6iEGfAi7Eh7ZGUpDNA3WdONZYfhiygvXHUMUFbUOHQ/FhoVXp3vrzbPxlcfK
         GSQWKH9rJZlbqoUBA73f9tngTfWXdmfR8UT1H2d+QJQrKrbIzeT/386VfX5ywCTzajtA
         sOkyVtIUDXYJc+Ib9xkq3GmVefHAXaPp9gGKgPCeYwgTDcZtdasvelNx8mc5XQCrV2WT
         3WSK9i3opXu4+9Kc3350d4CIWpuNf5N9UXnbU8dN7tlfZn6Z+2Bak5jx48yDXcwTJIz0
         Q2DVMGy95jtR/r1WqelUbXaMHHvaQ8O9DriN73382GJSoLWeUKMrABxuF2RRyIFdLhIB
         ZhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26A4aPgJxTCdFcMyIZSLE7eGxsYpBIDGl9yj/Yls13k=;
        fh=3FRDd+SBHRpaoEOXYtHvJgokT5hlmEagoUcGN1rsAmk=;
        b=Fa7kkajHUhqkHW+J9Qxdt03+AGFbP5lxWAire+bpYMHOUm6pHEw7oIisU5rW2T+wXd
         rRaDObAd0y9txHBM/zet71IRNVn0OV2f3nrJGgQNzrSvEh6Q6PxsFl5oCWaOUgZmD5XG
         67vQC0bZmWZXxN0Ir0/PDuUBR8Q9IQ1bh+gcb76E1C7x6lX8M9ozBYOKfbmRSJWWuoKm
         02xMqbbuA4igYJCI5guNsqqAYKxSf/6+HwAgCuBj3mjVAPwxj3eC19TIrCjOcYsQQrAm
         ZS1ilR8nX/ob6FJd5zNwNHeiUTXcH9SpGD0uEStFYZpYyd46Pqzvx1M/S8G7aj/2xPlo
         o2kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794550084; x=1795154884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26A4aPgJxTCdFcMyIZSLE7eGxsYpBIDGl9yj/Yls13k=;
        b=XqQPAg2wO5ObYLSJ60tvagDHEEqP3Em0l/W0NQSA6kdagkLZ043Wop/TCnLuUVnf3w
         x/vsvW8PT5r9yyFCZepTCoKzi/Tb7r7QryKwZXTE3f7K7jy5mpMtwrq7am3T+aa5x1dX
         tp3XjPZWx2eJSWtKrNiOct6kcdNbexshA7iv8XLeBp7QNAfUUxzx6/WSThQ7B7YUKSql
         vKZp125E3dV+HnPwa78G6eHA2ASRHQlltoNj+neu7jsZRYqpt2x4bT0uzMSzw3oLkisK
         Uxt3XRqoI4JSO52BlDp0lQ15HLyOkSf7rY6u7Su1VIOu0fp9AsPwoNRSjI2fpbQFNtvr
         G1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550084; x=1795154884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26A4aPgJxTCdFcMyIZSLE7eGxsYpBIDGl9yj/Yls13k=;
        b=SlfKqYMBCVg7ajIxrR33ViobRloci3pMRce9NE8Jeyr0QxPveaqYptYqlTYrQwWYcW
         23SlBWG0IuREv8YQ6oP/kX0Ly2c2a9+OQ1nrbMLwn1zs10Mfok/a6c1jAsZalZtfzHJv
         wT6ii2lwCXNoTIZYOiQEpDkF4vbKYcb2Jz4RNxD2VaWMSvpYnFNYTffLM1XjLja+dyVu
         Km7b95GpM2XmIy2DwLajNIeNnyfNQRDes/T8vkUAd03BQ5RgzDbFxtoOwnvfS1YI70/H
         sFq9k2MaYwX6cj99yhHeMJFewugWF1WR7tLDHPIP66xzm7UWm+G/wKGwe30g5mnX58+q
         VKWQ==
X-Forwarded-Encrypted: i=1; AL+hErGbExOjGrL3IPV5WhCdNJNeAFdFcOsg0/TOhbZboyejvpa5EUxdDKijBTvPqZo+BQnZ9BS5g2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bz1bWq3SvH25kQLLD/+vlyc4npTVwgVeONH2bq7sJCqnI25Ft
	UCIMohviFwmIP3QCYrREkukUdSZ0YxRss2GaUuG+m3qhKgMmn/Iq2ZeUw7tqG/7VwnfDt5223vI
	6a8B2HQP/pZug4mOfrecb6glFvo2Xybgn9z4gxkw=
X-Gm-Gg: AYBFou2bPiYfqZTDSu7EETunzTZziXJrBFFFGpM6YOfSA1FBc3V6Lzvg92bJN6Iw+Ie
	LVb5qUJhcGqV2c4JcJxeCfKkWDm7jQYAekaa9zZKRiP/3GNhmHGAv+gH8DFbjTxFceXwqRFJPm/
	iBJmvQNKyRQCx/iboIsoZpKiIVyNmnxZuRM3EIGO/6GtTeYcg+BMDXc95djqIp5bbTBhr3Nfx/9
	u2fxVAoFvIyp6hxtdbTD0MJys4zfQ960dXof/ZAaYu3SdF4x2bJdv3nPDjmDpo6hOWgeR41nZmp
	fYzhesJWiXoGddCfDfo0JXoF4k1D+a1KeYZm/K8ovzlzyV9esj736zXvScOoMsPpJOMUtjhsfx5
	V3Gil/iILMancm0X5mr+1ohn+dx07wtHKb3w52g==
X-Received: by 2002:a17:90a:c88f:b0:3b0:9a3e:bf8b with SMTP id
 98e67ed59e1d1-3b1b0b5d63amr2053645a91.6.1794550084439; Thu, 12 Nov 2026
 22:08:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112160448.41566-1-lui2012qwq@gmail.com> <20261112160448.41566-2-lui2012qwq@gmail.com>
 <179451113091.3909038.17914676412025517919.b4-review@b4>
In-Reply-To: <179451113091.3909038.17914676412025517919.b4-review@b4>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Fri, 13 Nov 2026 14:07:50 +0800
X-Gm-Features: AclHuK9Lr_yXnIkN3j5RcGH4UR8BkPHdICqoNnYU0U9QDO8Oz1UJmXvDJz9L57U
Message-ID: <CAE=Q7=4=OX36KCU1TNA_aLp4U8b4EpZE=1XkrKj63JATKFhefg@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: musb: cancel irq_work after masking interrupts
 in musb_remove()
To: Neill Kapron <nkapron@google.com>
Cc: linux-usb@vger.kernel.org, b-liu@ti.com, gregkh@linuxfoundation.org, 
	tony@atomide.com, bigeasy@linutronix.de, balbi@ti.com, 
	shimoda.yoshihiro@renesas.com, robert.jarzmik@free.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:18=E2=80=AFAM Neill Kapron <nkapron@google.com> w=
rote:
> Shouldn't all three cancel_delayed_work_sync calls be moved to after
> synchronize_irq? Seems like these other two work queues are subject to
> similar style issues.

Hi Neill,

Good catch. The static analyzer I wrote only reported irq_work, and I
missed checking the other two work items in the same function.

I checked their scheduling paths:
finish_resume_work can also be queued from the IRQ handler and
musb_port_suspend().
deassert_reset_work can be queued from musb_hub_control() before
musb_host_cleanup() removes the HCD.

I'll move all three cancellations after host/gadget cleanup, interrupt
masking, and synchronize_irq() in v2.

Thanks,
Chengyu

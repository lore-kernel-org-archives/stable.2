Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795707422;
	b=vHtFhkDWRM4SP4TGoTtu7RZ7xTmI6zsGRjsj1j8glzQCb3WYMfZOoPS6uiNLNqCOHpZu
	 zsOcg6VIGz0+g0e3rP8el2cGtUzw3r10ylrYk4MHPHDDbrpttjLLwM2nKE+Jl/VpUDme8
	 i+kXSnPqwQHePp9EI+zTkhZ3b085TErqtGXIx5MkOYXfVN8vQ5ydCG6ALsvXew97Ch4s2
	 OUDHFjhEM1UM5bz1292+oVVr6gydhTE2stX2BiCPJq1+nXlajZUARUkmr+M3JY3rWzzPf
	 307bFJiQW9VDrA+50cDVLPeM2GKAx0kE8/V16FprPr8tZVKmjrlPcmNdGET6vx8RE/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1F5gBEq1j8Z+ImGUtQMdnM0+OeY4rp2MspAzOkrN2IA=;
	b=WqBDJUJTZzj9h89s1WrHCQN3y+gQmM7uMyvrlDr63r+FMxToitIpTNkRuNFDRNNN25o1
	 Lgk+pqICtn2A/yADFMlknc5E4wtOkiNz7wei1Q6trCrSL9TBd/rzVYoUOPVBUvvQKovBL
	 ujQImREz3rvZJ/d/27yoZP2Ctb4PW/X1L4gvG1r0iEayE3tXmmE8XTs5pIEVhiJGPkZr2
	 XvuOT2R2OqEhA65wO7nxanB1BcJ5YTe2HOOyKwcDH1bGDCy9cRgrIwi3+hn8+eXivYgmw
	 3ioHYyRMAPcfwfb2YWhvs//ChcjuB5aopRybNVbXGewmyxSRjiaLxjL/OXzh2Mn2vfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ubgkt+Al;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83DD1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ubgkt+Al
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so6002731f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795707421; cv=none;
        d=google.com; s=arc-20260327;
        b=A2dWZYAlFHByatjJY0zD4GB/AN5mkvTS5C+xAzDPNrSBH/0hPbUOJYyx89rAL7TLUW
         euwGAeLt+OBOCJDJrfEGHiMBmnriH3AbTpFU7oohv/lxtFNsZpoUTvuuJEkmAGbuMiPj
         Ssrhxy5XkmsL22CEr+QW9KrIrSh97jQ4I9w1DWXOXwwAFy0lS7eUqXFu+5n8Z3FtaTAN
         eGEME8Gk8zEntVM2zPSwCaSgRGVTaqpmRTgXkc+5GzI2wZDJQJT4N/BNdmwQi0kQnWQf
         TmF/0Kkl1Bpgav4gXECt6q0q4AOLZJgDuQMsOMtgjjK0pi0QGqjmnlvryp7IWBUPz3Kl
         q+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1F5gBEq1j8Z+ImGUtQMdnM0+OeY4rp2MspAzOkrN2IA=;
        fh=ohNi+aOQTfW9zckWgE4gTSxTM/06XG7T7464WpxR4fY=;
        b=hIAUpJmG9qh/6L8DtidchpkTasKfudeKriQDMQA/KnJnfh/9hab9V4gJLznlKetBBW
         ysv3oGYexbNzzi5gly8Wi2Pmd4rcA8Iix3dtCPHR48wZ4Q6fuQ3W1LHaZ8rsj2H8A9Di
         HtOqK8ZjK2O2O8xYzVqm5w14i4QG1XiWuNbvyqGsaTExqWURi2n2lZPUFcnexmC2aidU
         kvcthH+HXqtXZgGq9jxO0LU35cJ9zypVjLAqf/A21l/J34hLhNd68JYDBFdXSiWSvI/0
         hblizctGsEbly59quGVjD9hKomcoS59pIeST2o36uAkQiAQTn1UdlwaO5TwO5IgkyPZJ
         7LjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795707421; x=1796312221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1F5gBEq1j8Z+ImGUtQMdnM0+OeY4rp2MspAzOkrN2IA=;
        b=Ubgkt+AlDmmUGSGz7Mhrr9yYeiNfQH/Toe5RHPp1SlvZ3axazlugfi3JMHHPxIcCWQ
         eNpTUNNbA5M2jGAYXlTmQc8yb9zLRcYPlC4NV9SfBfLqSJvARiiam7ehWhydpkNNFJAC
         iMe4MoQ65gNjjPh9ZDjDA+vHxOZlv246QqSOrRROLnYpwtCpohMb6HQYi22inFTq2Zw3
         njil2DOBB0EIZRL5LSC3f0AX5fKn/dGIWwi9hbZ6I3DmytUXT/N2ALmvz23zSbRtYgS7
         vyMopYP/XtMVPZSIvCTfJcfHEBrQA+BBYOMVlqkdCOVF9/fBr4FUV33KCDb0rxSah0mb
         nOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795707421; x=1796312221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1F5gBEq1j8Z+ImGUtQMdnM0+OeY4rp2MspAzOkrN2IA=;
        b=yI8cwWYeaWzFWTcDBxAkRvTp3+l4t/i9I23lIJm6e7zdmw5SjfRVVBu5wkcnF5SV78
         foRCDbnVShxtY6LjvCBgNXP4OmRxgJ58bix7Ov5qtYzRSflDA7oFtlItKBOP/oprBwMo
         +aPlPPM8+P0Ta7ME0YaEl7ugHahSM+yZeLvTFrY00CMSGa8AG7B0PHSn98Z6BtEceTtf
         7T+gTNxFc2ZkCf9vQ7uDP8oUn+TVdpTPgvwE9IZnlDGVc/PHdMbf3COEuxIp+20Vipwg
         KQk9KKbmuIk+M2M7J/I7rFO/1QJCvAMEE3gCTQZjHn3w/9GvEXErTQc+S9TjkX+MCx2h
         VOiQ==
X-Forwarded-Encrypted: i=1; AL+hErERzx5/F3p9Lgr7Cu2mISTeR9JwH///15fhnZ2BVcqtrEAedf9l11bIBqSStYgFqBBZIxiVS1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XXHtRLCgh9RbWCfX9JaL6hrlT/sezjybPF/YQ60qG/RaIRFGQ
	W7n1XQUmKuYyn3Svy9+QD6tIL2WiTc+xWly2Q60PgJWFtxb+9FrnXNcVPjT10YQY9S8sol/mAXJ
	lPFPGJInN7TAB++T93gye22L2dHusaYU=
X-Gm-Gg: AZFdTZdRJ2ElZtkr21rPQs34tDQhqb2NFrieldoZE4jiQ8gzuPP0pgDAn4z5qsbbW69
	D42vZBBDqIPy1BaNMoqIPiWTn72pL0164qVrmMEqXsdh3KkqnNWVx++ZCjB7TrzeAAQrb76mh0Y
	4exl7pBxRebU040XaPCT0/lKfd31kOrGyFRNZg3hxbSCHv3tXYpTqkmARuIYF1QBRQY2cQ0Mqlu
	/zCx3RsewSQ5lQhwEixJ9qkiz7+Ucs9Wa1hGd7ysiFiqAACqi8lgPxUWpB5nsrVBE6fOWkl0ZpX
	vFOYkhN8qrGloLRoKFtdemjapqISloVIsXX3lbgsn857D0uqLa1PII8mv8Ugo5LQxh5ixUfszzc
	nWT78aFekXu2UbACIXEB4CdaSolfhZ84SI3/7Ut1j
X-Received: by 2002:a05:6000:2507:b0:4b7:66fb:b092 with SMTP id
 ffacd0b85a97d-4b766fbb479mr18549308f8f.48.1795707420665; Thu, 26 Nov 2026
 07:37:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <awhPAzKefJVW2meb@ashevche-desk.local>
In-Reply-To: <awhPAzKefJVW2meb@ashevche-desk.local>
From: GaryWang <is0124@gmail.com>
Date: Thu, 26 Nov 2026 23:36:48 +0800
X-Gm-Features: Aa3M54pk4xmmfA0tYss79tXijqcYIwfVpGXaRa6BXvaRt_qpUfc6C8WO5pnowO4
Message-ID: <CANYHO6o-eNMV1YkRfP=W7XxmefBW=U_CALRMyWSixkXzk1uBtw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Richard <thomas.richard@bootlin.com>, Daniele Cleri <danielecleri@aaeon.eu>, 
	JunYingLai <junyinglai@aaeon.com.tw>, Louis Chen <louischen@aaeon.com.tw>, 
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 11:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 26, 2026 at 11:09:43PM +0800, Gary Wang wrote:
> > Add support for "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> > "UP Squared i12","UP 7000" and missing groups and functions data for
> > INTC1055 & INTC1057 & INTC105E.
> >
> > Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> > on the AANT0F04.
> >
> > There are no compile-time dependencies for each file, all pin groups
> > functions data will forward to set default when pinctrl upboard probe.
> > It shows an error when run-time dependencies are not mapping to right
> > groups and functions.
> >
> > The pinctrl-upboard is provide additional driving power and pin mux
> > function through native SOC pins->FPGA/CPLD->hat pins for flexible boar=
d
> > level applications. it's probe from ACPI device id AANT0F01 & AANT0F04.
>
> Thanks for update! Looks much better now. I'm about to apply, but I want =
to
> make one thing clear before that, id est is it indeed ISH has only a sing=
le
> UART? Or do we need to add an index there?
ISH has 2 UART ports, we can add an index to identify.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

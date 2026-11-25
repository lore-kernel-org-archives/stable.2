Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615147;
	b=MlXoJ7yAiM9RjlvjVjF5LhjOL2uXgPFPa7Hdp/oII8C4NbmTvNsmwwhDfjWjrXfYByZL
	 tyHoMNORUZnESw/y8h2fPYqqBcbqNnv3aFyvQk6Erui6s33hFZeWVZ9KOGZgRlRrCorJo
	 Ui/vyK3DtFMcAn4CkbEwBLEvQzgUdVPUZZTKEnzDnSUmGasHdIF8HaRQf6VggtwLGLXHh
	 IvegBfpk94ZY4iJsT/uv/y2p9mK8N9khbo0PRDDzT0GSagjVC3rKeFOIvU9pK5wQX1/yE
	 J4riidlYL9tusDPqXCYt8Ym8RC89H9V+fGPnPrZSaSji8uK90jtIPhgbGWly3OU0i+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=09UPLto6axokpNWgG+6ModtbjIWY6madfxL1sFeVDTE=;
	b=BrJOsX6en9b7YXcRHAnLOrmqHQNTQfaPUJRqYrZzqG+fhYhjuNvfBfVnmyw8+MS1+fue
	 EroBlyLOiG5bAmEtXE63j+pXQLsgV7ot3Yru7PRAH3FFMQM0rwJ2U6ZV+B45r0XAjqDNG
	 Jz22EtOGzIDxuI6gah8w1nIGTxMektXjwu63uiXMdA9RqAVxFF8UKXs4ouqE2V/ERCzTi
	 SftXsT8xyrTIwV2nqeJvBi+CJbQZlyn9MpCxLgg7APMG8YHxCq3vPvFcgwEKm0ZrJu5pI
	 1aAM2edUj1v2C/rItf5eW+e9o/ni7CUjpnsQwt/jyQZTFO4KiI/XdrFBiqssDyiIEhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Wmyd/y0D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9427606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9427606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wmyd/y0D
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a42b34e930so5056463f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795615145; cv=none;
        d=google.com; s=arc-20260327;
        b=oWGIuyT21Q7LvuUhhkyi+E5VHkgN31B/1aoOqtH7VUERSFNMqFO20DDWajzPFk6zqr
         xjwzfAAfQt9q4UD1upF2b67mG3LhTPSCkjX5Z+x6m1sbDaHL5velct/6gI5r496NlFwl
         pLYUQt8M5D5mUutuvFBP0yvEsxW5TkvsBsPJF3H5PF6Sp578TCVNCWCrai5hjJWFwKnG
         4kORS5fODimI2bINkjtB9mm7aeg3Ao8oOSvrCtpKm567oqk8r8Gubx9ybaaefZesI181
         Jf8HE6A0ZM+xcMynbXimOphL7Jz4DKwOMDXOuKWsWW15eS8Wbl2jWVm0eN5yldfnlkb+
         xMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=09UPLto6axokpNWgG+6ModtbjIWY6madfxL1sFeVDTE=;
        fh=uVO1zCRrFgyMUrBrcLsdTdl/3a+sLEWRJMNETLScwts=;
        b=D0ST7KajZPojz49BRFkck/HOOdOGFBxkEOD9OjgJ/8C61LG4Wi5M5aP4R4zPAmio0V
         sA/leRh5ppph7qB/unZZI09ftvEuO+OlSaZWPOhPHBqysDN/kmq2nrqZ+2Tj+sE85vsW
         O7hED6p6ssEDagMCG409MZTW1+5jT1yDk4ZQyMJaGqa8FmmbO815wsJcR4kpJAG35LXD
         x0Bs3cA5X7BJNq/p7NmQibXzCfTT9FnXpNe1kfy8cytUvCDniB2F9YlhM63y1NCIceYx
         LHAkhJnqYLQrLM/CtHtfebb4YOBJUM6z6N3oiJIi9fUSUHzSy6MfNFxNDhn7QizEgR5z
         E9Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795615145; x=1796219945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=09UPLto6axokpNWgG+6ModtbjIWY6madfxL1sFeVDTE=;
        b=Wmyd/y0DLovIGl2bT8rvYbNpCaVeCRx2typ8roczSOcFM20V1I4zDlREol3Er0tywQ
         H1F/1d2u3M7q6LeZKpuKD93ZpSkLRFYCFYM3WP7GirEDjZg4gVCmXxsrmfM+AW3VB31y
         CHk5nBMwo07qh5XaomSLQ0R6Jb3+cpIjHHzIrTi7iN13sAxAeaITwl4sLDRec6fUKSbJ
         KjD40arUGqjhjl6OKB0Febh/m92Imc+nFIWXonuqenHf0ZpimJLflZrUJamOiBTza2vf
         Lrk1ow39lYiN08Jvhzckmvyt2dI1LVvJiwE5cBk29X0d8yRoPUtMltMynSkuDG+miYIk
         lMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615145; x=1796219945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09UPLto6axokpNWgG+6ModtbjIWY6madfxL1sFeVDTE=;
        b=TYXPlSZgJbNP5iryBrxrTdfp/zUBDNClR7kSpcASBcRv3SrztJQXF8a56HQegHBtVu
         Qo0b+oAmI/BKUSCAU/wMEe4RLXcslKsJKgadVBAPvQ5K7oRfsLY2KSNQjwNXiNWijcjV
         +llvZU+B44a9Be0X+NKZh7Uqu1b+F1vRtuU4dzpM4KE2CWMq68Hc4Ee+0T5Q+jdigTrU
         EfkbF8lmPXpd56VAaZ0aDHLol0+cKrVJUjlNFE0bBTvNQ0dyp2Paa0Su8DoLnO7QDeJi
         AP7YKFtZutM2USqq49x8iE1IF1VPYdG3JKIPLA6PYhluXYXIFAjsAKWv/p5lfeHZuY1Q
         LZ5w==
X-Forwarded-Encrypted: i=1; AL+hErEGntVaVgeMam+XKeCxt9lMc1sA13T6L0P/REvQbw1hSGuoEnjha3eic4Sa1dxCpDtb8X+qpeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z96o2UzBVKDd6z8du6sxQ2GP0P6gIWIYD4uZZpZ6VTQ/0InV6OO
	WhZLI6+BdXqaHOGPKRcKsEsV5T4yWXdCsuYiwx+fzTC/if/yAEp48eHKIFXEpo3txiXzA5OIgkE
	SeB4AGXCsFvyHmHpHYv+lN18KHNwfs1s=
X-Gm-Gg: AZFdTZc+rYEGRCsecnwjfRp34QtUx+X82mQqm1Z05p5bUjIKqpt4jeMma5SmEMRXr7/
	YGbeyDgrold3Jrvht2xvIF1dW4CZG/LkvXRITPxscUHWmLhz8y4CA84Epd9Ok74UscmHEHW+u8M
	sKWouveL8Ie94N/qplCsWCIEZW8Hf/fIHCiqxV7pu7voK4VgDCddtURN54hAkDYWC03HC8LZs2g
	V7A9ILnJePfBSfhHRu5kvdPhAw8UO+MPA8maGu6D5kcJkAkb1/N3JYUQieBgL1rGPIpid0EdGDM
	JHjHLcHxlliRZQ93Ibk6AcqxUQIYdYjvvhQld+uWWokgWDkrEZgiGhfxcQBRvmiGcyYmu/a8Wv+
	cHleuJcS2Ao8LVaGS+SUxByu4IX3ieggfFaeCTw8=
X-Received: by 2002:a05:6000:4014:b0:4b7:ae36:5493 with SMTP id
 ffacd0b85a97d-4b7ae36567emr11689293f8f.12.1795615145005; Wed, 25 Nov 2026
 05:59:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
 <awXJd59jTHM2bIlD@ashevche-desk.local> <awXKVXS0kIGnA0lD@ashevche-desk.local>
In-Reply-To: <awXKVXS0kIGnA0lD@ashevche-desk.local>
From: GaryWang <is0124@gmail.com>
Date: Wed, 25 Nov 2026 21:58:53 +0800
X-Gm-Features: Aa3M54psDnYYcIAEdsGV8up86M6nPP0lMFvOZv_SlI_4KubbZ_Jtr3McMresRDQ
Message-ID: <CANYHO6q7Cx1ah7cJMfyeu83v80VAFcx-2TQNNWM6kNSv0zB7pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Richard <thomas.richard@bootlin.com>, 
	Daniele Cleri <danielecleri@aaeon.eu>, JunYingLai <junyinglai@aaeon.com.tw>, 
	Louis Chen <louischen@aaeon.com.tw>, BillyChou <BillyChou@aaeon.com.tw>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 24, 2026 at 07:29:32PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2026 at 01:10:34AM +0800, Gary Wang wrote:
> > > Add missing groups and functions in Tigerlake & Alderlake & Meteorlak=
e
> > > for INTC1055 & INTC1057 & INTC105E.
> > > Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> > > "UP Squared i12","UP 7000".
> > > Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> > > on the AANT0F04.
> >
> > Make the above bullet points to be a regular English text which explain=
s
> > all this. It sounds like the second sentence should be first to start
> > with what is this and why. Also don't blindly copy what AI provides you=
,
> > edit the text that it's correctly split on the paragraphs and in each
> > paragraph use full line length (~72 characters). Each paragraph should
> > be separated with a blank line.
> >
> > This comment is related to all commit messages in this series.
Ok.
> >
> > > The pinctrl-upboard is provide additional driving power & pin mux fun=
ction
> > > through native SOC pins->FPGA/CPLD->hat pins for flexable board level
> > > applications. it's probe from ACPI device id AANT0F01 & AANT0F04.
>
> Also you ignored my comment about how this series is supposed to be appli=
ed.
> Intel pin control drivers are maintained by me. The rest by Linus. People
> won't go through the code to understand if there any compile-time and/or
> run-rime dependencies between parts.
>
There are no compile-time dependencies for each file.
All pin groups/functions data will forward to set default when pinctrl
upboard probe.
It shows an error when run time dependencies are not mapping to right
groups/functions.

> > > To: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > No need to bother Mika, he is not maintaining this code anymore. :-(
Ok.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

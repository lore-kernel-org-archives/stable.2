Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FB4CA777
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544962; cv=pass; b=qmhtuzYg/gDBvnawopoa6aVo06i0tO7Vl8+4gzxaymFQIaBnyybebCNXwChnWdngD1b4uGSFN8QjDFDkaFxY5K3eALA1jU9gONI0kYGT7JaI6s30povUnqXXfevmbTxQpjkkAGI2KS5RiFRGMnxkcAtuqCBwhrv/BTex0tj4Q9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544962; c=relaxed/simple;
	bh=RA8fsEDD5Aia9QBWoZvERTD0+3MACqfVNv505KJYqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCv2LM03P88Grnsbtl7ngla+SzyuhpWlG09sEnrSlVeJBEg5urqeO9PqoLPIzAhK86zCoPYbY+ZsnZ2BvZbQhmx2iIehvibgcNpGshCUysh7dl+BlJB1tgCwQVDfv44cxaAHN69/iPWQCur3sObpO3YAFUG1DhmZUQKaIlJIE5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b=tMNM1F23; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b="tMNM1F23"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so5397372f8f.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791544942; cv=none;
        d=google.com; s=arc-20260327;
        b=NHdaHIjHBGTNDYKTW5Zgm+9KvcD088yFJxn5wA0JIeACd1sFMyNglgt3/56cTfyf0u
         2LxxbiyV30jrMY5k2iEA9lRQjYHweeezw4U5xUJCmzVmF4fJA7cHFwvXEBKI3pAboKUL
         vdVmEvwUY+onsUQTAbkzoPPmTIxqe0xGahjY1SLEIduJxQO5s6ujv+5zoupzIqTFYtEd
         5GzvABeoVhvHH2uEFTYccwG+idzTIuRj6wcaIfn5UF6u3Uy3yEtFMUfMuf18Y0gR/LBy
         y4jLDPuLdx3tL92A4n9Xo/6nLZO8XcX3Z0+XJy08IpNQreZWJ0VLGIwrYH7Pf2bbEsa1
         zaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        fh=od9KBiGIbiCFpoqZgticRjL7X9lEYfwMsOrVYJzZ2ig=;
        b=oILl0El5UgU4KN/RQFOUaFY0YN29P5YESewexzP4FeUOK9djOvkpRcQUOrg551CnEs
         ZeKsY0+bp//VXay3qOTKxquBUZP8RJ+2fblug0Pk5wAxi8gZ/PU2DOW6sHy2KLPfVtbf
         8LUMabDTjeCPUztOXGarOb5psBD435cuoB5GyaloCf9VLeX1MAIhUh8zSVJtIard/fht
         Dw3uV90DtpiXK4rnROti1Mc7+0F4/MFGYb4/3Wxv6FGzUcn+jtCmjx3XfmchxsuZKKqX
         Nap3P2fzpVMOmBCuVrIi7bdh3LyD+OuiumUgEqxNU3dU4oKQ2wm7GG5gtTgD4iXFtBSg
         WtOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1791544942; x=1792149742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        b=tMNM1F23DqkYhX3cNSTqbrxqMBC/HeIMYGg5cie7+Lfcw53AHQrMZmEwIQ7wmVJITu
         8OafZkSuRq7T/v7rG/p2h1G7b3HAKNuT0yM0LcDFLsANUIPR0K4qtZprRYa+RD02E/WW
         xygsuzoa+6HB9Bk/v7L+c30ryXcIj6gV34+kIjuZo0wnX6lcNEG64eNDzZI98GdsJnHH
         q5AeDsYbxIcgb/36d0bZQ3jil/Q5uBHO4qf0Ux+Rgc3Q4vj6I2pDD1xS0S7SiRBviGq8
         BE57fLIraGJT4TLsqDoH4eOuN4vdkSUDbzxjQY9OWOxsv/5r4L1wdqtCa8ZQWP99cLuK
         C4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544942; x=1792149742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjZIfn36vwwRnDJGfxZP6hB0pBi/BfTnn/8/ousp3gQ=;
        b=BiEvc8ra6+tqEdwfiJuxzd6GRJXKWVaVOiMW2SgUe3Kik44Z4hIMpIlzbdZtgtQeph
         k6nDukbASE6N6F4Dot1ekxAcBkno/wmYGlg+ugreRSB43oSPJ0358wN9GVQ1CzcGp3to
         mKDOlr5n5Z7CBSObOwFukovrxMYEYrfb2Gd8d8Jhpd154fDVPANavEvW8TByFqk5tm+5
         tGS58JEc7IPHaWsXqer5cBMGhnQQb0sJKK3Ku2x6AA8wsNj+rNiwx/2DD8S6AJWHWeav
         7l3WTcYCuayVamIk5g1u/sIynUv1VPzvMwv7hxqweK8k/MzRHhW0bkD7QGllIwROWjfC
         BL6A==
X-Forwarded-Encrypted: i=1; AKwUvBxblo37gab64MCgarabyFcuTZmYlbUiaOTe1DhTEg+50TliRTQCG3vyKIqmizBE8gWnKPNmVSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOGKyWm6MKq11nHmH3el60Gk+PDqgXrHnlaumQ3e15Bm1JFJWp
	EIqGMk1OjajhVI2SloXKCLLfK7YRMy1SZ4u6koZYE9SPKFrTYTktWenAuTIsW40gg9/t4yIh7g3
	VrUgz45IMXwRUKqKYGehdotIlx2DgIh+u3nZneXc=
X-Gm-Gg: AYBFou1qxvwyh24kHjgr8LoffK015FBmD/s4a/SNTdFljD35EW3Hr2E+IGvXe12d/Ur
	u0bgUHQu47LHMAQPTclnr1vN5xgnc3/Yd+/r6NZzSHc125G9UaKja3yZ+ERIRl2b9L1OVz/GS3X
	JAJczg1Zi9QW1zFdOFKBuawthe3UAIX0Tq6nAgViw9inrmTsMKTF+k3yqL09CvegxKktYKFQqUN
	0WTZOzYdQ3hK1neFieq9b0FemcdiXFNH9DE8k0rRMrC8FkWragXBnHDrz7I9yrG7d/3k6celM3y
	e0BHHuOxpl7e56liXOTNLY/qiz8LqaeYpcm8Bw==
X-Received: by 2002:a05:6000:240b:b0:487:169f:d339 with SMTP id
 ffacd0b85a97d-48dbacef394mr2591008f8f.54.1791544942262; Fri, 09 Oct 2026
 04:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
In-Reply-To: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 9 Oct 2026 20:21:55 +0900
X-Gm-Features: AclHuK8WMU2f9s206E9gcJrWGqo1xWTIQN0qw7OLhbmsPMhw7KL5K4OmY2f9m7Q
Message-ID: <CABMQnVJzcpMqfa-J_rS9rQksoz3XCKrWYmwiD7JU0zXx6BKyPA@mail.gmail.com>
Subject: Re: [PATCH] rtc: pcf8563: pass the driver data to the alarm interrupt handler
To: iav@iav.lv
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch.

2026=E5=B9=B410=E6=9C=885=E6=97=A5(=E6=9C=88) 8:57 Igor Velkov via B4 Relay=
 <devnull+iav.iav.lv@kernel.org>:
>
> From: Igor Velkov <iav@iav.lv>
>
> pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
> registers the interrupt with the i2c client. The handler then takes the
> regmap pointer from the wrong structure: the first alarm oopses, the
> level-low INT is never acknowledged, and the interrupt gets disabled as
> spurious.
>
> Only an RTC that has an interrupt (client->irq > 0) reaches this path.
>
> Fixes: 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on ODROID-HC4, 7.3-rc5, with the INT line wired to GPIOX_5 in the
> device tree: the alarm interrupt fires once, the alarm flag is cleared,
> no oops.
> ---
>  drivers/rtc/rtc-pcf8563.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Nobuhiro Iwamtasu <iwamatsu@nigauri.org>

Best regards
  Nobuhiro

Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794347284;
	b=MiUyrnq70PF15ewc+4IpfQYr+mI4Ry8v4gmJQV/1OHRGj+kZplWh+gJFxHiPNsAN8faC
	 SASxZFfZM+jXc4MmEwCP1aV11lXFn502Xby3ThJfR0waWMhzS8EiWSeKehmNKFIPMtBBJ
	 ypFgDi403/jYqZLkNk85Lx1ZeE5UTDApdFE4y91f6apLszC+QuWlWSkmNQ/CxcF/APDaB
	 CQeW4/QwG7GsX8jwKC2IULTu/YDK+sRhrHgTlrcxpsRUEJtYo4NXV0cRHyUH9YwIgZg9U
	 vivXpOmEddHaOwtAbQBHG/gp+mgQoVSeny+z9ge+739JJjMvIxICaofIEWFYwNZ1VxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347284;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
	b=CkHv1ukJob0ME78jzmWgNYpjtuA5UaWRKpO451Q1pi1Zzla9JKytzf8gkJ/rvQPNJbDr
	 5Yd/eWx4m1tn3/aVnOEywgCaLkanLphvc6bw7dsZyrXlI6+QNXW8KuUz6tsmHvBpFNLaR
	 CBDTHxxqX10wDnaBzlPdy1nENQL4HmC3Iyp/7nqwJleHKBWzWkp5gkDB/ENIR0gtzR0s1
	 dCodAgU1mQoFUq0CO6aZCf/EZbfr0k2rkItDYvVCAaz4hktzAHLDO9maa+mwMjGPvYeej
	 GHyPPNjLmKmj8BK6hc45XRwTDpLkGf32HVVqnADqigsnDg7rv6SAUDPzjzKEWMdNcyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=fail smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F2606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236F2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d58c50743so204153866b.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794347282; cv=none;
        d=google.com; s=arc-20260327;
        b=kTr37TjmIZQ5qUow0oshI+NbBd7kaDEYDJqTDpHxhp1r4M7NuS+XKBlfUJwzw2ZCLX
         La4uFv/gHKlefXJhfB8G7sHdeIznNdIfmaURl8N8ko4C59QqQFKhy9v+NHrFcDYm2LDq
         LupASq2joWY9qclGZmMzIGAo2fRFDtLpB8HN36YUc4xKJIMhPu2ZH+HZfZHVttuGPyJZ
         cOOTt9+2xJpqJU/9zIjF8nNi1EvRAUp8/iU7R5eUbAiDJBX5OXUs7UrXTwNGiLcEYtKm
         zL5T1kxMKE/jvQiaJU8F6czt+0BvGr5BbvNvfNbsQZ1QV6Cm0o3SQQnynuVr4m4MJTLF
         uSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
        fh=d/a561BSGXiTs7WyWNtQT1Dng+xzI8S+CAviZ24bxIE=;
        b=nyAlNRJ+2HfZne3SwgrDOKWQumwQtMX0j9jKx6VwCyZUBVhvLGlyldYGGkJNHrxB69
         gzi5Qd7npxyEsCwrqGc7esJJdNe+Dibuf623dyehZYfaZdQt73tT8jSR95GjXsn0pAoY
         Z8apJxrBRserhrNbr0891k6ycerQe3iV9iS/Yw7gJJ+mUhKFDQnD1ALPop5GZ+96ns7R
         rYbTbIl0C6PCgfJ4rovW5XGZhEF4FfnqwfbAYUnTOtIzUxJxqgbzWpTuHsqV9I/b4hGf
         nc0QBuJTgiV624ldmudTDgzeO602VpRGqRB8CQg0AzVv4nIg87KJcowsujDbP4h/r68T
         Xctg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347282; x=1794952082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
        b=izRIrL7ckKSiRz+LOrbO1+85tH8goz5ZKs8himt41Q5KygQo+ALha+nkyO1jn23Yku
         koU6pTE8lBNWyMXNuGVOCmweFBmmGXhVONWRG9VoHATU6Yc1ppq8CY/pQE+y0frQFGht
         Tu07jkMWNxSRR2IkVDITE7f73k4qEUdn6OK82aXIBmM3zz9udyEpsLhWLaSfIgLRdPX5
         Pv0Aw0dX8atMYROu84n2LKWFbiNSSGShDz/vLLH/B1u8iPLfwddBvxVnoJS0OL/U/icR
         8qtGVNroqKTwVatr1FS/aU9rLXLurMsq3a9OWPUUxHxsa46Y2KRMwR8IfFCrOcVxCMNi
         T5qA==
X-Forwarded-Encrypted: i=1; AL+hErFk/Neq4yAAAVeeLS5owCa5NdgrWEjxvu9X2TzVU7GsEdn0eixRQVfIJu8cPwT+q5yJIlS+0GQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sKV65z1gTZYuxn/hd81n1txkEppDxpvvhKz8gALhDhpi6eLrv
	1jT18OlKIuuEOBLsHFGHSPKauodAp/Xel5nbQWoUGv6Pite/GqGXvbFXuLWq9iZwh1GhD0mDf/r
	WrWq2UPjecDfoBYcS96PMT0qPptpZG7fF+8I0ey51hg==
X-Gm-Gg: AYBFou2Gqi4hGtAmvnHS95EIgpZ/LXZ0+Uk6xXjvjCddR/qkn6kR60z1YvqGWmGCNte
	Bx53lrya1+nSn+NNNif1e5F5RWbjtyWkoa2X7r/gFUdxpsGfACNCBpbfNr/Mje994HsUQc43EfT
	M7OX8pHYl3JdGyQ8Yqp055CXedoEkI7e6K4Z2SzEHTItcnQf/XneLEY0mdyQ9B1oGnp0rP3eT9J
	mMzPQ0FCEZFFQi0+83nOs/s43vIbHY4HgHIdx4+PcmlC0ZtsLCrQsqTq/RoOFH+kYzc9RXIaYUI
	j0up2n3KXGalY6Yc/XLXQbmW+RJ91T7mZf1CV2DvMir2g5ZKXKlNCa4u3AvuwqVBxPJ7RRU4jTE
	ERFo2onqilSH3MaaYfDEVdYN3OvvkFmmwXtyRk0SGDoWtQc8pc/WowkY/m797Akxf7GI+UC9sTR
	GHeZIQ9L9rH+ndRlo=
X-Received: by 2002:a17:907:d311:b0:c40:cee7:3918 with SMTP id
 a640c23a62f3a-c5066d8cbc0mr27479766b.44.1794347281996; Tue, 10 Nov 2026
 13:48:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151914.2651241-1-opensource@grische.xyz>
 <20261104151914.2651241-4-opensource@grische.xyz> <20261110122536.7cca85ce@kernel.org>
In-Reply-To: <20261110122536.7cca85ce@kernel.org>
From: Christian Schmidbauer <opensource@grische.xyz>
Date: Tue, 10 Nov 2026 22:47:39 +0100
X-Gm-Features: AclHuK-CLlMl769sSx84CkwDdaR-obj6arfB97PbP_3TdPcxS2uglw83nZZfEio
Message-ID: <CALsH2cyxzm3OTzyyFhBk_LSkFk4sw+6xcAtUc3hVJoLr8WO03w@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  4 Nov 2026 16:19:13 +0100 Christian Schmidbauer wrote:
> >  /* DMA operation mode defines (start/stop tx/rx are placed in common h=
eader)*/
> >  /* Disable Drop TCP/IP csum error */
> > +#define DMA_CONTROL_DT               0x04000000
>
> Maybe just me, since I don't know the HW, but what does _DT stand for
> in this context? Other bits seem to be documented with a comment,
> let's document the new one as well.
>
> Not sure what the comment above the new define is deferring to, either.
> Should it be removed?
>

DT is the Synopsys GMAC field name for bit 26 of the DMA Operation
Mode register, see [1]. The line above the define is actually its
description. The define was originally added in 47dd7a540b8a ("net:
add support for STMicroelectronics Ethernet controllers.") with the
comment on the same line, and when the define got removed in
5a78fd3debad ("net: stmmac: remove unused definitions") earlier this
year, the comment stayed behind.

I will move the comment back onto the line of the define in v3.

[1] https://docs.altera.com/v/u/resources/r642178/cyclone-v-hps-register-ma=
p

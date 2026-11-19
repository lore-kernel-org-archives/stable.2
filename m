Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098350;
	b=smA/i1o6OUIB6EgWryyGKo6N5cxTCNzs5YuU68BNcNdnujH6dSugZ8D3yr+z31ba6Uab
	 HJ6H0ttw/XA17+RiRkDeSdUPkUos05dF0BriCqT1Dvi8LW67kdmFAFK23kfs1k11orBpI
	 pGZLyfFpj75V+kJ+VYkL1rAn5VNPfFeP7cCjJQGOU7Y/cgxqkEogNPW5yJnxZKVaEyaFs
	 euH5Z9PPqbCRO+bNPL4MEELYij2bBNKw0NPGjKbLFDMTCafPDx1faXr4q6a0ZV0PcAWhm
	 z60/GrSTmwSDp2wdnY/c+kuF9Hf99EJNc3um0OObEdCPgCuj4GVAIGo+D7m77OfUTAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098350;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=S6kPe4NT7AT/fWRI9vLKBAOhSOih33xoPEvUpOSU2Fg=;
	b=njs71FugmpSohmkJxTLmF055N7C4qH10kl58XCsR8Wb9d90rafH1xLREqNxoi6ByUqNy
	 jpUpHNaOKRnUjYAttpBsyM9lNlQJAkK/XDgAlumOCF6tppfGyBjoKTklGZG0bLS8c27o2
	 lHvTDgLXJx2fU3YWaRrVlH6z7PMHOis0MxUS2lQjEXIWkmjYWR/GiH/FS7xW5zhR3YjoJ
	 p+u1JsHyhxHtmKi/sP4hnV1ws9fhceiZemVVM4NcQWwLRJTouIm/8romwTDvULHA5muK1
	 dMottEQcyZDGBsOhBK2cDMd0wsHvSmxHKRsQpKu1RPnCM28qt/G3gFoy31F0nzVw7ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZLh4Rn+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DC606A320;
	Thu, 19 Nov 2026 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZLh4Rn+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D0C1F000C6;
	Thu, 19 Nov 2026 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098349;
	bh=S6kPe4NT7AT/fWRI9vLKBAOhSOih33xoPEvUpOSU2Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZLh4Rn+I33L7QzUDukfI7AtJsC+OS0wDo0SISBc969pfmC189iVgLEY/4cd2lqKz
	 shbS1JYzU6I9OAevIyJcZvUHxADzAyy2vdnxF2M5EqJFiNnXlarq35NqbcM2Ud09wN
	 jPEnC57nJ7RgrI3qTu1UqLhzzVssYUcBgkL0DB0+Kn9MQ8KwXeN6j04j+pqeCcOoaJ
	 NweiH0SJXNk7+3jTGZECVxbLrVbE1+sKgiB2DxrQsbgafN6hveUliuS4mtmMJW9KJl
	 2ECsbnD4QrDow2jsCDQZD+mcPlGB8u4Z8JvVKXQyCuEn1ijPvqT8Uo0o+Ty2c/r11t
	 y3rT8JIJ5eM1Q==
Date: Thu, 19 Nov 2026 14:25:44 +0000
From: Lee Jones <lee@kernel.org>
To: =?utf-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Cc: stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 3/6] mfd: palmas: Fix potential IRQ action leaks on
 removal
Message-ID: <20261119142544.GR98456@joneslee-macbookpro.roam.internal>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
 <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn>
 <179370041880.793788.14407997006744050474@kernel.org>
 <ACoAEgCeLDq4C5*UjRtdZKp9.3.1795092235677.Hmail.202321181@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACoAEgCeLDq4C5*UjRtdZKp9.3.1795092235677.Hmail.202321181@mail.sdu.edu.cn>

On Thu, 19 Nov 2026, 李广硕 wrote:

> 
> Hi Lee,
> 
> Thanks for the review.
> 
> From: Lee Jones <lee@kernel.org>
> Date: 2026-11-13 21:09:18
> To:  Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> Cc:  stable@vger.kernel.org,Aaro Koskinen <aaro.koskinen@iki.fi>,Andreas Kemnade <andreas@kemnade.info>,Kevin Hilman <khilman@baylibre.com>,Roger Quadros <rogerq@kernel.org>,Tony Lindgren <tony@atomide.com>,linux-omap@vger.kernel.org,mfd@lists.linux.dev,linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/6] mfd: palmas: Fix potential IRQ action leaks on removal>On Sat, 31 Oct 2026, Guangshuo Li wrote:

Please reconfigure your mailer.  These headers shouldn't be in the body.

> >> The remove callback deletes the IRQ chip before managed OF children
> >> are removed. Their later free_irq() calls cannot find the disposed IRQ
> >> descriptors, potentially leaking interrupt actions. Depopulate the
> >> children before deleting the IRQ chip and auxiliary I2C clients.
> >>
> >> This issue was found by our static analysis tool under development.
> >>
> >> Fixes: 124e9deb1c40 ("mfd: palmas: Use devm_of_platform_populate()")
> >> Cc: stable@vger.kernel.org
> >> Assisted-by: OpenAI:gpt-6-astra
> >> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> >> ---
> >> Build-tested the changed object with x86_64 defconfig plus COMPILE_TEST
> >> and the driver dependencies (W=1).
> >> No runtime or fault-injection testing was performed.
> >>
> >>  drivers/mfd/palmas.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> >> index 7fc886f4f80e..8a0b7b1e89d7 100644
> >> --- a/drivers/mfd/palmas.c
> >> +++ b/drivers/mfd/palmas.c
> >> @@ -677,6 +677,9 @@ static void palmas_i2c_remove(struct i2c_client *i2c)
> >>  	struct palmas *palmas = i2c_get_clientdata(i2c);
> >>  	int i;
> >>
> >> +	if (i2c->dev.of_node)
> >> +		devm_of_platform_depopulate(&i2c->dev);
> >
> >I think it would be nice to devm_* regmap_add_irq_chip() instead.
> >
> >If you also convert the auxiliary I2C clients and 'pm_power_off'
> >teardown to devm, you could drop palmas_i2c_remove() altogether.
> >
> >> +
> >>  	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
> >>
> >>  	for (i = 1; i < PALMAS_NUM_CLIENTS; i++) {
> >
> >-- 
> >Lee Jones
> >
> 
> The IRQ chip is registered before devm_of_platform_populate(). With
> devm_regmap_add_irq_chip(), the children would be removed while their
> IRQ mappings are still valid.
> 
> If the auxiliary I2C clients and the power-off handler use managed
> cleanup too, I think palmas_i2c_remove() can go away. Is that what you
> had in mind? If so, I'll send a v2 for palmas along those lines.

Yes, that sounds about right.

-- 
Lee Jones

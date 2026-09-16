Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F1456292;
	Wed, 16 Sep 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545314; cv=none; b=AgeLn7L0Y+jxgfMZMg7Vs9cp/1IcW/Sy3vZiJ1r0khZ/GU9GM/ooOh31pZ04vG946k+33/zugHp8Y7DvAzkbLjC1jnqJDL24rIRO3ixSceeWM/ber6KPp0TF1UJzXyqG1l2vXAEa6GPs+U1tM8wMz/RG1Kaq71IvKt2kjRoNSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545314; c=relaxed/simple;
	bh=1RzC7PqbfWrhbi+RkKBrrf22Vn14hRSQYCIwQxGdKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U47xXa9J4wJ7L8dhA+OwJ69GslRuyIgmd25V3qnsBU4KBTrXR6zR+cAtbudDsCUlLdEAh0CrZOU5KX35pEPmmg6kBCIjDK6WnYYS7NB980SvxKdZiAeqkOeoIvWZH2DEAEd+T/wQRydPiuCO53oOJeZ0aaCzA/Le0WogwHRHSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQXJc38X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQXJc38X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E231F00893;
	Wed, 16 Sep 2026 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545299;
	bh=2OgOP+jxXWQNRYRoolW60fTXYG8LulWcgv1fskPdr4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQXJc38XSm97lmRc3872XmOkSrrP4O7h/wvOdwT7rH0JjjxQW4cNAr9TTZwr74C0n
	 80EfU1uu+E+g+W+Bs0Q6W3kcEqYqXbXO2Ua9Ug27DvF4br/xVOMoYA7Ma5XZ9Fwuy9
	 PReFtdG7zkupeROqWNOMVKONS3zG7eUFtju86SKbnRaM54vTd6j956O4XxZudRzdXR
	 pyxGjlAU8sFIu/MCIfBmquaKqYekFAuF0/JSB70ySWn9YPVTKhcraaovyhwRXNSScL
	 IvhY69JsGl31fCnN1fbWy3JqFxF7kB670kqCp3y5fDneGSYN9R6mTmg4pxTrMoOMGC
	 q6e33yDcE3m1A==
Date: Wed, 16 Sep 2026 09:54:55 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Wolfram Sang <wsa@kernel.org>, 
	Ludovic Desroches <ludovic.desroches@atmel.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Yao Yuan <yao.yuan@freescale.com>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] i2c: fix DMA channel leaks on probe error and remove
Message-ID: <aqpLLgjoREHUkj5C@zenone.zhora.eu>
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>

Hi Shengzhuo,

> Shengzhuo Wei (3):
>       i2c: at91: release DMA channels on remove and probe error
>       i2c: imx: release DMA channels on probe error
>       i2c: qcom-geni: release DMA channels on probe error

pushed to i2c/i2c-fixes.

Thanks,
Andi

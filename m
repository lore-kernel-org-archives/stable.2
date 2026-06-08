Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A830675D
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924675; cv=none; b=jdJ/dcnCMZy92uUOn5yxznGWPU19slcMRGdtHomJCvZbwpOe2vCwezrPczke+eFzCiFVcIcCWDyjvkdlny4WC3l+DXStk3Akk/7d5cqnVLOqgMlUof1CiOLCCKNBH1qApAmF8Owjg+Aj/A3R32wpfnuGdfa3mhvU8/UxnybeVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924675; c=relaxed/simple;
	bh=557A4rslfuELDPas1rUlSRtz7XC3ubYCXfKrEJMIPQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=YFH1aNFkw+35UNhNuzO/Y2NkwvBnjx1NayshmjL9mxxf85uqtErOAJpIXG8//PczyG5efWhmDHMcSmjtclC8pQIqfz8Nq5X9wCiBjj2I60ohtoFn49tM6kwEI+JnTxUrXz1OVx52Gjerv1ri/i4gjni3xrLUkU8awzqWN6wNMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DaAOSI+g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DaAOSI+g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DBEF7C5147D;
	Mon,  8 Jun 2026 13:17:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3F135FFB7;
	Mon,  8 Jun 2026 13:17:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9FD6106A28B2;
	Mon,  8 Jun 2026 15:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780924671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pJlyIZJnB6mb5l3T1DHISpp+MXT5INLcjb7JHMUtO0g=;
	b=DaAOSI+g80z5cTwL/GBPQ9XJdZTtV1sZMoVO5UNLlYabQK9S89Xcda7wQbx6s0ZSGX4gZR
	CRUwLC9UB5NIlq2KtC8tbUPpmkiuvG8nSqufJb5aWBtJgFYD/wT6L+N2Co5On/k/01dupR
	eJNR+ZqLzg2C3Q6CwLi+LfXO+lv3mh4HpNiRCj2PUQlkcL2g+011aTAZ/QOxUvs8PTtBhL
	8gpYadJfsAQpr4icSs747vpt+Cr92f5RKJn2EBc7iuMPZWjN9ugp6Jc95qbzI5/CLJvGrC
	/+pES53rUebayKSFaM0q3PYngkLtnLqG33IkwNytdkcCmhG3w4gotpvMoilAjA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 15:17:49 +0200
Message-Id: <DJ3P3UDLPP2D.X4DC9XWSHPR7@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Srinivas Kandagatla" <srini@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com> <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com> <a13529db-a85a-4cee-9269-17c0f8fc9781@kernel.org>
In-Reply-To: <a13529db-a85a-4cee-9269-17c0f8fc9781@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue May 19, 2026 at 4:59 PM CEST, Srinivas Kandagatla wrote:
>
>> -static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct d=
evice_node *np)
>> +int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_n=
ode *np)
>
> Export this in this patch itself.
>

Sure, I will export this here.

>> +
>> +static int fixed_layout_add_cells(struct nvmem_layout *layout)
>> +{
>> +	struct device_node *np;
>> +
>> +	np =3D of_nvmem_layout_get_container(layout->nvmem);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	return nvmem_add_cells_from_dt(layout->nvmem, np);
>
> np is leaking here.
>

Right, thanks for catching this.

I'm going to send a v3 soon.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


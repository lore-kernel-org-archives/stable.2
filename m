Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688673;
	b=AJHiv1bwHh+z4F9or9ug156z4jBV+AmYePs+tfj3FGdHmJi5sVnyeVTT9nFnpqjmAXU+
	 L8p+xpIsKpxiJ65FF+fWOHfGYpz6c9fL52yBOAXT/cPheXD/1MY3yAGMDBIBDqYNKqMFD
	 9NywpXC2+sfg85R2ICUl/ZsPV99vVac34iQOCgFVSalJmsoJU1KknRASKviS3qkn30PBL
	 ZzAkawObCGd7/V7a7ZPf0gMG4W1INxoheDwdS/dGsGvA3qYDK+ev7BS+zjRHkSwo83tPv
	 BzWI/jiI11K75SwH/FdWXnOW38v4WSZCZaFl4J/0/TxP5NgZG83ZEN5Uc+I63w7Svgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688673;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=HWXhD2T0YqRDo710NdzVWCmw80S5rSuIE5qAwGglR9Q=;
	b=1xi0pwDI/fopyu999RUATueZGDO3UPlel6G49zlsoS2zHZxKc8QFJj3yjMWU7ldqKBTb
	 mAv2DiItUw2g2V24xR4+gKroZP7+5+Kh4W2IDb8j2cmhetQKcFxGoTWhY7FRDpmZv68gA
	 fU/RawRhqma93WzVI0ic+E7ChRnptGKbMAC6iR2zAKL8wHqOAS3y+qIjMYXKOv3YsM+nO
	 NE/yL68+JoXeBnvx9Fg80N2eb3LFeO7EgKOpz6w2Vkj1wHUTxGlOpsCR4VNARkkUb5IN1
	 cY8h5MuZ4KzJFNsts/u7bIyh/TMZ5FZwH9OFY0UmPh2g5uJunj+k8j9PStBSPltO3eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hT2tNv90;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F80606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hT2tNv90
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A14EC4E4179C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:24:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E7F660237;
	Thu, 26 Nov 2026 10:24:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA70211E6A5EC;
	Thu, 26 Nov 2026 11:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795688670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HWXhD2T0YqRDo710NdzVWCmw80S5rSuIE5qAwGglR9Q=;
	b=hT2tNv90ahKjUQOa2PA9w+ig6qobgxqJGnnsNUsMe71Jj8uMN8jI0+7woKeG0XQaba8s0o
	0rAl+v6dGXw4zWstY2by8epYPzTD5qX1FVC1uOwpzCXMj/WMNc3WlmvZm4NSX/XIvKuUtW
	hauygcBny7aVlM+8z562vmsGNdssOq23cbAQyamxzOAtiIyXLuk+9+I7R6nF3vyIXQa8I1
	ERBxzOI9xKVeJFR7U/5t3dHbdxa1y4cgcpbO2kj+tkIjnA5xEzjXeIDBLyZDweWd1yb5K2
	HW8RIJYF3jsf2v2aGJ1gp/H/bR9/4AKnOtOKsGIv1UbbIAaM9Qz2PXhe93g5Tw==
Message-ID: <0e983410-bc97-46cf-9ee0-c4cd11dcfa64@bootlin.com>
Date: Thu, 26 Nov 2026 11:24:28 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Congatec Board Controller: Add storage devices
 support
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261119190350.GB70182@joneslee-macbookpro.roam.internal>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261119190350.GB70182@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/19/26 8:03 PM, Lee Jones wrote:
> On Tue, 17 Nov 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> This is the 6th iteration. As discussed with Lee [1] I just picked his I2C
>> patch [2] (to handle the conflict) and rebased the series on top of
>> next-20261116.
>>
>> [1] https://lore.kernel.org/all/c9d26395-93f8-4e63-9cd0-586ce913931b@bootlin.com/
>> [2] https://lore.kernel.org/all/20261027093306.2812695-27-lee@kernel.org/
> 
> I assume this all needs to go in at once?
> 
> So we just need the I2C Acks, then I can take the set and send out a PR.

Hi Andi,

Could you have a look to the I2C patches, Lee is waiting your ack to
apply the series in his tree.

Best Regards,
Thomas

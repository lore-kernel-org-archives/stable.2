Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C994D2EFD;
	Tue, 21 Jul 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646035; cv=none; b=rjPuhDWtckdCC5wWtcD2gVTjMV93zSKDHk7taqGof/jHFnGzYrLUpymUEEUMI5d5zju9eYRdPaAfxa1fdMCK7jspkLx5mbFYiIXdFPm4u9t3MeDbZH498kl4C9BpMiMmmVeNwvPif/ClFKguOja5hIlqLIYYqbj+M69uHQc2Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646035; c=relaxed/simple;
	bh=r7Du9HZ27bfIxVqPqpKxTEoHSCoPvLr6EfHvvMk2hR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDA14kvhLy9WMTIGAl0KCHTUy6hu6268/SoWjHC3IhC4ySkdjOim9PyVvwkZVpblTLb1cEEitd55nkiIO2W4tZ66WPDIsVjsrIfBlBn42dvPq1kosBSuFspgmLNsJd55KIvnh9AeMiW9uKW1p4k2ZqkXKBrFy1BMr0+xsficzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vAd5uYYn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vAd5uYYn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 820C74E40EA7;
	Tue, 21 Jul 2026 15:00:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45D6060368;
	Tue, 21 Jul 2026 15:00:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E87A11BD3A6A;
	Tue, 21 Jul 2026 17:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784646030; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZrTWz7T4TSY0EU3YcniVMmn3w/BH84VOvJGYsjQQWDY=;
	b=vAd5uYYnqPZhJiEmePB33rsgDafjb2PLzq31tCqz6Tmf80u91CDGE31zXKw6cDMZmOrbFz
	6aB39dkOtqXBILxvbciuDuu2j+0aiZeMEUfeei8FiwC9cZbhayy8EH896jwGj5VqPfx2lX
	sm/pzfc7hnzLtmXpu1kyKvqOjorNuqjiH1+EtUf+HtniAhCi6fWR8SeFJvuFsAxHYZSlkv
	A95QKSjrxbQdVR7rSYgbIAr6zA35Gki1f9X602xte2uNUFXqoeXncaL0DVpbLy/96gTYtX
	bUZfq8GlPHTKiz12tuu2/hsTOQml01abVCbQwyUZFkVQ3p81ykjUkJc7KVjkPg==
Message-ID: <c666a262-579c-4e23-9172-c35fc9b3f3c5@bootlin.com>
Date: Tue, 21 Jul 2026 17:00:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
To: Jakub Kicinski <kuba@kernel.org>, Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260704214808.1566710-1-coiaprant@gmail.com>
 <20260720172433.77b83dc7@kernel.org>
 <7BA9366A-3243-4A46-BA8F-BB170C8AD912@gmail.com>
 <20260721064910.217a6af7@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260721064910.217a6af7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


>> 3. Should we add a .remove callback to force suspend the device on
>>    unbind? Otherwise the clock might remain enabled if the driver is
>>    removed while active.
> 
> Embedded experts would have to chime in on this one. AFAIK this is a bit
> of a gray area. Some users may want the link to stay up, eg to allow
> WoL or avoid link training, maybe?

Avoiding link flaps/training is mostly a concern at boot time if the
bootloader set everything up beforehand, but I'd say for unbinding,
this should be OK and would mirror the probe.

Maxime

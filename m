Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482783;
	b=laaSCvRRbmQG3SLkvM0wuj6RmO6Xf1HDL8W+9Dhx/8rzzR3eyLcH1Fi3JV+kPpyDVLdp
	 Og/lYW0kLP25J6FsOzLrSP+doxkAp/wVb9AebcADkckXQBKm9/nCk6nyIDTvK/V6wU9cK
	 hhCI4QDqchmMbeKcSXuRe9RkQKVyhZh4sk0h/gj0d3vSg6Qdq87unPsqSIts0Y3dx1Qg0
	 iYYCIyB6mTLxVeI+ZfIQefaX2pNwJqscLdQvZJUh300SLR54B02HMPq3Hee56pMxshkRG
	 mbdnG2MDFkCEg8iQmaZ+PtkzDYYcjRZ0qo879TZRANk3nAsGCYKmYOcev8whPuZVjnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482783;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=hi+RizexM700lJm+zJb+vjtDDdoQ9eNhKLCKMXQF8Cc=;
	b=zEhyPmZXKJqPeeq48InoKFpO/kOjIBuuTiORw17jVvZHqGeQnZ3on8b6Jdhj2dFksCQ9
	 F+cIbefng4QN7sU5Yfj4HX0YIt+BxOo/KaswTI4J7dO5A2Nxc4n7wrcWtOj+pQhFqJLA5
	 CLq9cu3Sz1zYyjMADmK0u6j8gt0VXNQHP7zDapYaBbWVhrarWGPYQvHc6S+/L6sPF9e8g
	 xtK9YPhNAo+nt2RIceCDqBJe7IqwF6eBkvBQ5Z4vFkAXojahb5moE9yv3VrSMt14Io+zH
	 7rmNmUGwtqnsaTWeYvKwRDQBbuj+iq+6Urtiy62G9EDMJy4fCFmg8OU4b1X0DWooPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y9eroWaR;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE0606A31B;
	Tue, 20 Oct 2026 07:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DE0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y9eroWaR
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB70FC5CD5F;
	Tue, 20 Oct 2026 07:53:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E4D460393;
	Tue, 20 Oct 2026 07:52:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 351CF10328D8B;
	Tue, 20 Oct 2026 09:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792482778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hi+RizexM700lJm+zJb+vjtDDdoQ9eNhKLCKMXQF8Cc=;
	b=y9eroWaRPITyTjrHPUIpCtTPYTC79pAmN2AmgzyvBdS1kRnW21+VrVlTLK8BMm4l8okMu+
	xH3nRyzR2BGLvPQdz4I2NdNL+ZMkfigJpysxQdhxErANk56ghzvZkVO75XuBb3apI0Z1VO
	tzIdlH4OFyB+0Ik3L3qRGe87m/SKpahFF/iyoI/XFakxkaAFwkv2ODQ7PvDOz9IRlcs/OI
	isk6wZjjj4v+LR2g5xlxVrY3ZDzVtGtAiXrFPpIrgI221e7u/2oA4F3x7wds0epUUUFfhN
	9yLeEC16MIIGBbTn2hc1/++Q8g8vvayyUDSXYj00hUUASHpBMzEXmU0P+E8Hbw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 09:52:54 +0200
Message-Id: <DM9I42KN8Y2M.1076TL8NU62GR@bootlin.com>
Subject: Re: [PATCH v4 1/6] watchdog: w83627hf_wdt: Fix watchdog identity
 truncation
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>, "kernel test
 robot" <lkp@intel.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com> <20261013-w83627hf_wdt-improvements-v4-1-b6f6b60a9566@bootlin.com> <atY1mMlBN1L93rbi@google.com>
In-Reply-To: <atY1mMlBN1L93rbi@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Oct 19, 2026 at 5:22 PM CEST, Tzung-Bi Shih wrote:
> On Tue, Oct 13, 2026 at 03:58:45PM +0200, Paul Louvel wrote:
>> The identity field in struct watchdog_info is only 32 bytes in size, but
>> the identity could be at most 33 bytes in this driver, resulting in
>> truncation.
>> Remove the "Watchdog" suffix, as this is implied that the device is a
>> watchdog if a user request his identity.
>>=20
>> Cc: <stable@vger.kernel.org>
>> Fixes: 3d6757a640f8 ("watchdog: w83627hf_wdt: Report the probed chip nam=
e via WDIOC_GETSUPPORT")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@=
intel.com/
>
> The patch doesn't really fix anything.  The longest string in `chip_name`
> with the " Watchdog" suffix is still under 32 bytes.

Indeed, max is 21.
No idea why it got reported in the first place also.

Best regards,
--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


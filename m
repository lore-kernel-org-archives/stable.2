Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAC49EC64;
	Fri, 25 Sep 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344709; cv=none; b=EHNp1lQ6itRVZYS6/QLG/stQDNWKYA5bNJTCbFysz9iCnqOgGgUCWO+QSbnL0L1GbhuUk3kvmHeysso2wotUCdRf+EJ0P7VjAVLcL6i+ouuMgJY1WdnhAFuYZxBEetl/vP6E8FmaBzY7q9rIHZJqF+VEG6kCgnr8IwqVpAnuWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344709; c=relaxed/simple;
	bh=PFgt+TG/ihd2roRcYykKI9ou6JPy7aTBjmHmdhLyrf0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=nqN0BtH4AuavmhHOT1iW9xiPNujgyb0yx88I6mnILPrzGoYqcMahnCiRboGB4CbLrPYr5VIPSXN0TvxKOS/3LUHpgptSzqGq+Cc1vCzVSvSgmTcGdORsulTSufHvzYJL8psrJUtL4rsncKkpLDr2vDks0k3zE2N8BzY2TG2eSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tiUFeFvO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tiUFeFvO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C21451A101A;
	Fri, 25 Sep 2026 13:58:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E5036073B;
	Fri, 25 Sep 2026 13:58:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43731103294E9;
	Fri, 25 Sep 2026 15:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fffo6XGiMMA0rNbqf1rQKp0NuWXeYHKojKv+7+WrZco=;
	b=tiUFeFvOdf2mZ9glDIjxu4AMif6I8m9GMxtgr1F+umOOhAkya25msf3n4UoDMBb2G93KAB
	WwpP2aoRodOC0eOQb0xLOll5K06MI4XBXKPVOyMJ4wB8dWcT3X/gGZJyOqHIRHK04dUg8I
	DC9E7Wm2u9HS4Oqc8ydvJjTySaEcxPy5zqIcFZdFrq6oOWPjJg/a6i9XV6BOlBd4/+3RqD
	IF/nq3EFz2PhY78HGRqVTTP/0bohq8EYPw7nMDxtEaT4pbynha78gElAiNos4WxM/fphy1
	hwhHuC6WDPmWBcDSZ09P16cwTkdjKmAWqW3pIlq7T8N/n13CMgcCmkFL2SWS8w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 15:58:16 +0200
Message-Id: <DLOG87E6TO4D.10IN5DZI777OL@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>, "sashiko"
 <sashiko@sashiko.dev>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net] net: macb: init workqueues before register_netdev()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com> <abd06220b7909c1feeb6b6100272c787@tipi-net.de>
In-Reply-To: <abd06220b7909c1feeb6b6100272c787@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Sep 25, 2026 at 3:42 PM CEST, Nicolai Buchwitz wrote:
> On 25.9.2026 15:15, Th=C3=A9o Lebrun wrote:
>> register_netdev() exposes the interface to userspace which might=20
>> trigger
>> operations like close on it. Those access the HRESP/LPI tasks and
>> might therefore use them uninitialised.
>>=20
>> Fix this race by initialising both `struct work_struct` before
>> register_netdev().
>>=20
>> Theoretical bugfix. The main reason for fix is to avoid future Sashiko
>> reports which triggers if we grow the race condition (by touching those
>> workqueues at open for example). The likeliness of this bug sounds
>> tiny, but I've not spent any time trying to reproduce it.
>>=20
>> Fixes: c5092ba3155e ("net: macb: Convert tasklet API to new bottom half=
=20
>> workqueue mechanism")
>
> IMHO the "bug" was introduced in 032dc41ba6e2? But this would generate=20
> more
> backporting without any real use. So let's keep it as is.

I used this command to find the introduction of hresp_err_bh_work and
didn't notice it was only a tasklet to workqueue conversion patch.
You are correct.

   git log --oneline -Shresp_err_bh_work drivers/net/ethernet/cadence/

> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


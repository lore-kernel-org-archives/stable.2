Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECAF489FC2;
	Mon, 21 Sep 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001408; cv=none; b=mtQNSdxY548fzMNCGZMAkCNbEqm6r872iasmAijlqVzXzw7TJyNuE4dYKHIPArjPvna15+10wktaGqaLiu4sft7gh8xhS5rYRwV5WlaaXxYE6ggLe79NARxY00PcKmxL1v9njDJkJfylGXcSBq7YiDl0mQ1/fm8+nI1xyO/GZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001408; c=relaxed/simple;
	bh=IC0ONy0ZA1jsH4EBCdgdHTxA8Dsas2tkWAhJ1oUchIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MHpnZ/jxpg0/E2fu5/Vr7wQ/5pXpoTvWwJZvAwhXZ3qJjfC2+aWVQtSSXG7UuDOPChf+j0hNtgloPNCBJUOA4r3sOtSlX08tEifdlEPGI9GYEDso2HKlbcAVKncs65VOSyipvTVfJGihMA4ccIp1/nCaDudwomWaQXAq+T/sT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O/2DsMr2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O/2DsMr2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5089F4E406E3;
	Mon, 21 Sep 2026 14:36:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22B575FFB2;
	Mon, 21 Sep 2026 14:36:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A83010328FB7;
	Mon, 21 Sep 2026 16:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790001400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kJtKbvFU1ir1qiLJZ2dhReiG4HYk81aRFWYDTAHwEBE=;
	b=O/2DsMr2lQM2rAhs89k0Lnb79hp2p08dWQaHRNFtBtJpIH2uYL+Xt0QmQXwARq1hi+Xjjf
	LYZttWv+A1wMx1mC/hfzO5H7XKGxcxCibqQSQW+GHErityxcYkpzox0uiXtp29ukuPj8KH
	AhZaD/gAsHhhtiyCQoIILlGDhlKqQ71SOC13O9K7WAfaUZVP8tTsLkN6/jE+ODK7gv7ufo
	+WmBORl4NMTcmbuoT89o2cU/2hwc5MVbPxd2nkIgl6Y1C4yhfxh8EEH5FqwhJSmF1NOWL/
	PdUDHqQ+A4zCvQQAep490XPwqSMKi6KwWRSqPKJZpI2dHGpw2vKR89SPcUW7jg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 16:36:34 +0200
Message-Id: <DLL2JCMFXCO0.313SCDHNUJ46Q@bootlin.com>
Subject: Re: [PATCH net] net: macb: take bp->lock around NCR
 read-modify-writes
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Antoine Tenart" <atenart@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
 <f695ad9aa88acb08727f442307dafe9c@tipi-net.de>
In-Reply-To: <f695ad9aa88acb08727f442307dafe9c@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Fri Sep 18, 2026 at 10:31 PM CEST, Nicolai Buchwitz wrote:
> On 18.9.2026 21:59, Th=C3=A9o Lebrun wrote:
>> NCR is read-modify-written from many contexts:
>>=20
>>  - macb_mac_link_down() clears RE|TE,
>>  - macb_mac_link_up() sets RE|TE|PTPUNI,
>>  - macb_hresp_error_task() clears then re-sets RE|TE,
>>  - macb_start_xmit() / macb_tx_restart() / macb_tx_error_task() set
>>    TSTART (already under bp->lock),
>>  - macb_interrupt() might toggle RE (also under bp->lock).
>>=20
>> The first three risk concurrent RMW with anyone from the list as they
>> don't grab bp->lock.
>
> There is a fourth, in at91ether_interrupt():
>
>       if (intstatus & MACB_BIT(RXUBR)) {
>               ctl =3D macb_readl(bp, NCR);
>               macb_writel(bp, NCR, ctl & ~MACB_BIT(RE));
>               wmb();
>               macb_writel(bp, NCR, ctl | MACB_BIT(RE));
>       }
>
> I guess you have skipped this as the emac variants using this are not=20
> SMP?

Actually I skipped over this at91ether one because at91ether functions
use zero locking. But as you point out, yes, RMWs are safe from
interrupt context on a non-SMP platform.

> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


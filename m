Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB39514769
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913988; cv=none; b=GgNzDOZt9oLyNCjS4eV/NoE67m23T9bEj1fwoFodXUhZIXpJM3V8gVcsdPwy9KiQhDwZWPY/YIwG5INgLBrXfJXRKemwd4PQ6qyOj8RxUF+PSdFpim9IuN+VYS9o4SWWn5arwfxYcm1WisPQgoZgs9on8xOX0iVXVcJyuXJX82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913988; c=relaxed/simple;
	bh=MF1HCO1uu1j6lxoCnZYJZ5VuSwxHd32R7hfkaz/yxVo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cOBx675CuTJqmDIUqlMjpkODJmjfYIKHbSqk6RKruSRxo+6Sd2FsUg8YNJ5gP/e3dYwJywEJndxEymfmpKZW8pgZSpGX0QMqWWurx55ML93X6sXvonXAVF5ko9hE25NYk82bo+2tQhUFvL9mvigRNaqW5U1NMA7Sp10We5rdvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X8w2xhjv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X8w2xhjv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3FDDF1A1217
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:53:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1330160362
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:53:02 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 67A4611D718A7; Tue, 13 Oct 2026 19:49:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D5+69p2VzXOIAfYCm/Asn9KvzPJEf02teLbj6NDuP5M=;
	b=X8w2xhjvGrVAbPzCaNqTFPaKuIdazVt59V44ns/k3CiOnyTVRikYfSW8A0qbVWUq1z5oZm
	ve7U9ICFZdj861hk6zNauWTQ276d3AvWtagLIBC+2gUdsbsrIfKNISkGvuWFWIlQkWGz2l
	VL0ufwUfn6/WtONn6/gdUgEREomCbZG83w6QgJudwDyKHF4q0c38G+Cs+7xZumLfEShLVV
	vepN34Te9z7yxoGXELVTVkSBbQszQwOaiaAIjSTCQkga98uvE0VykeJVDAKC7TPweOvNfY
	5Okvy4mW7lKeWWVpjZU3wvGoD0KjqoNkYfI7tsekkr0/0g2b7Ku/PSy20Tj7hw==
Authentication-Results: mail.galae.net;
	none
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:33:03 +0200
Message-Id: <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in
 the data path
Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff
 Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261007053211.572073-1-taozj888@163.com>
In-Reply-To: <20261007053211.572073-1-taozj888@163.com>
X-TUID: 609Wtw/Oe2JT
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 67A4611D718A7
X-Spamd-Result: default: False [-1.60 / 30.00];
	BAYES_HAM(-4.50)[97.52%];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[152];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	BCC(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[microchip.com:email,localhost:rdns,localhost:helo,garzik.org:email,atmel.com:email,bootlin.com:email,bootlin.com:mid,bootlin.com:url,lunn.ch:email,davemloft.net:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]

Hello taozj888,

I was reviewing your patch but you sent V4 at the same time!

On Wed Oct 7, 2026 at 7:32 AM CEST,  wrote:
> From: taozijin <taozj888@163.com>

We need full names in kernel patches, you have that in your
Signed-off-by.

> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
>
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...
>
> in gem_rx() by received a large number of packets without
> RX_EOF flag set, especially with unknown packet
> type that would penetrate the hardware offload for the IP packets.
>
> The unlimited prints here would greatly bother and delay
> the system booting process unless the source stop sending
> packets since they occupy the console output bandwidth and
> other processes have to wait for the completion of printing those
> messages.
>
> So rate limit the netdev error information print in the receive
> and transmit data path.
>
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org

What happened? This doesn't match your discussion with Nicolai.
https://lore.kernel.org/netdev/3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de=
/

TLDR, because those threads are a mess:
 - why drop start_xmit diff?
 - fix your patch autorship
 - check your changelog!
 - check your fixes!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:33:03 +0200
Message-Id: <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in
 the data path
Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff
 Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261007053211.572073-1-taozj888@163.com>
In-Reply-To: <20261007053211.572073-1-taozj888@163.com>
X-TUID: MurW8kMqMYNV

Hello taozj888,

I was reviewing your patch but you sent V4 at the same time!

On Wed Oct 7, 2026 at 7:32 AM CEST,  wrote:
> From: taozijin <taozj888@163.com>

We need full names in kernel patches, you have that in your
Signed-off-by.

> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
>
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...
>
> in gem_rx() by received a large number of packets without
> RX_EOF flag set, especially with unknown packet
> type that would penetrate the hardware offload for the IP packets.
>
> The unlimited prints here would greatly bother and delay
> the system booting process unless the source stop sending
> packets since they occupy the console output bandwidth and
> other processes have to wait for the completion of printing those
> messages.
>
> So rate limit the netdev error information print in the receive
> and transmit data path.
>
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org

What happened? This doesn't match your discussion with Nicolai.
https://lore.kernel.org/netdev/3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de=
/

TLDR, because those threads are a mess:
 - why drop start_xmit diff?
 - fix your patch autorship
 - check your changelog!
 - check your fixes!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


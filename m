Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32668388379;
	Sun,  4 Oct 2026 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118166; cv=none; b=FukerPlAH91Wf48OOrD+J2hxa7T73LXgSz1+GBnS3O2zP3dKccbjzyJeSijCjIFEEgvmlJeR4+S6vC9Yqrb9Kx/gxDayE8+PrsnEDEU7xednfvsakuYlVsGSj2eS7VYd0O4Ptc4mgRSNQnCpX/Tq1+I0ksAhNjEt/hMvLaQt6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118166; c=relaxed/simple;
	bh=mol2aMlgWpSO+Qo+MW6h6dw5A2JNlatnKsDk2DB11zI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=AzuT+VYaOaKx78zu8YcP+5wqStjTJfanM5EWcsESzW9VPekmGnXhHPrTiRf7GIQPK1OealfNcJMQkb8AL/9bTaaGpMd0m91IY1Zz7SDE8NKEguXkcseoBe6Wlthvc/ITyZgwNFT9/vmDR7R9x8/Eo65zT412sLI353n6f3wHKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A+Ob0GwR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A+Ob0GwR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7D1E11A1059;
	Sun,  4 Oct 2026 12:49:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F7E9604FE;
	Sun,  4 Oct 2026 12:49:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE5D21032817F;
	Sun,  4 Oct 2026 14:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791118161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mol2aMlgWpSO+Qo+MW6h6dw5A2JNlatnKsDk2DB11zI=;
	b=A+Ob0GwREiKa80YIWL2SCmKA7AsWfJXQccHWajBDj/vGDveF/5FHGEBKOVcDI5+n2+6k16
	RlNTsFC2dIR3VmwopA4qyWdKDN3CzWL4RKF07S7p3wE2VI2v83/mGW7rkHnASSBSGVRE5C
	bdZVdA1FhjJOORVPOEXYf/GNpFNki3K7UtSwbuaExauoOBRSKsRlvsjXcWkQniSjItvlqQ
	D+++3v7Og6dAuwe0DlOH/rkGBHimQik7Nb+0hDa9/pFfxvvqmMCWW4Y8ItKsPTLAz7b70u
	7QzmjmqncPPmcq4GL2gmNZ0Pp40LL6YGSj4NLLu5gKhnXRVGbWLGTgsviWZ7zw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Oct 2026 14:49:11 +0200
Message-Id: <DLW2E7JXT811.PKQ54Y98FZ88@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 1/7] net: macb: manage the netdev lifetime with
 devres
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Russell King" <linux@armlinux.org.uk>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Soren Brinkmann"
 <soren.brinkmann@xilinx.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "jiale yao" <19888972804@163.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261003085940.493951-1-yaojiale02@163.com>
 <20261003085940.493951-2-yaojiale02@163.com>
 <DLVX7ZLU4GOM.1WCL74N0U7PUP@bootlin.com>
 <178a0ccc.167b.1a106d6770f.Coremail.19888972804@163.com>
In-Reply-To: <178a0ccc.167b.1a106d6770f.Coremail.19888972804@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jiale,

On Sun Oct 4, 2026 at 2:14 PM CEST, jiale yao wrote:
> At 2026-10-04 16:45:58, "Th=C3=A9o Lebrun" <theo.lebrun@bootlin.com> wrot=
e:
>>Hello Jiale,
>>
>>Those LLM bugs are code churn, that's why you are seeing pushback.
>>Please don't ignore the pushback. For example on V2 you got asked to
>>reply to an automated message, which you didn't do.
>>
>>https://lore.kernel.org/netdev/20260927153020.5311dba6@kernel.org/

You've skipped over part of my message.

>>On Sat Oct 3, 2026 at 10:59 AM CEST, Jiale Yao wrote:
>>> macb_remove() frees the netdev while its managed IRQs are only
>>> released after the remove callback returns. An interrupt in that window
>>> can dereference the freed netdev or queue data.
>>
>>Please indicate how an interrupt could land in that window.
>>Thinking about it for a brief instant, I cannot think of one.
>
> I reproduced this on QEMU aarch64 virt + KASAN:
> I added a macb node via an extended device tree, with its interrupt
> line shared with virtio-rng. Keeping the rng busy triggers a steady
> stream of interrupts during unbind/rebind, and macb_interrupt() hits the
> window after `free_netdev()` on the first attempt.=20

But that never happens in the real world. We use shared interrupts
because we want to supports boards with a single interrupt lane for
all queues.

I've been thinking about removing the IRQF_SHARED flag recently, because
it tricks Sashiko (and you) into thinking that we might share our IRQ
lane with anything and anyone.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


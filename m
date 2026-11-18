Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998606;
	b=sQvtkkAYZUDvOoYbi89d1lmOBfPK9BFPa05MoumP5ncW6F5bGPiaJUBV0aUYXFZEXZEO
	 CVE0TqHmklK0peRwGQ0uawF4JzWyKc2Skdt3oAXnB7cSBzLHNIrssRUtgKB5TjtANGfc3
	 oX5cXN6nORUWXLV0RsZPnz7GcDIJkW95WrM8D9AlcdhUuy9d5PCT71jeoyUelVPkW+WT8
	 jTy4gUpfwTHT31VRGWROvKPBdT8teug0WK3ThvLW9KI2fRO7WiEvJcsHhD6RnNirSe6A9
	 +chr6eBPXqHnC8tn9Z92n+OO7RYfml8oLqpGmcJVB81WJeeKeBA3moYEwCMr1FUldWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998606;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=eF/hHeUma+QeQ6xbs3R+FZONvsSTm0QVHzw9pn5uvQw=;
	b=CiVVKzyiPuGndCClCBvhwGlpB6eWnAcHGLQjRDz0LXujRfY+LfIn0/OzdGdlUUDuwBiy
	 h/dr6zkt8bc8M5vSn4d6tYYfgPY9WN8XIOxm2aEEz1+fTPExaZJIrD2u2M+t3+gai5nSe
	 nPJ09LhG/F7wg2ZbDzuGS8YzbqHiA73rJcNiezKj5GbcIWfZAwcCWszp5V4yKGEXX/Vie
	 aQWnIialXXhl47Xs2ONLysgrIU7eQMXtmg9PcTXHWze7wq64kxOUB3VRFQuFRq0o6dpLv
	 MVlFVNBN0gYT+TOE5i7FzvgqsxOXysYbfdMJoYi0uIA+UDvk8VCgsgNuGKSGsULY6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=26nx9rUx;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F0606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=26nx9rUx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CA3354E41638;
	Wed, 18 Nov 2026 10:43:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96F505FE9B;
	Wed, 18 Nov 2026 10:43:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 925C311BC1151;
	Wed, 18 Nov 2026 11:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794998603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eF/hHeUma+QeQ6xbs3R+FZONvsSTm0QVHzw9pn5uvQw=;
	b=26nx9rUx2LQCLUilaAtaApd65Ga2TYSQykwfxHXpjXSCMUMYhiQ9uhVLWhb34hEA1Opxg2
	WLB2EndQZK7jjl7YD2/cxqpKTuoxCMJOc7EsNDQ2V991v6EDlGM1RYrRKfxZCQg7oReOh/
	wz1NDbL0oIYHnblJhDiZOEHWj73kyLiz8QMOQWoC9WdkEV+5Muk80u4t17SY0IWXIqCDm+
	X/sG4OGmC8ANHW1Rf0BWO16wP52RCPy+QW76nvHD8JVyQig8m9YUCr5eGWcSJsqkD4Mr4S
	pXl46hpFQOEGYNBINX9BXBcvjHnZ3aSPIoxuTAEty7rleyyvkE3PACIcZte3IQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Boris Brezillon <bbrezillon@kernel.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: core: skip empty read and write requests
In-Reply-To: <20261104-submit-mtd-empty-io-v1-v1-1-3f6bcf474e2a@gmail.com>
	(James Hilliard's message of "Wed, 04 Nov 2026 22:03:38 -0700")
References: <20261104-submit-mtd-empty-io-v1-v1-1-3f6bcf474e2a@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 11:43:19 +0100
Message-ID: <87y0aqifnc.fsf@bootlin.com>
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
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 04/11/2026 at 22:03:38 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> Converting mtd_read() and mtd_write() to wrappers around the OOB helpers
> removed their zero-length checks. Neither mtd_read_oob() nor
> mtd_write_oob() stops an empty request from reaching the driver.
>

Yes

> For example, the raw NAND read paths select a target and can read a page
> or its OOB area before checking the remaining length. An empty request
> at the end of the device can therefore select a target past the last
> available one.

No, there is a guard against that.

An empty request at the end of the device can therefore compute a die
index past the last available one and hit the WARN_ON() in
nand_select_target().

> Return success from the common helpers when both lengths are zero,

Ok

> after mtd_check_oob_ops() has normalized lengths for absent buffers.

This is opaque to me, just drop.

> Keep the existing range, write-protection and operation-support checks,
> and clear the per-request read statistics before returning. Both return
> lengths have already been initialized to zero.
>
> Fixes: 2431c4f5b46c ("mtd: Implement mtd_{read,write}() as wrappers aroun=
d mtd_{read,write}_oob()")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/sashiko-outbox-198544@kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Thanks,
Miqu=C3=A8l

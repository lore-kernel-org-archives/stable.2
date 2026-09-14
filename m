Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6D46EC95;
	Mon, 14 Sep 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391489; cv=none; b=Jl7MAmVwOsspdjwLRoXDnyv+T1Hn17h6y4SLNQszdX3hN19hk+hoEhCt3qVeSLf+xITpTkaS/RrPSpcSllTvAHnVsQrT1HkwBd0RTHxgB642b/WPz6XvBJjuP3B+hLN9eMxn1CQITdyRN6xQOY0z5xYonyxGBe4Hag1gG1/G2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391489; c=relaxed/simple;
	bh=Gzh8Pe7W5FCqY2ngsH9A6ti9ZfeyNM/ZirG41dCIBog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0l9HjgQPdmU59BRluVvkCYTLJHAqRLPY/pviLyTGDVg0Raou3A3M2ZTlRvqBaFUCqm7DYRJ9bbvi46CaKkRxNST2RyIW3PX4VG1t9HBa2RP6vPlc2GXXjt/b4svy3INv35ZdpwbQzo3Blo72jWQPGR/j1O1fIo+cAaZScMTags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YpWGMQ6U; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YpWGMQ6U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE681C6220A;
	Mon, 14 Sep 2026 13:12:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF7AD60323;
	Mon, 14 Sep 2026 13:11:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED17311C7AFE0;
	Mon, 14 Sep 2026 15:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789391479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mZXhJAtzmuuuXlU9rBzQtuSa9QmpjCsIQYhnKWG9j90=;
	b=YpWGMQ6UbZG5fkZvLP4ZkOZw3aBPbmCdSLK74588bMJm+9FInTvn7SEvOSN8H+nsz6rQbI
	oUC/F2jMcEwEeZe3JMI85jS/009Col9icdoJy2bAMWU2geSfn0QJMTB9PChj558JxgOd9k
	es/39YrHisuiZYcoquXzHVN2+K2rl4p+E+52o8go0fle7lmSo3rouo62Sr6dENSWgu+hdQ
	+rW/l2zAcYd4egtxTvj6sRdA1R4oWVNm8JpqQ0Uv91jC2zwKom4bPZxAHKK0mFQW4MLyxD
	1zW8u6rchhxX8XMKlOtw4H5mfRyc3o/r5i6VlLJkQgzI9Leyjfw/LFNVKavq6w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Itai Handler" <itai.handler@gmail.com>,  <pratyush@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <vigneshr@ti.com>,  <richard@nod.at>,  <takahiro.kuwano@infineon.com>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
In-Reply-To: <DLF1P95EJSHN.37NQ86W91QPUU@kernel.org> (Michael Walle's message
	of "Mon, 14 Sep 2026 14:41:16 +0200")
References: <20260914081149.1916589-1-itai.handler@gmail.com>
	<20260914081149.1916589-2-itai.handler@gmail.com>
	<87ld94owzj.fsf@bootlin.com> <DLF191CC4QMM.1SNYEHUFJ9GK2@kernel.org>
	<874ifsovtz.fsf@bootlin.com> <DLF1P95EJSHN.37NQ86W91QPUU@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 14 Sep 2026 15:11:14 +0200
Message-ID: <87tsnsnfkd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/09/2026 at 14:41:16 +02, "Michael Walle" <mwalle@kernel.org> wrote:

> On Mon Sep 14, 2026 at 2:34 PM CEST, Miquel Raynal wrote:
>> On 14/09/2026 at 14:20:05 +02, "Michael Walle" <mwalle@kernel.org> wrote:
>>
>>>> Michael, since we already got a cycle with AI walls of text just to te=
ll
>>>> "fix that damn conversion", can I (or you) apply that other patch, so =
we
>>>> can get rid of these? Let me know what you prefer, although I don't
>>>> remember where that thread is.
>>>
>>> It's already in spi-nor/next since last friday.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=3D=
spi-nor/next
>>> https://lore.kernel.org/linux-mtd/178913311701.1915651.4791624215787396=
187.b4-ty@b4/T/#me3b51a242469a4d9722089e18547e87fdc65d7c9
>>>
>>> -michael
>>
>> Since that one is "big" I would have merged it through a fixes PR. I
>
> A big one nobody cared until the rise of AI agents actively searching
> for it? :)

I used quotes ;) But yeah it is big in the sense that it is an obvious
breakage and we are going to get  more people proposing a fix for it.

I usually do a single Fixes PR per cycle, and what comes next is carried
through the main changes PR during the merge window. I will tag and send
the fixes PR in a few days.

Miqu=C3=A8l

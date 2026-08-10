Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A793D669B;
	Mon, 10 Aug 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366082; cv=none; b=d4QgCvQR274SGciseXmyW3e+Dw/upcyadLbtzGgwTiXnH5kqEJbdKay6KoOEOCl9uIMTjVQBoaKeApBV4isb7pnMIgF2VArXHrGDMSYQyZNYWbH8hkGp+Cnnmt0A+4elNUMOOYf+SkWusGPr3HU69xwmN9M9TBRuE42mYstVI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366082; c=relaxed/simple;
	bh=udAMHzRtyQaOkwLerVor+ncwwjh/ZWCrpPKCMkWf7fE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i857L5mw6npHpbjfhexI63/JweSOFUCfXrcSGhMpBYIrReUCUn24y+6wexrvjesbCtZXclqgwX1DxBYErb7keKoAQlVWYlIxatHk/NCMs084zM0YvbEeIKrT8npibcbNm+TaQWSIaF7eaXoRzHDP0PlrHv+Yj/AVtHgYQL9nmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aJhc4sly; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aJhc4sly"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C39584E411A2;
	Mon, 10 Aug 2026 12:47:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 960916033B;
	Mon, 10 Aug 2026 12:47:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B6A411C4A56B;
	Mon, 10 Aug 2026 14:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786366078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=udAMHzRtyQaOkwLerVor+ncwwjh/ZWCrpPKCMkWf7fE=;
	b=aJhc4slyOKzqCwyPlKrJ5bTf2deEFDIXqXSEDmcv+8Wf3qyU9mq5u5IE6fLV/3Fxbcz79g
	3BhpgUiuKfpD/LICkrGYC4pZGvStD469hF+JbSp0A++QFuFsTV2oDJJcSBG2z7XxBkmH2P
	fH7kk43gkWIL0LsHR4uGTTjVymeJB/lvfd/feGtAGYRatoEYnE2fzjaGtn3Xi1ODTNhQII
	KWxn0SRwY78mW8ayZ7R7lMEJe8Y3yy+kGThWcE43L5PkN6cVrlvnTqXD5p0Oh8A8j32uK3
	rV5e9KTiwJ2629AYQQ7FItj3nc4D7sGmoQde/+B74f9Fi3nK9rQc7qsDtJc9eA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Runyu Xiao" <runyu.xiao@seu.edu.cn>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <jianhao.xu@seu.edu.cn>,  <stable@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
In-Reply-To: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org> (Michael Walle's message
	of "Mon, 10 Aug 2026 10:25:28 +0200")
References: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
	<DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 10 Aug 2026 14:47:50 +0200
Message-ID: <87h5l2qgzt.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 10/08/2026 at 10:25:28 +02, "Michael Walle" <mwalle@kernel.org> wrote:

> On Sun Aug 9, 2026 at 10:42 AM CEST, Runyu Xiao wrote:
>> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
>> condition. The raw mutex_lock() leaves nor->lock held when the busy
>> condition returns false, so the waiter can block the active operation th=
at
>> must clear the RWW state.
>>
>> Use the same scoped mutex guard as the other RWW start helpers so the
>> mutex is released on both the busy and successful condition paths. The
>> state flags remain the handoff to the caller, while
>> spi_nor_rww_end_exclusive() continues
>> to acquire the mutex when clearing them.
>>
>> The change was checked by comparing the original and patched source.
>
> What do you mean? Was this AI assisted?
>
>> A source-level check of the original wait condition found that it takes
>> `nor->lock` and returns false while an RWW operation is still active. The
>> patched source was checked for a scoped mutex guard that releases
>> `nor->lock` before the wait condition returns. A user-space pthread model
>> held `nor->lock` on the false-condition path and showed that the
>> operation-ending path then blocks when it needs the same mutex. No live
>> SPI-NOR test was run.
>
> What do you mean by "user-space pthread model"? Ported this into
> user-space and tried it there? Please keep the commit message
> precise and don't use any AI gibberish. Please, explain what's going
> on with your own sentences. That way, it shows at least some
> understanding what you are trying to change here.
>
> That being said, there is something odd about that commit. Tudor, do
> you know why you've omitted the guard() in
> spi_nor_rww_start_exclusive()?

I agree with Michael, the fix looks legitimate, however the commit log
is unreadable and should be a 3-line straightforward paragraph.

Thanks,
Miqu=C3=A8l

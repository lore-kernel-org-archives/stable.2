Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E6442B0B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387793; cv=none; b=iwZiTQEieJBd8zJOf90y+eI4UZSAywkszcDFGJ9ZAqDQrKyVds8W55LU64ocvkRCLnr6TLXg87IWw1loVaigcoRdhizS2ng1jwCUpqgNIGDpzJbGt/+CfirHNUtQPnBgqoOmI9RNpu1N1mfHZEarLbM61qrFUMqir5um9dTAWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387793; c=relaxed/simple;
	bh=DIFbZRJbfGdhKYVNBWgps2T9SIYINBUqv550FvJbPnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0JW2xdjhfwXvF9yBk89LgMGF2Ht/rh2I06tL4CEoTpJytXMRBPtZD9N7ZKzBy4XZpsc/5LV3uMOQ19OzHPLbwLvmdZyQjzLt1bzp60t/po0E13tVvvRBpTTUSA3WLsFRdH9tce9ua94sdWrYW8GABE1ahmG/qd/5Ml+sTZ4WTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qanpWb6b; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qanpWb6b"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D9D1A4E4059C;
	Mon, 14 Sep 2026 12:09:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD8AA60323;
	Mon, 14 Sep 2026 12:09:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00C7E11C7AFEA;
	Mon, 14 Sep 2026 14:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789387787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=imnBdl+Y6imr4XHv64a6LJ2Rk4vo6DK7imSA+6oOEmY=;
	b=qanpWb6bTANqCQiqendoxvJEOtm+FThRWr7Wufa6tx8owz2Ve3ibimrT5eyKlS4BjM+XzV
	MyCgowQ3UhWagZCsZj360UTbNMLCze4f2xZaUBLu/HERDJwK+8YLuqUeDQp9I+Bsh7tH3S
	HHJ6YjV0nZNPf4LU8OKZJpqdmFL268SOSwg61jNaOWnteRz0rc2jvyEsl+jxEZfEAxz/Ie
	mJlmpt0wO4aDtlRslaTupTYvbKjSSWqmp4Z026T2sx1iDVlwQksO8ulsX92osfEirbOIP0
	F1zV6r8laK0HKPJxQ2cw0H4b2kIZjYfl6Vdl31JrDcHRJsN7oeH+590KDdfiRg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Itai Handler <itai.handler@gmail.com>
Cc: mwalle@kernel.org,  pratyush@kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  vigneshr@ti.com,  richard@nod.at,
  takahiro.kuwano@infineon.com,  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
In-Reply-To: <20260914081149.1916589-2-itai.handler@gmail.com> (Itai Handler's
	message of "Mon, 14 Sep 2026 11:11:47 +0300")
References: <20260914081149.1916589-1-itai.handler@gmail.com>
	<20260914081149.1916589-2-itai.handler@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 14 Sep 2026 14:09:36 +0200
Message-ID: <87ld94owzj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/09/2026 at 11:11:47 +03, Itai Handler <itai.handler@gmail.com> wrote:

> spi_nor_rww_start_exclusive() takes nor->lock and never drops it. It
> returns with the mutex held whether it hands out the exclusive claim or
> reports the flash busy, leaving the caller holding a lock it does not
> know it has.
>
> Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
> helpers") turned its "goto busy" into a plain "return false" and deleted
> the busy: label that did the mutex_unlock(), but kept the mutex_lock()
> at the top instead of replacing it with guard(mutex). It is now the only
> one of the ten spi_nor_rww_{start,end}_* helpers that does not use the
> guard.
>
> Its only caller is spi_nor_prep_and_lock(), so on a flash with
> SNOR_F_RWW set:
>
>  - if the flash is idle it returns true with nor->lock held, and the
>    matching spi_nor_unlock_and_unprep() calls
>    spi_nor_rww_end_exclusive(), whose guard(mutex)(&nor->lock) then
>    deadlocks on the non-recursive mutex;
>
>  - if the flash is busy it returns false with nor->lock held, and
>    wait_event_killable() sleeps holding it, so the operation that would
>    clear ongoing_* can never take the lock to do so.
>
> Nothing reaches this today: the only flash with SPI_NOR_RWW is the
> MX25UW51245G, which has neither OTP nor locking ops, so none of the
> existing spi_nor_prep_and_lock() callers in otp.c, swp.c and sst.c apply
> to it. It becomes reachable as soon as any common path takes the
> exclusive lock.
>
> Use guard(mutex) as the other helpers do.
>
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Itai Handler <itai.handler@gmail.com>

Michael, since we already got a cycle with AI walls of text just to tell
"fix that damn conversion", can I (or you) apply that other patch, so we
can get rid of these? Let me know what you prefer, although I don't
remember where that thread is.

Miqu=C3=A8l

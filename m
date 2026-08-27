Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF723B63E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819601; cv=none; b=iiKBkQfG6Fw3IFFf6KO+ev2Ia48uu7lyBUjUpM47JItFsX/p41KHe0VpkHk//FvDnWdMsdezy8hGLKsbgzLJFl5vIU9CcDy7rFim5bJ8rWRMS+s3/fkYT37YylLmkIkHp1I8fpN0lflIAK1S+TyHeIZbcaqgam+ccdnV0er3gQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819601; c=relaxed/simple;
	bh=MXcYU0wpdxigUdN91eobDqnjz/40R6iSKgJHLhVwIdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibLpUz5OQxu7wO2EkXmnw2X+YTGE1VSOyoqFKS38KXFlj7YJsEWwz4k50wjCSwtexnWiN4S/+5c1lWuD8D9nIk/J+s3OnmueuHxhDXkA8mDd0q+vgWaQP561PKoS3kRWmh1FanprMp7ZSX2SHiGRN9xRVyMLgXNlimVU0JHkw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BDFAZGrB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BDFAZGrB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3E1951A1849;
	Thu, 27 Aug 2026 08:33:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10273602B8;
	Thu, 27 Aug 2026 08:33:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE5B111C783F8;
	Thu, 27 Aug 2026 10:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787819587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MXcYU0wpdxigUdN91eobDqnjz/40R6iSKgJHLhVwIdQ=;
	b=BDFAZGrBnc9OcX8stWh9bwubCZ56sqUXoivFmTfpmjZhlbZqWZwfETMzz7ge4To9Np0x1H
	Lb0yLVUQ3r87bdcbEq0bPc6t4SiO6aGh8pqM4Q/RQ4Ug1e6GnCUFxkPKNL0a9aavJU0Pwk
	khI1c9118GZG4hBU54JkCL6yTBsnMDorIYywjd5+XPG1L8OXm4qeCmOpg2xRaonarPieKQ
	CXqibtoCNgmGWsrGXAD+M+AHRfRX1ukEaJzCmHbuECUO+hO/YcQqiTOtYa2A4F6xlcddDq
	LSoHgN6+LAxGGAlvD4A3Dk6w8Q6dgkgBOUK6Rlx1LSmoo1B2yzVQmM1AbxX8UQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v5] mtd: spi-nor: core: Fix mutex leak in
 spi_nor_rww_start_exclusive()
In-Reply-To: <20260827082656.2772784-1-runyu.xiao@seu.edu.cn> (Runyu Xiao's
	message of "Thu, 27 Aug 2026 16:26:56 +0800")
References: <87tsoigz8x.fsf@bootlin.com>
	<20260827082656.2772784-1-runyu.xiao@seu.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 27 Aug 2026 10:33:03 +0200
Message-ID: <87jypcdku8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/08/2026 at 16:26:56 +08, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. When an RWW operation is already in progress, it returns
> false while still holding nor->lock. The wait condition is then retried,
> but spi_nor_rww_end_exclusive() needs the same lock to clear the RWW
> state, so the wait can deadlock.

This paragraph is a bit irrelevant, we don't really care about the
feature itself: there was a conversion to scoped mutexes, this
conversion missed one place, you fix it. That is the justification, but
fine, let's stop iterating on such a trivial fix.

> Use the same guard(mutex) pattern as the other RWW helpers so nor->lock
> is released on both the busy and successful return paths.
>
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Didn't I send a Reviewed-by tag already?

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l

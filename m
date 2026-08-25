Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E003DB313;
	Tue, 25 Aug 2026 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660313; cv=none; b=q/WX7mONAc6JcwpToB+jrYyCuJE5T7hyVzMTJ5kFsSL9pSiTvY/yrjgUWNFhVwmW24r43aw1MyfJiJEZU6mD1rnNT+dKJh2YQyZ62j3hALgknOSNYzm9RdSDysx3RuGdaDx0elfn1FpSZssYP1ES6Bd4iWReiF2IP5f/Q+Qa3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660313; c=relaxed/simple;
	bh=8o1oXJrqZncv1dN01fPRKLnSnmcXHT6RXTZDKgnyQhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FUYkpDoNyOPA35E6Jm0u5KDWY5PdBPf5TPIrES3n+7whlBmqOL60qFyvvTtHpog5Oy0jR14VU2i+OF24OCeushIsar1MZ9R3ipJyqneXz4mbkmjtXs1vOsxxfw1nePbxgPd5HMqUewmowEqtIjXy/l6ZAa0wICkT31IZjJhUtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xSl2fH+U; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xSl2fH+U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 26B8C4E412E9;
	Tue, 25 Aug 2026 12:18:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE895604C4;
	Tue, 25 Aug 2026 12:18:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E826711C792C9;
	Tue, 25 Aug 2026 14:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787660308; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8o1oXJrqZncv1dN01fPRKLnSnmcXHT6RXTZDKgnyQhI=;
	b=xSl2fH+UrxAw5b3PgX/eBormBKdhWxMtBm3ZZWaBiNDZlPvZo2gf+ySuMG9sRueramrQox
	zq/CHoceB4v8tIKG2BBNtCFGtFKL1HesmsDXA3Xffmrr3nmxXNVN64hBYYddacEd0VE2Yd
	9Lfl2eAym8MYp4atUhP6NrzWx7tte6HYuarTUmTKUgN7vMC6cfjTJTblOaVHtO7lhn2wRk
	2xlR8up9z1GLj/l3LwR72kPh7hHDAiUoIFfKhXjiAgVHzesXyVEPfTb9l2rG5OzP19gBdb
	pDq/WEa7Gj4GuOlhu9C72kegle8jYoUcHykx39ZrE7SPf+ql2t02fr+9Y88CYA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: core: Unprepare after interrupted
 RWW wait
In-Reply-To: <20260819140337.36775-3-runyu.xiao@seu.edu.cn> (Runyu Xiao's
	message of "Wed, 19 Aug 2026 22:03:37 +0800")
References: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
	<20260819140337.36775-1-runyu.xiao@seu.edu.cn>
	<20260819140337.36775-3-runyu.xiao@seu.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 14:18:19 +0200
Message-ID: <87zeyagzqs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Runyu,

On 19/08/2026 at 22:03:37 +08, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> spi_nor_prep_and_lock() calls spi_nor_prep() before waiting. If the wait
> is interrupted, the controller setup is left active.
>
> Call spi_nor_unprep() before returning an error from each helper.
>
> Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads whil=
e writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> Changes in v4:
> - Add the cleanup for interrupted RWW waits as a separate patch.
> - Use the original RWW locking commit in Fixes.

There is already a pending patch for that part:

https://lore.kernel.org/linux-mtd/87o6f7mzbq.fsf@bootlin.com/T/#m69e389f70e=
b3e34c0573bf289cb050825f14b516

Thanks,
Miqu=C3=A8l

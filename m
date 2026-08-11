Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E93B14AC;
	Tue, 11 Aug 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462716; cv=none; b=hWzNV3JNciSNyPcxQnTn88p373fXHE1ekM229TRPj2ZLlarSEWqwDIrl4mcg629h27Jnf5DoeGNkDuOBzepWlzpAP9BxVGzynbfbaXTmlKlQTqcbP/DdXnyOjq7FlWhQUoghDAGXXMhksMeJRkI7PhjjST3baDeSFik9AmwJ2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462716; c=relaxed/simple;
	bh=IOFG+qVscDGAjpgzS9lVJ5+X+UGjYnG8+VuAnr3J00k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNolZD1ey+uXiQ2kfPXBdWR4OfCfCOo4qTrcOQGTohNYsL8Z1ma/rTFr8m7ziSwkHRUdH0uKjEikNRwdtx/5i5kwkum8Y5daPfic3qz7QHTAGtrJKicy/vJWy7Qu2Rv0/kAhOG4bCKxb0NWQitvEWUd3GrWSu6jL4dyUpp3ocRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2qOcNcj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2qOcNcj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EDB5A4E411BA;
	Tue, 11 Aug 2026 15:38:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B83826033C;
	Tue, 11 Aug 2026 15:38:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E331211C48EB9;
	Tue, 11 Aug 2026 17:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786462704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IOFG+qVscDGAjpgzS9lVJ5+X+UGjYnG8+VuAnr3J00k=;
	b=F2qOcNcjP2jUpRcKlJ+MbJohWrSNOLsCjX95aWjjHWKwV7+ncqFqK/giuool1RXPr2Vjrn
	2+9sC1b+IV8A1sambYaOLoo9H3nEW1zyCY8jhu5VXZZEIUe3AVihVO+ZKubvIk58bBIgbl
	yQEZSEeRFR7aM8uv3cMMnVi5ddWJpKvkGqBCMT9E9o6IzPcVTqwF8JS4cOrZNd8I3dT5Fx
	u5xewfug217dMafMifypF4AS+DWGAWH05aFAq4c0762EFJJEa7Q2ty1DJdbJj1cF6tHVr8
	JlWjKPP4JnVbXQ041TWzkpL1CeuKR/7TB8i+yyIEob+L08ZvjyJh7rUImkVhlQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
In-Reply-To: <87jypwoha6.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 11
	Aug 2026 16:36:49 +0200")
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
	<20260811083111.403453-1-runyu.xiao@seu.edu.cn>
	<0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
	<56991b48-cbe9-45bf-a24c-d7aa771c55d2@linaro.org>
	<87jypwoha6.fsf@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 17:38:19 +0200
Message-ID: <878q6coefo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> Have you seen sashiko's review at=20
>> https://sashiko.dev/#/patchset/20260811083111.403453-1-runyu.xiao%40seu.=
edu.cn?
>>
>> Both concerns look valid to me. Do you think you can allocate time to
>> fix them?
>
> Sashiko is becoming a nightmare. I'll add this to my todo list, but if
> someone in lack of technical challenge wants to propose fixes, be my
> guest.

Actually, the might_sleep() warning seems to be an hallucination. It
mixes different concepts in its explanation (might_sleep() is not a
problem here, we are in process context) and I believe it got mislead by
the current state of the code which lacks a mutex_unlock(). The second
issue is definitely not "high" and only touches legacy
spi-nor-controllers. This is worth fixing though.

Thanks,
Miqu=C3=A8l

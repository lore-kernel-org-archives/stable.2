Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091854;
	b=tGQk2FQLx/P07YcDUQVl0n9TNDdGhQKSf+Lhnv65EiG/zaZk3WOys5BTSksN/Vl3SBPk
	 vClbdvERnNggfMYPnLutH0zJbzv1K/fAmoBvaA5XbC/FquWr5HaihHb5NxOKxVdC1bJ9K
	 e7U7xcyAlGvALi6oimPrHcPbTwEyEYlAArUsGG3fvh2jgqgJ4yqKWu/xbYg5IH9SXxjNm
	 FhJRFThPvLdoeYd2m858b/PjwmfAZVDI9I02/rvHYuN06NQkjbBEGtxgn/AmoKZEGJE2e
	 kr/NpoxofmSFSEu4xPSJrLgvLvCpIjfq69L6ZbAvzDSIYRoz56TwLJk1al+nPQoj9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091854;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=PxwBCxacHoYLPSc7fd8YHXq1TexJePfZYiAdbugkj4g=;
	b=n4oLsPeICW6uSTZ8vRa89wYU8LTvnJF/tsznVYzmXRUPZFIVzUYCL51bzejH4II+rSUg
	 qnEOay3eVTBITjfuOA5ZivzZsECyuK0sEZMJaUjoTHMbxD4PsqllVO30V3z5aV5qu/tj/
	 RMo3dQJ1jqVMi/bR2yRc1yX3vQ7pquD00RMH1c37d2VJIAEHElrw9TmulcVErK6aOx/in
	 W3JAwtWPL+SSdOol9clhgl/stTGK+TNm1B4pxs53eg95QZ0XL6Wp/j0ikR/+D3Ug5eNlt
	 6sUgbbihaTIFLDzqL+NrL9xb/wqp2EZ81MrWOga49iFW2NZkIx9RKWeIDZSTWxlQW4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="G/UfFKVi";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67B60A261C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B67B60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=G/UfFKVi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3CF891A1711;
	Thu, 19 Nov 2026 12:37:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C17560237;
	Thu, 19 Nov 2026 12:37:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08EC011BC05F4;
	Thu, 19 Nov 2026 13:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795091852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PxwBCxacHoYLPSc7fd8YHXq1TexJePfZYiAdbugkj4g=;
	b=G/UfFKViB2rK492W2eHR9G7tStdBG6h3B+KtXktZjpis/AVce/0PMcbxPAxQpSgXBB74Qc
	NIU18loFLDCq2UODCN+HPrT01JyZtN9T9y//eoWhD6n0/ZU3F6sUfe6+yV6iIf4iWR2xxn
	jf5x1zyQVDrfTG/8Xxi2JLtsNSUsXlaI13pRloYRjVRWTAXsLEs+OtownJS8FaghAHbLoH
	bw69FUe/efosxTc0DSXo87R98OuGXAJrPmw0u6bFHmn6ReZzvsjNnk2H6tvsQf5Bo9VpPN
	Y5AYEE3597t7/xxoyH+ontFDWzqXxAj8DpFLrn+jHMaNcn1P45T0qDixzi8AYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261119-spinand-cleanup-ecc-engine-v1-1-60d007d2ddd8@gmail.com>
References: <20261119-spinand-cleanup-ecc-engine-v1-1-60d007d2ddd8@gmail.com>
Subject: Re: [PATCH] mtd: spinand: cleanup ECC engine when
 spinand_randomizer_init() fails
Message-Id: <179509185092.2889394.6227945736733720640.b4-ty@bootlin.com>
Date: Thu, 19 Nov 2026 13:37:30 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 19 Nov 2026 09:14:46 +0100, Gabor Juhos wrote:
> When the spinand_randomizer_init() fails, the code jumps to the
> 'err_cleanup_nanddev' label and the code leaves the ECC engine
> initialized.
> 
> Change the respective goto statement to use the correct label which
> ensures that the ECC engine gets cleaned up correctly.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: spinand: cleanup ECC engine when spinand_randomizer_init() fails
      commit: 8af49d43433c305e0fa773ea705eeb7d08b6ceb6

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


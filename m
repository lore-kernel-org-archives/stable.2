Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22763513571
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543514; cv=none; b=n19XTanpMlbnkJVRlkIvuW3l2d1DLZhcSU90i89ZyfjlZ/SFD30kcJgeXS1pTvg9ifqXf3hlsZDIZinSoviUUlh/JH438NModVic59eTY3eceIqNNU5ZH85nWUlL4vdX/36BIhRT9ieiOtWF/uyFwbSYnm4UMFwIM12Gf1v7EjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543514; c=relaxed/simple;
	bh=b+mXdaBHWtnz1eKg1Z3u+ckfuIbrifDwIRLVvX8fNyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYVdDvB3nk8X/TZTCfJ0Ocfpsyu+O6/A4bxeAj9eY//3aXicrfbRFC9nYwVQFG1zLYGCClMq6bfkiGDssGTcx8LCAhvV49vePTDl6dFas4uKUsJpM9fLb28FSWHaA5nlRpgr0j2G3EMd2Nbe1pICZ71cXwe4LbgAbkgSp6tzd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jQ/pqsFh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jQ/pqsFh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A43604E4151C;
	Fri,  4 Sep 2026 17:38:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 798A66057F;
	Fri,  4 Sep 2026 17:38:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72B5B11C78158;
	Fri,  4 Sep 2026 19:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788543510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wl7EtZ/xRSHxa2NefH9pWoJDSQvxgnL59nCZrjBuwzo=;
	b=jQ/pqsFh0aMETdA3THOo1MKS517bOJqynboLSv7CVCFJuH89ScruP0oUROXJeB0rzNb5Bs
	RdbubpyeA3Wo0NxzFBqkWEuabKfrtyVAXiI8u2EXqy/nXOjKgilFq6dGDIBgkLjOpst4EI
	h1VjVIgwchEvksFrBgNjB47iKFClW4CIYp7oNNxPW11xSn7eWzBOvN7fNpWJH7EA2DIryi
	hE4rHcbNSEkou4FiBCkU9IXl7vhv1W3uwzcQW/oA5Gkn0JWoDekB/WWML1zd9WVYbDqDWu
	0jSiL2UYwUJob4VQG7Fb66LrHujQz3awXIR+QhGvjO/MpbV8HoiOF5OV/GbmSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, stable@vger.kernel.org
In-Reply-To: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
References: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
Subject: Re: [PATCH 0/2] mtd: spinand: fix nand-no-ecc-engine support
Message-Id: <178854350834.1467647.6353766361428985013.b4-ty@bootlin.com>
Date: Fri, 04 Sep 2026 19:38:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 31 Aug 2026 16:07:16 +0100, Nuno Sá wrote:
> Setting "nand-no-ecc-engine" in DT currently oopses at probe: SPI-NAND
> dereferences nand->ecc.engine unconditionally to test for a pipelined
> engine, but nanddev_get_ecc_engine() leaves that pointer NULL when no
> engine is requested. Patch 1 adds a nand_ecc_is_pipelined() helper to
> the NAND core that folds in the NULL check, and uses it at the three
> affected sites.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/2] mtd: spinand: fix NULL pointer dereference with no ECC engine
      commit: ea765ae1efb2665da8981eba82b8a72e314af854
[2/2] mtd: spinand: fix zero oobavail when no ECC engine is used
      commit: a039958f2b95e6cc7f0e44d40298d17f1c0851c0

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


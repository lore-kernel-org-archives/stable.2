Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B43D88FA;
	Mon,  6 Jul 2026 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319077; cv=none; b=Mqte0b2IoA71AeRNi+Y66J4j/i1zPbl+7B2X1BcynWtLibK3uRvV3asEFHhcOMIdv71T5gZAevyBE5p2T1Eh9Q54Zou5HvDnfgOg18JQX7NdbDlZS6nv9LKeYTjmCgTyPhxiJyuKs9eBJfOZI6TNjBoixcGuq1WJHe+lftXre2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319077; c=relaxed/simple;
	bh=t8PK/i5kExzoyadMP4zeq/CxF6DiBBH3PN72t37cGdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dMLfEg11R/P+OFW8nIUv/xh2z1Pf1aKxAeTJaCu0U49JzcmfjhxADM7POehPB3Rtxc/9hRFeLJyOu89xlHjw5D4oqXHHYwjiopru8mmelHeVfi4Q8ZB0HQU782Q8vapeRyc8+Q05yu32HpYNgEXbRxYHyESHUGYI81az8FDZPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V0mw8dsr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V0mw8dsr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64C941A0E80;
	Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38FA7601A2;
	Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6538E11BB98DA;
	Mon,  6 Jul 2026 08:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319068; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oWy73pQkQkykoXtmTREjFgcQDsCw6POAoGsrElatGjo=;
	b=V0mw8dsrSBSByAJAKvS8O3OxgpTuNmyWSRvuUtyWFhVX5iCHK3DHymMXLzJ8rBCzVz6lPJ
	bBOdDprjSupXr8P9uXIeg0ZsAA8eHRMKfz5ypqIF4vZGvXO5zfhbHnKB7VcuvwcrmYMtdD
	4IO3OUYL7bpMwhNwYa8CD2ZVJZrrpEIyH/1kFwCd4vHL+6TSyLns45G88HpdF+mGIFE7aI
	0c9w2f9BE2sO94wAZ3vYGwOUucyDKACtrwxghroXxwgCV5zlyzynZ6/+SuUlnyfnI7vKFL
	tU09jA7BSVkjdnyN6SlTJ4H2GkpIXlMIKaCFGXyps+zdmo4XxTLsYt/gODqshQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Frank Li <Frank.Li@nxp.com>, 
 Kees Cook <kees@kernel.org>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260703074233.59967-1-pengpeng@iscas.ac.cn>
References: <20260703074233.59967-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: fsl_ifc: return errors for failed
 page reads
Message-Id: <178331906728.868671.5254954365609125128.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:27 +0200
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

On Fri, 03 Jul 2026 15:42:33 +0800, Pengpeng Hou wrote:
> fsl_ifc_run_command() logs controller timeout and other non-OPC
> completion states in ctrl->nand_stat. fsl_ifc_read_page() then only
> increments the ECC failure counter for non-OPC status and still returns
> max_bitflips, which can be zero.
> 
> Return -ETIMEDOUT when the command did not complete at all and -EIO for
> other non-OPC read completions so the NAND core does not treat a failed
> page read as a clean page.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: fsl_ifc: return errors for failed page reads
      commit: f9a13e05a327080c3a1c8165adf9e678fb68fef2

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8941CB26;
	Tue, 11 Aug 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437688; cv=none; b=aclhP1qZHHknGuhHh4v47hIAWZnZgrau4CWKh4RP4uGgjsGkC2NVIu3qiMdGVbT/FJ9fT1Z+8cCNrQCZXZR5e7/D5XdB8KCR2lueRALvV5Oy9ATbjoGiDWJIPDPnH+lM5ZwMAvwszqdOJqDKdEZXUABK6x51BTfgUZ4Nr2aU4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437688; c=relaxed/simple;
	bh=K8CQXiaoy6hLSyxUxpOtM0c7wWb31hYP1OPqlVQpamc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEiiI7so7AcZTEd36L9Mo9vdJBGp14X8K8RqqoOXU+DH72M5SgpbmzGpKcTe8EUp2EtF7r3kDmaWmaNqayRB5nlzsuYEnu/d0vIeGst67akTy21A3zwFULc16vV+PSPoIj9WiLpj6rV2nclMQo/nJEPKesrnPaDkbK7NHFptQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XMQ2e7Hg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XMQ2e7Hg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7D4EC1A1566;
	Tue, 11 Aug 2026 08:41:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50ABF6033C;
	Tue, 11 Aug 2026 08:41:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 491A911C4BC20;
	Tue, 11 Aug 2026 10:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786437679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=K8CQXiaoy6hLSyxUxpOtM0c7wWb31hYP1OPqlVQpamc=;
	b=XMQ2e7Hg8w9fjjP5cPcO8OW5pB2Fa3m32YWueklimYSxQkKLr5+d7+dXolHRzb1X1qAlO6
	oSi7drTvzBzwFqA9ps7BEpkFw49sB0HIIhgncUdhNg0SLITlJ26kyqH33r9hm8e9pIta3M
	apm7XdR4Plp/7rCxvpYLNxZpkyN7k9RMAWV30V0e2iIK/DHfaLSMHT8FazbUw5YDD7+q2X
	KqFPlC20Y6VSWGILZmQyJrQpAnGrPOmIfUkydgiJXxn8ipDBdNMcg2PLhxesAL2RQ9a8Eu
	GoDc62gCuY1yJEGuIuI4eKkqpeD+aZ7dda9BEqFUwKdC3SYNKJ5cHaHLyoptjw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
In-Reply-To: <20260811083111.403453-1-runyu.xiao@seu.edu.cn> (Runyu Xiao's
	message of "Tue, 11 Aug 2026 16:31:11 +0800")
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
	<20260811083111.403453-1-runyu.xiao@seu.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 10:41:15 +0200
Message-ID: <877blxoxqs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 11/08/2026 at 16:31:11 +08, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
> helpers") converted the RWW start helpers to scoped mutex cleanup, but
> left spi_nor_rww_start_exclusive() using a plain mutex_lock().
>
> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. When it returns false on the busy path, the raw mutex_lock()
> leaves nor->lock held and blocks the operation that must clear the RWW
> state in spi_nor_rww_end_exclusive().
>
> Use guard(mutex) here as well so this helper matches the other RWW
> start helpers and releases nor->lock on the false return path.
>
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

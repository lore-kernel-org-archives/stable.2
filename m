Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB13F4833;
	Fri, 17 Jul 2026 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288259; cv=none; b=p3op3zEMrraiFooplbBLl9Bx/7R57ruxX3B0dcc6SD9smr/+8BqEYC+FxEGaZzhOswCMNyblVl4HdYo8iotzuBiu0TfubhhBHsOaJ/Y55gTDvc8mA78iyddHkMtoVyW4N7a6KZOApaYFWnuq8BRVOsgYl8YGPqtgQLDRyfl5nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288259; c=relaxed/simple;
	bh=kg+Uno28y8LH0GLqJP4j+/TvRJiU5EsXOvYmq5/Z454=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEXLtxMx8QVHPhvl/EY6TxJabmJGRMp+wwEYdejgRu165ZcnNNGlTMFE9vcVS0Fa2CgTmeFab3NNXFTLQZiiJx8ufhQuvc88LGQWEt8wiBcjYWclljUtAqyzbVYw+6dv4MGt2SvX1l0cKZtp3ostrhQ4wmiWomZ3DPoYCTO2A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wxttU1oA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wxttU1oA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50C374E40E19;
	Fri, 17 Jul 2026 11:37:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23E5160363;
	Fri, 17 Jul 2026 11:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5AC4C11BD0D05;
	Fri, 17 Jul 2026 13:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784288248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kg+Uno28y8LH0GLqJP4j+/TvRJiU5EsXOvYmq5/Z454=;
	b=wxttU1oAiok8Es3N+ZVzBrA7tmb+RDahAu2/CX9Sh9AsaJJjbRnyqMDUg6GsVBLyFq7ElY
	tycs4cn1wYyZdqVS6ypIQ00qqXuRytn318n9pV8Vdw48KhZWhCEXG+cJoJHtOyd8ud+p6V
	7NdTSnM/Cv7l2sogWk5MwAHiai7dJGOiH7OCwN0ACUpib1VkQGOdLpwEkUDbtAfy2njeFJ
	VQtfNGn7i2duIjT9dHfLobplo/89PvAgLccs1734/lNot3lXc6KisbR4O9lGKsEet3sTg5
	2Sj8Dh/3l1ZyT/5zDeZebHri5OFu9BG8x11YJPY/+HySRexOvngz0tlDq/ZyoA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mac802154: hold an interface reference across the
 scan worker
In-Reply-To: <20260717105810.26226-1-security@auditcode.ai> (Ibrahim
	Hashimov's message of "Fri, 17 Jul 2026 12:58:09 +0200")
References: <20260710140927.13228-1-security@auditcode.ai>
	<20260717105810.26226-1-security@auditcode.ai>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Jul 2026 13:37:26 +0200
Message-ID: <87fr1hkft5.fsf@bootlin.com>
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

> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC03033EC;
	Tue, 11 Aug 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459020; cv=none; b=ExAM1naPoaTx2hKtwnIYNG8E+2S5Bl/0mzRY4So/4zxdgU7nhvxjSQYlQZh9RodochXCM4MAFdQF3RB3winS+VkCP4WMOlCrjA1i9gbJ4g0L6eV2zj369MbhqGqYzTlwbv+X0CmjGY8J8FC47atI8OwyRKuqWV7fXVOGHldMCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459020; c=relaxed/simple;
	bh=dIwtbpfTYyW6Ohr75acw57sAphuxwRk8EfRKzj3UCVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3iy2LWFcMr7lcidjHx81vC/pnQieZNAh858T4oInU2cvuI2zjqU7r3dBjQhcWKbbk/6SNICaUVU2zqTrguH3BxXeKO+oDm2ch5GrYBV4oxeYhvKZZZh0ZkfUtRu5+/M/l52GRIJmgr7CuvNuTKExQ2EgR+UeYadSO/AqkCrD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pHAPjdIs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pHAPjdIs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0BE874E411B9;
	Tue, 11 Aug 2026 14:36:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCB826033C;
	Tue, 11 Aug 2026 14:36:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AFFC11C48D69;
	Tue, 11 Aug 2026 16:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786459014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dIwtbpfTYyW6Ohr75acw57sAphuxwRk8EfRKzj3UCVw=;
	b=pHAPjdIstMc+aRhOzPPTp1nBbb8nDjYbkch3lCpybHxApdOIhxhEd9FkHAtcmXGyUccVmD
	YWXH9VPQNEqA0HU/+DJZtEcO6RUrHbMbGm3O03BPqMYrtWuE4sLvBwB+PcPzEOpXuIo9kv
	6RukzXS6LWZLscF4ftTtkVabrzWmiojYYlZDyrx/KPs2c9GTfqUekEqm5A/iitZ2PPQNvh
	TzmdHWKh8jl5Z1XLvMH8S4K3G4AApB48ZlZZ8dnLmZwdPbKZZAukEbu6HXdA+7HK8HGdj0
	b7sStVLjq4bQkh46ETfsDbjSD0mGFHmwxQNo+OvqRV0PkOk0az46hS3uMfCTBg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
In-Reply-To: <56991b48-cbe9-45bf-a24c-d7aa771c55d2@linaro.org> (Tudor
	Ambarus's message of "Tue, 11 Aug 2026 13:42:17 +0300")
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
	<20260811083111.403453-1-runyu.xiao@seu.edu.cn>
	<0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
	<56991b48-cbe9-45bf-a24c-d7aa771c55d2@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 16:36:49 +0200
Message-ID: <87jypwoha6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


> Miquel,
>
> Have you seen sashiko's review at=20
> https://sashiko.dev/#/patchset/20260811083111.403453-1-runyu.xiao%40seu.e=
du.cn?
>
> Both concerns look valid to me. Do you think you can allocate time to
> fix them?

Sashiko is becoming a nightmare. I'll add this to my todo list, but if
someone in lack of technical challenge wants to propose fixes, be my
guest.

Thanks,
Miqu=C3=A8l

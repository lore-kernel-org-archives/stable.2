Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5A517BA3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543519; cv=none; b=DeQsH29ZL+7CQZ88eJYFfWd3Ynsu0w+buDFpypU6y07cFdlNjmZcN7qHUEoBfEj1J7/56BrYOldk179WDxr7OAot7F/W2AmQLzk2VL300eLAQai8d5fAlXijoOmrPI7r4cb6l77SGfCaXDYJuq3SwYq1jMyh8FFCvIb7QlbxUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543519; c=relaxed/simple;
	bh=5it2E1EPIAFcUUzGsQ85Fu8jmFSe50WZtrwR4zf4mdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F7jDzRYdQFArEqJLHZLiB6GhUJbDQGvT6OdM9ojlA3DTfZ9vkOfdu82JBqVrPdSaCgMC67YQVBVh2VhVcIAVShCOiiKfOKSC7uZDnP56t/Vovee56KLO19j00fm/dTLW6yx6/YiBTCv5iMo/q+26TQergrkKdQ4+/eGWorX+z1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RVjekmHP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RVjekmHP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 30A1C1A19B9;
	Fri,  4 Sep 2026 17:38:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 045566057F;
	Fri,  4 Sep 2026 17:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD6F611C78158;
	Fri,  4 Sep 2026 19:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788543515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fCUZAB1CODJMooW/JvhKB0bkDCO+uGwldLqxXNdhU9I=;
	b=RVjekmHP2791GzZBTe+bKEIhfKS3+lwgibzp7lc6FZqo00F4Wnx1nmLddTyy7VTPooC2yg
	R4PLGef0PtCHiSJIkakwJy2ouLSbx+GJ4AJ+wtRF+IzHfOXtunD724QB3AiEssiH/ALXLY
	GmxpSpuW/oZv3Q0x9ePFJ9XjTp0/qU2/0husfaGwPeXFh2xD03VeiHMZzS9VZ/RHa4PeqE
	MV9ikFn6Oz2+i5OqOCGuxMt9dwE6HTeDfcenecwpQK7P/HJKr7x5twvbvJdzUqSEWlc0Hb
	+R3+zQr2wK8rdf1YSlFTQqWCJAcCS5qNyLcWNWlUUrBKSF7DEnffzyYdE02rzQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jianhao Xu <jianhao.xu@seu.edu.cn>
In-Reply-To: <20260902070542.3485515-1-runyu.xiao@seu.edu.cn>
References: <20260902070542.3485515-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] mtd: rawnand: cadence: Initialize IRQ state before
 requesting IRQ
Message-Id: <178854351280.1467647.11088878922601581121.b4-ty@bootlin.com>
Date: Fri, 04 Sep 2026 19:38:32 +0200
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

On Wed, 02 Sep 2026 15:05:42 +0800, Runyu Xiao wrote:
> The Cadence NAND interrupt handler uses both the IRQ lock and completion
> object. Registering the IRQ before initializing them leaves a window in
> which a pending interrupt can access uninitialized synchronization state.
> 
> Initialize them before registering the handler.
> 
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
      commit: c4da23777d35f4aaae7ff0ea9a503ba2702ef53c

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D914A2E02
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319075; cv=none; b=BEH42oZHSvzqF9jT9cXpfXAlb5Q0DlyQnJQEMZa+He2DMNIzKgiMQZpsQbXlyxXB8hHJ3xUVEUESxZr+1uKyDPn3HRkycUrxqEXPAZHHUGNxX9SmLps50f6wTx3ufTYW1NUWmY9ZJtEQXdOxshAPpQVJLNxz5a6MoncM+4eWlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319075; c=relaxed/simple;
	bh=GV1ViVPOjIgiCoy7I0ebGKDcmgwvfBNUVaVKjQcZjhY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYdaEAbZSjW550fgnHq7Sf5K83+dRnn9HYd8dW8D5UB7OyoiO2J/xkpuwZkSk9hP6aPocEG+UYjdx5tJY7VcabMcJGBX+pYEUJ/pjdydXCTkY3iX03E5xZVhjLO8z3Ihw8lukf259wr8v3C0XL5QHEYpv7v5e6KHjV6j8aSI81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pvRygfjR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pvRygfjR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 33DDE4E40CA5;
	Mon,  6 Jul 2026 06:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 03266601A2;
	Mon,  6 Jul 2026 06:24:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3BA311BB9890;
	Mon,  6 Jul 2026 08:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3bOyRrRg5NIlkC5Gzfb0zGlziitAdyLpprj4mRwqvjg=;
	b=pvRygfjRsbhnPbjgQMAL1BobYAHz2+arIhrGO1DgS3B3ozPBukv2jm5F0UBoWWrLuomOnC
	dcJriaqYD0ry2xhp0blTjPRbJ4eq5Cfm+3Tmi75PtDbolpHDg6lo7JeMrB+N7sGq7BGpth
	11o4FJUofilF5j2cKg1pCSpyZfRulA1aYXJV8JQz6UMqKfr3QtuhKmdl+mum6ZzHas0QqS
	qAvP9uOOkULVL6Omn5PQ4pYDHtUOTKRnbuWaV55npFKCx4U3whfZDPfHxGpzc5TLCfvvtz
	DTFyks8KuZPEP2gmCFi/uOEjD/b9BXjyRlkST4lCnT0mAfEoBhIdALDheRntUA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Vladimir Zapolskiy <vz@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260703073943.43373-1-pengpeng@iscas.ac.cn>
References: <20260703073943.43373-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: lpc32xx_slc: fail DMA transfer on
 completion timeout
Message-Id: <178331906452.868671.4337256162199028270.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:24 +0200
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

On Fri, 03 Jul 2026 15:39:43 +0800, Pengpeng Hou wrote:
> lpc32xx_xmit_dma() waits for the DMA completion callback but ignores
> wait_for_completion_timeout(). A timed out DMA transfer is therefore
> unmapped and reported as successful to the NAND read/write path.
> 
> Return -ETIMEDOUT when the completion wait expires. Terminate the DMA
> channel before unmapping the scatterlist so the timed out transfer cannot
> continue to access the buffer after the error is returned.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: lpc32xx_slc: fail DMA transfer on completion timeout
      commit: 17a8ce84964f243c8f89dc7353ac7e8d3137bc74

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


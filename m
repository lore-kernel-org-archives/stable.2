Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B33D9537;
	Mon,  6 Jul 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319077; cv=none; b=c4c1Lvw6Cw7f+WF8WPHm2xFJgIjoBpv+y3Ul6gftOH2g5Vos1dUmmS6I81mpMwIyTwjSBPEvdxBDLMgfy15YM72DlY16ck+KBxZiQjZDLE2CW4me8HonDxX9Sbtxlvvcg7pXmwtrrp0AoT0L7LrJW3ls/D3C3ym+jETneXf186M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319077; c=relaxed/simple;
	bh=3hm9OoDTN4bA7xoEYJatgQpg/RSNWltyyDXKGw/wDl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gKrd0bLyFZAHf1eaOMbqHFl6Qs2WMJt87LejDMPi86MPk7ArYPbX64P6Ljo4aE8YX2ptONN7OsFY6+a/Ks0O+w6w/eN4Zc2dZ/MUE8Sn5Njptu9dLGNLJe0h30VrsQ60iIq2tBTOkohPbyk3FBVzMbZqK2W3P6jQFqyzx8F7QmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JFnVDzXd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JFnVDzXd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F3121A0E76;
	Mon,  6 Jul 2026 06:24:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D80F5601A2;
	Mon,  6 Jul 2026 06:24:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2E0211BB98B6;
	Mon,  6 Jul 2026 08:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n4Tv2V/4yOSjq4bLJ4JsjVrgvra5EH3VtlC5Veydlwo=;
	b=JFnVDzXdssDy8kawCIfV4y0w2gDg34MLVLBENTkxpsqhVeLRaJ2NZ9TXZhrfgUt/O4ZIIC
	ZDdbySW7fbjWIIhrz7VD1pxiMWkf8a3Mh3rx97pm5XgQyTMM1ookRbrTvkM60rriVBFLiJ
	nQ0hNvKLHywTqENdOiI9oiTem4w/njWKtL6p1xQzImgn+mWYw7g4da20IZaXc4DJpcHUxY
	hut+YaNTgU8MJVTtQw/GQ6JtRuBwn6/8iSp9kgBF2dK2WptWNjvcE3FvNVbEXRao/M7jq3
	51tBaKFbGLF/qzSmJh6d8Tx2KLiCVk3PCJT6MykBHEecyAZ3Om37SNaOvz684A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kyungmin Park <kyungmin.park@samsung.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260703074350.65127-1-pengpeng@iscas.ac.cn>
References: <20260703074350.65127-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: onenand: samsung: report DMA completion
 timeouts
Message-Id: <178331906884.868671.5464358338960736984.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:28 +0200
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

On Fri, 03 Jul 2026 15:43:50 +0800, Pengpeng Hou wrote:
> The S5PC110 OneNAND DMA helpers have bounded waits for transfer
> completion. The polling helper falls out of its timeout loop and returns
> success, and the IRQ helper ignores wait_for_completion_timeout().
> 
> Return -ETIMEDOUT when the DMA transfer-done bit or completion does not
> arrive before the timeout so callers can treat the buffer transfer as
> failed.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: onenand: samsung: report DMA completion timeouts
      commit: d03a19bd6c7f86b99ca8fb61a6ec2345cee1d9d6

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


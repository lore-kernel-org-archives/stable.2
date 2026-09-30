Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4950E5A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778080; cv=none; b=YMYfZbpnefUSl9uTQCLGLPRBAPR3N0g+02MMECO1h63uhprBXAwxF5LslYv2O6D7cBLtG4Hfyz1h35szdrZyaTOKAiYFwf9DNgN/3v7VlDIJloadGdUD91hba4OFQFSM8cZoR8xj+xFY7mI/oYVxo60IZlA2SLzMDR+QuwXgMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778080; c=relaxed/simple;
	bh=uXwxt0Qhbcg0O7ZYfHlUJHUOGbr9HzDCl+H0IvEAXtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs7pFMITOyHRMa7ltfTUSe+UhEDks+9Z8tHCjiO2avTPZ3ac8FvMknNiU9WcmkyLklrcgmBG9YupbI4OC/dOT1Cxhw1Mt7ptSAsABCzp5+LvZDoGdbIaT23maotql0g3GDKb4B9S+ThfaIsrmaYjZpppQ51cbCE1ZOggVQ2Tuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aL+o4Jao; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aL+o4Jao"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 280C91A1075;
	Wed, 30 Sep 2026 14:21:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFD9E60749;
	Wed, 30 Sep 2026 14:20:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D10D5103283FC;
	Wed, 30 Sep 2026 16:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790778059; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Cp+D07WurpbWSMpKPIKSwnGgyFLxPSz7Sc7naukKSWg=;
	b=aL+o4JaoBIzNiZWSzVmZJCG7egwzH8W98aDqnjHQhKcZqlO08OmZwVowGNlXsJHXckHUZt
	ITV52l1zpOZ5QsiHZ37nAMv2Bmz7pmfGbcEGnbbcQPwn2HVShx4AkRzBH6g8ywF1FvcRAr
	4mjXL1s4237TBSeOF08WSgU3+dzHbwKxuVHN8Q+6/zn3BWyagSkEbFROk/QJnQf3I/u5bo
	NFVN/G6MRe2PSYZgt9ngEU/whfqYwI2BMGkM+fy9adM1CZwrH4NKIiYXquKhoMXCM5rgYK
	Pemx2v6e0KFM7v7eVgagOGgRa0pk8BbJtH2Bwfqu+X2KIAiTeth+psp2J4EU2A==
Date: Wed, 30 Sep 2026 16:20:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] i3c: master: adi: free the IRQ before unregistering the
 master
Message-ID: <179077804631.406255.4420583421827208390.b4-ty@b4>
References: <20260923085340.490776-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923085340.490776-1-fanwu01@zju.edu.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 23 Sep 2026 08:53:40 +0000, Fan Wu wrote:
> adi_i3c_master_irq() is requested with devm_request_irq(), so it stays
> registered when adi_i3c_master_remove() runs, and the writes masking the
> controller IRQ sources do not synchronize with a handler that is already
> running on another CPU. i3c_master_unregister() then frees the
> struct i3c_dev_desc objects that master->ibi.slots[] still point to, so
> the IBI path in adi_i3c_master_handle_ibi() can dereference freed memory.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: adi: free the IRQ before unregistering the master
      https://git.kernel.org/i3c/c/1c1e2d90aa45

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

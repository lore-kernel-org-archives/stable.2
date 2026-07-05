Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79399370D7C
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286959; cv=none; b=Foa+g8k5usF/teSTC1uVgiJSKaTX/ryUMf5VXb93DNrZCj/pjQU0FaPLca+AxlKkDolxw+IyS048JoRg4/VauvGWmvg3X5OYIpspRRRCwQbw/oFuRQ1AgK8b/z3HYSAfog41sHOnejwgiU4ethIf50k+v4Du1iM3xzCu197sVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286959; c=relaxed/simple;
	bh=3BjUa1NIsAcPSPBadFjqdjTOtpBC8zMr681RxZqj6yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THia5uOkihrkTHemdepccA1dCHK+IXWdFDyA7qNpY/AuvkI6bXepMm6D9i4Nr25AGI7gYoXt/7b3tEaGDWXTwmpVnHU+Jk+5f1O2X149gzb+91TNHaJjdx4UVlH/7a3qKb/aIi7o7V68uvd0mZnZYsPI6S1YEqQ1FbmRC+/+UeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0P01a7pZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0P01a7pZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4F3B64E40C02
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 21:29:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 08676601A2;
	Sun,  5 Jul 2026 21:29:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E601A11BB8700;
	Sun,  5 Jul 2026 23:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783286949; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SuVIfmSrYLDNWcGh++AU8GNwBJmF1eJewpBolZ+OX7o=;
	b=0P01a7pZPDAc8aH+TB9x9Ny2D72ovmJZK6oOx7js3rVVfwr1R8w1IP2UzKlTtL0K1a8VZS
	FQC485rBrwfxS3UAyJOCXr1OGxpM6xwocSOP3tFbBkCo9m5vjX5iBklCFkziVd+jZZigw5
	iia5+KKlNCdrq3a3I5xavDkN66X8Hy2v3CL6rLsISBRWmWB5VjoZ6TsvP2twYt+9LqxQcn
	DXCUV1w1vwtsKa6R8Wkx5CrI0g0bYFZjDZDA3aPSo8K4dMvd0devH9J3mDNx3CD71KN81e
	kbs+SvI0LzzpTqtVGm6yXujW7vWuxD+0mFd9kx2cHWsZrfKReFXJ/Ibk5pMxSA==
Date: Sun, 5 Jul 2026 23:29:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Kaixuan Li <kaixuan.li@ntu.edu.sg>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] i3c: master: svc: bound IBI payload to the requested
 max_payload_len
Message-ID: <178328692976.58266.3370861943512860784.b4-ty@b4>
References: <178227747353.2931373.15868718612134648277@maoyixie.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178227747353.2931373.15868718612134648277@maoyixie.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 24 Jun 2026 13:04:33 +0800, Maoyi Xie wrote:
> svc_i3c_master_handle_ibi() reads the IBI payload from the RX FIFO into
> the IBI slot. The loop is bounded by the hardware FIFO size
> (SVC_I3C_FIFO_SIZE), not by the slot size.
> 
> slot->data points into the IBI pool, which i3c_generic_ibi_alloc_pool()
> sizes at max_payload_len per slot. svc_i3c_master_request_ibi() only
> rejects a max_payload_len larger than SVC_I3C_FIFO_SIZE, so a driver can
> request a smaller one. mctp-i3c requests 1. Each readsb() then copies the
> controller RXCOUNT bytes (up to 31) with no check against the slot size.
> A device that sends more bytes than the slot holds writes past
> slot->data, an out-of-bounds write into the IBI pool.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: bound IBI payload to the requested max_payload_len
      https://git.kernel.org/i3c/c/bcd0e9acbaad

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

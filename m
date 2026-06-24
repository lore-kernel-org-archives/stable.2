Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208493E5A36;
	Wed, 24 Jun 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335749; cv=none; b=JMnlg9JHbWWf2ux7WTx9w9xuA/YqLZppQKOANQ65spPoWASn4hFDTrBUk8JgD2ePYR3fu6w7F4Y3yFi9zY0Jshjl3fG7s+wbBASIkHPEac402p4yTPM5QSpK6SGfYxyZC/jThfBiJvAEc792aB7CZr1W9w6S9f8KzKg08ZAEHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335749; c=relaxed/simple;
	bh=XKZWxuNeA28dfVCe7wZUWLIx4+atL2irYBOP17Cfaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lfyr2Id292P9Qz+nRmU/tbSSfHA88MxESmeLwsTevaenikBXxTYNY1V/eDXrotHU2jj8tzJkpZOU2/S3W3DpSZ552hz0nYhcXOXRUiggLEQmEjrwUaK8pX0eKMfUaf+43BvBYdcC678LGviiqBMY89CxZ+ayfhGWmVaaSAG/R8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A13nZ6Os; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A13nZ6Os"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C17E14E40832;
	Wed, 24 Jun 2026 21:15:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94EE7601C5;
	Wed, 24 Jun 2026 21:15:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A6A8106C8468;
	Wed, 24 Jun 2026 23:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JYNVb3iyAzsQp26XZiaX43GwZ4bhM070s2F68aaiHHE=;
	b=A13nZ6OshjjcHVpIWLWQX2BnuR9Z8gOZgpC9roAV/gM4/EZcRrHtWTAIIP9gEBuJTDs9f0
	djoCp8RN8nKaVoX0w+dscotNUtwR1l+/4lra7svZAYdMGawodoWMVHjQkc/1v/tyEKkKuf
	pqmYqwxpEu7CCN047+4mvYP/+ly/kHRepc20lgFUVtM8jXIfBbS3xKf38B75vTLkFQw9xi
	G9GdSvdkx/MObj2e3//uFHzfQOWj5WsZG4k/GEVLGqUw9p2AfkHqDoYN3lGa/63AuNxauw
	i10nSLVWM/Pq7jkSzCauacXluEgyNGFYmVBKoM712xnBbh2KFp59KhRMPIRakA==
Date: Wed, 24 Jun 2026 23:15:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtc: mpfs: fix counter upload completion condition
Message-ID: <178233558792.1517260.5634581783722495256.b4-ty@b4>
References: <20260513-panhandle-ashy-70c6abf84d59@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-panhandle-ashy-70c6abf84d59@spud>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 13 May 2026 18:55:55 +0100, Conor Dooley wrote:
> The condition that needs to be checked for upload completion is the
> UPLOAD bit in the completion register going low. The original iterations
> of this driver used a do-while and this was converted to a
> read_poll_timeout() during upstreaming without the condition being
> inverted as it should have been.
> 
> I suspect that this went unnoticed until now because a) the first read
> was done when the bit was still set, immediately completing the
> read_poll_timeout() and b) because the RTC doesn't hold time when power
> is removed from the SoC reducing its utility (I for one keep it
> disabled). If my first suspicion was true when the driver was
> upstreamed, it's not true any longer though, hence the detection of the
> problem.
> 
> [...]

Applied, thanks!

[1/1] rtc: mpfs: fix counter upload completion condition
      https://git.kernel.org/abelloni/c/9792ff8afa90

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

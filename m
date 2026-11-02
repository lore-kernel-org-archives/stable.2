Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612214;
	b=gNe4VkdaSrpjQYNxAQgRR48ywUud/Sss/UJCxfzECmFt5PyBNrL8Pi75p/f72tyGwFYM
	 qc0ZLmCXilvTB2Xb2MKvchUuGDCrvBepe8nfqIFwfhBL5ZnP+BK07RHGd5NbEfcZjWh/d
	 XmE6r+P2ldfYrWW78Te8OnGyhIEVX2XcJps+PidHUazpz0YmC6TYd8kko+4nOh8dR8gfR
	 PgnSK3MwwvsPQFQ3ttngzvHWDEH1X+FxapNzDFja21lqTeLT/T5E3yvPpNNlSBEJgi6Hz
	 wkgQbnsYvp54sQw57Ac1v9AJVClyyqtr2gU4Zz2O4W3H5/tvGHzmhvaiOPROL+22gVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612214;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 User-Agent:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=R662JnnZXAv+1ADEOp/XUIUO/2DvMXkgRXTUkhoS1mo=;
	b=odXj/Es96ZO8L4GRVVQb8dO4C64BsexJTvDX0pArXqzwDWgW40rXDBP6vfpjZ9pJfhkF
	 EbvLAlGegTQVfK31JjFuxJDTaOy0javL0aPZqhFcp5Hxj5ghTc189yo7DUm/SXZ2+Hwzr
	 suq2D4ez8GndtUL2SXBokOxTjYx6V+DuY6Sih744+Ytn8z72zwlnZgT2pcGcFbs2H8c4b
	 rrfYW4WF99UP8VU61fHRYCBSP3YehFXO7AmtQbVx5SS+BPIY0iugCOqLa3ETULt4nOGWy
	 /M8QA+rd563Q/L1JxGuZHREY4ZPjMNlMocxA52tQr3YD3ZOXV5ATOD2al+7jzPuHLjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A9606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2A9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1DDF01A1406;
	Mon,  2 Nov 2026 09:36:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD3E960750;
	Mon,  2 Nov 2026 09:36:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87A5A10329134;
	Mon,  2 Nov 2026 10:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793612202; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=R662JnnZXAv+1ADEOp/XUIUO/2DvMXkgRXTUkhoS1mo=;
	b=ENSWRpj/pGztgPota4D/jbkoJd49rS9LxSmaJdiO6AJbVkCmy85VNFuglYm7CF6xQga0dY
	yuU4gkNhkSkv32sAd6EUl4kyutT58hLQxDE39jJVqgdLYxYQU+scUvyTWvqSMrs8CbiC6p
	JQKhDHaGxFdtVCh3ymHQPmqXBheTc2VjxFtJXnAbkaJ6enJJdYj3BOSLcc+6x+b9901lqB
	T37DOu2OLMjVLP/HSpBD4XaPCt1TbjJLeo1kI9iY0Bm0z5OSTU/nevYC2FOZ3pGy94KyXM
	gERyuUElRPNTwKqSe6YXgpTlTMLR0dz9vLgSbnYEXk9kli8+aHRbmFdgzTQcuw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: andi.shyti@kernel.org,
	dumitru.ceclan@analog.com,
	sakari.ailus@linux.intel.com,
	luca.ceresoli@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	gonglinkai@kylinos.cn,
	rosenp@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH] i2c: atr: fix race condition caused by static local variable in i2c_atr_map_msgs()
Date: Mon,  2 Nov 2026 10:36:24 +0100
Message-ID: <20261102093624.17510-1-romain.gantois@bootlin.com>
In-Reply-To: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
References: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: koshi/0.3.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 29 Oct 2026 09:25:26 +0100, "Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:
> Was this potential bug observed on real hardware? I'm a bit surprised
> nobody noticed before.
> 
> Also, if it's a bugfix, it should have a Fixes: tag and possibly Cc:
> stable.
> 
> Code-wise it looks OK. Not sure a bug can really happen but I don't see any
> reason this variable should be static: it is always set before being read
> by this function.
> 

Thanks for the Cc Luca. I agree with the need to add a Fixes: tag and
Cc: for stable.

Apart from this, the change looks valid to me, as there is really no
reason for this variable to be declared as static.

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

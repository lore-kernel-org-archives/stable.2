Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510823;
	b=u3Id83MUxLnH4GzwhLLalFF7WPZu4aoxqMLzwpjWS4qRluAF/HVT+1HK8qfrPcaEiRKC
	 NTEZODIZt58vQ+yyeGttp1/xsjXGsAfjkogmWWvQF1ZXBj9qni82Gg2v2JeYra4D1qJAV
	 rfOI3RS4yFYj+yAyXV+R7r2+dFXMLX7J/B7+9zYhkrQGWhvApz7Vv8z04myLzhy93uCwg
	 CyXs0SyyDjxdJ2EzY+lfZx+ZfIYgpjExD4wPNK2h5XhrLFUNdB1+gARhEBHDibyj3Uv/w
	 UsKRwMsNMGEf032dNb2CjwtAu4ihLvn4qLK/00fIqeXq56coz8Psvlh1RSxYx12tpCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510823;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=smFTUIcx8cfAJ0RIWvn0nwR9mA44PKis6Nxa17lG3+k=;
	b=0KWks8OcC4yFPxDQMdA0HmmR1zA475pdbZ4Avbw1/mI8KDSaKiY+8NkHPBVgnEpucdjW
	 PIf5DSr+jAH0+DlPpG2ztxJG0GoF1kRmOQroCuNaU9otDqSKdIUPy5xOuhMveJMVQ71OA
	 TsoEA3qvAzExCwcB89ZhMTSqEP4nOP1ftSMfKp+uzwBwHMBGc/SUMBF47sBnKh/apXkG/
	 WQh6ij1t7IMYjGKm7PQsekjnqx6M3Xp41QlHNt6MySta+o1R1zSHH33DGaVSFxlPti/BY
	 j9OZCpck2ST6Yy2y4JeLNhalnHcpVUVQQsWhTCMmsREzaNYdO8byCHBKkIZJzavvYbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kiqmBDZW;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A9606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kiqmBDZW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6AAF0C4CBEA;
	Tue, 24 Nov 2026 09:00:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8CFA601E1;
	Tue, 24 Nov 2026 09:00:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 112E811E68CD1;
	Tue, 24 Nov 2026 10:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795510814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=smFTUIcx8cfAJ0RIWvn0nwR9mA44PKis6Nxa17lG3+k=;
	b=kiqmBDZWuqGnmZH8dTJhz4Y+tJ5PUFhdt956ttONRCBoKDeslaD3J7qYRa8Pa5/nsCdZiO
	3i+Ed4vvqdQaggJ1HYYU9eQQOcXh0CeZkgKbGSS3g+RkCv+dLdn2MbRvVOd0UIWrqAG6aK
	9Kw6ja2Aj6AmKtnH5PX4/mdk97e7pAnh7/yb5vOSMiGuuxSi2naFoEb0AOBCyBHZLWQCr4
	s3DwSddEtn/re5H5wwwodR2xAICobnEEo4HQAs/W4aTj4r3+Bjg+xB1p4YKQCJSilQPdxj
	FTXUGkSed0B0upfooAf9gN6XLVD+VFDVkCxMSp0SYvu0HAcpHyxnP+qjzrNCMA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mfd: cgbc-core: Add support for conga-PA7
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Markus Haberlander <markus.haberlander@rosenberger.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261123-cgbc-conga-pa7-v1-1-f3d17fb02e43@rosenberger.com>
References: <20261123-cgbc-conga-pa7-v1-1-f3d17fb02e43@rosenberger.com>
Date: Tue, 24 Nov 2026 10:00:05 +0100
Message-Id: <179551080501.9961.1835193533099263045.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

> The conga-PA7 is a Pico-ITX board with an Intel Elkhart Lake SoC, like
> the conga-SA7 SMARC module. Its board controller is of the same
> generation and is accessed through the same I/O ports, so the existing
> driver works with it once the board is matched.
> 
> Match the board vendor and name, as for the other boards: the system
> vendor and product name are empty on this board.

These fields are expected to be empty. It is not Congatec's responsibility
to fill them, it is the system vendor's responsibility. The conga-PA7 is
not a system nor a final product. So drop "as for the other boards: the
system vendor and product name are empty on this board."

-- 
Best Regards,
Thomas Richard


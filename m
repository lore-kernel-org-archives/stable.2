Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B5432302;
	Sat,  1 Aug 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583649; cv=none; b=rWZsQo01zIIeNMnTzyjVWGg9ha4BBrFgXi2zkhmrh5cl6WYvm159yfDM/Fs+LY9k/M8R8mJlORuKtzACcHXVVZapK8QimQT2XcVJ1R8HZxmqxV4Y+b7BRo4oYaP2i9dLY8DFEK29AtHhVNMEdfVE76jBEfYDFdrkEuf5NMeo0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583649; c=relaxed/simple;
	bh=YFJFNiG/dCjzfVJ+FS0HnxSkZpVKlnNaqoS0nAaybVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTKCvwMhpg4p4h2XMo5/dovAU1+k9zeNEAQT4PUcO/r4Buk7+fgyE+GaidkBw8HdgpqRHHwOKVJ3iMgfjT94GRQk9Bv1g3PKMFxNLkd+frm0LOMLLiQqKZaYWSzhpWEGcnslGMoyFFITN4ZIULcBwFphJ5CK276keFlShp4nG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pjum6oZA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pjum6oZA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 63FFC1A1395;
	Sat,  1 Aug 2026 11:27:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 345A9603C2;
	Sat,  1 Aug 2026 11:27:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEA9811C170EE;
	Sat,  1 Aug 2026 13:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785583634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QKObjQZ0eiPXWIcCdUDPDX8kQvNyavu8as7Hof/t/FE=;
	b=Pjum6oZAfGJso6gXTr+YOmhulEcrUSG1YPaRDXCMUAJolWvEKuTQu6ovWiXEWLlH9qCeZm
	mvmEZvpxPxsWsjk7xDJMFPx48dkSwiJiC0ZhDwnHR8G9Asi7+jU9oRDhveKZTdPH21gWXi
	IzaXGLY87ytHRAG66izbASx6ueIdFJ0ECAsaRtveMXHGG67p9K2vKwdZAytjpPZFqszb/A
	pIVopmqxuZu/8lQrBKTaXNOrUWuiAKT7u7Sx40HZsQS3+HGEl1+TPYdU4pUiRZvRrip9A+
	CSgzOJjhXTNckpBh0/2W7QqnSquhj+BVAcVVp/rkpX3quaHIeGiLHI4R2oHqqQ==
Message-ID: <72162aab-ac18-4089-9a38-ea1b162b2610@bootlin.com>
Date: Sat, 1 Aug 2026 13:27:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: fix probe error path and remove
To: Mark Brown <broonie@kernel.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, Pascal EBERHARD <pascal.eberhard@se.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
 <6bcaa81c-d52a-4a4f-9bba-8c61f6890fb3@sirena.org.uk>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <6bcaa81c-d52a-4a4f-9bba-8c61f6890fb3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

On 8/1/26 1:48 AM, Mark Brown wrote:
> On Fri, Jul 31, 2026 at 12:53:45PM +0200, Diogo Ivo (Schneider Electric) wrote:
>> This series fixes two resource leaks in the cadence-quadspi driver's
>> probe error path and remove callback.
> 
> This doesn't apply against current code, please check and resend.

This series is meant to be applied only on the stable trees, as there
was a backport there that broke probing in certain scenarios. I should
have mentioned this more clearly in the cover letter, apologies for the
noise. If I need to resend explicitly mentioning which stable trees this
patch should be applied to let me know and I'll happily do it.

>> base-commit: 52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74
> 
> That's v6.12, that's rather ancient...

Best regards,
Diogo

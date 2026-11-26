Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683872;
	b=oDWGfzSFDtCSQjMdx0Cxx2ZI/LCJNMxBVpCiETP9utmUxihUZZlYAJxBmooW6AvQkT+o
	 5nriXFfgSguEgv/i0/giOEEr+OeORCD+SV5rnTjUeFyqV6Q4egGH6vuPESHRQ/FK4stpk
	 0o5Di0pfvXStp+Tc842V11tV9m5uDpqt5ay8PLWTp9EyZY20kVrq3CxcmfxRcG1kHik2y
	 BH019eoIE+VN2tVTKzMP7ae6Ys7iOb1p7y7bu+lry4kWabcvTEVvxWEnRrEhNxKoDJDJ+
	 phph/GH6/A8OrGbep5IBz0OaFuRE28ARnUn5+hB/rDUvGWNon7h+fzwDD2NRCQqQDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683872;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=+epy5iM857+Y35amMUxIo3MbWvv+HCgyMNGV+6ss8Jc=;
	b=h2G71TO6WSFOC6YxEb86kSb96w9mqo25EOYu/48TYTjFvAeBVsr8t7ZN6gXiODy4xvuk
	 quchp0Q9BwUF9j3m1zCR9Ab1l8ToByTfFYeCQ1VoFaaUBM+i4I6uQjlnpyw/socE0AIOL
	 FEOHBhIQ7swmixwgsVIEYTSR+IRDOFyUPugN+pMvxxdLbujNI5YiN4FCUgauCGJ48R6nw
	 0H2wrvhiIoe9gLQjrAcuGvaoxDu0/oZu+REaYZQLca3/+59mfVBbRec6XZkIkpwvlCool
	 xRsdKT1ovUqbcXrx2o3k0OYzyE4tNQ4Q569/FFLF4s/QlNnZ9CDTLoU0nnVdILeumyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aRfbTQxw;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DF606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aRfbTQxw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1AF8A4E41780
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:04:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC41C60237;
	Thu, 26 Nov 2026 09:04:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E862E11E6A5EC;
	Thu, 26 Nov 2026 10:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795683868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+epy5iM857+Y35amMUxIo3MbWvv+HCgyMNGV+6ss8Jc=;
	b=aRfbTQxw1eIdufWRfZjIxbnYzQRjaNO8kbsIB3/NLSgOF9LgkCiOHwV8FVBVhPUZ8fTmLe
	nP4ruagJL5vXaGjwj/mMtgyFPeNWqfQ7UTIjoNiqItqtKsJEMLkdVIiS0E4+ti3voy4It/
	bQG8T/si+rQsvxQgodVf6NIArUaF6suxOg2P4QxFhKd4FGLR6UOnF7vwZSaXxrp1vYa+qj
	D3sJnLJwEnxn/1CqP8x3iNBIy+DfR6yXCvb5LGe+VIjtYTqcVyzQfwlJ9Q0VD4vi2jYHUC
	HkZBlxoORVjAiSjNbDfblzMU0etdQ7qnWA0wNsjylJnClPGYspFZiIq9UmToXA==
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
Subject: Re: [PATCH v2] mfd: cgbc-core: Add support for conga-PA7
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Markus Haberlander <markus.haberlander@rosenberger.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261124-cgbc-conga-pa7-v2-1-18a114b1801c@rosenberger.com>
References: <20261124-cgbc-conga-pa7-v2-1-18a114b1801c@rosenberger.com>
Date: Thu, 26 Nov 2026 10:04:13 +0100
Message-Id: <179568385320.302193.15039118220494670733.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 24 Nov 2026 10:22:38 +0100, Markus Haberlander <markus.haberlander@rosenberger.com> wrote:
> The conga-PA7 is a Pico-ITX board with an Intel Elkhart Lake SoC, like
> the conga-SA7 SMARC module. Its board controller is of the same
> generation and is accessed through the same I/O ports, so the existing
> driver works with it once the board is matched.
> 
> Match the board vendor and name.
> 
> [...]

Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

-- 
Best Regards,
Thomas Richard


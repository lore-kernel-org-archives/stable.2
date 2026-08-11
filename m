Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8A1F3BA4;
	Tue, 11 Aug 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435263; cv=none; b=uWWTEaH9dbiue4WFeRMnXM3hMAY1jxsXYgqsaI6hLBvXeW7dWLq9JO9nHsujIbWciaIOFy1Z8m1runMqnyN8w5RLhNQ0Hv+5EOlLH4sm5kLFbTFEJTeQxvPcJ6F1QitdLbU4cGBHYlP1U1/3FQo01ntsq7HlbsLLD5hG5X2z8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435263; c=relaxed/simple;
	bh=H+Vk2xfo+B0+N8bIbj6BdstT/ByQMh1o5WlBDlRhmC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOrAxZ48Fv1tvI874UrQymBWiJxLbcBmqsuso8ooNF8pc4A+rgwFg2WUc+3Tv6y16X17+j6Qt7UehwcHMUClPiH/+GlKoW44eEdKMA83w+2mjpQXKddT7n40VKim5+ad8cAeDNaZrwPXeSJPLhgZ7EEO4x1TVO2gAwdR3F211Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B8epk+UH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B8epk+UH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D18164E411B0;
	Tue, 11 Aug 2026 08:00:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A488E6033C;
	Tue, 11 Aug 2026 08:00:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8603E11C4AC8A;
	Tue, 11 Aug 2026 10:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786435252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DK/f7XA+PNdm3nlpd0KdTqNH4jmg+PuecPVyS45ASeE=;
	b=B8epk+UHdC2aNpPUpx9FPPuveb0bF6G5+0E76OmELomEoDP+8KK9+TRoKMbPWrpG3cxccK
	dBnb2y3zlKlZE6J7eR2geVbY0oFBlii35Tj95+gmYmLyWFVVZf5cRobongalKrfWdWeoaU
	dpkLFsVIgCfdNXbKS66m7Yq3/M9VZk7QCyC89pneyWEd+wfaolWjs/BpTsBqLHvFgpSOmg
	DOqbkjr7+rNMJzugOEHPkdANvl+at9kmuuaMy7xSMdZBCh8NKFqJSS2Z4+zKwdUwoJb/xK
	N5obgM9P3ohGXJom162SQAeuj7Ygh/Zjs+s7u0k22SZ5cTzO2aewORHFZrvi2Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-wpan@vger.kernel.org,  Stefan Schmidt <stefan@datenfreihafen.org>,
  Alexander Aring <alex.aring@gmail.com>,  Varka Bhadram <varkab@cdac.in>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ieee802154: cc2520: fix FIFOP work use-after-free
In-Reply-To: <20260811010359.131381-2-fanwu01@zju.edu.cn> (Fan Wu's message of
	"Tue, 11 Aug 2026 01:03:58 +0000")
References: <20260811010359.131381-1-fanwu01@zju.edu.cn>
	<20260811010359.131381-2-fanwu01@zju.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 10:00:45 +0200
Message-ID: <87o6f9ozma.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On removal,
> cc2520_remove() only flushes the work.  The devm-managed FIFOP IRQ
> remains active until after ->remove() returns and can queue the work
> again after that flush, allowing it to run after the private data is
> released.
>
> Disable the work with disable_work_sync() instead of flushing it, so
> the handler can no longer queue it once removal begins.  Destroy the
> buffer mutex last, since the worker and the stop callback invoked
> through ieee802154_unregister_hw() both take it.
>
> Found by an in-house static analysis tool.
>
> Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
> Cc: stable@vger.kernel.org # v6.10+
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

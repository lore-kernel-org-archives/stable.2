Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DC43F8A9;
	Wed, 29 Jul 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313795; cv=none; b=eCsj55jLdB/nk/irO637YA3UoTaiEgPd7kMtlzN3QH7yAol0P5iqVmQjfgCNeN5UGWvZpFFSk6pPtMYgMLIdzuIOjafGd3T0oj3gzlFJKK3clP4biAfyVbtWFejwFFgDKn4O5//jxwwwnRtr3fs6yg2xfxn3abQOfVSXNsTFeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313795; c=relaxed/simple;
	bh=fCR3hsMiiO5KryvysXxkcVgnvr0c1eH870Ff16+b89k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0oqafPZuhdH60WfK0+hmCl7tAYVsZF63tPNsv6g4VObch3YmH7jYjrpNRVv11yLEQFgvJBqwYxVb5/ByH0u0zjudoBBjfQmSdkFdjCX8WwZtJKyS4VHklXArIKm+pmRsEhHczbic5iYQU5fLfz1OWVWpWkuGNy91yURVXwxUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cvNgwvfB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cvNgwvfB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2433C1A12E0;
	Wed, 29 Jul 2026 08:29:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E32406039A;
	Wed, 29 Jul 2026 08:29:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 147BC11C14ACF;
	Wed, 29 Jul 2026 10:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785313776; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fCR3hsMiiO5KryvysXxkcVgnvr0c1eH870Ff16+b89k=;
	b=cvNgwvfBddBWscuzeV52TNdLm/EttnbFIg0IL1ScVlNfzxxoRmWIIIWvT7dRZYCbRkn47F
	ilkWvf8xQgpy+OcPFT+kjvcPOKs9uHaHnCEFcAHepj1DA/GGrryPioBypwzkOUAlCahzOV
	n48gTTl7w/w45ipp37Xw99qOgjjSulUMvsBN5FlDFNeNkkOZvt6wel/FVSad0NskjWEKOU
	2oYXbuA2zSUTICgKDTReM2F8fuXCsDhBxjTptH2WCP/M5Cu+HhI9vuc4+tFnOdnZlDvxuW
	LNPvY+65aAN7kUaZiBQON6p5p+ukEfwS7q4cvFOn43brVz0C3c+SacD1nCxyVQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  david.girault@qorvo.com,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH wpan v3] mac802154: fix use-after-free of sdata via
 queued RX frames
In-Reply-To: <20260725135154.99876-1-security@auditcode.ai> (Ibrahim
	Hashimov's message of "Sat, 25 Jul 2026 15:51:54 +0200")
References: <20260725135154.99876-1-security@auditcode.ai>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 29 Jul 2026 10:29:29 +0200
Message-ID: <878q6unqqe.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Ibrahim,

> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---

This whole change makes things clearly less and less readable, but I
don't easily see any possible simplification.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

If you are willing to fix another possible leak, you can check Sashiko's
feedback agout skb_get() which is likely leaked since down the stack we
clone it and not consume it.

Thanks,
Miqu=C3=A8l

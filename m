Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104537;
	b=XFvuBshd6b3lCFtIjYf6ao0Br2DME3sGWPg+J/eugfsdZCqxnM3Mu1UN+cn50OZecrVT
	 c6CCJTGHARsgirqivvq+KBgk68FiR4s03G5Pg7qgT0Qr0IhQpQuyCSA03dWboMZad8ZJy
	 jvO6VeL6oz9gzNUnG5xuyD9A8CB7ZriHeiUIzrPrPIhn8YUty6Sf3zvBuY1MKZasfR+FQ
	 2MK/sS8FW90AV41Gf7VXtrBFUx7P1Y6ljF3bZt35KV4ozgcFx+4VgA0bPcF9iE3hvn7AM
	 OauN/vitgaJLDM1KP0P4WR5u6mmbTzZLmF00fSYVdBMYWX830D40ToA7GBHrkjyOY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TxSclnuHCt/lHKYBcrzKLSRWY4cdJ4cl+4OUOpVye5s=;
	b=fuq0ftn3y/Wb8GOSSfsyDJzDp4+9F/2uXpn8ed5V+DzBGtgncyq5s9bji3k4RGtDXqxP
	 yEwRxXL0cbhIO45l0oadnuHvgeZtHaI/zlFy3BewJcGplXbKuD7x6KbzBflF/00eZewtM
	 B2AJj/AfXrGpXWaftDfyWvnxaQ1ipgJykn3JbpD9Nnmf6Z4u1cyKEOa418IbLusPFe83C
	 f8UMXN/hW4DuG4ANgwcP4SLAS2SKx8YUK+P3A0PI5N4AKVJAnCk3+uNkAA5FZFgiTTtSY
	 erDlLL7EqtRz7PDOWru7rRn4gyhasBJn/BhAQGEMBa228fF6Jgkc39Vb3LgutnMLC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9TbhoWi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E2606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9TbhoWi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9E11F000C6;
	Thu, 19 Nov 2026 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104537;
	bh=TxSclnuHCt/lHKYBcrzKLSRWY4cdJ4cl+4OUOpVye5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9TbhoWiEtTeP8a41wMgkTKbNn80l0VEikvN95vdfrt+tlWAZKEZxIRM1WHrP4rYs
	 MlVYr661PvIYHrZlzjgT4PUYlzB6c/XYXmx9mqar1hz7YEUaizpfi5YBj+eMvsyuAN
	 wT0UHuK/LBtFbvkqNYzGypeHJ0PYMXXYhb9/Ka0ZNi1k0wRwou5QwVUaF+g2vRr6JB
	 g8Y2z3rTFohKntFoKna1qCZknjaUq6GamqtnidFlFU93lQKaM0tgrOVQSOEPBEu3+3
	 sipvZeHFnFp6/7FUMy6A21VUnmjdl4SyvZO8SpuKJxyoOxGYvoVs2ba7JMhIeijShC
	 uxEe1O+vAd8Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Liang He <windhl@126.com>,
	Tony Lindgren <tony@atomide.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.10.y, 5.15.y] ARM: OMAP2+: omap4-common: Fix refcount leak bug
Date: Thu, 19 Nov 2026 11:08:24 -0500
Message-ID: <2026-11-19-1-daily-reply-0022@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1794979730-13985-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794979730-13985-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 7c32919a378782c95c72bc028b5c30dfe8c11f82 upstream.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

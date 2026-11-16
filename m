Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841166;
	b=G8neGMgSVwJLml/u+tstTPOv8NcqBxO6NPuXubVp0AUpKNzFbUjEvdzrv9LXxgZ2B1dn
	 3sUAhh58Qd5muMMOlH98aRMslJ+EteI+y+E4U5CiUbqu81FDluEbFCujhDkrESVLtambl
	 ZiVoBFPJprVn1lzdjXXFcHZvdDv0g6nFY8JYcKti1UDY6Te7KMVOR5ns3X9O0Q6RvcDVG
	 h9mzP2L4vhPp420/24CHh3xVwjyXwifXSkFuKhnvNzSXShMJm6sxC4ra4pXYUtpIzlJRV
	 8AomtbKdgUCssfnoedkdblVdW/Vbj7vLS9WVkQpnYmn9M6Qhn6Bwel9wZrKNCZGc8Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841166;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=k+z1e8ZYHmpUCjSLI93JX1rRkKOX03qgDSkkP9m7sJM=;
	b=sLaC4qEelbDdTSzqkOskt0sUuRCfErsP9s1QgAQ3LcAdp1qwMOboaS1rcsv7RPvKnaI7
	 kcP5TObG6EU0wCKCAtAvKotTSqL1Qt0hGGe3WK9hnqcUcRgDolkp9/+KybjRUU7tr0hzP
	 uKmz7bqKtVd/PluzAWTagoNHosKxbUVopJhzr0W1y7H38ut8EsgotQT2ug67v83Z5jSSc
	 x2iEQ42vpaPhW4DuDPOmOSbjkkLR6UKxbiV2T8FYNvKYpBljZ7henYQ1MztV5Oec/zdUJ
	 hGwbl1z3Kn+yOTsfasyjWmUu4qbmeUGgl56SQq4eizRxmNhWUZqo07L7QgxPT0SUY9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b7dwUYkY;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB79606A329;
	Mon, 16 Nov 2026 14:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB79606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b7dwUYkY
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 073451A168A;
	Mon, 16 Nov 2026 14:59:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE9F86023F;
	Mon, 16 Nov 2026 14:59:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B7E611BC146D;
	Mon, 16 Nov 2026 15:59:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794841162; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k+z1e8ZYHmpUCjSLI93JX1rRkKOX03qgDSkkP9m7sJM=;
	b=b7dwUYkYBncloh3qf///PWv/FCi82wnJRMnDsiFy6tRyanBxT+0HFmm/Vlr0JJpHuBBvz4
	X3Gyqd5Or/le63nZuammyJqDBqmZuxdufszUfHFHGDjEPDI4Xjy0NslQiDmfKr0XWcdZmN
	x8SEbMWNRls/gJnQTF1zpN8hmYzsE+htWV+/FCVpZC7io56+cOrr75yNLKWfwOFU3r0Un8
	My8OC73w5GOHgHYcfVuKgPn1uWwGS+gD77+WiVrd1NbCUW8nJ7HauPvXFc2Z1QQ+Ifwb+6
	wIBOgS+FDEcTCssTR+BsRsV364Mwu0sIf9ebrzkLtOkXfKVxE5WHxktrznAEAg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@kernel.org>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: fakelb: release platform device if driver
 registration fails
In-Reply-To: <20261103102854.1340581-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Tue, 3 Nov 2026 10:28:54 +0000")
References: <20261103102854.1340581-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 15:59:17 +0100
Message-ID: <87qzgkrfei.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 03/11/2026 at 10:28:54 GMT, Wentao Liang <vulab@iscas.ac.cn> wrote:

> fakelb_init_module() registers a platform device and then registers the
> platform driver, returning the result of the latter directly. If driver
> registration fails, module initialization fails and the module exit
> function is never run, so the platform device is never unregistered and
> leaks.
>
> Check the result of platform_driver_register() and unregister the device
> on failure. Also check the device registration result, which can be an
> ERR_PTR, before using the stored pointer.
>
> Fixes: e1e49b641387 ("drivers/ieee802154: IEEE 802.15.4 loopback driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

I don't think it is super useful, but it's not wrong either.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

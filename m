Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608813;
	b=BRrnWmNox4+t5+qWdSDucBYNm+K8E41jVhPJHia0TLdhOegkzefOu6B9uBnQqYnIr+m4
	 NuGEPhYZUom4iujAPYf2ygWReKUdCw2agnJyUdmoDONB4+ItLmXE24wYd9GHUaQ9c6RHk
	 JzNHdn3lnoq4KRkOu05KF9TIL8AAuUpi0yVtRe8MfOtyxcN2mURqVhSoljNZn3v6BjdjQ
	 fXnFEbrI6Lemz9u38pWaz0pzXS3rKDLV2A/nn37CFRqmKuvmMoIBXITYpH0h7B17fuYr1
	 oRhSOstdHS1cz2p3g+sHkkRBEY/lux1aM4cSicY29KHitVVQXJ/7vvwzkMbJf1OmH7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608813;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Received:DKIM-Signature;
	bh=3oaoMw5fIc0MMZ1IvijkvhqcCiuTTyPoYGfE2YDn1Vo=;
	b=bONpPnfVjM79oVaWHLrKAy8PIcqFjv3xurKF79ZsL64/l+ekZ94XIh662EJY70/dFcYh
	 nQYx9/osgO9wg7xakG4MGQT70/5NFHjUQBFge3kQFNrd+II+2Olig5gKr4qoND/3IFt3O
	 fdtNfycrhrZAurG4Qy1tywJZhV9JOMWA9l01Y3W1AN6bE+5CaRCWeiNxTZwzK3J/MOka4
	 AVm59eNxrkm3qEZaI7cimk+pCA+4REkwXEqaxL0PwRbRF90sDXLX41SF6RP6NeRNaCq8I
	 MXAHrzd7/rgZWZLfIetbLOq4B6VoHfUSmjwcDMQ3DoV9C9v5KCuqei2YvorUoDIFiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=dE7i2YJ5;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8E606A31E;
	Wed, 25 Nov 2026 12:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D8E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=dE7i2YJ5
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sinfo@kernel.org
Cc: Federico Musto <federico@rimpianto.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: atl1c: cancel the common_task work in atl1c_remove()
Date: Wed, 25 Nov 2026 13:13:28 +0100
Message-ID: <20261125121328.2662-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179560665678.3294.8918626244463796277@kernel.org>
References: <20261125113141.99792-1-federico@rimpianto.com> <179560665678.3294.8918626244463796277@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 26FF1932-D966-4E05-B3EB-22FB759A1D93.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 13:13:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1795608809;
 bh=3oaoMw5fIc0MMZ1IvijkvhqcCiuTTyPoYGfE2YDn1Vo=;
 b=dE7i2YJ5PHZAHSc6MpK70/WntPdOh8d7RMonT9jjEQbqoxXnOIpNoiCN8NQ6qXMxt4VtImg4d
 m/i98D1/QMreloZu2jcsaszKa4qGVX8wD+Gdmkzy7Z5bUW6vqxJXUo8aIyv+pFc/LsbL8Chc/0Q
 YM6k1BWw7wsyRlVZKb2BuQLoBXl5NOWsNOc5B5a19+9HGYRpDGbPL6dAIUDt4ddRRiZjyHOOw9X
 DVEq80d3px5JoJQbmem8Dk/I357CZiEIVI6VBckja8OHqD1jaKcsTpGrlUedP9/rbeJG0qLyYpI
 QiSAnskArfYSfCmAO945sph/9UU2Jg0JJvhMJSbm2zQw==

The change was not tested on real hardware.  The use-after-free window
- a link-change interrupt re-queueing common_task between the
cancel_work_sync() in atl1c_close() and free_irq() - was found by code
inspection and has not been reproduced.

It was build-tested on x86_64 against netdev/net with W=1 and sparse,
with no new warnings.

For context, the hardware I have for this driver is a MikroTik
CCR2004-1G-2XS-PCIe, whose SoC exposes emulated AR8151 v2.0 functions
[1969:1083] rather than a discrete Atheros controller.  The related
two-patch series posted alongside this patch was runtime-tested there
through a DKMS port with diagnostic counters (27 link-down events,
~4.3 GiB of traffic, the link recovered every time), but that build
does not include this change, and the remove/unbind path was not
exercised on the card.

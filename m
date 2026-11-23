Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435230;
	b=MsuaC64g6VngSkU60wD8X1N6IzFKsVMNN6SJv51/IdCDzLur4cVl4ua20JaCaib717iR
	 EkVxJGi9WS85xeIw2FaQaATIKgv8b+LgEFKugNGd/thAMe7dztddGHWAxGny7hlyrPI6G
	 H7EJ4pHQo5sJ212KoRa6qkPqQHsflBnrjQhCk31FmiJ4g44Ykq5IFjhvrYtrwPLZ2h4qA
	 OcyN5sThk2WLWFYnSCx/Rj998AnZyj0WNTM8fDbaeWlHpyHGGfPiB/p53wDbWKMeQUg31
	 UHRkmCc/+GN2vuJf/UaNf1R2EqLh9teBxv+gIcFTLvyCy/orMv4gPbasmv7kXZaS3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435230;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jRPeG+FI1vMjvAoUa0LB4PHxy32yruYk5KO8ffW1GmY=;
	b=OouaqltRQufBunm3ta1R70f4zGj7h6EdK9JIz3sx4p2SS4/y7lM1KoBs3xtg5RsBBxkw
	 E7ZSKSZkOs0mBKL4CHAW3FULa7OB11H0XhTbfjHx5PRB7AMIFzhI7e+gLZU/QfC+lb3gx
	 7fO2mqBExYSOLgc9K9qlQBxjUag2kfnek83Alv+mUIgp5d4whEhbxXJN5/MKOuLugdnZ3
	 XHVFS/ou2Z7gi845stIsvI2J3lP8GH/UsSPgg4a7o3vpjcnYSBLq6aGSBkAi75T0noOfa
	 fx+x3x+Nu8l1dpDKAlaQZiABCffPk0FzLdrm6f65Xl2zYebFrjKK4ykQpny+5MsB5xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vo0+c5YE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD8606A31A;
	Mon, 23 Nov 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vo0+c5YE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490541F000CF;
	Mon, 23 Nov 2026 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435229;
	bh=jRPeG+FI1vMjvAoUa0LB4PHxy32yruYk5KO8ffW1GmY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vo0+c5YEIIJTJ2Kt98yojufAjqqBVUiOlgqqW2dQ4ch8O6r+hq7gxW4RLdZfuJY2a
	 xlR+5jSpCCepzH9SAi89eFjlsyLHcMpffncV8sGllDkaQSmbtFon252WcK0Bjw5eBl
	 X5f5AhrBfVvCTvw7A0G4yV8l+jbktEVX8IZjworLG+2tQVmUPTJkpIH9Dxj29Hfplf
	 lt1FUhS4QepGXpCjUC1OwiDSnDkpLfC39MIK3w8q7cKBfjU2ZlxJOIqdAsAWcAWUOR
	 10WaI6vUpyjEkf6ldT9HLOtG+R5sq7ftwFpnjBtnXa+xQBl7Z3e3p8Qdoyi5jq5G32
	 u8/hLY1rSwVxQ==
Subject: Re: [PATCH can-next v9 10/13] can: gs_usb: gs_usb_get_gs_can():
 report channel number out of range error
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:28 +0000
Message-ID: <179543522887.3131.5577678621864110262@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-10-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-10-db121d488945@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Grammar error in the commit message of "can: gs_usb:
  gs_usb_get_gs_can(): report channel number out of range error".

--

can: gs_usb: gs_usb_get_gs_can(): report channel number out of range error

When the USB device reports a channel number that is out of range,
gs_usb_get_gs_can() now prints a rate-limited error message. It then
marks the condition as fatal and detaches, as before.

> If the USB device sends an invalid channel, the device should not be
> silently detached; instead, the display an error message before detaching.

[Severity: Low]
This isn't a bug, but there's an extra "the" in the commit message.
"instead, the display an error message" should probably read "instead,
display an error message".

The code change in gs_usb_get_gs_can() matches what the message
describes.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c392cf65d8a6d..aca4f4fdc796a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de

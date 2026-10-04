Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3184A5C24;
	Sun,  4 Oct 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147608; cv=none; b=Rn/dCtVUz5VLrG4bBzUSkP3Lg75P0jcKrRmQxN1WWZQG7WtK0gGXK5ahtjZ6sHZOQ8OoZ8kdYHwjFAGIx1wzAjtDKjDgXFSAhj8Xm9L76U38BWRSdsS7GJxdI/4xM6GQDvBR+H7LhsSWNU0FWPTWry8mvv0gC8dmCCT66JYXOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147608; c=relaxed/simple;
	bh=doQHPYfst42NgJxu+DUu8YkW7hWEb/b3Ymva6Rl8Lxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPmzn3RKxF58qNnHi0lskcczDEL6q6w6J0bQtoMfvSskea38QOu8arHb7TVhmevAPaaSZ37iLTdyl1xOrKn3uL93QRpfCcOJd41nMQuIOweReAXmKWaOn5+Qa4YjZYmhbE0voGX8zmfQAOMKAQxOoGXGn+zsgEtz3Kbvx6OQjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S56LnjnK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S56LnjnK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A1DC84E41168;
	Sun,  4 Oct 2026 21:00:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7472C604FE;
	Sun,  4 Oct 2026 21:00:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 755091032820F;
	Sun,  4 Oct 2026 23:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791147604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=doQHPYfst42NgJxu+DUu8YkW7hWEb/b3Ymva6Rl8Lxc=;
	b=S56LnjnKllcxhoYBtLUKnPk72SveNWUnqXyIy+qeTwmjY7yKspcAhYurAAhl4soK0kHWCN
	ClL+K0WPCvHYgHQBSi+e7RWY+I5ccoam/Lw+2dDxHP7/Ky84JSl2AXKewkBiqQtghsBMEb
	hNe4yaQ/QWcdiRGNgsEwkit0pp92/AWm/gLEl7ZJgdmMmlYKLzArvjAweyuTCNKRG2hHxU
	5VcIiEGM9JypiF8/xDsyBq5VwhSaniTdGvsxmTDAF0N7Kam40mumKv/W7t1Pzzgchm00Du
	oX+fOUphqV2Mih8ZDDnwsMhdLtPCNTzEfVdhqY7ZQqJI5NSqR73pi5o/Hd7xmA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>,
  David Laight <david.laight.linux@gmail.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer
 overflow in ca8210_rx_done()
In-Reply-To: <20260930071914.421586-2-benquike@gmail.com> (Hui Peng's message
	of "Wed, 30 Sep 2026 07:19:12 +0000")
References: <20260930071914.421586-1-benquike@gmail.com>
	<20260930071914.421586-2-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 04 Oct 2026 23:00:01 +0200
Message-ID: <87jynxji5q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> Check len > sizeof(struct mac_message) instead of
> len > CA8210_SPI_BUF_SIZE in ca8210_rx_done() so that any packet exceeding
> sizeof(struct mac_message) is logged as erroneously long via dev_crit()
> and dropped before copying into priv->sync_command_response or passing it
> to ca8210_net_rx().
>
> Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
> into ca8210_rx_done().
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

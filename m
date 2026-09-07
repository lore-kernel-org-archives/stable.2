Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1B3AC0C9;
	Mon,  7 Sep 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762684; cv=none; b=VyCOcONOkSxULmY1CPnkQyof3xsGjkySzXXPo4lyxDQVuf4O3JIIl+FFy+PCk3F5G+fNQT04Z4BEIoho8LaQGEWU6r/kvS0Bn9Nc4vvDSMzJVDaRVR2zkx6qrGOjKq1zCQO2pfr0bK5TSPhqLdKST+XZbGRzKnx1Q4WsQFZanAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762684; c=relaxed/simple;
	bh=yp8MmPjH3R9x5sDWZdHZKG8Cf/MP3TdFmmuG7mG56/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rK/jwaNWbYYJ4n8FysCb/3UEOIkEBAIAXaYcLb9JnPTS8r558+4Y03lgSj0Ax4qUrv2xiXgxgJ3RyC3uGV5+xfRFjZo1haMcPGocG6nf7NCvhcf5hJJsbZ7b36oevSY5+KAgODxErLyYXZ576J1KFHgHNnXEsyktpxM8dQMc5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZUwwBt68; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZUwwBt68"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 63C154E4149C;
	Mon,  7 Sep 2026 06:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 284AE60383;
	Mon,  7 Sep 2026 06:31:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A59611C79D5B;
	Mon,  7 Sep 2026 08:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788762671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yp8MmPjH3R9x5sDWZdHZKG8Cf/MP3TdFmmuG7mG56/I=;
	b=ZUwwBt68t/0d0NmookVUEIMgZYNO/0xrHsighyyC25OMHU7ijj8FHZFgBgNbfweY8VGuwO
	w4oshTFAwXHggBZUxqnu4UV2aLqpHgQrgb9jSXjZccjyJRp5ey3U6ei0uP1nLiCSqhXA3t
	1THFdVbE1ZQ426VJdKULNyve1u2BgOu7ewjs3ssRVr5xQDIbKQDQRwO3ZjtIVJ3OwEbEiD
	Cn9L0Hq/JKT1ZZwMoR/Eqg2Ao3pVlaacX58/Jn0n6qa8Ej4RyAa18S+TEM9TmmAyraxbEo
	SFRS+yxpeZIoJ1+oOeGXZIOOKXLOoRCEtb4B/2MPTILT2/E28LLDxvoCFRM8QQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  david.girault@qorvo.com,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  stable@vger.kernel.org,  Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] mac802154: avoid extra skb references in RX queues
In-Reply-To: <20260905061524.91223-1-xuanqiang.luo@linux.dev> (Xuanqiang Luo's
	message of "Sat, 5 Sep 2026 14:15:23 +0800")
References: <20260905061524.91223-1-xuanqiang.luo@linux.dev>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 08:30:58 +0200
Message-ID: <87mrtty3ml.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/09/2026 at 14:15:23 +08, Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> __ieee802154_rx_handle_packet() passes each cloned skb to
> ieee802154_subif_frame() and does not release it after the call. The
> callee consumes the skb on every path: it either frees it, hands it to
> the networking stack, or stores it in a queued RX descriptor.
>
> The beacon and MAC command paths nevertheless call skb_get() before
> storing the skb. The worker drops only that additional reference, leaving
> the original clone reference without an owner and leaking every queued
> skb.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

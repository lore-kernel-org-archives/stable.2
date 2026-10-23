Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770605;
	b=gRbA182iQ8V9DlRVHltvOsarlWo8vxPzsimOF2QOjBFsxQLo5tZOY1SFfTYJW7IoSehy
	 GCSQFBmM614scl44rM8mmXZs3WID7DPuZ51S7aBrceS//XR+VmFiryROUZZJ8PkMZ9mjS
	 gcXhyhO14bmv0WhQGrHPkTIwC9Do8S6VRfyHdw4mtAKxojrnm7RDRil65MSbr31TJ+X3w
	 +a2spOJlwIW5Imw+56rt/1zaT1XCjaPcpBVldQHYiv/ObXxk9mMYH1H/NMDlg9uwgwWZV
	 yIjhEhzrzoorozov6Sq0yR0cTdrbW6wdK4xogeVQs7vsfzIH7jeT/h61MJJr5IzAI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770605;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=XB/DqQbns0rhIYJzq9cYO4pOM2WNkAQGdTIX1QI/KCw=;
	b=fPXCxXcSce7IChLAvCXUQ8T+rlJ/sdf138eQ+6B3Cju6o/Cj0av8LFG7MNbtsoOP3zNd
	 BPCbdAQi1pkS8d8tqkDlP3JiA+AxX70BIWXQTfI44q4x85TKyTy9GGX9/VhQ2zAgvMMLY
	 777xKcIRXBqDEnIge9z07m90gtGhR8GjRKJXGNZgd2ZVFvLKkhXfzOioI1iXIAVP5ZvuR
	 041/NZ0CBzn2xr2u3ipZ+VqjciX/HjN6xGNMu6Fjz+CJlPDa7zRdK6YF2M0vlULqkfiv7
	 Lm32E/wpv6OCQf2uZkrCKxxZcmvTNob1hRoUdKvqSCSvvrxIIJHaumb/6D0hQ/RkLpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hlvcHbet;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A3606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6A3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hlvcHbet
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A06011A12F8;
	Fri, 23 Oct 2026 15:50:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7218160398;
	Fri, 23 Oct 2026 15:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E56E010329032;
	Fri, 23 Oct 2026 17:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792770595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XB/DqQbns0rhIYJzq9cYO4pOM2WNkAQGdTIX1QI/KCw=;
	b=hlvcHbeteCd7qBm2mggkskIW9OvJnVDIV8097eleolYeWs5IQtudp04on67RYahWoORzac
	004KcPlPG3nErF2QDHE+Lq2BIgsCTBmHbWhM/Yd21UL34dC2zdelmsuWtlA1or4UWIQiMX
	YR8Yak668C+EK9/sxIqCiYncOD007aLANwHtcEz0Yw7Lw0WFk1Au2r1LE+IF/Xn2wfivLE
	P6MiqXKTqzwjJslF7Xmb7CbxuWYhODCRtSOMO02ykuC3quR1CJwK/z6fG7NpEA604ZFxVQ
	qA65pRAg74QPsb5UPP7bxMTb7MK6J2s7iqvRrytSCRGfzL9QKOjJLXaXc1yU1Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Raul E Rangel <rrangel@chromium.org>,  Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Heikki Krogerus
 <heikki.krogerus@linux.intel.com>,  linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: calculate TX length before preparing
 DMA flow control
In-Reply-To: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
	(James Hilliard's message of "Fri, 23 Oct 2026 09:40:50 -0600")
References: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Oct 2026 17:49:52 +0200
Message-ID: <87mrs4o1r3.fsf@bootlin.com>
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

On 23/10/2026 at 09:40:50 -06, James Hilliard <james.hilliard1@gmail.com> wrote:

> The Renesas RZ/N1 preparation hook programs the UART DMA block size from
> dma->tx_size. The generic TX path calls that hook before calculating the
> length of the new transfer, so it programs zero on the first transfer and
> the previous length on subsequent transfers.
>
> Calculate the scatterlist length before calling the preparation hook so
> the UART flow controller and DMA descriptor use the same transfer size.
>
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

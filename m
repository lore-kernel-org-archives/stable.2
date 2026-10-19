Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437528;
	b=FBW2naLJWgIAKNlW2lsVVhNWgVVs8C9kQ+cwWMXlLMjVG2mKTHtjZ3pYzUzBvXiZUHpZ
	 RAKrbubLhdKQxhTwdx6uWqrZdNXqzX7vzB8K6ALaU+CDXWtmINh46UHUVehyD2C28EwQ8
	 6ith/dJHsko5/9caAPXkqlv+eQZGC/RdjzybCP+7uzfkX5qedq43W0fUWzbUmMuvvCpKB
	 qIAHs3geAwgcNQJYYPrGKXBR9CiLlR2iZdGaJ7pAyfRqP0TXtb7R7tVKWq1KzKJP6XuiL
	 ACLc8WmAVpnSRajpZMBRkjG01E0g2uBuSoOLaMWWQ9gVCkGtKCExfbU9hIScQW3jDCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437528;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w8JHp8xVnqgIU8zK0CuWukcaoSP5qbWa24oyA7HTlt8=;
	b=OMAfV/VhfN6EapxgsHvdN/mTGOpdF65hIwvW/eXcooHOKj8/xflTfO58awLSgJUq7K0G
	 RSh2bRfa4+S+szEUEKqAQPf/+yxt4KtagNoVkfwJAADbenG7GUAovPKhqf3rD6SlI3mTB
	 N3hqEUNzMgAvnovhJajPGAlkoofT76ndjTHgEzh4mNP4w/T+RTrT1tcacB4ITEWYbdNbR
	 Ny+c8/JeWuvARmikq6XBo+PSDaMlNmc4wCg5Nf6xN0x+Rknx5W66H3TBcGjOgiqrHmv7p
	 igpAUDRu8nksiprb2hLh51pbXOTzNd4Cvrd1Rss1o8mX2Fu0oiP9mBQGJpUU1kWgY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE71606A319;
	Mon, 19 Oct 2026 19:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE71606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Nerijus =?utf-8?B?QmVuZMW+acWrbmFz?= <nerijus.bendziunas@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "John W .
 Linville" <linville@tuxdriver.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Oleksij Rempel <linux@rempel-privat.de>, Kalle
 Valo <kvalo@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next v4 4/8] wifi: ath9k: stop a failed register
 read from opening the RX filter
In-Reply-To: <20260916173429.403889-5-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-5-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:18:44 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874iehwlbf.fsf@toke.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com> writes:

> On USB a register read is a WMI round trip and a timeout returns -1.
> The spectral trigger reads AR_RX_FILTER back, ORs in the PHY error
> bits and writes it, so a timed-out read stores 0xffffffff and the
> device forwards every frame and PHY error to the host.
>
> Add ath9k_hw_enable_rxfilter(), which sets the requested bits with
> REG_SET_BIT() instead of reading the register from the driver, and
> use it in the trigger. With firmware 1.4 and later the
> read-modify-write is done by the firmware; older firmware still reads
> from the host.
>
> Fixes: e93d083f42a1 ("ath9k: add spectral scan feature")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678118;
	b=Rrn0WCcXNCGRglPgEIwhsLw66611ThXxz9nVW0oFk5Uwp53PyxWOULWzzba3J+cJX1ST
	 RRhVuR6lUCqMWq+BaBULrCG4CsrgTuzr1vXb+Z82drv+N/8P1QZQon2jTIsdpk3CW8Pi3
	 kvc9cDnqQ8nZ3GM60D/ZF0tN00P/zqO71PZkQyKggAESLSKg4OIj93FU8wTrlTEVaUxIy
	 GeGZyr5VMvilumlIW+dMRG986giiNnAP6rWML+JJjP3iYlRCG+R+JVrPMHk71k1oiZX7a
	 /d4BEJp2g9Yd9jO/PbWEjcNV1Ccgbpvp/vk+uXM4hIZAZkgiTpYvQID0VW25m/CGAJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678118;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9er3puoTvMyRaWiL3gMCIc4iB91P1C4PLn8ZexfgLKY=;
	b=Gw8ZNtGGAr6KXCI4kVA/ZpZShyTMzhSZya31QVgM7ewaLoWfOf+2atG67lDAbw8s2g5N
	 4ij6syHOt2Qhpf1HfR0QudpdLA8jEosTFDewqKtVW+erhjIOc+9JX4oshDZ7hpz3xK3Yl
	 p6UvnAZOzc7EY8yEVSgjfTIVCU0KP5wiKhjeHX2itxZSY728x/u7FzCdgewU6H1zChuiu
	 YJw5+ZR0ohiNzE3ZselSopkjcxyUe/lSGb0FvbeULaeTSSZwY2HggPeVlhP9x+TMkZDon
	 NH/3fFGD7xSwHUFdc+ZX/N6gCqoEtXbXivWol7Ow/EWZ7mQNjKsPAMEmk9jrplEphbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862D606A31C;
	Thu, 26 Nov 2026 07:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6862D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id DD0AEC06DB;
	Thu, 26 Nov 2026 08:28:27 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: linux-wpan@vger.kernel.org,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	david.girault@qorvo.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net v1] mac802154: avoid extra skb references in RX queues
Date: Thu, 26 Nov 2026 08:28:15 +0100
Message-ID: <179567678219.1859476.7303574828087613735.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260905061524.91223-1-xuanqiang.luo@linux.dev>
References: <20260905061524.91223-1-xuanqiang.luo@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Xuanqiang Luo.

On Sat, 05 Sep 2026 14:15:23 +0800, Xuanqiang Luo wrote:
> __ieee802154_rx_handle_packet() passes each cloned skb to
> ieee802154_subif_frame() and does not release it after the call. The
> callee consumes the skb on every path: it either frees it, hands it to
> the networking stack, or stores it in a queued RX descriptor.
> 
> The beacon and MAC command paths nevertheless call skb_get() before
> storing the skb. The worker drops only that additional reference, leaving
> the original clone reference without an owner and leaking every queued
> skb.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: avoid extra skb references in RX queues
      https://git.kernel.org/wpan/wpan/c/6b4e5919526f

regards,
Stefan Schmidt

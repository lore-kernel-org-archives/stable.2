Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896144;
	b=yhNKX/YsB9fhbYrm1TzQGfUGCm3BmOhcTu6C5iI2q/mO8ioG0HTkkZo8f0YXL9YFFvSP
	 0iCG8Sy3Ng4Hrpj7JegK959AbmoBGJad2szVuZsNs+1Wx3Wyceym7UC6PdaHfe5DDMIdn
	 /+icJippBFFgsNTICSB8L8H/VqE35rXH8ezwoY6Abi8tNrH+wRVdaOaZuJLTNDdjwcKCF
	 NdB/txZp/k5jZd6UPibaVq5Jk/ay8lBoZ0aOLbVPv5RYWXVQMKK8oiCZ1C07xR5sLLGSX
	 ad+DrM5dtsggYvWi/+rhAZ6conm1vLzutD8ICWJynzfwrEnBBHoaFkqeynZYd5vaFlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896144;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=vWoDjOBeo1hAWyxzYdw2qtx/GzU6IPF2wlEpRRXvwRY=;
	b=sds+ZVuT8lFZob+/uGnBZ0VilwWZ9YdyriuK5es6LH2HIxGDatHWeB/Ao3WNmxh6pGfq
	 mkIdFwbTxQVYG1QaRPNOWfxmvlSeGpYm20tce7Q/udDsBxX6TFYNq+Ek0fs6gtsEHKZJK
	 cFNKCBRsCuhAZPTdXFTxJExTPeaq1WIvsKOF1vryS6jkSAhQ93HJ6spwAY0bnsiG8kkJJ
	 F/CvR2C21GD1ygHFx8MszgwmFo664HTuQ6H+eZnDtd0uNa9wfZ5uMm8jk+rPrWckEDE/s
	 Weg/qlhOiunvdet4qQz6lKxCHh8tWmdP0PtKuuaqsVggXuPkXXyAGOnAOSNXsAp8LGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=rx4JcEvb;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21721606A31C;
	Tue, 17 Nov 2026 06:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21721606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=rx4JcEvb
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AH6FDGV04175949, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794896113; bh=vWoDjOBeo1hAWyxzYdw2qtx/GzU6IPF2wlEpRRXvwRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rx4JcEvbTzz1+caKLOAoxA7HkTAjyDgPMiTiqjJYO02YW+KtPfyQLKz0yIg5SJv6e
	 tbIUjTb6SOXyT6dyTJukQvVxMNtzgZ5iSqdstzpH9FcIOcNFmvOxd7wbqx78qWgdAz
	 8inVeUXcVxZDY0ixClkKrfaE2z1eoCi4XSX02UMLXley8CYkLXDeUI2+FLNevJX1fD
	 Zxm+E6NZpkTDZbMXcuQcxR6KDIRI6upAuBdDCJFLS8toFsA0Pj6k5mcwJzH/wUwuZl
	 w9BB+iA9RJf9J0kIZ3GCSvkXnwTSJUcx9Ne5iSV9mErxQTkNgHuIp3Ok+iYlvqBjhh
	 A1v5aFNL6qdOA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AH6FDGV04175949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 14:15:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 14:15:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Tue, 17 Nov 2026 14:15:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v10 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Topic: [PATCH rtw-next v10 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Index: AQHdc0hRmL5VjdzwlUqF6WpiTM7N/7cxzhuw
Date: Tue, 17 Nov 2026 06:15:13 +0000
Message-ID: <74ed5d7ad4b04a2591ae0071cc8280ab@realtek.com>
References: <20261113082242.2773369-1-alastair@d-silva.org>
 <20261113082242.2773369-3-alastair@d-silva.org>
In-Reply-To: <20261113082242.2773369-3-alastair@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Alastair D'Silva <alastair@d-silva.org> wrote:
> When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
> delayed TX work may still run against a powered-down device.
>=20
> Track the operational state in rtwsdio->running with an irq_lock mutex
> (similar to PCI), check it at the entry of rtw_sdio_handle_interrupt()
> and rtw_sdio_tx_handler(), serialize state transitions in rtw_sdio_start(=
)
> and rtw_sdio_stop() under sdio_claim_host() and irq_lock, and cancel the
> TX worker synchronously in rtw_sdio_stop().
>=20
> Drain rtwsdio->tx_queue[] with locked skb_dequeue() and
> ieee80211_free_txskb() in rtw_sdio_stop() and again in rtw_sdio_start() t=
o
> catch any frames queued by an in-flight rtwdev->tx_work after
> rtw_sdio_stop() completes, and reset rtwsdio->tx_queue_stopped[] while
> waking stopped AC queues under tx_queue[].lock in rtw_sdio_start().
>=20
> Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry o=
n page starvation")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

No need Assisted-by tag now.

> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Take my acked-by to v11 with small nit below.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

>  static int rtw_sdio_start(struct rtw_dev *rtwdev)
>  {
> +       struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> +       enum rtw_tx_queue_type queue;
>         u32 clear;
> +       int i;
>=20
>         if (rtw_is_8723bs(rtwdev)) {
>                 int ret =3D rtw_sdio_8723bs_check_rqpn(rtwdev);
> @@ -1069,20 +1086,49 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
>=20
>         rtw_sdio_enable_rx_aggregation(rtwdev);
>=20
> +       rtw_sdio_purge_tx_queues(rtwdev);
> +
> +       for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
> +               queue =3D rtw_tx_ac_to_hwq(i);
> +               scoped_guard(spinlock_irqsave, &rtwsdio->tx_queue[queue].=
lock) {
> +                       if (rtwsdio->tx_queue_stopped[queue]) {
> +                               rtwsdio->tx_queue_stopped[queue] =3D fals=
e;
> +                               ieee80211_wake_queue(rtwdev->hw, i);
> +                       }
> +               }
> +       }

Create a function to reset TX queues state.=20

In rtw_sdio_start(), this is a cleanup operation, but it takes up too much =
space
(blurring the focus).

> +
> +       sdio_claim_host(rtwsdio->sdio_func);
> +

[...]



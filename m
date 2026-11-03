Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674993;
	b=tH4WW5pjjaqfrapOInSs9ZUE7OYe6oI3rZlnLb1odWh4Rh/w709eAYdm3uc8awdKjEjL
	 hrHvqySq0P3b1r79EKERDPG7t+Uq6Qnmz98S615tszh17gWuweqSCGoqp8W7UXTbbY6LB
	 CSeBKu02C6qY9NlsTryqHtvRuTvndVBJcfpPETLYoe5Hq0M3B2uQjKvHZenVQxrJ62IKd
	 6b1snO3pHWqMWFGa9HEg3fwWnd+yNPo0N1JXudXG+o2laiMNfSxls1itzKxO5XJbo0Hgi
	 JUILVyIK4w9R8uqhejsqQZu7vvgJoX0AqAxyuz7lxnDFpGGhw8K0SFwEwUb4DR7sU1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674993;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	bh=oCrt+/j4hdeOK45YwUt4sEBeoooxnL1Gvg4diMjrU0M=;
	b=5mM32OsLyvYkZmmnmBxtjkvN9qawPRgBSE9ecBQkvprfPofYQhYsbFuyjPuJASbhoe7f
	 Uz1m1vbBg5wbbF18gAzlsI9yXPg6F8Zwn57BlXjb9XLaygVxuO1+DbHXHOPvQDdQZXbCw
	 CUoJy1vF5ag9mwmV03vx70Q8vjPKGGsoAd7ARF+xNb3UBaFcrq+NXp5M/g8/P1oIdXZ1L
	 18jvuPLUKmdcQSgMq5I6vK+t4jP9YYQqbPbfPRFUoTqut2R0yRIObSN2Y9XmbxElBjwX6
	 HhB4nDwHQIixK7YIl+ysoJ5omvbHCZMfXbitSepoM1XtbT+EjhD6YSYL+kCNLkTmFGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=lslxYma8;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31464606D812;
	Tue,  3 Nov 2026 03:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31464606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=lslxYma8
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A332rArA2688820, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793674973; bh=oCrt+/j4hdeOK45YwUt4sEBeoooxnL1Gvg4diMjrU0M=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=lslxYma84pbsN7RGk22fDtWY4A184oQMrfkyHe9Ck8zUQ0dXM1evljPGTX2sUlrp2
	 Aqaaigu3oD3qY/8s38i0ryAFx9f78lReHgIPcMzCZW50cgMgP86a7oLYWtC8eLI4Bx
	 JFbHCyoGu3lNEnHXOd3cYlkx1EW0W42fKoDKYthZVva5qzc2xVb9p35wXCdFTRcn1b
	 2w6mJuxxieLpQYmS1OPmuCtVgexFU2ddD0djKsEsRJimBoNh2XdnLGfJiT+h8Yz37b
	 8q4iQPr3SRhSvIy0M6uEPl6dJqWm7HvbmvvFZHuPk/zaEPVH79b1pJaSnXsHefagrf
	 oxlsRuNsKNCUQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A332rArA2688820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:02:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:01:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 11:01:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>, Ping-Ke Shih <pkshih@realtek.com>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
In-Reply-To: <20261009123022.87787-1-luka.gejak@linux.dev>
References: <20261009123022.87787-1-luka.gejak@linux.dev>
Message-ID: <534c767d-c243-4916-80e9-3ce5f8424476@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 3 Nov 2026 11:01:54 +0800
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

Luka Gejak <luka.gejak@linux.dev> wrote:

> rtw_sdio_rxfifo_recv() also takes the last-entry path when the descriptor
> claims more data than rx_len. The skb is then passed to rtw_sdio_rx_skb(),
> which calls skb_put() with pkt_len and does not check it against the space
> left, so a bad descriptor can overflow the skb.
> 
> Reject the packet when pkt_offset + pkt_len exceeds the bytes left.
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

83ca360e8528 wifi: rtw88: sdio: reject oversized RX packets

---
https://github.com/pkshih/rtw.git


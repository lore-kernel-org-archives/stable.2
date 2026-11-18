Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967165;
	b=yYI3xEnPs7RW4ZarxL1zR6Y3OFu7aGGwoL0PHn+4QN6azH4lZA7LnLEpot+zh35p7gXp
	 FxPLrkVsXE3F01hkjya5EAahbhUk/QmAJA4mPXTObvpMpzcJa/eRirMICLEDf8Oyykb5G
	 JW0hvFIalaKJCecs1Jvndwnxe4t8EoabeNzTEe4h0qt9kElvHw/HPWJZ9nMUZ00Y2JlVL
	 LSx9NdNHO6ftM+CGWizyOIS2awBkm6JaGyFnnug90omrzXzkj3x5bGfANlxYBRAf8rvRr
	 AxtwJRJlD6Gjki7dt6NXlaqdsEsccZsJ3q50DhhJRIXjt/nxIQOGhKryrBe5QW/ijNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967165;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	bh=XJQJo2wE0lk+4HgZW9J60rvYloBz0R9Np939LBvZbbk=;
	b=ASaytwRJtGSk6mOw2U7nrxD1JfTMvehH5TxUCaPxJ0IL/1xbB7OmY7kCB+p1dEBhZzUL
	 ghK6PyiOBxROUMMqId8oqIQgF/4RtZkojJFS/A2IJalZQDSg3vbJ6lbLKdUC/+IPQyGHO
	 HnxJbkVJ+q9kJHEQu0UGMqO/3cFJWK4+olQ6mOa9bpyxLViM3GRiIW2PaKqk+Q/hSiggv
	 F9z85i20RKW9LGn9AZ5N/zeSZpzWPHH+uEtVSENCFqTmVWkTzOzfIWYlKA8yNR6UmZXzv
	 r5kOBk03Fx6090h6tqpBuq3H0EbSFgGcWOo1o3nipwkPSGZBDa6liC3NfqnQY6VMXpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=XQ87ZR4i;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BA606A32C;
	Wed, 18 Nov 2026 01:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31BA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=XQ87ZR4i
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AI1wxMrB859233, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794967139; bh=XJQJo2wE0lk+4HgZW9J60rvYloBz0R9Np939LBvZbbk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=XQ87ZR4iQ313Na2oPGkiQCFjprtL3tXb+2L37H24T553cLdCuWDyPcG8hYG5m9aYy
	 BEPNwYdbgKMDmxBDcyXZbvBoB/Bu+LObOW51X53hgdDzoLEME52+Q93/OZo1N11gx0
	 Is6jRut73tv1ld+muO/s7LacKs0nJ42jhzDFSMI5IZbSsAGiddCtSFHWsW+Ahsaqx9
	 TQig1pSwHd3FOxPrIbaxMdVg3BxSBgtj8nayUxV3li+rKAa9nc237lhBMxJ6Hvvxe4
	 ggYp0Q7/a2Z39oV8/+MqZh+IZivn4eEz5Xtry+YK0aZyqey/zWCU4IRM/EJEv2mxRC
	 vBs/QxCpb0c/Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AI1wxMrB859233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 09:58:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 09:58:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 09:58:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, <linux-wireless@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-kernel@vger.kernel.org>, Alastair D'Silva <alastair@d-silva.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v11 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
In-Reply-To: <20261117101347.2157211-2-alastair@d-silva.org>
References: <20261117101347.2157211-1-alastair@d-silva.org> <20261117101347.2157211-2-alastair@d-silva.org>
Message-ID: <70dc30d9-a615-4a0a-9ee6-228d079c1bf5@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 18 Nov 2026 09:58:53 +0800
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

Alastair D'Silva <alastair@d-silva.org> wrote:

> When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv()
> returns without reading data. Because it returned void, the caller still
> counted rx_len against the loop budget while leaving data stranded in the
> FIFO.
> 
> Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
> of the receive loop in the caller immediately.
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Cc: stable@vger.kernel.org
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

2fc87b00daf2 wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
07eb79021ca5 wifi: rtw88: sdio: Track running state and cancel TX worker on stop
a468dc94161a wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
6f51fced1eaf wifi: rtw88: sdio: Split rtw_sdio_rx_isr into 8051 and 3081 variants

---
https://github.com/pkshih/rtw.git


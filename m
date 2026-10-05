Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8E2BE043;
	Mon,  5 Oct 2026 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171369; cv=none; b=cJSBy9sHjalkoD14jnbYksSYwkit3X2Ty3aoz3BAt9OAASGEbkbqdZgS/1PriPtPmNEUgVWVkmtppEL3dOM7Cv0awYISrhYNx2+hOq36c4cNfUVLddQ3IXacpvE2KDPXQRCIp3zuq69qvbDNbkUWOp1A/nvu4JzZM5bnavVXDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171369; c=relaxed/simple;
	bh=rme8jXLowIGdM8K6IgVLFr25KrUCZ5+SdJYzzGtlgbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=reH4JJj6yeQDH0tT1e623KKb5tMZe6UFS//GUdUapnXH0USXyvo4cLDKcukD0Q3lM1jYPNKvT5mB1rPznMtin1RPxfrD24Im3KT7JSVQeGndaGEIYM96x+EtMM+yphP8WcncYHvsfWyw08Dc2RcvprA1C0v3DtZ7S2/R3XIg04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EE26bpxo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EE26bpxo"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6953ZVDf81612921, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791171331; bh=f7JHFfvzSLfAXN38tfCvg+N/T9DNPl+r7sSgdZrOJn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EE26bpxo7aysjxul4re6DRAD1V06dCXbljZdG2DsOKqOFlG1GldqcJgtfC9X7WnsH
	 K+tcCI+3jvBfUfi0OgswfUZKBYMytvPlKkekngO2UL/v0XGsCf0n+HCz+n1bH1x6+D
	 n5M6alfVmwG0trqkMUuTIDHLvP6RIfSDL8+39xcB7wnv1wStn7WDa6bH2pO83Kk8vJ
	 qZe0CejGScrOvOm+WBgtW/Bv9cqhvq1Fn4MMHCgRhjJ95o25v3qcaOPBdm6hq7AjNl
	 Au+NSuZUF+pZgn/dPPxnBBhg0wo4Ca8MLhBAEcc/FNi7Qq+ZgnfORnCQkH7+LqlXgT
	 Gf7ef0fGcFd9A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6953ZVDf81612921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Oct 2026 11:35:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:35:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:35:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 5 Oct 2026 11:35:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Topic: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Index: AQHdUThjHehNiw0xlkuYT1bxT/PheLbuUbcg
Date: Mon, 5 Oct 2026 03:35:31 +0000
Message-ID: <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
 <20261001000303.3505264-2-alastair@d-silva.org>
In-Reply-To: <20261001000303.3505264-2-alastair@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Alastair D'Silva <alastair@d-silva.org> wrote:
> 8051 and 3081 SDIO chipsets handle the REG_SDIO_HISR_RX_REQUEST status bi=
t
> differently:
>=20
> - 8051-based chips (e.g. RTL8723BS, RTL8723CS, RTL8723DS):
>   The hardware automatically clears REG_SDIO_HISR_RX_REQUEST once the RX
>   buffer is empty. Software must not clear this bit, because the drain
>   loop in rtw_sdio_rx_isr() re-reads REG_SDIO_HISR across iterations to
>   decide whether more requests are pending. Clearing it in software
>   terminates the loop after a single request, stranding the remainder of
>   the FIFO. Additionally, RTL8723BS requires RTW_SDIO_HISR_CLEAR_MASK to
>   avoid undefined bits causing resume storms.
>=20
> - 3081-based chips (e.g. RTL8821CS, RTL8822CS):
>   The hardware does not automatically clear REG_SDIO_HISR_RX_REQUEST when
>   the RX buffer is empty. Masking this bit out in software before writing
>   back to HISR prevented it from ever being acknowledged in hardware,
>   trapping the CPU core in an infinite interrupt storm loop that starved
>   RCU and locked up the system. Furthermore, on 3081 chips the physical
>   RX FIFO capacity is at most 24 KB (16 KB on RTL8821CS, 24 KB on
>   RTL8822CS), which is well within the 64 KB loop budget.
>=20
> As the number of architecture-specific special cases has grown (16-bit vs
> 32-bit register widths, differing HISR writeback timing, synthetic loop
> flags, and RTL8723BS resume masking), attempting to accommodate both
> architectures within a single monolithic handler has become fragile and
> prone to cross-architecture regressions.
>=20
> Resolve this by making rtw_sdio_handle_interrupt() a dispatcher with
> separate paths for 8051 and 3081:
>=20
> 1. 8051 chips preserve the existing unmasked writeback behavior, leaving
>    REG_SDIO_HISR_RX_REQUEST for hardware to drop and respecting
>    RTW_SDIO_HISR_CLEAR_MASK on RTL8723BS.
> 2. 3081 chips adopt the interrupt masking pattern: disable HIMR,
>    acknowledge pending status bits in HISR via W1C, service the pending
>    events, and re-enable HIMR. Any packet arriving during servicing
>    latches REG_SDIO_HISR_RX_REQUEST in hardware and re-asserts the IRQ li=
ne
>    once unmasked.
>=20
> Splitting into separate handlers isolates these quirks cleanly and
> simplifies future maintenance.
>=20
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")

At this moment, did it support 3081-seris already?
I feel this tag is too serious.=20

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>




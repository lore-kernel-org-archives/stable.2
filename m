Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548554AB3BF;
	Thu, 17 Sep 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636213; cv=none; b=B/o8tfGNoJhSWNJkf/66i946jv/ztEt/ziW3e5E+rBS9iBdkfviiB/p4hBjiUTP1hBu1ugHf3wP0My8s8WE5Lf8BUAvi+EKVQ6Dy+DJoW03m8H4PHVDWpQ+VCVoHTmE/1k8FOzteBfNjrKmUhf/DW7BtZlHI3K2QiczfgSbPFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636213; c=relaxed/simple;
	bh=VR5R/ckONE5WIHaDtjgVkmaC0BRZAQRLZd5mpaDxOTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzXNz6xJ6SZzweaanOlvE345R0DIlvUH4ZpqAD4aYaMjLKSupMXKF6SsCaJOp03ff4Em9q8UT6inRbVwKYk5gjhn3y0cufAoAYU3Vr23Mq7deeEw1w9SmVK9y61bmw3ZIpby5qk7zy/1Lv/8kBYs8oaS9TFJjX5tv8pb1r5Ffxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bQk50RsD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bQk50RsD"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68H99gE123147515, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789636183; bh=VR5R/ckONE5WIHaDtjgVkmaC0BRZAQRLZd5mpaDxOTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bQk50RsDXK/Le8txZ13Un8Uj/+6vd/vmD9TBcY1gLMw6ImeK/1eoSyJCPZyYoMQxZ
	 OH+1ozRfLi+FNybZRzqb839lGlAnivLjrJt/UoszBopmZ+g2vB5k/MZOvzgsekbc7G
	 YrgAyro8IyaPn6m0EuD6TgSM+pwaZDyA/6Pes0BydJ0EbqPe269ZJ3N7GlcW15DFSv
	 b2mYDoFCzKj/3LldShtT63J1U+13xK0Emyf4A2j2uYio+GTbHlLF0xLc30zO28bw23
	 OjwWIITSYbNTLyrn2LhJds//vz1ZiaKecw7jjMao+e3EEcWo4St1Y55rlvBtp91q5A
	 WrZC54Gnv6OJQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68H99gE123147515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 17:09:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 17:09:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 17:09:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 17 Sep 2026 17:09:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, Kalle Valo <kvalo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Topic: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Index: AQHdRZjHlTD58hEpHEaBWkK5Af0sf7bSYOjAgAAXxcA=
Date: Thu, 17 Sep 2026 09:09:42 +0000
Message-ID: <58a857e3b0614e2b9a520024b9932685@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
 <ea3434d849b34a4286b0a193351a610e@realtek.com>
In-Reply-To: <ea3434d849b34a4286b0a193351a610e@realtek.com>
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

Ping-Ke Shih wrote:
>=20
> Hi Martin,
>=20
> Alastair D'Silva <alastair@d-silva.org> wrote:
> > In rtw_sdio_handle_interrupt(), the HISR status register is cleared usi=
ng
> > Write-1-to-Clear (W1C) semantics. However, the driver masks out the
> > REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before writin=
g
> > it back, causing a 0 to be written to that bit.
>=20
> I feel this patch makes sense.
>=20
> Did you remember why you clear the bit locally? Can you share vendor
> driver you referenced?
>=20

I asked internal expert who said this bit will be cleared automatically
if all packets in RX buffer are received. If we clear this bit here,
the interrupt will not raise again if no newly incoming packet even
there are remaining packets in RX buffer.=20

Checking rtw_sdio_rx_isr(), we can see it reads hisr for each iteration,
which this is also the evidence that the bit will be cleared automatically.

Therefore, we need to dig further why the RX buffer can't be empty
and get stuck.=20

Ping-Ke



Received: from mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616822083
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175201; cv=none; b=oAMhbj4TGXCyUlODjtpFbWn2OGtjHZAMUbzxxsQ8V2m3I+Qc3QNEzarx5rQmyEX6/AeGOe11+Q95SEhkoHZZxImTZM7FjEHIpyqiAeH+gU/VZkz9rfTGFs6vbhv5a6tPn73VwcKq2wZqDOSa1SeaulKc5+uyJ44dVi224vvtzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175201; c=relaxed/simple;
	bh=lcftc0xj9lMKoVImH9pwEX76uF/NZ9v9EpX2kIMVyCo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=GnygZM+Kmw+oVH6Nmjd2bDOy4Ts0Gjg+RZVjw7cZW4wVXlD/jkoRLJR2Qqy7TaC2j882QtqS44LgdUW0HowDkYzxNOgPEfgnifWKhnme0qKVOrT9dIEmWLBNIpmRbAPOMaYfbSxfqU0933V/ehZcpwM6uRRU74C1QwU1CtL1du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDBlfAJD; arc=none smtp.client-ip=91.218.175.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDBlfAJD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lcftc0xj9lMKoVImH9pwEX76uF/NZ9v9EpX2kIMVyCo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791175196; v=1; x=1791779996;
 b=dDBlfAJDLdSdvNaEi6BqHRC3YUnkFXifSr8rq8tcee5jI7OfxoWX6zlUYdkMRRfHwni/JpaO
 8MH5RwMYwDjk98ZwnYjAfgfQ1qp1NKGNGVodNJ4vSW3Dg6J//9/0Yioy7tYlEXMOulNxwpaDME3
 N6nRmnoDysuGT2l2rqzooBnA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81e8c01bc103a4b5;
	Mon, 05 Oct 2026 04:39:56 +0000
X-Mizu-Trace-ID: 81e8c01bc103a4b5
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 04:39:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <6ef33599cc268fa12e4663461248f1700969df34@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
To: "Ping-Ke Shih" <pkshih@realtek.com>, "Alastair D'Silva"
 <alastair@d-silva.org>, linux-wireless@vger.kernel.org
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Ulf Hansson"
 <ulfh@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Kalle
 Valo" <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, luka.gejak@linux.dev
In-Reply-To: <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
 <20261001000303.3505264-2-alastair@d-silva.org>
 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>

October 5, 2026 at 05:35, "Ping-Ke Shih" <pkshih@realtek.com mailto:pkshi=
h@realtek.com?to=3D%22Ping-Ke%20Shih%22%20%3Cpkshih%40realtek.com%3E > wr=
ote:


>=20
>=20Alastair D'Silva <alastair@d-silva.org> wrote:
>=20
>=20>=20
>=20> 8051 and 3081 SDIO chipsets handle the REG_SDIO_HISR_RX_REQUEST sta=
tus bit
> >  differently:
> >=20=20
>=20>  - 8051-based chips (e.g. RTL8723BS, RTL8723CS, RTL8723DS):
> >  The hardware automatically clears REG_SDIO_HISR_RX_REQUEST once the =
RX
> >  buffer is empty. Software must not clear this bit, because the drain
> >  loop in rtw_sdio_rx_isr() re-reads REG_SDIO_HISR across iterations t=
o
> >  decide whether more requests are pending. Clearing it in software
> >  terminates the loop after a single request, stranding the remainder =
of
> >  the FIFO. Additionally, RTL8723BS requires RTW_SDIO_HISR_CLEAR_MASK =
to
> >  avoid undefined bits causing resume storms.
> >=20=20
>=20>  - 3081-based chips (e.g. RTL8821CS, RTL8822CS):
> >  The hardware does not automatically clear REG_SDIO_HISR_RX_REQUEST w=
hen
> >  the RX buffer is empty. Masking this bit out in software before writ=
ing
> >  back to HISR prevented it from ever being acknowledged in hardware,
> >  trapping the CPU core in an infinite interrupt storm loop that starv=
ed
> >  RCU and locked up the system. Furthermore, on 3081 chips the physica=
l
> >  RX FIFO capacity is at most 24 KB (16 KB on RTL8821CS, 24 KB on
> >  RTL8822CS), which is well within the 64 KB loop budget.
> >=20=20
>=20>  As the number of architecture-specific special cases has grown (16=
-bit vs
> >  32-bit register widths, differing HISR writeback timing, synthetic l=
oop
> >  flags, and RTL8723BS resume masking), attempting to accommodate both
> >  architectures within a single monolithic handler has become fragile =
and
> >  prone to cross-architecture regressions.
> >=20=20
>=20>  Resolve this by making rtw_sdio_handle_interrupt() a dispatcher wi=
th
> >  separate paths for 8051 and 3081:
> >=20=20
>=20>  1. 8051 chips preserve the existing unmasked writeback behavior, l=
eaving
> >  REG_SDIO_HISR_RX_REQUEST for hardware to drop and respecting
> >  RTW_SDIO_HISR_CLEAR_MASK on RTL8723BS.
> >  2. 3081 chips adopt the interrupt masking pattern: disable HIMR,
> >  acknowledge pending status bits in HISR via W1C, service the pending
> >  events, and re-enable HIMR. Any packet arriving during servicing
> >  latches REG_SDIO_HISR_RX_REQUEST in hardware and re-asserts the IRQ =
line
> >  once unmasked.
> >=20=20
>=20>  Splitting into separate handlers isolates these quirks cleanly and
> >  simplifies future maintenance.
> >=20=20
>=20>  Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation fo=
r SDIO based chipsets")
> >=20
>=20At this moment, did it support 3081-seris already?
> I feel this tag is too serious.=20
>=20
> >=20
>=20> Cc: stable@vger.kernel.org
> >  Assisted-by: LLM
> >  Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> >=20
>=20Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>

Hi Ping-Ke,
I think you missed my review at [1].

Best regards,
Luka Gejak

[1]:https://lore.kernel.org/all/20261001060213.24759-1-luka.gejak@linux.d=
ev/

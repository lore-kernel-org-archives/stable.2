Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7935C185;
	Mon,  5 Oct 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188456; cv=none; b=peb1Ej9ZQVusv3qoX9SDrpdCleyxZ0PRksIbeGZHNh2eDvLNdIq3TUkVBWE9AQjoz/Blk6+bEa11enYkU3lWqunwWzd7OAquduNwMsDwzAxqAF2qxcxxglyxPYXLrm11dWYUfcJZ2zYW1cavtfPYXn0ZNf25xyWdwszK/lfGsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188456; c=relaxed/simple;
	bh=fA0Y3qxufq1MW/zwb/eczKYFzXaz5Vgncte0e1IO4B4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rx6oIZMThS+21VdSoaUSgqpceYBtzSvW3RiE1eF+DLxjXUDtD7HZBzWKoLr1Hg9YS0G1nrZGmJ/Cb47pHG71y2dhh+t7zkF2N2PHDxStYuUxQqO/0A/TR+BNDKWSKDaOS6aYV1HAifUqJE1SqpEVAp67oIyzyO8zlQkklaRRLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=MAqv9q9d; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="MAqv9q9d"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id EFE77405F6;
	Mon,  5 Oct 2026 19:20:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791188444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fA0Y3qxufq1MW/zwb/eczKYFzXaz5Vgncte0e1IO4B4=;
	b=MAqv9q9dANTorVVaw3n3K4vorgqdbDO7t7IvBWbha7F8qEM7feseQb/R76giUr6MYFn+JQ
	TRJRDai9zHyXOmW9KmYngkUYYjfgLcZzNKUflF7fZQtSOFIScJfUyGlqQV4eYWd0f5p3sz
	UuVah7U8g7K5MD/g7Vb4gi+PDS7/Psp5XI1G2iMYYEjVGl7wt15WibVm6iU8nZQj7zGnO6
	VPrKXokuBXzeBycxmYkyvmIdN0ig0NnJ7DTnCxNUe4AQLWYJhU0phfAciuDjYz1LmjOGW6
	cC1puA434YYeE3KeFlJWSozj4nUVbpeF592w5SkAt6mtiFhBe+yCldl/PO9BWQ==
X-GPT-Reason: legitimate; This is a technical, professional correspondence
	regarding Linux kernel development (specifically a WiFi driver
	patch) that perfectly aligns with the sender's domain (alastair@d-silva.org)
	and the technical nature of the content; The email contains detailed
	code logic, commit hashes (e.g., 65371a3f14e7), and architecture-specific
	hardware discussions (8051 vs. 3081 chipsets) which are consistent
	with open-source software development; There are no indicators
	of spam, such as urgency, marketing, or suspicious links, and the
	"Reply-To" and "From" domains match perfectly.
Message-ID: <50d48391aef50cbc4c7f9292f7467b8be17b4ec1.camel@d-silva.org>
Subject: Re: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	 <ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	 <kvalo@kernel.org>, Luka Gejak <luka.gejak@linux.dev>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Mon, 05 Oct 2026 19:20:43 +1100
In-Reply-To: <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
	 <20261001000303.3505264-2-alastair@d-silva.org>
	 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Mon, 2026-10-05 at 03:35 +0000, Ping-Ke Shih wrote:
> Alastair D'Silva <alastair@d-silva.org> wrote:
> > 8051 and 3081 SDIO chipsets handle the REG_SDIO_HISR_RX_REQUEST status =
bit
> > differently:
> >=20
> > - 8051-based chips (e.g. RTL8723BS, RTL8723CS, RTL8723DS):
> > =C2=A0 The hardware automatically clears REG_SDIO_HISR_RX_REQUEST once =
the RX
> > =C2=A0 buffer is empty. Software must not clear this bit, because the d=
rain
> > =C2=A0 loop in rtw_sdio_rx_isr() re-reads REG_SDIO_HISR across iteratio=
ns to
> > =C2=A0 decide whether more requests are pending. Clearing it in softwar=
e
> > =C2=A0 terminates the loop after a single request, stranding the remain=
der of
> > =C2=A0 the FIFO. Additionally, RTL8723BS requires RTW_SDIO_HISR_CLEAR_M=
ASK to
> > =C2=A0 avoid undefined bits causing resume storms.
> >=20
> > - 3081-based chips (e.g. RTL8821CS, RTL8822CS):
> > =C2=A0 The hardware does not automatically clear REG_SDIO_HISR_RX_REQUE=
ST when
> > =C2=A0 the RX buffer is empty. Masking this bit out in software before =
writing
> > =C2=A0 back to HISR prevented it from ever being acknowledged in hardwa=
re,
> > =C2=A0 trapping the CPU core in an infinite interrupt storm loop that s=
tarved
> > =C2=A0 RCU and locked up the system. Furthermore, on 3081 chips the phy=
sical
> > =C2=A0 RX FIFO capacity is at most 24 KB (16 KB on RTL8821CS, 24 KB on
> > =C2=A0 RTL8822CS), which is well within the 64 KB loop budget.
> >=20
> > As the number of architecture-specific special cases has grown (16-bit =
vs
> > 32-bit register widths, differing HISR writeback timing, synthetic loop
> > flags, and RTL8723BS resume masking), attempting to accommodate both
> > architectures within a single monolithic handler has become fragile and
> > prone to cross-architecture regressions.
> >=20
> > Resolve this by making rtw_sdio_handle_interrupt() a dispatcher with
> > separate paths for 8051 and 3081:
> >=20
> > 1. 8051 chips preserve the existing unmasked writeback behavior, leavin=
g
> > =C2=A0=C2=A0 REG_SDIO_HISR_RX_REQUEST for hardware to drop and respecti=
ng
> > =C2=A0=C2=A0 RTW_SDIO_HISR_CLEAR_MASK on RTL8723BS.
> > 2. 3081 chips adopt the interrupt masking pattern: disable HIMR,
> > =C2=A0=C2=A0 acknowledge pending status bits in HISR via W1C, service t=
he pending
> > =C2=A0=C2=A0 events, and re-enable HIMR. Any packet arriving during ser=
vicing
> > =C2=A0=C2=A0 latches REG_SDIO_HISR_RX_REQUEST in hardware and re-assert=
s the IRQ line
> > =C2=A0=C2=A0 once unmasked.
> >=20
> > Splitting into separate handlers isolates these quirks cleanly and
> > simplifies future maintenance.
> >=20
> > Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDI=
O based chipsets")
>=20
> At this moment, did it support 3081-seris already?
> I feel this tag is too serious.=20
>=20

Yes, 3081 chipsets were actually the original devices enabled in that initi=
al SDIO series.

In commit 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO=
 based chipsets"), the
SDIO HCI was introduced along with hisr &=3D ~REG_SDIO_HISR_RX_REQUEST;. La=
ter in that exact same 10-
patch series (merged into v6.4-rc1), the following SDIO devices were added:

Commit 095e62dd7427: RTL8822BS (3081)
Commit 6fdacb78f799: RTL8822CS (3081)
Commit b2a777d68434: RTL8821CS (3081)

No 8051 SDIO chipsets existed in rtw88 at that time (RTL8723DS was added in=
 v6.5, and RTL8723BS much
later).

That said, if you prefer attributing the regression to the device enablemen=
t commit rather than the
core SDIO HCI commit, we can change the tag to: Fixes: b2a777d68434 ("wifi:=
 rtw88: Add support for
the SDIO based RTL8821CS chipset")

Both commits landed in v6.4-rc1, so the stable tree targeting remains ident=
ical. Please let us know
your preference.

--=20
Alastair D'Silva

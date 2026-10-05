Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6383672BD;
	Mon,  5 Oct 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182657; cv=none; b=OI3M/EzlwlcUvOMT5bpbXhlograKBSHCuqftcYaiu7h7DTGbjwCdwhwJirQ5JfQudkzqzGlyfYVSlf/PydBSYBYAbpedysAq5k86yyXmaV01fv8y/ae/IRqAIA8G2cePfQ+sJiovQQ0jqyJm9ukqZiQDNd1DZtzkKvqgZonnUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182657; c=relaxed/simple;
	bh=0C64j6HQ6CPxdkVlJPvHgxrtdmU6wkRgZfmlqpJ9xcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+TcvOHDpLqaYWZ0Mm94Sdem2Y4Xd6f1pWBB9yydZ3+V06rYPP6n8ls8WO1KGrxzYIBzylNQNH5n6OYXwSqZos33NxoJEsVqd+CgyzIhYiqCTFdyOplEYy1rUOm2cu7GxWZm0a8owRHJIsSREl8fSWnDtT8tAiRzjW24gCsaiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=ni7U9CmF; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="ni7U9CmF"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 32887405F6;
	Mon,  5 Oct 2026 17:44:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791182640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0C64j6HQ6CPxdkVlJPvHgxrtdmU6wkRgZfmlqpJ9xcQ=;
	b=ni7U9CmFkRQqGutIqeMQ8OMCeLJPsO5AO1UyDV/vwm3QM7JMKFPkh/vG4X+jh0D1fAeu4A
	G4ApUJTjs6O7IL3eE1eb98GdQdl8XefqZ1IgtLId3iOlQ/K1ig0XBEEBNCKr53v1cdoLgG
	GCDPNiMl07uEFf/CytwOl9HcFY0QAF72ZOqJPZaHybAsDv2kyyi0mCAE5MmGsH+6LAmbXa
	18skENtv6HA1WwCMnLKpY5K7qLWCTEsbbcHofKLwjzb17IHK2uWpOupN9g+xGqq4/CwA2I
	FLS9ugix5Fow/7UvmnGb8bkcshBVGHEfXHEfvBWDLyj2fsl0aA0gwaB6BIs8gA==
X-GPT-Reason: This is a legitimate personal/technical correspondence
	regarding a Linux kernel patch. The mailbox (alastair@d-silva.org)
	matches the sender's identity (Alastair D'Silva <alastair@d-silva.org>),
	the content is a technical discussion about "rtw88" drivers, and
	the link points to the reputable kernel.org domain. There are
	no signs of marketing, phishing, or urgency; the email is a standard
	technical reply in a professional development context.
Message-ID: <9bb2ad98540bd716d00a0eb0b4faf3593c06cc7a.camel@d-silva.org>
Subject: Re: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Luka Gejak <luka.gejak@linux.dev>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	 <ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	 <kvalo@kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Mon, 05 Oct 2026 17:44:00 +1100
In-Reply-To: <c852aa23403e4ec7ad80a17a6dc18d0e@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
	 <20261001000303.3505264-2-alastair@d-silva.org>
	 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
	 <6ef33599cc268fa12e4663461248f1700969df34@linux.dev>
	 <c852aa23403e4ec7ad80a17a6dc18d0e@realtek.com>
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


On Mon, 2026-10-05 at 05:30 +0000, Ping-Ke Shih wrote:
> Luka Gejak <luka.gejak@linux.dev> wrote:
> > I think you missed my review at [1].
> >=20
> > [1]:https://lore.kernel.org/all/20261001060213.24759-1-luka.gejak@linux=
.dev/
>=20
> I feel like that might be existing issue? If so, use other patches to fix
> them.=20
>=20

Yes, it's an existing issue - I can submit that in a separate series if you=
 prefer.

--=20
Alastair D'Silva
0493 18 5566

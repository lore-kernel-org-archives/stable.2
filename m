Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFC3BFE4C;
	Wed, 30 Sep 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759927; cv=none; b=dROjwyRpvzhbstokrj8HzeITPKVGMHN2EfCTEsFBMRyW7COyQiS3A44zQYz+AN/MSxtu+gRzFP0Nonmr2qipon3PfWgunoFizyk0rY+yoSVnhaOE9Dd7y/hzKc0HJilRDOW4IA2HzotnwTVNQJOGJ1dPfiltXzB36rew9sCd47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759927; c=relaxed/simple;
	bh=09qIv25SMIlrgx+Qp2nEH6oHH5JZxFNCI+xarH/FmP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jM5mT+gNBaDE+ItZ42On6TASYkvvQ1ZeeS9oL0BapUglMJA2WOiJc1gZA97pV/WbGLT85vICCChojKZl3eQSSZDfW5t2RJfdxhUjGxfLYijbIzwI5i0vje4Gs5/sxSBUI9KInGtcQba1N2t/BAEaJHEzlPyXVg1/e0lfOp5r0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=VXHCoEae; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="VXHCoEae"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 7F01D403EF;
	Wed, 30 Sep 2026 19:18:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1790759912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=09qIv25SMIlrgx+Qp2nEH6oHH5JZxFNCI+xarH/FmP8=;
	b=VXHCoEaeGl5zvjzw+uFCIITG9oQh3+wrnh6jNS25cJMKMcFFvcdHhzRckzeT0HTnJIBwi8
	6CCMCzYTMGoLy+Nb8EeHXEyQMZaOWMCTmqnj40foGfQ0omNk4Xe9bO3tH6Xz9HhVM5WNdq
	proIqpPpTDegNUYhTpW6/mEuGtoQBa4oAXESkBe7K3iH6CnKQ/JVohvfJvAJp5Q/KkJheI
	t0rZJKUXLYZh4xkkwWDaXdEpxHeE/FB5VWyRc65xd2Mdt6O9IXmbisBaYyJVOQd1wDlN0v
	b2a0NX6ABMDLQAxvwhydxiyNWw7iD0bpBdees5PFy7QhIfiVlosyPXZR7G5maA==
X-GPT-Reason: legitimate; the email is a technical discussion regarding
	a Linux kernel patch (rtw88 driver) which perfectly aligns with
	the personal mailbox of alastair@d-silva.org; the From domain (d-silva.org)
	matches the recipient domain, indicating a personal/professional
	correspondence; the content contains specific technical details
	(W1C semantics, RCU preempt kthread) and a valid commit hash (65371a3f14e7)
	with no signs of marketing, phishing, or urgency.
Message-ID: <46385ff62fd302329feafacfc37324a0510bb519.camel@d-silva.org>
Subject: Re: [PATCH v2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	 <ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	 <kvalo@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 30 Sep 2026 19:18:32 +1000
In-Reply-To: <20260930090714.2779699-1-alastair@d-silva.org>
References: <20260930090714.2779699-1-alastair@d-silva.org>
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

On Wed, 2026-09-30 at 19:07 +1000, Alastair D'Silva wrote:
> In rtw_sdio_handle_interrupt(), the HISR status register is cleared using
> Write-1-to-Clear (W1C) semantics. However, the driver masks out the
> REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before writing
> it back, causing a 0 to be written to that bit. This prevents the RX
> request interrupt from being acknowledged and cleared in hardware, trappi=
ng
> the CPU core in an infinite interrupt storm loop (starving the RCU preemp=
t
> kthread and locking up the system).
>=20
<snip>
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>=20

Apologies, I omitted the required attribution tag per Documentation/process=
/coding-assistants.rst:

Assisted-by: LLM

Maintainers, please feel free to add this when applying, or let me know if =
you would prefer a v3
respin.

Cheers,

--=20
Alastair D'Silva

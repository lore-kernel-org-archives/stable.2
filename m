Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904825;
	b=sS5LCILFGlQS2T036WXvlFgU4i/taOb7OtW/M9q3LQjSWuhSiSaShvqgQLzEr8g2Uc6C
	 1cOdt2rKtS9BtTG1SORYwIFQIKkgqNvZU3f7T9r6c84fI6u3iGPwN47TpOcO/Gxcb7xES
	 HAGC+eHTw0lxtNEEpiO3xHGYSE4A6cUswmpSxxBa8pj8YTfepcsTfpsotz9VS4yTgt0Bh
	 /4yXmG+w/0bHwS2NMIQ5RPuFABO03CMyyskAQXZfUA9RQQfNXXAKw5SX0NtTkxSP4GUqs
	 JuxKQsZDzTtBvofsGpSByAVQ0Erl4/xe1T5vbmqZXocSAiMy0KiwBoBrwfX7Yiv9e8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904825;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=BFwuB1GrvKDcDRsKDjLKgNhQsOcb8aL9tjPBBhahvGo=;
	b=z+y9Xns3vhd5xUR6mne53TyuhPm2M87qoAUpReNWNem3JgFM+bT+S0gxzpXyWZpjdAzc
	 6TNRnnga00mWUm/cxb/o0rwQ8btqFuF45MSkMoNcHEbn4WMmjQgi3LYSUqYHVlUmtq4/E
	 +ENThp4mUIhpBKn+UCMVnphCeLnzHMaX5u1QQSsO47bUD1t81reyW+Fmby20JNg85qtOF
	 lJGvg5abRXVTrV+NoFOVFXZCnvFQIYEnQTqgWheFpsTa2WdzRCUOEW6LOZMFaJl2lq7aQ
	 PAarcXNN6Dcr9hhkHRbU+ddAZ9nxdLoQYcqULRgMVCLF5J8VUP+R3H413EElIo0EJWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=YhVyptiT;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2A606A89A;
	Tue, 17 Nov 2026 08:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D2A606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=YhVyptiT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794904778;
	bh=BFwuB1GrvKDcDRsKDjLKgNhQsOcb8aL9tjPBBhahvGo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YhVyptiTVn9oJwU1o14brPOvhwDpWyM23LMbK61NsRiVBVIh73HEJyUbC9eDdDXqF
	 E135itEc+DG/CdiYa7INh8M4iPF+WHKuYUfrCNJN/mp/g6XEq86dGQK8RhgsykOoKd
	 VeCJygKl15YCq4KqGuVWoul6s5VuSjyr+lwJPsxc=
X-QQ-mid: esmtpsz18t1794904773t426700f8
X-QQ-Originating-IP: qHeq2V/ZLD2p2YoBBFsSIpmiLg33Ldlt4VVwdnZEFJs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Nov 2026 16:39:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6951036732220354189
EX-QQ-RecipientCnt: 8
From: Siqi Chen <chensiqi@uniontech.com>
To: Lukas Timmermann <linux@timmermann.space>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Griffin Kroah-Hartman <griffin@kroah.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siqi Chen <chensiqi@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] leds: as3668: Propagate chip ID read errors
Date: Tue, 17 Nov 2026 16:39:17 +0800
Message-Id: <20261117083917.3304865-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M+HBeokw/bUUu1ofZVCU8DkQfTPtk2ih1uRaoKsG0l0HpeXowSWaFigf
	xtVwvrISo2ojiXM34/Ns7paoZhkKnNwWZvFvjP4orz/e0NsJSEU3PZkse29dGzwM/optoFu
	s23oXEm1xLZ3aN/U3O7cBX5OlVRT3BdUeptHUxoB3rKokQIElOGpXVL02oKEMdy1efzCfCf
	U5Jx0eSt5Noeo6JZ1lp8Lkyc+KOipkEoWHb8BGkDXRxm9/wxZUyp0lHNRVznNBCl+FlCclY
	sVuX/J9/S53+vyOoveZyzt2/b9ungH89E+W/MC0DiRWnarFxWiT3tRlFN9LAV/LCVki0/Hi
	lSMvUvf+UXhbdtSV0hj4JxL7s9/wXzOipU9+eXvYb2YkIWidIJb66Nph4u+tPJ0LWvlt0j2
	yhByNuIYQEz+d6x62j9W25lPlSnHYOFyJAmV3USzIxs5lJe67Klv+RRVEs4C5I4tH6xrQXs
	pzSHw89Qi6Ne1UzgRJZEnHjp5dy/2QYsuA6RlYg5//vegPu7XMfOUXXgNouQ2JHf0RpeLSP
	DfUFH5OrlCnmZTksbOaHoo33a2TDKI7weqVGlNqS5ZCwq3c2W/YnvCDZvOL/1Wod0ZequX3
	YBn8oW4bATPXPHtk4cSF2M10eY/HTMM1TQK7+nHuTjj4WYkdcPwTxnGjKFjOqgHo2PRjKUX
	aAsK/XFKH1CnK1hXlUwLX7Rb6SLH+rHy1jc4yQdpOefrP8UsZ0cVnZONmYvImIsrul8l/tF
	J7qoVJHECdXf59zpq6GTW63Z389rE8SjjtW38ZfTvtGfYHTnctYVmetmv0nOuCnDCVD6tKx
	r/B8LWT2KiF+e4B4G8IMX/bR89OG4J/TtWHCM/EXg87a9sKn9/Le5EJ9Z6UCVTLheo9XlaB
	HopoH6k5wo7kyPdP3ijn4/690Q/JanVmLpNgTYvEQY7z2SFdNVYZM+okSd9QkBdWoehUkSt
	h1YOH3TUY0S4qPWUMGz1p1cdcc24A6i1TUuI4wVzcyDEMZFg4wrK3jopDRMo6GMXOlhHLSN
	P1akYIGzXPghmqNB2yDOm996kyLgOgmzODcMIz9HVOZSft4TAV9mPd86OHKc00aFmr4SkR4
	p0yCjSdopqcwPgfaQjTocQ=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

i2c_smbus_read_byte_data() returns a negative error code on failure.
Storing the result in a u8 truncates that error and causes probe to
report a bogus chip ID and return -ENODEV.

Store the result in an int and propagate read failures before checking
the chip ID.

An AI coding assistant was used to identify the issue and help develop
the fix.

The change was compile-tested with W=1. No hardware testing was
performed.

Fixes: c7dd343a3756 ("leds: as3668: Driver for the ams Osram 4-channel i2c LED driver")
Cc: stable@vger.kernel.org
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
 drivers/leds/leds-as3668.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-as3668.c b/drivers/leds/leds-as3668.c
index 46427fe752a8..6e4b6ad59059 100644
--- a/drivers/leds/leds-as3668.c
+++ b/drivers/leds/leds-as3668.c
@@ -131,10 +131,13 @@ static int as3668_dt_init(struct as3668 *as3668)
 static int as3668_probe(struct i2c_client *client)
 {
 	struct as3668 *as3668;
-	int err;
-	u8 chip_id;
+	int chip_id, err;
 
 	chip_id = i2c_smbus_read_byte_data(client, AS3668_CHIP_ID1_REG);
+	if (chip_id < 0)
+		return dev_err_probe(&client->dev, chip_id,
+				     "failed to read chip ID\n");
+
 	if (chip_id != AS3668_CHIP_ID)
 		return dev_err_probe(&client->dev, -ENODEV,
 				     "expected chip ID 0x%02x, got 0x%02x\n",
-- 
2.20.1


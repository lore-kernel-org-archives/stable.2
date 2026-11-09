Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218182;
	b=oS5yOBAkS1AcF5WEvM86MFDjeOsZaOyd1SVC4rE1fMcGMF3AN/PRHFJruOhdxej6f0Vg
	 9Tprue1V8Z+ssNkggD+R0C8gjXW0whoWqfmy+WyLhKqB0x9KLsgWgLThZ8GzMNKHIuFld
	 6n9zFxLpiA+tCs0np+ienWvg7wmQR2ibG5BI+tJsiOboV2MN7Ciul1qPrjjbLf6KsAVOb
	 jnaSMYf2P1/atV8KnO8jY+z4DrU1qUVbseX36UahbPQnOpSPzFCgcdLkGGH5VcqjjbFBL
	 leF6oEtqE9XDX3efKpiEsY3xnNOmSV1wpT4oI/RCrn1Eh68YJetCHS8qaEOV7trqQ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218182;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ZkXiEuu8Y50Bl4oTkv4NlwXIxP0EYURNhTHQgzNEz5w=;
	b=mpcqXDszzGaYRSmL+b3AhqPg8pNDcV4XyzVS9nwfm7Od+iXeBo9i54NlGLJMNTetxvAs
	 XZs6oimYNHtpoYBSqL4qhbZz+47QkUUjpwG7UygI3B1OZLa5KQmSLsQ45bEPG4/KZp+MY
	 sqp96mWcqSfkAmC7GjXkYPP9TAZuAxxUCmPxh9LCUOMc3bVd/wOj0kmCm+msfAxtL1dfc
	 1tOmnVXPDyEe4GWLwvalL4rLMiV7ibhxClF9NOqvJPGCoMOQXoD8+PgROYqSwMa56o8ag
	 knmYZ1qMlBEzl0WgapP1W5OPmcsWnMZOkPPXYR9Yd03FVLBLgc+SKF1Ft7+XJ3NMBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="VR/xcGIz";
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB97606A321;
	Mon,  9 Nov 2026 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB97606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=VR/xcGIz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794218161;
	bh=ZkXiEuu8Y50Bl4oTkv4NlwXIxP0EYURNhTHQgzNEz5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VR/xcGIzIKk5ceqIE/L1/8dqo4RgTN4aPcJ2PL5BfFHpGxZtk05VMHYh4kT5SuWMj
	 L5nLKSrwI4dI9zi61q++h66XIp4f7I6RYo+QeG0BYh6//meHicMBNZVm6DOxhm75Ur
	 d5vCwaP2gfZ1mL+Q+s6fhGgdfTP+B8rEgCzbLUok=
X-QQ-mid: esmtpgz16t1794218157t1c5e46c7
X-QQ-Originating-IP: RsH3UJ8R2RqfbZVBxwslQDXswDLbmNfaHsaFPjEz4kE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 17:55:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4843279051413660856
EX-QQ-RecipientCnt: 15
From: raoxu <raoxu@uniontech.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	luiz.von.dentz@intel.com,
	brgl@kernel.org,
	pmenzel@molgen.mpg.de,
	pengpeng@iscas.ac.cn,
	u.kleine-koenig@baylibre.com,
	raoxu@uniontech.com,
	lars@metafoo.de,
	mike.looijmans@topic.nl,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ltc2471: Fix LTC2473 differential offset
Date: Mon,  9 Nov 2026 17:55:53 +0800
Message-ID: <5E0C7B547C19B947+20261109095553.3790087-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NtBdRKr6H5AfMumdFftmyIbS/fbV4RnfKR6El0m38aqwCkyB3pfmps37
	9RKpEoh+CZPRS53f3d17AAy/JH08R+Ah+c+WmS9qk3t9ZgaE3ex8GgCxzBHr99/ArTXhQZL
	qfbw5g1lSeyL36CbX6On7z6LkeTAFg/Izb+IIGfoyyeleDdFyfttwKXUNPn092VPwkWGBOM
	Ovw6EAJV+O4AkkJLZAJiL3yRdwT50/ory9GcOf1sJH/iolgRAMNVHwf2ZcGYBtyTrjG0Xpi
	UKcWBt2H7+T+tcjgM50KoY03OpMwjR17fj+/WrNrkKyGpyvX4GF2rfa2qxXdMFlfDFSeqTB
	cWF1ymXIwaawEjlQjUeoe6Ul4PgiI89zijzox+t2a+DJg81arCwYvWKZ0Ok/XKaJ7PhrlG8
	F0k5W05Xh6qIMYxt5BBmMQq7MHriQ7T5MMLGjPORDKTcBqwtorGrGaO85WIijdTwLb3GhYV
	ccNp8pfPj5ofe57dj+7xEinj+s7vUx+RGtQzPI5vN9CKFN/7DJwpqOBFAdix1yWyCmuK0Hi
	PAHYbZ+lv7NavXv9A3QV7mAuz1Am+edtakh9x1mUIjm0pb8itVFdQ0Ri7xk7BzKihdL22E4
	REtfuIlmalU1IpEIh0qIUtJFCz1FVGtiq0Kfkbb7pzlM/MlH0Sui3VgOGcn00OFIYpVu69Q
	SnlThfpTom6aff0O5WH3E9UFG+gSA3fWCNzaYpXF1BXQe580gbarWQwmmZ1NpRGsknhEptT
	so7ZDelfSaWCVwEPmpXkiQRifv6XaVsQ/QUcQi7L9nMT1Z3I2aobIq+pIXa4vUfmkvbhuZ0
	Okt4AO6YVoztVtI7RBm5UEYpDpNI6hLkA+yrfvc31BnpQ1kva0M5v4fw+VMW5WoELOK+ECa
	Rcnkc1gGBTNx5F7d8a/JFwu0uIZZbmu0UvFw0GtvVLeZ2mEZRpDzUEVEPoBFOwxCqW+t+Tc
	40MPiFcCtm456wAsIJ/CAUBLi/S0bRTef1/Xt/fyfUun6Bk3uTVTVs7TFJ7Q9TThLr3tpXy
	VwRNKatKMNq3+kU1kUHWyjmv9+PTQBeCpLoW2aHr2OU69TTyHSPKfUA+Mz7V4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The LTC2473 reports its differential conversion result as an unsigned
16-bit value spanning -VREF to +VREF. The IIO scale is consequently
reported as 2 * VREF divided by 2^16.

IIO offsets are expressed in raw codes, but the driver currently returns
-LTC2471_VREF, which is a millivolt value. This makes the processed
reading incorrect: with a 1.25 V reference, the midpoint raw code is
shifted by 1250 instead of 32768 codes.

Return the raw-code offset so that the midpoint maps to 0 mV and the
endpoints map to -VREF and +VREF as intended. The single-ended LTC2471
does not expose the offset attribute and is unaffected.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/adc/ltc2471.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 369af700969f..1c88c824d92d 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -69,7 +69,7 @@ static int ltc2471_read_raw(struct iio_dev *indio_dev,

 	case IIO_CHAN_INFO_OFFSET:
 		/* Only differential chip has this property */
-		*val = -LTC2471_VREF;
+		*val = -32768;
 		return IIO_VAL_INT;

 	default:
--
2.50.1


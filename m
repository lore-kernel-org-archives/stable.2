Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218843;
	b=dGVV6B2SIUdgselwNkRzYfSgdyw+no61DDjEnO/g5eZCEg5nfubSUfqqJLUTI1GLx6yc
	 N2DLvRDVy6n60nXCGF51hlWCerWb++1UCcHGgG1vKQyznc1hd+7t39Tu3K6giGWe7n8zP
	 JaMiunhFJLJZHfP+IQcSPpXrQgCGcuijtW2JhoZKTQQC8BalwMT1bIOLewC7Es5txNu6/
	 D45YIwtrcAC+sOUqiDRsslYO8KlaXzSOajDJsDhCEEspbo2fh/lQu2Fz6QYNPEjrVvj+B
	 cJZVBfmDtLlMdyuV1hkSmKROoEMOZLtcKgUM/LE07nKf3rj6WP1hvTyVa9DhkM5Fe2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218843;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=wzD2gVWenx4OduZr/3FuD3SECBgKzRss8SaZBrTL2N4=;
	b=qjZ5utpCY+XclzDeJpDBYM0s35zywXfed3F7EECdLABGjfynetsTybAbuLAhn+JIAhJr
	 lQpXq4QWO1EwfS0r/OONFLYnPayGYo5ja+qR4TrXwlekGsEK0rrb4StsPcmwbHznv2gT9
	 zkSEoBLG6NUoFXACiiMOv/C2HA7wqO0Fmh7z/MkmLxAXcCsQbsmmnlTw6tmHYe8aNmelQ
	 9ZN3et+plMwdy4p9UBWnrLFsWC67Rj4r28tyc2xSgRqR83iJtBI3CXJeF5Ce7zLWf9zwc
	 657DoPk/2tQkPZ3gsANSyB/AyqDHnkgQ1OandSMJEPj7ZezNqE5q71C2lG8E98n1dQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=dvd9dz2o;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4921606A326;
	Mon,  9 Nov 2026 10:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4921606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=dvd9dz2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794218828;
	bh=wzD2gVWenx4OduZr/3FuD3SECBgKzRss8SaZBrTL2N4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dvd9dz2omGOpIjnCzKhth+N0Pf3JAdA7r8DhQIwx6zIrZ86sVh61b1hedePeyxICk
	 OYxYUi7xQ4ij8kt63NtBixOz7norVquB846LLsny4iAErpVf7AcvnYqVkf6yqnsDkE
	 klOuF8x0s8JdMDVWQjxLyUZtAI7uVJU7wuim8bR8=
X-QQ-mid: zesmtpgz6t1794218823t6ab04ff5
X-QQ-Originating-IP: 5qUwObxY9qhhFgcy4aG04KtHrvTQxuH24Pjj+8aIQIw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 18:07:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13396370734778610991
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
Subject: [PATCH v2] iio: adc: ltc2471: Fix LTC2473 differential offset
Date: Mon,  9 Nov 2026 18:06:59 +0800
Message-ID: <AD0B78CBE86D2045+20261109100659.3796603-1-raoxu@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OCnNLGxuhE2o1dSDhlb8I+bEqgPkzzoI5OLoG5lcWfW1lHNtjWNmAWJ8
	hggayVzDr5mjWXdcFliYr66Yk4VteRxgOHzu25XlsT6rjLIsE8mMXFSUywubcI97WXjMUpP
	3QwG2UWNhzv3g8ZNeaQOG2A6BpgWhGJh2XQsHBFAovM1YAoJdu/PxUDSxoDLpOmw8JjOvf9
	ZImW3bNiuRmfik+nLl4UozSBYC37S3G3h2H97l79ImYIwU/g85Pt6ow9dmtwSu1mPe9/IHW
	Xg2hIsXq2ori3qIjbhAZckjdz4MI3/AB9v639VMw3uWIP80a8SwK8Yd963yy/MQJV0sy0uP
	/g+fs8TonvKqN7DGIDyCcxXJJJiVW+9WdE0BrlPFWD0MqFi25un/grP6HE+G/3kYehMA8au
	0qyE8Q5xl5pptQy1pJd3pyuMGML96lsqIDucBgLUm5XhlVwgegokfj2dnerYW/Sm4onqpEs
	qLh+EbBLWJYSvMeU/0c4HUtmVUmK8B6kIhx1Xoqz9Ky15UOHGFjC/A+o6hXGfehYpQLjKoF
	4BmKkXHNYIb9pZcKiT9UcxYnpZM+vvSqB2iB8ouR051WckzsCB2B0O6MPdL8bWmLR8t8n6F
	Hum4bDZ7uAHhjyLAdYtOLK/Gy/8Q/+Ky0nqaV6KtbH36F8lP/Px+EJs4b9R7XF+8B2vknWV
	duo24VhK2rbmEiXorv+deaXflsjJ/SLWRcUjDSHEn1DU//774+CFa3QGFBUq78CnirJE+6T
	ce9xLGoxrwyJ0b3RvCc3TaLJwdgNKyBPulYZ0aFAgi90GmYQCZWhZJIWV6NttnKBdaqQ5kW
	BRatl2HiJrEEUNrxwy9CsQs3oVeTtnE2fTu2NsQzv0DLJPbalF3AOWd/16WFGP9YmruKxaX
	rpQhwtBJvMCvE3iSXx4busc1r4/5VNYLs0ivYWiXILYbfXav/EPuZJF2HRIGIy4SkNkpi+d
	OhhTF4fPQf0j181QcaAFqooTfLzE4gQ4BDpc2FYPEystbXUjKIYZ1CzRF9t4zQ+ogect0s2
	I7JkMZfdfZOaN1oE/OUt0XF6myJIfk8R/irNBis9vF1/1VcST1vyZEebpxsksJ0TPvlLk85
	46ON20hk6qNk36feNj1ArY=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Changes in v2:
- Replace the raw -32768 literal with the named LTC2473_DIFF_OFFSET
  macro.

 drivers/iio/adc/ltc2471.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 369af700969f..eb418c0fa732 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -25,6 +25,7 @@ struct ltc2471_data {

 /* Reference voltage is 1.25V */
 #define LTC2471_VREF 1250
+#define LTC2473_DIFF_OFFSET (-32768)

 /* Read two bytes from the I2C bus to obtain the ADC result */
 static int ltc2471_get_value(struct i2c_client *client)
@@ -69,7 +70,7 @@ static int ltc2471_read_raw(struct iio_dev *indio_dev,

 	case IIO_CHAN_INFO_OFFSET:
 		/* Only differential chip has this property */
-		*val = -LTC2471_VREF;
+		*val = LTC2473_DIFF_OFFSET;
 		return IIO_VAL_INT;

 	default:
--
2.50.1

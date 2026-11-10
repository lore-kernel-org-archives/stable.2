Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313536;
	b=Slz9pHLSgfJDT+1dX4T4nZT+MIthv4+fCBkeM4R++VkbAvdS29UVHlnXw1rIW9zSZAMM
	 XHHm5c/meI2nC/9XsEBQuPaawFl6j2DACsGfqUi4fYGkZdn9HI6j1IyvmWt57zzKg1ngJ
	 h/zugw2FYEit68S5jjHYFdHNJ5508DSJEtMW4TI73J5FcePKaNMu927fpLaZzVmLpt358
	 1wVbSPXLp/+p+3ipEBCyb2XRbB3dpIK/V/vcuW8GIqxzh+/HwmAeTIYAJrfM2bDOcSPYt
	 EClQ1z4XCKFYNYcT2ITyE6ZaRlvwQnfsI1uKQumgj8TIz1xcWWhF+3YB4GfHuy643Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313536;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8lWCiB0JHEA7qzkmIFqBVO/U/0hIioLfNPjh2IrIufs=;
	b=bm/4GTjkXfE+PK0RGXN4fZljO6A8yHcWyHwbhWp45n5Vsy58CQ6yxbAudx7fl77QyAfU
	 rGVlFPd8M8Axgg8uN4VKLejYnCZJVErJXeOxofnXS+E8YA5xKWD2OpeuJi74Pb+e7f5O4
	 f1OU/nX9UcRgK/Qnx2599t1IeNmf52KZw+fKuBlxV/3zj61fb0/U+hq9gxetk1MMVmOOf
	 k/qDoKzX3MwfU+m3Gm6KLK1fJm1Dh/CDwzxe2uPhfBYmV1IFlUyyzfKpcvCIf4Sbb2sEp
	 jZrvNgyEbSWfldaoi5jZSXalX86QITXJEfMvU/yrCdx3J9RedKba0wrYI5PMrC1busw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=SI4Wmh9i;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58B606A31C;
	Tue, 10 Nov 2026 12:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E58B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=SI4Wmh9i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794313477;
	bh=8lWCiB0JHEA7qzkmIFqBVO/U/0hIioLfNPjh2IrIufs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SI4Wmh9iiZypCLWl2/XmG5ygxz0S3I5Z10l+nJIgGIVpILB4LN2UlWwSRzb31TfoQ
	 x/B+HSOe+aDRdA5c9OzxJvq/SBnj3tP9j1rHR9EJEUjmEr5dxQvZON4ThYtB+Beu1H
	 TBxAbaI6dNtJYDvkK+tHjnEdiyr/7dxfu37cS3GY=
X-QQ-mid: zesmtpgz8t1794313460t52fdad64
X-QQ-Originating-IP: 7YJuLs4em+I2CqTud3IbnSVjn7y41TF7S7cgnCx37EU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 20:24:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10375027920850177401
EX-QQ-RecipientCnt: 16
From: raoxu <raoxu@uniontech.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	luiz.von.dentz@intel.com,
	pengpeng@iscas.ac.cn,
	pmenzel@molgen.mpg.de,
	brgl@kernel.org,
	u.kleine-koenig@baylibre.com,
	lars@metafoo.de,
	mike.looijmans@topic.nl,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org,
	Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v3] iio: adc: ltc2471: Fix LTC2473 differential offset
Date: Tue, 10 Nov 2026 20:24:14 +0800
Message-ID: <B29B7229F9C3B748+20261110122414.373459-1-raoxu@uniontech.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nc4Sv39/e83WFeryTqrHNtJMOj01Y+f0ORTzGpEKG9K0/C7vSde8aTRX
	y/qMc8n/tgq+FMlEVe/lRS9F0KkGjR3APk0ev9oxRLubtn3yqwsgYusnb8cVywJaE4UZvwV
	i5E5xqio9BD2SAQA9BmhyHwIctS/G304cjq9Ompv9GKJgdwAHLT7J2BTpmJKcgknghVshgw
	tkf5eFiuFk+CpFBnoshnkwle3c+keK+tQJIzLZbpiAH3VcUK/iSkdxgK+SG6ii+izKmNHoF
	ulmGGT0f+0a7dYEWzI1I3AWepIao5fTPgXbVQWoho0de2byMm9OIKda7QMo8DkdXfzxk/A5
	1+xquYHAlIXNwGmUJh33GCQmqD5ALlcMCbphGzXdiRVPcxET5YTlV0dRrbtdGagXSiS7Zy6
	yR70M3Ec9jBLjTY+ZZsz04VWHgBAfbQRxdxKTUyg8vmIuSe8154gFZMvYewJnXUg2A88STa
	jv0ddqh1t3FVg9TN+vYkH0kVdMcYhaqGZywYbEcIga/l4XuGiqiaNopkQEoztvzS58bbqv3
	X3kZRDDRH+ywiABL53LcCmr9nf2g6PkkhqfKSw7f7TjW6tdITacG6LzVVOCIIcd25q4K1PP
	baCGg3AIwvuHUdL8jdq++7xWjFSij+b/alWWX0dxd+Ct35wiuDcl5hr8x4NmwzxGZ96twF1
	Xismda0KS0Ie09Pu7I9KswrbzhrOSbziulVOJQ5nT6L/GGQvUyK7+AqKY2zuYHNBaETd5UN
	TadUTiXM2cq38YPRi8ul5RoyRWDcDCbh8w0oKywt/h46VNxODnr38k6+w+iIaAV+l/Q1RJV
	go0t2TyLIhS5fLo3YYy3adv9TKUvE2N5nQXcACAs14e+EFjzrNw9YqbisSB2uu8/dTE3phq
	t0OcPDPw6FWKf+EuBN9ISVASKVVXbHJ/IT4GWFUuYOtnTLejMSOKDmeIk5MUrmj9WP9xTNd
	IDMT+p4Kw36e+p1Cbd27YC/1hl7cR+qQgFdP9/m+4C/gP652tXy+10VSmQmirXpmRuBf2Oo
	QKXpkgkQx0SUUjhVtXqGegBCBtjX+PZOGz/poUvMQOvayUvoUmT+wS6IUnjpzpHUcdjQR38
	fhES24ep8VKgzg0e8r1J/5oTLJNMnc/0+Nt8zPOgx2e
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v3:
- Add Reviewed-by tags from Nuno Sá and Joshua Crofts.
- Move the AI assistance disclosure out of the commit message.
- No code changes from v2.

Changes in v2:
- Replace the raw -32768 literal with the named LTC2473_DIFF_OFFSET
  macro.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

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

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055970;
	b=qwxuvkSWdSb4+W4SAN73kE8Rx25sCWMhcGoslSFth5tMa4jQ5unDR97fF4ER6VmuADWI
	 VAghMbjPxoukVvX940AVvIiH7Ez9ro6/TmuWNhCocfWf6NIXuZc8opR0sKFip85j8DLLE
	 QqWGYSHRPF1W3NINGhxzJGjKYzcw1c8ctlmK4QYM8lQ9Rj6qUhN4caQ+non5tW16WGAzx
	 Xni02ObXwokKf+t0VCqDt7kfvrOIn6eOi140re4RHmygO8SY+6ErFYQDkA6GT36s+ejba
	 Zcs5rWBBcuUtt7BLKdrq7fKUmN0JfWYPOsU+XVKYkZUVBUa62iuUJVREnJB48WNgwug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7CiUjokl7xwHJs3fMhqatMdxzmO/NYeg425YuE/HQjs=;
	b=DVj1X+K+ygLLc+1ipjflm796+6xCfbcLbh6sjqdy1JP5+BZKNknxFhtboxWvFafToESG
	 Bh67saYIAZfq6BPiLUT68UH+zn5Ve727SRCtYHALgrtlOYL5x5pfe4aZaTVvo7TvKuwHE
	 PWwfhmJuZgcqQGpcEqDVodvriw8EiptGJYzph63a7Z1EB2LkMuGqm+3ftInLXZN/FLbCf
	 82t6Keb1FZDemZWKoJXwt3m6AWsBfHkpnyfRrCX+uYIvz7AnsJKd/FVG0NVnjRaPWsRTq
	 2C3tXEQhuCy2s4MMru9VpfS5UKPt9ezltkxYqZOVDregem5WKWzGP+w489SDkDHQm2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RnUf5fZv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85E606A31E;
	Mon, 26 Oct 2026 23:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B85E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RnUf5fZv
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP6LF869031;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CiUjokl7xwHJs3fMhqatMdxzmO/NYeg425YuE/HQjs=; b=RnUf5fZvHITkG0jc
	j8ZETP7QCydIvy95Q9NOVyIhXwzb7BUeAx6U0z9SKF4U3qiHoaygnaSPZgeIYcSD
	7N8lFLQY6Bw7N6iiRJImnK+WxzykL1raD5j+zmuC5B2oVKWJkv9sFtJY9+867obx
	Injn1nmg0vTOS5vn2VO2AqGJYYqkqYTgiYL/vtFf8OUog7C8tUST9Ya8Zl3kvUGz
	n72lnKgnvexIOBchkNQ8PbVTzBKxqs+5oWusgAICZzYX2hBJBfDxE5r24gsjMidw
	VGYeR4FaPWJ+IaVc4eFTz79HQkVOil8AOQtkp+ldvRjpUIV8jun2NTTbsdNuxcub
	3SUZZw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s92u95-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Ve120242;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN61iC120296
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 75A25255FD; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 29/39] iio: gyro: fxas21002c: restrict available_scan_masks to all angular velocity channels
Date: Mon, 26 Oct 2026 16:05:47 -0700
Message-ID: <20261026-iio-v1-29-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX8bVAABfv8eMb
 vfJkvl90uPe/N3XzmfQFerLXDWs/4yD8ELmCTbL8vaoabWhQMIizJKaN3g2GVJKuLgCCFE3JZ4C
 RySdWJqJMaXbP5pETQbGm88wdeoRPvRSLGz0HvYLNE9cG1jbYPUskStKqAOMTh4xBrKeYR285bg
 MNax9dfIedeWZtNbcikN0J1WgFL8/a4LAPk3wYzPvgtMXXwlQzTl9w6J5TIxbIgMJwOq+VC9Ni/
 a0wJp7/Y7OO4JJZDtcYspd9T5MqpA7mz+Rf3N/bYZSREcPuOko3+63+A6ZXMinIIk33Tzl0Fy+5
 +iSH0jUNtUkTjimu3wTcfv/TE9tGuDA1jzisa7t9pjM8zXxxzUgt5hY2LbYN8JWDgpCIh2rHHGG
 5wiH/2eEPROHzvTjRe2gevB4/E9MLiP+o2U1/I2Vgzh5+sQPo671x3xR0sI/YTdlpC6uXueVT0T
 eS6vTHav3f9mvchinTQ==
X-Proofpoint-ORIG-GUID: pNIOybkKdavxV7ZdaHzYnUChxAdcAmtI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9i7pETBAEL1J
 P0oenfsyAm9NIYxGfC//rkCr8rbQXnsQHt7NQAhp0uBkWCGmF9JRyaYMAvNqlSfX49jnDPc79jK
 bv3sPJg0y5i2EipQ+4C2guN7/Aw1y9w=
X-Proofpoint-GUID: pNIOybkKdavxV7ZdaHzYnUChxAdcAmtI
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=o-__5saYOCqK5gidKSoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

fxas21002c_trigger_handler() always performs a single bulk read of all
three angular velocity channels, regardless of which channels are
actually enabled in indio_dev->active_scan_mask. Restrict
available_scan_masks to the one valid combination of all three
channels, so the IIO core demux can provide to buffer consumers only
the channels they actually requested.

Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index a88670207cec..6ef3ba2bd1f8 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -714,6 +714,11 @@ static const struct iio_chan_spec fxas21002c_channels[] = {
 	FXAS21002C_CHANNEL(Z),
 };
 
+static const unsigned long fxas21002c_scan_masks[] = {
+	BIT(CHANNEL_SCAN_INDEX_X) | BIT(CHANNEL_SCAN_INDEX_Y) | BIT(CHANNEL_SCAN_INDEX_Z),
+	0
+};
+
 static const struct iio_info fxas21002c_info = {
 	.attrs			= &fxas21002c_attrs_group,
 	.read_raw		= &fxas21002c_read_raw,
@@ -969,6 +974,7 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	indio_dev->channels = fxas21002c_channels;
 	indio_dev->num_channels = ARRAY_SIZE(fxas21002c_channels);
+	indio_dev->available_scan_masks = fxas21002c_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &fxas21002c_info;

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780453;
	b=rMRfRNI+EIvPIVJx83Gd+UUzkXJSxXyrR4+BxYDY5c2+FXFIZMjOIGZ+Swc+EBof9w+0
	 Mi3Q4AOGrs3rHMMhtQnI5GUIGM0sUbRzSJzTbTzYC9G1/89XW/9QhepXMxq6a6FxXenQc
	 VfcT0opurHozpVgEeCJ4phadXGoa26oi9MRsHs91eWMq6b/GRqqgusIRO8FCAapAMJLaD
	 vlvR784y+DA6FxEziplzPfKknquhmuDjvo5MxxKxXyvwS29zIDum9JGMelI0ACcBeML3c
	 uuMT/ZFLWB/hteMEpNyBaFCkZNfjZzWAoolheOcPeTjyGRR8GwW683iyrBqF5o4Y0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780453;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HH92dr4xGRpQKZQzm3MYKisM5iEBj+5qcD0cUMpTkZ0=;
	b=Af6fpRVmMpf5swd3Al90NRbYC1yg7t0hcMXMbPYvdcSYKVnkEmIVtXfmjfx1RYfQGpGm
	 7L11JSJnrJ5YBkUAXIGRLFPCxLJg4QH9ErGIzCatUxvGO32obwVDmOcnMGbMYCWNKWT+p
	 PCOnYCPYs4WldiP1nnKC8VRRSvlm5pdM+/ye7e/wFEhrce/0gwuwd7i1aQEp1NFa9PIUq
	 CVZWfnCORn+IKlgQAjrO4kx4Qy2XdIsD8ZteaNCtqg/jdbNQOjvmm0Ea9qAZDbbNya+s2
	 AJGbAIWuWSqe8z9KizAtw7bvlP4zawXAqep3zZAu0ZFyw/eZbXfNPGlZNFrB1T/KFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RA4xQ7bT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EC606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A86EC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RA4xQ7bT
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NIHk2N2036649
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HH92dr4xGRp
	QKZQzm3MYKisM5iEBj+5qcD0cUMpTkZ0=; b=RA4xQ7bTuBO3eB0MUT5qm1Z56l0
	jx6Vupd8FzZshv7cCRnffpMkQSzSTGzsRFZTXt1FZUI/GWSilp6NRFWVyq7q8s18
	BdC/qN8Bk2Iocw4V74q0vJoGgcVFW91bF1BQUL8Y60eTbAEF6Wl681ApC+M7f24U
	1myeT0nvlr/Pw/o3EpFlzMpGVzgOiPMvXM2hfALFB5dhPEhWhhmgfLvE+Jh8V0Yk
	YZEwESCO66mVqTgMlZo1Iu/OG03dKwNeEb5S6PumfYJUk14fI26KGlLu7dU3EfAT
	wNG8QN6i0tGaFtWZVcy3AwiUDKjsI6xEkKr0I9uMnJ0WkMVes4cC4Pzrqtg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr082aj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:34:11 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NIYB3W2272288;
	Fri, 23 Oct 2026 18:34:11 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69NIYA9K2272280
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:34:10 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id DC38324DBE; Fri, 23 Oct 2026 11:34:10 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: kernel@oss.qualcomm.com
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 29/39] iio: gyro: fxas21002c: restrict available_scan_masks to all angular velocity channels
Date: Fri, 23 Oct 2026 11:33:57 -0700
Message-ID: <20261023183407.1639972-30-jonathan.cameron@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023183407.1639972-1-jonathan.cameron@oss.qualcomm.com>
References: <20261023183407.1639972-1-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: reDRqJ2HXh5zvBNPIq_pcAd6IC9P_wsd
X-Authority-Analysis: v=2.4 cv=FM6OVOos c=1 sm=1 tr=0 ts=6adba8a3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=o-__5saYOCqK5gidKSoA:9
X-Proofpoint-GUID: reDRqJ2HXh5zvBNPIq_pcAd6IC9P_wsd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3MiBTYWx0ZWRfXy4S0cbPLgCaw
 y4FSJvFDHl6mUymqaN0zzJ0VBv7POJtMWENISWInYRjAPhjbZsNWNn6HCzcfQ2rw+rOgbweRBiM
 X9aHJYRzkRuu8TUxLeNZ2fP2W8hYKiU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3MiBTYWx0ZWRfX+I3/sXRNer+/
 NAYxKu6Qu8qief1EzYln7QN/u+ZPt8M3mQiDOAmy3r9qmyM1Q1RaIl9e8/GhWrZEiEfP372h4Wh
 4G/BG3BkBpXjdfpLvqvVvYN68KMV+lzM3OIRQByUoNbMnH2bc/kIKqd1pycxWO83whOvMBRgQ45
 L6CY8McKT04nt+hPQ96WXtoC3xrBkv5IKaGLy0foRPWNKaMZT9i/PoYt6GryyXX5XvblFW9rulM
 Q47zKlVHeL8ktdGYu9sDdvkG27iyEfl5PaxgwEktUzJY1fD4LUkumqJKkbGkrtpBZUR+qIKYQ+Z
 M6/LEnDlSGqe6KlwgV7zL+uWSKzrPbhBuAUOuJPz/0CWP4dcAH4pcPHV1JuLXobJu2e0WyBaN5m
 241bQLOETh1xFF4HlJvDcmzD6hdpa4k2ZYn5vz4QyMzKcTIPmo5b/zbaPpxa8J4Ag1f88XJ/0Z1
 XvOsA58a78qgddL1f1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230072

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


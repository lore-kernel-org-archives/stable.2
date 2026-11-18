Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016378;
	b=VfJzXA0t8Votyg/67+rvO68wVzhijwcAF4LS5rTP/ZEEKH7E+hXu4pvx9tncpQ6pa6tE
	 TRJMZIt8VysvcaYK52HVPf+VdwXqcrtguYKRiWrgN8xd6V2tL/pUCznkZVyGIpa91kTth
	 mIMAtL1BmRxIAfiXVZDJeG9jyRvLnxaM3eNyt/yrX//mxGvBg+H5WbDh4SHOqXa8KryzW
	 VEWkEn2TYYNt7Q9wZuhPalXLBuLJ1f6HKgOk7SEcTFXCClKlHAECpFFaSbGaVhN2vNs48
	 CjWwRFry4pjq0j1tcnKn5slmWim4s/XZoUQxTheLLx8CwgLg649/mEGVKRJ6v6L5xcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=616Ka6K1GNSuefEHOZNEhhdOKtztQQYz9MITxFkzSxA=;
	b=yxUa6nXcfYJXEy1HgOAOdYs7qUX62bGn+aNUK2BPaQ1iulEyftpv8OfZfJ7jmIY4K9PG
	 6NVu9GS8BYUR1UpvGR9oe76Dj5YSXzo1j1bBnP494oDPuYl6R4cW7Z+bnzp9LOkHHbtWK
	 YI6eZHQhZDd8CfZtK+ifvmE+WTJFuPlfZWXG5FUK0wn7jr8JtvLsoRAK33NAmN7PEMdZW
	 jfzF43gySoVO5xXeut33/9C7YZf1S9JmM+JUrq8dGf58aK+dVxaRagKtLsrFt1z+MeigM
	 pAeQ+WC2+RCSbUFdIv9RmENEbasAPE0RZqxjM4ooqpuYqIFdINKS2Nz00ZdlJKkcWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hge64FN9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JKwjoUib;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DE60A2608
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 306DE60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hge64FN9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JKwjoUib
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ9jl3912225
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=616Ka6K1GNSuefEHOZNEhh
	dOKtztQQYz9MITxFkzSxA=; b=Hge64FN9RaNvcTBcgNuD4PL26tR0qaTlrBPtUv
	nbKJSARE1EURH2FPOZ2HbhWiI0wx81FVY7AcAcayc9Gxec0/pGI/f2zFzXbnh7nW
	ubN+S5MU2lT23ymQHkap7I8GhbPmB+r7JywUSqruS5HdKeOdOUBqyJxB32uu0Rp0
	8/Px5nxYDT+E8ksbgfi9zjO0XIAgG2p1vuUw0epjln23ymcHKuh3tdXA9IwYtAZ9
	rD9lvS1bpee5cTQ/JxyCk0uSvrKm8eYpvdTDphzpBYcItDiIGscPdiHmVUes/iZh
	6vPqfLx0Lu2Y+rjrB4gvU9hn4ayvO3U1JGUTXp1/kjq0512g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9btdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:39:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94967c6d4f4so138671085a.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795016375; x=1795621175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=616Ka6K1GNSuefEHOZNEhhdOKtztQQYz9MITxFkzSxA=;
        b=JKwjoUibtPRkRXX4Z6bB/WLuERHh2F0iv0JxeIfPbI9SaN7OAQS+yzuAFxkiPSa8sZ
         59X6aaCq0gao0Q9ElzmSxAbw+OMr/F7m0Bthc1nGGdhI2IKT46n67MofOk3zvHE4GFQ6
         CqN715nJ6ps0GKxrAsl7uVEw0/X/A0clGq6D/ObAM3ZbwK8irq9nTfBq0qBdAHYqfaBj
         A7XWRynYWMHKTQ8OmBYkhKXnZhBLmypanDHPhDXm0lXdd2U04UvM1wWik2Z7lmcIyhMu
         KqRvWc8YF6xCTcIBsUVrzV6NFMZlQtCzQefZROXz71ZgIdrw0yq8I6CtaMv7M374wlYu
         oFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016375; x=1795621175;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=616Ka6K1GNSuefEHOZNEhhdOKtztQQYz9MITxFkzSxA=;
        b=AfAoZbVkauT0HGH5k8EM45l4BKR/46EjS2GDIqLi564V9OqqHRgfFjHhlmlB4RFbrk
         lmZwu3kWTkuvNfMfry9J+lvie6WdxzGfE4J+HTZ6sTeOkIhtJp6ut1fqTdy1Euc8VJg6
         CnO7RXAktxiDgx0Zea/nAwviGHJj5Z9KAl0a0n/1+S7+EMVoIZ2U+F5AjPXMsQA4pqG/
         dZ00XPzIYAIf3DLS+2Q7ZtLzE7ET+KwP/Znj6VXLabjT1yYU1bTTj90EZAH36etzllpz
         PoGKMlbJfUHlFDpKaUfUzrHoEgZmJXwdxojqeYo/NuxsEcWmzii9YlVFMn3FXUJVzukv
         vkFg==
X-Forwarded-Encrypted: i=1; AL+hErGDnG7bXTtJqpxanV9uGtQEXc/F+5Nz5+5VQq+DuPuxh4TGNU3hWFBQHqV7y1Y95N0l0jbkGSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z82Kzja9mhtnuEVBm/8GlRO+Q9ztLzKJ+WunnpltrUbdG8oCE90
	5+xeZ+FNkdNKGE2LbVbL/gojZG0Nyy6HQrTJrblr39lNnfVtuU+vLfKAGY12BcXY0w8c6mMZ1U5
	0/pzQv19Azy97s9ShfwBLdJkwaEYf+Vok47Q0LK+3Sc6woVjgWbvQzVoE7Hk=
X-Gm-Gg: AYBFou3lKA0Ckbo28kd2zdgwlNWZI7S6h3485o8JgC8ikoNDFXJfqIp7qvtqy6lciJ/
	1mWDvtoZzsczxM8Gm8GD1YSNExSAG1qPEASPtiIAGSq67s8gpehBOAqZso/Y/Q2Vx4dqWCtG4nH
	AuxiIV7ToJ/2lwFgAu4OMpgnWzyFUWbbyh3RG2n+dMfGzJcuZXo3vGGLKZNnjBEC9J3yuGcwqv9
	XFOyC/jO2/mvIdkSD0u8n1PH2yHmzdCbeaWOIcfFJGjrfJ8b6+CNpkmBgpEDvM1j+G1+p/jLqvY
	92ef9BJTPGB0N27fA22OPutsOvebwk4d/Z+3tWQQqFizzmw3bpScoZhFqTEYT7Tad/wvT0grNWe
	tr7wMJ8xR2jmAIF5CYpbeCtJL0JONfW1cXNDBONiwfyHcHxtn5in8mNOBFg==
X-Received: by 2002:a05:620a:408b:b0:93a:2221:5460 with SMTP id af79cd13be357-949995d2b49mr536820485a.40.1795016374751;
        Wed, 18 Nov 2026 07:39:34 -0800 (PST)
X-Received: by 2002:a05:620a:408b:b0:93a:2221:5460 with SMTP id af79cd13be357-949995d2b49mr536810985a.40.1795016373810;
        Wed, 18 Nov 2026 07:39:33 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e59834esm30324505e9.4.2026.11.18.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:39:32 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:39:25 +0200
Subject: [PATCH] platform: arm64: lenovo-thinkpad-t14s: Keep the interrupt
 off while suspended
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKzG/WoC/yXNQQ7CIBBA0as0s3YSIRWrVzEuEAYdYynOUGPS9
 O6iLt/m/wWUhEnh2C0g9GLlKTeYTQfh5vOVkGMz2K11xpgBy8PXNMmIXkbXYzW9IgVkeaLOWih
 HirhL0Q0HG/dkHbRUEUr8/m1O5791vtwp1G8b1vUDs+tPBYgAAAA=
X-Change-ID: 20261118-platform-arm64-t14s-ec-irq-suspended-5fd6892d7e26
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=0FPPSirqiaOtAK8WV7GCGSWqgQyyyxZfbHd9VhqdDKo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq/cazrvgAHeyd3NMZasNE32C1JDADML9fJfZFO
 2V9ElqdU+SJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCav3GswAKCRAbX0TJAJUV
 VpfwEACF7UhT27ALWux4AATPEI/rPp69UMnlCuUQakXbBZplvXJlhLZma6JTW433EuwVjkt4T3P
 +T3t1bbVlRRRY/Vxqye7JtU/m92e4QTnPrY53clteeLmLU8GAo9+62qkxRUXMqHPF5kOv7w75vQ
 r6yUHkdYmSi4CLnpqQ+89E3rEwUl4LqeNyWZh0cpg7UF2g0tZ8Yp8zuDSIKjNrTRDGgX2QaJcl0
 2D/LJqvRXT2RFkbyXVRTPQ7fnJn6U/87vUXgpWxeIsCTEZIr0sfBHAnG5EnOAaaBXmwLVxI+ZQk
 yYCxTUcM3Nf01pgbdqOVQ62QE8W/dHCSmfJRvKGE0l3ej3hn4nrwAyl92BvSfcAAYKgA/0I1u/z
 JIZfoHYD+9510LI+VnNFibw3AGYk7PLx9Pb4wluIeh640K7+xxFaTWwQLN5wBs4fphamNXvzS7Z
 B46UoCx2cetNunF/m8M9XBkL/GLlWVKhe2JHPb+TVTX9C6Ya4Q40BUN8B9MnE9RkNOqzsxjr7v/
 P5nGSNdDubv68vSS9hVphEtArlg7wIj8cOrBxwpigCGSbMV7QsWHcenjR+HT7t9bFK2dTPJPiLX
 5yN/3UHQIFIeiXnj/xGzbynWB19PD9hnwnCyPBcGjFEn9GqpNZWXC8ylM6fNiB/fsFd5i6JfiEZ
 7TUGlh1xMjumkHw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MiBTYWx0ZWRfX05T2swu/W3O8
 a0ZbG4iRwA7IIyDdnJMoaVuTCkFiXta0fTHMBI29zOGaORZ6UMwaUHcCMdMb4t9ZZUQukFpLI3E
 yWo1dwH5bHhqaWS7QU2HwilqAkkBpYM=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afdc6b7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=H26x3CEjwpY6bbsiv-8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MiBTYWx0ZWRfXyYaMXT1JbMoM
 LMzxJ8kU9v/TlgVF55nLEWvn/CI6a0USZYYU38aN5z2/7UBtQxE2muWW3vVomlehVSdG9lNAOOo
 So+eAiFZ27U2/IexonN+gYy0wQzEVhqF8LgSNhZaqyB8VyedrcVLJbp6E/tfHlEhtRUNNmwdG0k
 B/tIPuN1j1BZp+hOur6qwLaqj6FeFddVtHouZlKR74uEABAZWBqEa2h/flwhFSXk8YtDX3TDMfY
 2xlVELCu0ArAg1bFBmnH2oOjE1rRueyUaLU5/eiAYryAhuP+/k8ArKUF3P1luiF7dAEyQCKz4b9
 s9+tYVIREPwuucTFjLMDx+OB6f0G292p6+wcAOoALRrP0FomtBOpKqlo6gmlg7L0tU1Zq16QODW
 KYMlkpO4XX2lVWhVqiPjpIioUxAuSdEcxNxM9gpJg712S/fWzdwA0wEoOYFuv9V80u2Omhrf5GB
 kl9YmffzvqQOyOSowpw==
X-Proofpoint-ORIG-GUID: pQdg1i4dTrGiiQrtbYqqO3PB40D9IJ26
X-Proofpoint-GUID: pQdg1i4dTrGiiQrtbYqqO3PB40D9IJ26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180062

The interrupt handler reads the event from the EC over I2C. Nothing
keeps it from running while the system is suspending or resuming, when
the I2C controller cannot be used.

On resume the interrupts are enabled again after the noirq phase, while
runtime PM of the I2C controller stays disabled until its early resume.
An EC interrupt that is pending by then fails, and so does every further
one until the controller is back. On the ThinkPad T14s Gen 7 that showed
up as more than a thousand of these in a few milliseconds when resuming
from hibernation:

  geni_i2c a84000.i2c: error turning SE resources:-13
  thinkpad-t14s-ec 7-0028: Failed to read event

Disable the interrupt when suspending and enable it at the end of
resume, once the EC can be talked to. An event that arrives in between
is handled then.

Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
The EC interrupt handler talks to the EC over I2C, and nothing stops it
from running while the I2C controller is not usable during a system
sleep transition.

This was found on the ThinkPad T14s Gen 7 while getting hibernation to
work there. The support for the EC of that machine is not upstream yet,
but the interrupt handler and the suspend and resume callbacks are the
ones the X1E based ThinkPad T14s uses.

Resuming from hibernation failed the read of the EC event more than a
thousand times in a few milliseconds there. That many, because the
interrupt was level triggered in the GIC at that point, as the SPI
configuration is not restored after hibernation [1]. With that fixed,
the handler still runs once before the I2C controller is back.

With this patch there are no failed reads on the ThinkPad T14s Gen 7
when resuming from hibernation. It was not tested on the X1E based
ThinkPad T14s.

[1] https://lore.kernel.org/r/20261024144720.113165-2-zhuling2709@phytium.com.cn

Prepared with help from an LLM-based assistant.
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index 873747838a4f..a291daba0577 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -616,6 +616,12 @@ static int t14s_ec_suspend(struct device *dev)
 {
 	struct t14s_ec *ec = dev_get_drvdata(dev);
 
+	/*
+	 * The handler needs the I2C controller, which is not available
+	 * again until this device is resumed.
+	 */
+	disable_irq(to_i2c_client(dev)->irq);
+
 	led_classdev_suspend(&ec->kbd_backlight);
 
 	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
@@ -633,6 +639,8 @@ static int t14s_ec_resume(struct device *dev)
 
 	led_classdev_resume(&ec->kbd_backlight);
 
+	enable_irq(to_i2c_client(dev)->irq);
+
 	return 0;
 }
 

---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261118-platform-arm64-t14s-ec-irq-suspended-5fd6892d7e26

Best regards,
--  

Abel


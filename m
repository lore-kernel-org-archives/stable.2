Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884474;
	b=YjASrsT62UdRkY1JgtxzNYSMLGwx7QmggZ9Kv2xkxxtk5HQeRc/zJh1kucn2e3CbSJOt
	 ePkJ2yvI2ZhZZfDh1jh55TkZo1yfbDLVLtfnuVNSEBW4gzC38EHhhuBXemLXwg70GU3Py
	 YAwkiHFOETv05YT5GEgJrQhN7KD/A/bLAXb8FeDJnv82V1SwMwvogdOFiFkS4uFfh4p+I
	 U6iCP+AhQ2FjgQLk1uYbB/f0EscOO71boD0/JxG5hhEqkXoZNbe3NyToFfoRWMgTsT1ju
	 aUvJETHnaQEXL+aYTz8dp2xt2W0V7Q+fR/k5uXHB5weRzEmVWmz/kwclVlBXlurz3Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=23xE/pG0PxrZgDnTN6o56S9USHdH1/BEwYK81Qphu78=;
	b=QHceI6+bij27Vv5p8qArxqL78OB/XrOjObKZifze666KcW2RhyuBBcqk033eGQ6RRMXw
	 K3mj4fVvUhNDFHb5JP7cF3aAhxXoF9pe//Z1MCuiPYAABq07rdT78qA9D6/DZ6udxfu3h
	 6dGg8GFAOo75gCp+X7RNN7YwC7B6MIYxuUjeuztlyuuxoqhI6e8Els3DIrxl2iM5I6ksr
	 4ylHvQt0sqh+g47mjUViP4Epa8qwTOrTHiWoIQXmokhrukHn+Cnphf0P2DxDr857YM9YF
	 jisqpmfQqiivOWRVrttXf7UjaDIXjkIIRPdvGuArPrWQIpSpo/lBbdyT1P6Jkt13LSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GS9QQOEv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NWZfsYNL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64196606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64196606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GS9QQOEv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NWZfsYNL
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Ai2p11583066
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=23xE/pG0PxrZgDnTN6o56S
	9USHdH1/BEwYK81Qphu78=; b=GS9QQOEvyagyxW4AOpm6qYjR7jCKPC9ovlt/st
	BKSccjL8AG0Ka1So5VO9j6GGzimISP3h3dtirV5lPTqpe/NUDU8oYHV0X9yWGziy
	F6aLmxd+4AClGFV49qJ4ZJ8DI1QAqhOxnutB+MCUF2zin7ayMmkl4iAMae8kou8L
	GFSgwrJBaYyvREDrr1DOKhPDhRrHheOPZqWGXhmnq8jjHnwFzEfoJpBX+a3XhS3+
	sGatro6fX54ZfHd9u4r3SKR/y6G5e/R3/tHcztS0eIjQygnXRkMhgkZAxOW2myuU
	usc22bkt0IKe4b3Htqk+sLYgw5eODEY4n6tZcocDQtPwuuIA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraarkn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:14:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so572876785a.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884472; x=1794489272; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=23xE/pG0PxrZgDnTN6o56S9USHdH1/BEwYK81Qphu78=;
        b=NWZfsYNL8uCzcBcHt6ZQ8GuYtbzTjwRj0tZ56Z+Uu3jD3vLURCwZgpovB25qsOyvye
         8ypPOvFzQGqaoYjckWuC8UKrp2UvxTm9L8LEDVz3fwH5aLEtWfU/WohCdCG+cp+NvJAV
         sINKNHMp/TPX/1JKM+U2as/ecJmMr0e3yGqmUxJ9tpG2FDhRfRgwtrcR1KvQ5vIp0KZC
         1hypduv8vkZB0/poi4w3J6oRVzWgFPXSUEiNSDLymzcrLVt0/fKrmOsx5VpiN/yaJNGa
         G2/ZZAD5cgHEaz+Tp0C4okrWJ9Ur9+FJ4K7Qu91Cz+/VSCNX23fGt5y7h18e+5o/6WiX
         4F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884472; x=1794489272;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=23xE/pG0PxrZgDnTN6o56S9USHdH1/BEwYK81Qphu78=;
        b=jvCeSLQWJFGjCrwWNotnJMUNLpcgh26wD2soj/IpDzPknuje2rkPr2ZeaNXGZyhpCS
         m82qdvuywzzleekYlyJ/h1MlCEOz1cg7YN6cNw/0rLfCR6U2b2+95FR24Gv5s7h5Aydj
         eCSx7poLrm6lAQdvnY72UwHWojTPJXSv8oeYYMYW+v/XTAmUhjs7L4gVvsBDATiPM4pm
         fJ/BQzImKQx0lE3jpKGrgNeOc+chTVe2XPq9G0EvKRxDAVnuSPEOJwh3u46H8zBVOFyH
         5aVPjV1kxIeevf6hBZpt6ntgWLxxddWl/S5yrpnz7MK5aeSyhLF+FItegbNmz/GB9etc
         mahg==
X-Forwarded-Encrypted: i=1; AKwUvByB9DlI1+jVFjmORug1Blqy056j2imjZn2JjyY/baUXcGxixL3i0sR/u/siAMwRt+LHMozilPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z893QqjT3+szoy5gpvg7JLGX4MuRRwE44iaRVvJ/bULtodBixYL
	MZBk1+XRR9Svf9DWg03PG6JU9rITId+z8z7EaXZYjfhov09OiWd/Sso2xOiTydpV4s+NZXzqzeB
	ePDvy8gSGivH35jScnV5Sig08Q7ojFUXURtor/ObYWWvgvQbK5pARbR9UOPbyxierJ20=
X-Gm-Gg: AYBFou2pCbtAFKNuUVGKmQ0SIKwu5QgGgeqcynzOTNqtzE9x+/JWyyyZkQeOxQ1KDmh
	DUKZNl32AJlQVdFH16+6FpFaJuKDDq9beFg64AX1rc4jmGT0+U2RtmxyUJXcpxFBbBUOdmc39PC
	KOOO+clYdckArMKXijHqaglohGJpJVlSYigYiIKwh/isUlpz9UkhWqFLI3sU/0zL9dAdElnZkFa
	h5QaQqREBkjSUUKD5Vg111vdjb5MiLvu0IGlfdLs3mQ2bsn8YjqYVimCd7W5upelwaR/5eCwBBd
	47ZVIoYxKbKzyJdTOap+UWAs1WqV0j0JSuq2lItd8lvOOQXeqH8agytuv1WwXWjeA0RlBuPyGu7
	ZpSS96OZRIJcraN7eNEcNz6fbifuW6fWQN5MwuL+Znda18S3YD7G/HRQ9Tn/03ZHyK2CHYOpy/a
	eZ8A==
X-Received: by 2002:a05:620a:a8cb:10b0:93f:2ab9:7294 with SMTP id af79cd13be357-94430bc5284mr1978057785a.29.1793884472192;
        Thu, 05 Nov 2026 05:14:32 -0800 (PST)
X-Received: by 2002:a05:620a:a8cb:10b0:93f:2ab9:7294 with SMTP id af79cd13be357-94430bc5284mr1978054185a.29.1793884471727;
        Thu, 05 Nov 2026 05:14:31 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ea594cfsm58427225e9.5.2026.11.05.05.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:14:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 14:14:27 +0100
Subject: [PATCH] gpio: sodaville: fix use-after-free bug when registering
 the irqchip
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
Message-Id: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADKB7GoC/x3MQQqDMBAF0KvIrDuQBNuKVyldRP2xA2Jkpoog3
 t3g8m3eQQYVGLXVQYpNTPJc4B8V9b84j2AZiim48PLePXlcJLPlIW4yTeDVwDH9oZwUYNeEGu8
 aHXxD5VgUSfb7/3zP8wKZe0oPbwAAAA==
X-Change-ID: 20261105-gpio-sodaville-use-after-free-0824e74ebe18
To: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mtZCRkkcVp1Pu8MTkbPwoYXRgIxey6b4FJwI8ZeDJrU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7IE1+YCaN3rfSgsz490/sqXEUn/d0CQdL3/3b
 4jl2xeGVMSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyBNQAKCRAFnS7L/zaE
 w5RPD/4mACSFED3s9lgkJASVoQ96FuxBAVSoSz7sJPe7ON4ttfxDlSOQZ7SFV2Jrtn3lfqXXq7C
 TQZOyAiTJlC+qarUYkIR8eieV2YudN+Mk9sdCrwI2xggU9l6rjyocu4M8wQde5pOGKaCKfFC0uf
 cJUVgadk+5qZS2694XAgy0mpskmeQtnYKyJuz3KkkQi/rEAWu7iFcTf13Gv3DjovTnD0tT/2Sr2
 DblPBPpBawhrbjpsGPzx6PwzyT97btbk8eAoOA3S+0GGREE4onSndqkjLIKcflHymc3zCc4tYXv
 kfQwoy55h78c9UCR/2URIGs8gNfeZK62fNK1rRlYW5msPsgTN0sZcwBSMMTsHUcZBVU1f7MTHkh
 jAfW75kQgmesLjiEudM7PREIOJqpo/TB4NbYj4HAmET/MeasIqg1ThslL5iHXbxiXx1kou/Z/6+
 8HGk2JsBBVJh5mYKsvOp2Xsh9RQUJdo1lw9INoY/Wdy86E7+4ovsquIyRMXD/ql8nNzkLLmToKM
 Y5dZGTTpPzE6yskZGhp/64kH7hVc2BlgTpkNLxu37MajFmh4PdyTmt9ulredKHVon3+YMj4PL7v
 6vxeskvmrkmVkg6zW9EKLcC16lqlYwHAGtNidvEUgkKkfn54Z0Sni4DLcODiBbgQZ8UQmE30nLh
 QD6nGUIANxxx1Yw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX0BRlIIidVHZH
 HIe9ZhJmQM9mTSyO765jefEQs1d49JnxjpRrWZaVxnNx2cahz21Ugkh6guWXrRM38pl2BAExi8F
 f1cJcY0Hl7GnPZefT0E/TgPPVtDK5ew=
X-Proofpoint-ORIG-GUID: b6VN_o6MfhkTAPBwLxHLAoQdEHMPDs6k
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aec8139 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NpnzE1Ya6WnjZ8Z4SpgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX1Jb/+V+HHaY1
 Rx8pr9UL61n0OIb0pM8M7jqzMrefLenpQqfd8q+HfJVnK/qNm4finj2Z3rds3fgpK/iXOgufqZU
 Syoxw8XAdCkGNYUtWmgUVD/L+jNYKDzVR3X5P5hj2G8GiI8YSySWyfQX+5Vw1Ikk08IYJdzViW4
 OXHBm4IkYIq82F1xgyyxp3tzq1QqMrKi5xMrOwg2uQPRbxtj2YH42DVtYYS8flGs3HLuJKEroJx
 z5xCZhyWn8eAqUJUUyoctyRZz86Jk3z0/TlkeFQaNDOTR68YpeGwCqAhpyyyOiINyOCwCAkDcEP
 MfOpfp3oHOgCa4oU8mzuM06HQIdHrEI9XRPh9ERGkHMFrAuTFtfqWm2OfewWNX2tB96YU7VHCCI
 Sn1KVQbpQAM4ZYOY407JfOFtr98NJ/JdW7wuejOiVEaF1fT0AsZw0r/zaUga5Gqtsn0we+EL6rA
 hb2IqTe3009bKQy2xgw==
X-Proofpoint-GUID: b6VN_o6MfhkTAPBwLxHLAoQdEHMPDs6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

In sdv_register_irqsupport(), if irq_domain_create_legacy() fails during
device probing, a generic IRQ chip is left registered in the global gc_list
while its underlying memory is freed, leading to a use-after-free. Use
the managed variant of irq_setup_generic_chip() to ensure that the chip
gets unregistered before the memory it uses is freed.

Cc: stable@vger.kernel.org
Fixes: 9381fc5d655d ("gpio: sodaville: Convert to use managed functions pcim_* and devm_*")
Closes: https://sashiko.dev/#/bug/linux-2f7ac8b6-5034-4ff1-9afa-5700ff44e3e9
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-sodaville.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index e2a784df275c98699dd625c48f14a3be31113920..4ae38d964bfc1f4191ebebaf4716d544183a9e8e 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -166,9 +166,12 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 	ct->chip.irq_eoi = irq_gc_eoi;
 	ct->chip.irq_set_type = sdv_gpio_pub_set_type;
 
-	irq_setup_generic_chip(sd->gc, IRQ_MSK(SDV_NUM_PUB_GPIOS),
-			IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST,
-			IRQ_LEVEL | IRQ_NOPROBE);
+	ret = devm_irq_setup_generic_chip(&pdev->dev, sd->gc,
+					  IRQ_MSK(SDV_NUM_PUB_GPIOS),
+					  IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST,
+					  IRQ_LEVEL | IRQ_NOPROBE);
+	if (ret)
+		return ret;
 
 	sd->id = irq_domain_create_legacy(dev_fwnode(&pdev->dev), SDV_NUM_PUB_GPIOS, sd->irq_base,
 					  0, &irq_domain_sdv_ops, sd);

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpio-sodaville-use-after-free-0824e74ebe18

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


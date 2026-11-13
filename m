Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576173;
	b=DY0YmObM9sjtVtR55xYLOvzeAuS7w/DkGiIk5hYnQb16ykHraBZNAfFvy5oRTjxJcwCg
	 P03xUayeZClA0smDSkzyfbXic9RQTvl0zJoJiaS8LnZShkDTJoN2MjwHfPnUtAPYkwIlU
	 /5K4MLj7thUxnV25bw+NE9C6yu1NvRHJwUOVUzkPpo/79i9gjbpZnYfogVbv62Sfu8HKC
	 D+635Erc3MI+UXLA1NeUCtFB1659tPyhS+Q0fyS4q1U/Rj15eAf4zAYMBXiJ4XREjQr/9
	 eH0pAEKaACjTWg9sLW7TYfOdOytgauBtAkaOj63NJkXMe4LzdRxqUHqnWA+3/TTq7WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576173;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JQ8+sqq1Xi1ve9mdblMlJkMRVEsyvQ5nDwDvZeW41Gs=;
	b=cZ7RJQbbgRLfRLk9WfRczJ0atY5G6gqEmagx6MIRIooo81RXGoUrs0d2HFg6JGcdXs/l
	 djsnyLYy8ryPsOz1wpETD0qFiOaouX0vgWX3FUeSYJNo3iLcylfmAe9LKKWjAZcHoXYzm
	 leJS7qmO9xhkD91SbC4vQqyUTJ+jr9iB3A+7Vuq+tdydSygi2mvxHVRr53gudMZCrKjJO
	 xrqbTyb2TXguoDUPS6k2bhVw4Sd/maDhD6P/aFrz0CHzzRtqm+gqCa/6dmaZUCJnr/56A
	 boCRRME8ogwJ0CYRElznWeXZXGtgXNHwO/hCFicrT1t5VPky7CTcePO05vIwQMbHkGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oMTuOfDt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Bi/yjqyS";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40599606BC1D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40599606BC1D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oMTuOfDt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bi/yjqyS
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJVGJ3771919
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JQ8+sqq1Xi1ve9mdblMlJk
	MRVEsyvQ5nDwDvZeW41Gs=; b=oMTuOfDtLwIhCAMMQrqJDvu1g8VvXfY/A7INZm
	jEnf5qOM3O1fguSHZZ/V0zfCkxa3IW4+wRD8vaY+ORKs8g7mdHkdsbSF7t5pOoMb
	Yn5JEz6i0RNgSQh1Ge+rp8qy8V+QYE/wXeJlhMLcDhNLIX6dZ4rCCYqFbkGfHWY0
	UKcS2Hnau0QLyyG7tDgAIVC7tiwk7pLBH2As8bPzuB/jlqoWPIymFaFYWzfNwAmJ
	e2E5Y5AnWnoz9cskvXKZr7KgM/AEH3CDzPAOI1mxaUVvZ0Q1sbl+ktkoH05eKJx3
	m6+K5bl+WjT4rSHo0gxiiIY+1LN3BHnw80aSP/InAkpFFSNw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2msvq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:22:52 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b155f4eb8eso15484857b3.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794576171; x=1795180971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JQ8+sqq1Xi1ve9mdblMlJkMRVEsyvQ5nDwDvZeW41Gs=;
        b=Bi/yjqySXPsCcNrK1sbIDb9vAepeJas+8mL87kqhJennwt8mH91WEwWGk5gkw5VeL4
         xoZrgeMN9qTINoHE819FYT364BiFilDGD3Fe40fXvDXLJEZOZdJbenuJbHhOKf+Dqb89
         HzYsWhRHwNYEuxemrp69KDomyPcuXUIQeQhR3CEGKTqE1Dl5G4nwY0KVP8mO1RHFDBle
         8oxmfBdxcvc0kYwdptvnnbY6QD/kmqg3ACefamtsY4T3w8+NfVocxwCoxPnCboNhvVyd
         vNVlHzEMaQROTTjS8xB8y7H32w/5F/N6KCqHRSBSyau9DdgS3BLgBKto+w94pxPV1kqi
         tN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576171; x=1795180971;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JQ8+sqq1Xi1ve9mdblMlJkMRVEsyvQ5nDwDvZeW41Gs=;
        b=HUUjkdmTHYmopbAzg/yT2v7bXGM61ZooVn8/U21S4JggMPxkenhtxmEl+Oc0Au+VCq
         zbV+Mx+DB5tqPJ1VbczANfT4HeLI2oYSpMHVW1wUJe+9gWjkTAUkXDTLG/q4RuPL5Gjw
         GEq8qjM5+QP0Bdnjv5em6lriC38GZee04mkhOl4kEmfUrf6v2vZqx7ThyOfiLIaWXF6C
         IEeao4urZZ2Mv+CW80OKc6QKbgObJRo8RKyDds4Q7weI5IX0Xyl/p0r9KyTY+KCEzl/f
         AZc3tXmIWDE5m5mvLINkMrPWmK7DlZYNDFn/hg1SiE9c8SvvgDJePGg4rLFGxHbCZ9LA
         My+w==
X-Forwarded-Encrypted: i=1; AL+hErESG+s0ZkhCJbya4mz1keQKyOR6rngSnIB1tpH0o48GMgjY4RQVXxUxVyVzalPUNtlvxby0BK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z4eXphUrp9jHu3KA7k6Ku+22tyxxAe1tEncwaNE1huIgXO11P
	whwIVnagaI/DtIOfn9d4IJ6Ok1zXuB3tDyPKB0MmjZ3T1a2JWJIRC0B13gTngZt1zrTYE0uF6oY
	gx0aKTrJU8qRh6UxSE09bVC5k0oxPHlVoRGfklxRMjN10hfDoGiG18J3q6jk=
X-Gm-Gg: AYBFou38tJ5oRUN1zZG5GLuxNx6LpFkqpo225Ssg9CY9PWTksQpJK/e8Df/rGwIkGVY
	UCowXaVz7+GyIOLRgk5ydC7HkrrOQt9QGjsIeHIRldpATT1ublaOcCsvdslBu9B+eWkB/SQ9jtK
	eIG7RiNJL0nc2oJA4y5jEcFnlW/ggPA0MZpj4NXaPxEcnCfy16Xo3oiQLM925042S92N2+dRuSP
	6aV9yKIHPlceJdPfFLcA79sJBRg+g9obegWq2Vds+/JpsuS3RAdcQy00oGjCiN2aYXru0DbjDN5
	MziMxedmOJX493RLmeOvHaHkDgVgzVwidB/oHV4d8nCV/KjEEf7eFhwEVh5A3IVc9J3dk7wmrEg
	DqziCMyzsWW6cl54OWOVBSAgQx/JRPMNqR1UPctiykYUh5IFSJ/5Sr07+iyQCIzmigQ==
X-Received: by 2002:a05:690c:6983:b0:8b0:8ec8:d4df with SMTP id 00721157ae682-8b4aa2e6c2fmr14709027b3.53.1794576171507;
        Fri, 13 Nov 2026 05:22:51 -0800 (PST)
X-Received: by 2002:a05:690c:6983:b0:8b0:8ec8:d4df with SMTP id 00721157ae682-8b4aa2e6c2fmr14708887b3.53.1794576170997;
        Fri, 13 Nov 2026 05:22:50 -0800 (PST)
Received: from x2e.localdomain ([108.208.224.205])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa957df4sm19614737b3.20.2026.11.13.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:22:50 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 08:22:46 -0500
Subject: [PATCH] tee: shm: sync DMA memory for the device before it is lent
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
Message-Id: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACUP92oC/yXMSwqDQBBF0a1IjVOQaj9IthIy0PapFbATulQM4
 t7TJsMzuHcnQ1QY3bKdIlY1fYUEuWTkxyYMYO2SyV1dJSI5zwDbOHE3NWyf4FlcX9ZFXra1gFL
 2juh1+y3vj79taZ/w8/mh4/gCf1QRWXQAAAA=
X-Change-ID: 20261113-tee-shm-dma-sync-12f58435b81e
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: KwxxQ7yhw3UhkXrmUWehDvH4qqDL4v-D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfX36oqJfpOZn7o
 9o39m1xFQYcpxMjEbJyUBxNYcXiifLT6ku6SIGPXFCd2NNMtFkjw/h4XjiA4ZdUne5chxv6TsMN
 IWLWCuBSTNMQID0HmEvv1bx/bMvXfr6PVBQHLn0EgZi7y2yc6QVWUfx6YcSgi0+7H/SwmV5JuFi
 a3SMtdmbd9RqSOo8ZAPSMGe3e0qOZWr8zZeJbTvyX4lHVxIo5z7A0LyMNLcSLgIbWhhMiAeGxAM
 AE1+kaReQCcSUdhlCJzUju+QorUmIEhM00utqEwfi4HXuAzy2rdQM3ovb1c5zB1Mgd7PRvyg5GG
 kTnyZZzp6uHy8anYo+csOnWIJ/x5ChipgWF9W3D4VP1iu9RlfSvkvHerljlTKUMrazpjF/JAKIW
 m5f/WQCjVNVThTXrQ95JPwp41+e9Cf6k3LEB6fwUSr+Hq3LvzwSVslO4DfHr851SjpKYedf5mVt
 LnpgxHxTld9HWqpZaHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfXzssPcmYeT32V
 hoRCH3bGBqBBM6eUz/1iIAeRBrd1hw3ZVMadFz65PHx9JIwhFWilHBEFu3mvlaBm0NCy/BZXfGp
 ZdUaP0fuRqxdsyPO7eOHb/GIY9qnds8=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af70f2c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6jbKIeu7AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=of0t6A3Ksg6zxwdynqYA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=-0VUF4iAjVmhXKmeMUOz:22
X-Proofpoint-GUID: KwxxQ7yhw3UhkXrmUWehDvH4qqDL4v-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130053

tee_shm_alloc_dma_mem() returns dma_alloc_pages() memory without the
dma_sync_single_for_device() that the DMA API requires before a device
uses it. dma_alloc_pages() zeroes the pages through the cacheable
linear map, so the zeroes can still be dirty in the cache when the
optee protected memory pool lends the pages and a Secure Data Path TA
writes them through its secure mapping. A later eviction of those
lines overwrites the TA's data.

On an Eliza EVK with OP-TEE as the FF-A SPMC, a TA decrypts into a
protected buffer, a read of all RAM through /proc/kcore evicts the
lines, and the TA's digest of the buffer no longer matches:

  frame 0: 0e534d8c..., reference d98ddba1...

Sync the allocation for the device before returning it.

Fixes: ab09dd6d9201 ("tee: add tee_shm_alloc_dma_mem()")
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Vincent's direct-map series [1] cleans the range in
dma_zap_direct_map() before the lend, which also covers this when it
can unmap. It returns -ENODEV without any cache maintenance when there
is no lendable pool and the direct map cannot change (arm64 with
rodata=noalias or rodata=off), and it is not a stable candidate.

On a dma-coherent TEE device the sync does nothing. teedev->dev is not
configured from firmware, so it is not coherent today.

Without the fix the TA's data is lost:
  https://lava.infra.foundries.io/scheduler/job/554467#L2262
With it, the data is intact after the scan and 50 lend rounds:
  https://lava.infra.foundries.io/scheduler/job/563840#L1979
  https://lava.infra.foundries.io/scheduler/job/563840#L2008

[1] https://lore.kernel.org/all/20261111110738.872947-1-vdonnefort@google.com/
---
 drivers/tee/tee_shm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 5c47a36916c45..70a273a425f88 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -297,6 +297,9 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
 	if (!page)
 		goto err_put_teedev;
 
+	dma_sync_single_for_device(&teedev->dev, dma_addr,
+				   page_count * PAGE_SIZE, DMA_BIDIRECTIONAL);
+
 	dma_mem = kzalloc_obj(*dma_mem);
 	if (!dma_mem)
 		goto err_free_pages;

---
base-commit: e21989d08e0d6abacfff71387d0cb36dd96a4079
change-id: 20261113-tee-shm-dma-sync-12f58435b81e

Best regards,
--  
Tyler Baker <tyler.baker@oss.qualcomm.com>


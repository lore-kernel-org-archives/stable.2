Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C39425860
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931125; cv=none; b=OSJQGELiEgFsFKVyVbetocxuFTLHerQroH8xCGz3a+LeteEl3CDGPJod1D/g81hMWCT4liL6dIEDUI39zQNIjmXjaqqEmP68t9mGyB9T4IRqAnNFFnkRgzn9yFwhghryQVG+Tgh8AksfM0SDl1rB7A74FiANqbuHJhwYlP7pZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931125; c=relaxed/simple;
	bh=hVwQCzCUVfRxvw/2Itw67jSlR8bgByNRggeDv/nTJpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jngthQ1WeS3OQasDAdqvpxTIz5vOnEDVvpgZoQjj1/4+lC+MLOkjIOjW5ttttkQSPlhgKcwZMAbQXMJxz/Cg7ohZCusMs0i+aEBw+nQSVwyzUSeV6wHB3BVLpi4ZgPq1kSgnVETz1Cm3B6o1c8IBHI4mivY2KCAn1mDWLxn2mfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cD4qiwJw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gp48u/0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cD4qiwJw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gp48u/0V"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925iroc671552
	for <stable@vger.kernel.org>; Fri, 2 Oct 2026 08:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Qiva3P9QlNLK7cQUkmFLZI
	12yKqi2cNC+lMiXVGWdk0=; b=cD4qiwJwlZVo3MXt1OVqj7uRs0DEIKxrXx1zfR
	ecmHxGIQ1wJXX9SkHlVFMa/W7wkdv0hLKfzZH/OhslUgwcGus1p7nY2r9No+9gsB
	hlKvVhsO8YZ/UNEM0/PjAWtx9bIa4+7fZ2GGkeXy5bx3OYhjXhsP5I4iaQZvJr7Y
	O08b5xLbekZU0WFULm4lzZ6tbJq8Kjmgr07Q58+cbXsB1EpDscjSyNAVDMKTUb8e
	wK8g+zUd19vcdyNSLZltQKVYpBKHGvuqK64HZmbhZrEik9bZuHkE42JoehTl/k35
	z2vjquRbJNfBgzr1YR0s3HHq07ysFawSLDwNqRcUdyfnB89g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tjc83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Oct 2026 08:52:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso282904385a.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790931122; x=1791535922; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qiva3P9QlNLK7cQUkmFLZI12yKqi2cNC+lMiXVGWdk0=;
        b=gp48u/0V7ySZpxcjeMDN+yT6Xv90xWTUwAS9EoAsyc0xEZcrutyYvCsq6ZIsbTkro1
         QBllsON6CSCr5Nj22Ycc2H9cMZBpA4YqZX7vTVLFwihEvAhPyE/yGBO87DMlOadFNyYV
         TDS97gkk9scKrXKGR0xswPAuriQZu+YRJD45nhpxG1uLBds0wFZmUwJvbuyPtZ8Uxgrg
         bmGIgaaYt4bPgOiw7TIaieJqjdiZff6ckwVrXEvqOPAFvNNhF5C/wSFA1+Crzhlkl3r6
         /tmChhe/MxqTDRzi65TDikp30uq/TQhdbSKY6I3hXH4jml5WKJ5yCFCHtNg9yMnR4q8q
         A8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931122; x=1791535922;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qiva3P9QlNLK7cQUkmFLZI12yKqi2cNC+lMiXVGWdk0=;
        b=zci3N03cozwazr8qGoU+XMXk9NdPJIxLwNQr5I/3+t2yqd3DG/oOsnsjDLZwTHV5vX
         hZVtE6fdLLRqN/zHiB16xtRAUddnKGiKY0rWjmV0LucuH97XUM9driHo6VxX/hx6hyPJ
         BNh0RPmYQSxB01ipHFZtQqa3bGh1YsnwP/ozIKt5c4r6F2Wt6MEotqFmA9G6EJQwfKNh
         9ZIKQlO5iQY66QjTZ1eOZuW1mPsqjAususduN6OS54XgELsL7cIfrZwSwoDV8rYppOT4
         XuNFYYAD8LPvV07aH2AE2uchc0bsB1r1b63mF9ANE20ilfKn9eoqDaoW5j6BbtEFrlwH
         8hng==
X-Forwarded-Encrypted: i=1; AKwUvBw9qmulgVN9jdCMRSREbADknRktvFwg2qpu9WkEazr/sXHMT2J+POFwn7SVJ/9YZ9TATZeijUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l740k0D4cNLkOVaubAJ22MvSENpW4Zoe4ndYIRxYEGtJeNG7px
	nnGfA/5z3Pq7i/srEWvspxAhAYFKldHDOG72uZ5dNykunmV1X8EmkvWO9qr4RmAe5B6gWT+NYyg
	F0yi7P8m0uHVYgC0pJGdNsoJ3AJHvbPsHdv6s5wDLd10wpzHF3yquWszco1fC1eIMuhU=
X-Gm-Gg: AYBFou2lP5bqJ+HXjwn1nskIOHfmXj3XjKnG6FoGLuqcwC3pwfhbgngJfGq/QmgbOWD
	bbl6rCwUcjjTKUUTClJy2kHtfk43ZlT/K6UMclUGQGTXsGprXRDCFX0BJ3feSlBD1WtZcVnSjrK
	UwTLY8lIMnGETg5n4jB1zQtux5ccmAtpOPw4oK1+/w47RglTGEappkxGTtZ7p3Irxs2Wd8OXLEd
	CQ61sZoOzVKg2Bj8asREmVYRiGDlbfQ38Ie6YH5MDS+FR1VBktDX0LD5OweWFDie/+Ob6Nfe2Ob
	fqmkfH5w0j9RoR30FMAlo4VBnQbIQSdIrDlOwapnzKejW/KD/yQTr9phJrkin1xHQ0CnAl+97Vd
	ZjMSy/sz1h3GpVr20+jv5V9niMBw/
X-Received: by 2002:a05:620a:7111:b0:93c:8544:6ad8 with SMTP id af79cd13be357-93cf16de661mr349881185a.28.1790931121570;
        Fri, 02 Oct 2026 01:52:01 -0700 (PDT)
X-Received: by 2002:a05:620a:7111:b0:93c:8544:6ad8 with SMTP id af79cd13be357-93cf16de661mr349879185a.28.1790931121041;
        Fri, 02 Oct 2026 01:52:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104f89sm4680561f8f.30.2026.10.02.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:52:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 10:51:47 +0200
Subject: [PATCH v25] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKJwv2oC/x2MSwqAMAwFryJZG6jBFvEq4qKtqWbhLwURxLtbX
 L4Z5j2QWYUz9NUDypdk2bcyyNYVxMVvM6NMBQAZco0xhMGvOK0ek3JxemL0sQ3kutg6CyU7lJP
 c/+cwvu8HmgSmTWMAAAA=
X-Change-ID: 20261002-bam-dma-free-irq-cac4b268c465
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hVwQCzCUVfRxvw/2Itw67jSlR8bgByNRggeDv/nTJpY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqv3Cq6QO+/JOipZx1bSxR4XL6wfPPDB/FEzUOX
 Ows75CaTySJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCar9wqgAKCRAFnS7L/zaE
 w3FSD/9OpFXDiBntLFPnYz+Re01JWPxn1X6epggjdDWMFMp3HI8ayErb8YyTV0okRqKOXrzLQ6j
 nns8OfiUXTp5HMZx0WLuGwqb2p3UYZzPWihxfiCf0vCsDMZiHNeBG/BZx+pbUTYrcs7zGcyI1Ai
 /2N4b/QXHyGX7jdyntYPDenE5IXtejMAIMsQpNxSSid9KKvM1G4WVxqKbktCKFDgmc1lDUg7gix
 iPXhrmffy+EhWyE92qsH1G31yFrbxCqAixSNs3T72f6MrjUdwqm+V/Su9z53lwoYCGvfdsjcDqJ
 2+Lrzfjq78Cn8R1aweGGR5n4slcsoXYOs60lhKJOMk2FEn+dl94/+tbVs5fPVc/Gydkl7njAR0I
 wGb1Vd3ZIY5HyvYlNus2T5pwcMHMGb6okbrpDbMzjIERsPqpgR0Q/58SH3oG5HMvO0uOKUFnBgS
 ZbmyO4YwfmKm436r9OMKgN7cFGgOWDhan4omoFNzY23MojMUUoAWpX1EeuRdR/6dozc71hM/INf
 w76EwUn9yLNfdKCEhiKiULathriQ39VZhvHxvT0cmuPnqDSlwDpi622m8jyn3fMmDpHF+PevaBN
 XI2Sk4ZT2OEPn7m1CyqNkOwWcXjiudtfbU8/CbFZELUnlb4GdJwSGTEkL5e8Te9J8SMF662mlKQ
 CGOTRrXhk8dqyqw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: fVOkScHqPdBywDGYVg0C8Fbhei_dNXfJ
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abf70b2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=sdHaY_b6le-me-Zt7agA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNSBTYWx0ZWRfX+plIqS69TaNJ
 lq/Z7StUomE4WJRRqDmH5kjEJPFq50rQw/Uz73e9sEtb+fUNCq47cic5kFeYlCig97iK3s7tcYW
 1TjY3AZj7WPT6b/LCoio0EBO2fFIWjJYFpbZ4Fpe2uHEG5uxJc6Dd1GYzzkDfjKdYL7VhttZBjC
 CJQ9YjcSAKoFcsqS8fWb+Y131QuyVYMVxqRzCkAdrXDTlla5Xlbwy6VRvT+xfI79zjpNajZlWMn
 kTZ0106pK6wAosdAARPCNvpusuP5U9UFxqbjYuf44AIAToUbQIhGF6W6QmHPQnLorCOPb17OdAp
 cYXt06n18hIlMw4CLK+DDLfblPgcLHT/0dArM5O2jKAtDkz1sjwx2Qy42UUI70vFvdS3YwCfHAx
 Ed0Q2f1i2yWuvrmdsockzjq3caPOcp+b3xYzESoDrKrLS8O4QiGuNZioKWXPNZhqcWF/aI0S0Xt
 A5TkM9BgQXARyCvN6qQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNSBTYWx0ZWRfX3F/vIbI5M5Gi
 WeejNccnm9478i/0BVpsbWjlVOCJrlF40zX9LnqGRRIsLzMr1sI2B2EpmxhN2SCKZk+KFLkP2gI
 NyVk4AC6ENfQixOyQJxlF9+jdhj1DHU=
X-Proofpoint-ORIG-GUID: fVOkScHqPdBywDGYVg0C8Fbhei_dNXfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020035

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Cc: stable@vger.kernel.org
Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
This used to be part of the larger BAM DMA pipe locking series and never
got picked up despite months on the list. I'm resending it separately.
---
Changes in v25:
- Don't touch remove(), it's not wrong in its current version
- Link to v24: https://patch.msgid.link/20260723-qcom-qce-cmd-descr-v24-0-4f87bb4d9938@oss.qualcomm.com
---
 drivers/dma/qcom/bam_dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 05a3b1f9e0c23dc5f861488fae03494867970523..a626746b5c93496e5c5e885b35a856d38c284448 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1366,7 +1366,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1385,6 +1385,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1410,7 +1412,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);

---
base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
change-id: 20261002-bam-dma-free-irq-cac4b268c465

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


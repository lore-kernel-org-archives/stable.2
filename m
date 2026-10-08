Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF048AE06
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451877; cv=none; b=HxuANGGHI8qz6VQV5ndJ8ZyC4w7TFdGxrewOg60KXxBAF0vG0Rijg3+7ZdiC3p9K3TL/JSqNYlttT9IpR5TcfyB9CSKIrDrvHTXieNClQRJpNvbmkSl6yhLgjHP9amQ8+uXkG5qclrMsx6io7aR7KxN6mONl2bwfxwDSTLUapVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451877; c=relaxed/simple;
	bh=4K9BvFlMKHfQ+Lv18CAMV9myI5c6fMcJfPP2KtshmTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J+r5pIRGFWPBOJxzUmAl1hsyMHBFi6yzL6vFOeBSOpAGc6umlINv/GW97AkVhR3SxR3MAzVPNfG1gWVtZkkI97jb3tJ94wqFgEuiCSP6GQkkoxUHnlPrHwJs/P0wEma31WgLzt7cd4ciNAc86U1Syph4vpM+E8DQhfyjlYp2bNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SPaHxSBk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jv2oBvqB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPaHxSBk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jv2oBvqB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KdiZ2686707
	for <stable@vger.kernel.org>; Thu, 8 Oct 2026 09:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w2Kn2Qmc7ugy68f/zjB7Cv
	OIvn/yO+vxbW0OIAcRWww=; b=SPaHxSBk2mSHlmHyBO9uywimHGGjzd5b0Qyn54
	39FA1LNxTQ8AmZ7QBxva+ivr22S4bTs0Khu9w5flTc5BS49WS2KjkWeuZRU3M0Wi
	Qzz1B5DvSYkFjHYQyimps2wQme7KS3HdxsGOaxj25dQGKSrTpq81bXnPdxwWZ0lm
	zZpeLBgaz3QEF/vR47YHbqMlQtEdm+lw3VtCQ9shJUtjRDP0x2SjLk0RQHJVeZWD
	tnLHpITjY6dd8rgCFs3rowIRf4W6j4zbQQtKWRKBPan7vxP9k20oGobW8ii4j/Eg
	Jvv36bM3fdZrZLJ2MYqfBxs6ReLXTGN2glA1VxGBwc5mZzcQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe427fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Oct 2026 09:31:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so977231785a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791451869; x=1792056669; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w2Kn2Qmc7ugy68f/zjB7CvOIvn/yO+vxbW0OIAcRWww=;
        b=Jv2oBvqBXPvt8BSBbf7HX3BXMZ6ylEUukSN6Cph0sqlC6KhGx3CZHhMXxDKSoekwbD
         jDubrbouyfI5K98e+xTIzX4Fi3dBBlomU0wBNUrmlG3/sAW7MqHj2RsR+uUkWinkXl02
         ts3AupaNhwqXAfgxl3Bf1KOT0fYAcgmwqFBlVTHoriXqSShuPL/AxXIIUt3rEdcNw2Pq
         U1KO1tjXBh8HDTXYuFRE5Yvd7tdDQabz9T+ZB7bI+CUzEkziUByqBzx9ZVxFWa2YNf1S
         tiE1ouYelpZFVbaWhtiww79kvuMlTmUugOhqRVYd8v5nrGBlK+wjJjuJ+6u6QRB8MRpv
         8WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791451869; x=1792056669;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w2Kn2Qmc7ugy68f/zjB7CvOIvn/yO+vxbW0OIAcRWww=;
        b=d+lXb2fgJVXrvzZbMZqDBwUF0qDvIiEfHzV1eqZGyMAPYvk0HFBDMKe2RINMtdTlH3
         ZqfvEHGrZEnX5/+E0rCqmAqhXDWFom1dfJyFPCHk2YYkd4IK9tqLIJI+EQ2HReXe4xee
         SZxvxSu7LosWmMvhMtU3gNRk8NiWEv2xxx7WQUNRt0MJERczTyqWhpHLNRDJfPbPsFbq
         qXp/dNkqkH4q5f2FE7z3qlkai98Oy4Cj6OGky1SmxphY7ylg6wApTZqE+7GelfICR9hT
         62rkIF10youYityAhBGrxf3o9OYEltuJBco+pKmJANBzrF2lIDSGpoP8THK4UEpsUURt
         Vmqg==
X-Forwarded-Encrypted: i=1; AKwUvBz+jWgYOLzRDcx3kvXmmuxu0sWIcvNOA8/ZUZxJN8Rca5If0E8Y8OPjk5BuLkeO+W8lG0E3WmE=@vger.kernel.org
X-Gm-Message-State: AFuF++lACTOtVEwfIr6+m3DekctMClTVGwdvANsdIhAt6XOhdX8cMBgT
	eMgy8voj7nB3gMcc6Prv6Clhov2/wXnm2xSm9u3BANHMxJ7Ettv0TPbxMKCDyEqU8vmGrb0kjUY
	aa2aeQ4hd/5g7d8MSATO4ereOp2hwA0fxGL6ENcOEvV7/p/LPSprGKTngbtI=
X-Gm-Gg: AYBFou1M/Py854XNnBOoVspYP23EuFmSy7DXLY3GggQkXT3hQJ2qTh7+CJCwCGfGNa2
	Ka6bFXUKpwBQSyfNLP/Pfj7Wb4mSC88OHp6NdFRFidkuQUGq1BDw0emZMomWxWhQ/1czMcD9ERs
	9AOfG1MrJ1M673+TH6RVFbntu1vbsnN0yXk0UiNjguRF1AW55I1jT9gkkbD244efTjZshFnh1dP
	z9FpTZHATMUjlr3ZSEIvV9nryaAG8hAk0kZkS8RonhvlPz/i1Q+6qJTQrgf2gRxAEy/SRfVvZrn
	vjHa60xU3jylnliDWLtTeooNnRormbTRuc95Qbs9OwZr+Vlfe6XW0nkSb2i+OXM+1adNb0cBpdO
	OPAdCBOWNxuXmKPT4KGrqPy9i7pZO397EMepP0eg0WplW4A==
X-Received: by 2002:a05:620a:4102:b0:93e:5861:34df with SMTP id af79cd13be357-93e9b7e0695mr912771285a.47.1791451868615;
        Thu, 08 Oct 2026 02:31:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:93e:5861:34df with SMTP id af79cd13be357-93e9b7e0695mr912765985a.47.1791451867903;
        Thu, 08 Oct 2026 02:31:07 -0700 (PDT)
Received: from brgl-qcom.local (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843bd060sm72236575e9.14.2026.10.08.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:31:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 11:30:56 +0200
Subject: [PATCH v27] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-bam-dma-free-irq-v27-1-660e70223e3c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM9ix2oC/33NSw6DIBAG4KsY1sUAKmpXvUfTBcJQSYootKaN8
 e4dXXVhupnkn8c3C0kQHSRyzhYSYXbJhQGDqE8Z0b0a7kCdwQYRTEjOmKCd8tR4RW0EnMWJaqX
 LTshGl7IieDZGsO69m9cb5t6lZ4if/cUsqq39R8MNyqktWmDc8Lbl7BJSyqeXeujgfY6FbOos5
 K8kjySJEoCtdM0L0xT8QFrX9Quvj7UeBAEAAA==
X-Change-ID: 20261002-bam-dma-free-irq-cac4b268c465
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4K9BvFlMKHfQ+Lv18CAMV9myI5c6fMcJfPP2KtshmTI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqx2LV8XwxmUipbG10DNX/knwzlW9TCpiGjbcOA
 qIbJtWPJsGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCasdi1QAKCRAFnS7L/zaE
 w3NDD/0W4ee5YF3dX7AKjagavsGUi3P6FvO749+FP1JhLtnrPym2cMfNHKH9zrT5cimn9sU+Pqj
 PhTMmT4DSDzK5gR94rmz+Bx6F+6FQ9z2AblM7unV0z1lbhkd9ZoG1K1hYjG9zOe2vpI0UT5Q89f
 PmBwINwCcS6aZ9AeEMXUZ5ljoitaO8Op6SYwlsWgga7nhkjVON8AaXdUmCE6h/GVN45uS4lN8cx
 sn2229cVn5DUGhMEkzv5BRbqYgtTMboefblQeJSEF18CyU7gtuOTGtwZUXKnbMzGMuA/UjYGX4t
 tm8FRHfciPXvsaufR9eNHdpwL4TKrmYfq7YSKHMuk/+IgHsrkZyGCIokWgPY4S7fPZe/N2LBjlQ
 qazHA8TD50mOPPSkLRi7jT8ebLwiQsT8EbVNPQfFf3/sqGp+rp4FHjCk1EGGaZBEPMn+EKrqHDS
 nn4leTKo0fnpgWQnQ/+9QLlWKE9BgogHME1DeSeTouI4SVVW7hKmg6Q9BqQqgu7YmrLQUwrtYBx
 s7kWhV0gwugPX4JY/wG4l7GKQ9vhzMItDBeS3GY3LMVqhCFFQAqEKsb8XtUw9D6ZRvgEukknUa8
 1BMdzIOGnopZaVIIb3XybZXVrCTk1WBBpxtdcJywLP1dcVnMe1odA+cI4fvQv1d2QZBkkud2i+a
 4rqYY+8Bs84QBIQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: cDVUADiYctMBvUPCGR9madaErxPdBn5e
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac762dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=sdHaY_b6le-me-Zt7agA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNyBTYWx0ZWRfXxdOo74VpumV/
 b7zoo0uR/zwT9yNm28Q9zFIyyt3yClhO228dq5U0J/9p3sd+PNbJjRiyVrwwZWwP/NcsD6DUa6h
 AFnyZkwFxCkfpLFquT5C7P9AKBD6758=
X-Proofpoint-ORIG-GUID: cDVUADiYctMBvUPCGR9madaErxPdBn5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNyBTYWx0ZWRfXzVo6eiBvd5mB
 0V1xkyY2wo+Kk0h7aGw1/VZb4ryCwzpXiYL7xV2cVRmWZn1twVuAqZqfIU7PIsYZunBHdrcR3SM
 fjZyjAPM521/XhJm5Z0tm98p17iZ5YAx5M8J176dmcokJNS+1vqMVAlwrUS3kY53NBUMPFTP0fx
 pqt1wq4iFQeD+ppkl+3drTPdHmPc7JyPbUvfInn36IYTNLaqWKkzuscSv7KEHHkqWQULBqjB6kh
 X3NtE7xLSLpZeqJxvoXTGAX3E4LqFVlSMTYOpv7Th6aFj8zn82+nl7OvMQ1Hj9O5HkTjUhphgZW
 PhIVXUKXW0s9IIqUHfKMzDfWSwFhtyF7jVJFa7DQSvjhVsainCIrox2o3G3gyMM+nMZrgjq7kwZ
 A1s602RqDBP8kyNbborvt4ePBfhoxEvoKQeq3VgSK0ipvP+huq81oXB9kjgQuP2Q+feElBiMGCm
 FkQCpgpW+EV+nI5DG8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080037

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
Changes in v27:
- Rabase on top of current dma/next
- Link to v26: https://patch.msgid.link/20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com

Changes in v26:
- Rebased on top of current linux-next to address conflicts
- Link to v25: https://patch.msgid.link/20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com

Changes in v25:
- Don't touch remove(), it's not wrong in its current version
- Link to v24: https://patch.msgid.link/20260723-qcom-qce-cmd-descr-v24-0-4f87bb4d9938@oss.qualcomm.com
---
 drivers/dma/qcom/bam_dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 94cb957d4b187704e207361d629fde00e3e090bf..a626746b5c93496e5c5e885b35a856d38c284448 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
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
base-commit: 53b32375c9caf793ff392f762236c90f2a062ae5
change-id: 20261002-bam-dma-free-irq-cac4b268c465

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA53D5C05
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274107; cv=none; b=k0y5nUIwrirhyypFyNlAUemOu8mTc+nevTMsEX6xhGQiajnu0iRYs61IS+2Uyyc5Ah7L2bzyTF3xj2eLDWGUhvZ2uNMd8pPmXtLwTRcaO/iOeS+23XEequ7Fsqfu0GZmtFxjhCqLQNX9yHYbZ07CA9jH2Vo/eFLro1JE1BFriT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274107; c=relaxed/simple;
	bh=n+2IwE2+IIr9TTH+v4J6U1CCskevxnr+BzHrpIX+eRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VX7UlN9++40GR0PaR4KDNnIrRWIZ72FuSCBoKmi+gLskB8bzWdNxK8LYbK+j8MYYrCzIt3gD59O6b+mwR7y7cm9KlGWbTdGYpQ6Oe69G+53sxk08lx40eI1v8OSzUDHK+nzNABKaYTLgbyGj7UpWHmo4vOm9kp3YJedgJu+IjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UMz6JkIj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ifyqIjrI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMz6JkIj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ifyqIjrI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966e8PS4103502
	for <stable@vger.kernel.org>; Tue, 6 Oct 2026 08:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w1wq3dQI2RF0LHKjEbpAb/
	nLQYwcZCipMnLv/ojYT+A=; b=UMz6JkIjYM+lj8TwCiqcd8kDaxCEJ3QJPuXz0I
	me5xkeVJZTEX41cGQDAU5FiDyeL3IG2sP1HXTRjzsgcqat0shSgXuBk1TP77I+Lw
	M6oOQ/XARA1vS69FVHsiVWVvTvCDs7RjEcszoQ+9iS23s9bFLsrpbM1gSi0GMYuk
	VQPkqn2tycU08aC8lbBxjLEueFca3qfIVR+7ZtYYch3LOITdQSeQVN02qw70Yxlb
	YRm+zfzF7FvNZ1B1dobWvDRvkQFue6xxgBD5bmX/YkrKJQz5jnw6KgrkbRjt5wXO
	XUtggU6NvKBEL/+fDh3nauePAgEaaYFT5oZ3vgnmdM6O/aEg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0anc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 06 Oct 2026 08:08:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso353015385a.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791274103; x=1791878903; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w1wq3dQI2RF0LHKjEbpAb/nLQYwcZCipMnLv/ojYT+A=;
        b=ifyqIjrIoRL/t5Mob09hYiZrnuN2w+mnsVvCIBzljqhy4ma+BIRZjBB2iOY7YXoWeg
         7kcUpEtCzK06on0wDRaY3AMvukWYccsLjhCm4of80Y+P4Rvyhw90HMoix6TAH3xwyMGO
         xRd6h3A+9k0RiBaXaRbct9eO3imJuLsYvq8RSRTDnt94G+J5ZTnoBfK83YiRGvY6U9wP
         +S7+P+JoACi+GqMDZp1aiXaHC/54Hni8oXMeQboLRZ7pC2U3v04wiJHrZGIFBQcd9O2D
         bm9zd4Z6iZ126oBWKOwBdhiaGk9QQb2mMNotRNLYYCIieEybE7FVkZOY5BJQWfk7DIUV
         8j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274103; x=1791878903;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w1wq3dQI2RF0LHKjEbpAb/nLQYwcZCipMnLv/ojYT+A=;
        b=rPCiX5+rMLHxuByGXU0KHnGjRI4zGtWzJD7SLgpL2p1TcgIYXW9asfyLUwEYKqeK86
         5SyYVP9bAq5scVWnLFqdIiQV/Vp/jktmxe4nfUkwmWViphoZjXmX84cMNYSrZTCYSpu4
         B5zSc+li1wtOs9sCyQMXqvEHsnIiHJ+0BbpaeW+RrmQFtKfhyscxhUYaMVZiCBGG5Dle
         exjmjr+mPzfJkH6F4UsDtFmb/Y9+PeAnquWvpups+qHnmgFcs05nnuFD/OuGHkIBNlZC
         7DyDni97DNOq8Cg9RpygfxGImdFLiBRYzONWeIClQry973wi6Txpcu4jzZDiTV/oeCYT
         HJBA==
X-Forwarded-Encrypted: i=1; AKwUvBzpFJVGhLmmbicOYrPjKjJlVWwFbLEfz07S5/NCOYZy2Mhe3mJNTlzNdLahP2CTqU1gB3mpZMw=@vger.kernel.org
X-Gm-Message-State: AFuF++kO4dZ2GczTBGTiY5gtw3vIi7KpJTzmXGEbnHDuu2SE6gCdsbPI
	D7L+kx09HXCjVJmClgc3r7BVyOAa6a9l3hayuGJQ3CJh7fGUQapNqHhtIoPWZOYglcYucv5UWvy
	TYupXCsHMVhAo8RFxZQKkMzD5DXfo9yc44Ib1pmFusTG3b3gtSmKIEz5WEYk=
X-Gm-Gg: AYBFou3BXSrFLyQedBPN2ea+XG0foN1Zlh00FOIWNy9u+TpVaEEUJ5Lx2iJbDbQHlQk
	5z2mJdsiOrHqE66Lh5gC/0TdESaXYx+jd/M+an/xwM9dSf1oyyHyxJ1rya1TMYTPPCenDSlOb/E
	0BVW/g7r0kXeWfxkCo8I5zZ0uSjnb2TRwj0lfXcILf49EA1r41PyNc9JInIH5Ha8sapwgDwgKGL
	+N6EYaOOulZLY9qVquFs2XmX4Op44G8AZwzhMUE1g4csDVHfI6pyYJ5aqfGwdZVFv5xOfDDYcls
	bMKcarBiTGfFW5Gibq10JaP3v1bK6YyVo9u+/Te0m51vVvYQB+kuiwSImwsiEjZOHAIcT6Yy2iS
	WPSnogWorSm6uosFc63Q8OiclQ/CkplUh9iMPR0NNggdNEg==
X-Received: by 2002:a05:620a:1d0e:b0:93c:c7ee:8087 with SMTP id af79cd13be357-93e8f4a00e1mr107852085a.41.1791274103355;
        Tue, 06 Oct 2026 01:08:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0e:b0:93c:c7ee:8087 with SMTP id af79cd13be357-93e8f4a00e1mr107848285a.41.1791274102886;
        Tue, 06 Oct 2026 01:08:22 -0700 (PDT)
Received: from brgl-qcom.local (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8f28sm72055985e9.15.2026.10.06.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:08:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 10:08:11 +0200
Subject: [PATCH v26] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGqsxGoC/31NSw6CMBC9Cpm1Q9oKjXXlPQyLUqbSxFJplWgId
 3fkAG5e8v4rFMqBCpyrFTItoYQ0MVH6UIEb7XQjDAMLoITSUgiFvY04RIs+E3t5Rmdd0yt9co1
 ugWuPTD68981rx3wM5ZnyZ79YVPuT/6xxAiX6oyEhB2mMFJdUSj2/7N2lGGsG6LZt+wJ1156Iu
 gAAAA==
X-Change-ID: 20261002-bam-dma-free-irq-cac4b268c465
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=n+2IwE2+IIr9TTH+v4J6U1CCskevxnr+BzHrpIX+eRM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqxKxxzTrtCSVZ2fACUSgdbvIPgEPV7kgZM6u4i
 IH1xFgxjU6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCasSscQAKCRAFnS7L/zaE
 wza/EACrJQ2MbdK0GKSxMMBc9JKslW+1nxkjAq/6lRMn6feMA464PvDPc/HsT8VJl/zTzIt66Nc
 NcHRowHXr5tBjJuwkP7alRjfVV1yoCdQQG2jm0pOgWoDseKuCmkFyl8Z1EBae0qGqHweHJnfZiy
 fxafbLDWFfhBJuucjaTso2ea3ujDxf+3uXXH93cMIbxssFz2Opk1zP9f3651HZG7ZafPmjTX5Xq
 SeZA5f7FQMA/uvpla3ySQr++0Mltz0y6k5FI0tNifE2KB2bErXtPdufl9xnl+WnU/km5X1dJCsZ
 nrhfUUuOOazoMGzLFV3hhEVdK+jatpVLrZDRBXkafjEfJfwtKQ/a6vITjRzxfGg0o8Efa39d4rD
 PN6VIgBkE+W2jUptTOVrcLx6wVLqiX5VcAc84X5PTffmHloFWo6r3d25g+CvpYGy57M8ixjccdS
 snvGU+NmmEK5GpvakJLXWXFQukK9Vg1DxD3v/AwWdJeQ5QwT4yRZo83g9kuPLIiYMLLbERiRjeg
 UD4tBn55AGCR0hHQfJ36vZP6Wa1RoPzjOvGpMS7Nn0znqZSBNSd6D2dGelhodg7wVgFTDwsxEos
 giJAVET67ua0sAso6ewHo3XQ/j0bnAdrYrZZTxDaTYHzCHIBk/cqgI+VlaFqAO35Rwg7SepaEVZ
 xIzQVCP6kVqAWZA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX96SLJguieBl5
 mQwIvYFmPNI4Hohci/Enhp+aJo2C1e/794Lo9jKHRraxWJaOT5r3PBGQn/3tC+TSrilSxq1tubD
 9Ju+TzVzVh2bybwbFd7sfzQOBJvg8Fz1aJH9Sk78p8cWBsFTqn4Gel8RdENwiW3kEpQulslYyBs
 GmBkF3NOMUVH0v+T206byw3nBlzWCNuBuie5OkIIKNH8YcRtCeX8coeyGntxMuotdde3Su3Xuen
 qnPGNrN+R+jLkdh+zPtCwwUuRPEwi4EbHvVQjq5KbgB31AhYhwyoSYzf6WBnzJ589zcHB4BjNar
 rzO9QS7ozW4coVnJLSOr1Y+iphKkCL6OIic26uoJm1GEQux2mKiGTgVQHN7phXCWKfiJ8VaXDZ7
 UPdm29+HojwRjGnxdlJthCM02ZM3wY+bHwYmdSdTf7WNZ1Xt1dPbrAYAFczg1iavwg83oG6p1W/
 +/fR6QLAR2m4BfDg3dw==
X-Proofpoint-GUID: 5C-hM1rxlNv6Z2N_sKg0BHQd8Qo8XVOc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX6PLqVgtK6Ljc
 BccYTEw4Dw+EZ/f4fwvp11d3X99MiOTTQghNT+giPYS+1LbB3jvvaPA1pR6mADhr3lb3s0+vl6W
 VyNTDjC07DgUYUSfz7xiiss4vfiwbZw=
X-Proofpoint-ORIG-GUID: 5C-hM1rxlNv6Z2N_sKg0BHQd8Qo8XVOc
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4ac78 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=sdHaY_b6le-me-Zt7agA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060032

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
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20261002-bam-dma-free-irq-cac4b268c465

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF543D4EC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610908; cv=none; b=lS2a1VzDEw2Ahx2ZAvG9MMZgqJqInXkwO+j5eGGvLSmlrBXQLL6WV31QS4Kk19lie6LcQ3VHz/6pBJ/kDCfPfqS4sIoRrzVqTrUOarGgzVLs2MkqH5rP6SrhI21cmZWc93KqKk8cU0xB+RR4zPpNxatWOo2gb5trfBZoR+q6gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610908; c=relaxed/simple;
	bh=IkcWGshUEa4u7dhMzEQVwaerWwxFO++zUBrXJW6rS0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NoBQfviav2yeOlEXdOcFtOLGBs1chr/P1GPWrci2XusfNMnqvBaRKqwt6GljtuLwV6p80pgZex5C2nrRES+wAbYUmCV9a5t0Y562Olcwy+uxppj0dFxJY2EbNq7OdtFob22TZXrNx50/ggANkw2wZst4V4xVX0t7D+ourfDDw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7N5Lq1O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZBShAU1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7N5Lq1O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZBShAU1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GA9K2X2914540
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BqZE6aH27VWQfilGircM46
	jMc+11CYdxAMP4Jw18oyE=; b=N7N5Lq1OFoJ0CYokMHJIfzVUE42feUuuPAlMCW
	bSyiqjlXwezZCSZI9F/oa97kHLKqVxOj7anvgIpmJUy0Gxcr8X80b6d2mKK3mSn2
	1U2R9rHDuJcJXsRYunJvEbT5L35aJLI0zy4x7fEbScFp1SNvoCHbIWYY7kA5objE
	WMtOQBIPMw0+QeK+Tvz4KMYjYmiKpN/0u/ra9Kuuw6j6zQOs57R85nKxxmT3+fAL
	3rxTeiwjkZO6An/VLpzWfV+21F05CMl+8PUmOcjhQ6iRVK/jbNGfYtFxWx1mYb10
	QQayrxpiLJJa9gLx3kpqT/kPxUhVicgjtgjIlJtHqj7o8jnA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1761b1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:55:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-842446a3851so2399215b3a.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781610904; x=1782215704; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqZE6aH27VWQfilGircM46jMc+11CYdxAMP4Jw18oyE=;
        b=RZBShAU1r4mVUAEY6NAVlS6cabAgs/elnO92K6A54fnkm3Qtnq7+2EMTXi7FoBWO02
         wqsbtL3Ypzy60y8GGVNkWTxBC5JFpjAa7OyanarbCo+jd0J9U5y0023QKaV0CfBViDmj
         W8H9ieZdx9lOuyASQW34gZXOoDJjjz7Zy0jQ8y6z6/r3u3Esb7mlXxezRejjwlOsIA0x
         +Jn93K3XRiW0fK6UUqtkW3gCqtFfk+RbwFtN4hIscjSqDMnbQM+9VefBdkv//bgnYddW
         +796gLj/2W8F4E+vVF8GZziY4h6kF4wyko0ciyPRyRrttxkOWCKWpGLX2Q82MqfZM3fD
         c/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610904; x=1782215704;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqZE6aH27VWQfilGircM46jMc+11CYdxAMP4Jw18oyE=;
        b=KA0C8/Rb5ZuQrukb2AiHw6ebcz7YWUxSghC7lSg6x7tFjD4LwRl+lkmJkw+tzumITr
         KlemDEGUxoPQOndzDfWRCuFVshdy3IboFX9QLvMzp98rJXOAsM9BAZ+g2lGuVQc8uy20
         pmuQvcAeBsvnX7y4FqfaGlSUg56JpR3gPQS7HwQNrYaxEdc6dWM3+Cyl6CKHisPk6OPK
         5LtXYFqvybAVpEicvBdtBUJsI+GyJZpL6AYBOzsHQs6suT56zQyOubudv+TxBCU7934w
         IETm4CRPTjWIg9rKGHa1/sUGU8aXODZFWu6Uj24iaTtZlGdt3FrkjhFBB+dovZ6RYbm/
         rtBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ioFEDWymZsLD0cCAITY5Z2DwHGqM8AM9JK/tDJlqBccGIg+0hxa5MaDRtP6wClHyONoATwIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZYq02mwh9oimn0TUpmLYmkENsioBy7YV4xc54kS86U6hCBwu
	tLp2G+xBlpRWowPTm77h6APy/kerwB9WTCn02eca5SX054MVskqK8rG5Iv4th1uQiy6vBMH6ZUy
	5tFVbjYCrevvxoAc74FFU4xUeO4bS928re8P3Ic1xQemqr0CxyJqja0vyMRw=
X-Gm-Gg: Acq92OEJ7mRYjqwL8Edi3IA2gswgiz60mMnvK9+eGkGKF9ATwV8ZHW5nJjURbZXeVWI
	4s2tGG0h2j9vhS0G1KYt4w9XfUCO9XLHaTXS017llg2bXt477dKj4yv/mdC0VOhl+mgs8btSKlB
	IbBiEWTgJOI1noTJOO7gZHOazjd5EZirRbBN8NoO6FVu5YRUgYdT6FXJedfak8QaXDwc+5riuBj
	lLooyHVCH+RrYMygSKDype0FwSOGZxXKUSLyLAXa01+0LBd7CZIeKONJ3AWbbm+tPR4KWKGmYky
	p2I5Emd0G39OSN5HpUvHLF+2ouwQ9pkuT3th6KnmEXVIjmx3HuvmbEs9T3l0KqYT7uLkXLXh3Tk
	k928VUwK2xZDOcjaISOmVBJWE9pfLx/4/PaVLfYGCo8vj5Zkmyfc=
X-Received: by 2002:a05:6a00:1907:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-844e1ab9f5amr15874128b3a.43.1781610904055;
        Tue, 16 Jun 2026 04:55:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1907:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-844e1ab9f5amr15874098b3a.43.1781610903559;
        Tue, 16 Jun 2026 04:55:03 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf4b5csm16050549b3a.23.2026.06.16.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:55:02 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:24:53 +0530
Subject: [PATCH v3] pinctrl: qcom: Unconditionally mark gpio as wakeup
 enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIw5MWoC/5XNSw6CMBSF4a2Yji3pg1cduQ9jSCkXaARaW6kaw
 t4tjB3o5Cb/HXxnQR6cBo9OhwU5CNprM8XgxwNSvZw6wLqJjRhhOUk5wTDJeoDqKW8w20pJu2d
 ntfFY1SLlQkJZFAxFwTpo9WvXL9fYvfYP4977WKDb9zc3UExx1gAXdUtyItKz8T65z3JQZhyTe
 NDGB/YHySJZKpZLVYiM0/ILua7rB21wq4IgAQAA
X-Change-ID: 20260430-enable_wakeup_capable_gpios-cb9439ae8772
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781610899; l=3105;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=IkcWGshUEa4u7dhMzEQVwaerWwxFO++zUBrXJW6rS0I=;
 b=63/ySxmq4UtHp74zjtRfXCIVzdA1nKbfE7WhjCV7hFsTX1yJph99Hoiu7jCnjvdAcpGXY05M0
 dZta5VjWstWAVVUwVYWl8QdLDmgBclpumiWMGiMuBcfMIu4tufXwvQj
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-GUID: 9zkQdJVzihJJ4s-drqZFlpiaUm-yCoWa
X-Proofpoint-ORIG-GUID: 9zkQdJVzihJJ4s-drqZFlpiaUm-yCoWa
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a313998 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SnbX5S4nitk782EHpS4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyMSBTYWx0ZWRfX5ALm5atp7acX
 eQFsee4xSIG5ctgJa4mJo11jBaTQva7VIKPH9JCKPv7sj8hMJl75ZKTbRKUeymm0rj3BjdWvnAn
 r5HhFyMXdkTHuuqwig8LJRa+LPEEZQE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyMSBTYWx0ZWRfX+pT6vFjT8XYe
 bcGwfhB47btm6VXzCektMCvq3m/PW48XOOlnfngmqSl6YBWNuloZ4Os0bVj820HcX+Q+/u9ceOz
 dfvGthH0lnZeVtvjWtQI10t/+s16xuYgbZR/+luWTVPoZ6GDUHXMJQTKkGZ8kwrW/kjbzLj5Re9
 mRjg7kdPZ9nICmBallJ+P+0UMSkppleVuMZB8UBaiev2t3PbPxEoKth06u5VijDFPAPs1H3ZSYf
 iMs5zJEV5iNBMqcbTy+fEfhHt4fErhGKnlNMKsILG1KHGdNNRM8x4P9bP3x7brJ6HthoJqjz85Q
 4xKqlVBK4l5Dchk6sXbLzoUR1MS/V4B2FHC4u0rkdnc34ZtfHANMmLX6yRekjOihcKZsQ8V/OF/
 y72nSG+K7PpbktjOhmq7lUgB5zTlDL6IYZ/9yNowta+COnD4i5uskW0Z62cNS/hDFpxKbTQbs37
 tQW9cDWfnc1oieGBYaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160121

GPIO interrupts that are wakeup capable need to be forwarded to wakeup
capable parent irqchip. This is done via writing to it's wakeup_enable bit.

Currently the bit is set only for PDC irqchip by checking skip_wake_irqs.
skip_wake_irqs is set to differentiate between parent irqchips MPM and
PDC. It is set when the parent irqchip is PDC to inform pinctrl about
skipping the IRQ setting up at TLMM.

However, the functionality to forward GPIO interrupts during SoC low
power mode is needed regardless of which parent irqchip it is.
Without the functionality it is impossible for MPM irqchip to detect the
GPIO interrupt during SoC low power mode since for MPM irqchip the
skip_wake_irqs is always false.

Remove skip_wake_irqs condition when setting wakeup enable bit to allow
forwarding GPIO interrupts for SoCs using MPM irqchip too.

Fixes: 76b446f5b86e ("pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits")
Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Reviewed-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Changes in v3:
- Added explanation about skip_wake_irqs in commit message.
- Link to v2: https://lore.kernel.org/r/20260430-enable_wakeup_capable_gpios-v2-1-8c26ac795318@oss.qualcomm.com

Changes in v2:
- Modified comment to specify MPM HW as well.
- Spelling correction.
- Link to v1: https://lore.kernel.org/r/20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 45b3a2763eb85405fecdd4770ba3d4ab684563f0..6a24f9b5e4a979528ba6b5b87fd297c2783ec765 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1242,12 +1242,12 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 	/*
 	 * If the wakeup_enable bit is present and marked as available for the
 	 * requested GPIO, it should be enabled when the GPIO is marked as
-	 * wake irq in order to allow the interrupt event to be transfered to
-	 * the PDC HW.
+	 * wake irq in order to allow the interrupt event to be transferred to
+	 * the PDC/MPM HW.
 	 * While the name implies only the wakeup event, it's also required for
 	 * the interrupt event.
 	 */
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+	if (g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
 		raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -1275,7 +1275,7 @@ static void msm_gpio_irq_relres(struct irq_data *d)
 	unsigned long flags;
 
 	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+	if (g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
 		raw_spin_lock_irqsave(&pctrl->lock, flags);

---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20260430-enable_wakeup_capable_gpios-cb9439ae8772

Best regards,
-- 
Sneh Mankad <sneh.mankad@oss.qualcomm.com>


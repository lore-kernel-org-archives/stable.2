Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAD4AEBD9
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552637; cv=none; b=oRLKkWJyv9mR6vgnxXRaGoEmqbZGP9n5oJOrDoRBQMmJjT9ZTOxLfn0UbyEk0Y09Iv1mIpAPqJd7Jp86lH/kG366DOcvjPnIR46SnYKOoloRjJGBY7bI2QQ+x//rmMyi6JC20NxtIZJS8cjv60G5quuuyzfwomGYEnzBWLM34mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552637; c=relaxed/simple;
	bh=9WzHIAv4+zGjiiNZyV6DfLgFv2m9+CZ7DYDWVGUfu0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qV+fAUn/XkcJcx9boNKB+jDxErV1N+4n0htM6Uu4hHJ7It/mIswnxQ7GbS5vy/+lvMpGhmeH7ex39e1Big0CGQhWFRBpDfx5LnhePBTBdVSg0LLnekVK/t/05CBm82T3jvTPb3LNxkIDbDFSJDkdMWZNvOI9zvMNWEDrxsqpH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKlMMfkn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCCLgjYj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKlMMfkn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCCLgjYj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92fu52477683
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EjEYqVUMD/QfVns9KH5KAf
	c1J0WZ0Tcq9NRHRiudLcA=; b=WKlMMfknpOc0OUE3Ieh6CT8HELyebpo8/OSzKK
	SiB7WBbZ+Txs6YRXRHErbV8RGHrDi9vPQaVzOiMgBIT270swPMmul6Cuq2XeK1o3
	yjny79ErlKcXeTY5Fv9ihRKFcZV/bhfbJFlfGIgU3gD0XAs8XIgeKRVP+emk6tCj
	x5JUQBpifNlLCYwqjm7iFtByXR2lpRLO95BzBDRCqQydFX2yeIyltKFmAQ6qb4fz
	QghjPVse9FFzIc3bOmFp3e0xVNCy01Qcbf77tlelDL8fYyFRVh/YFaswTg++/iVd
	XZ2jU8srqRnHZSg+y9wP7oqJheqGUbbRKRYm7GtBjyPtBhIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqjcksqak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:57:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so7768470a12.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789552620; x=1790157420; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EjEYqVUMD/QfVns9KH5KAfc1J0WZ0Tcq9NRHRiudLcA=;
        b=ZCCLgjYjGNr2eWD31V9FHpg1BzzuzlRWrV8c6/ZH+AsOP0qFT/6m+pYTnwffthoWBd
         HOLt+pI5yif2AV0hSoLXrLG2/115D9eQZkEMIz0bEbXMPxHJjyXhGlRpCJFEJ9Ddqqmr
         k1VFzbMkvSmpLCYn1yGMKTTFek47QMYFe7rM8PW3WR1rIQArDtPmerObgKJxsxOOisc2
         +q/HeKgLpAUBWlt/1vY7Ac8PdK6YRXFF2EYRTdwpDElc6bESrGVqIcLeQcB3vVLXngbJ
         HhAIv43WdF0ltIbyhugzvSgY2SKGDIOCztcIgCBja4lnq/y2fO7hRYnuXYg0P6irZxbc
         DE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552620; x=1790157420;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EjEYqVUMD/QfVns9KH5KAfc1J0WZ0Tcq9NRHRiudLcA=;
        b=bMZb8b6DNLVojNuFp4NL00yj7JIDj0cgEr6qUVdxW9cgo4kbHuotPAMHJtSwYVAQ8u
         91IOpf8+uwQNFgH/kRmLf7B5C1uk/Ar/gioUt/1QcS/ZyWXAh7p4x0rjIQIAjbuQFe0r
         n2GvajEMKqjkniw8wyjSBMTqp4lJSVXKJe7oqFMuMhzzgcmoWfcxYI0Mps2RhGAprUQH
         XQbXWKMITsmPo0pR7Or8jpi3ozkg3QydF9uESeK6l/EVMwaf1RnIer9QKyIdb5rubX5l
         DxYNjulr7Tptgznfwybc2Ios5OEbzfzFMVGQKiuxnazcy8RB3rfkr62+qaUGBTU/pGmX
         cxBg==
X-Forwarded-Encrypted: i=1; AKwUvBz3qlJFIZ5z9WJxDj6/uWuPR/oL6v0d6wy/QNkaaw3gP49qVv0xN9bQpXVPblOqv09kzub3cqM=@vger.kernel.org
X-Gm-Message-State: AFuF++kE42+RChgJQdv/GuL98odn4dRWUZi9pw9g8E059AwNpm0DXHfY
	XX9OnTkAh4eLElUsBiosLrsHrmjySLwgGMO3EZmjdqzv5wmfAI0Mc8lzXcpvLxNpN0azNJapY95
	bCjPb9scmwhMKBukti06TeX8vLesfTgQXm4bUs9qh2tQd9z17RVs0i0oTjUw=
X-Gm-Gg: AYBFou3UtbX0/6V5qossgjpVtH0oxfOzlPgjkOukx3wXInxtUvXAMzt2hksZmptRiVn
	Y1r3fYAl7rGD1rUP1LA/OD/CtpMor1pMw/r++Ad2/Vf9gVx1/Vd16FPdU69hVtCwvcqJRPdW1IZ
	QBrVTQ+bzddVcE3mBMFIgfn+6JMzV3AQRliqPXtJy8eWa4+7OAUyZoMLt/pGR1YyCVDLX8pAerX
	jasT9PC1eslMsYRrhnP5GStO0eGp5CYGq8xLSgHJDk6U5+T8leedby0T/Q0X2P+ai5b75A2nxa/
	Dw54o8/jBEWhzBOo3hV1ZEoc8i8wuqnDnDdAhsnL7EWxRUqCaJ0hTn4V3HZTrvh7+gWe/jDEV0z
	cz/oolddY80xfCEZHdn+XSN4Ac5wP9CRYO8S8Gg==
X-Received: by 2002:a05:6a21:138f:b0:3d3:ae0f:5268 with SMTP id adf61e73a8af0-3dd5f72a0e8mr5268074637.20.1789552619944;
        Wed, 16 Sep 2026 02:56:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:138f:b0:3d3:ae0f:5268 with SMTP id adf61e73a8af0-3dd5f72a0e8mr5268010637.20.1789552619480;
        Wed, 16 Sep 2026 02:56:59 -0700 (PDT)
Received: from hu-anupvish-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b0520asm6990313eec.27.2026.09.16.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:56:59 -0700 (PDT)
From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 15:26:53 +0530
Subject: [PATCH] mailbox: qcom-ipcc: Guard against NULL con_priv in
 send_data()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-b4-ipcc_send_data_null_check_upstream-v1-1-bfc61f5056a3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAORnqmoC/yXNTQrCMBBA4auUWRtIi8boVURCfqZ2tKYhk4hQe
 nejLr/NeyswZkKGc7dCxhcxLbGh33XgJxtvKCg0wyAHJU+9Em4vKHlvGGMwwRZrYp1n4yf0D1M
 Tl4z2KeRxcFoflNJyhNZKGUd6/z6X699c3R19+cZh2z4mkZJRiQAAAA==
X-Change-ID: 20260916-b4-ipcc_send_data_null_check_upstream-072b8856680f
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789552616; l=2110;
 i=anup.vishwakarma@oss.qualcomm.com; s=20260805; h=from:subject:message-id;
 bh=9WzHIAv4+zGjiiNZyV6DfLgFv2m9+CZ7DYDWVGUfu0c=;
 b=elEIKGjpOqengBZjU8VqAN91IcqocVSmYBFJqzsmVj88/XsCQ8QIjN/s8SfXD31UVru1Xp/MC
 TxBfsDsQP0hBpnW82LiJbGiLcNklTYFs1x6q4grePfNBV+nnkyHbe1B
X-Developer-Key: i=anup.vishwakarma@oss.qualcomm.com; a=ed25519;
 pk=Y9ilCu91UQrzHOM14SG2IjnmQ1QSroH5uVeBSWEmEDM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEyOSBTYWx0ZWRfXximGmWwtxliE
 ecRtwF0Nxzxv08J5OSonkc8pNvUyAAe1EsTm9t6nymqaWNTsKUf81ewyA+Wp+dwElyYa78OrgTI
 mkkoytRUeae6G8cg7ktpPps10uZw6jY=
X-Authority-Analysis: v=2.4 cv=PsIG/AM3 c=1 sm=1 tr=0 ts=6aaa67ec cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uR8SbD86SFq7i-S2JZEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: PIOIKxrapRJCFur-1GU5oZ9OSsWJewYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEyOSBTYWx0ZWRfXxiL4iGa72JGY
 ZqLgcSElOQgGQ09KKN6GA+A7HBHZhUTfhHVNo/p6ny3hxMEXBNoaLz2w5tF/xGbAT0QCgukFMf5
 BU6MHnnKcXn4vRaBXVqwJNkyZQ6BQD3PIcFSRxVMYCP5fHZJvcnROMcsd+4kkTGek8dL1G0hgQB
 ZhtXEBgoH4629UHLZmW/o6kHTd/c1QcyBfoXDVK9OQ1lckvlsqROl2ZttI3Fyya5SYvOLzKYKKb
 SWFGygc/ncZr59a9469rKipNprUZxQjiCtrYj8DHuoh1gd7/2cEnIjMSMSklROfuH9W0b2+XGMS
 VQQw5x4a/Xi5GjxewPg0/JVh+uXdvYdLmIa/MK9kGd+s5VIm/ZPjwNa/zf9tnkeAgtd4NQhOeW3
 OQeqOnwWmk6dRQoaucjnjt+gOvE7iOndZ+UlMV1LMF1qrt4LZODomOcHUaEkur0mYjwhj3wawhq
 1SqyEAi8tnpgIuw7PNg==
X-Proofpoint-GUID: PIOIKxrapRJCFur-1GU5oZ9OSsWJewYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160129

qcom_ipcc_mbox_shutdown() clears chan->con_priv with no locking.
qcom_ipcc_mbox_send_data() dereferences the same field without
checking for NULL first, so a send racing a concurrent shutdown can
crash:

  mchan = chan->con_priv;
  ...
  hwirq = qcom_ipcc_get_hwirq(mchan->client_id, mchan->signal_id);

Add the same NULL guard mbox_send_message() already uses for
chan->cl, and bail out before dereferencing a cleared con_priv.

To close the remaining race where send_data() reads con_priv a moment
before a concurrent shutdown clears it, acquire the spinlock in
qcom_ipcc_mbox_shutdown() using the modern guard(spinlock_irqsave)
primitive before setting con_priv to NULL.

Fixes: d6fbfdbc1274 ("mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
---
 drivers/mailbox/qcom-ipcc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 185b63f724d4..387aa72aeedf 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -10,6 +10,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 
@@ -151,6 +152,9 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct qcom_ipcc_chan_info *mchan = chan->con_priv;
 	u32 hwirq;
 
+	if (!mchan)
+		return -EINVAL;
+
 	hwirq = qcom_ipcc_get_hwirq(mchan->client_id, mchan->signal_id);
 	writel(hwirq, ipcc->base + IPCC_REG_SEND_ID);
 
@@ -159,6 +163,8 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan *chan, void *data)
 
 static void qcom_ipcc_mbox_shutdown(struct mbox_chan *chan)
 {
+	guard(spinlock_irqsave)(&chan->lock);
+
 	chan->con_priv = NULL;
 }
 

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-b4-ipcc_send_data_null_check_upstream-072b8856680f

Best regards,
--  
Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>


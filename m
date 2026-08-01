Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F391828
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569901; cv=none; b=s5QbfPzYQg03eh8vZt0HzD947nbBJr8YETSl3J5wDfIgHWaDeQjglgyR8c2KaRX4sW+WrD1k+x2HPgHxL+qpgaPqqa7hpFoVcq9NKRRZKXFNZPZSJ1xlt+ulOa/BQ8vhDfHcuNhpBicBYoMUbubxD4OkyJRDOXXFOO9ZwZ/q/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569901; c=relaxed/simple;
	bh=lM0hNnMe7llCRLpDTIpK45I2Bs76ozytz4T0sGIxc88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4wNfXzCyZEILGy3+99paO64+g2vY0/tJUsftxJqU5k0FQzBIpW5pTrv5sxbdOYabd2o93LcZA6R2uLrq/9b14EPYUY1YFSf5hIHXeThA5ywadpNtW8uCqtcLLrf6f1klecsGNjYPS3H5PSZ6CnSktzZqnppPrXbKRpl7l/il/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G3Ny8H4H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aY43rVcj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G3Ny8H4H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aY43rVcj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713Dfwc2065517
	for <stable@vger.kernel.org>; Sat, 1 Aug 2026 07:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i3judZbl8cBLqAc9XcoVqVm2N10AU762ke6ZkjfT1Es=; b=G3Ny8H4HwRcHY8dd
	Ri73zkMzf17r4Fnt8tlSc+wnfIOKZkl4noDQ8r2z/atnb9kgHkhcpVOCkn6mvfgs
	26GwO6/VGZlXs5pRRwmDP5UQkvJ9VqzXQ6+ainXpTJGYxQNSt1uPlih6c/nqpMci
	PqZ16sgzsxLlHj5MbQzNanb79x/0wHwfJzXknPmACL0e9g0lvw0owqx30N/lnyxY
	xP8pzsT6xGZu99DJ4RBT1OoWrGT+g23+dNwuop5Q0fyYgIzrMWc1Ai4EgPwVzXNS
	0KAeLqp/iCZU/KZoSgSruus6A8Gf4zVMkhcokoPqwF+4HrPOITTVh5cD5Vwm0UPX
	4tQ1Ag==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8q50g4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:38:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb92868263so2265461a12.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785569898; x=1786174698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3judZbl8cBLqAc9XcoVqVm2N10AU762ke6ZkjfT1Es=;
        b=aY43rVcjI2vG/bThKpe+t6WeSJQNVfqddhaGe4g1KyoxDuayhTNkLf/J8WhrPbKkfh
         UoRyeTwoveAuPoU2WcOOpkQZ8sIxoqCJSOoYowrxgKCNlf+tDxsQ9kIdVa6O506VIH7U
         Mr+VmkhivRqhK5RK3PSvw7Tll+lToCX+oB80Wchu5trcc0sTaMacALCVKvVYpKG204ud
         MsAk//5Rtyhx7R520eWvd0OA3+ArE3KdH1TI20KKW+uOrq0cGSwiYmV17huElxkkFGKq
         vrduxWUMwr4E45zG4OWanwpekXWPUR1OpPcmpZcsX9leDD3dtE9v2jL/RNV5XB3ojbvy
         ExoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569898; x=1786174698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i3judZbl8cBLqAc9XcoVqVm2N10AU762ke6ZkjfT1Es=;
        b=fB8v6x3wgSCPhAFueucPB8WUz4bW1MCd0NobbdFx9FWdiuUSwJMvT+gvF7NnfZ5+4t
         hTKWokLiR87NsSVGnUpjzcRpaC1uwRpdcEEy19Glf1Miir4p8EwrDbd/A+1HJH5NK8aj
         U7xpIw8PMFV/FwhEx1WNnloCoPVIhPB+X6/gH/2xe0TCrIq1FyhQ7EVznoToJnDSKWTZ
         U2Muy9UTFgMlb+AfC0XfwILyizH37Ky20KoCYWQoxdEWpORN7DtyFp9fg5L/+bGpV1Vl
         97+oF/B4faurWb7K7jX+zKi8XS/9x51hrK2S3aYb+t1MYGQvbBX6NZanJLa+QTLZLP9v
         4X8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp6IUYCz3P38YHqUqUOW3rAbKKIdcqq+YguJnY0eC0RSAGWNTHev9lk5Wk0dlLV82T1KM2Z4KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwuhHQUUd2RJYJANl2hXDoHVtijJKrOj60ZNFYBqsNaIfB1AQ
	++wKq0I1jzGVATdEbknR4O8fv/SMvTPjsV15ox0dOyLcS9KNKmCGZ9aA0EXMuxjHzIJxkeA7W1y
	VHBziVp4TRwS5TEGmXdXO0KyA9Lse4tsBvwSJNLRmMcLFc8ZtUaGUT5tIbCY=
X-Gm-Gg: AR+sD13gXJYvAbjXGZAiVjpr5F/dkKIrK7fiH9hl+JJBufPi60nmkvH5qOFoWGAso+5
	2aVI3rktPvSIe78kk1IJ1rSyEwO5SIIDSCSQVpTiXeIi+Geu+i4CePN4CjRq1S931Jl+b81CQpx
	6dQ09nfU4D3ufJRiJRMgO3tswvbERq5MBx7S8kH26YYnLFcdj8Sz8IWKHwaXCnML0DgWuF7E3Lu
	rCCenxbnpiwlzesKd2wqva2a2tnfdALHkpFnK5g45k7NFIrCZEuA4DshVQb9jJnOt56keUDXx1S
	n5nvP56Ui4o8LZH5GejYHckaXAbqkzCuA07a7AI9/pINh7CsOPZQFcqc/9AdscYiib7aVWpyvTm
	atbGe/hlajraVmqA+rOSYBKtE/PlsFIPNkQ==
X-Received: by 2002:a05:6a20:6a05:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c92a53b04cmr2587314637.19.1785569898218;
        Sat, 01 Aug 2026 00:38:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a05:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c92a53b04cmr2587273637.19.1785569897772;
        Sat, 01 Aug 2026 00:38:17 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm20729985eec.19.2026.08.01.00.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:38:17 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 13:07:29 +0530
Subject: [PATCH 3/4] media: iris: Fix power-off ordering to disable power
 domain after clocks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-iris-fixes-dma-pseq-fint-v1-3-aba0cb22f6ab@oss.qualcomm.com>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785569872; l=1839;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=lM0hNnMe7llCRLpDTIpK45I2Bs76ozytz4T0sGIxc88=;
 b=ysE3G7dmHlNskzCWWJeBtiFW1iEwM8ls1jFTJx1nT/iwkZyDEDNyzlmJvNLMasB94v6ScXdt8
 d87ncQ1GtGwAPEPRa+Xv95E/VJJSRw98uR2tOmHzgcNYf9N+zV3AWTX
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfX3ghG+db5XZew
 PCdg9lYfPFEz8TUXd5EGxblAQqHo2ie1Z7WtbYhGwHm7zhL2l6XtpQ7tc2X5YBlre8S7T99EuMH
 u5zPKm9dqEE3MLx+nl+wshXFqQC+BZw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfXw5krJu4lZmEV
 JYc4LIbmasrZKEulNVrG71lElIHIj5unYnjcI/ds349NhALsB6+IzlulcB2pQTMHifc6kFWrkfZ
 PO1FNVo1QtHUOvMrp+GmfapWGvtUR4qAh0F8OwP0bClRrvAe3Tk0fKabOJy3taFgDmx11rW0lkp
 hTcA8yZfRBSqegz5oiSUGrcJPWN4f4x2birWEATZc1fhjSVtDaI21HtDJPmUG6uSQ0+nX0Lhern
 3mcY1ENtNQ5RxZpgpKQ8P3FD/YMG4nI9n6ZNOQYPctJUH5CUYh1ZV7uTiHk4eD7c5iSGMu09MZ4
 BVMvYSDBabS2wq7cDxNqVTfv0oJdZPQiwtSGUvNFPnwx5UCaEMK/jk+9nuuzFFahOxwjee/nJzb
 ePxyC/SMw4fMMfrhxALVmHPbwBhRP+JmS+qdlLYz1gakMnWgzXXP+PVfZtUkrYbsfDDZa+oh29g
 XZclzvkfGeU+ouF+f/Q==
X-Proofpoint-GUID: KANhhJxabQcVzsoUAKQLrv38EzFS4I14
X-Authority-Analysis: v=2.4 cv=IYC3n2qa c=1 sm=1 tr=0 ts=6a6da26b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ou1eOjPKtcA3bHzkrowA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: KANhhJxabQcVzsoUAKQLrv38EzFS4I14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010053

In iris_vpu_power_off_hw(), iris_disable_power_domains() was called
before the associated clocks (IRIS_BSE_HW_CLK, IRIS_HW_AHB_CLK,
IRIS_HW_CLK) were disabled and unprepared. This reverses the correct
power-down sequence: with the power domain already removed, the
subsequent clk_disable_unprepare() calls end up operating on
clock-controller hardware that is no longer powered, which can hang
or behave unpredictably.

Reorder the calls so iris_disable_power_domains() runs after all
three clocks are disabled, ensuring clocks are always turned off
while their power domain is still active, and mirroring the reverse
of the power-on sequence.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index e4847c107709..3cd493b06d84 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -223,10 +223,10 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 void iris_vpu_power_off_hw(struct iris_core *core)
 {
 	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], false);
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
 	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
 	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
 void iris_vpu_power_off(struct iris_core *core)

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160559;
	b=YblGLbBSzUM1fRlXMRcWT1UV3chIHerHR5lbXVqhQBhKUpcyLXpL4a/pJ2h91LiWMMZa
	 mTGicV95SN/YFQE7sKcInTPiZmr0bI/dC3GOflKM9ghtPwnH5MBK54cfe/ywTsHRjwXF7
	 /dUG4ciu5x0uHssgKjxX5yMliqlyhh2I6zPzBtDsOf8o8pt03hiCLN5DlZDZBpjaP4GK8
	 ckSRF+dOWx/sZdZUysUcpoOww3G+9RgBxsnRQEo1+6Xd9FPOSevcoU2mmdO8iwSqYv3ML
	 C8mlbvj4dOCdrIaEtj56gr5mpXFf9fjA3/kzEdydolhymOHhpOGPfPj/bdth5yQuN9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160559;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cMy9p57SoBkXCQK9JJ0rBY5bQmP4zq/Gk+sldtVJuwc=;
	b=b8eT9wPOTI5sg1iZdixKWIxRBmU8Ma7BKnnNf5xEVzy6nv9HxMSMg7tDai6E8aUGSj7t
	 QwuBHYBJ/mrVrYeJnDR8aCAZHnrsosX0D/ainibTooGPBl6Hd8ZtHJTXt35L2gpNGXAGy
	 w9tsTyaTZAYaAZQIzAJw0vUHtFlD2f27JWBBY33yvjDpR+mhicpBtMcYq7JmtN7OsiG1d
	 xzDrXv2gWUQCpHDIaGY+c6NCkiBCy1RKd/noZiNZCvJVOPpNFiMHPOnJKLTcA2DeQMM8k
	 /XlBHCoGET4dFaEZQ2FDrb4ggnB3WgdpBik7Oj3fWhykf4RQa2oRnBLvwgTmJ0It/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j6sqMdt9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XHnZYRN3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2D606A338
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD2D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j6sqMdt9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XHnZYRN3
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fN4J650511
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cMy9p57SoBkXCQK9JJ0rBY5bQmP4zq/Gk+sldtVJuwc=; b=j6sqMdt9VG0rG6w1
	RMdnteM9zDl7jpL1TK/myEmc0EpJuDI+JvKhjYJXd4oEECQ6Z/JjXjGSdValQPC4
	o+Kx840biickoJC/Q9b9xB7viUKi3wkTcnGD3O/E3g+o1kn065BDmBE9+fUVau9C
	WxBb26PbhOAKw34PSK1ll33sAWnlwsCs66vuWz0oQTrEm7h1zhYCcjb/l1pthJdD
	3W6Tw+N9jv5OY9TXqHl6/eA4h5VNVFYHkf3T6KVIgK5pXglNEqaMrE9HeffE4bxS
	5Wyp5N7fI7YOvi37TL8zl6Ge37rPat0UKoVFXBU2thh3MKvSg54FHamqMC7rxpLX
	B4Rs3w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyjgc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cde2fadb00cso587605a12.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795160557; x=1795765357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMy9p57SoBkXCQK9JJ0rBY5bQmP4zq/Gk+sldtVJuwc=;
        b=XHnZYRN3ClA2+MwlQ3Puo+bhgh2kw1wm8PoyywMaDV1gETp02lPvrDntNilfjA8ytj
         e+hYXGO7FB/N8PchCClJInVtsskSs64ekddtVxLrYXlymawmlUgVVYPLcJJydKVmf94A
         kU3m+GKaxLh2CWFxBBrRioAJ07szJ5FY2b95AOCZi+oh+/bUVI5zugzvoC5rG+ag9pYv
         BObtoQ4BPhcWz5PAQjOLhyo//g5YtFYod6C7oUaCZALods9Jyty/wYwC6E5B+YHxYMt3
         lfSCHBHXGXHAayC1Wvtw/IH/bWBFIi9bBwFjDyKKTCRRRNHgwYqCZuVuO34GJeA4yGNl
         EbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160557; x=1795765357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMy9p57SoBkXCQK9JJ0rBY5bQmP4zq/Gk+sldtVJuwc=;
        b=UpILHaFIhVUrUdlqslgZhTRkNIA2iuvFtDT/1q/ltM7H07dgUFHTCjasWnEpqP76kA
         72Q49j8Wn28P52OoUBm1HUh7WsXO8gogTal3E2/QVosZRK+kAJqJWShsNuUHTeDJVBac
         QJGshqh8jkcj82SEru3N2s3hWU7Un5baFpAQZSb8TK9nKPeDrzk2h9I6xto9vUuC+Rrh
         4bkGRXaV+0TKuMJ3LsEvymdVbgVqy5+eBmZdFnMHh1XuEuC9IAB9H1g8j9gSyuUUCm+q
         tItdXe3g4X5lDZYr+g7JhzR1JkGUxEo4gfdLRhQPPCp9byrwTWEju/MjAzdRZRFxBSwM
         u9Qg==
X-Forwarded-Encrypted: i=1; AL+hErGwe8ODLOKSzuDTtC2ewXLdaQVF0Ol3/qjh19u8ZaygIOz/iI3A8m7PMN4fnQ9cUTuv0INap3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V3Bzt+DrTUS53SRwxNdwh+585YCUT+k4NPgXVSfglcqF786b0
	78B/vwLPDFoirN4l6YT3Cf2aASIwteD9UmNnzK5AdxyzD6linN5u3Mx/tgMawxceWnb/67TCulo
	zuy2LLtKQC7nc8X+VlI6eCpGtJu4uqv9f5GFVpLbcwHd0ggHdO1ftzeGYKck=
X-Gm-Gg: AZFdTZeQj8nqq4/ANWIFfrWA8CYoPaohqxDPfTdqu3Fc7RA6shTqWOFCntqgN/IkNSJ
	FGLlJRVd2rkZjBeLWEhghLh8LQy6NmdQpSQLyn1FY9/dGeQIj/pniUolZeGQb6ISRdHek8FzkKN
	LgBPdwfUcEkhJ1DYh4wPEGQzUv+u0Tpjum0+tdCuJAPtYj3fTj6UrPk4Ls9HwMZUyhn8K81z1/D
	292855iyrDoVvMxRzuSot6ANqfxgDfmTUXr1gqJC+FhfaCoHn2+bSRmNRLKEvJsqTdAdofTstTd
	sKjFN6NAu82OYJr1ZDfEmhA+CTkp1ft5hLEejeKozjJ0C9D8ww82mVOTfFHV5fCk1nZO2CT8FHe
	WeEmLjv32/uWEdln8H2JOTdGHMl4JqWwEj+0EERJR+JNSs/3T2YQC/n51ORuWVa+EOwQCaTYuN9
	OflswAa5c=
X-Received: by 2002:a17:90b:2f8f:b0:3b3:bd07:665b with SMTP id 98e67ed59e1d1-3b41c9325b1mr1934256a91.40.1795160556576;
        Thu, 19 Nov 2026 23:42:36 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:3b3:bd07:665b with SMTP id 98e67ed59e1d1-3b41c9325b1mr1934237a91.40.1795160556149;
        Thu, 19 Nov 2026 23:42:36 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4323bda5esm119935a91.3.2026.11.19.23.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:42:35 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:12:04 +0530
Subject: [PATCH v3 1/3] Revert "media: qcom: iris: use disable_irq() during
 power-off"
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
Message-Id: <20261120-fix-disable-irq-safely-v3-1-82f9561394cb@oss.qualcomm.com>
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160546; l=1357;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=2I+5QsaOpqK8JscQ/rWi2t79eZPugQinEc5cxAOStn4=;
 b=Wx127EyMvAjyRjgOqzwVx2yiz9pX6rf5qhqKWF/CjT1DMOOOVo5WYVXRERHNye62A7GbjlstA
 Aav2wVNPDkTDr1vrSR7/wTS7Ftb3WXVj+fTKhuPFjETmPEWHdhPHRV0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfX5ByT6vltw0tN
 oimapC6Y4jRhMM+Av1oKUim6RsMA2cQaS3Pfgo/q4BpnXQQIksVpDlYPzCqOIXrTBRYpbLT1Zj0
 4kzKFCDosg7EKWH6y3DaorYATS5g53k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfXwJFWr/EitMjt
 8XBnNFBAxo9uZgOrK3pRz7rt7bMZqpieKw9LSTGUxKiOV9H26kpvKvNMJdj54FjnYeV8Q3t6wF6
 JMYSb5T3NiFBXgQJ1ZbGxe4LKcdAiSASAuBjgrdbSeeev0ppvGCVxW1P4C6LVqaFKUnsfATQlYR
 OL7BBSZCa8j8XppetGfrnLbsQ+X6fQyd9vgrXhEfIOdjrpbt78dI43+Yjt4Nhe5co6yyj3OiJeR
 5SdiDvvlVVMI5N4MYvsookpoRyO0iEC4SHUrEN1ZmEjkY+MFrtIXD/1f2MlUXDmFhUpNaKZUYy8
 w+/OkpppS9F/gR6/qiLo/InL7gUbJaCvZSJYqVJBhz/RjGbv9PxrRVNtBDYLYGdYMS/nZGXcgpb
 RTTSZmYGKH1ETY/1dIMdMZdw2KtEZf6NbWaZFRI2o3/MjvjiZeihFAtA4YTITYBkp9RKaUVSSF9
 GKKUme1dCqFZ6MjghDw==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6afff9ed cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=f9qQdqNCIvW5R771ZgcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: BB3E0dFMVJPJmHIbO3kpPXDqWVED1pE-
X-Proofpoint-GUID: BB3E0dFMVJPJmHIbO3kpPXDqWVED1pE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200030

iris_vpu_power_off() is always called with core->lock held. Its callers
are core init, core deinit and the runtime PM suspend and resume
callbacks, and each of them takes core->lock before calling it.

The threaded IRQ handler also requires core->lock to proceed. If the
handler is woken and queued around the same time power-off is entered,
it cannot acquire core->lock because it is held by the power-off caller.
disable_irq() waits for the handler to complete, resulting in a
deadlock.

Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 243bd845349f..1e183fc4e58c 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq(core->irq);
+		disable_irq_nosync(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)

-- 
2.34.1


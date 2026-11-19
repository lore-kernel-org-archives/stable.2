Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088765;
	b=yCyWAqajmkemsWcJ0R3iGwla0HpO8VJYJjyLmUNKtjL3aIIONGBEdZleuSveeSFmIrxB
	 RAGIb+2kNo8kyn0MMDoyjfCd5Rp2rlyxO12lVZlu18dLHnmZHPLkivKJKJE6H6ZeYkUnn
	 6u9THqpO6v1+b+yxeFp9Tkff1xqo8w3jQG2N/KRxxxDPZHUsZYB1OkfERIRRbIZ05hgA/
	 9LI+42aWGA1u9HgcpTE4WYFTIqv6zuaFNofI19AarfAFXjs7kxmi4byC7cQUwGBtQ0l+l
	 xKqzXrOK/88VxLknAFnuIsFJ0Wh/TJH9MlBEFVt9mwsMwzW2rU80Nny+6AX+hHgm1BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088765;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
	b=j9vlXH2M8AKXWs3OU7HVgBG5egl6hgo1fMhN9sn/UI6PD+8ozdnDJMddzObV1yMrMEuB
	 uQfc2Ef9PClF+JcZovPDnjTxNwO2Ey7GlrkXC6B+gd9SCor2/NDWc89X6XkTfFDikSkSu
	 xwFsevCQE7s7UvWxjmAGqV+IOINr8ZKE/sSiQwsOvoKYeVBEMkwPCRaXb27DmkjADu/L8
	 o73OEvM++8r5Q/Me16/BYJaLR/+vGLN0RZMuLPeamZ4w9PVdWRA4nkwU/2v3cBuZskxTE
	 6fYDwQhkwMAvM0mJLSK79hrhzxwtuPCjWaT7xHyTlJnz540ySllSL8lRzKed+6U1JiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WDOWStr9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kigHcnCh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2A60A2606
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD2A60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WDOWStr9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kigHcnCh
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBk48V976656
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=; b=WDOWStr9mzyuwxBh
	Ydkv7AhoWQcqjQb+t+u7KfCmsDDou8oeLwDPCzk59CIVbwP0sROVTJqdlBrhivt5
	3XKW5sJQg6lJaDX13Gm7cRkZywPTc0cKAEpyQD/x9B92ALJ+QhJ0jEho1Wl0ozLz
	imoo8fv4UaosKn+AYcyIESGfjNikAgfQOODQ4y8exjE1jHSqcExyyn83GEKgQvOm
	49a53cDJRMgyNqBLfQVOdu62ytbghg+y9HEiJNi8e1eCR4kAYmvqsKqMfcSOU2PE
	HvcX7LNBVRdMAn/WHhw25sNeWsdoWmCjyKh8ajT5VSLu45qrG07VpzLDEaX9mrRm
	ZdACSg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnmbg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3a9826f6dso1890028a91.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795088763; x=1795693563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
        b=kigHcnChGfGZgUVRzvAJSLjsWvxTfy1ClPeX80WEx+NcmvUu6aB2jUKno6VOYkYyYk
         dSPnA3SMLRe7I4IK6z4nC5B0xl6pwvaaIJCz+Bufy9NbciY22i1rxisrk1WFZceCcAnC
         JK2n6BWc/nySnx6FWIJxg1Pbku/CTI7bFlW5LEESFBMtTYDzMZWzTTRigEas4HXlncK3
         iMPa4HYV1njYl7BA2F1sEjxlBLrezVHiqydCQTaRchCCS0RX29/zF9cewuse9/6UILiR
         bVxluja7QBaSJWq69PGt9tdi6eeWNA3DJohwm3ImLimqyP1P4St6T45+UO9keaime5t1
         YYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088763; x=1795693563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
        b=N4N8ITaI0mNP0etxpG7Bo5XtmDVqw+E4fQj2j4zFq9tVAKw0pdKxvsu1g8Ov8vpLkR
         29BLB9IfoEL9UUyn3LBa3g8mf+WQHhM/yn6RWftGaEzRiDmLJvCn123il2jbdq3WNc0s
         oS/LRkVMdzsDkTDviYHe9Fn8pXEHa0ERm3ZHIf6dlEprSPg3+ysmoUFpVt96YP7ac55k
         ufDK1ZXSe2g3O+69m4zzm8GCFgNQM9xBmY9boXssmjCSrONlwPkUkHmJr4VuQtlGdSPr
         oN1qryCWapaN5PksmobLQZ6rXp3kM+tcILkEW6WvvVzC2M8uoaiN8dRaRich3bOG5Tig
         f5cg==
X-Forwarded-Encrypted: i=1; AL+hErFgFWh3WIpo882pqKU01WLvEjiyBKQLPE5c2xJ4KxEBP9W9EBNjIv8pahilLwSVGQsJQHQHFtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bXUe3GxHpkL1KmPafZS8uTJp/0j+ECoV1uIIPHtiM/MMcz1gi
	oBNVN6GxQ0mMV3LVeOUKj1RzllNpI/3mp7xAMTLHluAp+/oSV8Wi5kqEeLeq3wTQ51DPpLY5V/t
	veiltcSSPVlZzgr5z1DvRmddRu+3xHYWgnIMgVq2iWErHvKzCJYWFp9rlD4I=
X-Gm-Gg: AZFdTZe7WLVPztf0D+CgyN2Pux1IXKtFlpUfMPkAx0XYC1A2Hzquxmmo0NojHHx9VBi
	ijoo5GX/5fZVOjmUyWvHodbzGw93psbPLewQTjlpUuUWvYD3kLy1PB9o+UfiAYy8Eab76HAAMa3
	ftfypQBdOxHuRRftHUTA+bTRitrmzuFHyigPoItbTR5TssnSChjinSVPO6cxIBGTjgl2M1f2SK7
	qJsfKQP4qCJAgWFMWxEK11AiKIxyRdUsR4NjD/pQrekxVsuRiTpIt9uV2fE3sBgMcAoQRrT5XjZ
	S6kvXzjx0fvNJ3mgwfkCSvgpscQgDDWxfFaYvDPi2zNTXKDxv7QeX6KzDZtbgdawnG+Egs+5VN/
	JQN+h2oThHtz+W5KZniF39uoOlBFxB+AlkzUKly9XmJK3jft6zZZOY1Y2I9el/ixTDUkplkUBw8
	teNpVcY9o=
X-Received: by 2002:a17:90b:53cf:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3b3d07e395bmr4885586a91.59.1795088763496;
        Thu, 19 Nov 2026 03:46:03 -0800 (PST)
X-Received: by 2002:a17:90b:53cf:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3b3d07e395bmr4885554a91.59.1795088762992;
        Thu, 19 Nov 2026 03:46:02 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm2397030a91.15.2026.11.19.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:46:02 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:15:30 +0530
Subject: [PATCH v3 1/4] media: iris: Fix runtime PM reference imbalance on
 failed resume
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
Message-Id: <20261119-iris-handle-unbind-v3-1-52d467a13907@oss.qualcomm.com>
References: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
In-Reply-To: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795088753; l=1181;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=uA1DrNWOT1xdT5YBsROagD86Vd8Mo/RENc8c8k3PgK4=;
 b=IsI5L6EEjV4Qdz6e2J2ZakNsX1pWElNbeF15477Ach5NNo61xxfxA3cpi/ZZ1aB4xMWaK3yxt
 UVJrOvLNc9KD11ApcJcsvtR8WVLf2iGJ7BbmrZcEosCsxYQOfEPOky/
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: QA6oNrPshUQr66X0K7BHuIA8f0NhkWgP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXw7Jh/20RWK59
 EsI09RYVm+TQh+E+kvd1zpnRGRKY+u90BhSATbEdjck+MtwXLmVEsLqmpUtxrLjs34Iq4AxAG3E
 yfPZpnFJe2sF3QEvNqfnClB+/qRjczW1gqi2/jLHPguQ48/VyQabTQbYGs9s81ljT47g4V5798I
 B3+u9VwLtXFaCvSODbkseRBUu+JxzSQglMS6JUtbBz/BA0f7aEARwT6T8ste3oGb2ZLeT3Rg22Z
 kBD56a3+ZmSqfFUzwDJz8ec90Gaf/ZJu/eITEyRvq3IHUNdXo9XdK98G25fhTVCWADJ4V9MK81Q
 yLjNRwx5MKALJ0P1Bu+r0bkEYLDk2QvbXzyn/ddAF8s4mnWDELf6klaFaJdT3cu26lagGv/CZI9
 JDLfECOVYntflq5BjYrqAAmcN9cKMrrtrrzhV+Jw8SjCezHhbEt+MxJXCJ2OqifKZS8X2+ZxaP5
 VoCm9EfztjfjeBCEe4w==
X-Proofpoint-ORIG-GUID: QA6oNrPshUQr66X0K7BHuIA8f0NhkWgP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfX7OUQjPAZ0I3W
 0LlGC+EirBHudQtCFECbUBfEPdDRcmkpuNteJ/5vM32+Am7hGRvobmUp9LBGGqETRhGcMVvBK+W
 D43ozQ4XGtCACSsA1kFAurgKqqKS1Zg=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afee17c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ohPow3cFOKvdjjdYMLAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190046

pm_runtime_resume_and_get() drops its usage count when the resume
fails. iris_hfi_queue_cmd_write() dropped it a second time on that
path, resulting in a runtime PM usage count underflow warning:

  qcom-iris aa00000.video-codec: Runtime PM usage count underflow!

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index bf6db23b53e21..545bbe75e1740 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -132,7 +132,7 @@ int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt, u32 pkt_size)
 
 	ret = pm_runtime_resume_and_get(core->dev);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	mutex_lock(&core->lock);
 	ret = iris_hfi_queue_cmd_write_locked(core, pkt, pkt_size);

-- 
2.34.1


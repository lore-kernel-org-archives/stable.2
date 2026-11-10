Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319910;
	b=OzCR6v0N7saop2lPVSwDXP0DOLFLQO/Zq2lIHuuCYcjyHfKKJD19kopFpwnqwBK7mFRw
	 hn+uS7ITrLD8W1dO5g1uJqNxrr02LCBXmp20SUZwkMueYd/k3VERMXzukUvi1zuT+Glcy
	 Ex3E9kTzdNUXNML0YYbgW+hDg0x9T6C+bi23qw8nvpWuX/gieX3pCpJIT5A9lPt/EF4bq
	 L97ATqYZEfkI9Ou+HtTMLf8zvp2CAoEqpwMFDOQmFVR7xmWKwRpuYyW1SmY8hklL4bBfs
	 9v8mumdWjA2q8CLIIzCeF/4QN5E2tlNTnw/xvIHdiD04OLuhab3J5n+bbZN/NjNXiAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
	b=hwK7CSodexiWgf4h29QxQMU1ffbuEpTp7fyjpg1L97rFypNFmNNCtV5Raz/2utCqH46O
	 9Uup+cI8wHJWWKomQBKvgXnjfImrbinnuR+1t9lkDo5f4s3KZ/SZGsHL+CvO5WpIbsN2l
	 fcu1m/pFehdrPAjUHoCq4iTGcZJWUX+7eHHf20g4+eViyivqBloUlw2JqM3GLy3BBSDFK
	 fzuoUJQ5oiiaUauh1AgI++JMrRYRafW/eQ5lofY04yqfsv/aUm03EISX0uwk6G8oIzueK
	 uFjuH4/v6lIjb4fkZUYvdgcYPL82+rhjPf5bY3X9SAisxnmQpJYRjzf9YqjSvr5P2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=blpI6bvV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aDK4CXm1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2C60A2607
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D2C60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=blpI6bvV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aDK4CXm1
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAE3V60028680
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=; b=blpI6bvVI0nv4wLC
	GBvh/yOu2RQPe6bTSO8Zi48zC4YOA+3DdgJFlraJb3dohvKvsQRE/hnbZ3uvR601
	d1zkcrmuK7O7hKlLbED8tzncGDiCXiX//QBigUEUDkb1wpJ0mXRdKQDU1vPbVOCH
	jlCEbMxV3WTQ4gY4IP1d/C4GMerq3N7ZqoZj91IF/B84B0A6vRzRSQnzx4T0BSAk
	hIIDEvMwkZUPmMQTAIrBcQI32/WkeWZJALbLi2MXPBB+vWPULalQeFopTl87m4ir
	4PxLQn95D6DgOpeMEUWNvNzyA1cpnAmH8SPWxojiiZyvC3JxWtESUDhpOVQJSNFW
	nD0T1g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pv817v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f26e6abe9so3419437eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319908; x=1794924708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
        b=aDK4CXm1IJL4qLFhcsgL9yoMGodZUZRgFdSvkY0XTtneypHAtrPSEdkSwoCL3eg8Kd
         AccNBEcEAhplNIAuJVhNjoDU/WbJVabQLyGL7Eu0bBtIn7pbsQE88Rn+AeUv3cNwugKP
         fwrQ5PsKDOdAniK0sNqXYIixURW6fmtVcuBP4dwW4+Ai7W3TWNSf5P4NIq5FFVv50Acs
         pdqzVR9qMrDFWuBT659zATZNmiSY6KRwwdL9H6bRW9U4ZiEi/oNsbsJnDYZTBWI2Sahn
         5HAyT2DGpRMX6NaxP5FkdnRE5+UrPSYS9a4fuUSq+c9ABuCnBQ3M01TmkNRcYDECOOLs
         zFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319908; x=1794924708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
        b=HxxeyKYTHgElGt9DGd2hE6TJEF1o6ohnlZhgJrYkPz5F9LD5IkEoV4/8+lds8QMY6W
         7r5Y6XnCNUtXkJ90pAnBsLH50QJKDAt48p0N0VNfKaA58FRuk5MhBQYFi8VpJWSVzp3w
         9gzbY5g2e2trZ7MOoXVS1a70YT6d8wslXooTjImoEFxtNvsi+s1TJfrVjaFx5/QwNp6L
         8TmAq4gwCrLBrpez+mitS6lFf3hqo7gfhTjsCg9sPxFArBD/FLDSXcZKDbcrRjp3RJH4
         rjDtGgK3SIJ8/Gzl9i+UZqQEl1gTIStAngxeb5/BEpBu0Dzt5tk3dBwmt9v/DaP+6N6u
         GJEQ==
X-Forwarded-Encrypted: i=1; AL+hErH1yKHy1/6/kpNShbV35H7rw0M4qq0OjgVwHXuc6rRvYN9spKg4ntbXxv07X8qxJqddaGIRpE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KNVVYDjTy889WcI192DHBnDM8Cl2MwPbw6F1JdIIC2yqEQNqk
	bfk8AOyI7tDEZbMg99X77SUQhKjiQ0Tz6WES28TV5QU1WI5Iu6+L4huGHj/QfXhHaEuGyQXyBsO
	5xhNx14RuX+bw+xFmlGqasA5elyG2D/Bh+zD9DMrzsbpuCIf3Dt25Ga0QxjA=
X-Gm-Gg: AYBFou2U0WPIGbLmVoQSdvQIptoVNO8Mt4AXzjU+eLw5Vz6ZfvA2alNCTyk7wlQYNlc
	889J4u2ms10ZghQRC95/emriGYIf3c6zXJDagbfPXOURpAVP6N2QqULiyJdXZPxK9AWlUZeH1DB
	BuyOPD2rRsGXhOMVliSFd/Mc+xy8kKoYGKHrGTT3DjBS6mOaIYumUcy6h/XL8hokgO1wABu9krB
	NlUF1g4th4SCNvu+nAlr3de5XnSP3B1z0eO/A0Pm3w1Kx450nO1ZvBeG+LWd7qcGeiNfKgMVmd7
	p6YOIWq8sEJM/3KG99InOSsqvpqf6jZSSGPVcu4JUoagHPhOdWHS/JcQNkbnZ7wPbl17c0Q8L8y
	eVspJPaM3zJbzkQ1dxcHCDMSfYYyok6IL0NHKh+5N8gtjpmQ2b7LD6vm8jcLPBtpU63eOnPFUIc
	MbCQQixjk=
X-Received: by 2002:a05:7300:8252:b0:376:2e3d:7c62 with SMTP id 5a478bee46e88-3762e3db094mr431881eec.12.1794319907321;
        Tue, 10 Nov 2026 06:11:47 -0800 (PST)
X-Received: by 2002:a05:7300:8252:b0:376:2e3d:7c62 with SMTP id 5a478bee46e88-3762e3db094mr431835eec.12.1794319906552;
        Tue, 10 Nov 2026 06:11:46 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm8059128eec.27.2026.11.10.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:11:46 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:39:50 +0530
Subject: [PATCH v2 2/5] media: iris: Disable the system error work on
 removal
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
Message-Id: <20261110-iris-handle-unbind-v2-2-86d5f6f1dea8@oss.qualcomm.com>
References: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
In-Reply-To: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794319890; l=1393;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=mTtJUAW16Pa3NLyR5lT7gqKE4xsReqod6ALEVe9NOI8=;
 b=sgYIsWk0J+dy5zR0+93KaXAWwXH6anaB/lPVLcrZptFqpFLlsKwfzf3esBGAbCBTIfiKr11Y0
 Zn8JD3+yTXRCoeGqwa1VUCFVDlEm+U4fPN+LNjyiQmq32Rb+/2MK3bU
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af32624 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bZa8m19-NPAJ73ByzVcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 86Vq7YT8RYTaJvBNa2Ml-CUddZtwQZmY
X-Proofpoint-GUID: 86Vq7YT8RYTaJvBNa2Ml-CUddZtwQZmY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXwnfREkxtfj7c
 MTUQqSFAM0ptemkiiFAXfFCnE0kGcPQdq9+wEo+NNUPDzpOP3kZCcGW58tQGzhiVgo2/1JygCsl
 OPpurz1BrEJXA+FVhgI/8dRaBQBfMQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX3WV5CT4pjVom
 YWTbXNm4QSsm84NEdHhhwoeInFLNxu7QQua6UIKzW0574c3InYVWtWkZgcz4AbhgGCrvIm5GWmB
 AI+TPHzwLdjtknFWbqKV89vrzaqtZBUb6FVGmdUDAvxfPa8bhTztEnEQ4cId9qPMR5H3cwbKIiv
 mi5WLZR9vSl5icPG5Ppj/bMu/vi0kQrSMh3q2MhEk0wGdfE+u+Y18YJM8IXAUPP3VOiPYWD8Yi/
 hu6y9HooD/wpO4GUxWSKcRZpyovOkEw5+/SDOr62JAGI2vHUea9Lts3Y/TBkcPmUwWdvRd+jbfS
 I6VtlcAxcNSOcSA2g4kXfA63XFZ4ueOm7fvrBA4gK0v5KydRg9An7El0dzE25USEvufy8au4fqS
 w85EWrh0mKWYSy3HrdrI7ukjRlo3gRl4hW6zOFofqewwz0sjp2kEq8maP07IMbJvRf2QWh0so3J
 UHvZwFehlnB6tTmhySQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

iris_remove() calls cancel_delayed_work_sync() to stop the system error
work. This cancels a pending work and waits for a running one. It does
not stop the work from being queued again afterwards.

A system error interrupt can still arrive after that call. The
interrupt handler queues the work again. The work then runs after the
removal and uses resources that are already freed.

Use disable_delayed_work_sync() instead. Once it returns no new work
can be queued. The work cannot run again during or after the removal.

Fixes: 452480931648 ("media: iris: cancel sys error work on driver removal")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 343e44c6b9c4..6f02bb629867 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -251,7 +251,7 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
-	cancel_delayed_work_sync(&core->sys_error_handler);
+	disable_delayed_work_sync(&core->sys_error_handler);
 
 	iris_core_deinit(core);
 

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E463A7F4C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406146; cv=none; b=ap31Zl4rAuflXhwWXxPDBJ57wycaVsak6xtTLRtNwYwHRvglYmHrX4qMnRoT1uwkn6JAJitDZ7WU8dVqMC0U42A6tM9xkFwpqPiFbn98NNWWijQKNvYF07AeubLgGssPxLNBuZvnpe2NHPQw9dH3in6Xdhc5/cKD7ZSVEZZ9Rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406146; c=relaxed/simple;
	bh=Dh2fxo97rcw/HY7O42KDHhXFkESXOFHYWiIPR09Lu9o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SZTQ8JL6cK8i4fMj3nYoiEqyzDi6uZ4fmmwYeQHNn5WBaZShA+LdvITuQ8ia+x3Tacps4L/CMLY21TV/Yw7SIkZJgnJBeS2C1OJ6RgHbUy1nlx/WDbGAUE8ydMfE9smrcIyNmEEvIzzUUspGX7U/mg1LzMSlO4p5qm7+I4ZvG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDKTdT1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKBzzgmR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDKTdT1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKBzzgmR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674950f2526325
	for <stable@vger.kernel.org>; Tue, 7 Jul 2026 06:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yZfqIHDoqfWte/kPeYZGJE
	lmLBj5Xw+6kjVlLGAmoKg=; b=dDKTdT1uAk8DfkhMz8a2LjpGDV+JXWrWoJOCvv
	bCUYuPkAdqdtiu3ZPhmXJLxV8MgJ+qclIVWXwwj9YTIraRNzSUhGvmEnEs8As/Gt
	MeTQH87y1rPPwI2j8TZXYC8WOBY/yqcrwc3SZAR3OBLaphGd1H3oOP27t95isMP8
	vOAPM1YOwM6bimTyHIHP7hN+wPHQbnimIbgyT1LmGW7pmwqVhj1AMGwuc8QWmHk/
	ME+7eQDq7Xw+owQlIG96uLAuI3GIfdYdNOyWbJoCfB8Hul+Xw6iksZxBU95JqL4Z
	YVA7qjbAcXCjLh3WR7CkQ9LEyRSlwE6Tgzi5uYecnPHKu1YA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98mcxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Jul 2026 06:35:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8478423e020so6147342b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783406144; x=1784010944; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZfqIHDoqfWte/kPeYZGJElmLBj5Xw+6kjVlLGAmoKg=;
        b=MKBzzgmRPcPnWBFosxRePYMvEuqqH2kxz/1bf+KYKqpSTAyARDPWDERfl2oT7ySZ+9
         ysVwNyRRNAgaUkX/KnGviS5T1MYdWIF6XaNHYwAznNOfShfJ2IO7qs+nVqg5Ymu2YnGe
         2zaWLyLPSkA6CUqsUBtqmfYA0v8wHRLmcWwOwQ4I+arzSQ42M9lXgoK61UDZ4apsh4hR
         nGPf8zmDHdkJviVpm3dLUfETH+TEKFxilzcVpHKLQMLNV5aaoJLRb9bTL8A0BB5nYzzg
         TFrqjcPFcB4fThMUxtDYhReA2ACl1CcCE12DROyKVSa0NdnTVlb0VNaNN+vydXoP4EGY
         VvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406144; x=1784010944;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZfqIHDoqfWte/kPeYZGJElmLBj5Xw+6kjVlLGAmoKg=;
        b=ZB4jeT7uvrJm1uh3v3yyE5vRmBHiFzc/UtpgJru/8Xh8dYf2pXA/qwoHrTKlBKMxZT
         WKB8hMw56hFWJ7sXBsATrgb1UYTqEscDn7icn4UbieXvhHMlOl2o9xsbRK99Ydmkf4Hx
         u7iyEgPIYwGyvgs7mKz5YZK+lWXGBHQ5B7iupc7LiqiQg16WtzGfFsGMWnb96nkWRsH7
         CjXJPramlBR+kaVBg149mSpUxNHKQT3OYc9uipSIaWCmytWWXdCE3cnJeQZhodlcqwuN
         p2Lcu2kPkYr3yZVX0frjskMOKqEz5A74Mo+5Ylr0aHQwa9VxQ9P3wKtQoOTNY8vwxJlq
         vOUA==
X-Forwarded-Encrypted: i=1; AHgh+Ro651/UH4HmvONerLR6qY6bUYCJ7TMkMBnU96GR9+uL024SvH9N4suiKk1xKmsgOsiMmxR8kp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTarTNFEF4WpCaxLOYqqqbC6zAtNmSovpS6Uv5rLnQso2r5+o6
	cm8Ik9dteTWfOCY219hXSoo7ojvkP3LDK1xnd+ahOlCvSG4EHyWZbQSiLuN/2lzYtGlUfhjF5H8
	RInRq4O6F0eZ25WSRai3o+OIYXkpZwpODFADuwl6d8ZgSfmTR5XHGFrKMrds=
X-Gm-Gg: AfdE7cn4R/4gAhKps+1wf1hzxjoM+og5rFWmD2hJ43gGwxPxShMachfHbYqvank5xN5
	yIrbBxCd09D5/RxaSh8rlJgb5qt/TOg9QTHRVA5LkgHc2TExYN6Ipzl4RockKOXvQiOmGqTT8kX
	50mvTSqhaCZEvA/LL1uqrBvMAmUA69lS+wqNDi3LBPCiJ5EgNi86E6yxocs643qY8LBaukZKjJv
	/jpfB88WJe/vw9e3sGO5oRhJ+7LnYEUDE2TeoFukedB+JqhPwf/XJu+ITu6F+DBHRy3GLisCyg+
	8vGwbGOghvmus6SoMNKijlKbMcxqCaatSbThMdqxPkQTDZ/cBFvffHWMd9+YW5k3HVoF4DNfhid
	Cn6XTlRKmlt0VWGo8VKeO5PfbaWTndnbYS5po6F6P58/H
X-Received: by 2002:a05:6a00:3a13:b0:845:e1a3:1080 with SMTP id d2e1a72fcca58-84826d81a1amr4000303b3a.55.1783406144198;
        Mon, 06 Jul 2026 23:35:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a13:b0:845:e1a3:1080 with SMTP id d2e1a72fcca58-84826d81a1amr4000265b3a.55.1783406143691;
        Mon, 06 Jul 2026 23:35:43 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm4889973b3a.53.2026.07.06.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:35:43 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH 0/2] media: iris: fix QC10C format handling and disable
 time-delta-based rate control
Date: Tue, 07 Jul 2026 12:05:22 +0530
Message-Id: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-0-33fa130bc535@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqeTGoC/yXNQQrCMBCF4auUWRtIqjboVUSGJDPqSI01E0Uov
 btRl9/ivX8G5SKssO9mKPwSlXtucKsO0iXkMxuhZuhtP1hvvXkkZxOe5I0hE5JoiCNjlRsj8Vg
 DxqBMWJLZ0OB8H9e7bXTQ/qbCbfZrHY5/6zNeOdVvAJblA85kCRuNAAAA
X-Change-ID: 20260707-qc10c_fix_and_disable_time_delta_based_rc-4d6172b395b1
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Gourav Kumar <gouravk@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783406138; l=1201;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Dh2fxo97rcw/HY7O42KDHhXFkESXOFHYWiIPR09Lu9o=;
 b=rt7AYHwVCnoDZ3cTnKurcTiIxWMfKwwzTlf8uk1zbFfZHN6uVxWy7+w5Dlg8MeUYH4Y70vFQS
 KCZGH8+r2/XDYGNKfNG9LxFyvadMtwqLoC6ia4OiShyBT4vdvxDq46q
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c9e40 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=bHM9EGv_eIyXTYkJAFYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfX9naR0TffkbxC
 PO2NLk0cPKpqKy68qM8QgLGMYY2pectA8tjXYqeti/WcbTBtkA48LzHUyvyM7MAMEqGI9Y1WBlR
 /YCfElyKIqrlS9E+KcxsDZ72bMHklHdto8hksq/BAnu1+m/Os68bU3akJhVf1syJ9e28XPgTPHR
 mQovUuMpY6AMB8nuqlFgrEm0pyNN2Q8aFGAqmB/gxEpQn3BjAIwtBwGFm67DR8Vg0soqWVj7xnR
 EsD5D1mULxwwXzFPmRCExbGYmXHzECtJ/Mj/A4yPC+GVknpOiKKn10CRJiS2HTBvh9q4cOWAlir
 41Fhk0/7OMiQAXAsPxe6tI4TMZehZUjmH6EJYaLTGG5MguE2WaMiguA5qcFGUB6ynR+RSh/yiB0
 NIXigVxUXFaNdUJlekagtZ9NjQ6EgdUsWyp48gyDRN47+tpAgz7LdePiSZInmt0ya/SxG0xNyPj
 AK6/23hZALgsvyJthJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfXxVCzwhCSdTuk
 5A89kva9OZHnuD80jAEiEDj/T3MSmAtodAE+lEXPWHLFLUrAjEVB7Zh5kYkKRIX6zDYdmYChw/n
 6cQA1mjWthon9UTBepL+mWMFNAym3sM=
X-Proofpoint-GUID: nB95GrYNd60agfCMzUOhkhdTn716RzEp
X-Proofpoint-ORIG-GUID: nB95GrYNd60agfCMzUOhkhdTn716RzEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070061

The first patch fixes QC10C format requests being silently replaced
by P010, because the bit depth was checked before the firmware had
reported it.

The second patch disables time-delta-based rate control for VBR
encoding, so the firmware follows the configured bitrate target.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Gourav Kumar (1):
      media: iris: disable time-delta-based rate control for VBR

Vishnu Reddy (1):
      media: iris: avoid bit depth validation for capture formats

 drivers/media/platform/qcom/iris/iris_ctrls.c         | 19 +++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h         |  1 +
 drivers/media/platform/qcom/iris/iris_hfi_gen2.c      | 10 ++++++++++
 .../media/platform/qcom/iris/iris_hfi_gen2_defines.h  |  1 +
 .../media/platform/qcom/iris/iris_platform_common.h   |  1 +
 drivers/media/platform/qcom/iris/iris_vdec.c          | 10 ----------
 6 files changed, 32 insertions(+), 10 deletions(-)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260707-qc10c_fix_and_disable_time_delta_based_rc-4d6172b395b1

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>


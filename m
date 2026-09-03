Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FC4B5CD4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445769; cv=none; b=kKCdcecYZnBIgH3Bj04QQetsMSaIIZmsZuL79pwWDyoWBaARVL6az+TSuYO5iYrCfvXN/a3Z0s7TlFl9qvQhgtEQgECXMe18EnGDcPL/SLTktHecboHEf/+6qd0RFfOJgqWX7aDN91iYms4NJa6OOY0CNdDVBT1mowOuEM9NIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445769; c=relaxed/simple;
	bh=5Ns8HlqK6jXQoKvOFExlTMEc24MJgvb397khxg2WXXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jXMUFMNdGm2MXduFL2pjgcSBPd3Zq1VwtQSsk2R8X79cp5NLcqNVgQ+xM9Y92DF2SkQQVJblXGyxg/3bQSXrU3Gs1nmKXCZaElVbWLr9k36u4CbtOV2O3Hu/fE2ZvmaMUihPaZBlaMezHD3qhMAdTgcMZw/CxPUdfoVjayH8ckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UFKLsaSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSfQrggN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UFKLsaSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSfQrggN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAKH8539065
	for <stable@vger.kernel.org>; Thu, 3 Sep 2026 14:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yg3JsRt++Y2Z9ldyLQ9p9L
	Y1TD4JNQrPvaJFdhGRtd4=; b=UFKLsaSk9NsQjH7CL1LCdgBm2oM6LM1yR++HrL
	lCEzDsvFdS9WXRGQmy/xoY8tko7ueC/yuRGxlxkDW+XwVe5dwOHffawmwdWKQeya
	hhvJ88RTMxOTbuf6FmoPPiah3t2VQ7SSHvLbinBl4EL0Ft3dpb9LiFBkCkmO3fsd
	2WhM5eEjuUxmMpuUZHNatFJA+0O2+MpVCnXr6NcS2dmNbztu0JjSS7wQ/Ipkhhzs
	7maANn1ITmTWjX8DyIk9R7oyotp2TQlx2IpLD05qpvkhkapp9xQnMOQaDggv+6sT
	IJEbS0kiyncrKMquVvpo8LkrMx1q2aTrEXkrrVO4xZEIEo2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx10pk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Sep 2026 14:29:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936e393061dso347272485a.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788445762; x=1789050562; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yg3JsRt++Y2Z9ldyLQ9p9LY1TD4JNQrPvaJFdhGRtd4=;
        b=KSfQrggNf30nUPiUw197o/hLPAoJe9obPYU3cYtgy6LGKD2jcxqWfwdFt6PjOlSmLR
         ZqubJqpMowpZAOVYekkKU2Z2WnPp9SnIwqa6FXEblGGP/UOcv/Q9coziOmd9521nw020
         SCuvnrgMJ6460e/K+l08nx2zqYmsbeVi/s9OsocOLBCw9WILOarBQOcm+xIH84GsmOil
         WA8Kj+cHyivAq4ZS7mPJiOX0MPgYiIxEDzCaTCRz3YNadKdkvcBBtbmT9kegcm0TAwMc
         bwl5OeyVHGy0TY69qAGKq5o7RlCRiXNnYmwb559yElmCrmu3TUZz3w42UxJM1cizqjpn
         5+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445762; x=1789050562;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yg3JsRt++Y2Z9ldyLQ9p9LY1TD4JNQrPvaJFdhGRtd4=;
        b=bJy8YQg/qI19+3Nlk+SFwzFRP2AAFaP582KjZt7zOjDdMNI6EoZHGpLw39SP7wZYD7
         6wyQHVjCFl5MP18kDfSGBzYdvr+qPAS/xGv9IqgIZdT9och+u7f8I6TicVYva7wpj0WC
         cuucvXIyMvtVIjyd0mfQILlSnLE2lSnPZMBzMSeqO3gIxu0Wlr73tBvHMEJD8i4uiy5F
         rFfSLKs9tJiXcfLgcZVm/OBfErKe3MWpLJb4AL/oH3gmfJJjspl04CREilYYo2j3brCD
         yXeMzSQ7hGdJ2/cTotfVKOB455RF3KEpauDtnZX/U0xlt59oX/ltLabcxoYaWieei3T4
         NXmg==
X-Forwarded-Encrypted: i=1; AKwUvBw4765i3qb37c0+PyATI4545xXW7kPJnemmjEcM7KGs3ULayyS3Iq8DMz3j0VS0xzuyks+VjBc=@vger.kernel.org
X-Gm-Message-State: AFuF++niVdzm77CawX1dl3jiq0FyCCAzoOunzZqR3/sRAdDfQpMb8F/6
	7pZ+2hZ7dFg1a9c5MHYY5Wrrsc8NxYISwAW9zKgc1mjJzF/O2rCWG7kXph6BpAAgPUTAP22SYHH
	xkkcjQTcsrE+orev5eN1fdPuh63dEqtb04SoZdmlYbVfLInBAwX+TvmM3qvE=
X-Gm-Gg: AYBFou3MoEaK3Rd+9hjloNnSOLP/7No8isaQbimQ31ndS/VOohn0FgpWHUneJl7ZfCS
	mINZ9pUYEzYmep9dsbIZPbYSew7T8StUDeSF5Nq9Mpu1fa/z684/sU8IGhUxbsTNsCeFHZQQ1qI
	iWuqGFtYxzgTsoh9nJEHQPmKcgptj3oKjiMB1TfBRd5STjRq4G6cvd+VZTCjYQiNOOK8Cv+7pcr
	uD74907pyV1GPvAWYeYDCvFfdciVzUVQIhTB491KSqxfSu6+0+TKvPakW0XXkyk0rsKSFAV7vjs
	YteYOPF51vCYzSeK4ULosUugi/S6a/cSpgvQ2lMnsqmcUEuVEVmcE8dLTl0eyLQjdoBxQ/355iB
	rzv7XV7/drbiSubfrqBtPosy1OwaH
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id af79cd13be357-93960f28e64mr1446415685a.22.1788445761753;
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id af79cd13be357-93960f28e64mr1446406085a.22.1788445761076;
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1c7d:412b:f9d3:3bfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm72799415e9.5.2026.09.03.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/2] power: sequencing: add kunit test cases
Date: Thu, 03 Sep 2026 16:29:07 +0200
Message-Id: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOEmWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3YLyouLUQt3s0rzMEl1jM3MDI8s0yyQTEzMloJaCotS0zAqwcdG
 xtbUAQ5yAW14AAAA=
X-Change-ID: 20260629-pwrseq-kunit-367029f9b446
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5Ns8HlqK6jXQoKvOFExlTMEc24MJgvb397khxg2WXXI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqmYQ4Mb9pNFPt3w9PWSEtc6afI6dNv7yNUFrZX
 2iizrpvW9CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCapmEOAAKCRAFnS7L/zaE
 w5KHD/0f9k6NApXtF1gnb+yIZBSFVZtCQBqYdkklfCnXGHwSCHAhjuTW/7Zd1G5wttm+F1QRXMR
 N+OZ394aF/hHDqveBQZiAbmSWz6VeSo0cGzLTdzVEiuHdyqQ5EUvThsmlRiCaywHzqxOzDbWVMA
 8bTfnvBZ92jFvi6rW9u23RJg2HXk154lS3oleCU8+rnXdCPao0hsgoi3mz8haxfKtrKjXx3LyGc
 +FSYIyFUM2I/zDISC6F5Nj/0KrGR/3LucHukF7WfzXsCoJjsQMLL0PlLMS5knO3DcLJjPjD64w5
 VH63djgWB+a6a9CpJcc42+fivGJTGfbUQDLgxNbgXpBzsmlsrabb8uDAL6ML8kJV4ZmDKQubQyC
 A32s7rOSU4QDmgvqz9G9041mfKUfzULPXqJ4pravbc9xs1kkU3yOfg/bMPfvPFBWH0MBW0FOxDY
 eNiCrmaUmbNrJ+cn+auYGrvDu353e7r2vL7JJILxtOcDIFzC6xLCHWrZlThN6Q8eV6TCg0UZbZz
 1RaNTA50sQRFJxDDvZH2/jrDQ+vk0nkr1cwLVpZY2WqnTbeRHfT6bbpm5JJqKdDt41b/gdDXFqO
 3jdT9+0aj4ZYJrNPpPfPljc+cjHrGL0GtvV05++skmrRHxSAm8ATvsKjNKIZljN2PE23WGLVZcn
 Ra8UKmTrjFvq1hg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: OtDQHz1YsN_kUy0qR9Jsl3sceG-ZW7lN
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a998442 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=BnOhZuoTPVBHbJAVFpkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: OtDQHz1YsN_kUy0qR9Jsl3sceG-ZW7lN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX9vWAr/zPVYg/
 YC5YVTh5kB1NWL8hSuVQCcaJoO9E65GjX39ctqQ/Am2EBNd4iWB4xpCuHM+hTGibE2ucWrTiTxE
 Z9tP5iylou988H6l8wOgt+ZRqpC2JefXJ06YUUn7Xs/eArs+Dp99i0l5AsUzw5iukzRgUmDItgl
 M47j8Ma+hdBgJLIYJU1jRBkA2eHy1pAC3R1CsYHy4HVcpHh0EekKuFxoIdUNb2yM83js9uuoPWQ
 WryHUicDJE4kqSHRAV7QZdL/ryApYUQ9E03YLXMZwfxVcj8GgvKl2bxJVphfyUqfNVKDk5pn7gc
 8Pg9v8zO4bLUJMP3p8vUj/yza+Rxr73uTX/jgmwb8PTPQS5MP79t9KaBXl7rxBVP5eGZlq1ding
 IVfxn+KJMOxT+Z+vWwVTJixs84VignzIh//Stj0BC9jxqYy/p58Achr3hB5ycAeDI8ha0uI6GRB
 WrOp4ffBO1jS6QMj0aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX0XD41S73yz1p
 Sf62OTR12DfLh7XLJ4moqZp2A+/lquGQ/BBxAsmquUf/L97qpRQuswKsGYtoNKhrSMbL2grnvUq
 +e6F58VUz8zaQq4JyYBt8SGljBtgr8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030126

Add a set of kunit test cases for the power sequencing subsystem. Also
fix an issue I noticed when writing the tests.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: add kunit test cases

 drivers/power/sequencing/Kconfig        |   10 +
 drivers/power/sequencing/Makefile       |    1 +
 drivers/power/sequencing/core.c         |    2 +
 drivers/power/sequencing/pwrseq-kunit.c | 1497 +++++++++++++++++++++++++++++++
 4 files changed, 1510 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260629-pwrseq-kunit-367029f9b446

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


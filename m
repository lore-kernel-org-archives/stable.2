Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489520;
	b=GzQLde3PbL8fOt6AkF850suEMRPX7vG5DIAk1VVzZUjEcpuqF+4UZxnDOZrQim1ckThI
	 TkMsmh6Xq+w842/fzSyVNQTWpvAELRFKilAF0iwYmGnlLH5u3W9ycTwEpEK3MfGh1QEL/
	 zRz+DeMAuiv7t5NzPqJjo++pdnqiCrZcKiqLTyJQ5+jWSvsdcB2G1keTMZzEgal2idgzk
	 U6rNSGXIfVImECFLpU5FTpcQtkwhbOiuOW2N5sH5wkz4IvzJJmfetCOJsvYywEjAqHeZU
	 PbP6rmaUXJckcVDLD3jCCu3x2ePTNkQ18WfkiAg08r0EGuLAd3zxFipze/8yOzZHvMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
	b=162jiXrwdc7H4RHXvL3wnrrmm1gec306FFBxjU6nu1Ct0P56+/1KjjGPPxw0FuxStdce
	 UTu92tNdvMYAIFT2rxB2yH7EMIWMUvW+M5AzeDNIwDeNrs4RyFC+WblyGNpgR0UYd9ucA
	 CK+XdmpoNe3IbQAFayy404R03xnoLa5ok376IddkKbB10V/NP0JQVmj42soE2ab5F1+Uf
	 qF9VLEDsxIeECaKzwjlpNphEp7CQt0lcxz1xhnlqxJMp+ughALULMYka3ytJWCpiGgJY+
	 +jf2s5bl76mWA2DTWDCJWoFU23EGJNKy+pY6P15HID+ucEeR3xXuPxOQ3v+W/HLsPIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6oaWtMF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4kQJXkk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1F606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C1F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6oaWtMF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4kQJXkk
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Dv5p480050
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0reVTygQYZvGgH/DtOXkcK
	6EGhSpuDmU2CumM9pari8=; b=k6oaWtMFbt7v7dpBKEPbHRgaguk/AXr79CCMIA
	pYowYhoiV7TQWcgNfvL9ZHp8lSojuQngdWRd5eZNNoCI52UWL5E/YHIsGxXslnm+
	0HCsAVXhIUyPrxvx4ey3y+S0nn5xd8F5qSMZszNFrCcYnhp/KbqsJ7dFKzkrc7Xz
	DrP7GA1rbekvL0WDG1t8e06WYdLsY8kTV48XF2x06rNB27drGlvJsz2zyX9JkvvJ
	xlhS4svxPKicXfAJ/3sW8UQKjl674+sPOW+urnTgt90R7ZPFPXkTfKm1TWCOiWG6
	80hGQMiAeO9wbMuYosH28vf4tmaQafsQwgUjxinUNUr7ySRg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rsvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so1179897eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489518; x=1795094318; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
        b=Z4kQJXkkuBYcYZ7tSzY6NfHQhbPL/HYDW075fvGpkibLkkkdo3+HG+l2T33fhATo/a
         yK8E82veWF9s4CygE+pXYrRHDK4m2QV2Ul5yB9Wrs9OAKmnKcLdjuDdWtV8YK52u1LZT
         VLRrvDl6KuE0ID+oMlvl06ODtwu0Z1qKwKtz50I1KAIVAa9WXn2uuh5/ZH94uKGBeeQj
         umQkMFPkylZwyGbDI4/AOaSVOy8tudVrsRlzt2ibSduWLEWXp/NxZPm3294eRQSxzZF5
         DBMh3bffPWHZiDrqVmgqjNpRe+OXTYJ2BCeJuznJIkM6Uxk0LqcRjS0ECXPVVsmftUb+
         O5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489518; x=1795094318;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
        b=Fe85+wMHQl/sgNA53AdWAcHpiQRU/IwZYJNFgcqhjPrCbia/s23o84xK1mAz4O0SCU
         ziZJSY6cL2BaZmsGWM3Uad+tEobcnuBOSdeqn63wnir9P26Tjd6DAGge36I3z7jWkYCS
         g0SnjwuymMfDLu9N8Gfh4rcmbQipB/gQzRvig9Q9m11yd7hnAvdO9e9cmnUlpS/aONgU
         a4eWIca260+wr0YGbjZWN3EdOTkmYIJA1Us1Anj8vcDWQwaDY6JjWQB2HOafZ7i6ar1r
         w8P0GjWFvqxWvs9NFGrMfaJtAegGRPQT/xU62bVDZwxejfOELWNYJZ8I4qRFlsqFrA2P
         Tddg==
X-Forwarded-Encrypted: i=1; AL+hErHflt0WpXFMFM9LQKCizd2khY0z0xUFre83BZTC7EhE5g1/Kq5crfr9SlHuoZ6/SQQ8V+wrMOs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I49rk4+d0HK88FhmS2T56L2JGyyCtQL+X0jFl6gXex28EagkW
	4EdH8LNMWq5evuAVFSlgAU8xGGaC/OdMqAEQsMgNO592a0OTPNO2YQF0rMpJsicR0IbKOLdzNmV
	/jewpbM/QLgK6ByYs8ONcWytUbydoMiHmcJbJ9DF69zUnjbVRvufPrdsZFS4=
X-Gm-Gg: AYBFou0phG8kePHkEqOs9UjTxpLg3p8kzR3tsIq0sL2nUDBjOKohA2xFdR4Wbp45IwG
	ttTQ9T4aCCLSWUUuqPEOgf7oK/rDxU55KVLE4w4/TpUkz+SyLX21U7OBWNGIwe6RzrUKM5Adu8h
	jYhAVHOqBf6ZiqH5FY0Vws6R9QTC7MsO50hWkm6xa3NozjyA914yGwgH/n4dEzmsNIL0CD1x/0E
	/Pxcl7DjjseNKJfY4tPML1bLOuKVyw6MEJkj86+yrge4+TcnWGLz2eEtOcz4gakeqphJf2cpg3T
	/fGJhEsL4/6imRW3D6dF8XT6hQSLHpRIuh/6EOcsFA3LFOMCTatmuI3Sy9YKyLCb9qNRvMUObEa
	ao4E7FprtYJPn8Vwl9gPsE+NRQV9qrxKcN6vG0wL1BLuK9XQsrNLvz/QhLAL4RbFyAk7VKwQPno
	TgWMvGBPM=
X-Received: by 2002:a05:701b:2906:b0:143:271a:3df2 with SMTP id a92af1059eb24-1b3c0361cc2mr4490665c88.44.1794489517442;
        Thu, 12 Nov 2026 05:18:37 -0800 (PST)
X-Received: by 2002:a05:701b:2906:b0:143:271a:3df2 with SMTP id a92af1059eb24-1b3c0361cc2mr4490638c88.44.1794489516809;
        Thu, 12 Nov 2026 05:18:36 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:36 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Fix MMC/UFS sequence for ICE calls
Date: Thu, 12 Nov 2026 18:48:16 +0530
Message-Id: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJi89WoC/32NQQqDMBREryJ/3Ujyq1Zd9R5FJMZvTVGjiUqLe
 PdGu+9m4MGbmQ0cWU0O8mADS6t22gwe8BKAauXwJKZrz4AcE8ER2aRMX2pF5diXNMiqI3ZVcY2
 iyjKKEHxxtNTo9zn6KH7slupFaj6WDqPVbjb2c76u4vD+HqyCcdbcZBrxNFFJLO7GuXBaZOfdP
 vQBxb7vX8i1aCDNAAAA
X-Change-ID: 20261022-qcom_ice_pm_enable-3c5d21b99e42
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Jq66LheROe3aOR9xuONBNrXGgVdimA6-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX+cBGfGLtxSd0
 DVF1w4HCPmVj3kh1wWMvHTEe61bA1OgUy3UvAJVBsOUwmH3YiQJD0zGQcxmUFRur6P+KQ6L34Gs
 5kkl3tvD9nMnVoT6YcwX8nUEpr9JGVA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX2Vn1Colvi7r4
 PGdkspWyq0t0mHpRtT8/5XAJo+SkceuAjt41cpX/O64wxaPM7w9eUFqE6S3aGqtmS/YFF4ZFWbm
 4RMl1iIVdAvkZeG//KYEvRtpmQoK6lrnVrSnFOH/y1/YWCTQYoH7tuVmgkd/AFagaV0B1wC1zFg
 qv3yTuje30cqnM0wpcRAEs6bPoPjWXpWd81PZM1F9gUpNEpVmtZzIbVuWjQF9BzehoD8+KyvnzB
 BCsGBOxlGQR6g847ap7Jydx9TCE2U4wHu/4hthDWXEGZ6YFvj/lTilU/e4PbvOnkD299Qc1YNXP
 R7iQN7pTacYtDU1jYawlSccT5sLurn0ZhLN16xEFnPN+M92gkS1SUC4QI0miOMo0FYMz4q27E9F
 3Zxdr7eqEwa405eOQfrsLgjanlijKTcb2mukN0hd+C87+ACITiTX6RmJ8AJzIMYI8BiJPxRg9V2
 w8zEtvwMaJr+POxIWzA==
X-Proofpoint-ORIG-GUID: Jq66LheROe3aOR9xuONBNrXGgVdimA6-
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5bcae cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=bLk-5xynAAAA:8 a=1XWaLZrsAAAA:8 a=k6_AVi2K15u0NLJkO0wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22 a=zSyb8xVVt2t83sZkrLMb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120052

This series fixes ICE initialization sequence where ICE is modeled as a
standalone device and referenced by storage controllers through
qcom,ice.

Currently, ICE driver enables clocks during probe and keeps them
prepared after probe completes. This keeps the ICE clock voted and
hence, any key programming call from blk-crypto succeed even when
storage driver don't have valid ice instance.

This exposes serious bug in sequencing but it works as of now because
ice clocks are voted. Storage controller should not rely on ice clock
state and rather ensure valid ice handle is available before any crypto
call is triggered.

Fixing this issue require ice instance at early ufs/emmc probe so that
correct sequence is established and ice is ready to accept key program
calls from blk-crypto or any explicit storage operation.

Validation:
Tested on shikra-evk, kodiak rb3-gen2 and sm8750-mtp.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Drop patch 3/3 and post separately once 1/2 and 2/2 are merged.
- Tag stable kernel for storage fixes.
- Link to v1: https://patch.msgid.link/20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com

To: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulfh@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <mkp@kernel.org>
To: Eric Biggers <ebiggers@google.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org

---
Kuldeep Singh (2):
      mmc: sdhci-msm: Enable ICE before enabling crypto support
      ufs: ufs-qcom: Enable ICE before enabling crypto support

 drivers/mmc/host/sdhci-msm.c | 21 ++++++---------------
 drivers/ufs/host/ufs-qcom.c  | 29 ++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 24 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261022-qcom_ice_pm_enable-3c5d21b99e42

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


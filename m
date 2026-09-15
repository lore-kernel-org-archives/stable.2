Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89447ACCA
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478821; cv=none; b=rPoF6KwxN6y/vZyhqCRlVq4jacdLH7+Fvm37L1drxtaxAZjd7bDWW2e5PHtYDsi36w1f1WCDTTXGEbO9xilGx6VzXelgK4MpJGXE9spw50rKMZtMBLnebGtaVm5VZNe1tpt8NmDvu12GHEnG8Kxt1qQqVM3WCnyDls8CE98S2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478821; c=relaxed/simple;
	bh=ORYvywvQF9sr2A9kmeEgyJb+JyTAQ1yhyURfVvOXciU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha+25oDMEo7DFmuBPVBzWiq+uw8o948xsE+yFjSpPqcW08ppUf6re98V8K+RRnECh1/PgorbK+VbdkQznZomiAchqIvI25jPRNB3+Dzn90wL1rwshXJqjD+9oKvSgMEtVZTKl+4hQrha1khSy04A9uSl56gVqsjqMs4N5mqcVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brG9/f5Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1JDNELg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brG9/f5Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1JDNELg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxn874004782
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=; b=brG9/f5ZHsm+OWy9
	edieNlypHui3oeUhNtwGZXlvW/TAJgmTIRb61YuDVrQrFJN1DBtd4sEWm3zxvajn
	HKPp6dcmD0dBrO59dhmAsE6nNCfZEwTmxuJferlrSfcyse4luZQuYVbLkeVzhiQF
	DsWoR/JLXitTvALazoDdiKK+MZuUzm0Cho66AIdO3S061t9IGUeX8rQTRFSgdLSG
	Yb6QuN/Ttou8BUkpHqI5TXXW+dhQBqRFgnUnldvBEfolyiv/R23G27079WNNr7OJ
	KANQqK7fSxvgRfQHj8dKeTY8sMjhiCp3mdyvVrWLSXd2wFud9tyxq35ivVXPx9ST
	o/HD+g==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xts0gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:58 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-88e06764219so18631957b3.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478818; x=1790083618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=;
        b=O1JDNELgwCHfBg3hK+Ta9pAytgIACFQSPVSmWii/+Oku5jopavUv1ZmztuhfPJ44L1
         8K8F7SELogI0d8q+GcwbvdGZpnDPUxVfQvL5usBW8MMoRM5M7RT2wC0//O/z4JTch/1t
         HcQlYN1o5G3fwCgZnCrT22E/0VjK9ODihylyelytiizTL+/5FP1szSGIrPPIzJVr6b+F
         wNgpFsBgRUG5ZMR5UeJOuNId9QG4PUBxX9ufjVxk+Skr9tX6AUIsF99vE1T2C83Hkcv3
         cOMJTKnIVWdJ4mmfWhjKqA+TuKyVl/43UBqts0XoelBA4KZBqTwU00c0ghtG0rGKX9h0
         fq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478818; x=1790083618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=;
        b=yy6QuaKBnHydPcJfpLxFvox2wZgp98DrOgy79YCJ7raXRwsLxRSb+V1KbQzlBqzMVx
         5Q0lbzVZAEQS/C5Ryv1swaQgpnTlSgn4YHDQ0PvURHlz/DHjxEhFYSqhALD5jFZVaLvJ
         Dgx7zbCTHJQujAyg0p30XT6ScdRWRHPuz7GZPMe8ycR7YGLnpTIKWEVLr91uWdvbVwz4
         IYnFQmzCPXWD5SPRFzxAc2WZJraN/hZH//GRwKO8RwMyUGEMW35IApeyb1rjoxHoYZaS
         ZVuBq1gagpfzLuUO58rXZLjf24thLGz93gGtvwlv21NRlevs6ApNMqydKwkHBpCmoB09
         wCPA==
X-Forwarded-Encrypted: i=1; AKwUvByzAJLzvV1R1AcJkBt9lumubXF9Mx9HEY3KDkVMj2YgBNQxPmB2iy7myezLYgxQTmBfEMEDRrg=@vger.kernel.org
X-Gm-Message-State: AFuF++kELePtZMbvVajdctOj/U2kwDHVNDU0Zo8mdlTee9NFy0gtNo3z
	J/l9gyjrQHCIc5Qyk98TFcRk/7tqj110wHxMonmcIxIIrQ3sNqcagLmQNT/2n+Wp1SHMRI4onm7
	SyzYncc3CgOrgNcQNF9PLYGByqAUD38l2vE4vTs2/bT7njVsvgb2eb3v+E1s=
X-Gm-Gg: AYBFou1qKye2/F/FKp89zMGaltHvekiWoqJvuNG3Gpw6jyLn2Qpah3fMX5Ezf6pp0hV
	EvLwTUqlgttvCS3okPkYKjv3t2LAxSPkx8mkHlewUlJQA2rJpL5Lxafv9RqVahWT07Y1UwJerHA
	Ft7Q/5v7WOxCgd/lydrRuHsTa2EOHq3KDganc0G7xMIMlBZC6SYYxu2XQALTAzOZk5GkXGA9urE
	fQalPl8mRgR6Tr5JHOfwlCy9CYzQWZHBYHQn6s2cbOBGDK+x5yM+rFr+IiZR15u7wnSPgYrBdZ1
	pLegMDxZ6R5hRxLyRewiCo3WS1jyNf1yHEmlhzhXVEsGmbfhjqaJ629W/iqqXStSngMrZWW3+yh
	YlB1JucncCLvL0B7WOBfbWAAyD4StWUUb5sQ6
X-Received: by 2002:a05:690c:c622:b0:887:1704:be8a with SMTP id 00721157ae682-88d1f402767mr18659747b3.8.1789478817705;
        Tue, 15 Sep 2026 06:26:57 -0700 (PDT)
X-Received: by 2002:a05:690c:c622:b0:887:1704:be8a with SMTP id 00721157ae682-88d1f402767mr18659497b3.8.1789478817225;
        Tue, 15 Sep 2026 06:26:57 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:26:56 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:56:27 +0530
Subject: [PATCH v2 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1891;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ORYvywvQF9sr2A9kmeEgyJb+JyTAQ1yhyURfVvOXciU=;
 b=PGCt+aP+jk42cabmUEyAbYy1FPHGiHZieIT+Q77R5gl7R5qYcVOMHXJUjENBMiWlo7gxcyFCj
 DeVmA43HBOcBNQHpUGLcaRyIdrUVQQc1pup9sh9PiZKXNAjvv2mhQkm
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 6gCM9Tn3zcP7usrgEQvM7v7eNRc4x52A
X-Proofpoint-GUID: 6gCM9Tn3zcP7usrgEQvM7v7eNRc4x52A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfXzCUth78DIAtd
 8dygcyyknrfFBLccHXhRjECuGwpQC8cmRHFcive7gj3SDxuZC3b2s/0oihTEpp+oMjStk4/UVQ8
 7TfOz07CCkL6D6QsFO3SaaUMay+f+Ak=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa947a2 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B_gQsAElUtnq2ZcdrgMA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX5aHGAiAyfv8d
 iA7euoOOsx2yIDst9SbzkAZFc7ILuK8vVZORN1MgN5mpec8K2KSc/rymlAs4R/6FDNDE5OpFZYL
 O23K7tzthuelz4YEsenCfjYI8J5J9Pe7KYtVm5gUCnk7pmdcVId6r2KUmJOKQUbTTLfOPQ4ilb9
 SRuzNQ4DOnXy4LPF2XYctCI4D5/xHofU54C9NT5nMgTFgcviyCC8xx8mCi7fCIUeGwI3Vq4FhEW
 K/iXT+MD3WX5qFFrvY8+ndib9b2Zf8PuKFqeyMR0l5SF+rimwnB5prpC/vbdRzoYVf6eS+ePW2/
 VuAAjdG4fYfFTe2N7wVwsmywiQiao/X9lTYv/vzLXtsmtidYux39al70YvB4j1CSMYR56Vhq2bv
 jmqed3aJP/E/WMkf0wHX5gU+xoN71xLmNqlHGGVFO23N+vYblEAtB3FkExJ8yTyD2jeH88ySwMU
 NlczKHpqmttWKaJBqig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
values are several orders of magnitude too small. For example, the
50 MHz threshold is represented by 2500 rather than 25000000 Bps.

As a result, clients using these constants can severely under-vote the
QUP Core clock.

Correct the constants to their intended Bps thresholds so that the ICC
provider selects the corresponding QUP Core 2X clock rate. Drop the unused
definitions.

Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 include/linux/soc/qcom/geni-se.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..5f18d281e6a4 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -347,17 +347,12 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * QUP Core 2X clock votes used by GENI clients through the "qup-core" ICC
+ * path. Values are in Bps and must be converted with Bps_to_icc() before
+ * setting avg_bw.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 

-- 
2.34.1


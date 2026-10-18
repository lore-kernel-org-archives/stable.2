Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24B434E39
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351455; cv=none; b=aw7mw55WiYFItkejq4uKP1pYBCGr+9GLrX3R4sFnNPAnxjaVQirQa80l6nxzUnaumNvhUk4LVeUp0jZkJ95h0hI0iQR9mIUNHwgfHxiRboU/Ov7604PfRl72V2kuqokk6Up2RNDUtKmSCdy6MsOhN26SV8AE25hLXmhBFmFGoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351455; c=relaxed/simple;
	bh=A9JqsJ3JdFHwwfzZdup2DtWNIV6CuNIAr8OH+g8ihCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0bV7/cmIuawIJnliunIDEcsLWgcrQSs7BUkzLp/QjkL/121FX6izygyshW5R1tQWNPRPTVmpsdeUCuqNvl9mGr36MSfI8pmovYp28v/KqSDCfzpdWi+8HjSOekbAls1fKDtbjcRJAOjeOM8AUvq8RFIYjGBNOTpsdJNZBv1ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HSMCN6IP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZQSeAFP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HSMCN6IP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQSeAFP2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IIU2GG298523
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ehLEox3TtWa
	JJUfnw2m5PWlJR0h5h+JMt2AHDszIvVo=; b=HSMCN6IP+Uw0NnoRCipt/QRKMiI
	wRJkEi2qjKDJEVxMOatE9OWpFc5UzVfKUmgp5tXEMNzNexVZaMKFPvYRjMkoN3c6
	l0UfwvqEn77bSYDoSLw/17gUFZPGRMX+GYRSYoFWJh4XGONJ7wuXTht4CdPgeQd9
	Sx0wrrlpljLISFZQBPFjczX1zg+DSGxtFf3EODlwxJj6KVSwknUmaXcqc21QrBo7
	nq7CbiSckitxMcr374Da0D2+WvjKORGEhL8j0mjo1J9qvIzH/BZE9FDQE5f4n7uc
	xEJYvJ4REUk+RXQ4poAqU9a5U0WUuUosdbAIAM6DnMFaqrtHDoT/wsLgY6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxcnv40s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso258354585a.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792351453; x=1792956253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehLEox3TtWaJJUfnw2m5PWlJR0h5h+JMt2AHDszIvVo=;
        b=ZQSeAFP2Xh6l2h1nFP5t85NQza6txeq8aaV+Q8QvG3kHXCHWIyFMqosvvUhIVw/Rqa
         eUsJwNCz4LqF4vQvH4V13r/qcKP78OaR9b5tJtUWvkBcmurroIwICAnjZ9qI2+ANYxoM
         nPPnBh4EkMD4AAMqFSGDdAhGbry5mfz96+7gac3U6mmKGdkipNCyfzE9yf2MFi0NGxRA
         X+HM8/l0LEiaEGyyaX2Qb2BvoKGAmii4axUYBTd5y2Pc/axHt29KUb27gNmd5tAVbFGH
         6MLKYzisnglEfLm3b5UmTndTAjiUx8ieDxMKTRDHEHyp3U+gX85h0zOBUnKWDWTK4MwB
         S/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351453; x=1792956253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ehLEox3TtWaJJUfnw2m5PWlJR0h5h+JMt2AHDszIvVo=;
        b=N7w7yI9q3Zk08TIZr9XvvWby5tRXNta3aRTtg0qaEHbtMLTi6lakYs1tMPznyQbVrp
         C+Hx1XgYa/ISQnqlEY7xryEhA+U/XwjyQM3/lQgkT1WtYdTejLxhsKYmAbJ4V8HS31C7
         ThLHTx8hMPO/aSQieB6VeBLwpoZS4u+KRg/4pflLxv28Q3mcFxMI/zrHLgVYznFVllQV
         5Rg61pLgrybgkm46qmjp/CcL4CC3SelA7TKj3WIryCh6XVaX4ay7aike4xCPL/0HT90d
         B9GHDw4p+l2CyUBo/RbK+oQv+/Du+50uHlNY57wQCGCHlNdRnFbKW7QBdtMbsuskDKPc
         62cw==
X-Forwarded-Encrypted: i=1; AKwUvByhipiq7rZcQGonxk6qZ+qGgcMoEDpJzSgZmtmm4j9kPvgNbqeQcSy28NpJAXlZvbCYUnKRNuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWQmcdcAfoI6aUHpZShMIKttgcdD5mZWpk3y+Attce9RVDUBFx
	bkded8Ncw5T+XiczJhqjPOdqEHJnqW6OzcVI1ry0ZDCfYivCcKhL58088HutIgRu5UWgNQapP+v
	3QvzESfJMLUuVJr/ec6iL3QoHA5U1oucfgHp++yHVnLGYJ/CzTWL+tRl6IzQ=
X-Gm-Gg: AYBFou2cYxJ/rApWiLBDKEV6QJwik4djXZlX0P07FWXmxgQB1+fnCeIZHFsEz4kxF3S
	XdpjMOaNx6miOXJf9bSIQzXEJ9f1Dzx9lWJKlqbhDOp9gc0PkEUK28jYr8mYREzCVPVWNLSO9L/
	SdYCSe8r7Xgw158DlYMeF5+qGGaLTdLN/CedflZWg+45o7nkgn6XeLz3Q/hs9sBwQFlaf9GwEbr
	320Q0bruWUop/CAChQom67yhF68kMngLgyXglLJAw+Aq/MJr9H19OndSzoPP2ohbE64VQoOQTdt
	ZnTSp6FUUjtofCq0SjwB7A+C1R8lBZEDtkmyV32H8GotG19qyGcnXTyWYR/YZvwfgpzy2oooDH9
	GO+Pw5Yc1FuL0
X-Received: by 2002:a05:620a:8909:b0:93e:e376:9b1d with SMTP id af79cd13be357-93f29b8062emr883945285a.9.1792351452784;
        Sun, 18 Oct 2026 12:24:12 -0700 (PDT)
X-Received: by 2002:a05:620a:8909:b0:93e:e376:9b1d with SMTP id af79cd13be357-93f29b8062emr883943285a.9.1792351452277;
        Sun, 18 Oct 2026 12:24:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33ad3fsm184417105e9.5.2026.10.18.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] ASoC: SDCA: propagate sdw_slave_read_prop() failure in class_read_prop
Date: Sun, 18 Oct 2026 20:23:56 +0100
Message-ID: <20261018192359.287987-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BNUmP1QG c=1 sm=1 tr=0 ts=6ad51cdd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6IGIi60M6HWO0oJrOSAA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 5-d3ZmN3itQI_C1bUz6rUhtEUU-pJVxv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfX5Syw5hnm/RZZ
 /pvym+VNvMUroJBBP8GcpWLGFOToKDGglF/JFrkxIPpIKu6jtjLbbZE3MS9QlCeJDfRUsGV81PE
 towry104CUDD5V3xmjdi2+J5w70ZEsU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfX8N+WzD20LHh/
 5CDhclG2FTL3w81O1L488DBCh0H5UiWdn7ITf3VHvJaikbNmiTUriV6vIFAC4HCnE+gegjdWvQi
 TzmxteOZgs6ugIYwWad8R4157hI/NzjYjx3+v/UWnam5MYWOODXrSXC8p+O2MvdEsN4vPibD8QQ
 yOXemm8xOLlHh6b5jnkmfFrFIU66rvnmXOOgF8worcSv/wrFHQHXSTRE99K0G3IN3wBemeegvdu
 K11vmfVdpOhy/zx+QAWGrAedItoiJmYETSdj7txSMkPM9fnhrli742TcfBLIfcZzYHN/KajnElm
 jp+QzD2kskupjyutFqNntcJtIFAsYqq0hE3kbweVDmOWbhzi4/ZXsCHag0ZW4pLnS9T0BTKVbu7
 tRPEwXOlrTx+11QT07FcLMhi8lwrfxv5w7Lddws6T07vQi5M+2AUtrQViPrB+mIiXsXsrUvNto5
 Jh+STtN5G1/me/qSAgA==
X-Proofpoint-ORIG-GUID: 5-d3ZmN3itQI_C1bUz6rUhtEUU-pJVxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180077

sdw_slave_read_prop() can fail with -ENOMEM; propagate the return
instead of leaving slave->prop partially initialised.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index 79fdb672be1d..bcc660aeb739 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -27,8 +27,11 @@
 static int class_read_prop(struct sdw_slave *sdw)
 {
 	struct sdw_slave_prop *prop = &sdw->prop;
+	int ret;
 
-	sdw_slave_read_prop(sdw);
+	ret = sdw_slave_read_prop(sdw);
+	if (ret)
+		return ret;
 
 	prop->use_domain_irq = true;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
-- 
2.53.0


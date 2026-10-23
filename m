Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775618;
	b=dbzBqMOiEdHprj5EwTI0Cq+shz1v86ia22iFzwayP6Q0+S05FxOAntlr5wlgi8e8+hI5
	 2656DNC45f7kuKOWb8y0APlsVWVZtgwzLB7A5kzHFgD7lLyHLgrczuFtAvsIVATpHAfqQ
	 AgiDiNyDsL4wvbaBFqaG38WfgExrP2r4RuktMe6mRSNDK7ji+MWwwPt1+dJGIe4VNNE+I
	 q5ug44/Ei1+NxfRk6X5fEFm1SMGU39iLDD6WnVUssXsdNrrg8iZ59GTDo6cYQfVBDlxA7
	 V7sePQJj/FoaqyL5OYfKcuHDEYxJFRHzOW6FgThK0RAZrVL6q5cjQRhnVMkbQ6E61ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0RaoJf1quXYWRkDgnF0+UKFcSUDOACQJ5dkLWQMqNDo=;
	b=KJ/B4J88xIvW04SLSh9EWgOGv2wkqw4aL4ZiNA3hsnvjZoBstdrPPEt8ojjXfeIZULWJ
	 ZHR6CGaOHJnXGnUC7Awb7xLGP4oEvjbye79ss5N58wAkSFR+cfvqA4MnG6iARWmuEwMqY
	 1rAspE5dSPBDdM9ORfi6Y5+bcNK27tqek06w91Mw/Zp1G+4u1CQJqOfLHOnzi5g3/fkJ7
	 D/+4yvbs9zemAhY4p3sscapJUQYUEac+n+5BJ7JONSkr+sK4456Y+2yW3y7gD1VagZN/Q
	 I6hiF8QCUirokl2eI+4cU1Toc2oUiXe2G6IGsa5e/jvgQTaBGFZFf7pbPy58hRaZM3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPeE9K52;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDNgySCA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEB606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43AEB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPeE9K52;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDNgySCA
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6PwG3000292
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0RaoJf1quXY
	WRkDgnF0+UKFcSUDOACQJ5dkLWQMqNDo=; b=CPeE9K529Dr5esSobebjLOZOJmn
	lC7XXPUB2BhZt8WFuvJhrtNQLzNm3glP8Lpdvcwasg6vfan8GbezAjEsj4gcbxpr
	qS2QvuPvrJY1zwFrvQeRNDzQLsgHXxycCQAGo0HGYlfp8/XC8AFs2t2Rtd9QQeE+
	wLXlHCmnCVt03gMhBE+qHTLqNuuvQMEuUv2XdNDjTHx+PzQ0UHo2KpxByoncWlL7
	e+iBRwfP37yaZHHym3l2HQSsNA/yBZ/66koZ0D21s20eLt/OduPHLiDP2oldZFN0
	sCTgg9DctvSgeVolatlJU7EsZFJ3BX0tG3Hlads4JlfGadaezQZVJOGHrGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn13xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so202980085a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792775614; x=1793380414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RaoJf1quXYWRkDgnF0+UKFcSUDOACQJ5dkLWQMqNDo=;
        b=jDNgySCAGDqPFOm8WeJw/bnsGCKYAxZM8As1HC3sVfyuFB2FP4TMkp6J2Z3tcZY31d
         OExh9NnHxkZPY7AEOlp+nMbS2vJQqfTvLlzxQ38Mr971jVwTIgtIzFArlZlEK/T3lp/+
         Bu1rQlHHA43W2Iijk684jYri88rTP5HtFsujyL15Yz4M25n1JyUHABCE6p53DgbWmUVV
         29gD6t1tBeg6Xh0QQtzUnPn1Utuu+0onMhnm8SOhNW8s+NUnRWnNivNAXK72MLP8W7aK
         G4AcBqxBGSQfsRlRQZ1fSucoIoRQR7O7OqTiFgTY+mZRBfXxc5+JuR3sgKlVyUk8ugFR
         QERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775614; x=1793380414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RaoJf1quXYWRkDgnF0+UKFcSUDOACQJ5dkLWQMqNDo=;
        b=OfESeRmcCU+Q49al9Q4kZJ3FpHL4LRfrIubnXzP0sXH/jaZCVzG9TJdzMmW8ImyYLH
         /cWEVZYHYfL3lPTyxC7W1/Ps/4WskOWWzK4HbPOJXUT2NHTCihUqIOo75bFO/62/mZm3
         6/VDtK1VrAn2Zwyrj+fGMYbJH2isbuvnGOavO3zSTQ/ijDILBdilcD0FmApha0nH7IWv
         v7oAEdRGra6FAaOghtRp4LgufF0GZZ6PVUUXYKTUYCg+qU7XDVQjZ7e5qoeqkprca5ZL
         OxpEdILmhNpDJ2udvCHG/7goZXlap+vIARr/QAys5Obu+ZRVBLI/Ah/qpq+3aWihfIGr
         hN2w==
X-Forwarded-Encrypted: i=1; AKwUvBzLhIvUgfn/IRiMuAGj9uYxUXBA45EZVJhaFhOPxuDuGlqf73Gxe1eSweRSWDc5p6JzG57dltI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDcuUPKaNH9PLg4qBv4VkPijDG/BDKzNk+zbeeNPoIMwzB8DC1
	D9W7D9E5LLvCbTf4s6UaIjovF+R/OFtIwmDpbNc77UQPmOzZnOX3HH0/5WFLBDkg4Z8WUacbiST
	lBgGTdtjEDGM6D0BGwfAYWlX4pfua4elA9mJE6Y4o1PeBRwY6r2ijZ/O8VYU=
X-Gm-Gg: AYBFou3+y5+bHU+5qdE/wOm//grDzoZdnNFH4zOo2LUdrAT4tZgNebCrWFIkD01uzwM
	I62TgbjvMbGntbVo2BGNdvFXg7X3t+csBKaQFB+UjEkMgmv6+bwji9iPmdAs0Qk09YG6srj0fye
	TU10PPOMhw6zOAqW6kV29nZ18FcvXRdojL1iskidIWAFNwJS8Le+PVeRe0JsfkfYFdRNxfjGs6T
	HsCdtKW1Nd4D23e1THt5SxLZG9UREnxR9gz/WgKl98TbSjrVF8ps1dgcEUQAGM1CV2zdoSbhKBC
	fJIq9V8ZFcJWcrQb2nbY56IuDD+xKb5fi4Z1w9y8H4/XaT0g01JOiY26Jbdl8vti+QInd0+6sW/
	qLk2BY+84UX3c
X-Received: by 2002:a05:620a:270d:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93f624b1fa5mr963958985a.2.1792775614084;
        Fri, 23 Oct 2026 10:13:34 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93f624b1fa5mr963954685a.2.1792775613589;
        Fri, 23 Oct 2026 10:13:33 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4104b5sm1043841f8f.36.2026.10.23.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:13:32 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Ravi Hothi <ravi.hothi@oss.qualcomm.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/7] ASoC: codecs: wsa884x: Accept temperatures across the full trim range
Date: Fri, 23 Oct 2026 18:13:11 +0100
Message-ID: <20261023171316.819857-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023171316.819857-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261023171316.819857-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX6+xIAbFdiUMb
 iPyEe57f4NdVXXTZVsQ2hqy6qoiHv++EwtADTxfST9Xi3vlw83ajnoRJXSRpmy1yVSAaT97JIE/
 Q5CNiDEjtuqq/h2AQtPni16/xl6RejCaDg9U6WPkcYbWEPHYnOR9okgivEYAz4ZVJF8WEjHZ7rb
 ME2VIJs0ZmcsCq6OseuihU0jYNSyFRh9iYEIkDWh81TJtWq1E1g9MIPsyUzwykN018s4e5KdFTq
 6iwr5qcrcTYwU6ksyutcMWUWkBfmzai5Q1exMz4XdxpAsrSbjRQNggTFurQgf7VzUUMv3JImqtq
 Z3BH9x9L77kzmjsCoqedVBIT9bJbXWIxs7aWbSmzWu3iXEmMlNM/weN4brogKq73ZANQZ880p7I
 8KiEsuG0JI65Drj/yEluQOxBxI+c20N8H5IGvxt9d7VxrUcciKMfc0Nf+sdANv3s565VFQrjdvt
 CM9l4LZuPNwVmPKd7Yg==
X-Proofpoint-GUID: 0WOp-Nbb2w7FRMtVHC6TVTIp6cl3KRRx
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb95c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KF22LIoASRNQ4hJq_1YA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 0WOp-Nbb2w7FRMtVHC6TVTIp6cl3KRRx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXzSATufUFJbsn
 ql0iATi55jzXirotAolpWgcmsFw0ZvvkWTqvt4qaA5RvAQzyQ23X2uaVmdmsTkBri0J11M0cJHe
 IFY24NfIpP++0SNT8f6ihlDyQeFCB2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230067

wsa884x_get_temp() rejects any reading outside 5..45 degC with -EAGAIN.
A speaker that has been playing, or sits in a warm laptop, easily runs
above 45 degC, so its temperature becomes unreadable when it matters.

The check only needs to drop bogus conversions, such as the all-zero
reading before the PA is first enabled. Bound it by the -10..150 degC
two-point trim range instead.

Fixes: 6b99dc62d940 ("ASoC: codecs: wsa884x: Implement temperature reading and hwmon")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wsa884x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index a367c94bfb4d..f0857c0588d5 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -720,10 +720,11 @@
 
 /*
  * Device will report senseless data in many cases, so discard any measurements
- * outside of valid range.
+ * outside of the two-point trim range. Do not narrow this to ambient: a
+ * speaker that has been playing easily runs well above 45 degC.
  */
-#define WSA884X_LOW_TEMP_THRESHOLD	5
-#define WSA884X_HIGH_TEMP_THRESHOLD	45
+#define WSA884X_LOW_TEMP_THRESHOLD	WSA884X_T1_TEMP
+#define WSA884X_HIGH_TEMP_THRESHOLD	WSA884X_T2_TEMP
 
 struct wsa884x_priv {
 	struct regmap *regmap;
@@ -1929,8 +1930,8 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 	dev_dbg(wsa884x->dev, "Measured temp %ld (dmeas=%d, d1=%d, d2=%d)\n",
 		val, dmeas, d1, d2);
 
-	if ((val > WSA884X_LOW_TEMP_THRESHOLD) &&
-	    (val < WSA884X_HIGH_TEMP_THRESHOLD)) {
+	if (val >= WSA884X_LOW_TEMP_THRESHOLD &&
+	    val <= WSA884X_HIGH_TEMP_THRESHOLD) {
 		wsa884x->temperature = val;
 		*temp = val * 1000;
 		ret = 0;
-- 
2.47.3


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775619;
	b=4UsKm9rHo+vYexj9YbP/9n6Pjq+1zHF5LmPDuo5oQrB/febIHY1ZIiPE1pj6Kq/K/XkV
	 XbibnFDXTBB1u7pOnSu+e8KueqUV+jKzh2w1dH/3vJt8ngavphd9JD6QONc7zJadYlxZN
	 wpzQcdGFrZpxTNjL8/c1u/wwwMfgrOHuygP9m84vd6ABwTHcmMhwa64Fcp4oarN1sMoLA
	 5hAxYCitQyUIVqrNXQBx0lZR7ftYsGM+rSS3QhS3lE0FAA9DlmQIfk4gDc2Rb7bCKhDfX
	 vMk0IxraAy/nZ7Fn2WG4pEYSwwqy5BBrj9H5RNTwy1EciMGNDBsiBfskcOpto5XHcJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=o38SHGbZ6zgVNzoWguy2MUwD3AzbhFlCQHdQs5MMgUY=;
	b=ExV/NfvBFZj+R6QhpSRrCeugONaH2Kv8OITgm79UIU9jtAYaI1pnhXrRXBB7bpwknjNC
	 aMtPXmemioEDFL19fgav9hOvGFA2sfugVma62IlVVVFDzRJ1pA18YeTsnCz0OxzouuUoq
	 R6TNT4bP0FIr+HiPxUgnjB7hDAy+hfSVbH+MPGTy2GqZUFlITTYXLmEx6sJ2g30U7vqFe
	 hy7RgXkqbTa+Ypp206uzSYgICrQMOD0mkg9pKV4BK0K1xz7ZJwV6dV3pSCNevTfWpspGr
	 ReZeut1ufDd2UnDBoiOEtYLG2FqJogImSEaT1sw+uWbxrWxCd5w+BHyXwuqfsSXFEvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0+R9SR0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gldlTce8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74765606A32C
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74765606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0+R9SR0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gldlTce8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NG2uso3733893
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o38SHGbZ6zg
	VNzoWguy2MUwD3AzbhFlCQHdQs5MMgUY=; b=l0+R9SR0OTreDR/I0IQvUgOwyPm
	EFuLboXhCU4myF0BHYec0m0OtcxP0Iul/8+mXM0ahf81ngCB2hNPgpTFKFfcDtCS
	FVHqWJJgL2xYJZVe7ARlf5oSBMcjIp0CU3VrEzrfM9D1FztP5OLd5Bz+9o8JhT0+
	3BqWhjj8C/fW/R2LaExQ5iLI3ZQvez2xdPkm3zaLERSQGo4CG7MIsUkK3wWQ7+nh
	kpykiD+zWT38ErO7m0i6IbsuUvkq8uSkfhBGwe9Knjxt66zo2spm75Pw9WvV4eH4
	/7l5dhWmb2+0J6csmtgxANyoc4KHgKtNjhkkMSNivu+H/Avb3aOfuMFiYIg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug8va-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:13:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91bebff9fcaso33982596d6.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792775617; x=1793380417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o38SHGbZ6zgVNzoWguy2MUwD3AzbhFlCQHdQs5MMgUY=;
        b=gldlTce8WZZFWQBu1OCw391OnzYez1fHi7gTCevnJYC0DMnrLYh6+1MxRo1ReoquU3
         7b9/dHWU6HbTTUsMefJbYHO7bNTt7Qsp/wKVF4atkiSfTOh3VnZYJmw7Ed/GmE6RB+y8
         KvPF+kSpHEbZtWvyj+NTYeTOVpFrvTxMdd6Dzjko8RUru7h8k+zp9rbRYeQsDXMLFtbC
         KF+GnWTAb5SyQxQ0QT+eg4fqfpEBv80PNUqqLHjnCJYu4UcmYUzeB81Z94nI0Hnqb0/D
         enM03f/Tkc52MefFKupYVQsD6JFAks8S0nFW20IW9woxy+knVRw4F8wv77rx77XFMaur
         cXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775617; x=1793380417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o38SHGbZ6zgVNzoWguy2MUwD3AzbhFlCQHdQs5MMgUY=;
        b=P1wMxvKhNO0O40LIZmd7lov9Dc/8J35pQtq9b/vIFnvXM8g+A35T+XZZhOIWY5PcGO
         GKRaR8MeaQEw+GakAncO201DGB6n6cVSM0ILs5FBr5QXQFMiVeBFOKM81VTEltPMcPBB
         ThrSkY+YiikTNkr0o7+EoXB1SXGH5Q67rWNUlQkN0garwcOsYgvk3NadHnx9FkFPL6+Z
         pf1GKQXOO+6gZYh1hr9VHSyyRytQT54KZkRrVPlWQ7cThKXTSaBhvuLTl0F+bu8UY5x6
         uVZIeocfOxmXyr+jyu388Isvkhj+IDsj1oO3x07p+dJaLjIDdKHlQB4e4bpRDzOBRWrg
         WhAw==
X-Forwarded-Encrypted: i=1; AKwUvByHyZmKfJ0LDyhYBp/oTj36U+OkPyPYAxhZDfnBwo8yE6E7eZuZWDJVyhZAW1T/eZaIe0RscdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYItRgVbLLqscQeZL+Sx3PL8tA1RwqU8KTc/qBsSRMt8pBBeEMff
	Vj1902VXnNYaSSBj9KbAaAdug4oeMm4OAR8kZzRqmPTZosDJ3yHVdK2BcJT8ch2Y8/HtigPHfyI
	pw5OTp5ZgmjH7owf55PymiQhZPkoQugbbFUg8cOlznIB3agZkEi7uYthYrCs=
X-Gm-Gg: AYBFou21cPvwgEBoR8Kro0vI/2UWgvbjMl8cc9TEmH65wE26jgPL7GW7V+CsxHPgD7x
	otvNdT3c+jI2D1bgtSFRPkGznzrbTJhCkgh/0+0gJ/7WrfQEtl6VzeEl9x8XVjzF3uCq7+bu2KC
	imta8hrfR/lZ4wj6agiUvr1WhoQKUjA33ai52pch+spQexqgKgqFQxQ4jQ8Rww5oqic9aYgmUl3
	92206lW6aJ6bgh4vuc6B1rBHcMzcOJG6BuDWEPTiPLUBRiAJ2Kgk2/UyGZr9I+JeOxo/M6wU6DV
	Qln4DKCzJ0kR5yXbWYK624iOLT6VlMbEt/6HNC7l7pzjlHPrChFzk2puRlhI0sHUJIEYImcobFI
	e7jdwLHtKVoEp
X-Received: by 2002:a05:620a:4395:b0:93e:c12c:9dc4 with SMTP id af79cd13be357-93f6f9ed474mr543864085a.68.1792775616749;
        Fri, 23 Oct 2026 10:13:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4395:b0:93e:c12c:9dc4 with SMTP id af79cd13be357-93f6f9ed474mr543859285a.68.1792775616307;
        Fri, 23 Oct 2026 10:13:36 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4104b5sm1043841f8f.36.2026.10.23.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:13:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Ravi Hothi <ravi.hothi@oss.qualcomm.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/7] ASoC: codecs: wsa883x: Accept temperatures across the full trim range
Date: Fri, 23 Oct 2026 18:13:12 +0100
Message-ID: <20261023171316.819857-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXzbPFC1lvt7h4
 CVzYVX/V2tsuJnPU8suq65rLhHPRpHz/27643YBdB/qaNz3ESZrli3z4B9pxyaRHGjUbKImPd7K
 kh7QtS1nRnkNjUXDg5WKAjxnLMSnZeI=
X-Proofpoint-GUID: AFo99SLUQex4Ldl-Xrn9ruvehRqcCInh
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb95c1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BDwgr6QAJ8wfB24CiCYA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: AFo99SLUQex4Ldl-Xrn9ruvehRqcCInh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX3m0w8ipcz7xH
 zU6Lnx2/eR1sCjxz3RtIE66TUld5XOmydRic0lAvC5l1JqZ5qinyWVodVifrt3mFtd9Bt1HBB94
 G3PfAvbYox6QBkGMXOi/+2iHo5pl7NrpJZfl6ifewzOQECWcL8Bm7emcU06hOtH/eThL9UEt5lY
 Fx2gnmGgwMB5Lq5yo7JLLiSwl4vcQ6yMrwvRL+eMf7sQMFHuOHZA2dazB+pkZKw5GCSNkFSa9fc
 6TJs/DurumxhiqXBCK4L64rMeBFO5FXzoafDqa4hcMi2zfzUQoDAxFihj6kI3WX6dHHeqmQusQQ
 TlcJVSWI8o5evuN0he/+/ezVU2Su9mBHht+dvlisIoMwJ/NjlPhtaFKfheQQf0icN6mWnU0/Pd+
 62+oMl9Xc+PB9ofuH/i+RYBR6lu3MvZXXM8qKUFYl0jHt/4X94HrSxbLzl/eJ9mux1yMaAeJ/d2
 AKnmbIphPeveCj4NipA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230067

wsa883x_get_temp() rejects any reading outside 5..45 degC with -EAGAIN,
so a speaker that has been playing, or sits in a warm chassis, becomes
unreadable above 45 degC.

Bound the check by the -10..150 degC two-point trim range instead, and
use inclusive comparisons, as in_range() excludes the upper bound.

Fixes: a02c42d41af7 ("ASoC: codecs: wsa883x: Implement temperature reading and hwmon")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wsa883x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 442cf9f3eaac..ccd4404c1644 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -456,10 +456,11 @@
 
 /*
  * Device will report senseless data in many cases, so discard any measurements
- * outside of valid range.
+ * outside of the two-point trim range. Do not narrow this to ambient: a
+ * speaker that has been playing easily runs well above 45 degC.
  */
-#define WSA883X_LOW_TEMP_THRESHOLD	5
-#define WSA883X_HIGH_TEMP_THRESHOLD	45
+#define WSA883X_LOW_TEMP_THRESHOLD	WSA883X_T1_TEMP
+#define WSA883X_HIGH_TEMP_THRESHOLD	WSA883X_T2_TEMP
 
 struct wsa883x_priv {
 	struct regmap *regmap;
@@ -1430,7 +1431,7 @@ static int wsa883x_get_temp(struct wsa883x_priv *wsa883x, long *temp)
 	unsigned int dmeas_msb = 0, dmeas_lsb = 0;
 	int d1, d2, dmeas;
 	unsigned int mask;
-	int ret, range;
+	int ret;
 	long val;
 
 	guard(mutex)(&wsa883x->sp_lock);
@@ -1493,8 +1494,8 @@ static int wsa883x_get_temp(struct wsa883x_priv *wsa883x, long *temp)
 	}
 
 	val = WSA883X_T1_TEMP + (((dmeas - d1) * (WSA883X_T2_TEMP - WSA883X_T1_TEMP)) / (d2 - d1));
-	range = WSA883X_HIGH_TEMP_THRESHOLD - WSA883X_LOW_TEMP_THRESHOLD;
-	if (in_range(val, WSA883X_LOW_TEMP_THRESHOLD, range)) {
+	if (val >= WSA883X_LOW_TEMP_THRESHOLD &&
+	    val <= WSA883X_HIGH_TEMP_THRESHOLD) {
 		wsa883x->temperature = val;
 		*temp = val * 1000;
 		ret = 0;
-- 
2.47.3


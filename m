Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3804B716E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445780; cv=none; b=OSNlCXnjGzqTDFryPFL9oEm+PMgiBpAGIJUrUfWz+AFaubnd2vDAKdjffhpAywGhucvG3vzu0BPKukhoho7iYZdddICByRY1dhJECIeT0xM33oOnInMiEtNN0K758rT70Gm+2aOJepP9vj3WPh8aFO9nzugb81kOwb6M8hN6gQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445780; c=relaxed/simple;
	bh=1h8UY7C7DRfSBJpx+Kqk2kMtTanSJ0uIlMXF2pMqnmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wk3JOvrBCUw5wTYHOf75GJtfCblMICRt1QQP1uqt+d9S9F91M0wq+/V/SStduFTAdaAm0uTfLtSr5d391Ujo3KMD0Japhk5RAnf2Tc9qEcbqOsPdQXtJgxEeDHttm59wilhspSBynLISejb0t4hO9cWNt6aZX1J46dW0B+7NUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E28mpCZO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jW5rfLb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E28mpCZO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jW5rfLb1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAbw4822629
	for <stable@vger.kernel.org>; Thu, 3 Sep 2026 14:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=; b=E28mpCZOYSVLIZUg
	feqGJZzVkbTIloQAxjTgVzF46iC2DKqWJgxBJv9nWtuyWk3iR1SrX/Sdr3eFo6wX
	r6mkjtEVsqQF/0fLb+hSDt0gZIMB1v6rOWe3gkWDUxsLA/BPl6ch6+Ri4GbDSsfZ
	ulRDNbIWlhBnJUIX0SqfrWEyQ2mQW6FE3T5GN9dZHZXzLatGPGDgLlu+VmNhWLAE
	150PEADxA1wMOfEMF6LCr9GTy+n0rrmLSRvrMmhaKJWe72nZ/brYO8RdD87kZFjP
	RxGwQ9cm9rzhZCmdNjkxF1SPjzZKz6TKovh7BKugQYcfSmbLiuwRH/ZfUEKU0qTD
	wvOb2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p713ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Sep 2026 14:29:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93918756165so596814185a.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788445764; x=1789050564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=;
        b=jW5rfLb1GTiGMJ/ggH6WVGUnYFguEj4py/ZCsNSkq7I/A/krbQILsAT3BjuVY4p/pJ
         HcJwUmFv3PhNrOlfql/MmnGr+1O05KkO3DacivO61+OInUn8t3zNsp8JJT4FGUxxXUtx
         9R9yNUeEiogEyb2km8TwKkJzJycYlU+pqM7CYdzMzio9riq4Ij2GCHJ2O+4xANAHsmYf
         JoxLFqzy6l9/+8mtsGMSB1o5x2E0NEKRkvkoISeKx2L/s6e1ILFzBwhqxzJeds44tlYR
         7CKiR0VlJKcvH7hRWel8F8wMezh+uUDewZ1Icb8KoUHd2n05E01YTSeb8Cd+3FmpQdJG
         sL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445764; x=1789050564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=;
        b=YWa7gjUuunX3X8loInOBbBBSERIl/gjlkUnY9UR1a4YYD/djl3OGuW7FlFlogy3+d6
         inyTODqaWURxbi+asuPX+JeQA6sXNoI2+2o/x0YBWC7KpTKlp6GGQW7XHEryr2Tv8Nm6
         aK4bATk0sRwXSG2kTR1PnQZ3/SME0jTt7ipXhnOO/vWoynBmeI+RvXZQwlQiKV5GcFkv
         w3CTU9/1MO+XnxXeSmOnYetpRG1tUgfXiBelqqPgwI1XAafQg62qXZ0S7qxXZY4A/qcy
         cjIByfO65No2OcZxCcl6XL1m/q9WRSioj9CjF7ERqGeh84R00nd3jmNyf4O/kWt7T0xc
         XAmw==
X-Forwarded-Encrypted: i=1; AKwUvBxf2UgPUKt0yhdv2yBjl/llcrw2zQCG+RFiEJAuqpzxxhWOCiVPOQl7xhwph5TlrxyTo+3k0tE=@vger.kernel.org
X-Gm-Message-State: AFuF++nE3zz0Y+pzpoIQacoSAQCRS7MAVzSLk275eLgdahYCKs9sGTYw
	YT+jtmsTSa09YNccExdSJFDcZLC7VMkyGggd3jiYyWJ44TXvdcbpMShA/vH8vArMsT2sedy36bR
	SpZcSbjZm27YEyOKm8Bx7ove+r4DLWVM6QOikiVGuDVrvWYOJKl6+rgCuwns=
X-Gm-Gg: AYBFou33HNQOxiMT/UCKF0RVn463iVFNtWTJlw5SqBl9kL+o2sUl/SjG9+CTFvfzVgF
	Or3CrJ4BsxerFM+tXt/7Vou8kZvyZF2sZfy0zTd6OwKP0eJP+CgXADh//vnTB3379/Of0lJwIBx
	tHC22urRj9761zPFtUEo+eRJU2CUzpVhE8gCBlEJS0lL21II4ZfHNS4nOfrXKeFvAbJ9HMsTa85
	HwRWvqqSRvQ2At24mh7e8ujXOtMYphZULwohvWe+aQcnqOJyU/hyRdOA7gtQL1iuaVNeJikcMC7
	Y1GSlqIvueiFGCDzFkq7pDp+caTxTTABvE97uAHHMIJkkO2OegM7v06A1aF0pj3IZigNlJiiMUn
	FD7xYg+MK3BZDO8Rw1w0D4bODSmEg
X-Received: by 2002:a05:620a:4114:b0:939:57ca:7e0a with SMTP id af79cd13be357-93960cabe26mr1473850185a.7.1788445763483;
        Thu, 03 Sep 2026 07:29:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4114:b0:939:57ca:7e0a with SMTP id af79cd13be357-93960cabe26mr1473842785a.7.1788445762889;
        Thu, 03 Sep 2026 07:29:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1c7d:412b:f9d3:3bfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm72799415e9.5.2026.09.03.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 16:29:08 +0200
Subject: [PATCH 1/2] power: sequencing: don't call .post_enable() if
 pwrseq_unit_enable() failed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pwrseq-kunit-v1-1-1f893d2cabc2@oss.qualcomm.com>
References: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
In-Reply-To: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1h8UY7C7DRfSBJpx+Kqk2kMtTanSJ0uIlMXF2pMqnmI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqmYQ8f67iDxjYYuF9u6KuV9DjWQ8r4SVQDMArr
 QvqpcuuORWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCapmEPAAKCRAFnS7L/zaE
 wz1QD/48X4FfbNFqvDxZCWx2jhXOClH8pEnGIil8YRnF0id/RgcwhJyI2nRkXz1UWuq+tHyUUUJ
 nIZsbzcL4LptvIbWt20lI+Qwp1S/QqZVhjq5nIFYTop1lLX+tYrKZxCIOFyPObOMx8rEOV+BhG+
 cHL6R93C6o8c1VW84qHCvz5CLVBwsWDFhJi2cMBm2vqQmPcosm2ntjl3yDHwjNe5PiUmv9mPxUA
 bqY61zXsbS17XFMG+JnBxnoLMmg8TEW8q2O1IWoVcs1LpWViq59sc1UaR5l8BZ/cUTPTGMX6Tjv
 2jVqqRaUYurrMpkbdX2U6+T0FM+q5oMzfOfc3tEQoub+GOusp/7U6DrmvjPC1wJSwnv3e9Rdtrt
 mhVn2EPAaayGyO3yHOIxHIcF6KEWyoXjDmtMWKpctHO+qC/23wEbMaSURvsqsThpD5s4qtTjuLu
 QdLT0WiuR9RmMwbwYP2GwxATeRKup8P9JJicTeOfOtM/nXx6dHS1nl8xM7JJNa3g5YiRZSdqFMn
 Kw8K3aWGuayYa3meYob3Nfx+CX2Yn6n9SQu4nnE2OwcGCgocLWVs2M5CM+qyn4YnWj7wpZOaoIz
 XeyYsJfbucjy0/l6i1V7//swCUnHokK7kUxJJKbB+wtaRLCl9wgRsd2yHYpbWwAYNhtE9kQwpE4
 Pu9efPOytK2abdw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: uTwffI7IgwgAj_q9iuA_v3J41dFW20eh
X-Proofpoint-ORIG-GUID: uTwffI7IgwgAj_q9iuA_v3J41dFW20eh
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a998444 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Trbc2l1I1fXLbfWOQTAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfXx71CsaPR9u5B
 4/qHXt/a7r/GydxovEBmSKsT2ziGVHBn7/fEkqRGb3gpyS+PhXWWmhM1sr+s7j/zxvTzpRnU/BL
 xIFaSsv5THejDSzAfR3hQICUcJrXyXo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX/rBm+3I9OojL
 B/se+yNYRorkBjYesFKVsFFxSTlyaQjF9qABfUM4psVxZx60A5z6N2HRYD3ZmneDfYXFi5goLuz
 j/zI7HiiDQGrfdgqM6q3Gu70atA1hVapVnLMmUp4+OYOwmYXbpLFqKFq9h0dOMvVpqSNxI41eYb
 R1XSBK7BRPCcDHDjkCgMXXcqBhunn904KAfMLNXa6UKy0IzzIcxeBko4WVehakK/+LA5/GcTd+F
 pte5gkIi3kl6VrgJhvzyggwDbG03nUqWhXmw3lDxATiLnY1oEzK8qCx7adYH3mR6eRwddUs3ARp
 y4BUaUFG2bVyxxYlNn9s/GTSfWleXVymrT9gx19wa8xYRL077kgE/b32qzppUY7/MbHeOUgF0yr
 thYo+uf8WK+wY4s6gjElaRJ/+tPcWmyKbr8Hy+N3xCKlr/BZDltZ7h75T8l3sK5hoJirZCjJqDf
 krAssceKnwwGqEQGkSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030126

If the call to pwrseq_unit_enable() failed in pwrseq_enable(), bail out
instead of calling target->post_enable() which assumes the target was
successfully enabled.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 721e888b658d1f254513e126bb72f2d0487a8383..76c39600f690d9f19a21f4a89512ee24942e3b14 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -912,6 +912,8 @@ int pwrseq_enable(struct pwrseq_desc *desc)
 		if (!ret)
 			desc->powered_on = true;
 	}
+	if (ret)
+		return ret;
 
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);

-- 
2.47.3


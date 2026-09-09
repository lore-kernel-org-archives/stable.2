Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED647042D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946785; cv=none; b=PnHgmlq1wcDqokSLbibfkf4Xb+f00q43seTZkf3xb3iyd5mKvD53X/9dYa2B/S9Mo21sVqdF4HgfHKH4ZTrz5UmrNXMZDR8fViCQ3xtpO0T7TTATeliw8TQ0Sf0LNP1aNHYb/4Xj3UDUAeyi3nOIoCfryW+4Faw6KRueR2xFkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946785; c=relaxed/simple;
	bh=w2vep/69OYe1Fjz3Pz5QMys34XOdM/k6R5vqYZm7NTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0skM1APUPrzU83AzaCFoWtw4PZTnE2G14B5EkhKW+5g2OPDPsFUlH9UahJD9bqPcLibt+O2ucUIdei9IN9/gEMFRCskoAJdYZSkS/FbqvLrXAhsheSnobkoiRt5hVAS+yGcRnYX45s788pvKhEoL8r7o+aJD5S5h6LzJFVrQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5AL6wqv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rbv5HMfV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5AL6wqv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rbv5HMfV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896PEpf1274625
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VRkHmq5v0Xm
	mKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=; b=e5AL6wqvCIlCXJUjUoAJyGMTG3y
	SGuoGcAw6uDhzl8jVeiT93AVUyMdbTMfD5lm8oW0Dzz5t5lMZnKUmQqBmuhG2W1/
	6T73E1aEFrf5XIMpCtD8yGigIV79cTjaZicVFKTAhhv1rLvJAt61UF60AVNs54N4
	lcyLT5D0aU/5t49Q1h8L1pRpnzR2UPBdsWHf0oB8sQgYyvJefVH1rWrD9Rzm8AMq
	S4keP7VrILx4jwNhqT+crkABAZaER+eCXvx+PH9OLsd9MmAZAUxeMm9K2Bajkh1z
	vX4s6sEZIT/6m/Eq75k6RoJiNul8wz1Cln1UEruXSalXrpay54xDMej1i4g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw3e2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 09:39:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b571432fso876841485a.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788946778; x=1789551578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRkHmq5v0XmmKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=;
        b=Rbv5HMfVIk7Ft2bjmAbW2OkvCW50z7XrjrVK2WNzS9Icm4pMW4nuSH6OWxRcmgyfgD
         YpSf3CrT/G4X4pWI+NIBKfc3Nmop3TLmqHH5/zK/n6uXxIv/BtpuxAsJ+kuTG872NOOl
         IIODOilVLAoCCT/9hfU5w9Lh+0DJIrXvgWDqiYm34vghC2jFIf+zrK7LY/eZSFfdPThJ
         mAXdvfBCVEKuwHk+sUmYZtEIZ0NPXLr0ho6gxHz+hNSwydV4kr2toO12w0eTY0Zj+lUQ
         J/yBkmPevQ++7O8z5sTDkETyQp8D0sqG7jHe/4wpoy8aoEGmrb9kmqFb5Zq7PByS8rEn
         FFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946778; x=1789551578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VRkHmq5v0XmmKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=;
        b=R+BJVhkhvQ5pC68d6OJpkzXOpKUskfscgMi6HRe5ewYsptsqPvxruFiqKBWrFO5KCV
         daAPQeWgOiwaNLjJFL8+0uvA2h3VGp1yGJVJe6C3zHvP5OJghNAGA4vux1C82Wjs3BzI
         WPcJDWnxhh8y6ZBE0DkXJESK8x0W0XvSEr2fZvXT04HVnhm5RkliZbeHwpUC9rrUTTMy
         f6LI1DZxao3wwCZ20dt1ZSDJD4tG2mlY7rIf+36P+yeLGZymvKrFWiEJtRwfvGLXEP6+
         JqO8TFQdgw2jhabsCNb1brtHLYZkUaIYrMTyA0pHqzMrgjY52xnd3iXECrV14ycxjOEW
         pgZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrjv9/lECN0EBUQpLjv6JTcv5Y6VF88aw8o3Iu6ibm8VdN5FHPJ7Iju5LYyBMK0cIXvhw2hPk=@vger.kernel.org
X-Gm-Message-State: AFuF++mE/xjisSFn1jSThjUZGDaT58csmFlV30x1E4x4aXAatSAamC8o
	JxCAKJJTvJFHkfyetL6GDwd3q2pzYRsjkvO0nv5QDpKDDa7+j/USnbEkHJYYK2FH6n8Dg2EJxy2
	fiZ9hCEAj/Bh9SvJrEXMQ3M/pdG0s0Ub6uzBQ1Xq9XXOeyrMnL+HIxs2l1Vg=
X-Gm-Gg: AYBFou1stWBbfLnrYXGSFLDKDvoDnNdVlwHMb+S1A3W/c6ZRIjB0nFSiy4e42Fz1zcI
	BG5/EqhNAEhS4uTqcUfKAP01Tu7o1oRsFLx5ZNIjd0IDWlopyfOC1+dnKs770NN7afBqWebVLWJ
	hbq3XrjwwNKQ1cBWaxmwb8pFasTrltB+mU2dA7GC1weHfeJL2aIXNlOi/B7m9pUjJGVDHLE7vJk
	MGCGHCzT2LvFelbj9IJzo7BBqqzXgcuPjZ+rD2FUrfinAOLvxENc97RO2X0IMKl3TM0BjOBrsFj
	m3WLgkhHESV9pBfOgtMKJ8OXMnplJKCUyQyF/dqWUwVi5HccLXDRovnzYOQqA/laOLMX2d1+q3G
	kA68nD9JNhhPE1zCrEw8SFR0PiDehllzEjQTuWH6xjFe2HzhQJO5mHkkDiBPMCQ52gIU5JVSFwO
	0HBTsKHW8poEAlUXQ=
X-Received: by 2002:a05:620a:4857:b0:939:5d22:d1f0 with SMTP id af79cd13be357-9396dead4a3mr2695844385a.2.1788946777983;
        Wed, 09 Sep 2026 02:39:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4857:b0:939:5d22:d1f0 with SMTP id af79cd13be357-9396dead4a3mr2695842185a.2.1788946777560;
        Wed, 09 Sep 2026 02:39:37 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e19sm6387800a12.10.2026.09.09.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:36 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org, Shashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 2/2] Input: soc_button_array - check btns_desc->package.count
Date: Wed,  9 Sep 2026 11:39:34 +0200
Message-ID: <20260909093934.29411-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
References: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lZRGiqemlAr_vR83aj0SlOPKeCgXVCXS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX1b1Bvh5G81mD
 ibu66AalP/Mn2eezdo3gB7jC2Ej04QI8F0O9fS+UcEWXZOhydG1PuteVtWuLjWcq0N6i4C5hZbI
 6XlpuZC7C76meylSjPat1ztY7qTCM68=
X-Proofpoint-GUID: lZRGiqemlAr_vR83aj0SlOPKeCgXVCXS
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa1295a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3jGYf1cGefsEezAl_3sA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX4LRzVrhaBZNk
 N1GnHtJrzQ9vSm3GgTmOXu1/bIhPqKAZsloe4GUIpJlJfudJk4zSl2CelYrb7q44iAYjFde2F4G
 31JuDSJTiyD03jBFiQWwmPBce3zwcJjdhTqDigKUXL1pzyhAVLCKX2uceu3z4LbCWO6b0seaEWx
 UrzQvkAfFThwno10OUW7UBPm5Ong2b7fU3d/LrdwRjQgs9B9qLhWcgClU/OQgNlAVVPX9IL3J9X
 iWLJ94nuYYLk2AtGKQG4WZZVtk32MqFLR4F6HUhl+seYU/mHesj6d4qTpnawfy+0+0aBiIQ/sQh
 6qk6ghq3SEQECH4mjHg0NQqcJBLG0O2imn4wCd0QZEEEKcm9eslXDVVa8zRkKfEc6XnqP5mATdo
 6fyjo8W0I0sz6UuWgfsCy9czsFp3CUjokUfOmO13POUzzi2fVMJB8ggzC5/jZB+dgje5ZPECC6e
 NSqQLsLjHfzq9UhQcCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090107

Check that btns_desc->package.count is not 0 before accessing
btns_desc->package.elements[0].

Fixes: 4c3362f44980 ("Input: soc_button_array - add support for ACPI 6.0 Generic Button Device")
Cc: stable@vger.kernel.org
Reported-by: Shashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-input/20260909091440.3384C1F00A3A@smtp.kernel.org/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v3:
- This is a new patch in v3 of this series
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 264c41f80d2b..f08e29af531f 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -377,7 +377,7 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 		}
 	}
 
-	if (!btns_desc) {
+	if (!btns_desc || !btns_desc->package.count) {
 		dev_err(dev, "ACPI Button Descriptors not found\n");
 		button_info = ERR_PTR(-ENODEV);
 		goto out;
-- 
2.55.0


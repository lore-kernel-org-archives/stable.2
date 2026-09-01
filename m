Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B003CF69C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273405; cv=none; b=evY49BKOS+WB73oNDB7IpOTCLO7cGwabEMx6h8riU2IorL0ZWwJTt7GxX1/txFzjVKljNR7dCpvifEn38ymw0gjiwjNr1j+kCNsxdTb8iDSq/l44fr+d1LzJkNqhB4JFpGFZYbKpPxH1DAXT/9ygDrmIDN98WsESGqFPbUbiq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273405; c=relaxed/simple;
	bh=8Yq6wA6m597vsL2jPetlIgaUwdUajeAMwBBwubaUTuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL9lu7risKq3EI3cMYdbdUDe2t6nobo4uFB1rNTOHy48/TPMNVeIUBXmiVP+KE/cMMFjK5vLb0affFW3LppTSrbdJ7PE1rdpfnAliRagHguyu3TP3dXBCVju9u0GBtqjS11monu69BipVifkF8Umqm5QskEWZGERQLJfnhE/J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2d2pV/l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJeQHHyf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2d2pV/l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJeQHHyf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9Src1638707
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 14:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/
	0yEsYKiE=; b=k2d2pV/lvVru5YRizmlLEw0a1C+uvOmyxT1MG+VnhwgvW+Y1fDH
	OBfEYk/cJnWOAYzr9INzjY4Wqgfus4hfK1gHvaLyjms45WhlbqbzEKYU2Zy5j1aa
	C/MKzWtf6sQCSsTrL/yZ7U5m1V/eV7vi2/A53iMHMlhQgiOOqoBL3WAZgtWQnXv+
	sR2OuGiZsyGTPfCJ3qoO5c8OIXlZN3mk9A3EHg//OihlA/69lEBduzxvLTIYAaUi
	QXbv/y+O21MIlxdUkx1aIHfOvg28DufWGCXcy8w+3OHYA9JPneNJSYxRLVjIntRw
	AJSMowMHJdNR2OZEYoH91qkmfq6upF9udZA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcsjcxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:36:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so7957594a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273402; x=1788878202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/0yEsYKiE=;
        b=AJeQHHyfL4vBzMVEMTClqST9lfv0onhx31qx6qf6PXX1EZt73RH1Uk+ZG9O+Wyulgl
         W1FLqtdoXx4PjWlIBGBVja5yK4m/wu6YzyuLg4rarDaJe3UdNhEBfDmGruHqLyDAaL/J
         Q52OPRrwG5sCsbY6Naot32Ccb6KPzyFaiuQwgTf518H5oqHWFFAzAoeEwiHnwdCu0+kl
         8SBq4tBFuxh9Thcx+RN2tXXAxN2DRPEPIvH/xvSDBxEw7FHmEOQzRh8mow1hGRGxBk3F
         1aWXpSgThPPaIyKO6BczZu9RgAwz1fMmw2HgUwn2i0rDwFxQXH+JIEmahaXRiOrTRhMj
         capA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273402; x=1788878202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vts8c29USZkd3oUusvtXRpscx8Ph+Zcc0s/0yEsYKiE=;
        b=d5Hs4CZCY2YuiKSePk6ZkgFQaDRicBGfwr+VPVlU53T28tpoxsNcS1+Ftp2bmpamXJ
         O6XzNXNeLw84WoR5rn8vfqfBEcNoD65h+bRUNf/X6ha5e+ubTHrrE8jvAfTZ6UZ1+cib
         a6hbtDYEjBNuSs/ncbKrDjsQHd1HYsbNRQt20eZ/Qf+vMUkJmUrz13y4FPLRo/J6q+B/
         49NcPKjuN+a0SnqUzB6HsBwVwhvfHfyQjVgZ+oThunOEi6ET6xw3EFlmkAMnE7Wy0Sl+
         aQBCns0dtWul7B5LXgtydUHp7wEQkMrnfvayfw93lcBz0iODqMElTMt93VIElXu8sP4a
         gpRw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/OzLpp1Hvji2Ug0I8cPw8IGse6QyVvPxvTSHKvAi789R9rYeGOE5nOwWM9Gt/FWIupCyM/dQ=@vger.kernel.org
X-Gm-Message-State: AFuF++laNdcp6Cg/c6h1qlacp1/UKgFVpsG8rqoLaFmQzAle83c0SMlw
	mOEdLuFQ8g6uk7IYzaMzow2oHT0GM1bAiU47PggRCldALYFomMOtT0kndS7+tbJ2A64xemV+eOB
	MY6wa1dtDFrtxyFce7C1lq7pZDREb7ZTV2pJ8R8EplQKRe96r+OoQ5U+DnxM=
X-Gm-Gg: AR+sD10JogGYytgqm0PlaYJMWbKi9prcgzRoeb24HTNuIaG57AYSGt+SZYEq0PnDow+
	MTpqVDIdMIlp866/Mk40Ma2cHx7zPQhYFLTmrL9PBkQ9m0ElPziFaWQyZRQhIOb2PMu+fiKtLMw
	W9PAn7vMi67iz1hEzLjhJDQtya4QAUxFUSpfWbRqyx7TEsQxinJfo+XSPOQZsQbWxcTlrZD7NGr
	DfxCsKkPlr20n0TlcRfHIBc8UeO4PgoNPZoo6X4mhWfR+/xMJaRoF+bMnYJn1v3TFZh0UiFHhbx
	Kk+8bm/W+RiDpx8IdP71ZHKXuvm0dI7YuFjzptDCyXOvUAEqfdEStLnRjJNj0x4ns0P3U8RtB8I
	fjpDoImmS8tKpjEDfmzEQG7tNT2qrK786hVgSfZriXSETsH7JTxx/9/A5gSe7JEvbczw=
X-Received: by 2002:a05:6a00:a220:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-85b5968a145mr11062782b3a.3.1788273402143;
        Tue, 01 Sep 2026 07:36:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:a220:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-85b5968a145mr11062694b3a.3.1788273401603;
        Tue, 01 Sep 2026 07:36:41 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be99255a5sm1259669b3a.61.2026.09.01.07.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:36:41 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: zero-initialize policy cpumask before sysfs publication
Date: Tue,  1 Sep 2026 22:36:35 +0800
Message-ID: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfXzfKGYAJqKS6Y
 7zm/qbArmiHKHDuYmfr5RtSDAxr8xAn5XyM+EqvmB88LtJJ7DjIPXZljZib4UQgeVvqmvOX/dwz
 Sko5FBN77bpWVl3PYNBSgJW8tQH6PAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfX+3u/2Ctn+eIb
 yMBspMGzvYE/OZ2l21IEZYVpo4NJ1JuTYMP2cysYJIYdrcI3kPaNuxB9ErTb0Yvh4FNk8+J1dRM
 mZnkH/lEI6qnT2pdyF9ASx5Yp2Q/3EEEtzN1lhsucburh0FvVV15FKuhN0MpPSwNNTB2uGam/3d
 E+emGoaXmO/rQyuD/C1LSIrLQqbd+B8gUFIHk63pWs9DECmFim15XmLtxo1ukbmoiSHGrknA266
 4oDtGJbf9Mya+SqOmQs/+Jk8Bc7dqcQ1FdGprAcPkoOOAhIdJ+SEykH1wkGGbO6/GLE6xRYb1pR
 iH12WRc+zcFtmbc021eSdGgqer1Dw9DK4PmC9Ew+IbiEHE2aOzZ1nkslcSv2GLncUCoC0sxcY0w
 PMmc24yUatykKJiY/vdN/HcXO6tq/Nu8sODMRy9OYN4qwg2kTC+cHgm6Y4c0QBOt6IXQDCaLVlP
 cmRCIm1R8GVC2JPNR6w==
X-Proofpoint-GUID: TQM0p7kIV1Esq-6fTUkTH-rbzKkpqIcT
X-Proofpoint-ORIG-GUID: TQM0p7kIV1Esq-6fTUkTH-rbzKkpqIcT
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a96e2fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hVcsQZ9HNR-0QQQrEgAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010130

cpufreq_policy_alloc() allocates policy->cpus with alloc_cpumask_var(),
i.e. without __GFP_ZERO, unlike the sibling related_cpus and real_cpus
masks. With CONFIG_CPUMASK_OFFSTACK=y the mask is a separate
kmalloc_node() allocation, so its bitmap holds whatever the slab allocator
left behind:

  cpufreq_online()
    cpufreq_policy_alloc()
      alloc_cpumask_var(&policy->cpus)    /* bitmap is uninitialized */
      kobject_init_and_add()              /* policy%u/ appears in sysfs */
    cpufreq_policy_online()
      cpumask_copy(policy->cpus, cpumask_of(cpu))  /* first valid value */

This leaves a window in which the sysfs attributes are already reachable
while policy->cpus is still garbage. show()/store() gate on
policy_is_inactive(), i.e. cpumask_empty(policy->cpus), so a non-zero
bitmap makes them run the attribute callbacks on a policy that is not
initialized yet.

Fix this by using zalloc_cpumask_var() for policy->cpus.

Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
Cc: stable@vger.kernel.org
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
This patch is based on https://lore.kernel.org/all/83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com/

 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d0df986fa3d..3b1b2ed86cc3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1249,7 +1249,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!policy)
 		return NULL;
 
-	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
 		goto err_free_policy;
 
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
-- 
2.43.0


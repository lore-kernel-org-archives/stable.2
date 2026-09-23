Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E652120D;
	Wed, 23 Sep 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188218; cv=none; b=fcVslyhJABc2LaATZidxmNUYx4YFvlTrV6RGavVdZyzCu66394QSh78NUcLfRvJSB5ah+r6LeETTIckU9KJWbe3GgciJh+rqw93W5IL8OG9YDOcpvYBDqb3keQcJcoJ0qXaJeCT79/VCVMEuar+VWqyjh6HXYASpJrA2uZTyMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188218; c=relaxed/simple;
	bh=QrL7s1L07E+hDgPq4jr4STH+66HbgawTnYeKQXBrTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUVwClh8AqMS0+2fOaUcYVx/0QdeLhe7q+NX8iuDY/Jsf3ygdl3OXvSwuNgC5vCdr6MATFd4z/IIRRW58+ZOv9FIvEBIUKSLAWE0pdCNGhLs+A7lX15zXEvhM0GUvfUcpHx6rpvtdSUWlZY8vUdutFy4fLUEDb7hkFQ8697ZA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TbA70Nlj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TbA70Nlj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZeWh2748809;
	Wed, 23 Sep 2026 18:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V8FKdjbglwkp6JeUw
	/gWkGs8RKEryyBfh04FHL13StI=; b=TbA70NljE3q3EtTp6g/Omu+9daTUPCJzA
	fdl4cCHWmojL2zGYsj4FNawPk8XUlw7nHIErIkkYoI23fQ8gtremtvNx8DQP5dMd
	vmB6d6hLshi6eTTWslf9Ik9HHy1tPUMLk5jjEWx1i0RhyeIiHilMojarbLDUgsPY
	Zl088EuOJ5vY0K9ulN83Y/q/oRXL7iVPG3jcherEw9wLCE2kIKNVbRPfkhVc7Ftp
	kvWAnQ3eSqg21ALFc+BujXB30VWooAa2sNoHAJQOnYdD4iW1olsUJZ79kNw7fpxi
	/2Zo2BAX7s/Ul3LpgvP21dtDPNA2OEQM3HmNwLdjhScNSmA29wceg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqmcbe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWxfY682244;
	Wed, 23 Sep 2026 18:30:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qj9xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITvxp35062226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBAD22004B;
	Wed, 23 Sep 2026 18:29:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD9820043;
	Wed, 23 Sep 2026 18:29:52 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:52 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 09/12] pseries/plpks: hide wrapping_features when unsupported
Date: Wed, 23 Sep 2026 23:58:13 +0530
Message-ID: <20260923182816.151451-10-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab41aac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Lnrgi2ogIeW2OlIaXxgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX3bUJz79CUo1k
 kyFllup6jF18G/dmEYgpaVeZRvzeXZ6vOJv+WQC0Tqc0dpX10uRG9JX92yCyMS/YA4cEJU/hKzJ
 gDDa8j0JW88zlIhLSSx1BTsCFlJfSA/2ws8+5Vc5T7ebplk2guSanx27mzIcTtHAxfIq6Ab6XNi
 5dTMCVUSUl7hj2HhE+dlCvbgSXNlDZ8EZkujcRqx+jBLB2Y7szWnQ6IbJ4nrj59Cnow+UxfHVhG
 bw8KF3ZBM1Mu9TFCaWJ8UwmIQ0sabUkBm7CB9iFU6GtnGASll2ERHUtf9EFNL3sdvNvzhCkqbpL
 itVbo3FIL6mz9wuUL4O8JowHmm1WPrMBOvpenJsC3LDRFrg3yH8DrIDJzxEYli1H/HWHsyI9zAQ
 ucz3uKlCRB4PzIpZF4TMZ/+sZCqnDEOZcjylh5QKJX/cdG7+T+TOSDUp4HiOicItWs8bjUjabsy
 nQblRVECyoCjqVZtiAw==
X-Proofpoint-ORIG-GUID: QW7iC57hErNGErSPMKJzBhgkoI269dXZ
X-Proofpoint-GUID: 5eRUMSLeBeUtEqrBrcPgrzQdtvOBZpNp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX++zTutXSxTlD
 gbX/etK04WeEwgspq0zA4uyW59/aj9zOU3i0ti4KOzF0hhKK7aFkfRlMRa2vaYt16QtqkwsOP+5
 tEtoH5mQYh+q6tOwecL7LBgq43lZ7+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

The PLPKS wrapping features config is only valid on systems that support
the "Key Wrapping" feature. Currently the config is always exposed, even
when the feature is unavailable.

Add an is_visible() callback to suppress the wrapping_features sysfs
attribute when the "Key Wrapping" feature is not supported. Declare the
attribute group static const, as it is not modified after initialization.

Fixes: 447eb1d5ef00 ("pseries/plpks: expose PowerVM wrapping features via the sysfs")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks-sysfs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/platforms/pseries/plpks-sysfs.c
index c2ebcbb41ae3..f2436229f323 100644
--- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
+++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
@@ -45,6 +45,16 @@ static const struct attribute *config_attrs[] = {
 
 static struct kobject *plpks_kobj, *plpks_config_kobj;
 
+static umode_t plpks_config_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	if (attr == &attr_wrapping_features.attr &&
+	    !plpks_wrapping_is_supported())
+		return 0;
+
+	return attr->mode;
+}
+
 int plpks_config_create_softlink(struct kobject *from)
 {
 	if (!plpks_config_kobj)
@@ -52,13 +62,13 @@ int plpks_config_create_softlink(struct kobject *from)
 	return sysfs_create_link(from, plpks_config_kobj, "config");
 }
 
+static const struct attribute_group config_group = {
+	.attrs = (struct attribute **)config_attrs,
+	.is_visible = plpks_config_attr_is_visible,
+};
+
 static __init int plpks_sysfs_config(struct kobject *kobj)
 {
-	struct attribute_group config_group = {
-		.name = NULL,
-		.attrs = (struct attribute **)config_attrs,
-	};
-
 	return sysfs_create_group(kobj, &config_group);
 }
 
-- 
2.52.0


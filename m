Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E936556B92;
	Wed, 23 Sep 2026 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188204; cv=none; b=flMJWBLZvv5rLOQhLPEXFA9amDLbURAXBCtjT8x2YOZbDw9bAnF5BHdNbcytRquI2ZpOnK+yoUhuaSWl99OknHjp1FhIv2ikdb1tpZMjn/yGGimwLnWdiVkXnIHk4kKrUJ1P3cotI9jlyNbUWAq1taGstM8FW1qg6n5jHObHwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188204; c=relaxed/simple;
	bh=UOa264gU0HKr/iFrlj9ZmkKo4b/IK0gm6en2+TvOe+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0t0qJzHMERHayomRVgXmiyrA/irb5FAY4vWoKe5BABnnOd3wii9c7Uc//m8zDvcFYtb/iQ5eJFoRVYbFIHnaVA4d5w30rSbSHRQMeRcICPxSJFvSMTeBNcon39Wm8wA1Jd7wbX9t/N9jRtOgVe900Uz03xpGA0MK5dj7C/2/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxPxyGeM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxPxyGeM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGaFY53765689;
	Wed, 23 Sep 2026 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/68d2jRHIXwzdYdWg
	ZQG+0mX5K+5CfoKIkS3N3rtcq0=; b=RxPxyGeMkBUznQIxbBEq86GEGH2uLcNxw
	hRn16REu704PPj4XXlVm7HrJvoRzskdk03cJyLGGn8+drsR2oi+QFGmL7Jf7l3wD
	xdhuz4mqbjx1lK0tlAekS3OpvtIGgru17vTNxCz58RJbTeCZmKDK9Z02yLIORozU
	DOsWDy9O0HdbqXZpjRyt1SfE32AZvpPEeoY4/V7xxHa/oWKALWAGpjV13fgdsPlt
	anzp75wIegDOj1XNw7ctiu6dAKyTeKFgaEgJEUI8VjrvRqu6XnPM4nq2pglwRqQc
	Wys+am+YCCl86YR39ihY3NbZb+I2zrL5YpR/0DIF4+K6NNopc8EBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1mgnf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWmSs681758;
	Wed, 23 Sep 2026 18:29:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qj9w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITguZ42074388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC2020043;
	Wed, 23 Sep 2026 18:29:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75FE020040;
	Wed, 23 Sep 2026 18:29:37 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:37 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 07/12] pseries/plpks: clear SED key data after use
Date: Wed, 23 Sep 2026 23:58:11 +0530
Message-ID: <20260923182816.151451-8-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: OaK4aawNOFcwnCv3Wa_qvEK8Jv15GudF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXzPHcfBpH3PMz
 mWecZVLxRUnQotKQJNB5NsVfxFcgFEIHZERuY1+L/A2ngLIYqF7tslvLZWn8shLRPW2+Dh5m/Ll
 uSg84xXNvDT1ERcfj6aumnzH1R4Non+UPG7D7VGc2b/hI5yTNrFDsjAlm7VOB7cl+VNaKweuvgd
 ZPqkv2eoUqo3P6zkuEz9y0vSrQLjnvUIKzM3zouZUkNC0QrDytUKItZhV0xBSOT1mycGhnkB517
 5exA72hXpgJfClAboCSv+OAJ/E4+LtZesIoUMY2scRsDrAMbg4zFjdhiySd1FNG4K5XKkgZAdbL
 hAwMnTUCVu86oSA1aW1pZVBJWK99o8J9pVsjEOQNlidGw3Wu+ELlzMFK4GUuUQXjeBbFkGtmIzl
 0fowuYi4aWlBY68ABjzPSWbKQujf0PJqF6iGdGe+DYSToxWYkz13yz0o1CEtXLjFTNP6oFJr1AA
 AFY3kcvAUqyMMZOt4JQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab41a9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uQcaG2zeyhcm6AiLOIwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX+ssQjkiMYQF7
 dKyD6E8elWVdlkXCd8VTyzkKDsIgSfvxZZR7b4yAfSv8yygRIbkMXMiZhuCgZTRdiZIvwO2nnub
 HuU5g+oL0UzZRovjF+2kuFSt3laQDok=
X-Proofpoint-GUID: 8ZWD4pzB8hvzzxyI8mssDMUS0t-senxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

Explicitly clear the temporary buffer containing SED key data after read
and write operations.

Fixes: ec8cf230cecc ("powerpc/pseries: PLPKS SED Opal keystore support")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Greg Joyce <gjoyce@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks_sed_ops.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks_sed_ops.c b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
index 7c873c9589ef..ac3ec2ca7fbe 100644
--- a/arch/powerpc/platforms/pseries/plpks_sed_ops.c
+++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
@@ -84,14 +84,16 @@ int sed_read_key(char *keyname, char *key, u_int *keylen)
 
 	ret = plpks_read_os_var(&var);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	len = min_t(u16, be32_to_cpu(data.key_len), var.datalen);
 	memcpy(key, data.key, len);
 	key[len] = '\0';
 	*keylen = len;
 
-	return 0;
+out:
+	memzero_explicit(&data, sizeof(data));
+	return ret;
 }
 
 /*
@@ -102,6 +104,7 @@ int sed_write_key(char *keyname, char *key, u_int keylen)
 	struct plpks_var var;
 	struct plpks_sed_object_data data;
 	struct plpks_var_name vname;
+	int ret;
 
 	plpks_init_var(&var, keyname);
 
@@ -127,5 +130,8 @@ int sed_write_key(char *keyname, char *key, u_int keylen)
 	vname.name = var.name;
 	plpks_remove_var(var.component, var.os, vname);
 
-	return plpks_write_var(var);
+	ret = plpks_write_var(var);
+	memzero_explicit(&data, sizeof(data));
+
+	return ret;
 }
-- 
2.52.0


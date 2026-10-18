Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5C3DDDDE;
	Sun, 18 Oct 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343421; cv=none; b=msiasie7QJAL+dm9KwsAReSuZ8BT/uxsasnwwyGbWjQkfQ4W2kirZ0OGfgD3FUKGncU/HlVzbvlQ2BYLqyU1vQo8F7KU/VK3EgSzD/Ji82M3C8BreSW8cswfuBdlJZQ2TWiGgjsSEAn5QBEVpLPzpeXi3my0BF2AUobWDidfGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343421; c=relaxed/simple;
	bh=qdFrkCm+W8+77xsYDAo/ZIHQjh9pP40LMYpbfpAPYkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9D3UnZUQwH2nWWvDv1KWs6wab7DFsrps3UFir+tbR86P6WnIifoV3jKsWQSHIutXTSmDok5InWPMo4Sm6ZPDqXo8XwtH+IJ26Viov/px6QB8NEya3Z+SMMqXZncxqTletjxmOQilxfi4diK2rx4J92nWnk75G8e3wOK4zi4KGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dRq+LdC1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dRq+LdC1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFEjT81412148;
	Sun, 18 Oct 2026 17:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UwAOYK3hKGE7aM5Bs
	WRTnOVXm1lEw2FQ6v2Xm9ujK0o=; b=dRq+LdC1Z8bB+frdpm9YAIDoDBabyJFut
	awsAf2gzjIKugD+AjS99X+jpO8SaQZqqxeydJuiwoAlVKwvQ3wK7VcVjrklkUutg
	MJXsO5V5vcC5WUXcdS6EtytrBA76uF9fCyuIM1lrz8s7GBaq/X0d15ydvDpY2Vg2
	rk6q8Fm4KNELYI5b9GJVP6myR7U4oDQdDV56yhc60TSfKeDQ29rtyFxpPnOGKZgJ
	aDNw1DoScQht9m03MK1vvH/jc8ZUR5m/vJgrwg7NjrIl3OAnkG6lYpyb323qa7N6
	ZIchbiU/ddLITJzAW221ZcfMs2YSgYbDLSoZKWPoTDWh50Of4aNiQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h56qnu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:10:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK2JG2693298;
	Sun, 18 Oct 2026 17:10:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjt6ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:10:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IHA2Yq37355864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:10:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0429920043;
	Sun, 18 Oct 2026 17:10:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C9620040;
	Sun, 18 Oct 2026 17:09:53 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:53 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 6/9] keys/trusted_keys: clear sensitive PKWM buffers
Date: Sun, 18 Oct 2026 22:38:41 +0530
Message-ID: <20261018170844.491252-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfXx3KhleQJ9b95
 Di/+A3CnKxgS4kThWowJY5OILASm1P4BkeqLKyVk38/pYWNKI+8u/nJYsSy3YZ0/AMh4X15ViAv
 vOdqVkYoGoYxS5fA+MnqK+AVwKQOs0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX+Jk4dblUQxSW
 eBbbz8BbzFWeabNG88J+rkak4DrIgCnz2bFmJQ2mB8Wa6YRl67R3PhUfpB2ksZPiktqsViNOY7b
 t0DWDpL3jysWDyAPJG/+tycI6G+eqV82++tFkJa4spPdAsiic3bVipAea2KRJ7zsuZWPKOjAM7I
 gXh+2WLsgx63iTRDodaluHNoleK0ya/pC6GAzW5oSU/36zG4naOJVegZdM/6JCHNcUXRjjjfSeD
 Cwc0T+s7ag7yV8nawyPu8qzP6J05PLSMZTYeJMms89aXhhN0I4zbL1B3zYJ1UrzPqiVGtp+3I1M
 LnQ7m34mT65NMSLla6jXHh7kKJxhxy0R3Arxjo/nbGMi8G0zquVZIZBab/qae/pbjkd4j8CrCoR
 tR74h9gf6Egn0sdeZNxuTR152kKsyQz7B/df68a9oo9WgTEBScvpnEDexJxHO9rGWiBcrH/LMDX
 GBL5VyZupXBRV3+CoEQ==
X-Proofpoint-ORIG-GUID: 81Dxw-8ae2QEuHPM52pxlbCeVCstXdUO
X-Proofpoint-GUID: qbyyXaogK96KhV0mB8u5AFhAIK6YK6SP
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad4fd6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

The input buffer to PKWM seal and the output buffer from PKWM unseal
contain plaintext trusted-key payload data. Freeing these buffers with
kfree(), without wiping the contents, can leave sensitive key material
in memory.

Use kfree_sensitive() to wipe the sensitive key material when freeing
these buffers.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 7345f233eb74..b5c3d17be475 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -118,7 +118,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 		pr_err("Wrapping of payload key failed: %d\n", rc);
 	}
 
-	kfree(input_buf);
+	kfree_sensitive(input_buf);
 	kfree(output_buf);
 
 out:
@@ -153,7 +153,7 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	kfree(input_buf);
-	kfree(output_buf);
+	kfree_sensitive(output_buf);
 
 	return rc;
 }
-- 
2.52.0


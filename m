Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABD3A1A3F;
	Sat, 17 Oct 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262403; cv=none; b=eZ6MjqYEnF0OXev9x7Va27bukkaH7MVpUhz5mhTA+nV7CdgMNXsjLUnwBuaGjRaPKDOoUuKZLTUlAayT1TbHN/j8XijwEZgON35NlLoamzfW+3XKAJDhu+qqw3BHEdp1g+pfq1z2XTswAsvorVDxPnmhq0ZVrX8UE0INArzvJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262403; c=relaxed/simple;
	bh=3BML9Diq2iDrub7cVCUHA7zANQIQ6dIa5AeZEvig3qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyBbYVa2xCxjKjwPIuG5pQMdnBx7llhxz9NBrXj1NcVWnM5Jp/Ey3gORCaaEmLpa6f2DFRqGqrLy84Zh+cG8yT/otyyUSncNvBS7sSRQhqvuNHp8SalrIJzhs3iw2ldiHGoG9Y2Jcb5I2wl3aPknwqgA7DXdqVZ/xy681HoaDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=So0JUCjI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="So0JUCjI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEKVn2777425;
	Sat, 17 Oct 2026 18:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jOSTDu/LPV2hnD8er
	mLoXOjRDsEmLDyWj3fpyB7Btwc=; b=So0JUCjIr2fGjiXj+87oormTg2peRrWB7
	25ksoHWeAx9pnmX1/+COasuzz7t2/uCNajKNagGs+CB/NOIJPlwQMQEbQi2WU67w
	tG4Hkvve98J+qBh8OrSIWgte5kB4+8SuBe959mXgC8hIEUhqefKVqUoubCfFHRmJ
	wg5qqZ8ksOASv8N1+Mac7TbfRxBTU0Cg0zq+d6Z2kjiLaSU+CiBXCCBSfL8MbVzp
	s0YxYyAD6kPMrS8CjJ3ufxiRlwYTR6vZRv2sHHmdg6zCvW0uXhJB4XzdeioArQXP
	2BCLQPkzM5zsxW152LcyeSUu8Ab7QAtuevwqNIojz06vhwIJZ8ZGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehjwxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJv43078174;
	Sat, 17 Oct 2026 18:39:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hbne4vs21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdi8r27919072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BEE2004E;
	Sat, 17 Oct 2026 18:39:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB6E20043;
	Sat, 17 Oct 2026 18:39:36 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:36 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 4/9] keys/trusted_keys: propagate wrapping key generation errors
Date: Sun, 18 Oct 2026 00:08:48 +0530
Message-ID: <20261017183853.596052-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfXzo6gKb5pGW7W
 8/GJYaPwGGg7Yy1dV54H1ewOBAN/K3cz8WsCjThs25qbXGfN3WbHRBSUcUtK7cbbe57iHuYph0G
 w71kcmafnxzbkrpqtCrjz3pipiZ9CgK/aaKqdqn1T9OfzLj5Uwu8eaRwHe5Oa/tkKmPxm7JZUsb
 +KcRkyKo7TWhZjwpWSFWy85TBnHnCyNLC+MchXNJ+Zm+XifTmXBTsOG9V12tF56b7Gtt1JjI1cQ
 pc3tPkp5JY51WxYt6S4aZ656YGE09bh73OpODsIloCn/1ufBRr/UtzubK9TROoWZYQX3kWqkX0m
 UPJnzSPXnMVhzXh3fytSHzUlUbuSPGlWMedmglxQ1ByXt+7fEGB2FWVe7yb4lT0+0lj6c3ze7LS
 g46+Q/9WGpYtoFFElABC+bUYgmKKl/7pBEc1K8wA7jhNX2fP34i7w6/M+EMOWGF8lcd6m/b9ZmW
 r+8KiMkys9NB7g+AvqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX5bLMRjByCHgS
 fi+CoLBMEf+GzXx5NQnxTXohMZwnZ2tDEqWYIVWZg1VUNsREDUw5I9u/xBcCwy43vXJgV4PWsl3
 BDmRK6sbo3ppBbB7/DYDv+Gpfcnt3NQ=
X-Proofpoint-GUID: lZo-g7myqHilAj3ve6SsPOqrPnpFwt7e
X-Proofpoint-ORIG-GUID: KkqnyH5BETKvu6fRRbNcyUf1o6Ke_bJ4
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad3c0f4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

plpks_gen_wrapping_key() returns a negative errno when default wrapping key
generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
failures, discarding the original error.

Propagate the error returned by plpks_gen_wrapping_key() unchanged.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index b6b5697426a8..633a7674d065 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
 	ret = plpks_gen_wrapping_key();
 	if (ret) {
 		pr_err("Failed to generate default wrapping key\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	return register_key_type(&key_type_trusted);
-- 
2.52.0


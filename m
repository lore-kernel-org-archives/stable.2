Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889856;
	b=EkAkcIysJmxg1INFPgZ14FO1D9cuBzI70mMTlgymFkj8ZCLbrekLg2ON2vo3TH7MpoUJ
	 uMpdBwXkrRqjkHX7xLVqN1kpma5aDSihCZO19zIx9zadQDGXMzFj4/tzQzKjtoIZSagem
	 d6Jp89aXQYtDZdOycgdHz6tfuzNGZ2hF/5ajPC5S+/UhODW6auzdbzj4rLNbshNzoHArx
	 OQ9cxYfK3m/AT8ZWiJ3ZmpLeASCGZeleXgF+QLXFlfCpjSC02QfQ1+GR7ZE0RSt7tncCO
	 6RNkKxdiGExmHp0eSRmk82vGTqsUyKEdlHyAypNljBS5GcRDIbgi+ihtt9txB+qsUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t2j0aQBx9+Vi2dAOpjUpf8pTnhYHOVOwJ0xZDA5KQVg=;
	b=2eVMr3c6AlGrx/+KR1EFFLl78OgNupkYYHYqXQd6WaFiMczld7HLlhB6z2RiCMCW5aSy
	 4dEnFK5s/eUbmuUhWwtXw8OPjdkG6OjxkY6Zj4ZNI/DETECLmuHWT1HWrH/LgHHLcek3m
	 oi16S4NVr7O69RaRYapK+5cIkDgf/Fh7S7zUkRGDxW0prQv2wjW3pd0oeypAnvyE20y/C
	 wc7yE+EEjnM7IWbNOLX2aK5n+yZf6AI58C85SSIdhYBBprznoGvduMpxWDl18xRq8dmqm
	 0yuNE2IZCdv3AF+A8LCTbjSAg3OAayIFwZJMHLN5cvPL+bYyNrQFsa45mQ7JqQq8+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X4An+yaz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AF606A334;
	Thu,  5 Nov 2026 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5AF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X4An+yaz
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEWjW2060111;
	Thu, 5 Nov 2026 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t2j0aQBx9+Vi2dAOp
	jUpf8pTnhYHOVOwJ0xZDA5KQVg=; b=X4An+yazRlI3pOoh12ndIj7CmlcWtpUbm
	fMS1+nJxBH3+QlekFJXYI7WXiMnUsxQ9b+fP6gpgxukwi5rxTOJqzSox2G6JfavD
	ZH4Sf4lwM/DzQqDF86ftTLOSTs9fNC8c+ehgLF53ODLr/iXSlPwzQ0GpV3BjmbgG
	7D7Vt/h4BkjLwrC93WA2cATkL7mGuU19T5+x3kwL6/19ZdNUtZwUmGDIoqqHPcb9
	7gleWwKdAmex5R4eTXt0Z5uxe7WFmp2kiDh1SsPGiNzbxeNYjfZRqpCmQjUukWju
	d9ZrCcQ843SfqYVxiHtj5Nuw2j/zpnulm2NcZmTMHlC2OvdD5DUzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdjfas-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ0501685738;
	Thu, 5 Nov 2026 14:44:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrej3nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EhuVM25035090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:43:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347442004F;
	Thu,  5 Nov 2026 14:43:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26202004B;
	Thu,  5 Nov 2026 14:43:49 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:43:49 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 3/9] keys/trusted_keys: clear sensitive PKWM buffers
Date: Thu,  5 Nov 2026 20:13:14 +0530
Message-ID: <20261105144320.357260-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105144320.357260-1-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HkleClcCnRgp2QwXKmuGObFHLipvhqpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX3z+gUczxivz+
 I8Jn/OwJKQRCErZM8CHCqLPuQ/SkgLgMZyxJkA4xf0YgpteHo0L7HQFTAEY6ZX1c1VBibRPrSuH
 CiIY2XAGnMWbZgVqyJ2SevpLGiHueprDaPv9+uWeiTXAc7hXd3T9NHo8hCH+y4gMmjvptEdPPH/
 nc81aF2OLsIbwrWxqaOW17mf0h9RsEoOzLw3SYkIgz6r1scKfDsnfLXEukCdVNYH7eq4K/9egff
 VZiQfXRHF2fqLPXsjGRb+ME+kC6cC0CnhZqS3Pd7xE+YUd4aXWYSz6srp7Zevpe3bHlHRp1Ra7X
 mEb/I8nt+Wo9QvB43S304rWh201pZ6aQgTCZYN61vVaWcNf/d5W72HYKPgljk2i0kRiQ1DUmgKY
 v9qTQ44aWFqcKTGbP9gbqgLyLFk/hELCf+w2LL17euxOaxBYP532jXielr55Tp6eOtGn3HbD5bp
 a3zk4j4qbiwyiB0O2Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXxP/O2CvLICPK
 zUJ0D/1E+Q7T4Pis/0jemaIDX0p090YBszutEVTcNHcYxu8nZo7UQcaqKaJTbqMWcxKxSq5I1oh
 xFVslr8l61VSG8LZbCt0jrXl/vgVFbs=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec9631 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-ORIG-GUID: IFYNBTN65N6kOr7LPhtdJxwuY5l2CQWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050058

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
index 97ffec0ce1b7..be69d2b6d46b 100644
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


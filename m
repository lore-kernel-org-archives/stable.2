Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889852;
	b=RISHPyvH84CZClb05XlDzVaf+k3NLLWYAfuZ2wZbyaNH4XQKTBz8KLueN8q8avx2djqI
	 g8jRzyR83FVbYz5jZ9GUFP0/qvIRH37dqw614dbevMPAH+cwCGaQAQfj55xZvpOJr3Wib
	 0M3anpBocXCmHNC1Br1G7U+b0HU8wGbl4vrp0Pyedrmjk5sm64QZHNHv2+1GxMvSVGFiQ
	 vAqeB4gqTgU6GnucxRtFYX1mi7+ZP5TYaGdIYuWL3x8T2sdOkI4ekdBLC7p5yoNOHdCPn
	 h5dltZ5XVi0TMl3z8x8TLzkj45h4BYIdkaa8VGCnGgGdQ2GmKkdqBvAbDiQD49NJsUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889852;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2SUcQPh5aHfTs8GSLTrQaEuc4TRDtbi4xNGkbjxyYp4=;
	b=G9OTG9yKqOScxeATOYawEmcTh9601M+t4nas+7IgItANXj5YDz9I01DnFxJsj1vwRDxd
	 sy59yMqvGWlyAZQoFyarvsZ7RCZezjc46agXUZrRYlSpuXkFHcbjdrMG9fcK2kljkwVED
	 1mO7c5TC7TPXWFPmiNNcFUJ08/a1eOP+tmKXId6lgNVj9cAF+QRhe6O2zfBjxr7RaAM1D
	 5ddeADhst8vqTILZGQASQI3wMT1e5cSrv5uUC9TUGCW70VepzTFGA25M+6ZtoF+omnP/A
	 s0mgj5FYwjbkD3mMpW88/i6eV85IVYHz6083EdIxwxCv/WRN9csy6+ZAGxiuJtjpwFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eV4L3RE5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC917606A330;
	Thu,  5 Nov 2026 14:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC917606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eV4L3RE5
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE94C3449875;
	Thu, 5 Nov 2026 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2SUcQPh5aHfTs8GSL
	TrQaEuc4TRDtbi4xNGkbjxyYp4=; b=eV4L3RE5DQPo/nS8KZFIL078hSnXXK6JA
	04EeYRi/GIm42D9LSFfcywRQrj8DISUsONpcT3QKUr5mhnvvwUK/+i2MoQ9tUn2U
	qECaELfI0FRJqVPotCqMttRzcUp/GdkDQ33xFqLi2DL/uM5rwH8GGRbA3YiMm5XS
	ewOTbBrWYRNhh90OymZo0zZUJFVuVJ+mKZG0HJQUwAg+v+GnSpF2Y6rjcsIrzc5d
	finQQxidTuDsJfo9XL23YD9KssPUEzUOgUvCSVV8OsE+fkKMqOU84CfTSVwCxhko
	p6HgMsryCinpyQ2wzf3oke7YaviURdf9wUrMAkFmPv9GnhlBYKgow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3txha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYwpc595020;
	Thu, 5 Nov 2026 14:43:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5h3m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EheYD34603434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:43:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A0D020049;
	Thu,  5 Nov 2026 14:43:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C13D120040;
	Thu,  5 Nov 2026 14:43:33 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:43:33 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 1/9] keys/trusted_keys: propagate wrapping key generation errors
Date: Thu,  5 Nov 2026 20:13:12 +0530
Message-ID: <20261105144320.357260-2-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec9621 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-ORIG-GUID: aZQ6j2hHTPb7vCV3hz5l8Nh-CQokMZYI
X-Proofpoint-GUID: Tlh2Umw7WIff5V_qP4lxcj-NQ8reqX-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX1ego+E4JknT3
 kp1ymIVSZtGvBpyCV6l+WR/y61GcsgSHd/ecA2PV10orEedXFdWyxy2zdrev8Qr7kusH97aQgMr
 /OGxyftMYC6FeQauAbzxnkdpH4dowljG35l/VL7kJbgXOmzrT79i4vDFNP/t+TpAa0e5ksed7Tn
 IXft9epstN5KbkC2am0CkG4XzFlal661joPp1zlFtIAkAG/S/b+RBCoewFVZMEadZtJZqc1Qvxs
 EEA0WUngm5MaMJThv6P0pbZrhADHTiZjbXRXiwBKACTRGfcz7wj6/YtpbHdByC+QCGEIGMiUSjf
 fVEpmW3op8oL1t6L1uIoma9hYdXmp8jaW4NtItyt2LRQoGOWj2g60LSJBDhoYstg6N+JWOwddpG
 f6agFye/rdqT5NT9M5A8A0RMiG7wqBhHR2WbZ0IvNWWv3445B4LUYTfleyF/mfdMA8AJJoDABRu
 rJssfWb0yHr5El7E0UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX3RYqcxA45YNI
 feYO/6N1OG4uf70zhLigKi1LKWvgGwyfR25jFGIEObQWlBioYEacsmz7tjMiYgCIrqK5QSkTCmu
 Jzh4YyTFfl2Yns/TRAWeLSTzYCltbBQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050056

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
index bf42c6679245..422f752598e1 100644
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


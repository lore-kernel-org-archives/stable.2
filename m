Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6639A054;
	Mon,  3 Aug 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760640; cv=none; b=BEvjtrZxfIryOo5MeOxIlMWToQ/m6oYOEJALevNlcR1oEhRBfODdXPMJohiygzAqeKZ5x1hM7xDKRaMImq4xpysu5mQOPtfshmm2Rra94PheQEO6DTgVkFy4KllVONi+rw0AnTEdRDbrPZwec9toQxvQIBYy/ynpd1XnmnKn120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760640; c=relaxed/simple;
	bh=AXk1XlCtlA9643GEOk/CB/t3esbNqdAs3vBwr5+eTM0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gVKw57icjLA9TeMLD6hyIUlFvphGiOr2A7S5CO6rlia3QB+awNJMpr8kaKewsDHD22WMydg+c8LdmjkWlwUdHeRV2lx0W6vGAgk8++eJ/yxgHUm14cSQ1mUrnKXnLsJ0o5Sr4tR2qwU4SH2udTs3p/P5YQUjKnxmzR92ht+ECz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nTPQDV23; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nTPQDV23"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHXg01998962;
	Mon, 3 Aug 2026 12:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oRs+4u
	JY3vFR9o+WV/CgpALi880izHL66VWVCja728g=; b=nTPQDV230p70zB9hSIJfQ9
	G+8bacYr+ZKAbGEeDIzrnz0H3gMsfoqRjRJ0WzwJAP2Z2wN1Lll/RoEa9zUPO7pI
	qyXOHwkNzkYlBJbEUgERs+qhcyYFh5G86kyMgbVKqTnNcjuKnehzMO3DYmN1HlAt
	Xo/8PmikYmM/UbhV8dAm2W/VzCC7KvkZADqdzrbsy7nknPVtnGSjZ4pKUKTtXBon
	d90gZJCePRDnSwyH5qN5Qj8kqt78/0ULvx28A71ge/1ciPZ1RPxuw5/JZQvMn0Xi
	MWcsEMjoR7TBHfTJn8swB7XRzuzy5T6dDxafoGoMLp5U6cDJ4osSIWeGYS5U0GMA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3rre0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:36:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQK0K027432;
	Mon, 3 Aug 2026 12:36:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qdg97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:36:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CavCk19333858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:36:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E697058054;
	Mon,  3 Aug 2026 12:36:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D48C858050;
	Mon,  3 Aug 2026 12:36:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.40.229])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:36:55 +0000 (GMT)
Message-ID: <3d842f7e2523aeb0c6b70cd08490109b7568b8fb.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix out-of-bounds read in xattr_verify()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lincoln Wallace <locnnil0@gmail.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260729-fix-ima-underflow-v1-1-4ac55f7ee262@gmail.com>
References: <20260729-fix-ima-underflow-v1-1-4ac55f7ee262@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:36:55 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a708b6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=X4fbVaFwKxtK2A4i2zUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SECiIKO4YLKF1Y6ZZP-qb9gKpt6oWot1
X-Proofpoint-GUID: A2zJWKIo8Bf8tl0HfItv01Ei1q2Ip4wL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX+0tPJJ2x9D7f
 UoTvQrG/UdZaSmRl+63nhLNN8yKH3T9GJ6rkZGSpB3o3akI/qbM0vUE1PphUABWVKmRTJq61O6i
 NqKhN3J1QbDvo/A+TrpKE7ZqY+29fnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXzWdzNCUfHEAW
 PMnGZ0N18wmQJpviPYh63prUQFGA0S923tQGjbo3HsAXUlxBP7aF3CRVORObFmLrDRtu8e01SyD
 hj2s7oz8ynR69ByEpEp2kEmRStWrAaXlm1tIXkenZXRMF8d/gq+Huz3RO+XMn73NTNbp12hVcxo
 eotiGbJjL8gEjgyFKFUW3ozhGvqlNsdsOGDXwq0SJMduKKlrfDJ/yXdepqhETReAcT9ATSbK1EV
 SJ48gTLC9QzMt7UNurraDLRs0Z39pJpyampPboTx4hzUF0dyMfedQdkvudgxzf1lHmklew+4hg0
 OEiYai5yk5H32m65ITMe/r1GuasHNTT3JXY435toPN1uZJ9MbOE2USk/ZQKTRHSIqSUoJ+RmZce
 /R6zHw5dcvYLi4k0Wa3rVFxWr8QCcwLa+plKHP7bza7VgG+UqpVRLaPc5j+3X9eaYh1vmJjS8zE
 fl53qq9BUKLoYadIIPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030110

On Wed, 2026-07-29 at 23:04 -0300, Lincoln Wallace wrote:
> The digest-length check in xattr_verify() mixes int and size_t:
>=20
> 	if (xattr_len - sizeof(xattr_value->type) - hash_start >=3D
> 			iint->ima_hash->length)
>=20
> sizeof() yields size_t, so the usual arithmetic conversions promote
> the whole left-hand side to unsigned 64-bit before the subtraction
> runs. For a truncated xattr this underflows instead of going negative:
> a 1-byte IMA_XATTR_DIGEST_NG xattr (xattr_len =3D=3D 1, hash_start =3D=3D=
 1)
> turns "1 - 1 - 1" into SIZE_MAX, which is trivially >=3D ima_hash->length=
.
> The check then passes and the following memcmp() reads
> iint->ima_hash->length bytes starting past the end of the buffer
> vfs_getxattr_alloc() allocated for it.
>=20
> Nothing upstream clamps xattr_len back into a safe range first:
> ima_get_hash_algo() only special-cases xattr_len < 2 to pick a default
> algorithm, and evm_verifyxattr() returns INTEGRITY_UNKNOWN rather than
> failing when no HMAC key is loaded, so a truncated security.ima value
> reaches the length check as-is.
>=20
> Rewrite the comparison so every operand stays a signed int and no
> implicit conversion to size_t can occur.
>=20
> Fixes: 3ea7a56067e6 ("ima: provide hash algo info in the xattr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
> ---
>  security/integrity/ima/ima_appraise.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index 18d0d9154317..e39627f9c46c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -274,8 +274,12 @@ static int xattr_verify(enum ima_hooks func, struct =
ima_iint_cache *iint,
>  		} else {
>  			set_bit(IMA_DIGSIG, &iint->atomic_flags);
>  		}
> -		if (xattr_len - sizeof(xattr_value->type) - hash_start >=3D
> -				iint->ima_hash->length)
> +		/*
> +		 * Keep every operand int: sizeof() is size_t and would hide
> +		 * a signed underflow as SIZE_MAX. Do not rewrite as subtraction.
> +		 */

Thanks, Lincoln.

Just using addition would solve the underflow issue.  How about rewriting t=
he
comment like:
             =C2=A0
		/*
                 * Use addition, not subtraction: sizeof() forces unsigned =
   =20
                 * math and a short xattr_len would wrap around, bypassing =
   =20
		 * this bounds check.    =20
                 */

> +		if (xattr_len >=3D (int)sizeof(xattr_value->type) + hash_start +
> +				(int)iint->ima_hash->length)

Keeping the "(int)" here is not required, but clearer.

Thanks,

Mimi

>  			/*
>  			 * xattr length may be longer. md5 hash in previous
>  			 * version occupied 20 bytes in xattr, instead of 16
>=20
> ---
> base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
> change-id: 20260729-fix-ima-underflow-40bd249a9afa

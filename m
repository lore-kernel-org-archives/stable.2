Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776947;
	b=H8jWJjLQsIjSSqcC2tVAyxl/WAqmg8iL24b5ImvRAOjf5q/Vn2ZEgVTlbZwfi6+LVUMV
	 d5+oSl+7MQMvk+2/0E1hBF3KH74ByiaLJoKUppKHbfowbFbAG5y7JVNDqAxJxW95PladT
	 1H3HDWf1EJvlbdgth5ZDvR+tGR03ecSr9pePHRfCdP5gsCN/l2ywPCywJlW40HVQpA42N
	 Hpqjo2ml3piM9BdSHsCBTcVLOQ+f+9I7vZZtnYgMSzZsLtSSg0eRL7aN3P+VUdW7NGXpu
	 Zacc2s7xS25KIg71PMhz5+ixXvlC6lWgDSJ5sZEQ2jBTL+dIho+IUiB/IUYjfRLsuXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jxBEQa8fypwa5HeYZqPTu6RDpfTxs+7Lra3OJAsS+tQ=;
	b=r3DMlL8WMeNRwKqUrcIgYLa+YYAJuM933Ay8rH0TQ2FkP9270QYm8xKXucbHsNPz59PU
	 0mpYxOZBRIZmRN/AdD4I9ArmNtWFwxzVrhhffTRZpVbGhjev+idF0EO/+hOn0C5L1VIMu
	 d0J+UGLEXu9rlgPYGzmJmruHQJxOVJ5cNCbY3tqW4ivSUEwrB59dipkyQRPRbb++xb0Cj
	 3cnk76elw70ahhnG60d2SQEgQwaOs9qP8JU61+reIWuyAyEej9V0sYY+OHzQXSphfTO3n
	 sYDwi39ATPnHIizA9DX8N6UCpLemdn57xqZKQGjQV47OTtmBuXz85kkzVjsClGXOi2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RJvhIP+N;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CA606A31E;
	Fri, 23 Oct 2026 17:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RJvhIP+N
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoTA12413860;
	Fri, 23 Oct 2026 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jxBEQa
	8fypwa5HeYZqPTu6RDpfTxs+7Lra3OJAsS+tQ=; b=RJvhIP+N8N6xrkuSN2GbJf
	LsVAmoJOSCcXnXlFd42s2OUNDqqH9Q0LZ5w8r89WvRasi7blBliaxzyp8poPQ3oM
	aBuSdyPPy6n+Fi44KrehOYnPGx/dTLucn/43pla/i75YlnQ5Fokd5tFoDLACtnai
	oHQLxm6496zwMPsB8fM7Wt9yO+KLEM8JyBTyNghRog+blJquCGAkYA1O3Fy3inYA
	RXmUHIW61EuA49UB3ur9+QtCncEr3C9OFGFLRYMIl/F0PIa1kQFx/wZYbAgoWWbY
	pyjP7TcHyszvM0dpIzqH9/19szL0BLaRErNqgSFGnxVKTiFPM3080i1atn8ylhmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nw1e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:34:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE65tL2165766;
	Fri, 23 Oct 2026 17:34:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg25x4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:34:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHYolZ14680612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:34:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97E258056;
	Fri, 23 Oct 2026 17:34:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 571EC5803F;
	Fri, 23 Oct 2026 17:34:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.71.77])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:34:50 +0000 (GMT)
Message-ID: <fbad99bc209f1c56568d99838a4fca0ce8f63450.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] ima: discard modsig when detached data cannot
 be supplied
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20261021210145.1851396-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20261021210145.1851396-4-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:34:49 -0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXziehSlHe6sH2
 ybyuxmxmYHOTxqQiUg6RI/AXn/i90/jc9OTp+BpyNYmlgtkZp+7E+T1a6ZmuzOJm1T+ii9iuqa1
 ncNypGyF7UQ5zbujryXf/7VglaLu4tY=
X-Proofpoint-GUID: DWfy16-9hQb0J2T794sqwlGDiyN-THms
X-Proofpoint-ORIG-GUID: PFsd8diX5o5-MyYDs6h83QkJXitT9Uh4
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb9abc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=FwGPS302oaSD_WUWRGEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX1yn8HpIUJ5uY
 7mgXtZjgXQ1J/PFG2OszHvveMFTusbzvrQAtgZUUyX93ONJQtrjxjLXM/9kaeqyzqMO7l6YxVf9
 ciHO9ptG0MJhwZb/mtKJlqoCRllSUUQxKpWgC/A3GiTEi1XZ2jYEkKrDDNWPMqX3p13jeoEeSmf
 SM4/KE8o7m8hslhLLw0OobXK/CpVMXqTs8N9u1o9tOvO51DLHe1L3Cj5tZtYp5xNVefEAKzNmxd
 ZAV3j4b+IOHC9DYSJWmX3B5u8ON9QlWYQ6agrPVhzSqQQ19j7t6rYyGUWkKQ5HjzQQ+7hHnGw6w
 L80uZ0W46onY+rpmViWkNjIHoH1sMuEHX3z4Tnj5jZqssSdLD/RrSd5coIdiAhVHsGceFT8IODS
 1WhOOkOM//GlVLmqcJPm7eYyactS1DqKZ1JD/L7ZMepJzT4uIkps3T0Wxs8+lNUF6ceY00oY2sj
 Z7gbzLUfGn694TpMyMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230067

On Wed, 2026-10-21 at 21:01 +0000, J=C3=A9r=C3=A9my Jean wrote:
> ima_collect_modsig() supplies the file contents to the parsed PKCS#7
> message as detached data. If the message already contains embedded data,
> pkcs7_supply_detached_data() returns -EINVAL, but IMA ignores the error.
> ima_modsig_verify() then verifies the embedded data instead of the file
> being appraised.
>=20
> Make ima_collect_modsig() report whether the file data was supplied,
> and discard the modsig if it was not.=20
>=20
> Fixes: 15588227e086 ("ima: Collect modsig")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---

[...]
> =20
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima=
/ima_modsig.c
> index 632c746fd81e..f73d6f1b71c0 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -96,8 +96,12 @@ int ima_read_modsig(enum ima_hooks func, const void *b=
uf, loff_t buf_len,
>   * Since the modsig is part of the file contents, the hash used in its s=
ignature
>   * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
>   * calculates a separate one for signature verification.
> + *
> + * Digest export is best-effort; not all signatures expose a single dige=
st.
> + *
> + * Return: true if the file data was supplied, false otherwise.
>   */
> -void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize)
> +bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize)
>  {
>  	int rc;
> =20
> @@ -109,11 +113,13 @@ void ima_collect_modsig(struct modsig *modsig, cons=
t void *buf, loff_t size)
>  		sizeof(struct module_signature);
>  	rc =3D pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
>  	if (rc)
> -		return;
> +		return false;
> +
> +	/* Digest export failure does not preclude signature verification. */
> +	pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
> +			 &modsig->digest_size, &modsig->hash_algo);

This change isn't mentioned in the patch description.  Is it necessary to
address the bug and be backported?

Mimi

> =20
> -	/* Ask the PKCS7 code to calculate the file hash. */
> -	rc =3D pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
> -			      &modsig->digest_size, &modsig->hash_algo);
> +	return true;
>  }
> =20
>  int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integri=
ty/ima/ima_template_lib.c
> index 8a89236f926c..1be78612394a 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -478,8 +478,8 @@ int ima_eventdigest_modsig_init(struct ima_event_data=
 *event_data,
>  		if (rc)
>  			return rc;
>  		else if (hash_algo =3D=3D HASH_ALGO__LAST || cur_digestsize =3D=3D 0)
> -			/* There was some error collecting the digest. */
> -			return -EINVAL;
> +			/* Keep the ordinary measurement without an exported digest. */
> +			return 0;
>  	}
> =20
>  	return ima_eventdigest_init_common(cur_digest, cur_digestsize,

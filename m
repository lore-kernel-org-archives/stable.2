Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850321;
	b=xPfYFbB1Lg28qadYNt44J+SP8qI4jOMaxGLRGG+L0SIkMS8lD+4pF93Exo4WQQdaSoll
	 t9BE+EDbW2pkS3ZBPsK22l4wvEw38TT2P6sByoBZ44YkHfdlKi24v57YF6UDfidIYkKyK
	 8KhdH+GFOuI+jPhGJCljZvdniljFSnVXTWHvCDnb//nVCiIaTrNWZO+ZWceGY7zBmF5fc
	 Y+L+5VWKhoVnVrECwdCZEzPiDkrpTCQUEzKsUdwUCgn/GgP61DaxUi+5z2IF4psMyXN46
	 TSlggWiJtCoCCK7Ii0QL/JCBxvduX1/XVxJ2ZYIucBHMS5hSGBtzZ6nBmP8YpiHJj8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850321;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a+KpZeppcL0h3A/NiYESCTD3zYkLvfoDHcGbKEQvCZg=;
	b=UNiZY09NHtXmsLP5D3Sba8n/Q+n+ejDHuXe8TbYFaKc/0F/lkYAba6fQimToFVSuoWJt
	 ESinxr4sekAYweHXQnknAOOn8at8TryKYh+kIfHRQdiD1fk52D+Vic48tmFmoz23uaUH0
	 kdz492OKi5VOrZ3mr9yzTb+M0KS3YovXh3CvYVfkf+9g/p7TwK2HAQMSVxtwilpu337Tz
	 HbyMc4nBOwjO13upbNaImDI1J0y+/h0a9lBy74T0niSreJipz96nIRRBAtK7xEhf6P9oC
	 rWsiFa8rPMDlSgbCixLxjZkV96Vy3H+1ctLBX5BwdWbN7nApZ42MSASFw5ra5Ksszkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PHilDGng;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D650606A323;
	Mon, 16 Nov 2026 17:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D650606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PHilDGng
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQBKB3773693;
	Mon, 16 Nov 2026 17:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a+KpZe
	ppcL0h3A/NiYESCTD3zYkLvfoDHcGbKEQvCZg=; b=PHilDGnghmv8mW1BkhBjxL
	Y40eFFoXnu7kdAUQFEr7V1r0E997s0UPLQuBHMqSHvfHgbLF1nGwURZyUmXVAS79
	Pb1wkrAQ2uTq2gcOuK0ez/DJv4QCTg1JShOu8qpL6D34f7NqeVS36+R7txGvsXMq
	kcrm/yHoq6VYngUTNUiAdP6ML7JIKK+XiYq3dg0iBd9bP8ZwihopBZsmilJiAyRS
	Qn/PF5DpRDF+Sr6M3BveBUa+yWc9sAYWJ0oSl5MOb4HwYXtYAs5p5/EZvrPzwgRD
	gDmM2k7OwnbWLs+TOsPtPLsrT6dLHucQOeFxLDjIFxwrljCaRXu1RMDiWC5azdBQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9ve6dk-575
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:30:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFBo6xq781221;
	Sun, 15 Nov 2026 12:17:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2yjgc7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 12:17:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AFCHkFj22151770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Nov 2026 12:17:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64B9058053;
	Sun, 15 Nov 2026 12:17:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 115EB58043;
	Sun, 15 Nov 2026 12:17:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.95.218])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Nov 2026 12:17:44 +0000 (GMT)
Message-ID: <93cd2ed8c7b004898084742f28622d977f026b70.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] ima: clear kexec state when replacing file image
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin
 <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Roberto
 Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:17:44 -0500
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
X-Proofpoint-GUID: AA8kf3Ywixs2hpOKyns0HrNznCdx5sw5
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb3dad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=j6353hJr_xf9VQ38shYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX4iCfsz5fwoDm
 D0udGNqsSjOH11XRhnoyxUj7ogAXgm8g3cJ73mtre5O4hm6tofDRX6tLkD+0SFDU7pM+F3lF8/w
 7oyhLssgYFc8wc5NYrLn/p8nKPzzd0rMQU5k3UtSLhoCVP3zqj5D1uwFLHKdqLlrKoLtb0LW1ss
 YvWPeAwN+cw7YhTKGqoRMEdLPfdmD7ttGX6Z1eczOUwDNLDYeT0YpKnVvRdU/TQaZhb9lD8NDJ1
 IYR8hl7/beDgugsMbjOAI15O1CubGQ7esmsPrX0NFvi6i9ChU4vHxj1Hbvgkec0L5W0O54qxakW
 5cDBZ/heGQjv6uzAPAwC5k6v5Bf4D8xnqjK173OiZRiO5IKpya0F05Vs9MpO0uCy+JuCZKwk0Gt
 VmQ0ARvHAJ0deer3bq9TvfYTBp2LnBVmF4lMo9SVFshWeTRKKitpVnXOFLtzm6jdXfyviSpHTjp
 JjV0hcQ/EgNvZtfzj/g==
X-Proofpoint-ORIG-GUID: VR-E2jzzkvwbyAeeeDKyPu_dOrjzRJZT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXwC/7sRvkiI5U
 T0baiM+IFsEvJOtCG8Kltha4V6prZvi6jnLpz7N24myVbAZZpoEG45Mykz5dV9LaRVPv7AXuGlA
 7Ms5arn4v4I7qaixvI6ZJevbUQx4IXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160069

On Thu, 2026-11-12 at 12:52 +0000, J=C3=A9r=C3=A9my Jean wrote:
> ima_kexec_buffer remains mapped to the IMA segment of the installed
> kexec_file_load image. KEXEC_FILE_UNLOAD and a successful normal
> kexec_load can replace and free that image without clearing the mapping.
> Executing a later kexec_load image can then write the measurement list
> into the freed pages. The new image has an IMA segment size of zero, but
> size does not establish ownership of the mapping.
>=20
> Record the image whose segment is mapped and verify it before the
> execute-time update. Clear the mapping and scratch state under kexec_lock
> when a normal image is removed without another file image taking its
> place.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  include/linux/ima.h                |  1 +
>  kernel/kexec.c                     | 11 +++++++++++
>  kernel/kexec_file.c                |  7 ++++++-
>  security/integrity/ima/ima_kexec.c | 24 ++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 8e08baf16c2f..d61b7b7756b7 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -34,6 +34,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  extern void ima_kexec_post_load(struct kimage *image);
> +void ima_kexec_cleanup(void);
>  #else
>  static inline void ima_kexec_post_load(struct kimage *image) {}
>  #endif

Could ima_kexec_cleanup() get a stub, next to the ima_add_kexec_buffer() st=
ub in
the !CONFIG_IMA_KEXEC block at the bottom of ima.h? That would also cover
CONFIG_IMA=3Dn, and the callers in kexec.c and kexec_file.c wouldn't need t=
he
#ifdefs.

thanks,

Mimi

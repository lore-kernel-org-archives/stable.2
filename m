Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603090;
	b=eZvYJ/miGRob48p5tiLIMPgHDh8tx3Aa2DfUoFWuvBdviiz4ARzYOpAOEU1BbC1oDS4S
	 0PMGA8+78141nRpMS07YFq3NQLCwnZjmZRH4zyry7C8JAsyqMYpz95LWXswJp1VYVeSwL
	 NxdHeZBZ6O3DUF29fThwMB/RPkwtG/aq9I8CjBvL4qvzM35QiIqdFqlT2md5PCiA/X0+x
	 1YoBFmjQzGniAiJFkQBX9bV2VK0KCQKcuR8pROsomNbNW4QJDbDcDdsZqmQddU45aTnWX
	 XFeVN2zO/dNbtfrjxYgYlIT3G97h7ydMwjns0TSscjWxZJzYy1ug3LfNhp3AmycyEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ab23gmCX2jOyopS7KLgxDJI2CS5NhNqBnf6RTc5E4fw=;
	b=aB1vcSvBXgqSnfXfeKAmgIP0oZBijoiGOXY2RCioWMlYrjE++maPvey61UNuiQh0+6Tv
	 YGBQ4NyO4XF8//Xf7mJi/SLSKEzKnRNm8dFXpUoX6TQS4qDzC4u0C7sRkmgqXsOP8olWh
	 7fstbffv6mYFQgjLlaaa8KFCc4yiF71029JdnmS7o813+x0w7wG4LZUKHmPzVQwzb9VJF
	 zzSgq3F2hnS2l3Ifv8GiwBy8ZcLPAwEB15dakaJu011iyvGCxu6Iex7ikjZZVaEEU8wIt
	 2KBSJit/rYWifpVVdn6hlVHbbu7Rx9Lavgxs6XNTUVhpXyqJZ11Se8dcQ6zdgkm5aqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kVqre+EZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FC606A883;
	Fri, 13 Nov 2026 20:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50FC606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kVqre+EZ
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIvFC82292184;
	Fri, 13 Nov 2026 20:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ab23gm
	CX2jOyopS7KLgxDJI2CS5NhNqBnf6RTc5E4fw=; b=kVqre+EZGbILyjAARpky8n
	9KJzA0T8JwrDxgL7j7Ehd0ND8+zkdtNQd5sVoy3C6NZATz3YzJOlUcT8mFy9NgA7
	rLiob48Kd/6xGbIbb1cUTf1SWHnb8MqdDgxNOCgK4KqLrFvVGkUrtNI99bOouWwm
	uwkzo2CKhvbcYIeUmtr8p5Igap9vGn1JFhR5nXqvX1Q5m+kfh62nObMhdFreoFKV
	WPso7leGyFpfxlMezyFRUK4gqyhf06N2CtUz2ifWKcOTVB3F0A5w8YmqUUHusfBU
	puoqTOdpoILD6tCaDaJCtIJHZf0RcJfoRjnsO298+xX4dLYWyexxZFFuD18TgX2A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntnrp7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 20:50:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADJ52Ws2830271;
	Fri, 13 Nov 2026 20:50:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0te0k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 20:50:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADKoK0n25952834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 20:50:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C07B58055;
	Fri, 13 Nov 2026 20:50:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53CA5804E;
	Fri, 13 Nov 2026 20:50:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.174])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 20:50:18 +0000 (GMT)
Message-ID: <0225c3dbe0f73652994374660500973512203182.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] ima: keep kexec dump state tied to installed
 image
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
In-Reply-To: <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:50:18 -0500
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4MSBTYWx0ZWRfX8WbvkQga/2l2
 cLkruBDGzRlLiWFBwoCd5qvDtr3poOSlHYnCUZRtW/UODWTwvYJav2eMzoeiL55LseagzzHQwmN
 ouOBiupllJbQxcgrbV3pWmENeHOay4qAojUzyGJic32RAQbOlEuz52hw7dFs2vLBYWwDD5t+dc4
 3gZxGdDERa55KlxKTODBr4tSIH24eFLQboycGYYBJORscQktndsaEZPUfjM/IyPDhc0ShQpkug3
 p6TstV3zhmeV11/6KvF5deIBR+Rd2YJjEL5u4Rky8jRGBC3sS3cpGxtALnuy8ZAZ4RM7Gii7usw
 vF7mBjwuZcfTDCI7OKFpJHVgMrhhv+xdzDEgpCGQut1kbCrNIn/jbXMgp8m5FQn2G1yNc8dyT7t
 BjVHsVJPAQ+udpWyR9pHhxd1hGHCQw5HNOXxEg/IAtvo/Yc+EoO/YnqvoVG/MGOmbWGtGVWq0fc
 hGxnlgmx0KIrGkGjbyg==
X-Proofpoint-ORIG-GUID: NLoUN-Wj5mEwJ2D7Y2HAV6ofnjhrOBS1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4MSBTYWx0ZWRfX4I02K66mSj8y
 9/+wMKGKDNGJpDTtgpfOVDhZquEPv2BK3+Z/3Wdirjxa+79ELmZv43LTAwOHkLNV0l62RxRPLlv
 edjAlQztWjL+nvb86QKzpwbvOVdUNAE=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af7780f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=YQ5yl0S3xsvPwjc2iwwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: edZdwUNg5sz7B7bLE53BPf8m9G9KJhvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130081

On Thu, 2026-11-12 at 12:52 +0000, J=C3=A9r=C3=A9my Jean wrote:
[...]

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 0d845693a1f7..3aa8b1096f81 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -35,7 +35,8 @@ static void ima_free_kexec_file_buf(struct seq_file *sf=
)
>  	sf->count =3D 0;
>  }
> =20
> -void ima_measure_kexec_event(const char *event_name)
> +static void ima_measure_kexec_event_size(const char *event_name,
> +					 size_t segment_size)
>  {
>  	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>  	size_t buf_size =3D 0;
> @@ -48,35 +49,26 @@ void ima_measure_kexec_event(const char *event_name)
>  	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>  		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
>  		      "ima_runtime_measurements_count=3D%ld;",
> -		      kexec_segment_size, buf_size, len);
> +		      segment_size, buf_size, len);
> =20
>  	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, =
false, NULL, 0);
>  }
> =20
> -static int ima_alloc_kexec_file_buf(size_t segment_size)
> +void ima_measure_kexec_event(const char *event_name)
>  {
> -	/*
> -	 * kexec 'load' may be called multiple times.
> -	 * Free and realloc the buffer only if the segment_size is
> -	 * changed from the previous kexec 'load' call.
> -	 */
> -	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size)
> -		goto out;
> +	ima_measure_kexec_event_size(event_name, kexec_segment_size);
> +}
> =20
> -	ima_free_kexec_file_buf(&ima_kexec_file);
> +static int ima_alloc_kexec_file_buf(struct kimage *image, size_t segment=
_size)
> +{
> +	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size)
> +		return 0;

Please don't drop the comment. The crux of the problem is that a kexec
load may fail, so the installed image's state shouldn't change until
the new image is installed.

To keep this patch as small as possible, could the event-size change be
a separate patch, applied after this one? That would make the overflow
fix easier to review and backport.

Suggested comment:

 * kexec 'load' may be called multiple times, and a load may fail.
 * ima_kexec_file.size is the segment size of the installed image and
 * is only set in ima_kexec_post_load(). Reuse the installed buffer if
 * the segment_size is unchanged, otherwise stage a new one on the image.

Mimi

> =20
>  	/* segment size can't change between kexec load and execute */
> -	ima_kexec_file.buf =3D vmalloc(segment_size);
> -	if (!ima_kexec_file.buf)
> +	image->ima_buffer =3D vmalloc(segment_size);
> +	if (!image->ima_buffer)
>  		return -ENOMEM;
> =20
> -	ima_kexec_file.size =3D segment_size;
> -
> -out:
> -	ima_kexec_file.read_pos =3D 0;
> -	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved spac=
e */
> -	ima_measure_kexec_event("kexec_load");
> -
>  	return 0;
>  }
> =20

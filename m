Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618452;
	b=rMUw7zJO423saQDDXc03iFxc1V4TvfQfiP/8PV9Pxvo0C/6VhlUjj1NNgmtNetikA5R8
	 y7e4iQRr68W5LYo5IDX/FN2Ct1xXa74NNQycA3/rKeRl8dhEAkTMpLFaTIUeN01dpvBLz
	 dMW/Atlhg6eTNW/0DHlbJosgMaJU1Q5u1OvnFHGr6/feQSdPHItvgx+EaIDNtkLFcxy1y
	 h+YpNLoqyw8Hf4m8eNLoWLVJ5B4eCJ+7C2qPnsl2nlfSQAAtk50/+83Vgy2i3ipBz15PM
	 9GsDkS2RaV5VGs0efuMxlX11n++gJthGcwltS07CfvnfKZ6ZeVPdJyNNhYBxn3JQduw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=C4RSG9f35lqL5fM1GInH2G1/IqD5FC34BaiDTKAoE9A=;
	b=XyjW+6KfGsG23/iDEjlpWpB4CYehvS+FoAR0WYmcQqCXwSqN2E9gzVa1ree5UanI72Ay
	 +WkuYyMQPtJqJUnJKyA81YK3wm6UldMjH3w3lviCQL69xkgHx6Ituh0WwJljsh8iYRgoo
	 mksDplASVrw2jPLzz03+JFSEnvm5bFeECfAMCxjdHH1SlbvCgormxxKLp7FOccgesmo6q
	 FyR/+nilD05rAfHJFZMAFrVhRCc9MJFrrhlrP0Sd8VUUUt4b0Imq2Qit5j+3paawvfcRH
	 bJfQX9rdK7XqqkQkGBq8Wwo1fmBVzUBJCFV0cwI5neKg42xps6gMOnr/z54L/j7Ev+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qMTcSsiF;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172C606A332;
	Mon,  2 Nov 2026 11:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C172C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qMTcSsiF
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29ECpl875948;
	Mon, 2 Nov 2026 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C4RSG9
	f35lqL5fM1GInH2G1/IqD5FC34BaiDTKAoE9A=; b=qMTcSsiFU/tFL5WJmJMMx0
	zH/15SssF/8AJbnHfM1E8sKp8X4dU5QB91P6l/TXvlhtCMseZIHcV8vgaI6KBBMf
	nUS2UGCGDRnFR0p5RIzgLEwFJTrH0LOVVp3B+691/Npc9jX0gfG9WiiD5oJGd5zs
	DU7G5duFthbz029T8mvlC5lPPYwMqhrhd7HWiFLnczym2kByu39UfssOGzI3/aEw
	eZYfvpGcC/DU9Sb4RI8QZK7Z9qV9lfiyiGPJL0uJuKI70yRerXgjzm+wfxOh1A2s
	QrFkBUfU+QVkVVQAGgTT7Hpl2uUKlDRcHYpCVR4NOivU66LFSaKzCjc6PgMpcwfQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sg476-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 11:20:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29JuSm629592;
	Mon, 2 Nov 2026 11:20:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjwg8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 11:20:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2BKTwj29950558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 11:20:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E30425804E;
	Mon,  2 Nov 2026 11:20:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7FD05803F;
	Mon,  2 Nov 2026 11:20:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.184.229])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 11:20:27 +0000 (GMT)
Message-ID: <cb3ef53e2e5c6d74051528c2b9b9c0a294d6c119.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: initialize the real inode attributes of the iint
 cache
From: Mimi Zohar <zohar@linux.ibm.com>
To: Cai Xinchen <caixinchen1@huawei.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        amir73il@gmail.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lujialin4@huawei.com
In-Reply-To: <20261102024703.816178-1-caixinchen1@huawei.com>
References: <20261102024703.816178-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 06:20:27 -0500
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
X-Proofpoint-GUID: KH8CsFX9PB1rM4kozeqM1iI3oX7AVFIV
X-Proofpoint-ORIG-GUID: 5SeCfaCAX1gMjIutApMNTbrmx0pSomE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfXxPvPXS3GgLED
 E9D75XC4M74wGrvB5nQvMYAuN83bcn7thNjHRk36J6SkoenYpOoDwcYdieC0jb1H08bhs51zj1L
 Uujs0eOYXghFa6I9zH/nsjXtRTNxbIczMVFb6ZM9zotVW2s6CLKsfpXGBpilN4HKrK1Gjn6wj8h
 5nUt1JYcP732VP9Bs2eCFwYIAO1MEzny+Hs4Gh0cTopgxwVn7st47aZnVfoAjFfgE7MIBbg3YEx
 V233EyHRBcUlSae+rMxOr6wyM0XuotS1JAUSiE6VEu/mW4NC7a9Lqlpbmz5S1x7vRaedVyLx3m2
 Ks5659BMJ5yLRN/uat112IV0BxH0BAfgacB0/4Gtkrdh1IQ9zxkMIOFeKNtzvYt/t6YtCGWKwck
 FOtHHlnZ5/8KyP7PjBMd6dKNB0hJIxxHkXTz/rN5qLVdborTNy9auXeP+17rbXhPBW4dRr6JOsD
 VCHe9Kn84CZKhQ82tSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfX7K1UwQTTvQJg
 C1cek9Yp9X6vxBrEiZ2ViS1fuy8LHBdABwlXOKGD2t+2xW2LD3XWKKo4E2Ib4lrhQyVKRf0smF8
 dgxLH7lei66K6e52mX95onapo6fVCYE=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae871ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=i0EeH86SAAAA:8
 a=fvXhu7_MmMKcmc7fLc8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020044

On Mon, 2026-11-02 at 10:47 +0800, Cai Xinchen wrote:
> ima_iint_cache objects are allocated with kmem_cache_alloc() from a
> dedicated slab whose constructor only runs once, when the slab is first
> created; the constructor does not run again when a freed object is
> reallocated.  ima_iint_init_always() resets all iint fields except
> real_inode.ino and real_inode.dev, which therefore keep the values of
> the previously freed iint.
>=20
> integrity_inode_attrs_changed() reads those fields in
> process_measurement() to detect changes to the backing file on stacked
> filesystems.  The fields are normally written by
> integrity_inode_attrs_store() from ima_collect_measurement(), but the
> IMA_HASH path sets IMA_HASHED without calling it, so on the next file
> open the stale, uninitialized ino and dev are read.  Depending on the
> residual values, IMA may skip re-evaluating a file whose backing data
> or metadata changed, or needlessly re-evaluate it.
>=20
> Initialize real_inode.ino and real_inode.dev with the identification
> of the inode the iint is being associated with at allocation time.
> On stacked filesystems the first comparison against the underlying
> real inode will then fail until ima_collect_measurement() stores the
> real inode's attributes, which is the safe, conservative direction.
>=20
> Fixes: b836c4d29f27 ("ima: detect changes to the backing overlay file")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/integrity/ima/ima_iint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index 00b249101f98..02efa8eef28e 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -59,7 +59,7 @@ static void ima_iint_init_always(struct ima_iint_cache =
*iint,
>  				 struct inode *inode)
>  {
>  	iint->ima_hash =3D NULL;
> -	iint->real_inode.version =3D 0;
> +	integrity_inode_attrs_store(&iint->real_inode, 0, inode);

Thanks, Cai.

Instead of calling integrity_inode_attrs_store(), reset the entire real_ino=
de
structure. The store sets dev and ino to the stacked inode=E2=80=99s values=
, but at
allocation time there are no valid real-inode attributes yet, so the fields
should be cleared. The patch only works because the stacked and real inodes
happen to be on different superblocks.

The Fixes: tag looks wrong. In b836c4d29f27, real_inode is an unsigned long
version and init_always() resets it fully.

thanks,

Mimi

>  	iint->flags =3D 0UL;
>  	iint->atomic_flags =3D 0UL;
>  	iint->ima_file_status =3D INTEGRITY_UNKNOWN;

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730863;
	b=DD+mi7nB6QW/DTyhpCdMIB9/CaNU467uIathMIh6PWub7oqoBWUPQ1SQPnsuBHZNq92F
	 5XPhObmGK/735hEo2EIRCLCUURh0TF5V8UuYKoa4KuIMLSPzFkOtaJQH/lp3p9p7jbTsP
	 UwG1pJXg4Z/1GMs1e1am8m8o9kkGu0YIu8JabKOLh5b7QugmWLbz3AsZSgxRY+W/bGLNM
	 iWyIZGA1M7jfvgUL12sHUWG/H9lLswPgGePHQP1zGGWECJtsVIe41Jjk6kSvNIZK/7Uz1
	 fSlCdB/Lr2Z2lFPU6lo6H9CDGqGpWCIwELQMAvZHniSySeeTXp5S2QE21au224reffg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730863;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
	b=jmzrWs3hpA3HCI7yOB4XLVC7Hz+r1NuQfxlbzksgbtG4pNTXkf68f97/vdGl1jR5gf+1
	 pziYCIOMG1fBS6mP2LFpNZbIu5BN4G4M+hkOiNIkFfjMdkQPTDLFB/fErAjFZQLCQy7/k
	 uyPSlQVDnbGuPBj6ILL89LL9u/mLGKEF/05OVX3B2aG9w0/gEX90Y1O0Ywop2IdpxuBPP
	 XXyDb+smNid3LxCsxo0iEQCr9qRUvX++zdM5tOmLe9FQTViyZRqgWVoX8OGs+XA4zZSFV
	 PAndtXf8koGHJEG9KbCb4u8pQRvr/eptdFmq61OOq1xkCFQ9BoRBF5w/tVXlDSoTZgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzHT2IwS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIq6Vzoc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21984606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21984606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzHT2IwS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIq6Vzoc
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HPbQX4123014
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 18:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=; b=WzHT2IwSgehWqDBq
	Vhz4Z5HT67p975+82qgbF5lx8OMrgUUckAAC48pzuFP6cikOxUP75dOGOMhUXWAc
	IU/ReqlodDXuPIJ42m9zDtRAVrx+4AuqiCjtVGd3mk6/lw/omR8BDRc10f+bvBhU
	A0DO++soEbUHhFft2IJVQQgudalGQJ1FE1goSxAryWq+gnrqcZoobipGe0sE/l/8
	0lOaiCimWHv3jjS/lGi86j+ih2wWBzA4EfHnNZpe5+oDdbwF3KvvE+n65bfDclnC
	8OMZxKtfbNAuXV0ERkHs6IzEASzbdZ1yKPwxy2n/lpQr38PhZYjSTrSPPgzcYrP9
	WH1cTA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9bur1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 18:34:19 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-86c3a053d9bso69441997b3.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:34:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793730859; cv=none;
        d=google.com; s=arc-20260327;
        b=Ub+A5rdtp93gy39ibRmA8EAdns3dIBx6z9Uk5fbMPq0u961gKuJHEAIBVF1xc26H3V
         UE7Dj0Jr+efMLQ0vU1zhXG7nN7O5bsfpRXtOX4nMg9g3ce7l+l2ziBmGBOaJxcMDHT9n
         IOL3OXxbeUXPD9iuXwCKSK6y9zPDnF5E4SFSa5E0MRIMjukYmQEVq4Yq+cPM5t4fPKm/
         LqwwGC9Epjk6wSnHPqtnRgyfm6oHUa6ziSLU5npWUZSJM8nUwnsoK7HrVn+Xw2Vq41nt
         2HPxc1IkCN+mCRtU65an47GGPHP23M1kQxULWCRk9q2N1fjH6X4TSQApRdVRvKsSj1Sl
         5EoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        fh=UJhJNQWoAeJ5Sqv3+inSpAGn8PPpXGsan9v09s+nCLY=;
        b=mL/1Kneuj9FQLmoTmAjJ7W+KREwTxUNXGscoJvr40d//FXe+fVXY51z8aFdvApXYpF
         TuqdeInj5h4n9xFbQoTA+b9zxUJw2uFTe1zi/h81IaLZi4GegXy0Zon9/qIjZlqEmh2r
         mPI2F79H34d5Zf6nuhbUso6WTpVr0zu0AKKhrpe041QLX3opQr2yCthMw95Je7lM4SNZ
         LdZANsReVawvJHku9GmAVlzpQEarYu59d74jnZ6De0xMPtxFVeJutESZyaLMbmUFh6mC
         RfKMpOFlEJmP7N/lD73qZN3ITLLs/s2G1JwzIcTEWauCI9XbEKSgIW8cp44KaeqJ6xJB
         XToQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793730859; x=1794335659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        b=AIq6VzocRIxKkk8ARUG7ZEUZqJyqhN8weKZpJhFifmBVUeXFdJ7PeA9cLZXPYH1tCU
         IRZ+skH5IsPMTiZWKgrWy1CNUUW/JObaCHwoHRnNBPasCaDj9lqyxbHoASmyfKdZBYRQ
         7FTxGEJ+Y9Wc5HRoodX1y3PB8A/QxrKdOznZpljaeeGZznSTKZaoExQuRafmjIG0oPq6
         w+398qVZig3+502yLaeCfQAoTh5HgvLejYpCLSFiZJ48EuFOS8geB/xxuKBi9otakpDE
         l/draJ3sLU19EEQdJAD91Vzkf05eWbtlq0ysGXaVf4Hc469x+Iz7zeNF3RpflPg636DA
         0KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730859; x=1794335659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        b=I+5SXHX8D5dPm6hHiPGMeA0Nrw9q2Uu6xha7ChcnM+yzc4bPfI9kvbXAgbQNLDk3nw
         SAxGtqb48NrD1rp0OX7O+HTYgUpmRPmDp3uoNyWroU5R2VOY7uMw2k4luHl6dCORg59O
         dECJpecB5vEJla7W2LggAMCBjIoRCKNOx/m+ejACjvUV1aGYrDyoSmCTVguivetTe+/G
         DpHw4xyZzVRbjJf2PvXQ2/4DznBlpLCuRmlIDQyls3S83SDW4IK9W5HlSE2miVINRhHE
         s6Zr3lCVI7p7klco1CvYGbjv2G0RaYsiqaLdsLW44vbiM/tYOP5s+So7nZT8NRyrDat+
         UuwA==
X-Forwarded-Encrypted: i=1; AKwUvBwHK8zhLo+4+zuNQAg+dNhvtJM2NWh8C5SP3r+2cU4CbCwxvyVWpOyFvGKSDoQosxQobJJoXf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4txln4N2CjILvJNgtr6SFpDw6+PBWQBzl1BB6X1y2IufBBXVx
	dvEYFMIO55nwBNvhrmtSQVg/1PzZHgFRYNdzYnEkmL9hP80XGiS0UNbWqN6EkHrrbg+7k9QVqtU
	Jra+dvjbSE4ETGfcYxAmrQx+TezbHaYOFK7r63d2WUKOGQ/n5ErhYumz3mQHDQQe/2l+HVzxv/9
	Rh8WEbf0w5e7JMva7dQ87iYuf9bCnZMEXqvQ==
X-Gm-Gg: AYBFou2CJhxyl+FtYT7ZFY2GhrdHWPUWj+UbnJpjEDUnngxfVmkRRwMHI2+FJhyOUZI
	64Tkmdws3xQuJYuNpAZTMV9+/m0i0/U8vLz7bzBw/JtLbSCWUn0RkEk9WLpCYx7PIqsybFsU0Fx
	apZrZEF4rBnuMJSQXmFopAZlU9mGni8JD0IL3Gc3ZVlT8n2kPZFMYfTWF8YtQvmC44qr33HGl1r
	T+cZMYfojTuBvkd8cTFAI7u5m1NEoTPyIgCWjMO
X-Received: by 2002:a05:690e:4088:b0:67b:bb72:dd09 with SMTP id 956f58d0204a3-67bbb72e7a7mr7242608d50.44.1793730859376;
        Tue, 03 Nov 2026 10:34:19 -0800 (PST)
X-Received: by 2002:a05:690e:4088:b0:67b:bb72:dd09 with SMTP id
 956f58d0204a3-67bbb72e7a7mr7242592d50.44.1793730858912; Tue, 03 Nov 2026
 10:34:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
In-Reply-To: <20261023210238.551855-1-g.osokin@auroraos.dev>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 19:34:08 +0100
X-Gm-Features: AclHuK_m9Jis2nJnxj8Yo9gCVbFV_e32G26TRERoPo0wBnnCXCaoIJVZvpoofSI
Message-ID: <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: QCXjEfOKuE6qdTQmOJloi7GF8PmDyWDS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX8W/ZXocPOk+1
 LEwkYKre1kmOiHww5Nyd7IBOIrFCP34vaV0/5oyLwfD8gE5X/TTnH0dnFcLJV4QJvmxKrCAhOAW
 d6MunlD1gScfnpDBWEA3y0iibcRE2Ws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX3pUevPcuo2tO
 tk8rq5nOFkvo62AJtcgvM3KZjYRjDL+bnDeQIak1JplSmHMs8ifcFy4afK4NYzEnr0b1XDEet6D
 6W5XEdztgGHrQXZuh8P/q9xgwqifL3cbf2C6/ccjSuTFqIxdvsq0P/q3kl01IdxYAnEciSmIjgR
 ghyCB4gE+7uzrt37Or5iULiZkbfQevWuw+ZBbtdZTr2gPVCe03lyUOH+2RX3gLFuVWy4aNG0q8m
 UeICRn0YpbJfN+5hs8LpyC7p7aH3BTc0Kwz0ws/b3X9UfLDkMgyUpESe8iNm+2CUfiV4e5UysPI
 xyaTjIIk4IHG2eoKwnX/0jEwAR4JcVqn/7ql1CCZ7+sDOaUXv+xo3s/DjIv+hadi6EvsBjaEKwb
 hFS9oc3LHvwjTXJen4O9/9Nwl4BEtbDVkCd92oMutyyj1vGgtJGQzbwKQ//pourCAPkqZPfFhoi
 BChD9uSg7kXubGzd1pA==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6aea292b cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8
 a=c0YJ09nfCN-JFu4Q_T8A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: QCXjEfOKuE6qdTQmOJloi7GF8PmDyWDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030073

Hi,

On Fri, Oct 23, 2026 at 11:03=E2=80=AFPM Georgiy Osokin <g.osokin@auroraos.=
dev> wrote:
>
> register_shm_helper() sizes shm->pages from the length passed to
> TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length above
> 2 GiB makes the array larger than the page allocator can serve in one
> block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_warn
> kernel that is a panic.
>
> The size comes from userspace and the request fails with -ENOMEM anyway,
> so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
> warns above INT_MAX as well.
>
> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
>  drivers/tee/tee_shm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 6742b35..d539988 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struct i=
ov_iter *iter, u32 flags,
>                 goto err_free_shm;
>         }
>
> -       shm->pages =3D kzalloc_objs(*shm->pages, num_pages);
> +       shm->pages =3D kzalloc_objs(*shm->pages, num_pages,
> +                                 GFP_KERNEL | __GFP_NOWARN);
>         if (!shm->pages) {
>                 ret =3D ERR_PTR(-ENOMEM);
>                 goto err_free_shm;
>
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> --
> 2.54.0
>

Looks good. Sumit, do you agree?

Cheers,
Jens

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240718;
	b=WKUIW6mq8DT8fG2AM5WOspUKurZerb3t1dbeWzFVvPDmGe3lLvqKzS3kJ2MHCzjzYprv
	 Mfqx3QwYAzkf0hRW/C2loyjzRQbap8eLYz49afDcVAniqpoRwATppTfPy6pAH/IVP2VZI
	 0SrIqpPdDTPFTR8++LBU15mvrGIuh7MgSgB57ZoNIl1247mkLOEjjAZfrpPxjbLbC7iAq
	 H8vyJzLKlOPEWo3vNbR/nLGn6Bn3/OLc2xN+ZpAK1ErFDGRt5Wj9/5NgIuonMKp+QSQcS
	 TwFjHaIhQY7NBx8xDPaYbj6xdSrZ85Ewivy9JNUoEqr1/t8jh1KWYO44RT0swqX0GiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240718;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
	b=4miJFogSFk1qBdTsSWSaUH1l/VJacHd8tXqDx3A0txGSLLpVVAx/B0RznZhbD05LkyBy
	 fP6BnTjhMdMlLEuQcvtg7u6WkHqIHc5nM70lUCXyuhblHqvnoG9JHGqawr614b5/HYWlN
	 buvvaa7fhhL1cpMzs6PFBl8DMxBXX88+BMB3bP6AotmC4pg12a8m0qWxHglJyGFWEbnaf
	 0zV+929HeKIomteuthDhvoy5R4yMAj/1MRHCPOfKzls2qpSX+VemBzZUVUX6QPevFEgvn
	 wGX1o6nM3f4hzcE9bX1WXrAhUDiuyutTMQzUsSESlzjKv7Sj5MyIOWWZm78WD4Lg2/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhGcte0Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4Xsd9jB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD3606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBD3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhGcte0Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4Xsd9jB
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEoEX1322908
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 16:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=; b=HhGcte0Qp7wY23ZN
	C0FSBCegN49thP6q7OSLdjtStxTFqCRYbpOfLt0nQecHaIkpWgy78q/+Ve8bx2OM
	AQTdrftOxVcYB4lPy3P+mzV32tcFxjJhM3XzRBKRnjoqYbjDTu+anV1zmsmxOH91
	yOq6cAWzquayj/TTFptm0THnz7ez0qJ/6tmbXGL1Z755XeHISDy8VeDN1Lj12KrU
	gYjnsfzlsuwB+BZt+h10YWFPh0Xf19aJOSnRWgHmzzynL+LpuR/NbHPYuwrdz0N3
	lZto0ang6UhDA3Nt0iR9Da3ROc3rw9VucmvHyRTcqXD16k8n1+yNuWU2xZJwQWTW
	ntpUZg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qrtum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:11:57 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b3228a3d24so16619837b3.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240716; cv=none;
        d=google.com; s=arc-20260327;
        b=ld0jNae3hf6607RrzXRvmHkd9xdhMEeJeRuU/4T6erBNtx8jcFf0eYlAOoJU6v6F/F
         XZ6jEuVob/zqKoVZVoydy/Om4Bd6uuCuz3bk/p8eFNRQQDgEq0TZWouik1qZ37sKAq7z
         yotppyCiFujFwrUSyrPODZFjEL/8L2dUkbEhtsWfmgahCTFRgxDz4CAVhJ/KxFVuUWxc
         zL1Yw8t5Xr9joCajMShvRT49MWdfBMa+mhed/NDYqcFu/rT8sZqs6vdNo7g8oECZHgTN
         Q82/sFNRzf5v+3Ng4EKeiOcBPr78nx/qp6gEN8YwI16TQW5fRNfD9N4P2JNKhUtRRR48
         rB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        fh=HKD6P5sCZxTLI0bvcsqXrCQigj4CwKGs8Hq0Rm+jnQI=;
        b=UF0MC+9Llo66yVNjBf62bpH2gUTGvpyuJsLHUnSfvBUtZVzwJIVsGj/Grdgq92wVdB
         yPbtzraTUvr261CJZVqdeqV+iwZW/VoqfiQDt03qcrDriFTMWVZGrEilWgCo68bAvX6/
         gHAgyeQOlDpIfAZ3TjkBYy5jsRkuwkb5EZ8FG8/fHqLtWWBDfJ94FQc3IXaF4Gq6Y41Q
         TuvPrINwEl16ClWToAMFuqcC2xOrF3pQTSArIfWb/6RBU7NxXCFJhOzZppVoXHbtBhYp
         BMLBAiX2Jl0lF1bI4UAoTwH9dj1dBf1FktSznJRj5D4Q0UHwP/0is5UaeHbNtZU4O6tm
         2MgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794240716; x=1794845516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        b=J4Xsd9jBIoSjY9+RyiJSFANoUvLvE8SS+7wL0fJByYClqsVbHG4VyTmr+zZvRypCBE
         yH38+RVW04/RisEAFQdKgC/ReUgsZd6mY0G3piu4Qp988w2Q5DmyGI8B8f4jyk3eLUfR
         TN28kOfwJgCec/+jpJgUODr0+yhQKToXvErmkvCcI9apm1rCg+DWoUKP/5SCqcGR+CjO
         5OsUusuvRXLCiejvmM4dIk6zaKIJ6QSo+vYQh0gcIgTvJL0xfI6wzpKsIHvk+quDezfM
         rgRDdCj28wMiE4u0Gbu0K20F4c2IEf8FZ1AdmHTlcJO6DjOE1kAfiyCb/iJjRIFRXFqE
         8Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240716; x=1794845516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        b=JMJW11tRMYFsN80NnfWcVM2I5YYeKA+oriMOZvuss0rl8+RAcOKyC4NyuS6yHym5Cm
         /UZuOPX6qnYExjzUYZ6mIJfGg56Gi0+e6dv0oOOM0P1ODuM1/eJbudpNWOl52JPJKmun
         QhiFzJFDjUQ6dLCbwD381oh2rjCjMmCA5uraFN2M0jIgwDu412r8Ni9UA1jCmYtUT77t
         YkfI/yWpSmAzr5lJQL1vS5ukcxtfEt7ulvCT//lQZ7r+ZT2OxURti1siR21NtKj0FHb4
         T6MkAxsJ/o8tMf2EoKaZ+au2acNwy/LX95cYhcFzW/RsElU44c9TyKhPXoOnlC2Y8RFK
         MKcA==
X-Forwarded-Encrypted: i=1; AL+hErGA7Xj25pSHYw9mlvx+D1sS6JHT62RRdWup2Yf2nkJ0q4BT0tU2baN+tnt/tocEo0TgcRuGd8s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JonNopYtf2pZnZrlZd/tResR8xMAh/e6vxB8tBEGg8ZKVT+rl
	pSr82mPiBszSfJldfgHsCvzMIT46O3x0azclSYMfYUsaA0xUYnGjsOyf/LyJF8OoLLajswGAZke
	N1QdlFJF7gwJI762pN6ZSmhd0Oub0mMsCLS1cXA/Zu2fcEIcgUxpC7UWG8iByKddYFEpIegIi6z
	lleyOJkKNeoYUENfP1zbreLcSO5TqtG8pElQ==
X-Gm-Gg: AYBFou0IIkxTw+c5RIbY8En6HvJaEZbgGGv3ltbXlPIO3QDVfmW05wseLBmy8G3UizM
	OiIqc6Ajkn+YWRr0zBhOsByb/IbjUE7OSTJA/tD3gy62wsE+0vEZFmZkTAeV2liPMCAgS1KkQtQ
	FRbzYalrz3/HN5Q9g/VwmLUUs77Lgl4KJfoEkg9/ancTxKFZkBw05/+nd3T4XmFAYCXgIcDvIXu
	NeQIdju4/oF7zFr5hTbVlxwmd5giQF56I1z66jW
X-Received: by 2002:a05:690c:e650:20b0:8b3:2eb4:1423 with SMTP id 00721157ae682-8b36cac2f01mr16022227b3.25.1794240716201;
        Mon, 09 Nov 2026 08:11:56 -0800 (PST)
X-Received: by 2002:a05:690c:e650:20b0:8b3:2eb4:1423 with SMTP id
 00721157ae682-8b36cac2f01mr16022077b3.25.1794240715815; Mon, 09 Nov 2026
 08:11:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260806060727.191-1-getshell@seu.edu.cn> <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
 <avFnybu7UDEdva94@sumit-xelite>
In-Reply-To: <avFnybu7UDEdva94@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:11:45 +0100
X-Gm-Features: AclHuK950jimtjNEPKF71997ib44N0__-ACIHjqESr_H4Xz7V2A2clS6kzX4824
Message-ID: <CAGgiveW_WuG9E7ZGuEEbr-bW8haUPmw+h_5PDxzPauBH+z=mBg@mail.gmail.com>
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Hongyan Xu <getshell@seu.edu.cn>, Jens Wiklander <jenswi@kernel.org>,
        Olivier Masse <olivier.masse@nxp.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfXxZT6Y7dNnchy
 6p1zjAKaA5VQJArYVgYa6srGfJadcz4IlSIx2GuvsbF0nHtDK0ovjYyK2NDY2tKiy5SyH82gbgt
 ZqcYIp7hUR4ycuuMo3oicMRZaj+gD8o5nxwJ8gPxZM35/owVxuX4DsYrY6Paa9zZILqyEjYpPKz
 gQwW7obsRDGThm8U6Uqaq9D2d0y5vv+OQ2ZdaIxQ3Bj/2tcqclmqkflAszjdETdE0aLb0+e9tIh
 zL1cIoY4XjlUKpBfSMc0fOhnBAkuDe9kDSa+JTcar7IiGU22QFoE5xG/qlc5aYuAY3g7EdtkPio
 94zHFYwj2wyWkdHmB4ikckXRMTos76+UcsRkmyRfqW4u4lVqp0lGmdYwula+Qfdy7wRzA0v175p
 EPp8USjva0vcCB/Y2Pc/lM+dIe3n8GhBbS/1zTvAtA50tcjsjbnHSTnH/vzZl3P5wOltIxHKPG5
 qhLTDLSU7xitlp0AN3Q==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1f0cd cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=y-31G8drY-iPl3fTMagA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: VeYi6ws-sCDZJWhCD988RZanxUHrsTsN
X-Proofpoint-ORIG-GUID: VeYi6ws-sCDZJWhCD988RZanxUHrsTsN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfX/yD43e5ZyOje
 vb3SAAb/gs6XJ5TAn+573UFG39P5dFdL1EMkELPbQ8CZP5J2VryWYfu8tvIOuoGhMdRd9zVGxkH
 Y2oDdZlNVPkd52yJZLh0FcPb8WZEufk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090064

On Mon, Nov 9, 2026 at 7:27=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Thu, 05 Nov 2026 at 13:56:51 +0100, Jens Wiklander wrote:
> >Hi,
> >
> >On Thu, Aug 6, 2026 at 8:07=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> =
wrote:
> >>
> >> param_from_user_memref() obtains a temporary reference to the dma-buf
> >> tee_shm wrapper by ID. If closing the shared-memory file descriptor ra=
ces
> >> with the ioctl, this temporary reference can be the wrapper's last one=
.
> >> tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the fun=
ction
> >> still reads ref->parent_shm and ref->offset afterwards.
> >>
> >> Save the parent pointer and offset before dropping the wrapper referen=
ce.
> >> The additional parent reference keeps the parent shared memory alive f=
or
> >> the parameter list as before.
> >>
> >> Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmab=
uf file descriptor")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> >> ---
> >>  drivers/tee/tee_core.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> >> index 1aac50c7c1de..489c39d5b35f 100644
> >> --- a/drivers/tee/tee_core.c
> >> +++ b/drivers/tee/tee_core.c
> >> @@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_conte=
xt *ctx,
> >>                 }
> >>
> >>                 if (shm->flags & TEE_SHM_DMA_BUF) {
> >> +                       struct tee_shm *parent_shm;
> >>                         struct tee_shm_dmabuf_ref *ref;
> >>
> >>                         ref =3D container_of(shm, struct tee_shm_dmabu=
f_ref, shm);
> >> @@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_con=
text *ctx,
> >>                                  * list instead of the shm we got with
> >>                                  * tee_shm_get_from_id() above.
> >>                                  */
> >> -                               refcount_inc(&ref->parent_shm->refcoun=
t);
> >> -                               tee_shm_put(shm);
> >> -                               shm =3D ref->parent_shm;
> >> +                               parent_shm =3D ref->parent_shm;
> >>                                 offs =3D ref->offset;
> >> +                               refcount_inc(&parent_shm->refcount);
> >> +                               tee_shm_put(shm);
> >> +                               shm =3D parent_shm;
> >>                         }
> >>                 }
> >>         } else if (ctx->cap_memref_null) {
> >> --
> >> 2.50.1.windows.1
> >>
> >
> >Looks good. Sumit, do you agree?
> >
>
> Sounds reasonable to me, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Good. I'm picking this up.

Cheers,
Jens

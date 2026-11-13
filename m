Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794539068;
	b=t6Ca0Aj5nXOYh5zbv+cnmP4eRCHglzim+pzvjJaubNop/1htNfI6JgiUI9NuCa4UcwQc
	 2HcqsKaZ1mxS8jOLZ/mBjy/M1KQCk1j8ZTCwuHYeYimoCc1aH7zxRgD9ZxO6HyaUmmo9d
	 sCGFJvgR/SrLZ9r9vs+FltjkH8ax2xVWl0Vmqn7lLYk2qvq0TLjmVLUF7BTKBGWwfkf8+
	 BynBfGT14dSnh2wrm6AC14jHuJJCQKMaLH53Rz3PBI2W34zXn5OHRXO9rC8QGiciluR4w
	 +BbhKtjs6JXpIfZkhLg/CD1gNXqcmhCHdiVk+0/hF0MFWUUomv5gOspaMQh6kY7pywg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
	b=ozfJZdcGFZCcqi3X+bboCgv/CCDUliTlNhIVczdxaca4sLFklDNFGyg24L51nCxfD+Ym
	 IKu30IpekDG39zzTTMSbLKOIxUzC7yt5Gb0iAnitGGWIgemjiKd2JYI+mjyaHJudDFwiX
	 z6y88iDXA0baiEXgbxV1j1tTEYGGBeP4wduYt/nOuYw2MztoeEc2ZHJ+aOnRYMNGUQqR2
	 fA3JHcthxMLYE4xzkRm6DrnEDyKHIYTSp42sBStV8P7lCC+z35ZhihB7XOoxqYIWVPxLV
	 9jzIsyK/DWvhLf9gDAr580VMZJt9CC5erYpGB3CRpcsmnKwo3Vf3W+X7fLEbNnkT1Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=tPsmLIyV;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=W6w7REez;
	arc=fail smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E99606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E99606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=tPsmLIyV;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=W6w7REez
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACMBhxe2981223
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=G
	mhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=; b=tPsmLIyV5N9LbrCjK
	y/kJhmKki55kqypF5HyeUTxmGjlG1VgD8yz0dhCkeGdKa8iPhEu9yykyQuEGzdDm
	yIehzkFLhFvP089BJWGo1eAhv+pyg34OeoiBP1p+rCu5EZ/WcXI09qaWmZMpFjf0
	dVE34X04y3u/shxLNrl3282uW6lm/BH+dRSHorTDsjW36ffLhx4Bp7cvxPOulusu
	3HvotgAbEKSkngRmjH3RyV+W13uDT4SyHWGaAX8bWlxbyuZZPGLZdp8/XLKzYm2t
	WU6eCrmM/GKmOsx4sdy7DhIK/INDCOim/CYzTSfIxWR3Cf0qryuxr+C/D8ETp55r
	Q+rDw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hwp1pjwq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:04:26 -0500 (EST)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375f0fd31f4so623597eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:04:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794539066; cv=none;
        d=google.com; s=arc-20260327;
        b=E+OkFo+H87Urf9qmW2X4FZcn4NblHSBvlKDKUW2h1RNm873sNHt0PZ4eZr1gltYDxm
         oS2PK1uJ8JSTy/84GJZTRgHrpilVdP8N1hTzVNBP71GVdX90Qx5HhIvre77WmdZF4+zd
         MSFAkHVAEoE87f05J35o+9kIZprVOmGKPyZizK4XkFauyim7j9g0syGTWh8w48suvHhK
         keXnl+EyIRAVjMz3a1SZ19DY6cdedmkcQ2AYcV6EjIPP9WBSaktyLCRQSrTy832uivP/
         dUrWgLRvY3Z7Xgq7YtQPfS6Q3sI5ml3iwKIi9fCBpLR/hkd1syaZFrr3n08U/OhedgBK
         1Ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        fh=/MQA8zTf5m4uvx8ZZjbWehEElmNoLkhlHt+7ynPTkbo=;
        b=CVac0f1xV3xcr67a4YR8rELkxCgfjAsR5NXAneLmE4+hEHDk/8UBgm2s65rKOEQYDJ
         X90FRfLMMHmE63X8Q+JD77uWcyoR883AUZGXpkx60y6I/3WTr+7WbeHCAtK8NZndve2t
         9VHF/yoUtNEd/xXY0okwilA4oRsIVV+oGBrJT2z2BIZBy1N3jHEPZiopYwVRASg54fqN
         Won1jug3acrSoWhUFkqjpkhwW7+0HkgyFq+JMbhtqTtiDfQVOQ7GOS4Xu6lxnQGUXv3a
         YpWFRvsNRVpxmVfiR8MOCL7ggduPzIVDxYYEqAmuGLRvT9b8Kzi+gqP1yxHZX64aYsjn
         LvCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794539066; x=1795143866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        b=W6w7REezAMGGfzxGgt7jJB9EKaKguq5qIu4pJyGnWtQ+4RrrN+W5y1rMZX/029+f0y
         2lF4DpfGdkWIp00i1JimnlBZhT+n1v0Uz3OpyiXAQ+t2hOlfGX9JqUplhSpf/At/vsBx
         IrZdY37a3++dmIdSXtTAaJ3XXoBQY0s9FhUgastDW1xWO8Tez5TQHBr8iguGrdSs3K2K
         7rQEPU0pTwy8Z8WDYj+GNvI6Z31kQfOQTYlXj7HIJNZ7Y6/TkKJK3ufTk8djDEsPwtsJ
         kUWxc2siS7T9Tvath/wowTJta3EarpXVjiEoonw209ppE92DitZGIRFzltsGHDsYh0E0
         osOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794539066; x=1795143866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        b=gdZNA+XcVDfpa0ZDPKR1RvqmDKafcbqU/lRIGzRp9CXC+CwGTLndJlGhkX4HUB+wM3
         XBMTFY4GeT168MfWmK3LN0u/ea2e+DkyPkoljChfz1jQTBGzsGWDN9znohaaWaytiSOf
         qS0uR1KFiX0AqgTqx+Crx0RrvCmsUcCFcm49818zGOO0wedhWVu9fxmxUlX9P93YjADm
         OcWkYVYHxg8oEMR8B/4ilUAyAKex+zHVj1OVvIYuU/Bha82sZ3tBkqIt7KJB6/teUt4I
         OccYjUkIoLmxgjjjilZ4ctMc3kxgKkO3mnD4HntkGtICtpqZM9uY/KQQUR24ilFdtdyA
         2J7A==
X-Forwarded-Encrypted: i=1; AL+hErEekb/MoQ0vW5Khi6gOHmQYRg/0P7TfQQi/R4vtvvD/GtQ9AIeS/ylqfTnA4XuiLu+MmBHjKts=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nOz7MoUValmhMoKWPmneQBYEXgWNHVHLWCI2e2RtCq/gB4Lx2
	38gL8SZF1Ht128D4GQ1cgVFSqM9zLHcb4GPYa+bWMoLHe7Nq9MRDWJUfV85xY3jcSWE953QTnKF
	ZUKMbDf54y/BtfQeOXo2XopZ2lDbRP91Ywy9Gvl5z1pyWQFEsq/pRxCN+/mLnvhGWntcM+dvLAv
	A8ZwiqIp50vV1L0NTMLSVcR7uHuYWlCJ7g0XiMbyNW
X-Gm-Gg: AYBFou1iSv2RwmLJLyIQfwJd8xThOIWdmaecyzcYRq0KLnGuYEzlpE6Rg3GWV1l11Xv
	S4nDU6kwKfVIjOhnq6nPOUy/Zyka/esQsQEUyaLmHNbdLePEBbD0UYaft+Hj++TMGNaQVWgsYU0
	/x49Y8EPqyiYSWhaclWKXLoYiArLKikaGy51+j2NbAYgYA6h5kstNWchOPsA==
X-Received: by 2002:a05:7300:fb17:b0:36f:6d81:3f99 with SMTP id 5a478bee46e88-3796676fd59mr975908eec.7.1794539066012;
        Thu, 12 Nov 2026 19:04:26 -0800 (PST)
X-Received: by 2002:a05:7300:fb17:b0:36f:6d81:3f99 with SMTP id
 5a478bee46e88-3796676fd59mr975887eec.7.1794539065469; Thu, 12 Nov 2026
 19:04:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111033150.847104-1-kj2864@nyu.edu> <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
In-Reply-To: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 12 Nov 2026 22:04:13 -0500
X-Gm-Features: AclHuK84zNQZL-Vn9ypJzxeh0nfI2T8c8JoATz7C6GkFQJ099lS7ynWbrj7mP8I
Message-ID: <CAPqbLS2exums5i9PX6SA37MMdRcxsOZZqnEBJuYm+HsFGtPzGQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: Use unsigned types for snapshot split counts
To: Xiubo Li <xiubli@kernel.org>
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6af67e3a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22 a=VwQbUJbxAAAA:8
 a=zb_47FFdHMeEVrkQdFIA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Aw8NOknWMwhZ2rg6AbeQYLdDZ3YD2JrR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX/0YUxizWBnnZ
 Y75w6Bchx2jgotVMwXZlvlIAX+XQUiAh87lZgfxQx39N8lUi7uKchiCjGUFXoWVBcabfD4j6qqy
 m+T4ggONi8ctDJkOc9yKfWsv7UPmOG8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX8jbhH5SgTmIT
 EORldNBqWoc7rk/LqyCSz5jddDgjynAyRGFVfeeIvdaImuVBVPioNpsVR4XpPR8+tGcqtnRJrCF
 m7PB4u2+5NjmVmGIauWnrTDpmm+TFpmaREgTswd3ZY9oVxFBEzogyxW/SRCoFWhaxqwl0McTgEN
 j1aJ6YjkzvCbcCFn+GTXvBBg5fS6y9qQ6VgsvpECBvgTm6EHtcArydO2iQwhlftJB4hreDWoQF7
 JkGbXQp7eYRpIy8qNkdEiiAOm0+3GlIpK4NJw4l3R6oV2muyaJzGzFvSlZNB05xVEv74GI/inOb
 HfhiYtk+xzFxZW8bCWeg5NvAElQqjBiEMBL6hhxy6CBfVipm5CkAWSs8hiyjmP1+eF8a50ro83L
 W+XRrj5zogtTlbzgjD6zwEq53Oj7LbGPbmIJruFsdY5EWZ5mYw1tUz+5GMRTFRDBV7bqqskXMmn
 aYEq/EAXby7q6H2DVsw==
X-Proofpoint-GUID: Aw8NOknWMwhZ2rg6AbeQYLdDZ3YD2JrR
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130011

Hi Xiubo

I've made the changes you've requested, please let me know if any
other changes are needed.

v2 has been proposed:
https://lore.kernel.org/all/20261113030257.1061200-2-kj2864@nyu.edu/

On Wed, Nov 11, 2026 at 8:31=E2=80=AFPM Xiubo Li <xiubli@kernel.org> wrote:
>
> Hi Kaho
>
> Thanks for your patch.
>
> The u32 change fixes the backwards move on 64-bit (I reproduced the
> KASAN slab-out-of-bounds with injected split counts and it is gone with
> this patch), but on 32-bit sizeof(u64) * num_split_inos is still a
> 32-bit size_t multiplication and wraps: 0xffffffe0 still moves p
> backwards, and 0x20000000 leaves p in place while the split loop then
> walks split_inos[] far past the front buffer.  Could you bound the
> counts before advancing p instead, like b3bf89767e3c does for the snap
> trace, e.g.
>
>         ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), ba=
d);
>
> for both arrays, and ceph_decode_skip_n() in the non-split branch?
> Also, please rebase onto the current testing branch.

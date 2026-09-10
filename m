Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BF388E74
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028446; cv=pass; b=Sxe+W75nIoGW8G/mEVhf1NAVkr6n0CO9K6UCKYQ/fdcsLW3dHjDncpYdcN3f/uJ8ZJHczhZCxD+Fii+cIi46CXkImIWei8d55XLfmJ/dJEmO550RkwWE/SRd8Ie5dw9IgGOsaQsDWDrvH0QXVxyFK6VCfyDs23vVNi33HUhUYuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028446; c=relaxed/simple;
	bh=WvmQjKnGuI0dGsnyCGxoMDIHpfNF476NUnQtUUHZ7Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9Qir979iYno9CL4EbE6UNPg9nmmC/8++YIQoNIiRZRny+q334bYULcl4J8l3gsUGCtOVIdDQ7COmK6MixOCZTvmovuymGMg54JbAuEEUuoPY/yFzyutDdO7MpE+6IJanFipD+y6kAJkZxyQV0gkgGF4Um6Z4grc2owIitt+BsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMVmnSIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnKDz7Xs; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMVmnSIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnKDz7Xs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A6faIh3842463
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=; b=WMVmnSIUNnQMnz+G
	E9htb2pX1Xxykkf68zC7TAYJgyqUHA1f3o5ozjQ8z7p2MSpQxex3q5ed/RPjsYEi
	1V1FpicOGtHk6bxkUR84+7y6ixvBxPCo29gDlr8JW+i5SRxPuCBok446iWdXJvRB
	mde5/iWYIa4j0QfcqhxfGSJFDptmxM9KeydmOXGnVjixZvS0bVsy/SAB0adwsoyN
	eIWPN+tjQ7fvKnHcoFy8yBM826WJfVogBgQzKfXHoLpcMazXnPgq/8xATJowU7Up
	v81UceUP+o2B3qNBVWkIVvSBh94v0Tg59/bLIQat7ZOvwyAjSAgMN/XgaXZU7w4C
	/777LA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydttrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:20:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9399b66e0e7so917404785a.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789028444; cv=none;
        d=google.com; s=arc-20260327;
        b=ABCBK/qxvmzlhoxm5OyiZlYSfyUcapn9VfQ02rPtcQWB15V0cmI0HwkT7yN0n+iifM
         W/pez2I+Vph2eVIsJYhXhhKKz/uxcZUM1AmTiLEIqEZjmCjiMFc4JSV6gRQth1UX60k+
         i2RgNGI2+xvU3HIePETuAjmsLlNBC6q2+2IY0ebJHGYLAREh7TRHcLpG7AMQsbyeMMGo
         4f6mkPHa/ZoEqzOKGCwUt4/I6t9K02OrmegABXNhyg3VjKS7zvi2f0zWhrjI7KVQclw3
         JE8HcU4hXzLQkUKis9GrPfXn9tJdIxuwgMM6w1YB01JVkTkGCB5tXfjdFBvKvL1YI+Hd
         hwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        fh=9tlQfjLB/PL4QQfu3nEZ3HJsVKSX6QcHpCByyh3SWn0=;
        b=Xt28KAM/Dpm5CQ2SNnS5pq0blH0IqK5P9b7qtRWauJ3K8+MeXa0UgUC7pktQrZlEOJ
         JDwGfZF4vx2dxjx0LhDCv1AA7NXpvebGUE0BCWjjnB2vypU2UdAtvzKgjYBqYyNLPDr2
         Q/4LVT+dr8mREVOrDT88SAQp7Hc5ohmKGFpDX8wkhweuFPdsF625w6ZgqRv1HODuAH6e
         TLyGVGah2HWDKy0SD3+8umkkvmjfYShLAIf1Uo79/5QnjgAScLsFh4eDVknpXz/IC3z9
         Dj01bEcvSujRZuXAsiUrdrLE1Siupd2wf6LkfSpFMcD88iavx57beAHsSFaXVjJJS/Yv
         lN2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789028444; x=1789633244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        b=FnKDz7XsWnpHfQoQtuFbl0A0VIepqmBwaXRxiLziQRRwGskfddSAB9MBRzJZQ9LqI3
         31eIvbWf6+hZthLm1TQvPtRvsKJNrDq7lI8tUMIDyy8mCeVX62+VVjB4ykF+bz5RmBiL
         CWTPpGcaN8BNcbvyDiuh7C3dlKN+UWARPzci1QMzFJIoYXix1VEbel+QgeuW8sEwQ5nL
         Ij5QAkYzZXtoK0M/DRMxqOeUPW08reO1lUAGdbcXf3STHIEKrqS7zGItk42FAMmm+Aio
         j5MTsIPWmqAZyO++V69gzbBleiOnn7h3MZYerlt3Pska7CGFEjFr6S8Nfc89N0PifAnL
         /T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789028444; x=1789633244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        b=LcYdVRCrO7ZLGRioEYXfUzrTJgAoX9y3P6q8AaOGEzMcAZUeTkVcRs2ghexqf9unm1
         fOsEl9crZRiEynMZ4wN84D5/RGL6RyK1g7F6YGSbbjefTfcykSQ9XbCrxCCQ47RjEtwe
         PPp3if8EqKaJ4UtH+64WCoHUs51GhBGyql0CSPxDoPzCsN64xRFK0XguF3SUz1CgBeXP
         zbRs+L8GKVE8DBy7xEoTKkyHne3jyNSKhVBxOvRLgR58ExTuzh0LVL0s12WhnLsWX4Uq
         NezCnERb33XyMaz8jHmoMvLHWZfx8j3i4lXCw7VX5W5ZiWSW+0MAWQ1qvdt2F7Qn4Hs7
         59Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxe7c6KaknEWepsRUKBEo5xRsJHNmLu9pTe7ZLqrQCeJRtOU5q/1/U2/HHtwo2CUBPfarLv5A8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6YNzl3D0LCMlBV3XC/S2YHSPoWiEBK94kpd4gt5gFRGrR5ckt
	Vn5jzHgI3vEn/WL7U1UiCf+MFM/Xoa80/OnPPqEED7Jj3gVttWJLzuqX3VakWqpDmTdHOO1Cb6d
	ZrkOUOgrF07zv6e0SbtvUunqgsjA2SI112tfKiAjQl7YVRdOtE06tY+a8xkHOdgTMNoyRI7hqJe
	ZhW38Cf/8BWuLwx0ZBoKiIIkk85E1lilcHLg==
X-Gm-Gg: AYBFou35gmZWTtZ3oDw6F1qO+Ab/hoRPr0k3u1iNsudc9B3b3drG+DS+SP2ofMe5s47
	yfrkPuyEx4I7hlT3rsiSxPkH8/uswulRTrLDD+kyokqypVNvC4952XglEkTL2z7FogIjKKXXkub
	vDByqOZaHNUV/9M+dzrPqGp5wUEpZ5APT0FS7RazoKfmFRCRGjtd6rNOm1xuFZFGVWEtMgXzcwB
	bp5/JeEHIvO6J0wIJtFPyHr+SIDTwKAlt0eQYZ8FvZx6wwDT9QAYoCHwmQHmntZDjoi8r7WvYJW
X-Received: by 2002:a05:620a:4389:b0:939:6de8:43db with SMTP id af79cd13be357-939804d76e4mr4288469385a.47.1789028443711;
        Thu, 10 Sep 2026 01:20:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4389:b0:939:6de8:43db with SMTP id
 af79cd13be357-939804d76e4mr4288463985a.47.1789028443258; Thu, 10 Sep 2026
 01:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
In-Reply-To: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:20:31 +0200
X-Gm-Features: AcwNN1UxpGXbZOkTtYTEFpfk69pJe6c5Zo9ztfNY-JIQ24mBlchhctEeZIV-neA
Message-ID: <CAFEp6-3QOiY27ViJKtSbXZs4fBDQ7pVr3T0V4Q7ERnmUw0jjOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa2685c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=bSoUDPcfU04rEmEJkLgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-GUID: 2kiV4KgIrx69RMSan4pjbIeVPNWaufUc
X-Proofpoint-ORIG-GUID: 2kiV4KgIrx69RMSan4pjbIeVPNWaufUc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5MiBTYWx0ZWRfXyCUKQzR9pbsL
 2e+VQnTmTFSbZ7J77+CXwnmZXOFqtfolKeMH4564D53tJDnwddvHpgRbxN1OMhlmEXccQ2UwSCU
 ZzAv1pf71yeWdj8r9I3z2kcm7hAHuKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5MiBTYWx0ZWRfXytkuin2HvqEW
 /F7PTx/Im4C5OdhPpc93QVyXWGEdwvijlN6ePHL7NgY9w8hLhjQZjY7uJlMcu2mN1PhauwQjSji
 yWBaDrY0f9pDFs+tTfGeM702x+fV5pO7e4Lpw7ILA0gpGkdcnGuzBkWo1MEpcsyP8LMvh3YKgPT
 +SBMcjUdeu90f4L5EZ0BF33AAh33IZrD3Qgxz6NMLpAVze6s8s2sPAxsfnoP1MiH7y0J3Fkvrjh
 ERRATmh0uYKB+yY+GtrHzmSUsDbNF0Fl1wAcNZ1WZF7EeQmcwZlsIiEAY90wF8PDy5fJJOQRK1z
 aHAlcAC+FZ7a2682K95DEze1RD1gE5yNNU8FCIq4AvovX5eIsxz3Eux85zF2+59nIa8zO2qVpFq
 dP0t9zJXa6E+ZN8wQeHjTdvS/RsReDjncwfHKpPbj9jc4k+M+z4E4KquyB2RCPbKLKaf2mMNUqu
 TcrebRowi3IEkkFSeTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100092

On Thu, Sep 10, 2026 at 5:34=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> =
wrote:
>
> The NDP traversal in mhi_mbim_rx() only stops when wNextNdpIndex is
> zero.  Nothing requires the offsets to advance, so a modem that
> points an NDP at itself, or at an earlier NDP, keeps the loop
> spinning forever on one CPU.
>
> Break out when the next NDP offset is not larger than the current
> one.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>
> Verified in a QEMU guest with a fault injector feeding the driver's
> receive callback an NTB whose single NDP points at itself: the
> unpatched driver spins in mhi_mbim_rx() with one CPU pinned at 100%
> and the thread never returns.  With this check the loop terminates
> within one iteration.
>  drivers/net/wwan/mhi_wwan_mbim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index a94998712..ef158edeb 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -254,6 +254,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, =
struct usb_cdc_ncm_ndp16 *n
>  static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *s=
kb)
>  {
>         int ndpoffset;
> +       int last_ndpoffset =3D 0;
>
>         /* Check NTB header and retrieve first NDP offset */
>         ndpoffset =3D mbim_rx_verify_nth16(mbim, skb);
> @@ -265,6 +266,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbi=
m, struct sk_buff *skb)
>         /* Process each NDP */
>         while (1) {
>                 struct usb_cdc_ncm_ndp16 ndp16;
> +
> +               if (ndpoffset <=3D last_ndpoffset) {
> +                       net_err_ratelimited("mbim: non-increasing NDP off=
set (%u)\n",
> +                                           ndpoffset);
> +                       break;
> +               }
> +               last_ndpoffset =3D ndpoffset;

It would be better to address this under the next_ndp retrieval, something =
like:
```
n =3D (int)le16_to_cpu(ndp16.wNextNdpIndex);
if (n > ndpoffset)
   ndpoffset =3D n;
else
  break;
```

>                 struct usb_cdc_ncm_dpe16 dpe16;
>                 struct mhi_mbim_link *link;
>                 int nframes, n, dpeoffset;
> --
> 2.43.0
>

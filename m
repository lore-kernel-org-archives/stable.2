Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB5371860
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027771; cv=pass; b=Czu2VvVjSRdjL3ioH5LhWMMF4+iOOpKkIzYyxfopfER2x5uYwSQwGH+I7j0HvOVwT8leq6EreD/IKw1Q74cRhgjiuWLzbwimRUmFSrbvraBsBqKpIvZKHampu2yLwUzP87j/TZ/HXMlIJhL8uWJt++bV3VXQDVoRO7g9pxjq1P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027771; c=relaxed/simple;
	bh=e+oi/7PVMHZr0yXmqHSvM8XmVBC199Drw87zijqnF1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ytm+XdU1o+y4Vu/vtDyWG82KZ/IORiVsqGGdn7/ci1o42EzD4/7XGIpGaIY2WAncDDERik4uiq9r42jZ1QArwW6xEpne+zeb/AgcyQuUkEbjBk7v87HCxfFx5Jo414L2td7YBG+CtXBNfDgvDFpcomwUEm/IA1qOH1IGktBvgqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnuYhC7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KESZCpMu; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnuYhC7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KESZCpMu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A71EAU754379
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=; b=QnuYhC7AcE37eJFg
	jvAa9uaIU5U5Vs4O6u1T7WQMvGVxhQsbjnkHsXUFISkoJMLC5f+sQfw8A5uU2W7U
	nYyQVgD+GkbYAmEfVYYk0et3A55xXWVCtKpfQakPJLQRKQ9OrtzvYgC6wYUYTX5I
	Oc9jLRnSOC6K2U0a9W+WBkNmNQx9GTRrq4A95VYU+WNf6f+jTMjQbawatgqTcC2x
	A7IseivJpEmmEs1rLyQtIzkn7sLN8MDA/flWavDKujiDiC4nXmUpa4cZVGFVwwf+
	5P8UkxxANiFRCwWuGFinpIMJSJuAq7M3g3gcXm5IhfYINEX/qKz6iS5uAvzs4tOO
	GQ7vYg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkqsvr8gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:09:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939694871aaso1121483285a.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789027768; cv=none;
        d=google.com; s=arc-20260327;
        b=OaQvrSj5dZ6OR0RRSj0LVykaIyooaVj50rCnEy8Jlbbd/SvHO6zqU01Z44zGF6EETI
         2nblMdu3wqbg2LJ749EKH4tqwffLMSE79QixzAny6vboktvOqhtLkYzDI2/xx+FK5qaA
         Gud38sqfb3pbk/mDXRkDv/35dd9cNHQNfg32dZBaDlny9qLaYm9g7ORTlh8IZc0Jw3Qu
         qtJkXAXYjLduhswOnQCl79XVQ5RMcwUKMfwKLL66k9NJjSqflyhxrrAE5VbICuNLdlOf
         /0b63O/LxiB9A12rRw5mnpv46kqwlQCelwJe44iFei3tw3ebpvuq6ABMlMWkQGu0CNRk
         bv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        fh=KxwwnaeSn89e7ez7a6QhrMVUY55FByb9lketddRiW88=;
        b=O9UpJPiAwNiBwtszOfp09a4x568HAQQ1KlApE0gCEdz6X5NYqpOb2fHAM/M7PLTjCT
         ioO9UyzXJUr66o8J+Avd311G6SnAP7rfbfbj3AsWzJneVYi0sD/4of/3MSJsnSCdkmRm
         cRqqDYdXVD0LZunohNpNFAbx1nWqYhPKb81gnhRwGLo6l8HC9GO/VEtlE/or7cpaybqb
         jm+xCZs5NgJgtbw6JERrfWkobFDNTTNOKX3VZP/08difKTMBXw2Pe7WvQUILVwdyZeWn
         CYVSVVEDRopdnbZ7tHKUda/KxFjCbakRCjzmMzflNKAmI/77GQ4p3Ym2WVVGRRc1CBI7
         tWPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789027768; x=1789632568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        b=KESZCpMuHpgIrSgbTFZvNukqz8adFOI6az8OxiBszlH0ZOQ4NFX1cQfk3oRvhfKaNz
         PzOTd6EfiUPR+DBh6GLJQn2YC6gWExKver97uJMPFVUis1CqTZ0qDpXNT0FS630H+Yc1
         cd0anqSz6lwZP47BqDfB4YY6LC60Q2SFkjf4R8uxaCXjoEFDgQTtRSS6O/GE6jaXzBXF
         eMyTdI+pJ6CqfF9XvywS/LWksXF5+byrFy7uW8tZ9AbRwvJrhA+7FgkS6b7SJEJFgPvt
         rlKL9of68mWy2wKChabhMcX3pXLxe/mMGhtnZVxCrL/up/PxIzfjZr4iOScjkt9PHv83
         vTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027768; x=1789632568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        b=SxHm9xpO/FYRXn7RGzBAe5gp5Bcn8y0MBkfQ+Brf/GblqOr3ZMTbODMGXtIJk8egFO
         /soUD48pVPlYzKRF/OlLaUBsd3f09ebQUZ9VMrJXBxfoSrIYuYJe1ZNcaFGmp1ySQXcb
         1Tu1xlehCjSZTmoYeKlMV6dsUyar741PkF7jL26KbLxd7w58XetUebSWupaJsbyFjE3t
         9JRqpabQLiCALjUHXx0K8I0cNLV0vSK7jWOdpCB7enl48nWGSKItkF3VDfiSSj+YPVtm
         CG04H7pZIll/Whal7Yk5jfuN2gP5DbdFmanMmDVYY8l/5uS3xR6AJPt42hBorePrJq+F
         SpxQ==
X-Forwarded-Encrypted: i=1; AKwUvBybMAICv/SscPsz792fEj2ohKL98eJj9HYLtFodgRrdOkD3SwBoBEgDAgOPiqrToltdGriLX5A=@vger.kernel.org
X-Gm-Message-State: AFuF++mFUQOfKZc2CufEjnwsnAw8sWeod2/RHUkqQY1YNti2W1jzSB5K
	EwQYI8k/tKWSk97i9QJn8Ey6Uk5rR6IW8YI1ltOikay2X2auucAaXCvt372FdZXn9YsH/GLAlok
	dqgyprXGweMNnFV/MnAJxquuwymM35RBWUa9pJX3kpW2iRRJynWUbd3tEAo+sG+Vo26J4QNBr6f
	unes0QlC2u16K4gIFuiUOcCAAiYTsD48NGGT/0zXic+YSM
X-Gm-Gg: AYBFou1bAMBCrzE5xR38DCNY+pXdGxHJUPsAbV8msSDRlLb5iNVNOGDzgDKacRzFnqn
	J9foukfR//Ff4ail3U4e29o26AZCiqIv6Qm5U8Yd3Ky66dDrk/yv8755+6Xs1Mrtr32wLn4UIQ2
	724iIOdEjd467wzOcPm8ExPkTOsNNU26EaaL3jIdOMJL86k4b4W1CqPOisT5Y/jzT7qyvFwHiKE
	dsDoA0qUCegv8YW0KbGATmeuxrU1e2q1DjC4iIJ6J28L5WIowWBMoSw9DymB5+DxMvpDE7FZQBL
X-Received: by 2002:a05:620a:8105:b0:939:6de8:43e2 with SMTP id af79cd13be357-939804cadaamr3577776485a.47.1789027768131;
        Thu, 10 Sep 2026 01:09:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8105:b0:939:6de8:43e2 with SMTP id
 af79cd13be357-939804cadaamr3577772285a.47.1789027767689; Thu, 10 Sep 2026
 01:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com> <20260910033356.1052661-2-zhugl3@xiaopeng.com>
In-Reply-To: <20260910033356.1052661-2-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:09:16 +0200
X-Gm-Features: AcwNN1Ve1L8LMjcOpqIQaJD_QJYZ6Rdp4UWA7GwnfSgFAJr5DOKNJ8SBomTQUyw
Message-ID: <CAFEp6-1VVVk94T_EoaXSW8aJzRNuWeGTo72ZQNPJePa=aAL5-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: wwan: mhi_wwan_mbim: check skb_copy_bits()
 return value
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
X-Authority-Analysis: v=2.4 cv=DdOCOftW c=1 sm=1 tr=0 ts=6aa265b8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=wIlMCVVetkfELOPdIZwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX5PihSgSrUUDm
 HCFR1spzPCypQQl53ok1vubdppuPg04icXtQAvAxiwRMuZofgonmshM1oWL0MZbZ9zXF0GDbRWM
 Uc60PGFY2i+nXh7grQH8uUO9NnghathLFh0TOainTA5vTr4a1IyEOG5ZHIS6WEhrCxfqPg5hFKf
 2PS2rx/Pc1AzG7xbOdpBn6CKLdXP8BxSz2HI4mHqYq/6eo4Ct+0OpUntGNMK6jU4m+Vy5e/ZUck
 EWh9iCYF4w9S2e7pZypkwwQJb5sS8r5xN0XG4LdoGmuHs/uTZaefYZSyy64OfTSRgojkdM4wTpu
 wxmrhS2Xj9VwXycomeLRX5LJCwDVoVWpne6TLmANtpOQ5RfkgAqftYJom/t5w8IJSSFKyuFgUq7
 /HviT6eq44/dTMQ5lYr5KwUHAzWZ/NOnArsZyP+ZxMR9HMINaykqj64HzHCEsAF4sZF2Z3NxFgr
 UJehk3U8SK5TDW7IISg==
X-Proofpoint-ORIG-GUID: rJMONesdFb079F1w5vmcQLJUlPQp5B5K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX0NkI9AgHF5Ck
 qGk9jbEBXxygSxLsqbn0E7Z4zFRn2iGjvEpb68uflfRr3L2hBOyY+2tlZogm4O0FX5nGqzckV43
 h3ZKcsf03wynDjUvA2HXCvoX1Ovo+9c=
X-Proofpoint-GUID: rJMONesdFb079F1w5vmcQLJUlPQp5B5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100089

On Thu, Sep 10, 2026 at 5:34=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> =
wrote:
>
> mhi_mbim_rx() ignores the return value of skb_copy_bits() when it
> copies each datagram out of the NTB.  The datagram offset and length
> come from the DPE, which is only checked to lie within the NTB
> itself, so a modem can point a datagram outside the received skb.
> The copy then fails and the freshly allocated skbn is passed to
> netif_rx() with its uninitialized contents still in place, leaking
> kernel heap memory into the network stack.
>
> Free the skb and account an error when the copy fails.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>
> Verified in a QEMU guest with a fault injector pointing a DPE
> outside the received NTB: the copy fails, and the unpatched driver
> hands the uninitialized skbn to the network stack (observed as
> "unknown protocol" on bytes that were never written).  With this
> check the failed datagram is dropped and counted as an rx error.
>  drivers/net/wwan/mhi_wwan_mbim.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index ef158edeb..71e700008 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -328,7 +328,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbi=
m, struct sk_buff *skb)
>                                 continue;
>
>                         skb_put(skbn, dgram_len);
> -                       skb_copy_bits(skb, dgram_offset, skbn->data, dgra=
m_len);
> +                       if (skb_copy_bits(skb, dgram_offset, skbn->data, =
dgram_len)) {
> +                               dev_kfree_skb_any(skbn);
> +                               u64_stats_update_begin(&link->rx_syncp);
> +                               u64_stats_inc(&link->rx_errors);
> +                               u64_stats_update_end(&link->rx_syncp);
> +                               continue;

We perform the same error handling in the switch cases below, so it
would be better to factor it out into a common helper or a shared
error path.

> +                       }
>
>                         switch (skbn->data[0] & 0xf0) {
>                         case 0x40:
> --
> 2.43.0
>

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DA3BF694
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142700; cv=pass; b=VY9q9uLCIoyf4QGg1IpJZqoHJQsqPmw1BXG/mTiCvlgai6VYs0DbrhHr2c9UrQO7XIZjWOrfxWQhZ+8Z0nC/zQDvOGtjRE//t8k0CQmQw89EagU0cPVgM12xjdE7uTDZFW4IAo//rx28SastNu6NKD2kcxVwK/wlxq87xmFSSFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142700; c=relaxed/simple;
	bh=hsLLWXDPYnII7EGfTlxit4Rg/kAtzSQMN5XKHVCFFWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPX6bYzmcY5o+U600LnwYNqwrZIasOolIOrploJd4S34TA84cHAeliyDDWeVet83tI68fFDeFMAXSuGZY+EWH6ohPyHzl87MDdNdhExCxb/+y/nSoy8/jGmxF6Pp9kkCxExIdCW8m78mtkUxpc8e9JQVDuwuhI2/Pl47FGe32gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aP273yfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nsv3e4Qo; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aP273yfU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nsv3e4Qo"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFY5mp1406595
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=; b=aP273yfU2S3Flrhi
	BZiiYHILPxXKY8/vnBiAKAK+cXRXFMQhgmM46XBK/rdiaRsy10aAX3iVjG9nUqbX
	aG4gB7DV5pjv0LkugjJlKOokccXdqFmCoTWSGS7/kKPMDY2/cQrvYhnCcchyY/bQ
	7tJHrIhTTDt0AjTeKZ2lWRmfo4Zmk2/Wa7cJKfxQWCAcARI6mxO5DGRLBUJxHPqD
	PvFM/TnCvAZPW3cXSffJJQvVzhmdd3r6bQJ3i6hhAZUWFPd6TXOEDoRLEjp/mmud
	kjOTk7fu6glrmEJFMiRUQGnm9TGdCaDTC/oA4Y3gcK4IqL7UWTEaaFjcsJMMPWxm
	mJ1jrg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye8gq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:38:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9158f2c4b55so737582785a.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142696; cv=none;
        d=google.com; s=arc-20240605;
        b=Pe25YE8PTberyaCiCIxHT2OnGQO1eLtpIHxUjbwgFzXSwRD+jgdwsYkx5d9savskpV
         VU7LY7LPC4chVy5gCjtFdu3HYD4IlxD3V1J88gOtLpfr2mVQz9Gcdsgg5GyzAjotck6G
         hh8pqBH0yuT7BHM36snWyVM5iZ5M0TOfvPBexAr0vgy8wrKcKncUoh3t4AqgdMGMutXL
         RGgRHMg4q5DNh8d9vpaArza6/82eHUHYjzhbCj5bEd7VRhbsHZXPfpGMGsvhJ+uVAjoU
         ODSOaFKqQ07bb/zH2GVbOvd8x0jRMpJb2Jx6eYO/y1mD0c+p5KUTN8iQwiQhduxb7tNz
         /QgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        fh=gEiE3MyIXHndmg1oXlecmftsRYDwKZmInmJL4hgY9TM=;
        b=lhaOqYq1GNmA7c3SOOo2aVOUtEsulXTbb6/UY4rqbo3XC+5rluf8iQMqyXD0iOdzkD
         086unwMg18nb1wK8dL8kzcvUqLGJLr0vtp9yAjLxfgHDAhWn92CM7DwCPYoptSDHnEQs
         8N6ATlad0rPMhwi8nE3CZJu6p9wVUc6hT1sg2r1mhjcNJKFMuFrdIlTEh346senfzjZe
         jytdwVfM4nxdWq6nUP4il0hlblh8DB+qrgpllP4QEZ9rMpXQHG78gfEaofUXg+dTTvfG
         opcuhnke505GA9ooAEcyzzuiDGNlBUAGztlzS22W8OeaT79h21lbrhbtt7EB4Hr/Zdwv
         1B8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782142696; x=1782747496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        b=Nsv3e4QoqvyzhDK3YU1mBz0Vd0LrWnK1iWYswd20S4K+FGlNq8VK5hj+Bq9JCzbEEf
         dBAie/WRQqetYvJppcFdsKglf/tuH4JG0Ves5oEo/6486pLWBTgLkVsLruNYES+6v7X2
         Ido17H+C1wINwWQOA0ZddX6LGtqMz8c20INKRYC3wIDqDWh/Xpeay+QnTwzabGjMsRSe
         7xT9F+Y5dlAFuec4z8Awf14NXxVsTo+mDgQP6FfPjK1I+1uy1wXZzgcB2jx9rAvXG/ko
         0iOvDue/wngK8oKJKXSW4SAzxlK73fVuK0MrzlGiJ3KBTaHiFtc08JtHw0u4gOZSOKrL
         NQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142696; x=1782747496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7jZDkKbepLuvBAxJzyiRImSFmJRJwj4PLgZC+NfnDM=;
        b=BomkGZgwlkzchOGZbhQbEvBRk6+SLvAoPyhmLACNu4lR/kaf+Z4h3DVzSnJfwX3vKb
         ridJKqTRxm96p7XFtKHrb9HfhUpzAnf9nYZKW1yaYSgfVUp4liqtZuP1i5X+Vr7Vxtja
         k50OAJSEYk//v5GG89fYyspwEGgq5aTIKwzbfxGZqarJuvyiqR/3zD5aZ4R+qLNI6ii7
         bMJ3XFajKXNEGbJgQlSc0rAr10ch3LhB0aP0TYN/eINPN+08foCmhXcDKQitshZBa6P0
         if689MSmXOz2FDJlMdYhpSpbZSacCZj4jMv+dt8y7YnIOK5frRRXjbxo3zNBngYnzIyr
         pUOw==
X-Forwarded-Encrypted: i=1; AFNElJ/0N1Jw0fUW00E0Gh/JSCyhKEE77nwFGPVk68czCEJ+MoFydRiqvuETjN1lb0DwFmQWQ+HT8TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwOZtBAVbW0hWMzwRqtXJyBFbGvsg6rzkbMgHteK2EzGj0xW5
	mK6CS6v/Yejmg+7cK327I/9Bp0injbN/JZDCbfSHgYgu6XObApY/2eT0ApGg5YV3g/vn6VR5iVP
	omKdS/ds34OwlNPT5Eowlq+4G1S+5YKTgdVG3726stOfQinhWiPNcRrYBXkA4/uXbxchM7NRfq2
	IPvguIodMXaznFhwRCHp6HhkyD+GxNTLlojw==
X-Gm-Gg: AfdE7cnDzBMxUhA09QC/8hmrOZHrPGW0NHpoI7NxKEVL3aIyelI4fzTb/oe1dSR0Vcn
	ykaENLRnvl0xgcqQHhezaVg+8u4DF9GNHwpPiXXNnfe2ZISjcCZj6lS0x8QkTqznNjU+s1defQT
	khEfphF3biXSfCCxtXbZVknsActncef4jy/J04Il1t1RNB0Rx1kISK0CxrrzM2e9r4pO7OI8oTb
	80EYxxKHbgYKSryq8JdRElwCdJmfduxYHJvUlG7F8Dxwu2PBmK5C+PE3USHtg3gv+7wSdGUUoZc
	mGnfQDj2gw==
X-Received: by 2002:a05:620a:46a3:b0:8cf:f1d9:ba20 with SMTP id af79cd13be357-921d0b35b15mr1561317885a.8.1782142696615;
        Mon, 22 Jun 2026 08:38:16 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:8cf:f1d9:ba20 with SMTP id
 af79cd13be357-921d0b35b15mr1561311885a.8.1782142696144; Mon, 22 Jun 2026
 08:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621031714.3605022-1-haoxiang_li2024@163.com>
In-Reply-To: <20260621031714.3605022-1-haoxiang_li2024@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 17:38:05 +0200
X-Gm-Features: AVVi8CdKM5BtyFUhGptDdvhmqBVs3rFZUOjukCIu32xzQ0rj1ie-ccUzXGrjH6w
Message-ID: <CAFEp6-1FJNOxoFUTjXWPPBQ-PC2UJst3Zz3LnnopRCg923PZSQ@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
        ricardo.martinez@linux.intel.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Uz5n-B6ceuBX5jHe8TxOZV4I3cnvemzh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfX/9UYcsgMRht0
 IwLPh7mdjVMlorumRvjQEBfbOgI72/z/7ZEVzU91U7R01Lno0jqsvM3lgGNfAEwkLbua0baHhPM
 LD2jEApG9NjRWHYJJRXHBXs9YAzBews=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfXxAArQP7JV+C5
 m6hHYTdyIVjX7RTpZV9+oBgDNUXv1mmswgzw1vgg3FoK8a3bWEmPOeAYXVdcMCPcEzxHsOdnUs7
 uKLrXEK85yNeW5oJC3Gnur6zcRJCJ5dEjqfN+Bl3MF4WulAWExGnVeaygmSeyASQYyl1nSYGyer
 926Kt7wKnShW6wWQeYn+2/LeaWmU1SGF1dyzm1fgjmfBz/s+mlbZM1Clpzeo6kFYLvpkQsuyT8I
 4NdnFQd8Sm8eVo7MkmdM8KjPklzpTfWqAtlZGkHzJDM1T5U55H1JuPfCZa9Q8FFOFc7S0N1k/xr
 F1kKLzuDx7KxxRlvgkP5s67midgh0vI/tBOBOkOJu7Mt7EqhO+vC86JWGrIHVruulg90n0ktJC7
 jCJVaxXBZ8jsdjenJ7dMZzrSJiI3xZNDiiORloQAWRD5+oJ9uadQv70CnrJyMT1JCYPRl/I7ghy
 7+ZCxbXgnzSKM6/Qvrg==
X-Proofpoint-GUID: Uz5n-B6ceuBX5jHe8TxOZV4I3cnvemzh
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3956e9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QCaUasooE-QjBHq4A6EA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220154

On Sun, Jun 21, 2026 at 5:18=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> t7xx_cldma_late_init() creates md_ctrl->gpd_dmapool before
> initializing the TX and RX rings. If any ring initialization
> fails, the error path frees the already initialized rings but
> leaves the DMA pool allocated.
>
> Destroy md_ctrl->gpd_dmapool on the late-init failure path
> to avoid leaking the DMA pool.
>
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7=
xx/t7xx_hif_cldma.c
> index e10cb4f9104e..2917cee9b802 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> @@ -1063,6 +1063,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *=
md_ctrl)
>         while (i--)
>                 t7xx_cldma_ring_free(md_ctrl, &md_ctrl->tx_ring[i], DMA_T=
O_DEVICE);
>
> +       dma_pool_destroy(md_ctrl->gpd_dmapool);
> +       md_ctrl->gpd_dmapool =3D NULL;
> +
>         return ret;
>  }
>
> --
> 2.25.1
>

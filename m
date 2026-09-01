Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C440DB45
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277574; cv=pass; b=LCFISn7ZnJKLkBNlWoEkzNuzCA97ClHMZ8uc/xHDYqTAwBKi2nLrAaIMJWxS0tek1ok56IJGgp3FQeGef3SZkcnX7PzO187kvztaFn95XO3I/OZjZpP4GF/9+qbaONN/Yn1LXBgBIqLBl84FWgSS3SVFvGy8HhvFuSsPvAKYuJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277574; c=relaxed/simple;
	bh=XLo1O6Y/6Eo3OAdKCdgs0D45eVegKXe63+OLb+kXWng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeiB5PPOTxWITjDRQ7SlQ+ry+Naw12zOungjhjb6m+IwO+jExZ8xY+giYnZy6ETCgBc+g6/KErTU2qr51QVOqxARry19+eNEeAcszaz/PLeB7KOHor6taKEIDGsxxpYbjBwYQ073i/w6MhYOwj0976NA504g1QDc8l/tOyZoALw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feYTI9+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zmalf/Cp; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feYTI9+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zmalf/Cp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8YHk3495524
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=; b=feYTI9+AXed/U2aQ
	urR4ihwgtlD6ItpFSuAQtQEVdpvW/fhqqnRBzvM8xzz9hcvZK3m3gA19/Y8/s6co
	STQk+LdhxM8bCRTz5CeG1xf4+1Bd0Osr3fH50gOkQlcSbZpzi/0FVSDyG9RFqoRU
	QUw1PuLsqUbMfpGZeJk/ZLXRdguuyBWlBZBv8zcKoazxEe8k7zD58ccU4eAl7dWl
	yHxtugvSRYVgOOAe2HecNQDneJIXfyWjML+QoJCW7tqM4OGxoiPEg5KoeZnhHu4Q
	/6rGV/R30g4y9ExEGzEwmxUS+9DNxqYesPbcPBJmpIFk1ud+YEDSKJQqXAG4FDsl
	Lp1Bzw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9ngsqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 15:46:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so7716554a12.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277570; cv=none;
        d=google.com; s=arc-20260327;
        b=RJ3kTdaNhOlaWYuXnZtNMWPa43l7p4KTA46Nacjlq0LDfIrTREe380eDudic/FNOPV
         KLAi/XUaRrYjZJq+3J0mK4ErGRQx81MhbjUgMN+pQAAlFKWm3+y5AXOY+vJLUKICtsbB
         ryxL6fIgfU3Cw06F+XCoCIthJ47R2cC1oueMQcI/wg7iuUmNgtvqHJ2725lOB8IxU7ED
         baJoMieahokWQlhlggPffsLMsGRMp/w9oIdIbeN4jsccxurUnRT+inNLCZCj5nQFiDU+
         6trxkZQSD9EL9clwjAV5tCSxxkRoYmc+VcQB29+UB12cx1Kr8QOkP+YavZ/5xBv4yJbZ
         GegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        fh=7CPWno2FeMEVkyCATNBrOCqpQvjWXkau4VVRE29lzV0=;
        b=EmMX53K1ayxOp3wgd840LQcWLxPZwUY3SdsszqqdPlpBzDXNyPSXEVbQDZkP/SqON3
         YeWo2gGdqSNAJ1XCUMQd6/uj22M7GtD3OY2v4bR3jmDQCJtJTwPo4vvDfaCzwD1eehuk
         nMykKoSaRjel76dLNNfln24Aja0Geh1Tr/Br8hz9EPseJEy/BbMYh1RCdDehvwYRJflV
         GRTtVvwsmUVkhQ+1ZNSJZ4RQrkW1UhTAt1g+Nx7BNcSAa/jJxHWwCpkM4FYKQG5Zv7tF
         xEd00N4vl3mvXZ3N3aWILJixYZNOZfANsWxJYs6a+Q819sWrEzI4HvtyW+IdOG6FKn/3
         I73A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277570; x=1788882370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        b=Zmalf/CpZqZ90n6GiN/drfFuPtW6C3zLI7PxjwV4tjDMIUGqe7t9NmsU1JSUwGkXLB
         CJEwDCKywBSB3VH0MVY92OhMmezz98siPKY6Kngj5fL6ORV/Mfq5QzuvBrbcQYeT+cgI
         pngsqpQGD5dz4+FMovzbP9SqJTdY3YdkrOShCgYpQ6UB8gEDFCgr4IfFBJJPAIgjBLWc
         JWEojhrB5WIbLIAO2uVklaSufuBNPst28xSBCeOnpSKZUd9NKYIeIz0fqLJCk5u3cJ0C
         VqFJOYuRRzFTPF1F5DN2DEQNVmp77HTDDvgAL1MJBeXvCdjGOnWLtj6N95aezmmJXVIA
         0WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277570; x=1788882370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZesAiea/HD1vlRsrFj0Au2AyHXRN8QeZN3AWkJ1tr+4=;
        b=JJMtcq40NJsyA3FBU176FXTN8eVhHQ7DOmfrP16TLrWQk2f1J1Ow0OhYtKvE0CEPGt
         LKxo7ju8p5a0WuOwDAN3Gf8WX5hcAr2jX/BGQ6J38AcPTFX4EMuAAJ92JoF+1VqKQdbA
         d9VPE7DFg28HuePHgbmcwX4cFKgGioepFb0AczejVDQmCClLYl5FAyR0kbPzhxrZdOwD
         DQbc9ehuFye4oAHsTHoPLb25wqnsfdRRkPOBFQDw1211o7bUgU5oG45GLbn3TNIBObP3
         m5OMu8mS8EmVoy5sJNEqlJxUZbVa8zjXG37rl2b52wOyHfjcfy0VlAe2ckk1RmNtQVM7
         0ppA==
X-Forwarded-Encrypted: i=1; AHgh+Rqox0ljpilk0QRaHI2IzK3c9ygEh9SSnCWH9bOUymyIk91pxz2RLL4oNo1F9xOTWs6SD6ml1Bs=@vger.kernel.org
X-Gm-Message-State: AFuF++mnniHj9DtmCtOIHrqm84bsPgiJH0Fq3UFgbRsbYiLHXEqhxL7v
	5kJwQF7LkA/CGLsDMLo+V//RfQOX1lvs2Yfyp13KfsyLXV1ktfVcQCtp4xOrLLGHfFriiuG99HB
	csg0h6i7v2uBV8oV1Gc/yzYBT/V9f4PfqHdePQ/P8le9nu3khP/wE67QlP54plF4+OSH9qYPjD6
	SwST6MCvcNv7Bkq+ubEB2erkg6OGVGA0uG3A==
X-Gm-Gg: AR+sD12MeecegxE6yTiSZCx0qhO/anjiUMsJfcQNVKZST9cAiyeuPS/3Hx39E04iJWi
	8Oj4L+7BxjUAb2TlnERrmCBXw/js76yjzNkEldZHxeeFccZkFKe+pUXCV/dSiURnxL8QTcJUjQZ
	sXGproJVsoFupPG2SFQyUp0FCgBF0hppPbIL6gRngqeId4qE8uj3I71tahVQ==
X-Received: by 2002:a05:6a20:2d24:b0:3d3:af66:9f61 with SMTP id adf61e73a8af0-3d7b0858c0dmr13796014637.27.1788277569839;
        Tue, 01 Sep 2026 08:46:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d24:b0:3d3:af66:9f61 with SMTP id
 adf61e73a8af0-3d7b0858c0dmr13795922637.27.1788277569390; Tue, 01 Sep 2026
 08:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821085222.140633-1-ansuelsmth@gmail.com>
In-Reply-To: <20260821085222.140633-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:45:57 +0200
X-Gm-Features: AcwNN1X-ZkG58Ju7YGsTebESlLv7OBivRQr4LICy-o3mSGUv_1-w5G-mpWoo6R8
Message-ID: <CAPx+jO_T3qLTYh3VORuPB7_caWXXOXy4XYfwXhT4THEjTghj4g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX+T5JcKfYb3fF
 7loFB62sbZhALXnQdZYFroVHi45k59N+1jjXz4l5xC21FuevBnhCUZzlwa6GnkzA4GSdEBAY4DX
 hs4cLw/AzPFvlbf2KIZo3ABKFhx/7q0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX0/u8yIcgt3LT
 vbRHhlKQFwRa2VQrDHrGgM4MdX6zglFlY/Vl8VaV4Tg9rurB4zFuQu+P8idixAVFcv9rAQEhfHu
 X5Gxhfo6BFzZeivviAK212PD8F5Br/frISRACcypoYuw3t5NpMx6BfnAlM6rsznRHNnLNcLriir
 jQ14wkswwhobttKxWAq2bxppLSlqVD6C+nje+bdywJ+ASYhYkKo3inz/SK1b0Sftjz7qa3P8zyo
 PryTpW/mL9TRhDWNfQgt0pDBk65o8zmDW0vvJlGymccSgbBYRLlIFN2Xl+GYRfewIIgtmBs4q9t
 IXNBDH9mCpJZd+mC9UTbRQ9phhsutiTbgU4OemuXXSclEVIEdQJGcj/YJHlerV4KZ1n0OZj4quR
 FQR2iuIkGVfynTVdHEpIN372jioYa0W7namM2heCl8Pxvd+uz+ApEVRjy0sDB/PWWBKlnEGa97z
 vh0IyuDQw2OFwCWnA0A==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a96f342 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=95gA0qMHRU8tCJvgjbwA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: UKxLfCi78_OmbEUgtkou2ayBPNoY6Xyx
X-Proofpoint-GUID: UKxLfCi78_OmbEUgtkou2ayBPNoY6Xyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010139

On Fri, Aug 21, 2026 at 10:52=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> The AIROHA_CPU_PM_DOMAIN config was wrongly guarded under the Mediatek PM
> Domains menu and was unselectable.
>
> Move it outside the menu so it's now visible and correctly selectable by
> default on Airoha SoC.
>
> Cc: stable@vger.kernel.org
> Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support"=
)
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediate=
k/Kconfig
> index 8923e6516441..a2eb704a773c 100644
> --- a/drivers/pmdomain/mediatek/Kconfig
> +++ b/drivers/pmdomain/mediatek/Kconfig
> @@ -43,9 +43,12 @@ config MTK_MFG_PM_DOMAIN
>           This driver is required for the Mali GPU to work at all on MT81=
96 and
>           MT6991.
>
> +endmenu
> +
>  config AIROHA_CPU_PM_DOMAIN
>         tristate "Airoha CPU power domain"
>         default ARCH_AIROHA
> +       depends on ARCH_AIROHA || COMPILE_TEST
>         depends on HAVE_ARM_SMCCC
>         depends on PM
>         select PM_GENERIC_DOMAINS
> @@ -54,5 +57,3 @@ config AIROHA_CPU_PM_DOMAIN
>
>           CPU frequency and power is controlled by ATF with SMC command t=
o
>           set performance states.
> -
> -endmenu
> --
> 2.53.0
>

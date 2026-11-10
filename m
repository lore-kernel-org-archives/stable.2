Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308103;
	b=x6tOAGN0Awvd98g26lwYMzRC5wm/LrSrT+CoFuk03hSt2ESK6y8SriOnCpednwEsaiSr
	 h/pbjTZ5ZlmewC1Dl0FPL04cqA4sjpkte9pqOyIAbK65lD8nluKUpWvX22o/U6tlDAIH/
	 JCQbo5cxvOBpa7cJ8Y7fIHJUWAUN15kjmbDrYu6on1xuy8TXCKrfigmq4bV1m8LYPvBUN
	 ShfqxyL/wawRjK3zEerch//8qV20W84VtaIOzAKinhBl2GuURWp6zaOotbAnpfmhu5+Rz
	 fdbRg9NJUKB+AIu5bwod13WIiiGwN0KVqtwgEwv7YqD8l/MMrxOE2/9AR7a5W/O02Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308103;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
	b=gLM7PhU5yV7vI2JKPzeUKWEuAxRVODZnneO+1elGL0mikrtw0Em0+OdNgz3p+cAPsNm9
	 JQAVvZqTt3bdBrvUoY9RTn2XM1l1Wdn26PT6udjNvPGO8rCXLlJRgk1GYQ4BVXPWrVFIk
	 6F6GsRVTg05dYVP+++rKoO2dJZKSv+avCzOAzUqAcDANJMFHE1iYOg+aHndgGOgvS0pq4
	 xkXERS6WVQTOyx4xzZkm69kGxMl9E2CTLC8Z5m8oIIwhI/kkQiML51cHZEbhftgk+tW1A
	 +AInqetCvUVtnhqzT2jlp0CpZ8jkzmPMPsWzhEC9PCkzg4TLTMXpnetjgi5XFgnjOyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1ksWaxW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sz1BlcZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F0606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43F0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1ksWaxW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sz1BlcZU
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7lGAL2240852
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=; b=f1ksWaxWVw8Rz8ld
	MqqA6xAmL1eaI6KdF6ngVxTNfe1rtXeAfa8cXSgx6t1OROxJRizyCT5xXOijzAo+
	t1vFUcTmIUNcDluxD58KWpiMHoHx/ae6W5Ifo1i1L0DXFil5/mwaBy2xBvMQcbh8
	ds+/A7dr60U4fxFL8T+0SgPIj7G2qGMqT8DYQiYO7VvVN/7apninibA6e0dBArk5
	pjbgEMufR8WBkr9hfxmbnqxaYq08dZKJ4bA+PsAQFBomORtfEyNf68lKGIByyrHl
	yNmv2RqOp/XTP9UBHJTFcwse3MP/WEC1d3ThUO6vipuukBkY8buc3KA20SJySRwA
	27wEXQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp1mpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso2449010b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308101; cv=none;
        d=google.com; s=arc-20260327;
        b=Isu+60KF2X/eImzypaz9gqGrH+S1jFEDpz8b89jnCT9hpQFM/u+JfbhnyAb/o1BXw4
         uK4JluDV6u/L1gagfv8n60cAyyXnJXmESqPJqG1/W2SLo1jss6Qnp7OQIIDQsk9Kqd8o
         Cxq5rX3h+riC6qrZ0Ggu6MUb676qp6yvbdriGkkO9w5ucHsiOxLWS6nnbpC6W7jdvYtf
         LWQlvoshJm3plb1OzitALBFHSlBfaY/HYRTkwRxagZF3moQc3MubutUKYAqyPeNNlRKD
         fP9eeQR64BAQ9S9N47HRARZwnN439HELnIwrxR6aIAU3EeJP3mERFisWfx8K28s9oxyY
         rbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        fh=LscIe1385+nH69UbBz+iGRFwqFSm1dUF5ueB6CfRwiU=;
        b=UMNQKs5Nu58mPKGBdRr36GPcPJVNiFug+/1yGcqSLc0/7UPMoADFme3xtTszU0snNy
         fSyFueLueM8UYXNvjbSyXEw8qwLI9236AXSywoBnZEa7KD28WQPU8n6ojc3xg9UmiasF
         ZeIhmh/gvfpesxk8lFQn8Jg6HmgXlBeoki3E6KgqbdSv57vBrHheuRau9ucEQnaPvn5u
         Fp5mXW0T5tI4FwyvluBpIV6m4H4PmZG2sSQrLy776/KifSMDdcY8X3i1cAOe0+0dRarn
         LHbodgAV/sUE0dVqbeUIg/l/vnlLQDGLQjp9JO2b+91yW6RYpwqsne/wojmLRKMWjwFp
         7swg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308101; x=1794912901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        b=Sz1BlcZUowedlQQ6wH2xi7CfP8kiMQSqZXVo2jjcPzN60T0rUUyA05TFnEfl18woRZ
         Da6jCCli86Ja5RA/B/DqVT3hTSByV7isarvMqNUwPtYcKADODiHilnA+9rrpnlLDTWAJ
         3+ESG+SQhR2W5fr5iaAbp6Jv/hcZGEsR0+4TO+GX60Zd3fvMGRl/V0209k4GCqMlmMmT
         Go9H2j8dRWJEPbpEZeFx9ll2LjPv73vE1F8+XKEoogXkmBzx1663xxVINtrzoCKmvVI/
         7Todg8xbPUUKr5frHf27gRrrf+Ugh7cXMjGHYl5IXNs5xsxK+gDBMlynF3MdTEG1T2sP
         mErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308101; x=1794912901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        b=K/j79fv+JP9DZhlG8AntpuUaHIA14S+o6HqBvrrX/w+fsQ8l2ymvAEDCSM0VC1xVLp
         klQPyOXc5BbSr98M1Z48YqpSTuIVToqtxAOn2S+q6Pdfkmt/e1QeDbnxDOvV2mNCjvY1
         t321hxRt9S1tfwQvb4Ia8e3qLQdeWH8tKQP6ekmee5siHa/xQIH6SfUSajHq/shEQFzf
         S/4xRlP93Hv+xPP9jqZ8OTnQvuo1IQEZZRud4SZ7RGZx2qimbAQ0MoQvSv4L120t6L6Q
         o+SjqISQmW68ZSdrQFgJotHT6pcoUEuWsoTntPEYYamUXQ5kkdZGmmBZzap7fXJJtsJK
         yaEQ==
X-Forwarded-Encrypted: i=1; AL+hErEAwBVf75WH5D0zZQikRb65oVskOSBy5Ka2RhtURsvN4XRuqgObytEJGJcyF/Z0ufSyeJncOaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yklF4Ux2+rD9DYSwPmpYSe9egQpAFaCPZD4EVNalXzz7CrYNK
	tYznRJsPhC4ZfH5Up9E9NcCzfeRqLXlDNkmi4piqC/Sw4qOjOHYQbEr7/uZOkXqBUYXhc8scQ7a
	5jD2mhot8LRZfObubjtWE87b3sC5g2Jiu44jVY3K8Icgwx6wLvGM3LMWwnKl8urJSlFXj2fqNT5
	YaVMMXiK9VVvZH+qmIotxm2SXCQVlzXBUVNQ==
X-Gm-Gg: AYBFou11PdHuKPfWG4CJqqyfN5Zim8vskP9pMP+2EyQ2sqW8+BOz2vTzlzzc4NSlhJU
	hpeIG2+6wRBy4w/KPxPGvIvqkRAHVtGIM0pk1+3lKOHE6XXaDe2gWLbcq5bxjTKff46Gmr7bCGl
	0pOAA8fLplnUlzCaEkVK8GUupkdmsm8o4EVaBWHwD+7gIQtk87rqNRqRhO3A==
X-Received: by 2002:a05:6a00:13a1:b0:8a0:1435:fda0 with SMTP id d2e1a72fcca58-8ba8aeaabd9mr2606959b3a.51.1794308101014;
        Tue, 10 Nov 2026 02:55:01 -0800 (PST)
X-Received: by 2002:a05:6a00:13a1:b0:8a0:1435:fda0 with SMTP id
 d2e1a72fcca58-8ba8aeaabd9mr2606940b3a.51.1794308100616; Tue, 10 Nov 2026
 02:55:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924142520.1594149-1-lgs201920130244@gmail.com>
In-Reply-To: <20260924142520.1594149-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:49 +0100
X-Gm-Features: AclHuK8rWqeadVtw_i39_uuIhclFTsB4ghO-HIhVp563_1PxcLFRfqznhN0nh6k
Message-ID: <CAPx+jO_EVCeOtSKSekve_w11a=nnpyq2qWAa-R__T-URjNXwbg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx: gpc: remove all initialized power domains
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>, Wentao Liang <vulab@iscas.ac.cn>,
        Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -yoQ2dgdWDWFLrRyaguVFeWna6rDD8E-
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af2f805 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Dljt1d-j0Gip_uCM0CgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX5HOQlX8NTLKm
 ZcBbXopwuw1XklvuwKIhnZnWMHR4kMj+TCyg5lT8R9L0d/uNcBT6+c+vMJORxUIHu6tB7qDCRjN
 GXv69tHskfdqC2CE8sWvrc0ckt3raYcUd08DnFq79NqEeYs3EzPBn49/Up+rle9lgQ6PGfKFbdM
 avP2cYxgdKd3ejfD+w67VAKc668YyYGHSM7LR4jiK/GrD6tT6SbSgqVaLKQgyEp0R0b5Gyk7KnP
 4zsF1RSvUMKelZDeBv1jHNWlIpXefz/VR+QWU1SGmi3iHkU0JWAId+D8jbrk0RTxD9OCpPpAGRu
 3INtmOXSKZwOMotPyXhnbWbvdVYFmp5MlTZ+75JNRsM6XF8VYVB1tUCVP6O5AIekTNNbZci3OiE
 bPsXw256tb3/Xg3LuMkIEjp3xy64w13IE7kjXVvC+p5HBmmJTKz+T+8GWLIs/2sqeoN6sFehpI9
 sqdkYl6EPOGtRB9r2aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfXzRL4b+jo5p2R
 AEzsqzNetfmLzBEauFCVGkSGWJ0LHRo5UnoGHwR6YoQfueDXgYzwdjKxzWMnoKoPaccgX/qe9K9
 kRNDID9zPh3MibmWjTg90+f0RqSWsBk=
X-Proofpoint-GUID: -yoQ2dgdWDWFLrRyaguVFeWna6rDD8E-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Thu, Sep 24, 2026 at 4:25=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> imx_gpc_old_dt_init() initializes all power domains described by
> of_id_data->num_domains, while imx_gpc_remove() only removes the PU and
> ARM domains.
>
> Use the match data to remove all initialized power domains in reverse
> order. Release the PU clocks after the PU domain is removed.
>
> This issue was found by manual code inspection.
>
> Fixes: 5a42d1198901 ("soc: imx: gpc: fix imx6sl gpc power domain regressi=
on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
>   - Check the result of device_get_match_data() before using it.
>   - Use an unsigned num_domains variable and a decrementing while loop,
>     as suggested by Andy Shevchenko.
>
>  drivers/pmdomain/imx/gpc.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a22..d83fb37e2297 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -502,7 +502,9 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>
>  static void imx_gpc_remove(struct platform_device *pdev)
>  {
> +       const struct imx_gpc_dt_data *of_id_data;
>         struct device_node *pgc_node;
> +       unsigned int num_domains;
>         int ret;
>
>         pgc_node =3D of_get_child_by_name(pdev->dev.of_node, "pgc");
> @@ -519,20 +521,23 @@ static void imx_gpc_remove(struct platform_device *=
pdev)
>         if (!pgc_node) {
>                 of_genpd_del_provider(pdev->dev.of_node);
>
> -               ret =3D pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_P=
U].base);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed to remove PU power do=
main (%pe)\n",
> -                               ERR_PTR(ret));
> +               of_id_data =3D device_get_match_data(&pdev->dev);
> +               if (!of_id_data)
>                         return;
> -               }
> -               imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
>
> -               ret =3D pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_A=
RM].base);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed to remove ARM power d=
omain (%pe)\n",
> -                               ERR_PTR(ret));
> -                       return;
> -               }
> +               num_domains =3D of_id_data->num_domains;
> +               while (num_domains--) {
> +                       ret =3D pm_genpd_remove(&imx_gpc_domains[num_doma=
ins].base);
> +                       if (ret) {
> +                               dev_err(&pdev->dev,
> +                                       "Failed to remove %s power domain=
 (%pe)\n",
> +                                       imx_gpc_domains[num_domains].base=
.name,
> +                                       ERR_PTR(ret));
> +                               return;
> +                       }
> +
> +               if (num_domains =3D=3D GPC_PGC_DOMAIN_PU)
> +                       imx_pgc_put_clocks(&imx_gpc_domains[num_domains])=
;
>         }
>
>         of_node_put(pgc_node);
> --
> 2.43.0
>

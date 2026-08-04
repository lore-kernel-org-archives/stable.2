Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08B43B483
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850988; cv=pass; b=KpfviCnEfWPRjV7/InFF1y9jzlYM3dtfqtbfGJNTLf9ftX0AUm9HRQkSCcr1zt6fVvHaIwUZV1vshfHOhOuCO7jkNYr7+meZjdZyOzFLO91n/61320LfO7oYJLObcpeM1/PXe1dHCjpkkCJWLR3fChgWOma9ChJqmP6g/HeMIHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850988; c=relaxed/simple;
	bh=vWrRgLg0J40/F7IFgvutSnpLvx8wmx6h7DOuDiZqAzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgvfnh9RlpY/GEVrBcEPuDdPbz2QPKilbtQpcAUbhoRvhtz/U40ziVuIIXLQRDPkLrcIBHdwdCPmNaH/8Ej8aFoMAzbvU8oUwCftbIq3t3Dc4LXo/cInUH3CQHBaUNtiBmMLmZfHzmgNx6sFRkqMgoJi8Rx/RxwvSPNFZ3Nm6Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zxcghe62; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=daaOO20Z; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zxcghe62";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="daaOO20Z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWx1E3211674
	for <stable@vger.kernel.org>; Tue, 4 Aug 2026 13:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=; b=Zxcghe62akMqHxQX
	TcX9gyT4igpxPkdeCzWD6PCdSLX8b/M98LVaHTJ0v/U8WRnvlMPJHRpKazk5OKUz
	YtcQJ/QU90EJ9NQdxZ8F94Lwfvv/+Wkxzi3k+/fbpkvn2W5TRPMym2G+u6rQwL2d
	iSuyzR/h4RvBLPh5nW6XyPyK1vNiLNhEGQoaSsrSUnql8mQGvU0kK7aA2HQHbk1W
	5IYMECDQrQTTytnYNvxGH2HQWBpWbQ8NYbCz8daWePsPI1tDfDp1/G+JIeWLpJvE
	g+05ZcxX6zokFBLu6iWGdsLResGJhL3Bcv2cIv1uBGCwrqCiIp+D+ykosKqky8h6
	NdBt/Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23h2nt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Aug 2026 13:43:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907a1e04111so61409686d6.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850986; cv=none;
        d=google.com; s=arc-20260327;
        b=HJ+pE2fCdtkDBMvjxPRDXyhU0b0sDTCueITBU4LGEySbB8h9eTjVWiWMJbanbHIx/b
         ZnlMmZXKumeWLUDKenswoTG0GvKVjrad0BWTTItqmxCQmM3juLYcoW741Hs5sOUB6WlU
         w9zzGyaKEoRT7dHfPMsncsLwH0+pzfleNzUnhjH6rJl5P88VxLJ4hZ8KHMLVoSfUEnUI
         JYSlkFuG+yquxRPQIPcQk1JwZq7na/l/xHeT3wpEC5kWj4oR6ZkflZmkRx3ruUbsh/kk
         Eqgl4jxll+i0kVi0cCq1BrtvYRvCevQbVvWB5elZa3HuqeoUFmPUYxlfkt1h8Kly6eEQ
         zWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        fh=kTlOeUFt0//5ea4smsN+wO20vWMVJzcihu0+GUaR2b4=;
        b=A5bV5a8gaPcfQ6yjFBWUrPKTfxJwQO91+sWhl8B+n+huaChy+E5hRxxayPUFyzqBOb
         rSUtIc3HDXsDLRjCFTc4P+FI1u12mxaLdgS0ulc7cIBjNenZPvvDqvUOdwD7B+CIHOrM
         Q3clb8jTrdHNFaMo8z4eJTIDElgeVKt2irL6RU5wf8kO2qnYbTK0YxeifWsh7Aundv2/
         dMR73xfdkn7YKRoGN5otmYkwNTBvym5W+72j475T/E0gF2wpx+vLqed8LIz2Mqum0ZrT
         HFtRdTuqbQVOgUX4Eu7K0OMa99gFU6pb0TCedMhVh0Efxs7kBijLYUPc7c/4ElNOUnrK
         NZtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850986; x=1786455786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        b=daaOO20ZEBfgxoSMycwt/K3hv4+zjBVE95f0VISpjCyYGZu0REuzy85WiRl9shq/I2
         bZeUIDblxT+UYUMuejd3FKGrsPuNW3++Y5JoUoepzT/KwRaQW2hpncJO8qYAAVxsisK6
         MGT98EBx/xFtnQe38bPnDwfD6giynB8apsHCbha/tEcSVKJ2iFoZbjWUxCKQ5Ic5HULE
         0cl3N1+Wwzl1edxP7EcZofA2bsbj1rq3Zj1JZH2C9V29iGF1lRtNX4ZI1SWeodBfhzkV
         juJfUZcoKKpje+EAPtUhmTCg1QdqSPP5OnuI3YL1AetuJXMTwMied2VWMWyhEqlaZQIa
         xCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850986; x=1786455786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        b=jElP3UdGhLOBHjv7gOnzttb/bqeV+D9ZnusIVI4JoPDq5e95gcJA4wuEOY200SxMCa
         36pEnKui5vdrqtDWDTu+eONg4bGcvfTL/vmfZ+/hzNO08Z1niyh1L0n2cHKLGyMXWt27
         cb/cOFqHKCMtPHez+FPfe+uX1Y1yKXPoDYX1pIMp+S7kcshQUZHFsmfE2tEZJ3gT1Mi6
         s9JMnKc6JVKutAzM0bqF+NlvLtU8YwHHoT2F0NNYf3TDeJtUFCoFfI4kfrHDJTFwwaXL
         nCUuWhqcK4ZvmLT7FlKsMWtcR5VAzjdYejc0j2Ia0k3D2uvd1/zaDvSAfR7FpuabaiG+
         tIDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpqOr41ZA7Qnh4imXV8rX8WfWjxt+V9nuUU6/67PqKxa2blNz7W9oxz/DcKVIJ59uvB4E/0f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTd+OdopFhiG1wx09MlRRVu3uDNErzYKBO3Sj0SGnU1LdnFSQ
	SDTVWFqwpTBgUkbnExd4KGOZ6O8Vzkux1/gNcKgEo5o9juUcyszphWfCWMhotNXgtbnsHVAuQ25
	CA9IVakzu2S4lMRbJ/cu9Dz0jbP+jNJ7zJGS9kvq9BNnqTkgKleSN2rCPaG9Sj2F8SnUNR0xHQn
	hxM/T1v3CRNOqpjFJRdL08i9sTe9tWzAOPaA==
X-Gm-Gg: AR+sD12Rfw3yGXGIwrfWc7y1x9p11parASqozSo3nPaMsiOMOInJt8xLeafNipXqLkF
	cIWJAR8ttoh3zCJ2CZ3ICB+DyR4Jm1ZNrgteQL31NFikxQHGG4ecp+Ns5f4+98u0zxSY9LhQOE4
	tD6pjHSKBAiHZIV5+CbxklcStjO03c0v70QQkU9Q6kT5Knl/tz2PWKI2E/pw==
X-Received: by 2002:a05:6214:2123:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-9084954cfb5mr292319286d6.7.1785850985838;
        Tue, 04 Aug 2026 06:43:05 -0700 (PDT)
X-Received: by 2002:a05:6214:2123:b0:8ee:fd0c:5d96 with SMTP id
 6a1803df08f44-9084954cfb5mr292318986d6.7.1785850985502; Tue, 04 Aug 2026
 06:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727140322.41306-1-mhun512@gmail.com>
In-Reply-To: <20260727140322.41306-1-mhun512@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:53 +0200
X-Gm-Features: AUfX_my7B5k2X---RdqnxtTsY7r9fbypq1sJhWZOEiJTCkULuzpV4YOD1Ks3_qU
Message-ID: <CAPx+jO-uVPs0xXvX=qie_pP8+L6yaWSD+w=1Jh8tCEXNYmxugA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: unmap the bounce buffer before device release
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ijae Kim <ae878000@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: dbD-fTw3V2K4qegQ7_1O5dn4birT4oXE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXx+I55dJg2afq
 OyUKzxT8ABu9a2iW1kqrWb2f41XpNHbhL6y0ftJFuvsh/f95VJH53ud0CAx2JNhjdefbNGx65A9
 ZSO8n7de4zaWuedJ8lHb1npSOGIeoQ8=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a71ec6a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=9OAQqQgZgWU5tXGBbwcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: dbD-fTw3V2K4qegQ7_1O5dn4birT4oXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXxIYF3PkBWz4W
 KJGZvD8Z4LYbOn02qE8dx+xi0fVXMkQAfwyeT4y4YMsOf+RAC4kUQtnb7AaSfkTy8R0xMa/f2u4
 tmhYw8EjCTnhTqJlZ+PHHm2pGNDmKkidqCaukOi57DGBVGrra7yBS+fEbZbmcuZ8etp6hBPrrNq
 8+dyE4vgojPUBbFrwzV0zKz6SssNtR2ojTK7JZrEEbMxO0K72YTGSP5L+9vXrgqYX5bT78JRCeI
 mc+YwqvUc1Em4arrO1nj57aCaSGih8K9clxgA5CpLr6/3XBE/AuC/Xoq+NIGfsPN0ZYcxsZAasY
 xwmf6P1e6X2wvdvWiiewGAbYrlZADade7h+CSFDke6a9ut8IUL6h4nc0xQp7W/ijqoleYndpMEq
 hFJztiWJfub9QBcVu6olzRjomaHQxbN2+YF7SNRW+By/r2CxLcDbgdIYhcgdrxuU/Wm4E2zZyW0
 SnxGNEO9lJT8YNqdvHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Mon, Jul 27, 2026 at 4:11=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> sdhci_allocate_bounce_buffer() allocates its buffer with devm_kmalloc()
> but maps it with dma_map_single(). The buffer is therefore released by
> devres without the streaming DMA mapping being unmapped.
>
> Register a managed action after dma_map_single() succeeds so the mapping
> is removed before devres releases the buffer. The action is registered
> only for buffers allocated and mapped by the SDHCI core, leaving buffers
> provided by host drivers under their existing ownership.
>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buff=
er")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e3bf901b10aa..efb4c7742fe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4187,6 +4187,14 @@ void __sdhci_read_caps(struct sdhci_host *host, co=
nst u16 *ver,
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>
> +static void sdhci_unmap_bounce_buffer(void *data)
> +{
> +       struct sdhci_host *host =3D data;
> +
> +       dma_unmap_single(mmc_dev(host->mmc), host->bounce_addr,
> +                        host->bounce_buffer_size, DMA_BIDIRECTIONAL);
> +}
> +
>  static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc =3D host->mmc;
> @@ -4247,6 +4255,14 @@ static void sdhci_allocate_bounce_buffer(struct sd=
hci_host *host)
>         }
>
>         host->bounce_buffer_size =3D bounce_size;
> +       ret =3D devm_add_action_or_reset(mmc_dev(mmc),
> +                                      sdhci_unmap_bounce_buffer, host);
> +       if (ret) {
> +               devm_kfree(mmc_dev(mmc), host->bounce_buffer);
> +               host->bounce_buffer =3D NULL;
> +               host->bounce_buffer_size =3D 0;
> +               return;
> +       }
>
>  out:
>         /* Lie about this since we're bouncing */
> --
> 2.47.1
>

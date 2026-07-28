Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A54483BC
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247717; cv=pass; b=rrwtBuOYyKrBW5F/SnUnOs04DAhSUhRuhtrt3JfomZL5sHcqaolCbsYHl/MV/2pbxLsn9re5uBwCj4QtoJCVB8Iu/xM4en4lWeo2IGWKkttsMP3hwa6cf6WsHiR0FC9uAfJoo06eMtJHyIVBKuWk2GnjzyaCSVevpc9FxVHd8Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247717; c=relaxed/simple;
	bh=ADsl6Oh6BO5X1ATAFohCJeEUaOkmKU8XJWSMqfZeHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz0oxvC8QsWewM0Y5dENLhOYnz605TBq29/YU1Maxa0eSVPSmedlHbp9Q9meZGDfGlJksq+94Xf92NvQFU7L2rKTeHvU42PZgQ49dVQBsUUtYrYdcQP7bEh5Nczbije+1qtBTgvkcxRxADMBOcuwdHL0+BF+7MuH1d3o3GeDk3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSoDKo1D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OSQQ3sCb; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSoDKo1D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSQQ3sCb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDOT7i2773171
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dgrl60IlcgUtxV8b+GtgWbSKL9T4fkkU03nVj9x4Tu8=; b=NSoDKo1DRTM+d2OR
	xcEg1CPv1i2miZnJHhIKmXpRMqLAujW6GhWOPhBY0uv9AQR7A4P6Pvi/QaRi4Gfb
	GuKIhxcWvRXsyyaRla2PP+uge6SSh/SIHcel/gxQ9OXho2SFBiNfbssTEaAIvi8G
	22n0s8kUpjiGc2dqB7pqH7lw3WKyau8wCQDa0Zgah7No9Y86wLfxm+cTpwKPkTNG
	khkMlFaAND0JHSVlf+6tr1cYUZCqvgOrQ0rkDmRpcPNS4RlBj5ccNdOJOuSNqvwV
	f087lQhsUae6dRhITDfop6Zeauz66/K8sHlHuqpKQEAWm4or6M54rPRGs06G6dka
	zfO49g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpw7307gq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:08:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so115305585a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247713; cv=none;
        d=google.com; s=arc-20260327;
        b=jVjQXWnivaj3bCD8p52wMGNjCrgL1cBBDCr78oAMXTstsCCYE53ZoIfVOzJt8VG3Yy
         QVmM+v+IDnhIotlHVrEZ6HMVGWnS1UlkIWAD64Gj8zEb+3B8zp6bpn6NlOdjfDC/heV+
         Lkqm1v5JoMX+K6HhXPXYV73CQXeNXDUN7j+SbvFMyL6PThrvufQO9vnOIglbyrlTjpw8
         cFvCnbuyahVSabOzJcVr4yxukzjaq7E8IhqECfivt9mOTRxR6o/nPRVriU1FE79jf3zE
         QtylNNoqMilmzWjAGNS8zYQR5y585aQfbn3OT1/UKn3mgUXPFE0AFLmaQf31ZzvwaPqc
         1VjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dgrl60IlcgUtxV8b+GtgWbSKL9T4fkkU03nVj9x4Tu8=;
        fh=IrJjC3SDh9QRkrJAdyKxkhKH0gLSMcy9+MGYFCL792Y=;
        b=WTuls0AKgfujyhOJxjKZyfWFjWvl+2KZB10xHm2UJ0zL7cdct5Lphl9jIYHA0TDh7d
         q5cQARs4OgVXIhJ05s+6UCn4DIieOZacFWH0HXjLaDysNFQsQ8U+bmgIXjUAivUAJRQa
         s0VxlHNVDMapHQbK3DDnH2TNPQFl1U9RVYDDC/2lzluZ109/eKdiwlpSxSmmcB1DAmqo
         CGmhEwKHL8Z+zqEpzl/09gtp+Dzkgoc8EjKJ1QFSKzZsQGh3LByzA2W5Xb9rY2KiNUhD
         +W/KPVWhDh3hHmUr9uX147GxodZoNV50BC9LTQKM87VhSPeomVOpdJJjAOcSg9ub0LWd
         gBTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785247713; x=1785852513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dgrl60IlcgUtxV8b+GtgWbSKL9T4fkkU03nVj9x4Tu8=;
        b=OSQQ3sCb9rZ0MuqedNA/2Sj2nia5iRREdv7+LXEgbV+7ktjV/FHYU6NLGL7wf47GfC
         u+0BG+5Ai4EN437/fioteFT2CTFhY4ZyykwhUUYXmluLoYHaSox9V3sbdp7/rGZ7As3T
         oKLF/U9E0T7qiaKyyg8x/sz/4QlCT2BMB3GUw49SPmnVBsxtp7DHFVEC37pISuJCvWaM
         WLourPq6gNbfd/czQBA+hgcszNzaKbjNq332uxePTbiRlejHzvwLSf0GmdtMEbqLnxfM
         4SXtzgyHydefE+0x3cwMdJ6vK9mGM2GrNZquXjovOQlu0cOJ/Yk2zxEvcKoFcienBejP
         m/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247713; x=1785852513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dgrl60IlcgUtxV8b+GtgWbSKL9T4fkkU03nVj9x4Tu8=;
        b=Sw13/CU62oZQKjvwe06uspezbMbqy21zQ9FYQdlKOXS4QjhGO6Xr1mEE4Euvi+Vq1q
         tVnlifVJHoBBZxjHkT7C8aBviE6bwaMci1Rq6aNVq7SxO60C0ODW3J++U3JFY1dnWESc
         fYaGkdFgry8/1op2jThd5wKGIIZ+yiOwZsx0R9BsU0xxMVRo0TeQ9iSuY3ttCc9K6FYU
         ELE9XweovYm2VW1d01uyGpdkNLn1K9nuUdUcxxB3vzHQoxmeYSOdOdl4mhAP95sKAv26
         GC/HN8u0689cd1+zI1pg2fZ9fIe1AjQDWtzW037udrGk6AqvgLL0sfBHFmIxSwlSJceh
         1hxA==
X-Forwarded-Encrypted: i=1; AHgh+RrTkwO6Avd6Hf/7v1CXMgzK0eGh+vGM9aqIFPjtbc4WGCiueUSsFv8WuNnZAizzCAxWFeo+g38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcu/aU44ehA/FLZDomBr1Ex/Iv9WcZU0hCScISZ/d0dxkk2TF
	TPw52zkibobi0AHAKbIT5ypsacEgqquRDSRYelfLreQzibQSE8t3ugamsFBl2fkeVkgFMGnhpj4
	UWRR8cY401ex/azxb5HQuCyqt8WrX24mR1iywtOXBE+F5vReEdWYsRpHsB3a+pqXXG/8JpJsB9X
	paBozWK6RTOcz7hMg1He3c75cPURcTAiYzew==
X-Gm-Gg: AR+sD13JpW0QOvXdN+ANTwjv2LQfdzAwwaZTcuxeHCX6RGX1+1VqU4QYga/7EBgyaaw
	XWDSITmkC+B7aF8bE0ot8UyztPhxAlRgYE3DmcjcCEO6+8qAdgeo4pCINZe0S/ptJ5LIWSVOm9P
	a0clmD+tD4nAxcdFRcNXklpQiLCDUPVQQTWqNaF40bgh88beoiB/CF/CjWqRr9unaxfxmEFUHe4
	kdfxPFZzGBFZMYwUSoXdaDrlgyyefH1MQ3JOiQJDJZpDbaC/pb4rE+Q66V+0zXts0nx9vtngdA=
X-Received: by 2002:a05:620a:25d3:b0:929:f78f:6bf9 with SMTP id af79cd13be357-9330263c462mr233337285a.16.1785247713141;
        Tue, 28 Jul 2026 07:08:33 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:929:f78f:6bf9 with SMTP id
 af79cd13be357-9330263c462mr233331485a.16.1785247712676; Tue, 28 Jul 2026
 07:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-isi-v5-0-1d22ab91602a@oss.nxp.com> <20260728-isi-v5-1-1d22ab91602a@oss.nxp.com>
In-Reply-To: <20260728-isi-v5-1-1d22ab91602a@oss.nxp.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:08:21 +0200
X-Gm-Features: AUfX_mw5JcxlCW6NeAN0Cy8X5f4_Rk6VWvnTqzYs1-6WgLhGTre_063E34AGeNA
Message-ID: <CAFEp6-3jntC6xQLDLjQdMps5Lq-sOCGEtMnkFTtrCDZpngBwRQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] media: nxp: imx8-isi: Use BIT_ULL() for 64-bit
 stream masks
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Christian Hemp <c.hemp@phytec.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Jacopo Mondi <jacopo@jmondi.org>, "Bryan O'Donoghue" <bod@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>, Guoniu Zhou <guoniu.zhou@nxp.com>,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX2OnYS2AQCE5X
 9g+rub24wgYSx4SdSkCBwpd5RtbsK8YsR9eAgjk9jfW5hfNspf7LZf694OVIrMKm4DRO6l0wNtk
 szqbKzuqH0kb7A4sWfJL4tatOXPQt4o=
X-Proofpoint-GUID: 4zZQPdzJ3xUI05mjg2WJAzSwifyPrhqf
X-Proofpoint-ORIG-GUID: 4zZQPdzJ3xUI05mjg2WJAzSwifyPrhqf
X-Authority-Analysis: v=2.4 cv=NobhtcdJ c=1 sm=1 tr=0 ts=6a68b7e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LElf2VvS5UWv9C91Qe8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX2vTjQWoAACsG
 upw52I3WkcSK2yKDca+FaE/tv+9hP8fsvGhpiWax/KcovXU5B2+JFL7pZ4zPwZX6cElQPptpOU6
 EY+piDow0x5+995k3r9+8qcy+IuG/HAAf1U+rZXRzEEPW3c25QEORcc1yxhuQyhT54zIZ1+/Ypu
 1G/HYkP/SO8xBKtnKrqVqwdCPLfvUhi0mtF7ugADvM2ePulXUShWwIA4xJ0Ym7VC/EAwKEUqSah
 rCInjjGyHWuZQoBwkxesfQG17mNHcUeIMK3HMeTYG1gUM2fz8LW/UbNDlMGvn1TvrR50p6xTBMj
 GSLrdmGHYaSAVwtya8eoKSh4GtdHFrjrdLNOFY+YERSnDApubMVchfWpPfzJdDzHB/53tPWB/ni
 So5HoFNEdW7U47m8jUPna3ROOnXkMFFXXkL+kmjh4UEikfgj/RvP+dcBOzEshxSbHJJJtu9dBBr
 urK0YisbomzMpvneOzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280125

On Tue, Jul 28, 2026 at 8:55=E2=80=AFAM Guoniu Zhou <guoniu.zhou@oss.nxp.co=
m> wrote:
>
> Use BIT_ULL() instead of BIT() for u64 stream masks to avoid incorrect
> results on 32-bit architectures when stream IDs are 32 or greater.
>
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/dr=
ivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> index 9f0231ca47a3..9db9c6e55c2c 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> @@ -157,10 +157,10 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_cross=
bar *xbar,
>          */
>         for_each_active_route(&state->routing, route) {
>                 if (route->source_pad !=3D source_pad ||
> -                   !(source_streams & BIT(route->source_stream)))
> +                   !(source_streams & BIT_ULL(route->source_stream)))
>                         continue;
>
> -               sink_streams |=3D BIT(route->sink_stream);
> +               sink_streams |=3D BIT_ULL(route->sink_stream);
>                 sink_pad =3D route->sink_pad;
>         }
>
>
> --
> 2.34.1
>

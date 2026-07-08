Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63C41CB25
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526402; cv=pass; b=lgBDzbIBdurIRvFn5npi+TdyUGVK4zClqFqOyeHKMr6X0o7cifDd+G/Osp/Z30j9xtpxoPF3cZyiGdEKZpX7VUXzUI/ll1GrkkFWmy5YR3c1PD32t/HJ/DIuJ/5AsNpqMthNb8jnMJjwl4kYoARoxKANdzun5UfILsglk6DJpVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526402; c=relaxed/simple;
	bh=S20u3kEIoDTzgKRFIDn8D1YCZgVa4uT1ltEDRmJ5pQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1t2N4oyQkjjP8GNU7bqS2+R7fC8AR+2yBa7PyLW1H35VXraLulywSRASATH6OMKk6cHKoLmr/x7dhxLo0Ki5cZ81hf4C5By2YxhayhtoC+Shd2jrdtY0XHJvjTZbYgMjfk3uatY+KW5tKy7wLEx3kXBWFSWM6if0sG1Nh2SPN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joLcvzan; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HUWT4POI; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joLcvzan";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HUWT4POI"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3L3J2608008
	for <stable@vger.kernel.org>; Wed, 8 Jul 2026 16:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=; b=joLcvzannCuf3Ryg
	V2K/EMBuiTgNwVujenQonsGEky+ayxJmShjkbJJt+EoBPez1XnLbujmHhejHNZC0
	sUKxfVr97r+FGeWuLbLSlfpJNGv5X40kvQS9OfFowNKaZFN5vmf71h/iGriZzweE
	JjL3aUgfWB9AERjWRq5Y4SYXQw0CVyiY7KUVJ6oYYf4daNwD2oYozgpvCNb2bXnn
	s4WrxFtKp4DQJK42g7VBjAGqT7XRrEZr4GbO/EeO8sJuyiS93gnHiwTDFyQHyNh1
	QomU2GcRbfc2ilhey5UZFJ6HOjjwCNYRFGx4rMNcFXkG3UbcPQoi+0QX6sJInlzh
	Mf6XTQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be5bkaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 08 Jul 2026 16:00:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91ed0e140c5so163669185a.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 09:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526399; cv=none;
        d=google.com; s=arc-20260327;
        b=EgYHouI32FwMXPuuKC8383u279NNOcAcSevHqD6B13R54eRD90sB304HswYXirKhUj
         6mdZzV1Dky5OiE8Yr2L6Ac8CCcqwkzkJoulwiDVIA7qCJe7DX5XiRBlwvfM31J/CKLbZ
         Jj7HtoajXhoCnngkm77wArp/fZR5nhwCQwoVapvMUP4pZU7/fVya0OVbrbBcJsq2tVmG
         MDsWylsjNjtd7mdVRCWsn7toavhHr6I12U6T3MocPocmPobT8TjqwZOQUlZ3r/gBIqfU
         zKAZz7ePz2GBEtGSmHWZpEY5tgA+BKr/5P08nd+dU9eoz9vV+XW2Uda2MWqiJdEpfRiS
         AOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        fh=ZRHKTwZP4Mbkoyv3Cw7hDhekh10V6QdM222Sy1bszks=;
        b=RugHjVRRrF2YSCW3biHn+cyVXUkN1/t7p0MJrf28eV/s6WB++mTMxkZJVGcmSgfANq
         C0eW+ExSChvcmfOIKQ+U/+5z5ktppOVbgF5mLr9qEVpHWo9IFgx3C4zTPQdmHbEBnHo7
         cHGbIsIAPP1c+QQX5M+OZikZSc9nshbiyKLNSjF60Xhv/nzqRGhMFCfoADAXX6ZlogLl
         9lVFkRfcRGIH1BLsWCU/20Exm2N4AH7hMlN4ze+I9f9HrPetJJkwJ7NQElZT6YCWDnnw
         7WM1Ma+kj5vY0KOMSwlKxe/Wa6bMiQqvO13lvb/eoJORL3StuRpDXqG2mu5WaIYaOj8Y
         4M0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783526399; x=1784131199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        b=HUWT4POIdGPTCpde2akelxT+6aw0J8jaOENi52ifLk4MGP6X4Hyi4UMT73a5FmiIk+
         ZY93WCG++XnQs5m4GQj0K5YYZzfjnolrfSzyWhfnS2Cm2cx0OQMWt/Kz41CNHVMa+DlS
         QAACzlg5pO7fjL2CDbzp7leacbuwAH5gFuMhVC/hUVs8MXyKgzwxM0kn02UT7eZz92sC
         sihnn0a2tZ/sDZQ7TJHl2GYI+atXAR3cUwPnGKNwpxfHYhLo/XWWrRyMh5kVCZef7af+
         n9BRl+6CCPrE1gE9ysr07CdEYb74dUCn/ARcjSZ3SYgx8bP5yJ9flnptvqanL/BCAIIm
         hXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526399; x=1784131199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        b=INmgx5iVrc7Dor698i1zyxhPkrxwD3x9b5Z6xmzmv7s190rbYFmO8ii/IIGodBPIC6
         KUHobmqzADUgaJUZCTYnjBHJffCSJd3bQ2XqtIfn7jeJiH+je+JMvriSBQX4YHOnlGnO
         t+7XRmUsmCHewIhbG2xetdWAXVeVPa4XPMpNG1Qojp0naV7yQCLz/BDWpYThjinNRi9a
         eReMm8aitKtsih0cn8sV7dp+GjsuRdDXLfw2YzwYdeG4uc/s8BdX+wnmxhky1224wd4s
         Zjs71ARQia5R0NbdNv+qgdTbd/lKNH3uRHhb41SQn3asRA6rz+5gb5ju8vaTCrFEAxXL
         E3jw==
X-Forwarded-Encrypted: i=1; AHgh+Rol1zU1Vz+ajpfiaAb3tT/dPrdqq9UYULkjpMBV8S1UroQmqxK7TjQRq3jeNT8IR+2zal+rHFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyevvsg05qxXJ/34aCB0qqjm4q7HSSBk/8SBzvLGbEvS4UOEuJs
	2k04dm+5/SZUcxDP5/FyTD6CJJYNB/p+pAk1LYunkNC4S8Rf/dx5UwXMfdegUmxxwoDMkM5S+7d
	XQCZFRifZa+TT5328Dk8DggLyNIk7KPNA5ij5LnrcjDBLtfrA0CKQzDzioRO3hWsq2riFSG+JOp
	Nw8cgUYe32tH18CHElJfjbp+2W6+DmNYN4CA==
X-Gm-Gg: AfdE7clFFGC5/Tr/HnxFfRKLEQ4iGqrKmiD4r4tGL1kBjFuVnnIGb7sZRWO8mzpTOIQ
	Pfd5pevrBvJ8bedzrctjxr8FlzxC2brkBPnJCWCs6c+dTnS8u72Q7INwr4bVrltdnR6G2axCfbn
	NLd2ruAfIEo5W85j5NhCuHuc6x1ZbQ02t5IC5HCLXp5S1mQlpTyRNkYP/Njw3xqjrqBkba
X-Received: by 2002:a05:620a:1a07:b0:92d:e54e:72d9 with SMTP id af79cd13be357-92ecf5c527emr315767885a.1.1783526399238;
        Wed, 08 Jul 2026 08:59:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:92d:e54e:72d9 with SMTP id
 af79cd13be357-92ecf5c527emr315764985a.1.1783526398870; Wed, 08 Jul 2026
 08:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
In-Reply-To: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:59:20 +0200
X-Gm-Features: AVVi8CdAnkt7W-EK3sRgfNkIzKWDE74xqiNiWEwP6a_AAGRkEBuSzmKj65KtehM
Message-ID: <CAPx+jO-NMUPfXJpSUa09VrA=naiiFTMpg0qzqi4QeYbeeK3SkA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4e7400 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=P6ToQuPI3Mtl0Vbz5-oA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfXzG4UUw9Nfk9V
 4/r9ZRt5Heq6BKu2U377S3aqtOy225FRRCHwyzuemuxJXIXPn9wmu/ml2Hrji+N9FgWSs+mcZcC
 /f4390z0A3fQwCefPGKXaM5iypGjZSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX/Oiv4DqiuicN
 JLAxxPEn30xBcXppt3y+tcdlPhnp754xT+BcboIVOKgwrVb07ar1ZBzPwIJCV8vMoJkYquis82l
 h6s80OJc8HVZGDEbUUIOxkrWTFpUotppT4885JQQnvFi/X2CTl9uK0K3MrHRU5XJ4gT+B2L5rr7
 8h45HRm+FdBtoMqGWmMbibNSZ44ADzFeECE/9exMluFM2Yr41QS+mJ1LhnWtlg68CF5yeHEuwId
 Par8fJUFY3dpjoUKJ1kekLTkRxxXrFGuZpf74G0qeLnpu7wXaKjmw1E8vPVBpYnfCgHCvHoET81
 KAVUrHs6qmfIXnotI2n4vTykebW4Va1AxQ9XK+MidoTGTC2lmNsv5rA/SrMetBX9lXgqN90nwKi
 SeUqLIlzCG6Iw974joAL3ZAsi+0NYkk0xg43R6oCJeWtDPJXp90Dh7Q/zXngSpwB0YvkCdUm5Z0
 atlCClsnsI4lowzRqBg==
X-Proofpoint-ORIG-GUID: 5A1d-KB_yR_yFySU3VNIEB4x0ELFVxp4
X-Proofpoint-GUID: 5A1d-KB_yR_yFySU3VNIEB4x0ELFVxp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080157

On Wed, Jun 10, 2026 at 3:22=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> There is an errata for i.MX8MP VC8000E:
>     ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMI=
X
>     power up/down cycling.
>     Description: VC8000E reset de-assertion edge and AXI clock may have a
>     timing issue.
>     Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate =
off
>     both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent t=
o
>     VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>     de-asserted by HW)
>
> This patchset is to fix the errata. More info could be found in each
> patch commit.
>
> Sorry for sending v4 at 7.1-rc7, no rush for 7.1.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

The v4 series applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Add R-b
> - Set is_errata_err050531 to true for vc8000e
> - Link to v3: https://lore.kernel.org/r/20260409-imx8mp-vc8000e-pm-v3-0-3=
e023eaa245b@nxp.com
>
> Changes in v3:
> - Separate power up notifier fix into patch 1
> - Link to v2: https://lore.kernel.org/r/20260228-imx8mp-vc8000e-pm-v2-1-f=
d255a0d5958@nxp.com
>
> Changes in v2:
> - Add errata link in commit message
> - Add comment for is_errata_err050531
> - Link to v1: https://lore.kernel.org/r/20260128-imx8mp-vc8000e-pm-v1-1-6=
c171451c732@nxp.com
>
> ---
> Peng Fan (2):
>       pmdomain: imx: Fix i.MX8MP power notifier
>       pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
>
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 46 +++++++++++++++++++++++++++++=
++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> ---
> base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
> change-id: 20260610-b4-imx8mp-vc8000e-pm-v4-1-a978b40c59d0
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

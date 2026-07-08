Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEA409271
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526372; cv=pass; b=VWi2T4q2Aljq+welmny4Az/fWynD1HuVpP0oS91G+ggP8rP3HJEaUC5GPhSCuhFyghPYn7WmSdLMLooDw5m1DNK/21lavSAN5I4bc1XYevSDvqabEGdhcZg5/UbJ7GrPs+rYo1zGfltOZZie6COIeN2R11qGNY8yCQHTz+HrhSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526372; c=relaxed/simple;
	bh=HIVEgcuKsvKP9oTptdmuFPNK/sIQQFxDjbmix66hFW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTeWuUempKr9CLG3tAQMB74wuj15eY+y4xUeGg1OepX7lW50QmMClYj3IJ8dD6XXri1oj8fbQJWUXDOoo/esozoJ3GMvVi6b4Hfmv6bbKsVP23vCkW65+tUiN521nO49yr4LNKqlgglqJ+w7hWCqK7PGyZ1AFwkA2iIT/DOVQuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XyA045nB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NpWBtQ04; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XyA045nB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NpWBtQ04"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3s3S2751527
	for <stable@vger.kernel.org>; Wed, 8 Jul 2026 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=; b=XyA045nBOM5EH5Ke
	LNkFrfA9nQDJlcveGj2IHyeLt/bwfZVepg2Lvu1e8orRvbvsxiIi7z8zdI274WG1
	boey+aCihWfvPW4e5Nw6dcPx4Vj8dz8y3KDI3BfCIOP9AKlfSYhb48poQ21W5n6j
	gzaStDxvYVKkgOiRbEePjq89MlTbXpRjCEYHnTemwLl3whXN7lv60jJO3ClGjege
	h92FRnTFNsKKDVA9IbE/vq1trLW3UwOxTMH+GILaJxgi77uiIykYMQLx+zAiEJ5B
	tp8+/n+37p6V0FGEd4wpGQ5aC+xKz2KHp7F59PUEvOgGcn+nQivIx0OiMkAUKtu7
	8jOAOg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssuak3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:59:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e86066fc53so163266d6.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526369; cv=none;
        d=google.com; s=arc-20260327;
        b=r1xllBp4u0eZ6GZ4Ucdv5JNM96o2/J7r94mimZ216rRHjybwmu2fE7+gPTONtxtXBC
         voxig2UZ17N+1G2BWESM29Q0maJye2wACzTuQmYvrVwBpfup4flhGdMAuWa6ph5u8/Iz
         j5OPSxGs4fO1XvWIwYeysvELs7+nO3cTaOcQiQr8p3BmqOeBya0rQG1CZNxfduNZfHg2
         yf5bf8+BfyzyaK4ET4uI12GvKR7uNPETKuJ6XZ0mXm1p9K2/o+6uYtKSliAVRtBhzvKG
         cU1BYSUXuOEZQetafVBlUU91X2wtKF7ymUyVXC+wNAmuaFO49Ea+K5Tc+5yQuxQI2Sre
         lyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        fh=cr+9KNk5mSJ+BOJ+awG8ktSnFXrmKequgOmW8oezpCI=;
        b=OsZvPa3AF3MkCPo2BF97KZ1EVmi4RfAFsJhd6cRVE6gEpcMo6f1wSzCHceHze9O7/n
         p+NSqvgYEuh7I3f77lqJ8uYCjnfTnGjwMBHyH+/SB29Q/QHb3ofLYYZUd0uDVe+8mTZz
         pPoKeeF4bPa1qvb3gYiInqkwPw4rpOMEleXUVcBBxd0kUJ0Rj8lSfXuKv4EA1f+1xCLC
         LIplmFX72DXKsoXw+v8uTsFjYReL3EIest7zbhNJs+Sk4j7GwQ/wjTR/aeQHDT3fqxyz
         RpdfZU5zJPQTIl29VXx56DoyHGyy+Ishwj2g5Wej9ke+jjcCBaBmCepmJ/qgrGnwrCzo
         aYiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783526369; x=1784131169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        b=NpWBtQ04amdXupl7spST7zeTGHQ9nvmPtcMLhaoY06nvmjtOHE2uXbhUAUl/IMzLxl
         sfH9e4XagAgk/Fdn2vSpjjywHLC9RXbGCieh/qAjyNpPfKpAIv8+xkki/Sp9M4Ck9XyM
         H0Qn6vZOJ3wQHW95ohZH6gV5/FXC4So3bSKQddp8T0NHMHdEy2Xzds3UGLYgdukQQ5YO
         9Paf/8wtSDwmB77OGbqvf66TyYGIDT36V/btmClpavqR2naGKTrCP+rRKddxJmVuGcKd
         a5hUDM7GG4/UwmfSD/1Bw1KauFcmE376mhci7sKniDFA+GHzmOZ4NYxPHpTErXEjg6fu
         SXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526369; x=1784131169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        b=VknNBRNuhgfSlJBkJaif/WJhQm4dCKzAAMdTyYGuGvneYwFxFfgxsjEbeV0GRRpX4N
         mqzMsX3adyAdOaACi+VfJnkSExT81rmZ3uLK3cnJz+qCGIiTk0ozWLdVfxC98cDY3CE3
         1ihP9+YtoV0v52m0BXzUIhjEY6QrvEWy6ffBL4toQ4C8cu9YQLSmnQUs/sPZxeUEVOhC
         wQ4i3MPRnJNg7fWKSxQK+jtUG6AcRUgcGl0JKMYHktHfU9VdvnMp2BqAF6Isi7xnkV/W
         uGotpD1uB7I3/hwfPLXoZ0M/Ttqu+yGa40Ymp5ZW9jVvkwQUoYdxrQg5dtqzFhUd5M/d
         xi3A==
X-Forwarded-Encrypted: i=1; AHgh+RqCmp6eHPBt1o9cctwMdxsRHQ3DmoOZGxjm2l9AeHxOc/WtTYlP7B7+reLVesIOsK7ZOYX8miQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCe8FIRMFCOXiMM1znqK66dLfoGu51ITJ0AxWxRBnlQMn+Liye
	HYYFgZPsP2Qc5AonGiXc/2NqXbbkDt0RCPByRi3pnfsuk8M0fK234QYMKED1AiygDNOaGHQ9uzt
	zPrnpFcEcWWtxCDEeOQhM2LcMwD6ByJlob5/9/m+1ckS6d/ZjsRPLVOtiwIB6zgf2gEGbFk2cDY
	xZ0NBxVJ8ombFSCR62VDb8uXezgNFcSe15TA==
X-Gm-Gg: AfdE7clIsiL4vf+v3tnO+3zx4S1Rbhl8ntYoh+/tVevIv2ea0MpGig8THUCDaosYGWT
	cqqDFCF+auulFGetqUf7IwBSBuBWIbVbwai6kDWrjiOvTJZ1GK7BE+VbhxkSnbFqOO/3K5BjSNa
	SjyqEzsHVrLct/W8x6gvVkA6uFI+GraB0bLElOch9077BalFPPrV2XeXR94C9xCoGtmavf
X-Received: by 2002:a05:6214:20eb:b0:8f6:9379:ecb with SMTP id 6a1803df08f44-8fd3b9b13b5mr81855116d6.26.1783526369003;
        Wed, 08 Jul 2026 08:59:29 -0700 (PDT)
X-Received: by 2002:a05:6214:20eb:b0:8f6:9379:ecb with SMTP id
 6a1803df08f44-8fd3b9b13b5mr81854656d6.26.1783526368570; Wed, 08 Jul 2026
 08:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
In-Reply-To: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:59:17 +0200
X-Gm-Features: AVVi8CeC7wqwD-02BFpq0hOApFiP2f8o6VkvQcjct29H4Ae_roSruiCfTUPVGNA
Message-ID: <CAPx+jO-BkzRPcuxkC4rCwGvXg8io_yD0Cx7zrwC6Sw6t5ff3SQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: imx93: Fix shared MIPI PHY resource management
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e73e1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=8AirrxEcAAAA:8 a=v9JiyUteCMCEH8Pa4FgA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfXxVnoe8VMojNv
 7rOs26xrg5k5RRU4mI4n4/yg8uuEaoNoc/l1fcKov/QI+aPF86s0AkpD0/3H7qQb6jZe+uBZc0w
 gJV8PrmoG3oNpfNiU1gx1b+GaU12/KI5rawJikahH21iYavhOYTPWM25pdViYyhwEPB2Y0MDjjM
 BIaGXceVXL4JY/PeKP8NuHke0cINDZrs+koFi7bN7CPdJJe7+oiFRFl0nLdtrF8Zom8n7D9ZO2q
 6RFmnXdYcpJNWW3+fHs47IsudTKutzlLUOzRrktpnHIIikBSmp4Al7ekGkgbI/qV+h+YHzu0yAA
 VGISf815eu8vouM7EtSUb0EooqhR/8y28WBS+aDmmvoZwHOj42GNVeoLU2chcqFahTX2wDyfow9
 7v3G3CRlpH1TiL6RPCDf6+30pJeqD5Zz6RL4zX/4QlvwX8eNCH5tmR5w92W0bUGEEsWZN+Uw7tI
 TO8X5HxwRlFq5faiP5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX+6hOzEqLgWUA
 86n6HYbDT5nwISa03cOUE3hUJ2AD60gnMd3Ja/UkHUixzixUOeSg5ovYFr8hXN6dpwMlmAs3VvX
 nAYqupWz7rJC8epwx+yLl8bRvjgxOR0=
X-Proofpoint-GUID: F9LSqV44mpaxz_gJSUUMqsIdTHwPRbwZ
X-Proofpoint-ORIG-GUID: F9LSqV44mpaxz_gJSUUMqsIdTHwPRbwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080157

On Tue, Jun 9, 2026 at 8:24=E2=80=AFAM Guoniu Zhou <guoniu.zhou@oss.nxp.com=
> wrote:
>
> The i.MX93 MIPI DSI and CSI domains share control bits for clock and
> reset in the media block controller. This creates a resource conflict
> where one domain can inadvertently disable shared resources while the
> other domain is still active, leading to system instability.
>
> This series fixes the issue by introducing a dedicated MIPI PHY power
> domain that owns the shared clock and reset control bits. The DSI and
> CSI domains are then made subdomains of this PHY domain, ensuring proper
> reference counting and preventing premature resource shutdown.
>
> Tested on i.MX93 EVK with concurrent DSI and CSI operations.
>
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

Both patches applied for fixes and by adding fixes/stable tag to
patch1 as well, thanks!

Kind regards
Uffe


> ---
> Guoniu Zhou (2):
>       dt-bindings: power: imx93: Add MIPI PHY power domain
>       pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI
>
>  drivers/pmdomain/imx/imx93-blk-ctrl.c       | 60 +++++++++++++++++++++++=
+++++-
>  include/dt-bindings/power/fsl,imx93-power.h |  1 +
>  2 files changed, 59 insertions(+), 2 deletions(-)
> ---
> base-commit: 3b7a18a34e8d3b14c7c926f033488a0350de9759
> change-id: 20260608-pm_imx93-6ccc1aa11932
>
> Best regards,
> --
> Guoniu Zhou <guoniu.zhou@oss.nxp.com>
>

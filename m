Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B51349CF0
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154605; cv=none; b=InriFvwA1W5fV4yAnk+9hml5YPaTpS6lwJwbn3K4HLbH+NciNCK9xeOAoFkoYCsjcXnY15dMd+sF3v9Uv2mN65VNM8Dyg87AL3/or1VrotHoinj+sUt/qJ+eQaU+DwkdxIcP5B2B1ZneujxU1OtOs2ixxO3dva9gdM4KA3By9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154605; c=relaxed/simple;
	bh=yLCTlYjQ+FZe7T4QOyiIwafK9RT2sSnHqhjwIWNBv5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aevaNbQXHqp1i3tL6UHZPY4UVkUtZEHr2CWNSVMWhEVjUj8vAPX8ylS/uRl0ntzKoXelAwjFL82vAbNasaX9I/wV2EX6xXIBUQEYV7+6UA/IrDdfZ7U6Mvuwg2oHt3YU9BCDrd6qw0SeS4ucTB2Egr1T9mWi7aYov92SYvLF5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJLvRqm9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXtLvRtl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJLvRqm9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXtLvRtl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V53MUd3028647
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=; b=aJLvRqm9PC3mG7fe
	ck4ElEh520bYaqJBHrhG3OvjOA5Za/oSLOpRhjytpgyicvJx1D9CY223qrNYoj6s
	IYLr4nGapQH3IfaQcH/66rjb43WtcoxbORB9Qj2BRxGhBwrX6fiVDAo2TxcA7q2P
	aqpzQLfRqgElUMTMc55BI3YIE55rjz2eIvU38I7Ki2nlbZgP6rYxk/UkJHmThcOq
	QwxRhEUoB9Bw+OLMzqIG7iMTLoQUyxCpG4tATybAhvecvVajf0lIfF4za48LzNAV
	fxN+REr0iyaYo1VnoyQHAtDqMP//WEX9a44H5CGlHsWhitEasGgmEHhgJPro3ERm
	xcpk+Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdvmq6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:36:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so3840457a12.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788154601; x=1788759401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=;
        b=MXtLvRtlI5QOpCAt2LJk7OiM0Z2f5RhwZn1uCeRYXJkrPRQidYt0VoalLRGjpxBjpk
         YBcVyV9o+X3NX93ExKk75mgekVOBvgrabvVDfQ455K3YF4ECiAb4gaPZPg8uMskL+Dfk
         nDZ5NkY62QO2RQjujX1nCATusAqzhUI+RTOoKPa+9nzeQ3ZXgujiuVfDtQQyKrzal+eJ
         J4yozM7ZGMh8KFEVGY4n1o/DMVX7gdn/HlisxPVdCFhrXJeuzdijRhSRDvubmTgWDI3K
         kiisW4UX4Kjf/0ldisja40L2LjrC4iebRwmtGf64cco3wLOIEbj2ZjV0hTNKozIQ49QZ
         UhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154601; x=1788759401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=;
        b=qGJy1YfB5exS4baMg7dt8srf6YoAgmEOTtX11qGPMl1iW9a97sdGumMliFMD7oeGKl
         CsA9T3aJk9aoJBk17IP+RkDITN2ou4tPXj1iVEl6ODXxMVinaqfq9aLCNND/ib8lk6/Z
         ZO6WGAb9k8MQPQdCr/WyDQL3QvijWWKV8CBXLo1omZAHQOYXY9okgxQ1sOptW2lhkN/O
         KEWEbWn2S1rAZsmwr5tjaRQVIJ3uYik0mXL6+8Nn/zkXwuXXYQOmLAaAOTN6xzaGPdZt
         g1yBIe/SNy+pYHV5kiKbz2PQNwlcWMlfiuf4fB6EQXmObc8dX5hK6oVNC161E8cnNV84
         l7hw==
X-Forwarded-Encrypted: i=1; AHgh+RoZFvIXZrKvzfC+kGPssf9NBQQM7vgnB56r3HSfVE8Ai4iungD85dbEp+tVucMbmdKRGSY5cQY=@vger.kernel.org
X-Gm-Message-State: AFuF++n7st7aV1yL2VB3Y8lxkFV5ZE4VobmTwpNd7Tsq6ZjAUOk1FA4S
	Fw49xwx0QA9/186HCxmGv0x44n9PESX4ORzHeZySroRUciMcoNVSHBHU2JNCYbCweHcjdCdtTqY
	ld1zJvotVq0DbMdPf745fmmHWNajGsc3biWqR9Jn/798/+/WH4ELdLbcXVrg=
X-Gm-Gg: AR+sD11D+PPSX39MOTclm4vihAvbdCEqBL6Qs1nmvxdCsFZ6PtnScWJjuYpv52LpIE9
	p7a5Ftc9IY1/1DwQs2WKMAbdTnKwdgPMAuHN7obImNUayiurRCG11NZVrsZ6eKfZWkxe+smiJ6N
	+eOON9YleVe1t2LEUqruKoBKwCYzbfEHy9JxGS3Ea8CUEQkRbbFVPY2mE+wtsoNcdjn8MnIJUkP
	/ZC6I1VJehjQGuA/f+JfcUKBrwlvuZdr52RvDE93Bx2yh/F57bh4/p5PI8PdJCGYlPPxbD5Q82S
	yGfdKFlMe+0Seq/CZO20nxUc8HManEF6SMLvH67eZrx7QqjeTLsAmG/lK0IKeYNGkUfq90+eUU6
	4mbUSmNoJDMrHVpcj7llYgvTWBI/Uv4hIzA==
X-Received: by 2002:a05:6a20:d0a1:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3d26562ead0mr38893836637.4.1788154601548;
        Sun, 30 Aug 2026 22:36:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:d0a1:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3d26562ead0mr38893780637.4.1788154601101;
        Sun, 30 Aug 2026 22:36:41 -0700 (PDT)
Received: from [10.92.202.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f552473sm29621422eec.0.2026.08.30.22.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 22:36:40 -0700 (PDT)
Message-ID: <d49788b9-a540-49e4-be1a-ac4a64ec1692@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:06:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Only check bridge nodes for PERST# GPIOs
To: Christopher Obbard <chris.obbard@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YBFpJ_PDFaGd_4scOeQo6zM_c1CDEmDB
X-Authority-Analysis: v=2.4 cv=P6EKQCAu c=1 sm=1 tr=0 ts=6a9512ea cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FrH2bHQ3JhTd-qtjZ9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX/JZvtkI/HCYj
 Q2BYdm7dlwdsGwOdZT+lcg1Bht/J3v4TWx0CWsAgQf4QcNEOr85EawPv1yKw7k6UyPQQxAJD1un
 ZN6Dd++C2iO4WQrlaLsaBczUBmXsqfYN1Z3MlPab2GwNc3qgv1J/2ZZRCWy+NhsK18mOS6DGep5
 uPf7NF7nH5Wilk9YNUAnZVnKy3/9qPojQTHGbsgQFB/E0Pb7rtqxKNPotfODVUxIXdCilnP1k86
 4XNohXiRpwHKa/fA5NPlk28aNS2k4TJBG+uS+t347CR1HydPw0wFqSzER3C4EkxYlCtn3I6KZf9
 2TlcCtTp0yazt2Z1rSuha3ODHnv5AlkvuVlfzPmW+WmnUsnscZ7ftNnpQLZQV1oS8InA5cWJwy7
 cwKMxO2esMqyjpBnwD1k8yjGnnTBA7PwicXXu/AkgW2uW/B8EyWurguFYqaa3eSNltdKZIBh0K4
 HGOG+Gk1D16WtDV5QKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX3y+TkS4B/sj4
 WVLsydox28M5hNn/VqZvSSiWqS70QF2uAssHYIQIXblRSNVJx8TFfgEDgFORdCn8MWKu18bfaaM
 AQK2Zc1WGmC/g6J25tq8wvWhdEAynXw=
X-Proofpoint-ORIG-GUID: YBFpJ_PDFaGd_4scOeQo6zM_c1CDEmDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310046



On 8/29/2026 4:06 PM, Christopher Obbard wrote:
> qcom_pcie_parse_perst() walks the PCIe hierarchy described in the device
> tree below its root port and collects the PERST# GPIOs from each bridge
> node so all PERST# lines can be driven in unison during controller
> bring-up, reset and power sequencing.
>
> However, the recursive device tree walk currently visits every available
> child node without checking that it is a PCI bridge. This allows the walk
> to leave the PCI hierarchy and collect reset lines from children of PCI
> enfpoitn nodes, where those reset lines belong to other drivers.
>
> This is reproducible on the Qualcomm RB3Gen2, where a Renesas uPD720201
> USB host controller sits behind a PCIe switch downstream port. A Genesys
> GL3590 USB hub connected to that controller is described as a child of
> the PCI endpoint:
>
> 	pcie@2,0 {
> 		device_type = "pci";
>
> 		usb-controller@0,0 {
> 			compatible = "pci1912,0014";
>
> 			hub@1 {
> 				compatible = "usb5e3,610";
> 				reset-gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
> 			};
> 		};
> 	};
>
> The USB controller is a PCI endpoint, and not a bridge, but the PERST#
> walk descends through it and incorrectly claims the hub's reset GPIO:
>
> 	$ gpioinfo
> 	line 162: unnamed output consumer=PERST#
>
> As a result, the onboard-usb-dev driver cannot acquire its reset GPIO
> during probe:
>
> 	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
> 	  error -EBUSY: failed to get reset GPIO
> 	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
> 	  probe with driver onboard-usb-dev failed with error -16
>
> The GPIO is also added to the root port's PERST# list and is asserted
> and deasserted as part of PCIe reset sequencing. On the RB3Gen2 this
> causes the USB hub to repeatedly re-enumerate:
>
> 	[  116.479598] hub 2-1:1.0: USB hub found
> 	[  116.488601] hub 2-1:1.0: USB hub found
> 	[  116.496971] hub 2-1:1.0: USB hub found
> 	...
>
> This disrupts the hub and devices connected to it.
>
> Restrict the recursive walk to children with device_type "pci", so
> PERST# GPIOs are collected only from PCI bridge nodes and the walk
> does not descend through endpoints.
>
> qocm_pcie_parse_ports() has made the same distinction since
> commit 45df22935bdc ("PCI: qcom: Restrict port parsing only to PCIe
> bridge child nodes"), but the PERST# walk added later did not carry over
> that check.
>
> This bug is distinct from commit 3edb3a038d42 ("PCI: qcom: Skip PERST#
> GPIOs provided by downstream PCIe devices"), which filters PERST# GPIOs
> based on their provider. Here the GPIO is provided by the SoC TLMM; the
> bug is that reset-gpios is consumed from a non-bridge node at all.
>
> Fixes: 2fd60a2edb83 ("PCI: qcom: Parse PERST# from all PCIe bridge nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com> -
Krishna Chaitanya.
> ---
> USB/Ethernet issue on RB3Gen2.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..89a476c37098 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1953,7 +1953,7 @@ static bool qcom_pcie_is_child_node(struct device *dev,
>  	return false;
>  }
>  
> -/* Parse PERST# from all nodes in depth first manner starting from @np */
> +/* Collect PERST# GPIOs from PCI bridge nodes depth-first, starting at @np */
>  static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>  				 struct qcom_pcie_port *port,
>  				 struct device_node *np)
> @@ -2019,6 +2019,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>  
>  parse_child_node:
>  	for_each_available_child_of_node_scoped(np, child) {
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
>  		ret = qcom_pcie_parse_perst(pcie, port, child);
>  		if (ret)
>  			return ret;
>
> ---
> base-commit: 570f7e331f5febb30f1384817463c7e42b65ca7d
> change-id: 20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-ef551ccc0a8d
>
> Best regards,
> --  
> Christopher Obbard <chris.obbard@oss.qualcomm.com>
>
>


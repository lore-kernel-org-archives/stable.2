Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EB25A2B5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571487; cv=none; b=DVES6DZNelugIdF8cOzY0PhwKllObLymbjH1MDid/69dHvb3/lnuzDk1ET58BB9AvpiGv0PPQA7JAtB0fZAlUUP+n6u82lQP3OfpXMJKkKpXO4Nqo+RxDVMd28td43HkpbryJW1twqt2mDYxT4LpNWtSXzlNgc47STZZPSXPrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571487; c=relaxed/simple;
	bh=V2izehxJHiz5lHOcnoDYAHcF/YhGu+nIUCvOKbDgH3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbMJNclUta/wMUCkDVXk4+E7xzDUGS1KbNHmWJ29psRNs4UoS4+5Zq2LQnhLp0sPtXpEVMSa5cKL97jAO4V4AGCx2KEE8lLJAubdYy8SsWdSMutD0ahJf8BB7jpb0/taPJWlnhpy6fWtk36XGA+3619RavR83GpLpwLl1Ib0bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7ge/V1F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Luhk3rd6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7ge/V1F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Luhk3rd6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0OPYl092150
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OiyIJgSEwfIFbV0JUiz7Djf4
	fEFq9snfYC04/f9wwkA=; b=c7ge/V1F+A+RO8G2+cW3mG52ytI1zAoYhxSqdq5L
	mgv5DprWep6Y51lqjW0owMchRhC2g45k7MZPsbkMlh0HouPwnQMDWwitCRqFKX+W
	WnIq0g33dKn7UQAi8UsZ+0dIE/INvcdMFEzbfIg710FU5/3ebRGETxvND4VCsvnc
	gU+wjIGLGw3mOKc7A874s0VLqb1XHHPA+oaVjOuMOJ/vZqetKovB3aWcrZKepK0z
	twphHXyrQAOXZHmJF7RE10r4VLEjl2UV0+pOhlgCr1Srz/fvIXdkGTs/XBQFR3dZ
	Jp6lAdo6/BRyV6wl2W1txsEDBe7LfBX4T2dJhtFvvtNyFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9840p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:58:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157ae36434so354258685a.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781571484; x=1782176284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiyIJgSEwfIFbV0JUiz7Djf4fEFq9snfYC04/f9wwkA=;
        b=Luhk3rd6Vi9qBXMKrZbKv9r91SZ4/0OvwFUYgr2QaxMPcuIqqpA9vErV8K7a2tzUDy
         gLY/ilB2y34IhvDF5fPdiMlFMqYNfMK9PPaayTYwBH/QaxKWRHkNYIaVhRMSeeF+NiuX
         NZaeD2xYqtyzFZNhWxR5JXwTthLqW1UzoJv6QKZ8UdDMMwMDoPQlEP8FWJb5rmXEAo7F
         ERYgrh8GLQ8CfQIutoSuadP4Ighvq754p/ptJ4cKLiio8dkAh6YDdpbUmBNx0/ae/+S9
         Wq/ecdhrDAFJZXi+uUVOFuwuhjPb6k5IbFPdPKW8+LZzD8sSfY2QDIYdEcul8dBziB0U
         P8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781571484; x=1782176284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiyIJgSEwfIFbV0JUiz7Djf4fEFq9snfYC04/f9wwkA=;
        b=p2eZklN7RIzveJH6kn7ahQ2e3qbc5alRk9Vrm1wgVlThNW9eHsimZyD9bcSpeGYgpW
         8VEPoQCcJzLtJGJdvo65GbSM/NCdoHzI7F1qpSaHmy96UMODS7rvQBowEgU4kNgbhSgX
         SDt+JO0hGaqd2gSMiv7zIPQCgy0Kf5Uaxt3WdAuM0jijDeruiHgieLaX7TMe1xpGX3yL
         jbE4p5YAbVZeAlwBm41q3b+VXKxWcZAkadJMxznCod1qOrWcmiO/zJHAmLoB22TThM6e
         8Ij/5vqaRgXE5MdB+3bOGK9ZQk1XLJ7Iap9AA2/GPBWF1KTFz/YYEF1AEFkFxVUsGuOs
         30XQ==
X-Forwarded-Encrypted: i=1; AFNElJ85enwvxLsqvau+Hh1Fa8KLY17vMaicA4GroRZoEQBnqtAZ7TUNW/2J2YtIPCCkGG4MCK2rd1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtaBsmhALEuvxKcYPoxh03XJCOeacmpkO+i5fBa2vyev/xsG5
	XZJT9H3jSVbAK04yKIcgwH64eMhj96e+oPhnc35VJMUXWmeJ9TFh0ZVTMjKr49U9FwdBl8q9hTH
	CPyW5lhU3yclosyV7IzBxXMTroPZDRGCZ7sJnlazEjeJ96hNJKDIe4s245UE=
X-Gm-Gg: Acq92OESFuJVUD3ACtn7xx3qxV+rN0dLiD9eeR7ggfNntaBhgbU2YvWovldiTYzXWly
	Ukew3SHjfqbjb0+booz1g4h6DGBDG1Y3dD76OGwHogh5RVPIGM6AVG9Hthk9N75VOHUz0dKOflf
	R0LcIT7darn6eh3h4vEIWbypKdih8Y0MDiNY3Vz/3qEtnnrrIVDGL5n4wV5Uho/thpnG5uymWbI
	huNeaoqDccat5II5VrgN5eKfmKwrqTRDnVGksNb5T6483HFwxWCfo0xzeLRv9i6Vz544W5PuQY+
	r7fIoozG8XFaAbr0JbzpGLqP+/g4Q1kWHq+QRJmGUV1NNd4gVVBsQLzWWQLMDiwUPGJvJUtLuiG
	Vw9AHfMO9zp0BiM9XfCBqXT9rbxgqSvFb7j7GCICYsrtHm4/gvu9uWu2iupAtqpxem4FJr5yP9l
	Lg3xz6+Xy449+D2aZANiOvZ/WnLs2osXMLUPY=
X-Received: by 2002:a05:620a:3185:b0:915:cb5c:7f70 with SMTP id af79cd13be357-917f0a8a62emr1951642785a.29.1781571484375;
        Mon, 15 Jun 2026 17:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:915:cb5c:7f70 with SMTP id af79cd13be357-917f0a8a62emr1951638485a.29.1781571483893;
        Mon, 15 Jun 2026 17:58:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a6fc0sm3153341e87.51.2026.06.15.17.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:58:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:57:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel J Blueman <daniel@quora.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: media: qcom,sm8550-iris: Allow IOVA
 reservation memory-region
Message-ID: <ipemz4xvo5yr4wmrkdepsglxtwa6cgbwayjgoxu5br44yix6w4@jxpc7hz6ugtn>
References: <20260614145113.84243-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614145113.84243-1-daniel@quora.org>
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a309f9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=t9ty7G3lAAAA:8 a=q59RblQhM_AjlM9mRcoA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: mvM2bw1WaqF-TeVcQtkNt4fTCUnngIxV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX9GY/t2KfFx54
 vhm/fGYX/ZfQ3Jl4KcF1gdhNkJXgPH9oU/cKkSrH0gI2S9Lq1LsL6lUmQvqmwF13C3JwIMzWTA5
 GZmLF6bpm0ZwqejkCZ5NEhSd26kV9Qs=
X-Proofpoint-ORIG-GUID: mvM2bw1WaqF-TeVcQtkNt4fTCUnngIxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX4WtIjrYS0a1l
 XCWa2IDzdqMQpAjL2lrNE8WrgetyeOQV95QZ95HI/yWCToD6XGribI2jpLIbGQhspbtzGcKkAg+
 MvBpwB2cRN9hNqUR8VnpV6z6xuR+d06QrwOP78nTTSL2i/+K3cXgjM2JBsucam2bQfR3YvSNcTM
 vRO7CBR0UTZQNa9MssfkKnSV5o3jis128tKpvsAea+cKQvGErtVsBNFx04XcLPRgt7o2wBZfkbe
 j8/7R77GSGa5dkAOtEyJMy8S8FJmP6UKh9aZIJrgGE5Q030JEk8kQbDgg3U5HfaMvlBSGenSBxv
 VYwGyLRpSB15lZVnmIxzPv1DZW/cidf1czyOSsv0p19a2AHVXjmdsBUC2kwf4hYBxkvqM6JVfsC
 NxszVWoUeZ7eZpAjsZXm45wU1nW51ySQJJemlmfflOUkjCY302Qu6Q7xebr7yr2SWDWH5QkOraO
 y0ZQPLCswkJsaA9/ROQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160006

On Sun, Jun 14, 2026 at 10:51:11PM +0800, Daniel J Blueman wrote:
> In addition to the firmware-loaded codec carveout, some Iris platforms
> need to declare an IOMMU IOVA reservation (a reserved-memory node with
> iommu-addresses) to keep DMA away from IOVA ranges that earlier
> firmware stages have already mapped through the SMMU.
> 
> Permit a second memory-region phandle for this purpose, and describe
> the meaning of each entry so the ordering is unambiguous.

With no driver changes?

> 
> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---
> v2:
> - drop redundant maxItems, keeping the items descriptions (Rob)
> - add Fixes tag and Cc stable for the backport dependency
> v1: https://lore.kernel.org/lkml/20260601041336.9497-1-daniel@quora.org/
> 
>  .../devicetree/bindings/media/qcom,sm8550-iris.yaml          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> index 9c4b760508b5..5abcaee4101c 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> @@ -80,7 +80,10 @@ properties:
>    dma-coherent: true
>  
>    memory-region:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Firmware-loaded codec carveout
> +      - description: IOMMU IOVA reservation region
>  
>    operating-points-v2: true
>  
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53507421259
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006313; cv=none; b=kMSJ9tuR5Zhnxx/N0TsrPhO+MyZuwI2dBBLrJyrKG7LOGB1ymlO9PuP5TyiS8ggS5IGVtMbczswHcho/bK5GcAHO6W+dn3AsXxju1tVbazssUadzeuqjocURk4old2aqEkYUelnQxmTzuWfjfDH4go8NttrH3ZtiKoNj3o4mjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006313; c=relaxed/simple;
	bh=QbxYReKrQs6OGh/asaTfb7InLjzlwDhN8Zb0dIA3wNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxO+VPA0ZaYDM4NfvpLu1/c5blTtQVFGDYTjV/cpezVp+bK4wwqj2n1rDjiRguYdC3Lsk7xubIApM0VW+kgLHaD6gZg/SfiV0QfbQnnq1sXJ0/q0SnBGYxFlkg6mRWGFHce1tx6SWQDx47P7NOS7RFbIy/XTmYdrrONY01INxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCzfZvzz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EaBayJgs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCzfZvzz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaBayJgs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763x6OK483313
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 08:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W+XMHQAvtIU17ecZnl8EGWY4
	1gVH1HAt7t3DXxrY2Rs=; b=kCzfZvzzd860lKnF7/6UyolUIiMaPEW7D1L6sApZ
	ef9uagVFuvZBB6077wIvsXGLPbMJUPQkMU+64XEi+tc/9VYt98f+M7QtPgAZhxj0
	xSPO2XFRJZt3DuAmv4TtO/v3n3Xon+0wyL57bmP0Qo2hPBmJI4kKsxAKDVD1HH3Q
	ooDLSmHL+kazckAZbDEdruxBO4gQIIlw9toDQkfEUo/EnqEc6eM7czDmYZ+F5Vue
	CJ7u0i1W5P1xFwk3yMZ7nh2lQZEgtCgJkkeYL/FbMdUNsae+ddhqlgiVueEJJjvz
	cP4waK5U6ACPj2VhRUaui1WKRM5cm0893cNQxZFKV01bbg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjueh4e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:51:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bec738909so18128281cf.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786006307; x=1786611107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+XMHQAvtIU17ecZnl8EGWY41gVH1HAt7t3DXxrY2Rs=;
        b=EaBayJgsan5vldgtScW4B4Z3XCwkr+JuILRGVyb63XgjYAhd8/llZIt6oO+FuRiCyY
         ZovNE+h7s/9NgZ8rKH11tQtyVShxCTch5ih/Ws67xXkwrIpiyPjKk7t/LrOtuUyuB1rj
         RZVs9GSBbgWtobG5kjKGK4GmRkvkhaTNyKDwXEBNogiIbiQNgBOlALGh09CFm3oyGgLM
         T/2+ghY2UKEiiqgd6lZQmYJsZ2nwIsSQO8cm+3O5r5ngP747fifNzQip6cJU37CoJA4o
         jtQsjjwJXck336i23Gf1mJ18BuyRYBI84odBcj6ghuAUtUXe9vdTOvwsBB+A5c27XYVr
         jZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006307; x=1786611107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+XMHQAvtIU17ecZnl8EGWY41gVH1HAt7t3DXxrY2Rs=;
        b=jdBtg0LN1jiLUSCNGKmtb1/0KZ0xVn76HRa1WNyomlam+N+ulAhvkVmeGU8ntqieKa
         YC4nKVVH+/m0H8valhth5bwdSbicVwMlyyty2e1NNGERyuk95IYBuU4wewMVyyX/JNA+
         hwSIQSzLcurZow/CdytebWpDjg0Wcvba/QO7jn7/244yQGwrBsn7LieGRg9E/vMshR8X
         aEg6npMU4J1s7UJP+OsFqwj81oVdMsOZf42lIpTsoYb53KS3Q2mcDfA302ptC9wsUpAc
         ByKj8/bNcnZss3TAhjh20B2sNtOKz6mS8a56xdcepP88B6SoJmbgoCkSg13w2z0f+fPU
         D5iA==
X-Forwarded-Encrypted: i=1; AHgh+RrW8ezcYP1ldVfMy0B5X1BJxaQPZb6FjkhxDzJY9iXtP3jAqCWiddSKFKPBhSHt6vXO0ENj2eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3m2WNUnqczBiFvTa4pDdIXwKAskzwZDG8/7iO6tK3zW+codXm
	KnOZq5LWiUI4t0kpCWZ1xXUBcXiltgstqnk+lkKwpmMaDQPa2AmGuJoDqr3cvp4QQdxWk/j4diq
	NrHf53SiYVnC3Zk9QiGoRSI3lOED2Bzpa6iGS08A3Al3sezMS6wo6IYL3yfk=
X-Gm-Gg: AR+sD13xATQshddROXK27E43sGgfd1WsOhZBc39Izx1AY+IBJ6U+K/5QCtPJeJPFuRM
	MRSU5RC8qt2sGvm8otw3UYJfMyoH35/5mztPAcb5PmIl+7boFp/yelTvXXvpJMcoKZI+WQS/+0T
	eJkNbQghaLcUOzKeI/qPSYRSPj3zQbDMzkJI3NB382YtO5Ji2ZDyu/sYFUAats6t9LXH8UGR/9H
	zpE8hKirCfl0kTHzQQVRmCoZQGPfZMdS+PD3V0hEd8VZPs+/p/HQ6DCc8hFyygPXIjIFg4WVumP
	REkfFisbntavqyFgIjfbJQTOmOH92NFeFokHbDL5D+pCgLEfB7O2cU7nrT1Dxr7Mlq41WyqGIe+
	8Dg+YDotZ25B1m4RSJOQq5GhiDSZ4e4mHmibj06HSFUREpdzbjVV0JoinE43AnAxHHPK2WqzgFC
	YJsRhVQaa814ZMnA==
X-Received: by 2002:a05:622a:c8c:b0:51c:19af:6341 with SMTP id d75a77b69052e-52ce61d2d25mr137690451cf.36.1786006306750;
        Thu, 06 Aug 2026 01:51:46 -0700 (PDT)
X-Received: by 2002:a05:622a:c8c:b0:51c:19af:6341 with SMTP id d75a77b69052e-52ce61d2d25mr137689901cf.36.1786006306256;
        Thu, 06 Aug 2026 01:51:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f6236405sm598907e87.6.2026.08.06.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:51:44 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:51:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Daniel J Blueman <daniel@quora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bod@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 02/12] dt-bindings: media: qcom,sm8550-iris: Add
 context bank subnodes
Message-ID: <mbmibfbkba35xdytj7ukreqku5jwwbvfwqll2yv2vhy4ebnaf6@ntlhflnfznea>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>
 <178553021128.1745605.17032924779293673178.robh@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178553021128.1745605.17032924779293673178.robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a744b23 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: vui0Ht6R_hyY66wSML7C0TwsIi28Cx5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2OCBTYWx0ZWRfX9i5Iy8sXkIFb
 7YBgpPGlFE7yoODAzuwDzVBWtt/Yi3XZuwfRGQyaSmvHjR9pjxHFNhhAlqS/TJVkgX96B95EuTI
 +P32apMPimh7aSTZfUBjO6QQ6Mr8GnFmzKmHobr+rv+zKaHgQcsm4UPkHO1vMhGUk4B0l1E9Pg+
 HmWRvG3q1PGz2ObLIIlyU9z1Au/Y6/I//Q46CWxPHsQFU5THPpc649vKNYO7Wk0EFtUoZNb2sIW
 6k4twkFV90ykBajHGA7ReXwt8apu1y1zZdPJk9MqwEL1oQadcKzj4hUeKRKFj8w94cgAplZ6Tti
 DpL0t4Bj9PmIKp9LWtVzPCkEq+S9xL+Pk1Ork7bYbvSd11czOCfomA4I9g4kHir0Qtk0m8iCviT
 PoMUhn7nDBFY5XQ4oz9xB8bvFypmOPywiPcHEL8aLnrpuV1bwTX8CJXl+0xiI/hxX9OHNmjvaGP
 GOKbiBNgRNV/y8I86Pg==
X-Proofpoint-ORIG-GUID: vui0Ht6R_hyY66wSML7C0TwsIi28Cx5o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2OCBTYWx0ZWRfX+Kkb9mzYVVi8
 aCT1DqfTq0l5WOiJkdXHMth5aLbFYZXFYnoqMZZp7XuntZlE0xmWDPWJcspyauW9dHppjOhqdC/
 sEZYQfbv/FA6vUPMqVwfSUa26ZnU1iA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060068

On Fri, Jul 31, 2026 at 03:36:51PM -0500, Rob Herring (Arm) wrote:
> On Fri, 31 Jul 2026 23:52:17 +0530, Vikash Garodia wrote:
> > The VPU issues DMA through several SMMU streams, and the hardware does
> > not give every stream the same addressable range. The non-pixel stream
> > is restricted to use 0-600MB of IOVA space, while the pixel stream can
> > address the full range:
> > 
> > Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > Tested-by: Daniel J Blueman <daniel@quora.org>
> > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/media/qcom,sm8550-iris.yaml    | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/media/qcom,sm8550-iris.example.dts:67.13-24: Warning (dma_ranges_format): /example-0/video-codec@aa00000:dma-ranges: empty "dma-ranges" property but its #address-cells (2) differs from /example-0 (1)
> Documentation/devicetree/bindings/media/qcom,sm8550-iris.example.dts:67.13-24: Warning (dma_ranges_format): /example-0/video-codec@aa00000:dma-ranges: empty "dma-ranges" property but its #size-cells (2) differs from /example-0 (1)

Vikash, you promised to verify the examples. What has happened?

Also, does it make any sense to you? The device in the example has
32-bit addressing, now you state that _subdevices_ have 64-bit
addressing. Why? How are those 64 bits mapped to the parent 32 bits?

> 
> doc reference errors (make refcheckdocs):
> 

-- 
With best wishes
Dmitry

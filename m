Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABC448BAB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012711; cv=none; b=peu+N+NegVrHWYAFz14tqYLt7kVogyzJ4oPUtl6mzH6Cweh/7d4dRa3A1AuYNoxelp4IoEe/IbBOvUzMPq9P0ioaMXsb4qVHP0J8cypVCit+WPABRVetsHRXp/9dtYcrkngQIeInD82DIG/pP5N6Ex+MkTimNgmQzf/J15ur+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012711; c=relaxed/simple;
	bh=EfVGIjWSN87W11NoJvTgUTrEfh6vgW7726CLFeRaEoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRD7epsj4LYGKvbAW1CXZbmgyI/G7ei9WHd+UmeEf1dMd+Damq5wrbN5fKwhpsX441qEZnFBKBG7xLJpX6DkQds1zo6w8pK6OH7rzYemrcVa+buCi8ErafqF7bdZxgsnDGgp12RqOWbCNUvBa1VZlG/VYaMoJ9oOE36UQMh/fV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJlALQf3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XD0m2FXN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJlALQf3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD0m2FXN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nqjc1876708
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 10:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Gu5kFTr5+lhKb/yBXlYjBt6e
	HzTbtjAXsXG5M2tBKsQ=; b=EJlALQf3o9GjK6BRzWQt0SITOIhLN0U6TVK+IfQw
	+UPyASyprE4ROHi9owo5E6Q22GxQlz8sRkQytrj6b7ztJ9zzoadsMGrZ8MbQFrQI
	p4i+ks8Rwjxe9U/+8QBF0UILT2T0f14qwmhRzTRg55cRxYQeJdpQaliiOsf2ncyR
	mtnEd443/8YV8AlViwKD5X8a2gIkDHfcqXBEEO2IpKOeS9iE1xo38kx1PKm/4rti
	o5LTXMhj2SjrwMLP1XGLag1Cap7Xcjcedlz75+CJqYPoyphMR4OyntWenm2IFTY4
	6YW5ig9GAVIQJd04JiplnFPHRZkASv1HnKhjT8nKghRXXg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuchkqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 10:38:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce64c41efso33696921cf.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786012707; x=1786617507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gu5kFTr5+lhKb/yBXlYjBt6eHzTbtjAXsXG5M2tBKsQ=;
        b=XD0m2FXN5TKy7XQeS7Y/4hliZmg0EqL/TRFaYZSd9e0Lt2N+VTdoxL0E6xjZaPsSvf
         N8I9LeXwM8Llwlg0OOSSZ+PRdNQc0chKtzhfSIBaJYgh4BXOpqFG293Tt1DqaULnlNEQ
         fGgLIsiPf9LvCcf5FfAlSr2a7otHWVBAWA4AQOKvxEiGbt2mifeTwts19m69XesjkeUQ
         M2NsFRs+FcDqZz7oFdarZh8iZgGS3ckyGXcY0CFZ0pDrR1/ikDC07MwQawUtKdJfCpzz
         DmJZ9QutGp7Qa4oEOUOhNRmRm3t1hMc3xnE2vbWjMBC8Sm2U8TzunHiIP9obYs6KimKR
         i+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012707; x=1786617507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu5kFTr5+lhKb/yBXlYjBt6eHzTbtjAXsXG5M2tBKsQ=;
        b=or4UXO7qoFhyb+/b9A+qn3Hn5OOARgc2J1mCIWCH6rdKSJ7/Sv+if35AgkaAmT3fiu
         1jJQmFkKMNFoaW6zEk8nD86k/lCCmawaw+JjmZWY56n9lAa7NaomNZxti/Uv5poQuZUl
         rZ5AXSPZ/ImvZq59RJGnuPXzvKkZ9Lqf9Yd6mtujkO5sTnqHGDM9b3Z2BKctirXLeF06
         DY/QytHHv93MECavYmgu37+lT4jcxTUUAQDn0PhaXVI5qzSxFfyqoz1ib6Xke/2nABvY
         JSI3aF0TLEwbUG8keSMJ/aWaPpC02KhmgUIBjWscbeuJjOuqKFoFBF5sVZi18LpdKPFF
         zH4w==
X-Forwarded-Encrypted: i=1; AHgh+RqcIBc6nIRnAPkiN5Cp4tLo5jF7XAaezGH2UXOMyLHK2qpP+tovvrIXBGXiKb8cm/WRYuj8aq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxsPLF4E0hVEH03ntDghBfI6vxJgrp9PjYJkMCzaar4JS5Tmd
	X5NLh5xxLmLMygM+/0vn4gWTm0wubCQIYxf6zytLQBFFWPD5bCDSMYKd+v+EQTaYvzix/+c6+sE
	pjqPnZyf3FIzn+Y4FQONAYsE+ln2L7K97bfjikJGsrLt3WK8wDFGKQLCkhXo=
X-Gm-Gg: AR+sD13xZ6l9wRd/j7e4Hs18a3aesvbE8AQdAnWBh1PffLOlmkXwT4zPxvkvPqkT01e
	bpt9NfExdduGZokB3ZaptRR5zOTGm6g26+KjiRR7TyhLM7Z+ccrN//2uaebITbv/MBt5Wyax67G
	gyG+h9WjYpl2EZexx7di6MISlmbVakQWxRUQWjiZnLoQO/6bm/LXxwOLD1t1+86z62AGiOjnhFC
	xqqRd19KAnIFM/1xwMwJXqXiDwwj8+hFyjl5lQonKSSL82/k42C/e5AGbESWYBmWYyR3p6N0hgC
	BVfABziRXJDKIYFp75HJ+kIsPFsPU9aEIxhrrT8WJkTre78OWfosVUkX8MapZxhJnKRhCm6ZKbR
	74LgGxUwiPFzLnRk5rFe2L/sZPQFVsOYUyzarSkrHCmQV6w21kw2skl2VjLIMfn5LjmX2n8TMP2
	HR6qeSsGLZqtktEg==
X-Received: by 2002:ac8:5d16:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52ce6180b12mr110351891cf.28.1786012707266;
        Thu, 06 Aug 2026 03:38:27 -0700 (PDT)
X-Received: by 2002:ac8:5d16:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52ce6180b12mr110351381cf.28.1786012706837;
        Thu, 06 Aug 2026 03:38:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f62c50c8sm635416e87.75.2026.08.06.03.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:38:25 -0700 (PDT)
Date: Thu, 6 Aug 2026 13:38:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context
 bank subnodes to common schema
Message-ID: <uk7doek3x7km365i2nbu6yr672ywrwqm5czggugji6fudwmgt7@skaynqddkoqc>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <xusr4efn5dmsvcs2hl5vg3t7ctqbbchnbdx3mx6km5s7s3se23@mzzqs54lp46l>
 <d6207874-630f-445d-8d1d-3a30ba8f41dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6207874-630f-445d-8d1d-3a30ba8f41dd@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MyBTYWx0ZWRfX6KcQsDMukHmg
 KsTzGy2zUHe9Pb9QtAY10G3jPEnql8eKAgFjB+0Hjqz3Wstzrk6miBwB93e4Udo1ousaWSF24Sc
 1TR89vClBn5646tdIq9TsQ0CKMj2LUo=
X-Proofpoint-GUID: usqAud8hJyRmgN5mxRpeoTZdShoefXQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MyBTYWx0ZWRfXzfgh7834KE3Q
 6hUvUJOA7t4AYFZBo11oZ3cZ2kAE15JdMpW6OhLRH8uBUaDx7yC90lfIF96U+Yd00DINuRpaDN1
 6ctUB6EpYuBt2GsXooUCcVnCb7PWPHYVz+BeYo/EpY8PXQVKUxxs0YBCPVBbxKLaXwXJUPv3iEL
 f/vJrQoWzvPN8WiQBhdapTBWq0DeGL33WZsDa0d8kZV6dvedULF2MZRtqSZzIVObxhO8qpXiYZ8
 DbyuCOTYDIs8UfKHrPuXFjFu53IjqTRDlAsZ1F4o5SLTiunucspayQbRLWFc3GLWHTHfFU6jmm/
 +xxlitSIlKaJPDlt4stuWlgtqZQIWkNCfSLo7b9/n1ID97xlQbUlvlRafGjtoLPE9hUOzlJbgMJ
 COw8vF8GFBJS3Dgn3JWdob7kJFTPRvuFDjcP4UF2d5gRoHJ0iNBHIY+irn5iKqfPUKkN/hW56gi
 YNRvZaTH+UOe3+QeC4g==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a746423 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=yy27Je0FNM-02PBfZ1YA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: usqAud8hJyRmgN5mxRpeoTZdShoefXQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060083

On Thu, Aug 06, 2026 at 03:22:26PM +0530, Vikash Garodia wrote:
> 
> 
> On 8/6/2026 2:19 PM, Dmitry Baryshkov wrote:
> > On Fri, Jul 31, 2026 at 11:52:16PM +0530, Vikash Garodia wrote:
> > > The VPU issues DMA through several SMMU streams, and the hardware does
> > > not give every stream the same addressable range. The non-pixel stream
> > > is restricted to use 0-600MB of IOVA space, while the pixel stream can
> > > address the full range:
> > >      +-----------------------------------------------------------+
> > >      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
> > >      | 0x25800000 - 0xe0000000                                   |
> > >      +-----------------------------------------------------------+
> > >      | pixel stream addressable range (0 - 3.5 GB)               |
> > >      | 0x00000000 - 0xe0000000                                   |
> > >      +-----------------------------------------------------------+
> > > A single "iommus" property on the video-codec node puts every stream in
> > > one IOMMU domain sharing one IOVA allocator, so nothing keeps a
> > > non-pixel buffer inside the low 600 MB. Once an allocation lands below
> > > that boundary the hardware faults, which shows up as unhandled SMMU page
> > > faults and spontaneous reboots:
> > > https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> > > 
> > > +  dma-ranges: true
> > > +
> > > +  '#address-cells':
> > > +    const: 2
> > > +
> > > +  '#size-cells':
> > > +    const: 2
> > 
> > This would conflict with the 32-bit addressed Venus nodes (and it will
> > also break examples). So both should be just 'true'
> 
> With "true", i see following comment from sashiko (when ran locally)
> 
> Without a const constraint, a device tree could specify #address-cells = <1>
> or a non-empty dma-ranges, and it would silently pass schema validation. The
> DT bindings guidelines also recommend that cell-count properties have a
> const constraint matching the hardware.

We have 32-bit hardware. Also, as you've seen, having only const:2 here
breaks DT examples.

-- 
With best wishes
Dmitry

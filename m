Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841F46EF87
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546302; cv=none; b=swIKcft2h0lNrpzAL3jJiLYt0IO1n6E6y34bWsrauqF0rkL9m/0VU+9Ghn1L/kRzPneYSeIyApbAAogCvzFTBihVrIaljW6lvxFYmGvLchCizEwjo2aD4udDa60nzxOq2OogtY+rramD6p/XUx70jYQQA0km3c56FiqjgW64aCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546302; c=relaxed/simple;
	bh=0s75eyo128mLOVCAI49BPJzYb9KlJ/X6EQ4npup68RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPSRgYsEYC+slQjqVbDCC7b9TgWPttDu4lSx/6xb0BrBHBNVQtkPaKZSg4HCqpURoXgGKescyd8J8gcaIq6QXQJ/ZRNcExELFmV14hEOG1bXLTOBir0USdswiv5HodvPY+p86oq8/TrkW1ffH3+lqlIqNJnd7RnV3QZ6bn/K8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HXh0hA7r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CpKFOalV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HXh0hA7r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpKFOalV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G68w2a589917
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qpm1Y3oPylT9mPyiaTSpCsYjZSngMuRFhlOFNhAdSd4=; b=HXh0hA7r22EdB51x
	HBzQmHfdilLBR2bUySnZ4aUG73RqGL0Xnhr62ieqyhMnGOdXNfyrs+vXdJ4vCDjM
	kEX0gQs8qNfEtJkEd18zIKDUYmm7YBqPMB87ufJihPeJi6Gb9/QSF0gGYVyy6N9j
	UQJDoWEhR1O2fCh1ZF3oCkdGhH9FaD2XzCA56liEN/O5fXZaMDfAxyAnlX+ABOHM
	W3kSSJ/dMLZrRpQsLJprlCgxOpkQuYNCGa1r0GogSK/ncIbvLQLVGtohFYsLU2p9
	CH18Q3oiqPgqst4MFbOHCMgLX0z6t3mqJwWciPPQEMYSIOmvcJwMjAZ87uHQI0/A
	ovpQ4Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqe1ra69c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:11:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934a8cd3a8bso112722485a.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789546294; x=1790151094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qpm1Y3oPylT9mPyiaTSpCsYjZSngMuRFhlOFNhAdSd4=;
        b=CpKFOalVn5JqB+1blPasrrUDIxhePw391qKKietZu/einpfVrYKwIy2DRCT1CySS3F
         uqQWIlOWDA9654WtmwXBHMp7w6+wIhbks81qHrQNEJUIdx6jtvFa2G4mvXsTG1S+/Tot
         m2yNs4g+I1ZQote2DZAasbMBUhfXFFf7qFZ7WHpN8RzdbMcP9An4Yy2EOHjBIvL+g0DE
         Gg81CvxE7LGH/IKazZ0lAcW8JIIGuFDPwtV0utiFKP+sWXr6nLK7/IvugxJVXOS7SKRE
         DcM+flMv8gEuW8l5T3so2lIipksCTO3aFf0MCcBmjalVXVWodGTkfBMIV+Isoze8y7mk
         dKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789546294; x=1790151094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qpm1Y3oPylT9mPyiaTSpCsYjZSngMuRFhlOFNhAdSd4=;
        b=gB59bHPUhSuPGOlpJ1SoX5F/hF5Tgt8ZTfk47RNWiEQF18Li0XfvrQODT1NELTvRzh
         C6m54ey5q6P45BHkI9o2jzkmsTjgKB6ps3FntCjwiYFncZ525ITuPGN8TYG+22KgbEB7
         oi6QXYiohPUTkgxpOgz1lSD1xaQ/C/WBqHgt422qlSL4Wg7+l755ApGhQRWKX/d6cCdf
         Hmx6yNNPWJuBS5vdXk7ygoZLfpVFzPQAV8gAlPF0FzlrOc1E5Fy4B4IYWC6qAnvyHu8q
         74vXUpxQsTiCaut+T0C5ApAjuCMhdFJ1gMJ7+Vikw53OcjLS9O37d//HaBsy7Bu7eGQE
         Oa2w==
X-Forwarded-Encrypted: i=1; AKwUvByl/w20J1xFhXjjWfWM7Cu1j6noD/T6V9kTVtnRGtmYQWIYNkPli6Qas6vyQRxjyouu38Kg//c=@vger.kernel.org
X-Gm-Message-State: AFuF++kcbXHSJzBSr/IzQiBVntG3DpwXdOkDi+3RlfNEQzemB80DBBaz
	Sq3SL/Hgl0oa2L7mKbLIDOcsJK21/63QggP5YORhDxnL7A4/C6eJtHHTf7vxEPOoEsktlH30tAZ
	37mJmooF0DZOsJe9SSE2vAWK25MNmoybkOg0x6iOAxfPq19Jd5lFKM4cvqMw=
X-Gm-Gg: AYBFou0/eNy29ShUu6xyGOtE/Cjn2qnV5lIc+L8yhl/dpMHI7GO8OBGObASuBqnx2aW
	fcxZCb04mx/oYLLgYvqCrqfgcHHg9he8SZ44LPfRWliycb1F0OZ1IxKYgUrn1FLjwNnYNTrTXJ6
	O1R9NnK66jW/xe8jZ8c7+nKFGrANqnR2DyTZHmCA/OJEP2fx2VjBZq6A8YORRHHBTfDXh7QVcqw
	DhCKNe4lPXs2q9Xhs5M3PThVqY3fctlOM7ihBWTU/tDOTcjE6M290n4MIesDoCKX2UCZeuQaWJu
	/bf0ys9e8oIWEVc/oueL9OWi7td70OmkB9q6GWzWSBvfsFz2ftDGB4MmVG3yg9/SC87KzMhvCvl
	FgGXuvvIIyJ6+mVZggenVBw==
X-Received: by 2002:a05:620a:3727:b0:939:c6ab:e3f3 with SMTP id af79cd13be357-93bb78876e4mr210986485a.3.1789546294474;
        Wed, 16 Sep 2026 01:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:3727:b0:939:c6ab:e3f3 with SMTP id af79cd13be357-93bb78876e4mr210982885a.3.1789546293875;
        Wed, 16 Sep 2026 01:11:33 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d25e331sm1067522a12.17.2026.09.16.01.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 01:11:33 -0700 (PDT)
Message-ID: <911484ca-b1cc-4ab0-9fb9-2360ec33fb65@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:11:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0766/1376] arm64: dts: qcom: sc8180x: Fix the PCIe
 iommu-map entries
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20260912065607.535295758@linuxfoundation.org>
 <20260912065624.612877788@linuxfoundation.org>
 <cc43fb43-b6cd-4d60-b077-5fdf7918cf8a@oracle.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cc43fb43-b6cd-4d60-b077-5fdf7918cf8a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEwNSBTYWx0ZWRfX7GtUk3ZoknQp
 Bh8Xnx7s0yQWLW6LRJJ1ugUCCr9BVsc8VzSkhd3uNLZ5Scd5bIXDBiPlN6oeHSJCCB4dOM13d/8
 ouAyXFAO+Sn8aSxI8ButMtd84sApMfI=
X-Proofpoint-GUID: Ntot9FCNjc0zPNa57cZnYDCDXFghPXrw
X-Proofpoint-ORIG-GUID: Ntot9FCNjc0zPNa57cZnYDCDXFghPXrw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEwNSBTYWx0ZWRfX+VceFQNcaTDf
 w0xeqE9lGfgiqDbzD4+U9WFWX+AxY8PzO7KiGmvSUv8/jz1oM/3g6/nNIW9UzMuPgxuxDsr7rii
 Er6jGkEoYeZ5O011a/jylkvRU+PQPx1KiKs0hm0V/8GcLJrHLdbZJLKxrRiX7Zu2LRtKxuHTnjU
 zlX5pU7EZFxJzJLoE1LP5fZvjluAqpcY02OCidhlUDf3pItTpShFIADLZbkUGgbqZjtEHo1dan8
 H7Afr17Sj6EKWnKnTZQrXs45vpl6GD2/c6rEJiQJC0vfEMqV+GAo+9ZU162e3ky3Vbn0ZNkiahs
 IxRXDcNM1Ulhr9K3REToJoEd4y7oejKXWMaD/kKGbBtoqCju4X+cX97LkediBy4aVBW4WfGCZj5
 22sc1Ce8zTvuUF7A8wGXbGaXjG9nOxlVbs2usi7s34O9953Q9d2DvzIHHHFkoZqhYodhm2r2vW1
 q9jPACYgnvxQxLExM+A==
X-Authority-Analysis: v=2.4 cv=ZIhCCn7b c=1 sm=1 tr=0 ts=6aaa4f37 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Pn9D9zQKb93tNRXYLLgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160105

On 9/16/26 9:45 AM, Harshit Mogalapalli wrote:
> 
> 
> On 12/09/26 12:23 pm, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>
>> [ Upstream commit a4548204821a56c23cd711cfad2a637ca055ff47 ]
>>
>> The IOMMU provider apps_smmu uses '#iommu-cells = <2>', but the PCIe
>> iommu-map entries specify only one cell for the SID, omitting the SID
>> mask. This went unnoticed until the OF core started warning with commit
>> ccb2fd725d41 ("of: Respect #{iommu,msi}-cells in maps"):
>>
>>    iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output
>>
>> So fix the entries to match the provider's '#iommu-cells' property.
>>
>> Fixes: d20b6c84f56a ("arm64: dts: qcom: sc8180x: Add PCIe instances")
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Link: https://lore.kernel.org/r/20260730-iommu-map-fix-v1-4-83405d37ba41@oss.qualcomm.com
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> 
> Hi Greg/Sasha,
> 
> I ran an AI-assisted backport review, and I have verified the report. It
> looks valid to me.
> 
> The corrected SC8180x properties contain two five-cell iommu-map
> entries, but 6.12's of_map_id() accepts only fixed four-cell entries.
> Each 40-byte property fails the 16-byte divisibility check and returns
> EINVAL before any requester-ID mapping. The PCI setup path can continue
> without the intended IOMMU configuration.
> 
> Upstream has the variable-cell parser and its API preparation series,
> including ccb2fd725d411265df8f7ce12a66c226b16014e6. That broad series is
> absent here.
> 
> Maybe we should this isolated DTS patch. Thoughts?

Yes, all changes of this kind (conveniently similarly named and IIRC
they all got merged in one go) should be dropped from the trees that
don't have the parser change

Konrad

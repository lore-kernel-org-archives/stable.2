Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51051453A3C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983445; cv=none; b=q3R/X+KdNcb7JJE5/uQl0dXKmgVEOe0qDKVlbbz3jd45Vq3Jtu24csB+iquRWJFOfn0rhyw8HZub0QrXPrqKa9OVpAfSiZ6p+w+Yzk5mPsiOAvldjbAGSbMi1A2Y+Lyv2SmenKtWFcvZb17Iy2HC8dUOx8FlDhNYWDn/vRDsScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983445; c=relaxed/simple;
	bh=9QHUVdaZzK3zrT28M0Ibcx7qsEa1FTGQyIxXNBbPGMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=akhS6Fqda5WPnsD1rH9xQG3oI6B0jqTzerb0iQO3sFzdoFUzf7RbxOynJH/QkmNIs8WlEKXw10XzA83xXWPMOQyxUIkQINCZj85n+fui3GlBS+5THDQNJKnEDwzZ2HXPTjCKeJ7W76YU8g7xhJVsNF05xQpRn2/jv0d9O+sgGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7kJxAmc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evycv05Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7kJxAmc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evycv05Z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A0WO607143
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8uI9/fWCr9BWQafylmcrF08x1jWqCPZOKku91jDtxmI=; b=b7kJxAmc+KE9pU1p
	d9vJQPjR2TQWl03UCJWxRR2UG0csKCwPDyoF4anJsPiPKEjS+rE1FnvVhP78Mt2q
	gJPmb4/oVckzGXjav+CzogBn2nlNeS1oxvaCzXWUL/+OsLrvg4KpYzqgpMR7D/2B
	OAeX97wV0ZijJFIYqaNoavcafCPKHxUV+ejMSocLmQBFfwonJp0EzoOBA3eBUoXc
	UHt5AOWbtZDB5/BNMGM93mN9dXBmLrxh4bBJQhDsc+Lsi0fr/9HUmHbX1AC3d/Hu
	WsWIo2hTaugay1qERW6PBGznCsD7m1aESCJxkamIdxh0E0gyIuWz9r4e0N+Cr0Pz
	4I8V7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehmsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:37:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53002215979so3797931cf.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983442; x=1790588242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8uI9/fWCr9BWQafylmcrF08x1jWqCPZOKku91jDtxmI=;
        b=evycv05ZfT1wihKwAM/lKCi736Qq6Z9dCgrwkXxMEoaD09oZHe87HiH41Z1QFMqb5m
         f65jowgWqzCh/Udre+mdg6eOfk/eiSzr+j+YbTYKFoFkiXAmQCCOsNoJ+vXK545vuxKl
         mpHGNsJDc9St4VqxH+K1XKiOsk8WWkh44F4NcEYxs1MojfgT3yIbcmntAY9lZDOxZ80A
         +3MeROGsUrvDDYGlX4oKT3NSaTUnAbKZQ+BofE+UKjY5+sQupGG4oAB6c1s8h1NrNGrL
         SDx9zbTnsXRnxn5tgjvzfUBk7HxMBlsa+Yu07rQY7k6Dn2qNNDpkm+wo2nSmi6se9907
         mI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983442; x=1790588242;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8uI9/fWCr9BWQafylmcrF08x1jWqCPZOKku91jDtxmI=;
        b=0lHWjTEk7VFqe3AwbXa6h2sUMGl5wjziVW+FxCqNy9D5ewwH0yQbBOLTfboZnxz7M7
         LwMRlfcof8nwaUPl9JmdlNdpMfhfi+aLSTLcndqnWMzaEVm/Shz08Y+PA7Yy1yLbJ9nJ
         8iroDu4KETWXQJNGVURq5ifXF/x0rDHS1dFtNH9YVyo7LuLfBtkZ/K28ZFzT5PLC9TfJ
         nzWs8ywb4zQpxu0cjWLkbFZZCPUklB3khFekHp80IBUThvxzrrsCMBN7+NSgwIaJ0gRm
         N6D8Eob65GVjH6OQAvjtpu1Tfm2GeRoSwWJDRhtTduc9PzdvFjl1fPFs+GYEXpEuKLz6
         Bydg==
X-Forwarded-Encrypted: i=1; AKwUvBzHCbJQx1usgULQ345RY2rFHzZEhKsLfsFWXElaBTakrSCh0NDdQKfV21i+1jLzfBhOp9J4Zfg=@vger.kernel.org
X-Gm-Message-State: AFuF++mHHp+B6tNq9JQj9jkiqKUsn0JzSFIL1Yv7gyedJNh/mKavNqA/
	PHk3G3f/tkjKZqyfl4T2n7k9TSV4FVu275bmNYh2Itl1B35U/go/pvcbC9XTRiBKH/u+dbygaoh
	nIg1Bw2vpX8XRyDnzaGczD5jRkwrYlr2YsrSVfKv3GL5ziQ7DRnOvO56gzP+/YRxnAzo=
X-Gm-Gg: AYBFou18EiLfaYYSP0MVxIa7XCy9E2wcsdupPLol/JoPCfjxC8iOs9prtLmlIMWYV3I
	RoRgmf8AqxChdRbi8OL6FLmIVvUc87HWvFyTMTud2b2sDZkwbkdovfDobnDfWScqEKPRapmypSF
	FtcWqUMUv0zZbnGG3DNCv21x5bR7+FZkXwEttncHovEa85Gvksn+NsdxTxI9vV/lTO00iNToJrs
	BwNaYOk9lGJbOAKy9/0xmf4WEuRDX/CKbWyT5AYUintG8CAlZxEKehDM0a6MCfl6lroEO8KFE0h
	h8bHh9solV6rLfZ//DNH6M4d4EYKan4RKyvFNigqn3yOpgfXdIvdKcpG5+3KrQYFni8/vGiHHPb
	+xb9zGMTU2x0IoPXsadhyOQ==
X-Received: by 2002:a05:6214:2406:b0:912:408c:d75 with SMTP id 6a1803df08f44-9129c75e186mr109835806d6.1.1789983441957;
        Mon, 21 Sep 2026 02:37:21 -0700 (PDT)
X-Received: by 2002:a05:6214:2406:b0:912:408c:d75 with SMTP id 6a1803df08f44-9129c75e186mr109835406d6.1.1789983441563;
        Mon, 21 Sep 2026 02:37:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e35d64sm4066246a12.30.2026.09.21.02.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:37:19 -0700 (PDT)
Message-ID: <c32f67e6-c4d6-450d-8a7d-3057ce3a94d8@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:37:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0766/1376] arm64: dts: qcom: sc8180x: Fix the PCIe
 iommu-map entries
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <cc43fb43-b6cd-4d60-b077-5fdf7918cf8a@oracle.com>
 <daily-reply-20260916-0006-re-qcom-pcie-iommu-map@kernel.org>
 <848e13a2-e80c-42cf-845c-0c04a4547975@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <848e13a2-e80c-42cf-845c-0c04a4547975@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX4nwzjd+eG5CN
 2YhjgRXwANIXQ9XepmO6pZr3fSodw3poJvnCAzv/Qu+jgXSrI65RKeQXipJ7w4pH7DoYv0XMbD4
 5mB1l/d54W0gBVdmavBH7CyWpwnZTc4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX7j6/m958+Ja0
 vqiRXxIoQMN52t6V2f4RyJdOW84DsRdPQtQYE83KSImESL0RhwO4F6zyE4Ck9pyRxepBooiN5cD
 D3W0ROzmF34etT0mwJYQujNzl7sqT5uQU1Ee7ooB+LjusoxVWAeS2zRzCGIo1B5YYnobqUQ2dQa
 KpMRfAdCohlzSMgSj+nBA1AmvT2kGnUe/5Qv2Pr9KuuFosH45NQSa8bTceDRwAEzI9jMkC6Z9x5
 24XYTUTEDx8yNNPBeAkHPTRt25+ju4VfZFpCFHsEfmds++zjObJtz1bmnGADg+VjkOhIOJ97nn1
 Jv859L1fpU2Wud/t5+ypyr/729K6oCt7SU40grvfXnfxd4fi3rL47pUyKoNe2W19y4oSwy/L3AK
 T6ZgT4wgS2whrXWnlVWD/YOBDKiuWmjIQI2QXdohuvc6I4ZYzh1UPKle4rNwhGOiR0swexiyFMr
 Sf94oCttTMCDFYTw8kw==
X-Proofpoint-ORIG-GUID: s67rWRbk2GZPpc6OdrpEEnk5L702dEsR
X-Proofpoint-GUID: s67rWRbk2GZPpc6OdrpEEnk5L702dEsR
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0fad3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=lNoLSsqp7PxrA7xlTPEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210136

On 9/21/26 11:36 AM, Konrad Dybcio wrote:
> On 9/16/26 9:27 PM, Sasha Levin wrote:
>>> Upstream has the variable-cell parser and its API preparation series,
>>> including ccb2fd725d411265df8f7ce12a66c226b16014e6. That broad series is
>>> absent here.
>>
>> Agreed, and Konrad asked for the whole family to come out of every tree that
>> lacks ccb2fd725d41 ("of: Respect #{iommu,msi}-cells in maps").
>>
>> Reverted across 6.18, 6.12, 6.6 and 6.1, 35 commits in total. 7.2 has the
>> parser, so it keeps them. The msi-map siblings stay as they are.
> 
> I think the updated msi-maps parsing would be broken without that
> commit too, no?

For clarity "the updated msi-maps parsing" - "the parsing of the
updated msi-map which contains the amount of cells that the iommu
node provides, rather than an always-assumed 1"

Konrad

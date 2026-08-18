Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389233D4E2
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035782; cv=none; b=fq50ukcW//KTUEhmfK9wQvSyaR/xHzCTGJv5OnJkLkW8hEIKVOEvOO+QFSwBym2P2tDLmuBHdgaUigx9z8so4WsiEe1cHdu3y8IP6DtQu2BY4ATK0/7NMb3y807tIS3d0gLgLS8DEwxohQ7ckbS1xm59OonOmKXZbCSw4iKxd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035782; c=relaxed/simple;
	bh=bM6pDSjFTrw3Nm56Uum62JiF+u0GZCCUqToMVeaD8Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBGQ+/RU4mHYzThR+S/u7nx1Nf3FtGYXR/W//4sHOVAjZQEDqr+4v15IZd9yFSMObWfjbq+6nlf5RwqiexEWUX+acQpMBmMZUsKF4/YjB3TSjrbaIKWOgP6PiC9hTkeJ9C9oP5AYFdIuAG1x3qGgO8UOxdedNQrxF8OG+5OPjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFHu1E/M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqmIwc3V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFHu1E/M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqmIwc3V"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I4x05p3531735
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k4JiTPe+bV5Bhf2Yri0mM0d2
	+t3X2WZruXXiZxqw0ZA=; b=IFHu1E/Mv4Kqnp0FU/pK7eVfYYOF/FRTGmbZMo8+
	E4z9LUwB+slAA077NtvPqeL8pr7vjcRxM2pHY85d1jwxV5+n8V9OG5roTMNl3FzV
	HaRsf+wIuPgp+gtPU/mXSapbYm23A6qyiobEI64b39Eyx5jnQol12uUVAOC8A4wK
	wB7NPb7Zzxue9goykupW+c/nrSOVvQxsMBPDqTik/YVCF3CGA5n2b6MZOFUaChna
	I5R18DNr6RJ1+QPcd1WRhYnGvKi/mwAoZTViWNeMA2TLVUXUnB7DpkXwXqtfKFhk
	ricqUkBe+qhuzSYjvMDk6nhaxYzQW1zwlVW8SjRsibvoUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615k2fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:49:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e9a2b95b5so742742585a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787035779; x=1787640579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k4JiTPe+bV5Bhf2Yri0mM0d2+t3X2WZruXXiZxqw0ZA=;
        b=cqmIwc3VpHSWvmRE1rL2Vj7s0w8/m6dgjlrYLIyeAVfaHWg4nTfpNn6tvNP2xFgXO3
         RizxkZJrhqYP+MWEVUwvha12Oay6waBt161hSFoVKAGmd/2+1jc6w6gletYxmOHHrPbt
         N2kfR1vpY82FBZhTJHPwFb4N9GFl106SYnVrTrHsg5F9eyCjDlTtxQwU2HEAvkOt+f7u
         R+Yyl6eQz/hNCJpYIZs9PEnK4Zmaj4+1KVuL2WOqFzU2rm5ixLsW1ZQ72Fio6PjutxvT
         HWBIxPzEZYn5oB9p5pedYhdx+Lj04VbUHRXBtDQIWJzfjJKr+Ir/JDnFRuH2c2pKIoK6
         Qt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787035779; x=1787640579;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4JiTPe+bV5Bhf2Yri0mM0d2+t3X2WZruXXiZxqw0ZA=;
        b=Z4JP0Ohn1EIC5tn9P4NmW3gNUtkAXLhUYnWQH/eAI5Rp9d+4or2C9lieuabsym9Cb8
         8tSZy91gqNspOJZUzmN7sC2m+nqsdr2cEtH/nVSNa212qSZdNisv9wMGb9j8pvzVDiUg
         RXwAc2SwRP8xaRjHcx5qKJJa04n70/aAOrMDVjNzfacpA5EQkd9+28JT5vxuWln8rMDt
         4mujs2PcMVwG3SrpeBRni6/54rioqFeQTGVeYGy0ZXoZtvS1HPwujGsB0pWuVnI4Gtj6
         2CFobmYQfkWyPLvO3Jtcw42q25xzUfeubfznlV2sDvTkIbsiqZ2lKXzIB91dd5TVuMhS
         unBQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0+afsFb8XCKbK+N923joawqeVrujqqBbZ7jes7AmTWw/ZQHSoHqy8sC0rcEfPvSYTRw3pEeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLa9lSDyrlrPSMbLhH00L/RgqP1oZ1Uvi/ZaSIOYtPzxypJPQu
	paigODO5jdGzspvofxtXweskOE8fDWuXiJmOtJ8bZe7TlIEBcjUDAOM3+JyzvLuDwMOUW5D351B
	fHz5MScQ2YzyKsZlvGdYB1TlNmpRPQJTYfaR2bowqipnbsJLCBotMuOyNNWY=
X-Gm-Gg: AR+sD113nhQrXiFp59qoQNCwvYEvRUO3yDimCmrs/4uA8pxo3sFwXGDN1YxnRSFuEvx
	3ZqyCN0aE6ZruiFEUmPCfA9RrQnlEf5LchKj4kNvnkrANqdTzlQZAbvNZVRcUe6iGwVv4Pacb8Y
	QF1VhGv/mz0grisAhNPRP7H/keofkvG64MRC/inFzBi1KGEzdGnUNqGYyq0WuVOS/I3/7q0vPX4
	tNCK5dB2/++Qi6Lc6zoPWraGo0Up9QVk0PXwNq7Eq9HVvGP0UAbWxYO8pP8S8EJxeX4dxmmsQGj
	I4950m0FWv/2DsH9wK67rGMC6M6jnvgQYmdvbc/luKStgBttzcqdgK3QmQScmLReIduqhnB8fxt
	8Z7Pvzih6k30QzgRudijlMRinBjgWt907h+CxKitu1x6APxSWKdHMgjQ5i91ZT5mlUtWivt2VOz
	2AyawYCUUdhzyw
X-Received: by 2002:a05:620a:4150:b0:915:79c8:ec92 with SMTP id af79cd13be357-936d231f768mr3068128385a.37.1787035778785;
        Mon, 17 Aug 2026 23:49:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:915:79c8:ec92 with SMTP id af79cd13be357-936d231f768mr3068121085a.37.1787035777872;
        Mon, 17 Aug 2026 23:49:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e3c17sm9714011fa.14.2026.08.17.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:49:35 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:49:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] media: iris: Fix iova allocation from restrict region
Message-ID: <yc4clrtiuphrdfcd5nmvttr6lpgsxkbnrrmp7s4urkola3p23u@uv4ahf65clnr>
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
X-Proofpoint-GUID: 4Q3N0KhjwBdDHDk8c_3x9wd7SILNDbZ7
X-Proofpoint-ORIG-GUID: 4Q3N0KhjwBdDHDk8c_3x9wd7SILNDbZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0OSBTYWx0ZWRfX6J8E/Vzz5ioT
 YW6mGqDNi0EOdJQdwzKz9xkAnSxo5qdzhEbdiXTay1KiylAaVo2pY3IA21JBZUhop9AQHzJw5Pv
 I12XKwnQZKbNyMPWI8qW38bne6lXhSB+Z+1zBpWfTfOj+VDrBv9fY0jwOg/R7HkMwTeRRjjalFs
 uVj1yFPYIRK1gQYIr1hl/CpzJduA/eJD7iTQCVFRnpTYOIB6snKh9iikt/hkqREDfu3SmRrOMGo
 OYNzen+Q86J+7q4PuszVKRcKMEVQOGJsPxFC05ngBLucUYcfZ4yH+IQvSdZSsMi0Uz+Bp2SR0/G
 rO3x4dxOrZDMXfoe3Q6nlyxpFuOUoj9IVXqSledaTPg7mctfPikQmGxf8XyIPFjGtPL/Yn6kPPO
 WLYkrA+plSY57vhjzVncmgAguZqRFHVmLW9/z3vjNDpls+qZGICSKC5U072fxV3PX+L272Cqzq1
 teFGQ/SlmxvD5hh8kEQ==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a840083 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Hj55FqqFgxrcsKo4rRQA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0OSBTYWx0ZWRfX6CDWn+vhAnEm
 h4Cz2r/9q2gJCynxObW9/2qZfmKderAm2y7YFnmJLIVbj+jTdYxJ0uK/GDTHw4/XVLrYSHmmuRM
 0zaQY0XT9tk5BAMfCvy14aWdNemj4G4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180049

On Wed, Aug 12, 2026 at 04:25:58PM +0530, Vishnu Reddy wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream
> in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
> boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots.
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
> already posted here:
> https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com
> 
> Those changes involve DT binding and DT node changes, and discussion is
> still ongoing on how to handle those for stable and for the upcoming
> sub-node design, with no conclusion reached yet. Thereby a critical reset
> issue is still open.
> 
> This is an alternate solution to fix the unhandled SMMU page fault
> by restricting the IOVA range in the video driver, which also makes it
> easier and faster to land on mainline and stable kernels. At the same
> time the patch only reserves in the IOVA space without allocating
> any physical memory.
> 
> Currently sub-nodes are not yet present, and only a single device is
> available, so the restriction is applied to both non-pixel and pixel
> stream IDs. This makes the solution unoptimal while fixing the issue
> considering all scenarios.
> Once sub-nodes for non-pixel, pixel, and secure streams become available,
> the restriction can be made stream specific.
> 
> Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
>  drivers/media/platform/qcom/iris/iris_probe.c | 69 ++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

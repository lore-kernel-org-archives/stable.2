Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BF3446C4
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718533; cv=none; b=UV52SIyzhGuEcR3y2ei+17fG9OId0uVpsQhlNNDJhJRyvbJ7RCfAOSlW4js/AXwMTamZ0b01ntDIfI1lQGRB7qmaJLqdRam+WCBYcjotvTPQqWgiYCuQ1z67tUzj9S8cQMBjmdsVeLB4hqfqstyJWUQo7vPO+AVraX+R61fyp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718533; c=relaxed/simple;
	bh=ZunX9x9Qfg2ygxY02z1CqlB35kcZIQXd5mtkNO+VIUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5l9abmMT7fwdTA10ENt/IpRd0SQJtOCq1LFxCASMIwmztioaM3h2btGgI97tJDkccFKHQK5ogYwxdWZ2VkkOWn5DRjES3cO7RRja89AS9vtEIly6I7XUz49ZRu9OFyY8HkuuoWvB77soZdvvilhUjdgBQ07+vuOsKm94P3gE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdsNhp0p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z7FPnPIN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdsNhp0p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7FPnPIN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EDx9ou1935980
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GKepa7JDsXLcEEP/HR6lN/pxWVDviaNjxQkZKdCVmdg=; b=JdsNhp0pcIFBNjGn
	fPVUydAE6lLbJbeqsTa3wtzxyODH90NGk/9PdiuELpkIY+112yeFjkQ1PWlz2G72
	Hqi5W/Wis0ZUdmXIYrBhkzmrrAMSjWtIH8CFiMfZZCoMiDwN56MWtLVmkV858avM
	tkKAhlYGdMCDYyW1LqgpslktuMzcsKO/0fy6JGaJNxg7BQmiiOeYVKTMUoRqz1iz
	ECnLmHWtvDZROMLiKeizflR67PaZ6KfdY+79bCroF0v+jcAPyZV97cfJ3uWJ+ova
	DQ0X3P2J7Hx6peJg/KJNfk74ZyUdFksiH3chVfXQSW3I17+tKufGNE+WpgGfNnKm
	BTdQmA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20gn97jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:42:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so2240151a91.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786718526; x=1787323326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKepa7JDsXLcEEP/HR6lN/pxWVDviaNjxQkZKdCVmdg=;
        b=Z7FPnPINumW5xf0486+PRmnPEGfYs4qRNEN1Lq/7g71JIPne2GQbybL7R7jQNZ0j5a
         57mqAXxgXvI3OTJV5vr7X2Wjz7diSsjAgSIkvx2ZDgKIkyC6mjQJ/TUtriIIAivsasnP
         /UIDSuyjnnL/1C81JUWP0fDL4aaa8ILn1TOZy2VbIJp64dpWakpjsLZDQR+nl1Z8UmZe
         GbmdFvPiBi8VQH0Vve3fK8nTfTqanYkHYT1+OsctWode58RkzOJr9VUBkt3WMI5tVCXO
         xDMCxZrbLF1ULFhRNbwfXv6zAYAG3GnCMmIz+/b0eSepNYHvtszjXM1AtUXwIzN0R41t
         HU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718526; x=1787323326;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKepa7JDsXLcEEP/HR6lN/pxWVDviaNjxQkZKdCVmdg=;
        b=q6GqRe9nW+uSU6NU67ggNcWXlYjQRZTez8kaMvlO+cpTt/xWbxw0R1+HQCEVPVhTfk
         z1/u1UV2YvaLOost9w6CZw54lr1zCnTNTKslSKUEQfv/Y+UeJP7nLXBpqnpADHdlfI7v
         DUZUp0xzC/E0ZmQfWZCLYahPkLR89xflxEQJ9nOEBkaRW4O3b0oqBxORB6DF9m3YxY7c
         NDZyrnDYxt6i/heMDyDEc7g7BTpmOMGCkVUCUiOBW7NJQobZH9gKj1/8Vw8U0GIcs41c
         wmMREMIu6LaPCxpfkSpU4JKK/W7b5rATxJIDjpcnP1bQV6LDh38noKLpe679jgMYX3Ki
         oG6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoW3qo/fY+QQ0Tt9+D1+8Ylf1+dAmTaWbwcmlUVghHbKmcYcjet51oUPIKIOKjOkz7cA/1dDYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNrLl7YjAcP1/bRsP+LSwpTLjuRvxCz7+hF8EbAiUH/+70zlbo
	6pnnLuhoAjgntY24rU094vRkqzJB1uZfFZapO0yiXz+brL1Q6y00U9n04zRoXhtHI8puEHe60dq
	IxVW4/GNIHnYLNB85Nmd/9lqjQJPjC6CV5sHxnhBA4Y2+4QlvvCZjFPkfoQg=
X-Gm-Gg: AR+sD1083RYLi0JaBzra5p65TlQGMO+9Tz0dcF/Z5nfE3+yXxQE4UsQxapxMOWQBsTk
	L+H/p7TyHwPkjQb6LjY7sW2ZO9EcmPlhSpzqnXiUzF3Nzo8CkpMP6k4Vc9dnX3oQOoH21qbQqUF
	l6f9rOx80DNWEAXCxhJTASNh//5+ulv2ZERXvjAIe274nF1jJvXtq5LngD5BNlu912r3rps3LmJ
	M7f3o6jQZ0daPa+JP+LlSNEaXHihmu31qDectQNqCgP3fh2VRr6P6Wk6Zx5fxOS6Ai1HwhqjQ1L
	2uphfx9bsPscBrdy0Z9iUVzzmb8aNmo/ag7mpkysHdBZi76BoEtFkr2oPNxwiZe6Kjz4vThyZMk
	cV69s23EnpOZRxpu9d0iReDualmQVPUOO
X-Received: by 2002:a17:90b:5101:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3933b6d0deamr8279684a91.1.1786718526237;
        Fri, 14 Aug 2026 07:42:06 -0700 (PDT)
X-Received: by 2002:a17:90b:5101:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3933b6d0deamr8279625a91.1.1786718525734;
        Fri, 14 Aug 2026 07:42:05 -0700 (PDT)
Received: from [10.206.103.83] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ac9b1sm11516933c88.2.2026.08.14.07.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 07:42:05 -0700 (PDT)
Message-ID: <36dd132f-a879-4e40-9ab3-d416d7e8fb1f@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 20:11:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: venus: Fix iova allocation from restrict
 region
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <20260812-reserve_iova_in_driver-v1-2-ed62f801275c@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260812-reserve_iova_in_driver-v1-2-ed62f801275c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMiBTYWx0ZWRfX56y1f5EjbLQw
 JTiXK7AsRkVCpztLpzQ74rvOogFSeH76PGWKrTcI0cH6oxoocKOa5z0122QdN0yHGsIA/8m7dop
 H+/SgJp1ZBzURDF36mCsINezwA4QtriPHpw26A7tDzPGUcI1J5HA671obkqtIYDlaEo3G3wWakZ
 Zf89aRpAfkM/4eb5nLKDBHtfAEahlIclfY+bftDdRGJRmfD6p29Ef2IUY2Gi65ZFqDFJFi+HlXo
 dMXVp+fSvIAlrA12TUK9gUYE7MOz+I9i82tOdTagHBQxJvwqxW45o0uWpzPTPKEes77wMzN8ak+
 diBJhEkCEnouMDufZl30mEa+E0APifXw58Q57f/Vyx2gdCTMVqpxfAB0PmOqGmW+9RIWiiF2JY+
 +XbDqVCnAAJMEy1zChCHCPsoWmkFseQi9Bi9GhsKixHo+7dLpcK7hrgLrxD4YqyQgMFZ7FDqlTe
 /ZoMgqrizlO7zm+jT+w==
X-Authority-Analysis: v=2.4 cv=DdMnbPtW c=1 sm=1 tr=0 ts=6a7f293f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Hj55FqqFgxrcsKo4rRQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMiBTYWx0ZWRfX0mmPHEMGQ/p/
 PTZ2vImkglIQoE1GyEUBvszz9amBgHCivYGD0YzhAaHAPDtAnEHHcjWKkL/K/5qZKw/H/ZyGbqP
 QU4vTpkmCo0CXRcu/t93i3OzEvUVFtY=
X-Proofpoint-GUID: c8H1BA5yhnI8GLdvQuzumbCYi87N45zK
X-Proofpoint-ORIG-GUID: c8H1BA5yhnI8GLdvQuzumbCYi87N45zK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140112


On 8/12/2026 4:25 PM, Vishnu Reddy wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>      +-----------------------------------------------------------+
>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>      | 0x25800000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
>      | pixel stream addressable range (0 - 3.5 GB)               |
>      | 0x00000000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream
> in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
> boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots.
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
> already posted here:
> https://lore.kernel.org/all/20260807-iris_iova_600mb_fix- 
> v1-0-3996f67e33f9@oss.qualcomm.com
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
> Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 71 +++++++++++++++++++++++++++++++-
>   drivers/media/platform/qcom/venus/core.h |  5 +++
>   2 files changed, 74 insertions(+), 2 deletions(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595371;
	b=FMFmM6z4hkSbnTUcBrbC83QHhbs8NxdUQ8O+LauDfvHYGGH4YlEeYceYVN+nFW2zsHRh
	 KAl0nrWeHdg5QS/jD6OQ0B1geP+WPl+k25Y86VNyafDG3XGcjNJj4/+fee5YZqjaTMwCO
	 5eIwJdTJ+N0sGt4337FobuVfsFsY3tXKbc3MyAIoDY8ZiFBkl4K50ye6m61YkaVqJOXDs
	 3FNaHKhog/1SB+0L+lzCLQOQU1jSzizwfz9UIgJ0G3a8vWEae0WLlr0PUy18VVBYtaPTl
	 n693XfQLIHWhXCaYc1rKdb3v2/w1OAH+O9NcrvwvDqAaKY2rvC5CSl332QtpKxf+Mig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wtQv9fBBqzLZu4dFjeLGNnk+sYfH2oM5wagtmKDZJQM=;
	b=yiW/tnQP75DAzBlIc870urGrLwNBfHS8FDHmoNIsgg741IFwML1ohfAKsbLntJoN7fXJ
	 4G89a3iofTLxulo4Kb6jDFMZzIZUu9KVfHxD9n5sU/rSzEtnWGo0ABfsU49hOfx21gVVT
	 Z/piNTNOhr7QwEFXlBmMhVixTJ9B+Khyccws1nr9CEYzgz+nQS1g5xVKuQmCQyS/jSyum
	 T4D55owihGToeM+eqX3apkHq7cDhRtbbVvZS7gagwoR1a8tvqfyvtx+lxFWn+63c/SpC4
	 R6UzqQVXcjciJjWccl5/Ao434ooLMTYbNIDNuwwvJg4OdiSQztrymJd0cSXF1x3g8LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oTuBpkyG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KFSJb+ad;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D6606A66D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4D6606A66D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oTuBpkyG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KFSJb+ad
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR0Ew1011373
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wtQv9fBBqzLZu4dFjeLGNnk+sYfH2oM5wagtmKDZJQM=; b=oTuBpkyGyai6ayDd
	THPqtJfQxsHOeVWMJ0sV5Ce+zlRb8MVEhhSH/OV0tf30/MF7V94MyP5Af83c1+FS
	aa2QObsgCrPSzCbgNu87Im+/v/+vYSdV2BmC2UhjuDwgGxRQfd7LS9zj5KfaASLr
	z2L1GDM/86mecLZlq2vdx95ch4EQ26+vm3wKAtyvXzKP5pPkrs0nBWe4lAjtmbE0
	tS59IRGqOAraIPU+lRJ0v6vjuHPEsvptuve9ivAbDkE9fRXT4icB5rtEN2yMxwhN
	YbKlmj0OtL2DxeJAMe3jktToLzexdkmadYe947dLh8PXBeloaFGXGdzNBuFwxDAs
	qXj4MA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdmg07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:42:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1584691eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794595369; x=1795200169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtQv9fBBqzLZu4dFjeLGNnk+sYfH2oM5wagtmKDZJQM=;
        b=KFSJb+adaBJLJvzeG0seYunchIK+4lfE8ey78mCZ4etUdARkzmN6Q6Qod+2915lf1T
         3d4NQ/k8SlrXM9FFBV2oUNtbUNlTRy297p1SX5ZEjWfs3y2Q9/XWzZhTpoK5G6TM9MEF
         pNE8yxlF91g7luQ+3w5C0PPvoI7So4ZYay4sjQwh6OP4vvKTdIC3sCdCt2qrX7/XcR/z
         L8jP82Jy0qbXuV1MLqHw9ORtljoCzaVS4qzoZMhHR8Yed7/9EJe9MpqA1n/jygQHZkX+
         24B0Kht/B6R7An3+3rY7CF1B+8XPnP1MT36A90jBgwtu3yQZE0TVe9Tbbzkq0I4hUO/l
         rF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794595369; x=1795200169;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wtQv9fBBqzLZu4dFjeLGNnk+sYfH2oM5wagtmKDZJQM=;
        b=1r1/LuyIqmg7k9Lx6jkkhMDYKPVb7AM/RAFPBcObNXI2cRWZPgWQ8hPVaorTdcf2gA
         xcvjvEjWh2ym3Mj+EX9aclFN08U7m6Jj42fWIWv6VkJPC0IRW+WIbgwm+3gi84NStdYL
         WHd9+SrLX1ews+UNgOqacVTydvf9jXb4gO+N6+RtgHPGGHTBNLIFHiWBCWYAdXNfT/4N
         cAci4GQ6Vgxxb3zAwQJkwEMwJPZRLs8PM43fpy5NjOmRwlMzROG4MwTy+j9Ni1uXIC6k
         oa/4aJlCUguvsn2aK8O2ro7KRbZbATH2KotYl1qsBBrLJbLOgEchYN4BcmlxvXT/E+HM
         tJVQ==
X-Forwarded-Encrypted: i=1; AL+hErEm7Qk1IIUvBO172OPhxX+QLTq3sOQZ1u9DQhhsDmLvCjm9Ksum+Z+7/jvdsV+seln2rFtUIEc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BPe0RdSmktGNOKFxgS2lEKK0P1WAkcM7rssMQ0WU6A4Z9fNLw
	IC1pKom1rUq4NfC2oBORNGT5QomuwW/KrIhPd0wnDWwAYkk0n6C0FaHhqDMi2iO2lKVZP6dRFS/
	CmbxV6AoO4EigoKlAGmzJMDMmnJ1uBVwftkdv5xFbdyyHbL4HBeFWcJvpx88=
X-Gm-Gg: AYBFou2bt3m/igZcQxWeVp+OHzuvV9qEPM0ndlyP+G9mXCjJEoEPhMTVs0696yrrCAj
	aV4rXO/D/B57pdR5F8QvkI5yb4SwPGwZYpFHGz0b5uV/UyKCuyNOUjEvsvmQBEdlwD4mqY//QpA
	m9D09EXvcjoLUOqYD5QFw/EdKQN78C3hlf06irlFn59xt5X82GYrK9GxS1m0KwaUPHYUvNG5+o7
	OjW/mXN7MymkXqttrpTL8h7Zw2By1KD2Ona3NzIOO8cXPnx+xWhNOR4rktDWdN/nOYdiyjky6K7
	CUzvCMiMa7xl09+qNJXudLsgSpM9vU4HnMhjwEUp92KWCxt1/sOHc/pWoPzwmwtYNjSRSxXEsGv
	K88Lvbb5fZBOZEj3CfcxNu0HxVkpRi5unw7rDpYkU2lsL+Ce91Yup1M48f1zMb2WHze2FWhNeSZ
	MFNxuBHACorXmI+Aez9CSrPPs=
X-Received: by 2002:a05:7022:5e08:b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1b503115942mr2812413c88.27.1794595369079;
        Fri, 13 Nov 2026 10:42:49 -0800 (PST)
X-Received: by 2002:a05:7022:5e08:b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1b503115942mr2812394c88.27.1794595368577;
        Fri, 13 Nov 2026 10:42:48 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b505b5bf76sm6327679c88.10.2026.11.13.10.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 10:42:48 -0800 (PST)
Message-ID: <826c1746-137b-4a5a-968e-8e0449a25e78@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 11:42:46 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: host: Only expose controller sysfs attributes
 on the controller device
To: Slark Xiao <slark_xiao@163.com>, mani@kernel.org, bbhatt@codeaurora.org
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111115659.11943-1-slark_xiao@163.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261111115659.11943-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NCBTYWx0ZWRfX/5YBzmc2NLwT
 cfU0Ce+CavqmxAWC/OoyZ9W+JewFwVSFXCDRjiIT2cKkGhylZ/+iaeeEoR8Lt5CTQlt1DmMB+pi
 deFz5p9EgiPmZmJCXYXHFTq/O7wRQUk=
X-Proofpoint-ORIG-GUID: GNYQdmPmkfOauKX6E2TbLvyu2EvhoHkt
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af75a2a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=48XoENhhM4yzJEw9bqUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NCBTYWx0ZWRfX/zESkymSw5d2
 2ZtlNW5LQf63sTCv7pmT5bmJ5P6akN6xey4kJGBkBtfzCpValM3Dj3PmWCbejurCl88OGC2qGtT
 EApet2SfJ3tw1Psz5/BJxa3JQLznWjoK2g6dWJ9/quc5VdRMYWJpDY+Fr9H6Hgr6wB7HnTquz1A
 c4tNrYrOBzbbE+KvVG7YeZsiBm0iXJFX2JgPUKNSH0h5FYvaTT1Qk9f6ugghNFa9WpqFj2b8zZr
 3v+yfIPJo37bzBDcsoCSxJsL7iYqmUY4DEiVNHHiT/82KzeX5ZUN/nYTcjR/IQ//Tb83lewq6sT
 +Zx+HcSSaPSgsvjverJn6Z9x2Xq/moaEIddG04l6Z9hw7S9cWG32cPSQ9kJqZfk4D0dp8vwJRU3
 4qbuss0tuqU7VD6inSlRQJC0WBLYifNFjzLkHbx+FsuKV3gEbzV4aSCSA9C1kcErdf/aoReOA0w
 lOHQunuY74IyaAgjQTg==
X-Proofpoint-GUID: GNYQdmPmkfOauKX6E2TbLvyu2EvhoHkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130074

On 11/11/2026 4:56 AM, Slark Xiao wrote:
> The serial_number, oem_pk_hash and soc_reset attributes are registered
> through mhi_bus_type.dev_groups, so the driver core creates them for
> every device on the MHI bus.  MHI client devices (the per-channel
> devices such as mhi0_DUN or mhi0_MBIM) are also MHI bus devices, so
> each of them ends up with its own copies of these files even though
> they all operate on the same mhi_controller:
> 
>    $ ls /sys/bus/mhi/devices/mhi0_DUN/
>    driver  oem_pk_hash  power  serial_number  soc_reset  subsystem  uevent
> 
> This is wrong for several reasons:
> 
>    - The attributes describe the controller, not the channel.  Their
>      callbacks all dereference mhi_dev->mhi_cntrl and read BHI registers
>      or issue a controller-wide SoC reset, so writing soc_reset through
>      mhi0_DUN resets the whole device while looking like a per-channel
>      operation.
>    - oem_pk_hash reports failures with dev_err(dev, ...), so a single
>      failing controller produces one log line per registered channel
>      device instead of one.
>    - Userspace has no way to tell which copy is authoritative.
> 
> Move the attributes off the bus and attach them to the controller
> device only.  mhi_register_controller() now installs the group via
> mhi_dev->dev.groups before device_add(), while the channel devices
> created by mhi_create_devices() are left untouched.  No functional
> change for the controller device; the files stay at the paths listed
> in Documentation/ABI/stable/sysfs-bus-mhi.
> 
> Note that trigger_edl was already handled this way, through an explicit
> sysfs_create_file() on the controller kobject, which is why it never
> appeared on the channel devices.
I agree with the rationale, but this does appear to change uAPI. Are you 
sure no one is using these on the channel devices?

-Jeff

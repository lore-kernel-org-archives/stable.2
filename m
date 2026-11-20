Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193134;
	b=bmKClhKstWIFoQb2Xft+FitwOhXJOZ5E9cv3uCfukmo8FbkrlHmS5uoW2DQOEhFElAg/
	 gHldOvW01Xtqi+diyexNpsmRCuGri4kDyqkOSM1vmVOI7bOcvl8OoAAaH8BqqOVdIHwVy
	 qD5+IonFfpFMLVP6Mc31DKI0GyaoTlPKuloxmAtxG7KipY/u+G4TtRMRtJmmH5EhuoYoR
	 M68YQTNTlqQKw58SaiyHyVzARpvxpO3eS+Ap3y+sU/VBI6ItVkDR9YX4IhDKEpv6+vw3q
	 M3hRIqwsb9/Gcs2z+kz4r0RjQb9LB5ZRyZerwFi1cm9bhSoDOK6puXS5lxhwrGnJVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193134;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4IlXOQ7f0zn8jf6zZzbIrtKtz6kWu6T2Z8xnSRwhbZw=;
	b=ujzBJ/fNfSjzJplDAD85fMTtbiRdvNzfC2/AvXZXJ2cg8cDOB4wLttHIPzdTmKS96cxS
	 +N9Do3iYZmZeEhIYFG5hKwNLMTpqHq8tbVmjXdeAAC58DpMEImtCpieGwJIuZlkJsl8l2
	 UR2mqvmaWYDzMbOR7a33CVyme38eHYmpQkjy/QMLEi5IV5Id74Pt1rJY5wbtgOGKPxgKc
	 PswcFLRKgE832PQ0UOiBVWiAkiLFqN2BCd9h2bkBNYeRLiSuS3OkGO5v0csMZ+lP+aQge
	 Q9Kt8F91R5QkuXmVh8mkw35A8pZtR4cy5OgexxfFE82gE9pTLS/9RHtBe3h2Y/uw15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4SgVwVh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEr7E6hu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA4606A609
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EA4606A609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4SgVwVh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEr7E6hu
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfINI2040017
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4IlXOQ7f0zn8jf6zZzbIrtKtz6kWu6T2Z8xnSRwhbZw=; b=Y4SgVwVhvElqL7gM
	AuSh76nTy6d07wAWzQzAByaL8WNeDbQOQT5zJS5pta+Ws1fYjmdZjPnBJxgiL4w0
	GhPfMtuR8uCYU/RRAt94Iob+xSvCO+qTg3rNqUAL+y8lLKHkpF3MZ7Saxn0IGnDI
	EKntjdJy5BWBvejh1PTSi4ssjKiXLm7z7sefqI1ak3dVrUaoTJroQs01a1DbJUB/
	Uef+g1a7fB7tv05HUU8m+jo3yxnV+BoJn9y3WB2JUKJXwrlmoLjkQwIMp6sq0Gk8
	1A3AKDO99MtLsIIVOXYBTaaOg89Us31EPpaSR+N+hosLbOmXyZHoKOcWRHNg9rJ6
	pZi97A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjttu96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:45:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38355b03cb8so1032834eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795193132; x=1795797932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IlXOQ7f0zn8jf6zZzbIrtKtz6kWu6T2Z8xnSRwhbZw=;
        b=iEr7E6hurkE6sq89FOOL7ozBM6i3HW1b3bO7IyX2RPbOtt+2w44DjRoGTJbYH8J+9R
         fgH2omQKCTmxmbIV+ZseWcu6DK4CVzfRJcDNouH2erW3PfwawF+QKMvtAla2kHbBNzyA
         cBSSYybNXkB1/aRzi3jqxDxVAvMnxE4pYfqUxrbgAYq/MBLl/bnMPhO6lh1/goWwr89l
         Ch3QFeClyEj3XedhsG4yZzCmCnjLcpziHtQcOPGzn1vjn96pVOeyWwlr0d7yHpcNLQOv
         qu+skBXeHh7JiXv+LuTt+wpQoaNq1w2UsOcj1ZiFptLFo2ZYWfJ02uIUOUg4Q0Bx4aqg
         qZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193132; x=1795797932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IlXOQ7f0zn8jf6zZzbIrtKtz6kWu6T2Z8xnSRwhbZw=;
        b=YLwO/K4nClHNCkufBCqVCoq2//g7M/LZCGBLZBlLKEAxlvTJzrvMDo4+DMV92dkTkN
         /Mw9DnwoXbwC7KCSSRasv+DM/n23NHt0gyetYtGo0ZBalvkjgzHRuk17eW54G1zGJzuj
         1OcS+zD6HLps3+tpuAjqwGbgHB0cjAeBrlB35zjSM6sb5zpaDN1khi8jfmVtjMNEsx+q
         TWgNhC0sARLC1kPCP6gmmKUQR/sJNnJQ0sKsAtsGVOn3ql9+Dln4YdUjKlBmLzI+6iuY
         zhtZu0Oi3kAT3qi+nfbgLribdwQGHcHXUmEvvOmn/azvbhR4+jR+4rCxyt7peUi6ko1I
         HR4A==
X-Forwarded-Encrypted: i=1; AL+hErHqkEtAD8pAuVaqg4kWXBhMk3nqx6GtPsVKEeUj00Tgn91vpM7TYfIz/L00VZZo8Cp00y8gVBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ycy4dgOnTmEw2dvI7IRmpawwN/7hiJycayJRyYJbZBKs36GAw
	BOABuJZbrQ3sN3NgCoUI9PONd6VDKcXAnQ6AJhNidDBo4KALQ70RBnmxGjfrDl6ocA0bpf4TiAN
	LZ6QQ4GgVqaL390Hqkqs1U6yOJzGP/Dgi+i8EHej4QCXfW1hANKjW/gc9DraXIcSt2hA=
X-Gm-Gg: AZFdTZepVndS/xfHPrplBnQKBms48WlKpZbrTGck06Drl0/pVtFGb3MPW/ORxv73mQJ
	daYqWzLXgmrZjRRvXb+5QBRdEWm8tGzhcNUtIS0hSUtt1RkxRSMlFOLymSdQZXX8POiNvdbqON0
	iroZBff0F/0NmUv75ZviSaKDIHsqMbglrMQpZwGKJ2tXbb1XuqEkmA8puEPIJOaPvSiAj1TMlmq
	GjWyNlvIbfhwlVQj/Ko/qaV5/Dvhl8BJ3WlrmMXPuvP6D82I9AsXrytYjwhnZ6y5TJRQJycDYrh
	9+L8NB8RDojDB7POThGYLmFXMty9y4srlpB1zjyLLcDD4k2WDzcwe9f0WBK603wmAwkzLFIMbPj
	A4qTt6OYDgWrtUxjesNcYt+I9kWyMxVIY6Y0FuLyx+MWw7T2cObRligriqhXeq35mSxsdqZIyzl
	1Ys5dcBaW8HfVCvDCSYX67Iuo=
X-Received: by 2002:a05:7301:2419:b0:367:185e:867a with SMTP id 5a478bee46e88-38571027a5dmr3430884eec.38.1795193131854;
        Fri, 20 Nov 2026 08:45:31 -0800 (PST)
X-Received: by 2002:a05:7301:2419:b0:367:185e:867a with SMTP id 5a478bee46e88-38571027a5dmr3430845eec.38.1795193131141;
        Fri, 20 Nov 2026 08:45:31 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm9309301eec.9.2026.11.20.08.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 08:45:30 -0800 (PST)
Message-ID: <ca6de262-80e3-4c38-8f3c-122712d3f54d@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 09:45:30 -0700
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
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111115659.11943-1-slark_xiao@163.com>
 <826c1746-137b-4a5a-968e-8e0449a25e78@oss.qualcomm.com>
 <3cb75687.54e4.1a1ed794488.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <3cb75687.54e4.1a1ed794488.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P0gCrW9XLmfhZ0kyFH0C_RAv_N-LnsyI
X-Proofpoint-GUID: P0gCrW9XLmfhZ0kyFH0C_RAv_N-LnsyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2NiBTYWx0ZWRfXzOyZBphHo8cu
 8dJyGTKdkZNrkfThjVwxi8K7YKsoy54gmG76HgLHzCPpknAMqEi3v4HBP5A+dxBlyP4R88J0yGx
 BUQsrpauDSUJ3Ge7o1q90V/5OLPe6i6MgPt20Vi23Mc6nU8BIwbCKm4JUyikAyD6S/B2t+0nL51
 lzb3Mwrh1P5ZlQvKO6sL1u1ipjV5PkgMGecQyj9qG2eMNgtj2qbjH7lBAaAuMOuFtM7GQDVPyQL
 dEBa160Hbw/LOdiQIkAC2cLFDwFzXQM3ID+Q0oEDcdCCoaWIsGrP2RsE9Jp/NMOzEciZ2caNEbL
 mv2qw5Er9XDEee/8NgrkiC47VZq9v3wK15GTmp5ChmecA+8uHVQua7cMd6TkW1mhBB2RuerFfl+
 a4LG3m2e3vWwsGJr05AzQwMv0WTBvVn1g5mCGOEbBfilYO5R0n5xGJ2bqqmG+Sxfhtu7qdvO8CJ
 X6XcMUO+ysoLnk/YUEw==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b00792d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_J-3HC_dJu7vbrgoKJ8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2NiBTYWx0ZWRfX2RsilPhK1Mvc
 Lia97EmthjnLmQIJUsmIxbiZuCQ4fW2qqfzhZosl9y1VEee2UVAlCx8hNhMIGFY5hSItix7oILE
 4n/YYCO4McczkQIBsjGboHRCkRY5+t4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200066

On 11/18/2026 12:05 AM, Slark Xiao wrote:
> 
> At 2026-11-14 02:42:46, "Jeff Hugo" <jeff.hugo@oss.qualcomm.com> wrote:
>> On 11/11/2026 4:56 AM, Slark Xiao wrote:
>>> The serial_number, oem_pk_hash and soc_reset attributes are registered
>>> through mhi_bus_type.dev_groups, so the driver core creates them for
>>> every device on the MHI bus.  MHI client devices (the per-channel
>>> devices such as mhi0_DUN or mhi0_MBIM) are also MHI bus devices, so
>>> each of them ends up with its own copies of these files even though
>>> they all operate on the same mhi_controller:
>>>
>>>     $ ls /sys/bus/mhi/devices/mhi0_DUN/
>>>     driver  oem_pk_hash  power  serial_number  soc_reset  subsystem  uevent
>>>
>>> This is wrong for several reasons:
>>>
>>>     - The attributes describe the controller, not the channel.  Their
>>>       callbacks all dereference mhi_dev->mhi_cntrl and read BHI registers
>>>       or issue a controller-wide SoC reset, so writing soc_reset through
>>>       mhi0_DUN resets the whole device while looking like a per-channel
>>>       operation.
>>>     - oem_pk_hash reports failures with dev_err(dev, ...), so a single
>>>       failing controller produces one log line per registered channel
>>>       device instead of one.
>>>     - Userspace has no way to tell which copy is authoritative.
>>>
>>> Move the attributes off the bus and attach them to the controller
>>> device only.  mhi_register_controller() now installs the group via
>>> mhi_dev->dev.groups before device_add(), while the channel devices
>>> created by mhi_create_devices() are left untouched.  No functional
>>> change for the controller device; the files stay at the paths listed
>>> in Documentation/ABI/stable/sysfs-bus-mhi.
>>>
>>> Note that trigger_edl was already handled this way, through an explicit
>>> sysfs_create_file() on the controller kobject, which is why it never
>>> appeared on the channel devices.
>> I agree with the rationale, but this does appear to change uAPI. Are you
>> sure no one is using these on the channel devices?
>>
>> -Jeff
> Hi Jeff,
> For oem_pk_hash and serial_number, all interface returns same value.
> I think there is no need to keep these interfaces under the channel
> devices.
> 
> For soc_reset, it write the register directly and it works for the entire
> device rather than a single channel.
> 
> So I think there is no problem to remove them.

These are uAPI. The golden rule of the kernel is that we do not break 
userspace. It does not matter that their existence is a "bug", if there 
is userspace using them, then we must keep them.

I could agree with you assessment that having these items on the channel 
device is a mistake (and I do), but that does not change the rule.

So far you have not provided any data to say that userspace is in fact 
not using these, and therefore removing them would have no impact.

Without that analysis, I am sorry to say I am uncomfortable proceeding 
with this change.  Mani is free to ignore my concerns and apply this 
patch at his own risk.

-Jeff

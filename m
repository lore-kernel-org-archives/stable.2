Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782596;
	b=nwZfEnMLcGud8CjSBE85e/g7J2yuQPg3W2wl4xUjdTHmHletuTletgwvFRgwUb5bIbgm
	 c9+44eo8yOCQcVs7cb2/6Oof9KhODNU1LmNSDuLs/TzvWcBcfUjYRf+J+ocExoqz/q9iP
	 ZeQwS0DbVsVsIUQbR9fBA49jW4LVAKVtut5te2NxDbajjU61TUG/IECO6DoPnejUNqTkJ
	 /+evF53t3IuFY/QDUWkyV3y5mg+YR9NMPoV4X1YULHi4Xh0j3qGCg1mTVLXOQsX9oVxLt
	 xIIN81OiMUaRcNadKDW3C99OHJskPBhIybyPvlmqk31TZ2Asbc7+aobroqRW7+U9s9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ti4eSTBDmZFdm+uBFFei0a74Hc85Zmg8P5LMfNCYnHg=;
	b=HcMloSLcCAbmMTxeKsdtMWQPUbqzSdYAcwqiQW57ccGXr0vg39WYu65pu2HJ/lXx5p+5
	 BjHZ5WABkASp35B/JwAp8e3t6ewYEdzSb4W7ikvfTZnf1ZYjP3iF+lxkRu7/6jrxTGdra
	 U7JVCxp/9KR+Q1ASJWi2FzSlGXeZM3iPZ0OnfWnkmVbiILfHmamdlNiIrO0adgv8YVmj9
	 o7ElF5/4SR37nkBFQwK0VyJacD72e1NVN3xzI19YVEEWXa8CVYTz8FtNTC4F6SKUe4WM6
	 uFkILsILge8WKUfJ75l5RSpJ6hlSDk4Str7qsUG4MHJeLUzGlsmtpNaTdlv3gvBYY3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kn+9XV1y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EppFsVea;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EC606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kn+9XV1y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EppFsVea
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApDLJ1377029
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ti4eSTBDmZFdm+uBFFei0a74Hc85Zmg8P5LMfNCYnHg=; b=Kn+9XV1yfjnhjYAM
	m5dYVj+P/eXoYNTYmNSJH1qNZWewfhkm0SM3xTcVKOtag+RrHL9id8l3DRyn8Q7O
	2ONwELDprTsYla/i9ui+1TVLcWQFbzjO3C68qFgbHOcXBUhdy0SBMATrvTZUSCat
	CTaF3by6QkmdyMSPq6b0f9hJL5lUDTgvcJODsXNUuGaL/iDqEjdFjI4l4mnwK2nm
	92kOtxtb+2P48G7jk4CXiEccoPlQVaiXwduyk4wLe6LabqRTFVIaEid4GDF/WSSI
	eXPRh0CAwhZI5q+LuVJtNKN5rM5P7CZuyrTI8MTdLChjDt0Rv9YbLG0a138evwZC
	Zp0qIQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3agtv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:29:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869865a304so4094091eec.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795782593; x=1796387393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ti4eSTBDmZFdm+uBFFei0a74Hc85Zmg8P5LMfNCYnHg=;
        b=EppFsVeaV6N0nyrh8SmbFWlD92Twq6ri8bcseH1Hw0ClUXbUdIDXnx/zhICNljjxhn
         IA21YypzKDFON5Zp6zfX1ouDiQ8pqNO6Hjtf2vbYPTmDOjnuxThEJ45u2JtaSqxlhd7C
         dS/VtGZI5KK93maBCqh9fWx8UNk/y0XK/EUhg7wP6bBPFQlAYglAenmT08JEqbzPXYT7
         cKkpvwBDM3g1rlqRU9sosv93CovAQd86dJdaaG2npd12uSl2HE4snBQzawPdmeerHNCa
         xLX96uvF5pNFchbYqxa0A8KL88t/2g+ZmoN17EG+7HrocVlGY6FkOqYxC6WuAyntVF/S
         k51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782593; x=1796387393;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ti4eSTBDmZFdm+uBFFei0a74Hc85Zmg8P5LMfNCYnHg=;
        b=H5MnrsJeGVgafhpR8DdZDCn/09iPpjImkMQx0VZhA9FqoIeSjlyfVhg2mErtEzzPnS
         C5vzHii4463hB646RZ2DeZEkfnBQndauRA2r1Y4o9n8zyp5M9bBcZsSvZ8OUWz2gqtXO
         g3/JlDLwiBdE52ZivhKXjz5fEc/HvxB9UPgHDpF4gbQ7EsmrfirogjHK8zF0zNz/BdVw
         4SnCV7krEwx0ZyAY8WJCXN+VDWu0ZNxRzYs0KNnwpAI7hJwTH7e2iSfGp/gtjClZN7s2
         s2e+iOFrEvB+yUk0KiVTGf9JTF+9JzXyCvPrltdeykSx7ZO5vEpcgksm5DbFYODq/5L5
         HYww==
X-Forwarded-Encrypted: i=1; AL+hErEIiklf/gL0vxNWSAVy5m/5ckEilQbYRrZL4B/8wqgeX5D8EdgZfZr5FEC3+WWEz4ygRGhbFd0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b8/ILy1hetfG6RnKFiYLx3IEN2bNJN0tcA+q67Ygn2U9y6Hxw
	X5tqHTJ16UJYv0qHZCWyuGTR9RJvV9nh+sy7QRsuFW0/LlALbnB3iUe8tHXnB+tUW7vKWll2T5+
	tWDisqNVnwLY2Khapqyul5bwpRvdt7Z7khisoASIXB0P7rjPMF48T57PZAf8=
X-Gm-Gg: AZFdTZcxfHOOvfVRJHmP0zZ1wsDPsA4JVfbNH6htV7AhFArpfAY/IazVfwoIc3AIp6p
	Gz4VVC0vVrbviLhPgpaLnEUsfmZZXRMXVo9Myh030QDEEdPN+2hDyNXj8kIXB1mJY76UFOofZO5
	txYOzkjwSNKfbyi/3V80G44CRbvMcN0rpovNm1GBY/8yVVypNFXDsNlvkjIfmMFzfXCErvbxkhQ
	8SXXTqCGRUdKfyVlxnecXAOFzEWJAlAr++8wpvOBS5rfLKLk9wZh3SvQTHYoXhGWoQQv9lwc6fS
	z3+BDxE+sJ9jUWOYZWDUc4iV2TNDF58lqBtw6A6DduwGkSFIZuJq7k95NRSsYfJ0Pw58+8aRHcM
	VQUH8b4trJn75NjTRdF3/N4gQyfEKjcLxpb9w6zCkoNEw51ML7rdxrbnZUOtX+pXAQqTO7wwXlq
	HPIPT1Uw==
X-Received: by 2002:a05:7300:2156:b0:386:42f5:37c4 with SMTP id 5a478bee46e88-38642f53d72mr31457732eec.6.1795782593330;
        Fri, 27 Nov 2026 04:29:53 -0800 (PST)
X-Received: by 2002:a05:7300:2156:b0:386:42f5:37c4 with SMTP id 5a478bee46e88-38642f53d72mr31457692eec.6.1795782592750;
        Fri, 27 Nov 2026 04:29:52 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm60695792eec.25.2026.11.27.04.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:29:52 -0800 (PST)
Message-ID: <042b79ad-6036-43de-8157-752db5d7734b@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 17:59:46 +0530
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
Subject: Re: [PATCH v3 4/4] media: iris: Wake up blocked clients when the
 driver is removed
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
 <20261119-iris-handle-unbind-v3-4-52d467a13907@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261119-iris-handle-unbind-v3-4-52d467a13907@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b0977c2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oO3DLwcLetx5d5aH5KEA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: hsJBpP7fqsSfGW1Xz2E8GkbhbWhVNnNL
X-Proofpoint-ORIG-GUID: hsJBpP7fqsSfGW1Xz2E8GkbhbWhVNnNL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OSBTYWx0ZWRfX0LD1TUxLL2Ef
 VgC3nh6Wd+DSc4iTYcV5lS0Ki673EQ3jb7mqxr9mwnL8rjqVXiTlqQA40X38NnReipi9qhLSP/W
 cTrbcsp+0syXEedl5Kl2n7fgROvVKCHJK2+xTyr9Dss+Up97SUapmUoxceJomYi2DLqJZOGU/Rv
 5a8EZimAr57lrvJWk10kBY64ZOkvnvd7JyoX6I0e3eSC0Wt7TStuUkUCjx7RPbdtBE+2qGLOz9k
 oNPs8HDzL2CVlxP/ETWxCD9SCxz+rd3vZj1kdET3LvvEGMAcacghAXqXufa6wZutNqgHX3Sp18s
 YSWwEARKK0KayClfwLWf5G1Vj9rx62iUIDEAGAYiactFFT+a/PkdQYYC+YXQGxOcy02n0wDGrGT
 R1wkQ3Q3hLkQAEsFqvUJEY3hhJp06LVnJkVSJKy0Ma4utT37W98DmQXF7CHNRwEFEXhGAw+rRJm
 acBT3Vx4ptV5/7bthgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OSBTYWx0ZWRfXxh4NL9TQczin
 ZPg7KlQ/v8y0jWA/VzqKZt91ijqt6UzTgThrYHUwDE7Dp9HepvI2QKbRr4DtqcQk664RVZo5bJk
 +znN4yY3DuJWG1A1qyjq9wkaPnnz8Xc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270049


On 11/19/2026 5:15 PM, Vishnu Reddy wrote:
> iris_remove() does not wake up a client that is blocked in
> VIDIOC_DQBUF or poll() on an open session. The client stays blocked and
> keeps its file descriptor open.
> 
> Flag the vb2 queues of all open instances as errored after the core is
> shut down. This wakes up the blocked clients, which fail with an error
> and can close the file descriptor. Skip the instances that are already
> closing, as iris_close() releases their queues.
> 
> Fixes: 38506cb7e8d2 ("media: iris: add platform driver for iris video device")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_instance.h |  2 ++
>   drivers/media/platform/qcom/iris/iris_probe.c    | 16 ++++++++++++++++
>   drivers/media/platform/qcom/iris/iris_vidc.c     |  5 +++++
>   3 files changed, 23 insertions(+)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>


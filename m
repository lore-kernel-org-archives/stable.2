Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA85471421
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152712; cv=none; b=O9B0Eqa/DHkWKQysamofAGHT57EpoUWsvneaszq7WXEQ6PjfFtsNR9sfO67WqxuowNIKal0FFjSoxqUbyVwRsqpBl1lH2Njd4ZiJeBvbT30ppRGZet6NawD+vTDtHwoS8U/79bu/VbywRoGtBUyUu53ie9dNpWF4ISzIC3UXh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152712; c=relaxed/simple;
	bh=yyO1TjjuZ73WiNg4/ZkbI22ApDsMSWGk15dUuD4XbsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSCk9KqJTL51dFFSU9S1tQSKG5aOCoVt99CxoOCKTSS9Ae92/4ej7pJHlNsK6DN4s8SCavcHP0nCpZVTYZsGvZ/BjA94iZtwc0jn31tF7TfASbTVuD3L1sMMnsX/+mFZO8af7Ueyt24yuCpASZOY6aZt0NaEJshvY3Kb62jH1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtxTY3Lg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zhn2gsns; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtxTY3Lg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zhn2gsns"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JdhQ1387507
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cDb0sGso1ETTrzZaYUFiyqOj
	3EvRajpbPDzXFX1BXvU=; b=gtxTY3Lgmo0J0t3fEs82mwgejpRgmqwLUASBH8J4
	Ki5McU9Wa1putLIOnCfeR2umYGTLZ6dtjd1ldPWAKWKVn0+w/voJ4XwJk9Nk10sf
	W9KLmbiD0eHslzVSQMR3TXdKVYrNK/iPV72ioqmV9QIMX3dFcY7fUPWfIogvp95O
	tFEn/ctHVnLWvtBvr/G0nS28K6k4pyyo280LToKcJaaM2dqRv6X8Wt30Wd9A/h53
	oBufjpMbb6PvGqZVBOyfmUhbDS8DKbmYehYdOogamQvaZ+8nS5ZNkAlFHv6jhukm
	O1op1TidfRMkeIimSZA9w9fkPzmjcp4o89brDadfG0SZ2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma2wq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:38:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9393ac4961fso98009885a.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790152685; x=1790757485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDb0sGso1ETTrzZaYUFiyqOj3EvRajpbPDzXFX1BXvU=;
        b=Zhn2gsnsHhS6Nzv8y+/c+rW3oWJCtPmHGsG1mtV3+NptTYpprjv2hshm/SfvNImBGJ
         d0EwYgTxKifE0H9DtIrN3yP5751Y8dBuII1gU0e5t/p6yR7RwM/K9KjYk4EXcqTxLm1i
         9NcjIFiHXY454YqxV0nSlunE7Tg2O1Suc+vZLodVqM3blUUIkEJkXCsOwA4jhegtBNnN
         O7M30ltE9K9UIKucvWnJbXpM4kYqGnFTOFM4YKwpy4smpoEFV0OFVb5MxzT2fHKXKp9k
         haiaDJQQ5jxZkGQiQVCDfCm2Pmdn8JqBNFc8VzIgSWy5FaxvQRV8pfEOaYvkzcKSMzv4
         rlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152685; x=1790757485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDb0sGso1ETTrzZaYUFiyqOj3EvRajpbPDzXFX1BXvU=;
        b=GrrBMM4k9isVgqZ/34+ljhTkCyyMwmpQ0I+F3S2hwOOvrLPEUPmdchV383QHaD/CuI
         Qt11MgmS9Ge6IkhegNZI3hZC0Gw7Lvdj6TZ3gpILZyvAFYnJa1Mjsd0qk8fNwL4OwR2K
         jSKgF1vDhjWLEzLqXHv2KLswvtq7f/VMWbtitoUcOSH1e4VSBRMSHnqIP2SZgs7rX+C8
         03au40CDPgs6vQyM8bWxhlncb36qLCvtvEHGOaSrfy9fGeYHTK1DuUi8LZk+CQDJmEGv
         t3czsCHaCkyIpbLL34v7MyvMipIZpar3Rfw7KaOGeNkFS4pBVTODYZ08SIIFvtTW8r4/
         fxTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwC4wGlcNjsSJ0sHvGxaPLQOk8rC5SsOKiHxNcey62PQSDpt+vEuNQk4rkuaiV1HuOsLTAIrhE=@vger.kernel.org
X-Gm-Message-State: AFuF++lBs4ruT9/BCCn24i9dzO4VOysP3EHbo28DA5MfOIbjj1J1UjZV
	pcSKWYTZEAToSKOAvoVaBC9AWrWa+tQBl4mWVYemUprf5IMxEajVPV1b/WMc7VyfT5sbVhG4BU2
	k5CjYeQ56k+hW+a89n70uJywM6qcHvrnQY/WHgl7gNLINOCeHnuEwTFY8S5w=
X-Gm-Gg: AYBFou3AqQ9XDUcJzbqXx44bSEB3caJPpzS3Z4TAvXMhc9Hp0HxjHNrR/RIdqMk6zso
	zT85dBDqb5qkq8GXAinrkkPbtdxCuiadwYb1LYEb8/6ygluobZM9AsDGoBR8XStz5aDrgb5dete
	RW4OlEXBCl3m8RL0AJfg2u/RaeOzroz752T8d62WFzQDfg0hX0R31h12KR+tueCTVlT0zFhUjNr
	tof+sEBpe6oluxAKFRBlLSUWyZZlgT8pZH89ZS/nKcMgVy9Ieesaok0RPko+BTkI2ymQq6C2dnc
	8Qp7HuyM4yxMVuvH4XrFhUQX1EGwyFaVUFZQZLj6nnSaE9Qv+XjJFQE6tPGqIILwePICp7mkZrT
	4Tr+K2CvVkHFWDHKpQNXiiYl9ghDA8iKDUAbDHputg9UsBBtvAf8ZvjeleXcv7jl7qlJgcDj5qR
	KToxFFOuu/KhYx
X-Received: by 2002:a05:620a:4054:b0:93b:c581:2e16 with SMTP id af79cd13be357-93c250cdf90mr298719985a.30.1790152685313;
        Wed, 23 Sep 2026 01:38:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4054:b0:93b:c581:2e16 with SMTP id af79cd13be357-93c250cdf90mr298718685a.30.1790152684724;
        Wed, 23 Sep 2026 01:38:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d859652esm418457e87.83.2026.09.23.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:38:03 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:38:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] usb: typec: ucsi: yoga-c630: unregister EC notifier
 before UCSI teardown
Message-ID: <z7v6erddxh2ydm63xavvfb3sckvwsaruife4bz3r7cpwmyg65r@j44ta55rkcgg>
References: <20260923074828.489562-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923074828.489562-1-fanwu01@zju.edu.cn>
X-Proofpoint-ORIG-GUID: wet14RJ0w4rgFlI88ZVoCUbVHt7V9dXY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX+QOv6Dc96qU1
 YWKGfimFXD7S8p+z4FalAWImHrIZrdUh5lJozam/WsAXHQMXCnizYKa0OWPa+OSMNwGHhKX4urc
 DDjFl+M6YOgYphhYRpLwfjTcb8W4CdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXyOwH4V6DjVnV
 h0UCCGw6Dod4OhAFX1yQdkEFuV41P7Plb7qRrShavVurowk63wbJ5gzGAgBf4xn9ZNrl+9cYfK5
 ryWsLzIaR3ybmrIh1SHElxOLdJyhJX/C4HWPveBykVPOfRCiIGNX51u4Q/It4p5CwyH9AFl28j5
 Xx7zSZ309M4bCRJnLyzTF63GnZSq+GnX9fb94ONy9KtZy03ZE0rI22oYObiT52mfV3+ybj57ksr
 YLItg2gDN0taq+tYGOhJOkB87xZWtJ8sGtzJAfTAG5TKd3LIfkLLkLknm9lEv8xaO374yTS7fM0
 v1lW7ZPbT6RIIhUP9meRAIRdXF4h5o+3F05vjb/1j84fHH2++TC1/3HTU9yhL6v2wKBtG2Hr4CP
 iaaASDqjkb19c+dkCQT4t2pJJv38kmKAJiUHA7z4Cabk45llXSjY9Tr6ZV6C/mVbdgrVRl/aHTS
 ikh9r12rbLfTsO50iYQ==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab38ff0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pIWJAyJa_h66JnIjfXsA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: wet14RJ0w4rgFlI88ZVoCUbVHt7V9dXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230034

On Wed, Sep 23, 2026 at 07:48:28AM +0000, Fan Wu wrote:
> Both yoga_c630_ucsi_remove() and the probe error path call
> ucsi_unregister() while the EC notifier is still registered.
> ucsi_unregister() frees the connector array, so an EC event (USB, HPD or
> UCSI) arriving before yoga_c630_ec_unregister_notify() makes
> yoga_c630_ucsi_notify() run on freed memory: typec_set_orientation() on the
> freed port and ucsi_connector_change() queuing work in the freed connector
> array. USB and HPD events do not depend on the UCSI notification-enable
> state, so the disable command ucsi_unregister() sends to the EC does not
> close this window.
> 
> Fix this by unregistering the EC notifier before ucsi_unregister() in both
> paths, restoring the teardown ordering from before the error and remove
> paths were reworked. blocking_notifier_chain_unregister() waits for a
> running callback, so once it returns the EC interrupt thread can no longer
> reach the UCSI instance and ucsi_unregister() can tear the connectors down
> undisturbed.
> 
> The callback is also the only external source that requeues the connector
> work, so the cancel_work_sync() calls in ucsi_unregister() can no longer
> race with a new connector-change event.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 168c3896f32e ("usb: typec: ucsi: yoga-c630: fix error and remove paths")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

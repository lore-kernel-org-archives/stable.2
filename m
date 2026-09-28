Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB4547056
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618870; cv=none; b=NxZ3nW7liNmhE/AFVNQnDa9aEWwuRT9Ts6vM1MX0ajMAKDmr2CHMbsz606BLge4UE2xoo7+PK3ZfYKdiQOzmho5x2Eg8vkZk5vfRE8q8NGESmcqvd56IXVHGFOFYxA/5Tr+Z7mSep/HermG51DywXA4cql3I62OsoAqGHep7rKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618870; c=relaxed/simple;
	bh=jrIzIqdsXW9XN0EginlPY9EUOCV3pktmyRnjeemZhGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ragrKcnqo3A21Ye3RZ8dW0p+FpAifso4Oa8sdO5QcL3glalLEn36DLkYID+0X3C2FDnkaU15afWH9cokURvZmAvUexWD57g46qRyV7xL4Vupm8Gbp4zriujyAKvmLSmNjSyvAXqgB7phpMqBx5AkuxHN3hc/SfF1LtYDVsYGoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UF4PHkYX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bUdw4tKF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UF4PHkYX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bUdw4tKF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SHvueA2338401
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10DfQ6Z2QM6w0dvQ2IWLX5tdv1brJzI5V2bGF0Z9WzY=; b=UF4PHkYXxyKyuWg+
	YvrijZN9s4kTdVG+76g58Xf/qGGS4D+j4vM/RLAB0jZbcBEj5dsKI1Y/0VKhKEDY
	WATSKkaFlI6e9/p+U1e3lGER6B8scdLcWZiqgdodo9h9B0Jp3xMtpp5juNVArv8D
	4dyVvj/Sqdn2ltPNlHOXrqipoOHqDEJXai4iKruU5ow5YEYkz9OcmsObaXtpPnWv
	UyI7525NG58XratvJ9mtZ73ttkblrOqasB8N9zvfhrd4GUAgxKiiSb6beBci4bnj
	dBWxuaCBvfX5/fz5YSicpEMYmc9QAyXDbb16WzJhA9hhdfIySSWNYm9y4jr8vqFm
	TXcaEA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s2y6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:07:48 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1438492fb40so4871367c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790618867; x=1791223667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=10DfQ6Z2QM6w0dvQ2IWLX5tdv1brJzI5V2bGF0Z9WzY=;
        b=bUdw4tKFuF90pxb3p2IwGRI5EJcBRgTrTtAmg0qfMvOZ3/XS4xiay4wLzwgowQHnPO
         ogpgEC2ArLV0FuLVwhKDPaqeCxF1nafsdXw0U9+2PmcaAbpyuyRDVvD/gbByJnE59CgI
         rECiqKr+fl6IbNTYG/WUvBJdm7CYeI33IWKs/akht/b8CnBBcvApOWIgpJnaBg1IKnn/
         TdLJbaVqblLQksJ//Zg0ypD7/q+CoYTBmGDy1tXfSuhTf1CjAPd3Ci4jjq5LZkjaCRnT
         2US4nOzrtbMEs9o+e/hWdUg9JCFSD4NjWzXB8/kTHcaOobMoudWvtEgTlC24j7dLETZr
         mTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618867; x=1791223667;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10DfQ6Z2QM6w0dvQ2IWLX5tdv1brJzI5V2bGF0Z9WzY=;
        b=g/AZBLnDDhkKnO5vU9EkDKUBwQ4Ct/dG2jqtIXWLbUP+dU0791TWwFLhPv07ofNZJ/
         r/kZkYgoXRMekfqixRFHb768L01hcDPuE+yIxMjcztZp+74cNMfxcQEs4NvWKyP7Q8W7
         LRrkpm66LsnLAHsrjvl44x8cWvPTOBhlbrPN/u0GH/08TTbKE6wre/ZYfM8+C/nFER/T
         VBwsigc//7YEs7Zzk4n+I3/ddMrLrnUDH8IydeStaizluoksuAsRzNgedi+mCsNg9tFK
         B+TTUPSR2y4KsioY5q1IQ+oZqJtq7T3iBdQahgBXmWwxoKDxlBXuYvAtYF7OmCysoj3I
         AcMQ==
X-Forwarded-Encrypted: i=1; AKwUvByNxhAxi0OSHKOpvUWKN20t8UzAOxBY3+SgzYq3sgCYFOdoRIIP1o5LtPTZK++WcG8Fut+0evc=@vger.kernel.org
X-Gm-Message-State: AFuF++mr8949c7U26XrUznHPbU4R45gcJGD4O+7NJ8KVB2s/EdAcjjBX
	oiTQ0mBIthahD7F+4Sau7OKmSMSzdv9NCSkdDlDeUycpFQuI77CXBRHQS3jrQerkMSvH9F2O2rQ
	2RaMYcisfRzG3+BtgOb7ZEjlD8Hg3Ck0A6i2ULKPBISMZ/F00DR30OfJu+4w=
X-Gm-Gg: AYBFou1qXqDSIf/msAZAVRmT6x/7kU6wzm2WdmMqaYIdyMlKc1d/nQO51SyHR4VNVip
	W6bl+gY/GLGc/6LOkGg2txojkQRs3gqzQZdIIKQOyXV3D4OnDLalAi33ufksVgWQcvSGZqWHTjc
	J6vFQhYoC9Z6EvOQxVtERxVIFyZ+OHtIOsBr+opX65dejR4nASGA//YNlPFw4qswqIgeY/BZiW5
	pue36mUtTwJ/PtWqO1Qll78ub44ahmXxHo+dUrTV+RvRleX37FA34Bfmc8URF/902N/QO44fZC2
	wZQcjS3oXHSTYpgKFKduKI7zFQO/aqJTBR+tyZPxgLCkFKwnfwEW482vR9klBU4cFFx52zh830v
	HdEgQw+ulPp5i2TfcSg2yx2W4PU2CATUvWLtQGfSgv976C0ZwSiCTtJ2Bzg==
X-Received: by 2002:a05:701b:2402:b0:14a:d8fe:3396 with SMTP id a92af1059eb24-14ad8fe36b4mr1226557c88.27.1790618867406;
        Mon, 28 Sep 2026 11:07:47 -0700 (PDT)
X-Received: by 2002:a05:701b:2402:b0:14a:d8fe:3396 with SMTP id a92af1059eb24-14ad8fe36b4mr1226519c88.27.1790618866728;
        Mon, 28 Sep 2026 11:07:46 -0700 (PDT)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acd3d8eesm24802356c88.8.2026.09.28.11.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:07:46 -0700 (PDT)
Message-ID: <4af0fe72-4b55-47ff-91f3-06221e563231@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:07:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: assign device id from the WSI index
To: Benoit Masson <benoitm@perenite.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>
References: <3cd93e83-6103-457a-8879-bef8521bef9e@oss.qualcomm.com>
 <20260928154335.85628-1-yahoo@perenite.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260928154335.85628-1-yahoo@perenite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX1p68AstfiTW/
 1uMepec6TXjLqZ0Z/ORGu/QXS7pzdAlUbQpCmyes973T6HW2Mkym49O58cTEkTG3p6RsOQz0dDN
 CZ0Oymgk96MlhO2ttTNMudZMCiUblAylN49r8ydNjRszLbIEpMTLoFJlFc/jqcnfdhW4eyX1niY
 Q9jJsjOW5+jjHFE+smMhKV8mKMRWjbOW5zOHJ2vheB6nQkqh1qysKnmBiLgTfbpYhjauc9+4n5T
 QAVS0rC+oIbSO+r2gm0dqlaITPmPgfuYA0vEn5cgsfW0geTngLvpNJvO/xnXaKLh8AoM4Nori4D
 C1nXgqpvJU0ZrDwJBDspQ3imKNOK7nqdiG9f0DOGpSs3HDG5/8fq+r8tGe/odvUE9AAkyhtObk1
 nYhga5XaO9FeNo1HgYuBdFvCEbiSR0o0N3jTL1jCcZg2J7+WhNdzB2Jx44YSlhCyKdaiH072RWh
 09rGvrTxTgoAMR+Qa2A==
X-Proofpoint-ORIG-GUID: cT2lBKmWM5U7iGEoF5RSqVAOPiGZrpj_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX4tLOrMSgYCcv
 krPSINMVhhx3pMVPhapowCcapz5WIBqUzy9H/V8bJgj48HSTWqIeOr4pAcHTH9alD4Pl1pme3RG
 E9womvMZfksUsAvQhlhcSSfTTN2yiN8=
X-Proofpoint-GUID: cT2lBKmWM5U7iGEoF5RSqVAOPiGZrpj_
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6abaacf4 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=LV5C8B2hAAAA:8 a=33sO1Vo68oqyLtPrM3MA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=uiVh3g-rw18WZz7NjXbe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280072

On 9/28/2026 8:43 AM, Benoit Masson wrote:
> Devices of a hardware group are added to ag->ab[] in PCI probe
> completion order (ab->device_id = ag->num_probed++). The wiphy radio
> array is built from ag->ab[] and the wiphy device is taken from its
> first entry, so the wiphy path and the radio index to band mapping
> change on every boot.

you don't describe why this is is a problem, and hence why it should be
considered for backporting to stable kernels.

> 
> Store each ab in ag->ab[] at its wsi_info.index, which is derived from
> the device tree WSI ring. The group order is then deterministic.
> ag->num_probed remains the group device counter. The unassign path is
> unchanged, it already indexes ag->ab[] by ab->device_id.
> 
> Verified on TP-Link Archer BE800 (three single-band radios in one
> group): the wiphy path and the radio index to band mapping are
> identical across cold boots.
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Benoit Masson <yahoo@perenite.com>

SOB doesn't match your From address. So you either need to change your SOB,
update your From address in your e-mail agent, or add a From: tag to you patch
so that From == SOB

> ---
> Changes in v2:
> - Set ab->device_id from wsi_info.index in ath12k_core_hw_group_assign()
>   instead of reordering pdev_map[] in ath12k_mac_allocate(), as suggested
>   by Rameshkumar. mac.c is no longer modified.

your e-mail subject doesn't reflect that this is a v2, and it was threaded
instead of being sent as a separate e-mail thread.

when you send a v3 that addresses the above please make sure to use a properly
versioned subject and send as a separate thread.

Thanks
/jeff


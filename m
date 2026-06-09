Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7206376BD0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002853; cv=none; b=GzxWOTOYXquB4j500LsaobbAVKLRcdmyBeF4uo/Y0QlcalwLQ7YfreEI9Ac8z7qxJZ0U0t43dpkBYLomeGnusyPVFWaBhq/ZX0vdtns4hZEy5u3VCn88kBx1LEWl738PsFQyHTlxiVqfAOs649HfQzzQQhmj6vXRkpSD+cD1gCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002853; c=relaxed/simple;
	bh=y1rowJMxQaGWb4JIfksAagTPim0cmlPxRHjXj8mdpeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isZlHM2L6v7MEqMrfHaUNfC9AQojUC+xfkfYylSpU4UB1dJ5k5zCslHx/65QI3WKn6qRWHkfm85lf1LBumdabdYSnxKRSgQPKIg99ohuidway9WjGrMeE05t71tKV/FN1+EYYKJFK85LVwDRR9w0U3AtZBG61TUcZqiFzvZ0B/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROLS+Rf0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f5QB/QFx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROLS+Rf0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5QB/QFx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599xne82245917
	for <stable@vger.kernel.org>; Tue, 9 Jun 2026 11:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QGn80Czw+Q8aNgWthHK97QTsMBMg/HtanGxumcKLgUM=; b=ROLS+Rf0RgXL7Gvn
	tkk8FHreJAvZqLmANpC9Cqsjv4rLZno2Hp4Xb+0FGvV6Gf7TUuZHcgyeDfXhFBDY
	b/KAn2USklQFfwhU+8eCn56An2IqQeaIbyy79jTXUdHJxBgvl5tOQ4JE8R7hgqkL
	n4WwzQxKGvVtN4/1z29X3Qi0LXzCSuhGyYYj6kIK7VhWmFKA4kW7XGUFxUENsYf6
	kk1DDCD8ROHxI4hckxJoymPl9retNx7KIYSFioTf31F7EZDqBNyZlo7dRK9clnLo
	C2j5Bb0Yml+Ib6QrndeDwj7rXGu0WmMQ8iAkPLR+ki9ntHijhP5KE7Ze7zVK/BXK
	VI4p9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds955x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 09 Jun 2026 11:00:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf08c2a24bso51877235ad.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002850; x=1781607650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGn80Czw+Q8aNgWthHK97QTsMBMg/HtanGxumcKLgUM=;
        b=f5QB/QFxIQx0IiVUsOvov5ycl3PdEI6XmoKFMF3wutpG6VH7GF0mXDwfFbn/fjB9T4
         swUajfs/J0L+Hrg/owAPKRBY5XYY9EMrOEV/vH/LeV6zKVWZ/QQlQ/mOnCDjTGOwv1Nb
         8mvCgPkE8sZhM5heR3A4sQ0wRm24gAsvCcK1m38R0RPqxO5DxD9iaTZiZJ5+VY7n182i
         xZCrh0WSIQDZn3lYQpdkjo+uSUKHsTR0Qh1U80FgJ94agoKVhfGNdT/R0XjxwCiWqKUG
         s31jadSYucAQSubxrf6GM2MumQHGeYingeklhaKWZdIcvcMN6KKdm0FBovmddDX2Ip+Y
         4i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002850; x=1781607650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGn80Czw+Q8aNgWthHK97QTsMBMg/HtanGxumcKLgUM=;
        b=Dww5KjLt4bhdVE4JteckOyFfRPJbdpGUt9AIuZ9CxyNcM7v5RnJEsUwVeNBtcJJ2NP
         GJQO6Ouk0BckY/iNLoeqKDjAuN4zJ98uQDFKLtuj70fM93NgOp8+ixIXFG6MfXaTRmF+
         EwgsXf8p9pV5nvUQXhDaM8bT6aq/0aBePZGWzchgKknMPm55cROH8DbulyeSyGGVvBLu
         3yqzxM9bu4JYJ16QXIbI+JQfHggOO/kP0JKVlgUR+ARpIbx5XY+fTzBOAnNk1ngvQEqj
         ecn3Dv3j8Ua2TmQoY+vUB4NXCJj+kFTiU0EOII7JdZAr1c3TH02cTDo3m38MvB3FZH0B
         KABw==
X-Forwarded-Encrypted: i=1; AFNElJ+3LBhFNysY2q4lqxj/Akg8kCCaN0iPoNXTZ0thPfXzoT2y5zAhXVIG9GUd45r3YcjObq4eIic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxTnTbeMVdLIBqK6VHq6Qwjs7FHQW+u49uj7gUFGAWdNFCKJy
	uS46a4vpCsxpbYCueZioZk4p5hcPeOkvTGpuycSVFWkTMQ+5dn5KwMcwtEIHNGpTaMNDbUEFoSB
	w/hP3mQCcjtmTEb/82HDNvRSF9WDBFSjw32qVyt6pa4cfNWKJ58WoR+tDTIQ=
X-Gm-Gg: Acq92OFecfeGg1+Uya5Ss2DVnfYElvO5e0XB6WPQj0g14cV5gQiVraAcMouPPqb0cur
	hhEjRYCMKgE3oja6gxVbEC78jx4qUcZwQ56Fdn3qAju2tpjXOxl6NSnXyOUJ8BKnrli4SgH7z4Q
	cFL1MBh9RWG9KQRhm24y8Myu6Fx/EYHqDNIB3X5gpvH7wJkEeqUEa6uv1e1OlqrXQ7p1YVVNU8y
	LlioJeE27MILVKJ1mA52fddr38nZv+ORoxR9RIMlTKBAn+i6WAuxt2p4LI1iyB/eT2Po5geNefJ
	yUmHuxuGvVDl1Cx7CdCV8v24X41kW5bzkIHMLeiDfFdpF3Ddcx/iOdu2b9td6vZRvxAUE2fliaT
	rOkm5/jcFX3OeQVUc61kw8LYyYUgeX4mjSnC8dnuiAKQ85HMBn57At8oitDi8NhSbtkRm1LcW
X-Received: by 2002:a17:902:f541:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2c2a1bb43e7mr30141275ad.1.1781002849607;
        Tue, 09 Jun 2026 04:00:49 -0700 (PDT)
X-Received: by 2002:a17:902:f541:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2c2a1bb43e7mr30140895ad.1.1781002849195;
        Tue, 09 Jun 2026 04:00:49 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm211576805ad.22.2026.06.09.04.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:00:48 -0700 (PDT)
Message-ID: <6545e04a-eded-42a2-b773-92d9e9ed2226@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:30:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix refcount leak in
 ath11k_ahb_fw_resources_init()
To: Wentao Liang <vulab@iscas.ac.cn>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260609092528.220547-1-vulab@iscas.ac.cn>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609092528.220547-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L-BsCpRZ0-305bQ_hWubp75idFOGegDC
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27f263 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q36DTRNDronnURX6cDEA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: L-BsCpRZ0-305bQ_hWubp75idFOGegDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMyBTYWx0ZWRfXxM3dRUwE3w+o
 GyxOPppLn0IIFeqPP02vXGs9YtheAuVdCC6l+5cT3OBEw2hCFT2ZwsoGvdDdUgODnrZ1YHDlXRv
 kwdUg6p6LrSSUNOZBhPR9LHzw/VVlUxpH6j2aKJZ/l3V1zXHDCUBls3d6hjZpYqdcWOnTJj1yJV
 9HxKFJmBLBw72VdFpr6k+rruex3hMMtiKaXQztOlno6csgdMm112aMheCXgWCtBSv1eqcgA70W5
 G45bhRsDhEUYf9DOdJL3q9QkMraWyfz3Kf2A4p1ra2yqfl/sFizn/PDu0oISsOVylCj1bekbriN
 ZSl57wUEjHwlQCip4XMDpE9zulJqJX8O1lEdxi8T+z0+q1SvRvj4cXN56SvnWBpg4PR3BS0FqRO
 BiR1k7Otk7yfuibeZem0hNNeJp0ut0NxDLL6f4krnjy6h6/pt2g3LAdPtdngxS2yQZfkgZGJCHo
 QWo3rjDyj0xydXmDpcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090103

On 6/9/2026 2:55 PM, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, but the error path when ath11k_ahb_setup_msa_resources()
> fails does not release it.  Add the missing of_node_put() to avoid
> leaking the reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 095cb947490c ("wifi: ath11k: allow missing memory-regions")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

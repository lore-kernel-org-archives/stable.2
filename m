Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354556;
	b=SCWgtOkWMMd8N8AUa77lcXhPijWC7mxvSuotuJxWxRCdp0bv/GHx08dl29TFgvq5E3DM
	 v4V8vIzIpAJB0hIYMsLuRDkG8YgVditzvQjMSdQNaWgFsmas1fijKXwzt1LC5VxCelpbE
	 G5BcOnXXdTbCmqxG6kBB6gsEZcarFXcpWpI5KFKLoHjv+Nwa+XrfOxHHY5+R0LRBqcb0m
	 XXl7qwGKiAfQDQ4OKMVf2USE0kdeFxR9sIDlIaUBNUAfaYKAoG7/I9WdjVAIUGxOyRvWd
	 1f9fzr8bG6RLj/5A8RQc7REeKsMhKjKkzIKLBJrDo1NGXARozoA5ibMezImIAiD7smw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354556;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XPOou6CQafNHNZDV+h/LKdSD2kkWtiLvC6RPPBJtYFA=;
	b=4SyW/tbHhurx5JruXp79jp1yKuz/6N9+nMouE28q5LQy3+Wa1USmVZn7+LqElNfYKD4H
	 XMb2UGHSCk6cyRgeuxR3lxoQuzyXp6yeYPvePM/lbPNgSEqa3QS1sG2PQmMzVmh6zJ8K1
	 Sr66tgdjf2o31I4DB33es/aZfOhRrjXIEwPMmyInlSbthRrviSsDQVj3lu/lMiD8MiByq
	 FvKTBQV4uROxSl58isYLEA+Pw02mgiU+nyoXHOUUV2phYGxGnBk6H2FDfNJ4p7HpVJy9B
	 hARAb+hvaK4mBbsT53xi4TCylf9ZG5of2mqhEKW9aGRUOrLCer/C79umztnRZ/pISpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KBFHhwPY;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U4giFQcw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F84606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F84606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KBFHhwPY;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U4giFQcw
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U99I3X3435012
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XPOou6CQafNHNZDV+h/LKdSD
	2kkWtiLvC6RPPBJtYFA=; b=KBFHhwPYr++jbg4TF3vSjdJW1POzBYkAi3+RvfSd
	RtzlrtdMwBBDIaJx7+ddGCxoPXXfmqWm7EkxNxwTiKaEcrFSpMBa4iZEtM3d+eTU
	BIylE7jUINtqtnmJpg37mM2mJdqS08SL1ZjE755XYPuNUalOxi3xRMeTeZKKCjeZ
	EbOL8tbpLV2lQgWI7m+wpdOue51XGnlbu50aUMb0EZ0v4QVqy4tmZbIl9PIM0J+J
	eiSzVyUm/6rX/jfH+EPgir2UQbmcjw40pAZwGygoR1r5wIuOiTq6yMx1YdVlZIEN
	ad4DhGtxKOQRaFQQ5SMFS0d4E87WWuYt78zNnAjLxqNc6A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qtbxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:02:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1221346eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793354548; x=1793959348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPOou6CQafNHNZDV+h/LKdSD2kkWtiLvC6RPPBJtYFA=;
        b=U4giFQcwsLt8O88iH6fF/3J5vLMK0AZLuczdL4lXN18ry31u43LCXFz/OcNNCU3BQA
         CzcnAoyfclP5+Pk4yXSPHrW1OGIB32+aO1klCCIDdHXz3xcaIZkHJpwFYXnttyCXsTG9
         cAhffzpEQDariNokkBMlEFusJlkBcDoBaVZZMxgtv0rDWcgSfBBod0RhJMk0mD6zReFc
         Iv/CA6aOe5AJ2ojj8/YMkJ0dsaDJ9UsWTgS52GqP3hzpPUKwPqdV+yjLoFpM0UEho4d7
         kAl2HTnDCtmM++K98RA8v7+sJkl49OfeY4iIClunqZ3LpTuBX3EwQXl9zU2idNHqlNyY
         qsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354548; x=1793959348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPOou6CQafNHNZDV+h/LKdSD2kkWtiLvC6RPPBJtYFA=;
        b=2XzqUsd2+AROtIFDtiS/epmsBqEt2yuiqyYk+pVrpkdsQdRXuWqbuiw6h+9UK7HurA
         uJ91nKP1vyfpWrxLY1vKowubyAZ/9p3y0QrHlFLqZtg/xsuGkTGA6bOA5cS2G715aDmt
         HED7x4BulyOuUzALqanuK0S/ywtO9Udr/9w7b21LGg+HLc7Xeq7Gt+oc4ggayoUp0l75
         f0A/ejv2sWHJaEyLT0WcK9TYsebmDwvQXLkg4P2p+ZfIYrs4jaxfuxvSOte3JjOl5bvz
         Wgagk8bLfJcAufHq7jPpR1B86nI+DrWkyJkoI30A/tl8f4biW2Ip4XtD1zpHyIdsK1qF
         zKiA==
X-Gm-Message-State: AFq9FYIB8wUTo68tM6veGoCR8EeJlExidA0rKebLnHcK8sQYKq1YwJKa
	7wZzQw/Dsr/072JLDlYUm/rYXGtD2E9CMbmstiH05D5pxIR2qzc6jDWXWNzex0xGHBx+ySyQ7v8
	2Qps99uUMFBe0icREjsrLwg7icmJZyc2/2/Lom0MQvXfFlmfOV5ElCI2cr40=
X-Gm-Gg: AYBFou3xMtZUcQhu+CWqbpz5qsuiZnQctG8zh7q48Hdhu4NWaMzJoAYri/V7CzV+4ht
	K91zK1kcDws4sb95Whgam9quYvvJg7gzR6XTD5usrPl7SUPitGqj7kh2w+xlyfmCBUQn575diCG
	q7CUS7W7cp9S1oO+ViR9WCK4gSkqKhDvoSBxTYP6vxsH/eiH7VA3Ukj92SOJjpw668vwuBcOudL
	GdRA6NPYoSBJqbhPP5cIdBRb4iTGBiHXcxTIPq8gZZvDdIHcSXMTVkD0V+dZqX1CxxTUOaCZAjm
	AkoO9CZgdiS5M6bzaM1i+Lr3Zrgj4KZJdCrwyqU2RPThjUwFJJu4QDjtGHaUnwX7Hn4y9x5q64j
	3T8WBu0TYwYVI9o2J/twLm1FEjfONlvZNnIiQHZ+Ez/VmPSmaako7+KbQ42nmMQLV7X8ulF1o56
	Mr/SZUVFyj2j9dqFA=
X-Received: by 2002:a05:7301:6183:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a423c8988mr2702542eec.15.1793354547629;
        Fri, 30 Oct 2026 03:02:27 -0700 (PDT)
X-Received: by 2002:a05:7301:6183:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a423c8988mr2702509eec.15.1793354547051;
        Fri, 30 Oct 2026 03:02:27 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm6925218eec.29.2026.10.30.03.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:02:26 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:02:19 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Yingying Tang <yingying.tang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH 7.3.y] wifi: ath12k: Increase RXDMA buffer ring size for
 default memory profile
Message-ID: <auRrK4JWN-7rUcG5@QCOM-aGQu4IUr3Y>
References: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
 <2026-10-29-1-daily-reply-0011-ath12k-rxdma-ring-7-3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-29-1-daily-reply-0011-ath12k-rxdma-ring-7-3@kernel.org>
X-Proofpoint-GUID: GfRqOOTfHzOqaWxOJ9TaKdGc3Ez7giNB
X-Proofpoint-ORIG-GUID: GfRqOOTfHzOqaWxOJ9TaKdGc3Ez7giNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzOSBTYWx0ZWRfXwZkfPU2O5qDt
 tyJDI6uEIkd7nt/etyFdDkWonAKucGWhvWB9AsPzplZqqvrJpVmw9YEMRna47RIG8kRkqxGnQKf
 1H7mXxIVQXB9OcQJB/suK6pIw1mhaJWiSv8EmQGIN8xwpYARaZNA8QRnncM/jJbVYVXQZNDNzaf
 0bM5ZOBhoVgcWvsXvt9FhLW/y4xOVq6uB0oV4xEeBWZMbbLl0ESaV+dQMILhsHT+UtPFuRb94cK
 Snf0jItmm/yii9UY/0Y8kv+6TMpqmU8VexCnM50i1Qb02TzMmER+UWI7DF7MvCZqhQm0g8ebeVi
 NVLNkJAW2ZrD1rU2b++jjyXBrE1gYNgUFnahyuYKsaZ5PhnUbygre2L7SDqr2hJF/7uhoaisPzo
 msvnUx3FeHUjCa7ZrlrH0jFQJFwIHgNgZsH4IMR9jVY+A19UeuRVcNEHr4OVMbhLaMU+UYlGUSl
 UT7moOKNRTjUtzXPMQw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae46b34 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=3Y6tUoXcgYOYlkcqMpIA:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzOSBTYWx0ZWRfXxAp/7b4+dKHe
 /PFNkIWB45jLhqSd+Q+vOnjQu/qTwByR1f9AzArf3TyOMhm7hsNOECoNsGJDKmOqlAJx1Rqoy6o
 bx2d6fjspj+IZvQy5TBg2RZCpfG55Fc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300039

On Thu, Oct 29, 2026 at 02:43:18PM -0400, Sasha Levin wrote:
> > commit 15f7603b69a83a0acc7fcc8992ecbea6110f9424 upstream.
> > commit 643f0bf936176c114d5631da7547e991b5d99f10 upstream.
> 
> Queued the upstream chain for 7.3 as Greg asked, rather than the folded patch,
> thanks.

Awesome! Thank you, Sasha!

Shawn

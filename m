Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDD3CEBBB
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074987; cv=none; b=gGGe7kW50i4Knq4y5AENAWrya93dqitGCTtesCoFFzTNUpVz8+FSmCCmOhzxe6Bs/laDaKEZhaXeiAdp9Ez/KL3VLk0QZeXJjSVIUYSKJSnYenOjtwi7ZMDOX1dLawExyxURsoxTyS6Jx4xF759K9Xf8zKvY0IzsexNob76gVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074987; c=relaxed/simple;
	bh=92i8UPrYFM9G2v+lQeSO5oIi2vXqIG/djDXA+JTb+y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO5MRyLHqS1eSiaVQZCaQsIEJIDgL9mkSpDjs4PH0/Op0hxPggbJ5rimrUAhM1TFUW+ptNQytVSw9DuB1pbk3cQUM/Wa5nQzGTVUDmvXnw1yj6YvjmBhA1qam5GAdPh2/pe/92usy+YCJHuHRWWjuCDhQ/xijjOLUEeZfnalkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpJdPjDS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=falUHtrx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpJdPjDS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="falUHtrx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rbKl3136127
	for <stable@vger.kernel.org>; Fri, 3 Jul 2026 10:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=; b=EpJdPjDS1nK7FVuc
	MpWYxPN1aKqTdHLS0tw5yQCXtxcMTIby4BTOJ6bwQUxcn15qaE/22tHgCbu+ZN/5
	uZdmwzjZpBnebH9i0TtMmZozqbP7VIcdjvjMtpYJqKJj7g0yr4ro6chrub1oo7k3
	od8kKowptdwNXwTW/qgPgjzzgWpeQp95Gf6GhhVI5SccldkjHR9NpmlY3ImaaMlC
	APNYEWe8YYQbApC46CZfupqD2RXJF8mAxFKYnwKXMeDpq9hbZNsV3jl0hhuuGTgZ
	7TrBHGMjC7cRFUH0BjOxgEON+AthjlkeQ5ilaq3Td+El0FiDxdFfAZQRYMox/YW2
	rEVHig==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59v93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 03 Jul 2026 10:36:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c9d85160caso5534165ad.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783074983; x=1783679783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=;
        b=falUHtrxMtYvThnG3YsGO53F2+emillcNsmKzKA5XMRj3qvxUCL6c+3m5epKib28wq
         Ys/OAoELVPxuE91Fw6WJykXUCG9hUpbmw78B6cnytCJQBARWTcj8JNoyEdoQIIMr66ng
         TiuBq+U9hSQfgRdb6kEGupLkK6WQOBBrKA3XWVWsPPWF2sXtpDng7hctHTsYR2ww2DJP
         LuidvbBRd7h5Ht8gNUV/zivTx0QyLNWuNr88qa/BfvPM/gzT1HM1FZpxS0VuWV8eaEIG
         ws4re8kniSEI2+j0YdkeIdPVDm/ISIetP2NMr5kziXdpiVQ+cqpDyfQm/AGo3avB7Ix3
         wFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074983; x=1783679783;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=;
        b=LKXDiXwUdLohB/FQ0ckJTKe420cM2CtkwiMd56Z6T8/s+ShUlIVXYgL/X6mUCuJSHv
         zjEvmix1hy/ejqtIwjaAGaPP2oU3kmUc/cBwQ1gPKEvXCoNZOqB6EB8/azhmWMtSoTff
         gbva1xdQn7sRHoH3oGkFe8jZ2rUNPdmPUF3wiCLkrC+w7Q0q0eRf7ujOS3UJVQE7+9Gu
         /VbAY75TGox5QARD6KN2jsMWbb1SE73PWm9fTJeEeFmR6bjCrbsSPiK5NrWMBuD835/M
         /PWz/1//+ihYks+X5FdQdOrknKPhMVPiibaWPgmYT8YZ3cGKWhgxbfvNk/QZhTg2fGqf
         JXwA==
X-Forwarded-Encrypted: i=1; AFNElJ9StDr1yHZqc/jk4TGUP9IcVreQMNz6f6aEDw/XFuhrG0Ovg7VuC9ERCKYkXj/EJiqoMbuKglY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTRIyRkarq7/p5cBFoRHA3DOQxVLJVnaT994tjpoWgJip9xOR
	lEsHKMyY3twugRTNe2RDY2uf6dpj0DyUutbDkkmBEF5vMDA4h9ZJqQHXApGhYPzMKhhiqnHr5ZK
	wC3C/chfljCwrsTTZnaydNREzTN7U6qPmAGhBVBvCDobkSqyDtHN6MpMf/2k=
X-Gm-Gg: AfdE7cn+tDpveW2SyMD32ZioRV15cet3hPeJElbzFppL++10zK/K53IWCilRqkjv9+g
	QfUX48n6HPjGM+HmwrpaBboJM7IGTnb+T+5FuvrGYl5TpPhNkd1IQ2jn4VRYNSLCUTRM3SZZuFa
	7MebwVRcHSLqiTanWD6saKCOCQuRPE+FZLB+cm7Fc9D0mE8o9vYQz1PfYWH5Zs9deaZYPMtjHp2
	J1loZmz23BRT5JQl4f2+Ro64QupgvPIs9Ps+5blr4M6Ua/BYP7b2pj7/lwigcvbMmT9dhXoPZaC
	vAAFSsd0r1rmRhXPGdB0Omy5WrLzaDTCgrDkUqyXWwKPT9cif+cz5IkrcExSm6XPLA+7L7eX1sC
	oeP2zNonIpcDQJveeq4VwAb88tuzcqlrkJcQDc7UJGhjKTo/PiHk=
X-Received: by 2002:a17:903:3c6b:b0:2c9:d56d:afa3 with SMTP id d9443c01a7336-2cacb070082mr42780315ad.15.1783074982843;
        Fri, 03 Jul 2026 03:36:22 -0700 (PDT)
X-Received: by 2002:a17:903:3c6b:b0:2c9:d56d:afa3 with SMTP id d9443c01a7336-2cacb070082mr42779985ad.15.1783074982316;
        Fri, 03 Jul 2026 03:36:22 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b446a766asm13555217c88.7.2026.07.03.03.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:36:21 -0700 (PDT)
Message-ID: <20d52df0-a33c-48da-8f62-9adb7c77eea0@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:06:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
To: Dmitry Morgun <d.morgun@ispras.ru>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20260530114252.42615-1-d.morgun@ispras.ru>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMiBTYWx0ZWRfX2BzGyEnSBCGL
 wiIHwky871ITNp4eVNM14X1ENWV8dMtIrgvcc73Z2PMCVPrGCiXYsI7gYvtBI4/ab5i5Oo0iV+Z
 w8/SSHG4A5VM5pGGh/PzYyz46JB6hO4=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4790a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=YRM84PAP6wGYPlwToDIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-ORIG-GUID: KeNB5v_HafZhno-98tMptoodGdGahRrR
X-Proofpoint-GUID: KeNB5v_HafZhno-98tMptoodGdGahRrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMiBTYWx0ZWRfX3Ply/TiYvzUB
 QfZoib3TmrV8RzszLZ54FtGjmYIjAiGXU4LXujDF3/m6jiYHSPTvkyhijPmOpXwQzuSQqbbWc4N
 Y4FXvNSuWrg4sgbXlmAN2a79ck6V+VGqBPeNbGoO5LNzZVN6gjaL5vGG8l6LvYEDIY+gzeQYPZn
 UQsxit0RG7BbVc9ww626DFcg/G9dgQfRA9CcIpqcZMRSm2iX2CK5Nh5CqqWYPDImF7G5wGYqTeq
 fkH7axtkLvhc07MfR98053PgN+QjBQWFQPfBT+BIJbRT5P0LB87avSOm3fpEcktdlvQQR707xrg
 0VseAcsVTUdSOsEWr6mT2uuLvX5uhUbpKTYrFXY8Ouf6Hd9TwBpIhXjnwFVovGG02tj24n+wuhe
 L5lPvW4GZnm/2qKZjf6K0GRTukt3Ly/j3YzppnCkhdCrzvA/1MGh6GOzB6LwbVVOfZJFj3CDT1n
 qdEwJ7+lzwnqzq/mMww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030102

On 5/30/2026 5:12 PM, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992786;
	b=mI59XucTkR9jG0HZi2J2KILTezBFEomC6IukDjH1LW38kLYBl2pFcENn36aVgfPopMKo
	 DzFeqW+DfQqLWXdtjPyhm0b5xXJCH0lnTsDeH+QWAfLhJi4lRZ1ECozmjgu9UE68rk8xe
	 crI4thIbOMCkKzhekcDZhRy25I3KaDQCCwGCJyrRHwTG+sykTPFx/U4UaqCoY33Zi6brq
	 d0ZVCgYQ5p1m1OiZx5XcPXQq+hfaJYorruR2LUbD/hjML7F0VDWgPDL2baVMELC6y73KT
	 nrVyWnHbMiHV6zGavaUKePJvcJJe1jf7JZHYQ/1bWqLCuvJzuC6+Bv1h4WBB5EDiuIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=;
	b=a5EDJByEkpuKX+4C5ESh6ZZO0gmEs+ITNuxPdDYkmoeV+KjUqhjbNO8wTAqrG9mi6syt
	 sTYq14ya7OdpzjCcUUxvrvfOwby2k/ZkiRB05sAj/ibGUj3E4hn4Q8yEAyYh9nn+SQrpM
	 XA9RflN4JrLwk60ldYl62+OKOvQJT4qkHM1rp32JZ6jnQIJCgVuLeL+HFx+n2iOTPajoa
	 o9GvdD+ZWrxmwj8qdQ3S8W19ofT/4IKyOYZ7nIrsSODw05gbMnioaO2R8CoRShOqb9EGd
	 vpnI5psWzusoAwv/zGTcsb2uEkO0xC9dm/TalE7ahdTBEFSotBZ6gD9BUjBCB689/Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Po056Kel;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BzSaZtqd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86581606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86581606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Po056Kel;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BzSaZtqd
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4av4U2727079
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=; b=Po056Kele6m1al/C
	bHUihIf1InO6MSspmTFZcYBqxJq37uAFUxQaiCbE7L5kGRsIvgTHoUUEYMwAP8cK
	oV5VxVzJ2XEwZPoAodrIsg/BhHq67s+yTAV2t0tvHrq5kvFwgzeRpLZXd6XB+PjA
	nyorGltDu4kFjH4QhIpUpe7fC1noEfs+6w1OJYcJWvjodWrzpuj9x6MD7rUPgvfw
	4loEg7ogFIgwKxhKcHv8AYAkeRScK9mk/s5dPcHnNH1B36u+Y70c+wrKpzsqnPzN
	nbch5FYzA+yskFFeEqzczxRCZ0WqTzx+MmAvFNcYsgdY9f7+DZx9jsG219+4HVCV
	GPQEyw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6n10k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:33:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dfb24dfedfso28271765ad.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992783; x=1793597583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=;
        b=BzSaZtqd4yzulNAG2m1xLNRl1KUbZrkPTMVkfE4SZYF6Ebq/WDR73aowY2WAWtjR7k
         G9Y8Ver4uz7n1hFD0rmMX7SpwT0CnqJVt59xYiin5dhlZRRzHwiKdfIpovES8NthMFIW
         izZxrK5kgX4OPCWPA+y02+0L44eTWkt70WV6OlgxSuGAY/GHF3HCp6OXk+Q5pwjC29k5
         t7BXcppNu+gCK8S3JQQOOL7PwDfZ29ex9kjeAIzBIuxkQ3iSWBE+TeXHLEMw1b1rDihZ
         IiayvJaV06+QR1EaF0cXX/v5lou1hio7P1Vp6XuLiSKsjKBImHIhlkakMzzzrOYiMxrj
         K8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992783; x=1793597583;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=;
        b=uy9Tqyrx503cNXJDhiUb4jw3LXzAJc5H8YTnK0mGMR5hLcQJ6frHcoEGnMkrTBXfuH
         lesEhgW7aV5lOm1Ee368zbK4zQxtPjeb+g/YkGXQRlwX+0mWppn0LshvE+qqzH08kDIi
         /iQGhyIB907EsQYcmpqb1oc/C7IOdQtAtIrwNZDtYKsjAqkAtwZRvgpJzmKjTgrXkOm2
         0AvrIVH3M8C8QHfUfY2/fI2wS2pYyr+mWVlDWzd8WCejADZKNHKW1fn7O0o4ZQFvwHb7
         jwsEsb7f6D5XZKtoM+5OrOItXDHpTfWLgdzP+LYVR3VfjK4zXgcQk45o4Ap0Rrj8PShL
         3rKg==
X-Forwarded-Encrypted: i=1; AKwUvBxwKbTNfPuPFs/ulLKoORffolACX7CfFyIkc3hGI1TNFHZvjRvGziACzVsD3XmVgmedBBckGVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmFcW+PrG4J4S9isCBlFvLtcOUna4BfrKvzbXT+lTIWOt6RLOL
	XYkBmh/XHJY8Xza0WtZF8dCS1HpiuCc8XyVUXqiW37KrddgIaCeou1L7sTHVqbyd7ZGjPNaXGpT
	X/OcVXtqa/MG8ipMzUb0pOUNL1yJpUdZIzDlkK3mq3iVamrImrX13CY5T6gQ=
X-Gm-Gg: AYBFou0lTOatz61B9FsVDn6ABUv7WL87SobORCB8zz5gMAv9mBGX+5ZnPAzNaFtRSwn
	Pwq7RxQ9Dtfwlqr8HIVJKvVSNXRvzfACDrfsJXCfDkfKyas1Wt3qmPge0W8N8W875YDowzD1y8R
	yWwegKSj8SpmPNgFbOi1hksUa5ZTKAUdbXxrvieyFJrb8bTRfdeaCA3EaejsSEOl7+e8nNZM77w
	wl46IKpGANtDqq+9IxAPRv82i70JinHy98OtbbttHiWuWY9VeYsYnToQALB3wj1zuWHtEJkVg+Z
	PN8ZcFJ3PnRQ7NmBVeuvKoGnajIGOrjzqpe1oIpQWnPdh8NtCOe3CHbfLPcWFK3HkTHUdx9wM0P
	p1w23Y4F0UfFzMUJVzswEaBEqDp7zLQ==
X-Received: by 2002:a17:903:1103:b0:2e8:3e5d:b2b7 with SMTP id d9443c01a7336-2ea9c8754e2mr48634095ad.40.1792992783512;
        Sun, 25 Oct 2026 22:33:03 -0700 (PDT)
X-Received: by 2002:a17:903:1103:b0:2e8:3e5d:b2b7 with SMTP id d9443c01a7336-2ea9c8754e2mr48633935ad.40.1792992783091;
        Sun, 25 Oct 2026 22:33:03 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1dfee1sm11154465ad.64.2026.10.25.22.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:33:02 -0700 (PDT)
Message-ID: <520a64f8-db87-48f7-bff6-08a4bf6fa2e8@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:02:58 +0530
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
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cDUjXIyS5I3pyfMgCsOlDgTJUQO2Hj8c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXyGrtHaDEkpel
 0CFcQK/URuOU02Kr9q7HhUwxRJjDs9Xy2QVzESFeCMDCP/0WebNDR3+1GIRHAFuZqTefa9R0f9i
 Kp1OqYCdV7R4dfTLJVIXeQxtCSz9ENM=
X-Proofpoint-GUID: cDUjXIyS5I3pyfMgCsOlDgTJUQO2Hj8c
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adee610 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jtUn83jyyIc8HPFL8BgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX5EVrEhFmmC2n
 /uh0lUFcPSyBdjjIBQVunQZtGkdkGfk1fxIKTFqbT57mCbdLA8kNXhzIKsyueaCrQkkks3bgYXj
 yd402VWepFtrdF/1BJRohmUnEG6RRA97m/D4jVKCQ8FqU7mX9uoGC/y/3X1cXTeQ+1vBqK+bSXp
 Mc8lZCd0J/Mf7gKhLjC34da83clcR3nAYc6C/9BPRYkq0oA88jBv+tyyZsqY/XEh5syB2FUe64p
 G3diHvXGVFBI/s1rrOa/dbx9jPpGeJBkWsNNTp2/U1OGMp/nb80enMtWZYm7V5IvrFC4UHsV7Rz
 p4NYlR1mjwl952yEGbqsjSdKmpisb+ZPfbInmq6tO+3bDeb9a3yFws/TDxu/QRxAx2rvWDuP2uC
 5rPedDvwLk462i3i4xWY30O1xQRmuECEhCPr+5FnAXHUEv5nft71WnwJxORQHOjr2prielNZ//+
 LtAAPSBCmQfdd1v07zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from msm8996 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

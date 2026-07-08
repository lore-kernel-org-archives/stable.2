Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9003B95FA
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532985; cv=none; b=ckDjdd8pXdTK7ed2txWyK2UsM3fh5dg2WYLZ5/7Vc1PM9XaBdt7yBnEJjXc4agLLxgtrHeMDhfRo7oJ4fkff8AacATnnoRraMfGvOI1aknWbTspbG+ja2F+b8oUyoksLRe7sbtVwutB7B8UpV8g+uUxnjUDOz5GnSzZAJlB2ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532985; c=relaxed/simple;
	bh=LvxCHrdM6ZOJ/J3A7orQz/W8gmnF4rhcghvrTkQNOts=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wo1MwjJYDoCRMN8hn2cBIfLuW6KdlYWIQJWFtAzQnfwkdae08/L6CPuALtUUGJAeo7SL1e3HWbGhW+3IDJWgeh34Yl97c7/RPHyVL3lHRQe2DNV5QVu1u8yxjCguQOYYhU57lLrfO/9SxiA99xpvCjCGf4E7MbXwOmuv6HJ0/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCMPP877; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gusWzy/r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCMPP877";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gusWzy/r"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668GLK563387170
	for <stable@vger.kernel.org>; Wed, 8 Jul 2026 17:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=; b=mCMPP877x0Bol91s
	Jmsy1krXdXHP7nY8Jv+E0deztqPdfrX1okfouEc0C2nZBoCOGMh+z3oPcgXzzhvD
	/wPeTR/KU1m6AKZN1HTPDNfZx1f8KDLAQjlFIi/PmJQBoEAN0Z53BPeJnRZJ2pdt
	MkWvxNUNjoIjDp6d4dJOAEDytmcfgtkwei7BLxfaFghtSq3AmOClVnpWLG7qThkL
	0cy8ZXXPky1NEsG++gDZhJ7p3PKHkTGpjxBm83P41w+O5sjVEXnKfHYLD/5VVrGj
	fLWLsh8+95S0kkvSzbP3aMWF+vMjtn9UpHTvfPglA/A03wcikzfKwX0nVJcBKY4M
	qmczXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswbuuf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 08 Jul 2026 17:49:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1e6f602cso18844491cf.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783532982; x=1784137782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=;
        b=gusWzy/rJ8lJ7jXr9qWTXHOTLBE/8n0643mRrRMJMUFQlMfI0Eg2+lugOT544pRy42
         0YtWYL8/VzZxrxJh7/YRa5WTy/LhpzeDz4r/XfHTHLpLPBdvwpClGrrm8fVAdXPq3XpO
         m6Al3rXp+pukBQ+AXQBlA8WQZycHXL/dWGwMRP3iaBLNLAfzv5DndgE4QEUqC0d5YzeJ
         P/pwDrNum/2mDAHNrvhFClTjmSDhQTAjC7KSJ0/GtJrvIFSMFN8Lr0XC4/5kcIiXfKSH
         o6Am/ujEsV9h8Lvdmz4YwANonfWaiTAwVDIxa1AorY6SmrTsMfllADfGvDs0sM+4VTL0
         DJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532982; x=1784137782;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6RZBHsUYn+gNl91h+2+3Z/xDo4fDHSJPAjCPO8O7F80=;
        b=NiCbuav9/WUC4bPtLwIms3iG4r7s90k3HB26mMOhj/B9Rk75kkXwZGvT6ynOdd8g9A
         4PaLeW2zfOvUuPr6Ii4LXdifPYKLXv8wdJP+ab3hbqb8nNaFc6jtqw2pQugrqqM+pzlG
         4qD+ry4wnOHOEQ/pxvyE7fW+Pej1B61iAHvwfcznIt/BQ3TzBlRJcTADJBvEXFg6igYB
         lMB7EcTeZ+d3PhpiVeftMiMkOP8f1q+WE4UW2AhIPDQw/7n0rER6GBiNRYSbDS49B1g3
         i+ZyEYpBdr+np4CxSiCMqdRMIhw0jbyuh5Lp/4i0Si10cUVXWikeDeDwJp30WXFJ0Di2
         0grg==
X-Forwarded-Encrypted: i=1; AHgh+RqQHCykRQkfMpbk/c8os0ED+dvm/Pk4dGZE2EpDI206F5RyTCYqlPfo1K8/nwMtTRhZIt08B14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mLgHer9DJDhvGKzz2JMgVB6w2t9G0TrL4fAvP/uA+/tVdJYA
	9i3dqqs1NDr/Z7Ol67THDicxEqs4kdIl+6F5EK/eqdjKQ+irp0xehHx/uu3AUjLERD0WOWFcsqs
	htfeb6JfVitddcmEkkYZrTQi9IctBCsrFFOKAiZA/oRfL/7Z355oBlDRVVWg=
X-Gm-Gg: AfdE7cmH6IKD2Yprvit5P4UPxiqJNDp3QiRL/WOv5pM1HvpvIsxeDKc/7tKg4/eJVxK
	I2JTPYuA6PDtbdUjJEKoUfrzN+rq3RAh6tRe3IQvKpR5or0yk6nMedAk7MZ1oUVw9YaL5tqWdBy
	j0rmHhnLTHKvHeDPR/FvCElzK7mGac1WhaqX24vjIPWNaZ6nyNXy3VH0AOXiKi9uyqc4BqUgCa7
	Jx3W3WkkizCHxuIateJOdusrugZF8YlMfCYC9g1WAnsLvhcJxZwLjsggMRdOZBME+UcFeZPw6T7
	KbI+PGgfpOh2/Q1fr0AhxCPaa04rh5av909/vdbBTBMfTBDeSBYVSOCXvrauqNfghAdSoRa+CvD
	5Ozx+cioqLWSNTdKnpWowarx1qy9/3zkMh4ddqCXQQQe71NNGIw==
X-Received: by 2002:a05:622a:5592:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-51c8b4095fdmr37755521cf.35.1783532981922;
        Wed, 08 Jul 2026 10:49:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5592:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-51c8b4095fdmr37755241cf.35.1783532981529;
        Wed, 08 Jul 2026 10:49:41 -0700 (PDT)
Received: from [10.243.141.238] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ada04d04sm359763166b.47.2026.07.08.10.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 10:49:40 -0700 (PDT)
Message-ID: <c4cb79ac-1f90-499d-98ed-94ec431d9368@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:49:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/5] net: qrtr: ns: Limit the total number of nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jeff.hugo@oss.qualcomm.com
References: <20260409-qrtr-fix-v3-0-00a8a5ff2b51@oss.qualcomm.com>
 <20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UPM3bG9QYwh_T7AfwV3QyVHnuyepmqNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfXx64a4SqDgmHp
 z5vBirwiRlVBguy0BOSDK53tEUpKeva+utM84iDNWqkA2rg+IdxQ8tVFHRLKQ8QNl7vtXhkU//s
 4C4dBO9B+nx/ibK2lR/TFnAWasM1Ilc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfX82fKwIvb7qFc
 xNbAZ7cuJZoYizrt2zBkDJ5ebGztg+wZSq4ZojbVqM1JcY42qfenpOo3XpUxoLHTcgqto8Y/YlB
 yek4iRuBkweCfY60WfZSQLqmEluGpGTICf/RDbA3oJI0K+e9YFh1J9jvMZj81S79O3x4wczExVq
 wQtazooK/0qC9zuks/3nTVLhrm1HWAypVKN1ujt6H3M9vEL71L/LxfN7RUTVRGLkxFY7mvwREow
 YMWFTZRZUXaCi8WqcWDp0wxk7IGKv9/iRlWJYJ0m1fyKAVgK7IDPFMmqASwdtN95djZ6R80w5pY
 iH0Ck1OoMlVAG682LGq95lql8+/KAbwlK+PSdQgB8moWfJ75r7fLxEeONRk567g8jQR+IWXgwzO
 GhVrGn9LZewrko1SDyoBgK+ui5DPlu/hQT1ELjlyaWMdSrsUveAqCeSSUXNztyNDfCRo18RpWJh
 DDPxOkt+M4bRB5YZNjg==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e8db6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=iDFCKaCMZfxtLc4CjNwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: UPM3bG9QYwh_T7AfwV3QyVHnuyepmqNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080174



On 4/9/2026 6:34 PM, Manivannan Sadhasivam wrote:
> Currently, the nameserver doesn't limit the number of nodes it handles.
> This can be an attack vector if a malicious client starts registering
> random nodes, leading to memory exhaustion.
> 
> Hence, limit the maximum number of nodes to 64. Note that, limit of 64 is
> chosen based on the current platform requirements. If requirement changes
> in the future, this limit can be increased.

Hi Mani,

There are AI200 setups that can reach 384 nodes (192 * (AI200PF + AI200VF)).
I'm not sure about limiting the number of nodes, but if there's a use-case
that led to enforcing that limit, could we increase it to something like 512?

Thanks,
Youssef

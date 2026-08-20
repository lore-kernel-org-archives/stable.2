Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAD35F18D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237083; cv=none; b=jkN+HmriLTQF4f39nZd/Ba0Yzq/3LlHOjzF9Q4v/YbkeASTNppXXORl28+CSlQzASlbqhDjUnbSloBYMF04Wi6L+H4ZNXn6fKQMnJ5UYIwrznz/D3iHGKZ1xIQ3xM3HS5xILtVdT0cIWKeJemkyHYzTENo7jjw9J9m4XEaSnrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237083; c=relaxed/simple;
	bh=bFyzUNP2+qqip0ybP0JabGsLTTkvJs2TedU/hVOrIdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofC2J0qxfreDp0uDd6IctaIywnV/re6/Qj9HbT6QpBh7xwMX6Ut18ZiVZl5xtZEyGtQKnNJEsDO3bQ+m/8NsMzAw2Ggsz9+nSajMQ6FSpGeIx5vlM/mWC8hXpqRiaOI2CAWI6MUDYV189WFpX9ztVwkQMNSlI5EWDa2hLx0bn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0+LwQqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZlciOE7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0+LwQqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZlciOE7c"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7c9N3665970
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFLX4eJFo+iOg9km4uc26Mxwlt5r5Wih37H1Gy0pU1Y=; b=a0+LwQqKqe8RCJ/f
	v7jsV6foFdAO9+T0IC1RS44Su8psSnn00t7FBsrLS5zAeZxRKHOi2KNE/SMQUf5f
	D3sR97vC19zv4xAdlPwHUeEFYQ535HVkUlR4V6HMlpMNd+a5rkTxnHI5/c81AcIZ
	eU78pXDoUh81Ce8VDCKRDzlF2l0olhLfuPr5N2Zj74UYjUPflY9NRAjh2SwxoOCe
	YhJvFqVD3Wfvs4qHrwtqpJajSOwvN2K0p3oUDzX/SxxV4o4NzJ6U6gVORrnwlr0C
	Knd6hAjxKdNKMJVGeUtdkqp5HGzJgYikQ2kXcU7QsGGQWe3LOzy3WToNJqJI6Pwn
	hNIfZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg19522-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:44:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93102454272so49796685a.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787237081; x=1787841881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFLX4eJFo+iOg9km4uc26Mxwlt5r5Wih37H1Gy0pU1Y=;
        b=ZlciOE7clJ/dtLlIL5t+S48Wg48DtqL+bsSYKiYJKb77iLwF7Y6GOr2nyvpJlHsvo4
         /5UJPcupjsr1RmYKUhFc2PG/aVXhZv3ztR8bWoI6cMDjMAHuAwdVIqO/SIA/pJzJ6TLt
         8vMUSqJPpIYIFNVWehz8QZC6n7jDdq4lykRpIYMSl10ZjFt9HXrgku9XvZPFAIvhhpcD
         9EyYEinto8SXPoWGAnXzUR5m+bc3YDYCEPhtbtueMTAVZd45nvwQNSP6ltJ16xecodfS
         RR/vjeaxrYdxpWRkdXQv80YxXHvyxPMkmxScUrdrDWyq5Z/2ixbga+b15DyAdslJVwLJ
         i9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237081; x=1787841881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFLX4eJFo+iOg9km4uc26Mxwlt5r5Wih37H1Gy0pU1Y=;
        b=rZ9avrfe5qRoYsojA38cjc9K4zvT/4o1C887cbrpKZ74/4SvJaTpnWOa+AQHwb6Lq3
         ecHgz4MYeXUdMOKnW3UfORX8828qCptSLDy1in17MKAC6/wLhbJOEx+XVI2XtjD9NlvM
         SHcRGXkr8gZrvxgSUH1EQX5SL4z8bEs95BeeD0U5CJhR5cOPrNzGXtZ7ZaPO9sK8kBfm
         RYNH1PQYHgGwTSDf2pH/EwzBaXnLsD3CehTpADxCeYBzrF0fHPOeJgnfWKVxMhX9HVL2
         ldTBzf9la3eYge2xXhkQlIdtFsMIZKigL981LnTWTqpADKkcaw35nSojyu1j/TZVbWJV
         CQpQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9esxyYp+4OBDO4LZG7DvI0DVgVAJ2H3ImRZE8ZFwnSotFsXjgH+js2XPLG4JR7RJMCRVWUW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS66PLB9Pf96r75zKwi017t+2DIBSu+96T9K0twFn2VPEp+yTy
	hShPhtBQnojeq5gBEkHHMUHnGIAm+277i5RQY1FYXVrh9nc/0TZVHbC0pNY3mfuEd26lsHl7+xd
	rXlgExKJtV/mi4luawwx4hKjzVK++eI1pKUQztJVW0IYbkBodfcu059Ukrrc=
X-Gm-Gg: AR+sD11DSmH4l/f3l60XzyvOva1ayPFPiogFrhRrzh38Q7pL3Rc+U0lhkiNvCam58WT
	Q2QDZmJCy+mkq1O9Ri1WviDo3Zs0pRZ7/qoxUmyG3ke7S08AnHWoj8re1B9//6UEXxDdqHCcG7S
	Muw8LPP2jpKSyrL07VoUxRcUxalECWlmOjdRpf2SFDSjuMTn5YDkuxkkl/1ZqP/BO2jSjAKq3OM
	e3nZZknTMDQpdd0AmODbcgL/zFEPN02n5THKFi3Bq5uj12Qe6InWSSIbWOsFrEBbs4zN9gZahcX
	3yujyPKVweyPbtsU3REXtIkX2UQWhrQai2pw9On5si+pCfQfx1JgffzVc/4GE7el82Xt9JkxeD6
	GFm0EPMRawIcov6atbYs56mSR
X-Received: by 2002:a05:620a:4055:b0:92b:7420:bd58 with SMTP id af79cd13be357-9371e1aa1f0mr903833485a.0.1787237080708;
        Thu, 20 Aug 2026 07:44:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4055:b0:92b:7420:bd58 with SMTP id af79cd13be357-9371e1aa1f0mr903829585a.0.1787237080284;
        Thu, 20 Aug 2026 07:44:40 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a189dfc6desm15504331fa.23.2026.08.20.07.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:44:39 -0700 (PDT)
Message-ID: <044a5e3f-287a-4a6b-9f15-c6f13241885f@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:44:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soc: qcom: geni-se: Fix fw_end computed before
 round-up; propagate size to caller
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
 <20260820-fix-write-to-read-only-firmware-buffer-v2-3-7badcdc455fe@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-fix-write-to-read-only-firmware-buffer-v2-3-7badcdc455fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4rlnmXJfz6sldrbkK2k5xn683Sw02rlc
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a8712d9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J4qJpuNgrJFWkHdbzQwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 4rlnmXJfz6sldrbkK2k5xn683Sw02rlc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMCBTYWx0ZWRfX49CnfPnHqxGh
 9yZam0B++neUOBOFjudNQZqphACV5JppU3iZjfR4P1GIR3Bz3MHcHIfJAeybwaRGTWq2H9TcWTC
 ADKF5HQHqUbzYX5a62YVJH0WN5Tm9G8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMCBTYWx0ZWRfX/65umyfKu5If
 /fpnfb7vNbw8ZkCltJGUqYJMEg3/NXrY9E1uSqtUifRjTM91/iLHJE5VaMAf03aS2fdWIZCtM1J
 rhon7geSBwymqZ5kJhckccKUANsPtvPuDzPparaB+xK+zXDX6zlb+ZAvr24Q2TeOciaBUsir6Mm
 5vIQkp3cnUdajqLBkbWvYIjrkrWs+Ywc20MnSYtN5Sl9I/150B1aXHk+ooM+lYYOBqpYkHDU3ln
 aD1aipBx9q+h9a9r8QeU9I+ZbPfpbWNR1vDkS1v6Du+fI5Bori269LsIWTc9PFzUvofmhtlkn/E
 s1iomisLLNq6/wjcE8SAqONO1JhcBvz3/2JHWDj5UUSao9w1qNntCLdWy2UScXJCJ2OmXjRRzMx
 TaGqoqVlQUk06dVtOTcTIgn4csCv17KPYcETjGNqupFTd201BcFp4FBBvBXj/yet1zcxLIBuFX7
 1azlwCjXOPYJVoTcI5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200110

On 8/20/26 4:31 PM, Viken Dadhaniya wrote:
> fw_end was computed from the raw fw_size_in_items, before the odd-word
> round-up. A segment with an odd word count could pass the bounds check
> at the unrounded value but then be copied one word past the validated
> limit. Move fw_end (and the cfg_{idx,val}_end) calculations to after
> the round-up so they always reflect the true copy extent.
> 
> The caller geni_load_se_fw() re-read hdr->fw_size_in_items for the
> memcpy_toio() length, bypassing the validated and rounded value
> established by geni_find_protocol_fw(). Add a fw_size_out output
> parameter and use it in the caller.
> 
> Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

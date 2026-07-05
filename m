Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB153A1CEA
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278913; cv=none; b=fhNqp5GdtIQINIiuHXzuJ4Hf/qTi4dexBUXH1Vu+cLru3SarN1+9Xe6L8jELfgcQK9GBfjCXYuuv4kcw+ZVNIwrpsh1hyECDiKQLS8k6Mu63a9hvE8Rgc5Ly3K8KPwQfD9BDpe+EmxKpTlb1Xfhqmw3XCI8422uvvZuHAGG1b/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278913; c=relaxed/simple;
	bh=44lM3DRPYiy11Cw67gCIsslslOmao7q+J1d0JTufAW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcFkh4VUt6AoGZj2eHKmkdyntSkTsak6ksqzwICoeC7XcSIC3N6Rb+mX1XTs/jLXkDtmIiOj8JTfSd3TMfj+ARQv+DPL12HXGrOYZ7Lf3MLSptjmVc3OOFJLO14EjPyWVov4Y06BJTRvzW/1qKljRiYgrMd0PQYWjxgNQiV3804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYYoPstc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KLMxYOTS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYYoPstc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KLMxYOTS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HhZXk2351646
	for <stable@vger.kernel.org>; Sun, 5 Jul 2026 19:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=; b=RYYoPstc/ElDH0lQ
	+9fg1uQrsS0yv/soaDeKupGZTFCQ4bqXSRUZbtYo1LjUlL/9osR7Y08YMWl8BYyF
	4GZCWEd/IeHOKcrAfTOHWuiP6SQn3l4LcVpsS8T2yT5mCAmHn9tVP4azsSQAhFV6
	Tu0AgiRGkle6VATOVPsBbNUInpeUP8Zg1P9QHRt+plhYFTAQLVHZENXC4Yc7QKhB
	Oot0k/6BeP7Opqy9XxUjQnkLDK9rnlZhXlWrOG0XFRnJz5hmma14wKXFWSstn/jl
	kgBkKXAOMVT7RLlymwWiZ1dviuUQbl3coHy5nZUp6fjVLC1UPB274OnQHGQQLQ36
	9tOkkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sucpj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 05 Jul 2026 19:15:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c81db324caso51279005ad.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783278911; x=1783883711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=;
        b=KLMxYOTSFh44OyRyzZo7IJvu45c/gNgXjKSHDJAOGM6h0EQzdgonygcOHBa3p+fpKI
         4w7CMCIbR0CxXJiYtwEAyiVddi2fMoGyOvU/dNc/3m0ctB2Hip8HYMSQz3iSw0qO22sk
         h8F9jHKUB4qVYA90iHtKlvQ5L3swcNGW5XcPc4OwduOrFrbwNhOhlDMa9Ytr2acC6x65
         PmsdAPX5cSg4o4bnnOaV1cLr4CZ3KvOVUQVGroIhvteuPpA0Mc9BvKPTnowfaeCfv2Ze
         bj57iBIO5/D6doJIgH5EtgxWMfItWArTeoP0lP5krb4mkLqoeyGnCgYJpx/AZpu/yRcd
         Y8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278911; x=1783883711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=;
        b=XuriV95jEdunojbRVfzYtWRvmg+ukB4iVHPOqjj6AtAvDmdcAu+d0M6N2WU6pRGCQz
         WV+CMu0QTZs31yRhRjx4NX5Mxbq+Cs820x7ZGt4LyX+e3k1RK/OesZ106s3m20bIfNrr
         rnmhsFukv+W+o5knKrqTh5hY2xfpjdMg86YMawvIeeLnsXdQwmseC16YnRLw/C58hgCM
         dcXwfU96jH/yxnBmqqEoLCwuoXf1Bg/eTPXvfVcSo3cpBw6SHe9M+OZ+Sa+OUeWNGiox
         ofci73bZzSUGQKoKGwYxSMGQOxJ+7sGKukSJ32du+0yY9UcIOy8J5VVZIFU9fG3uvD47
         WRLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr+LTs5JnvKwonc3Nu8gMj+3d2Q9R/8yRFkMi4BpmrsZS8rO1TSE7SK+xKW/NtDalZ0WoHeGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRELhs34n6aPSZuWz8Eut4xswWLQtGn9/e3zaPwSLHGDFeP1K
	uHfynmOQkrRBmR1LwHweOgAiY+OHY9/UBuclDYEmD/CFFZUEOmalpvrQXLOnpMyOqYIWcAg+50s
	J83/q37JOS6Fq/ZIbgnM72f8LYQiaNxbtEE8zcubTEEvs/QHnRgtZsYf1TL0=
X-Gm-Gg: AfdE7ckhQvvB+7B29NUTJdguPZ+k2vfj/AxfeuY59ELCRcbpvY0dxgueG0qVNqO0xvF
	B/Yt4u84QsIbg4zGCkwJu4ttSqA4d/U7V5F1xsJP7ArtEYhfuzQEX4rWjESOchFmVoz+hsRnGKm
	Lyg9nJdfYkSOjWqkVZ9Mw+Sjt66YpINniQNMNksuERK1cTvX9v2EqJZfCsQ6jNyoRJyA+9kE+ZH
	j7iaIpEjJtG1zs/lrX/Hq97QBDJ6jPHGFy06NuxyQXD66HWOFCqn45/gXpRB6yDq60LscJKadyk
	ObLEyqcHw6Cv7xFO/3A9+VyejcpPi/fFGXhiZ6eVSPTu3WDAu5aHiV15wCvI0Jj4gMvbwqhLHKs
	53nfBUL1puH4+/H7TsAsCjdizWAEWsknkDBWrUgx1O3KMcFmeLPxkrXT3dtl5IzHTUwxi
X-Received: by 2002:a17:903:3202:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cbb9e38d1cmr78130905ad.14.1783278910469;
        Sun, 05 Jul 2026 12:15:10 -0700 (PDT)
X-Received: by 2002:a17:903:3202:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cbb9e38d1cmr78130605ad.14.1783278909958;
        Sun, 05 Jul 2026 12:15:09 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b492a088fsm31335582c88.15.2026.07.05.12.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 12:15:09 -0700 (PDT)
Message-ID: <c0b69719-980b-4a43-b918-007751e7e925@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 12:15:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
 <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
 <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIwOCBTYWx0ZWRfX1SfFJdGUVa0J
 g4+YBUTmlQQlRwV5VCxFxRwEMB6+ptrcNz65omWrvYKknDAbpCQkO60nMYeoeZ5u1bX1FgAy4gw
 QP7XcM15ZnEAFJgzixRzg/+yn1xYqro=
X-Proofpoint-ORIG-GUID: HFQ_T2jFvbjSFVD68ioFGWxGHsEAQKog
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIwOCBTYWx0ZWRfX3ZJhb9q3+V6D
 vRSQAR6evf4LJXeXoM9Hv9sLA697hIapSqbFJfMf2o4iGkdPKFTrN+FwZP69E25sRevFdtxvaKM
 9ibP7Q0dlyaweDFdJ+wYcuPbkHiW2F0PvWJYdoK8Sy3ptSsbBk4m9rVaQs4KhKF5cyugBECA9UJ
 J6IRMjvC9U6iYK31wmg9FEDGtagaDlY+RlDqxFbPnXbIw2mTiNwtFn0ugTZstlwBhwMPkZV7hh0
 lWygqRVNYwnJ1WlJpjpkYrLHE7qr7kSMm9yveoxeY+zj8a1OglhH0T8PFbHSKxaGWQGU3VtrxYw
 Ipzf4g142vBXCRdg1U0GIu36gMIWXFBy3uDvt1f9f+ioY3Zv/UgfTJPo46hTlJ+vKyvAJ9jraCG
 swMa5SK0nzEcKW4Be5N3QVoGDGmRxs2MCLxA41fdzNTJTheb2BnQnltsVcHB8uNMkCqQqNWfXFI
 /032alo7K2+LI1VR5Lw==
X-Proofpoint-GUID: HFQ_T2jFvbjSFVD68ioFGWxGHsEAQKog
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4aad3f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=TRTaysboXGgomUBcWKUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050208

On 7/5/2026 10:27 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 7/5/2026 10:53 PM, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
>>> When unbinding the ath12k driver, kernel NULL pointer dereferences
>>> occur in irq_work_sync() called from rhashtable_destroy().
>>>
>>> Two hash tables are affected:
>>> 1. ath12k_link_sta hash table in ath12k_base
>>> 2. ath12k_dp_link_peer hash table in ath12k_dp
>>>
>>> The issue happens because the destroy functions are called unconditionally
>>> in cleanup paths, but the hash tables are only initialized late in their
>>> respective init functions. If the device was never fully started or if the
>>> init functions failed before initializing the hash tables, the pointers
>>> will be NULL. The issues are always reproducible from a VM because the MSI
>>> addressing initialization is failing.
>>>
>>> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>>>   RIP: irq_work_sync+0x1e/0x70
>>>   rhashtable_destroy+0x12/0x60
>>>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>>>   ath12k_core_stop+0xe/0x80 [ath12k]
>>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>>
>>> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>>>   RIP: irq_work_sync+0x1e/0x70
>>>   rhashtable_destroy+0x12/0x60
>>>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>>>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>>
>>> Fix this by adding NULL checks before calling rhashtable_destroy() in
>>> both destroy functions.
>>>
>>> The NULL check approach was chosen because the rhashtable pointer
>>> serves as the initialization state indicator. The init can fail at
>>> various points, leaving some components uninitialized. Checking the
>>> pointer directly is simpler than adding separate state flags that
>>> would need synchronization.
>>>
>>> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
>>> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>>
>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 
> Missed to mention that pls add wifi prefix to the patch title.

I'll fix this in my pending branch.

/jeff



Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620862FC898
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272484; cv=none; b=X2UktL7F/wZDu6sd9Gx23cKqADv8B9wQRU0K/CLQWDuKsve/dSf7YjFQv692javJo09/uwZyUT3QF1T0kbmUePieYIP7u//8LEr1+jATeHBxHR28iC2GXU/4KOigFIp17DcUOUS39TDhuRXjtLVQKx8fhWfcMpGS35znXHF1m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272484; c=relaxed/simple;
	bh=sB7AINyyti7uXeU5MUKtTiLyLBD6wITu9XF36kuNIr4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKVblxzoAW98Re0td00ePTUl7MOh3Ozlw2Re4WTOoLepG14JFnY7Z+ATyzryvoV1/CSrBRK6oYc3IpeQ3yrf3l5XZTv+le1nNPyAdHFvn8Zxb9k+o8JVeb0NREz4H8+WhpAdQLU1zvJ+FS5tbgFUp8eYeY4oYV+rdPX9CI4k/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mO37KDNb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZsMxCVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mO37KDNb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZsMxCVc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665BGdfU1539699
	for <stable@vger.kernel.org>; Sun, 5 Jul 2026 17:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=; b=mO37KDNb1Udtd+Ej
	wyswc5+W8Y3oKvIa27hBAob4YwrwOfmBuh5xcOXzM9oeowZ5zTf8xGRruSCQKAf7
	5xRdmp1s/CFbSXAidKpJ991RGcXTl7GkN3bXWgquRIqL90/fwaKpKrX0rFV3VBmE
	IKCzUHLwk7FHSY/Dovw5Ye3fTE13PMCT7Mhj0VHrLUoy143yxnB7tUQHARnX0LY3
	j+0nVOaN1BukUZRZzXdbKPt5Yeb+X9paLnf81Idfk/Z3OK3EMhSSshkipyN3woq6
	iBOzlkCmE+Mw4xiQ2mVk1fGvn2R8cGPw+J4POIMr53tEcQ/pfT/2KR8QZHn5Qvfb
	ZA8oOA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh363n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 05 Jul 2026 17:28:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c804e38c65so44213155ad.2
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272481; x=1783877281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=;
        b=eZsMxCVceUVTt0ifkAjoO8GHLtXjd8b+IblN7Sy9FklQfemmGPM8evRK/N1kmeRnFI
         ELR26ZwMkPOlRs8sRwQ9GAxy1cJjystMRBV+UmS8S5cwhgTRIa5OboGNxWxYdqNfFM9i
         cvOLpPG8yNURVCfxA1DOg5eUMWH/+SwLixuXIwy3Hnq1WY+Tu+9s/IDKL7sHB4Eg4yLO
         wyhDd8yqvczZrxuQRCXKHWoFVR9p62fcngre161q3av/NxHP/gMbGRlWI6h3ybz4DJam
         NOSkPCivvpyoHU7iMyw7cGr4XNo4rsDy3Aukvi3JGOJCAF/j8Y5RKlTqQbKtCDufb6A5
         1dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272481; x=1783877281;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj+YLt1a9eyMlIaineSH/PGHkbWi7DsdRDopGs+T6Mc=;
        b=Z9SipMgbeQSnqf7276nq+OWwzsS5HtR/mwZ7+IbtTQHXdjfG0/lLcChH/f9I4ujrvi
         bnL+druergp/2d+6CGoXtwXU/Inw9qss0CBg+qCryAW/Mp0O4yuuirNJIIGaU2ipkUoQ
         cYGtluYM7b3ofGhtHLIq2dVfX3vJZ7x4JqlabZb6UIpxDBpz/J51rdPRgna3LDM4VDb9
         pZWllXrQjRb9mJ+76+af5vXp8oouvejfC9A1K1SzyMN7dYal3BV9BY2CA220rj6MUyeM
         y4bguvXLVvTKFY4XfStxdPFDlJqOuRVdz/KDJ9PQ5MKAaNEN+/zKanIh2vCTuoNV0fIX
         7HXg==
X-Forwarded-Encrypted: i=1; AHgh+Rprf8zeYCGHJaV0bF/ozUrbZvdCQla0pJmiawNhe3C2Mma1VDt8j7rUyH7uFTngSsCujL1zAlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+iYxPMr2SgEO3gQFOWocYfu08rXoijTVmwPLdJsJMA6riaMF
	Pv0ugWqBpZJBGwje6MefXN7bougfJQRS1zBqFQfti0crmk4YLGtWbG8qnDB3dlxpfi/Ta0lfbkX
	amV7JTmgLz1Zc6a6hq37QnACbmSDeKlDGBWaNt3ir+ea1DYI6so9NJT1z2m0=
X-Gm-Gg: AfdE7cl9ewVdT8FJe0BcbSwnB2QYzlcDuPuduAkmhBzXe2VJxfbXB7fPGgqUKegKDt4
	Y/qFNlrGP5OeHttYBsFbWcNRMsCURa7yc0oV4UYqZEAj+/bplBL/8Dh4SAyBkJJR9fhM2gonKq4
	G9aqZFrUV3eYfReX/SSuvwx3h6IEfK3g5DPzjcLPnWMp7noUHQphnkjbSYMPNuqGKWxClObYAlu
	MFDSNmZwR6CuR1ut0rEp5DcYZGqT5lXeASuUXp+Wk7hwimEgAHghaIoXq1Zevk5514FCz2bRH2A
	8b1tSY0dC3h/V/d1nl9CS2F0+SZF53HfB31ADg1XhRjBjuAwR90vc52zN0EM2MBDh9ak4oU3bgy
	ax6jOoHV5oZ+jCoLLjpjGXdc9BGEOKnZgkFWoeYyA2tuC2ULWUasrSWh2weF0ng==
X-Received: by 2002:a17:902:f791:b0:2cc:9473:97c8 with SMTP id d9443c01a7336-2cc94739b69mr13488195ad.15.1783272481208;
        Sun, 05 Jul 2026 10:28:01 -0700 (PDT)
X-Received: by 2002:a17:902:f791:b0:2cc:9473:97c8 with SMTP id d9443c01a7336-2cc94739b69mr13488105ad.15.1783272480731;
        Sun, 05 Jul 2026 10:28:00 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm65764138c88.10.2026.07.05.10.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:28:00 -0700 (PDT)
Message-ID: <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 22:57:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
 <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a9422 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DO-9swsaIGp9kS3Vgj8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfX1Xzuy1IrsT2p
 KGflsjczBXlQNMMFNbDiArrMGup+fcq/vngB5mjckDYBJOtgGY2RP1JUp0sK0ML9NHsu+nYGbYg
 A3tTm4DZWGHkpdfxahvUkLCCsoaimC3YkTgP59C1wEvPSl4/iGf0vxs+R9VBBCfUfM9d2wpwEZD
 99+VfepBPkVdOdn/ZCP1eVNsB3Zy8L5+HCYhD9wWu53Je1GTes4KkokhbZFarw8/YgpolbgT/9D
 pwCoipV9ZPub4xRraQEHRUkKT5JO+vce5qVZ3dn7p+IWf5bdEISU5Yc30/52g8Fmpl0Gy/57WFZ
 EXEBcCP1iBmqbhGIvV61onr3TdFiYlv6UcwmKMDWxOtGCv19Hg89iXBFJIWSw9Y46HPQ526DNLV
 y+aq05fGGpvoHf8eCKqQLdYW3XJVgM4aWxyUOiMePATz36LyqQADZeJhYts8AX9voy+NlSXgTww
 QOXQqSw7SzlyWOcL79g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfX3YwUNDISyVaq
 mTm/+NTtO8Z43eHPiiVlBEiGZFzbspA2l4VD+osRSBlAX2Q4zGG1Ag+WAbMhloecG3h6LAmmg6v
 Au8/MTFu7Cu6CXaNZIwQ3Vhjdc+n2LU=
X-Proofpoint-ORIG-GUID: iyxgGGtsILF9C7kOSv1MscacyJZ8JPjj
X-Proofpoint-GUID: iyxgGGtsILF9C7kOSv1MscacyJZ8JPjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050188



On 7/5/2026 10:53 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
>> When unbinding the ath12k driver, kernel NULL pointer dereferences
>> occur in irq_work_sync() called from rhashtable_destroy().
>>
>> Two hash tables are affected:
>> 1. ath12k_link_sta hash table in ath12k_base
>> 2. ath12k_dp_link_peer hash table in ath12k_dp
>>
>> The issue happens because the destroy functions are called unconditionally
>> in cleanup paths, but the hash tables are only initialized late in their
>> respective init functions. If the device was never fully started or if the
>> init functions failed before initializing the hash tables, the pointers
>> will be NULL. The issues are always reproducible from a VM because the MSI
>> addressing initialization is failing.
>>
>> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>>   RIP: irq_work_sync+0x1e/0x70
>>   rhashtable_destroy+0x12/0x60
>>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>>   ath12k_core_stop+0xe/0x80 [ath12k]
>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>
>> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>>   RIP: irq_work_sync+0x1e/0x70
>>   rhashtable_destroy+0x12/0x60
>>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>
>> Fix this by adding NULL checks before calling rhashtable_destroy() in
>> both destroy functions.
>>
>> The NULL check approach was chosen because the rhashtable pointer
>> serves as the initialization state indicator. The init can fail at
>> various points, leaving some components uninitialized. Checking the
>> pointer directly is simpler than adding separate state flags that
>> would need synchronization.
>>
>> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
>> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Missed to mention that pls add wifi prefix to the patch title.

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49C3009CB
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272247; cv=none; b=Ta1R/8vrhNKk+28B2B795nelyKFNk4KhY6m09KQp9RtW3hNTB6WBSgT5qYJg9MkgkGrENIGhMmsc0X82ei+lXCy4uxllOLP3v0QNKhBg6cb+CEevPPnWV7hRqE0tsZ8eBNTbVWBlxm9ISyi5ARVSAJCUUvbdW5nTtH+kB71INzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272247; c=relaxed/simple;
	bh=miuzIlBKZC7q5ljCHAuwY6y4LMRZb++BZNwEP84VH3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/j7Zk+ZMSfafcfZAS0caAUlHYTuTASJ4ROgoHHuksVAi7Gsg18z+cxs5y9jXzlG7TFSWdKmB1XMXJp8uFQ1uyhRbKnEEB/+m2Z55j7d3/y5vCdEBNxQCIXDcaLMZEOBCzYvhmCKhSdcwFKC7ELBgdDfVstwYjj2na201mtNRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvKlWPkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gz/DFcGg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvKlWPkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gz/DFcGg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6654ujo1638571
	for <stable@vger.kernel.org>; Sun, 5 Jul 2026 17:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=; b=RvKlWPkCBHO5YCxM
	+8urm19XschTQ/RZxtB74iGGOOvkoa+3D3ar3bZ76oCrF9iilIIWNbMxkoP9P3Ea
	dd4hWeT+vtewyUCUe+z2lDEGpnBUScIbzg8053RqDKSfwaXJmS1n+Y+182kf7fEu
	0ra7pH0V4pXcMC5pcZlaIX3j0ThLbjtt5HGIhYPif/dEpwv3vRyeBl9lYV0tZ1ps
	8Mje87IVbl+iUSyVUeL3uszhNKVj+NRSrDlJLgzqA7JJP9giIQeQ/yGJumEdF9Dt
	dtRECmyopQ7qnb9MM2m/YCj6Oi+GKAKp9lLJSyZKjx969aCQhdxGGoW/hTdpROTX
	Up/dSg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf82xps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 05 Jul 2026 17:24:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc77a6943eso35788855ad.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272245; x=1783877045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=;
        b=Gz/DFcGgv0gBHzEWSkYY4zd5iaWUHdhsKzHSmwSegbsHcQWEyJpm4D+dUFuuND+gwZ
         ZH/LfPFktPXW0jWNt7PD5wI9LLqxSmT+IDnOk48j5brdzQsHZhe04ugJQ0Y6mXYV9T8z
         ruUpz+d/P7Nwbbd/4gJj/GiQlUN58QKt4qkSL2UvF6kbZJYOxtL9JDcghhwZpH/ID+dQ
         1qbTcPvN6Lyw00Uxuv2+qxltbweUNj1FtHwjzHCBauMULJXcxiWlcyibvSDsCfvf8WEX
         wHr074HJrE2Hc7puhgCzuakM6Az0FXD2+f4w7IAXLVtBkfEelpTZVoMCa70PIwL/VvVs
         aTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272245; x=1783877045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=;
        b=WeixJhmZHMCXC8ZOySYiud7sHWiwgtntLaIG5zXe2aIOO32ZgyEyA8AEl6oYr1bNcV
         U/GeecUlp1PLDiiwK5nXjbqhpIFVEt4gt2q8bT7Yr6rVJ34ukfAU/xLc/nUg4XWcVcGZ
         JJm6/30Vns6kmiMVXSJIqcnIMYDCRxoRk2m4ZrkGHdCkP5KeUUVRcGJm86XInOAHimyA
         XNSm04xFVNE4kc7j0+G4oZsEHfg/p8cerxLLr+9OB6UXK96EjeyDb/o+PXDmzpv7D/5V
         X3YlTxv6Ey88pjfcPdjtNdLPvQ581q0SFqZzwrbqg+t/c2zA0TNF7waxzek8YmRwKm7q
         rplA==
X-Forwarded-Encrypted: i=1; AHgh+RrGKYG/EWwxvgel2eh9n4oecqwlOO4H6HAyZDaWnWy1Tfnm1BdL7Scg92Lo6kVB0V02iesLEmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsILp/wYU5i3hjFv2G/TwFTV57w8z8JhEmmkuhr1WJB7bnW+DS
	EdCM4AL647ocUVmBZ05RDGvbaUfi5/pqb7r3ca1bz150HzPCNH7URMUniXM7Q+HNTvXaHXFhGVG
	HgPr/Wlizo6Mr1ZlanS38UHunuTNGkE8aR5B23CELok2eM+Orrcyt74J/qn8=
X-Gm-Gg: AfdE7ck7YjtzmgezmvXyOn6B0tBlSO3txm9qgjPk7XrJVyUhlA7Asb5rHbtdsT38zBm
	54mTF7itjc6kC1+fMul1MNTHnAjWoU62INqjp4D+MbDg43t+SQZXNsYHBD+bY/T0ELdvUosaR9D
	npJFb/SHxcZboeeyEZI9ilDTZhygnaSzHQIzBeIJ7hRqpv+R6nF/Ja6qmJnebsId+J3IiBa4M3+
	0jxBhYPO6Y9CFKrSesIkdXpNtzKGQzrlZlSLUOH3zDkZ6A+3MBNE69Mc4zhgvPPOmjH+5uEpXOc
	7NdS011030zxDgIk3+43nS0tROrg/Abv2AGcxwfKXtANRT30g6gIZCrNrFDY/7LBTKW0SiiP30O
	RFxSj91yq0Z/rhaq4vApxpAW4alHanRvUfGm5lZJEByblsK+20C6PvciIX4H4FQ==
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:7081:934b with SMTP id adf61e73a8af0-3c03e2a3e2fmr7129607637.26.1783272245151;
        Sun, 05 Jul 2026 10:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:7081:934b with SMTP id adf61e73a8af0-3c03e2a3e2fmr7129585637.26.1783272244703;
        Sun, 05 Jul 2026 10:24:04 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f39e07e0bsm26472855eec.30.2026.07.05.10.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:24:04 -0700 (PDT)
Message-ID: <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 22:53:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c_5tKc3QuNQOLTQ-0btynTPG-jUPIecK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX+PJuH+bz5AMG
 +XLtEf1/0VECvnsYfoAsg2Ivcy8+UHWTNpeZuAYZyGB5SGnSLA+n7Z8qVLSW2GmZ5f2UNQaCm88
 JtKfxtN1fXNQx/vRluQz9ovDATOCmp8=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4a9335 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aXf5c7XquDVv4hRH_ogA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: c_5tKc3QuNQOLTQ-0btynTPG-jUPIecK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX4XUlUeeMt274
 N5JH8wh1J8FUUKW1uwYl0Qn9vKS4bGFjnMD2QAbhII58TDwm1BStUAB5nTAf+DHaEOIOeDET0ga
 Emi7v80P6veGsIC/OvByhJRF0XQVplNgHqItCk5k4cZ48dpJRgG2pUmVmt5LxM0bjXU4KR74FAR
 CnAUXR3Vz/w7jaKHWHdD8L34I5MDRZ+vv/j7nbRmsI2RQUqceR3Pb1EwhJrAD55OToYyvnhZSu/
 cMugOMr+oJIzH9ULGzx+Rodhqjm3FybCYBLJIhkpPVozEVf88CGYDWaVbhsMaS7wlkKYN8t2NZY
 WNHexrbwGs290TkEz6vtt/3GtKAX7cmYcvOBbnr0tn0zOe2aUsndM8NgAUTwkdBePebzKrXlchA
 I1+qo2x8VNwvDQDZPwaiue+03uy10N+nIsYSULuVNi5D83+ERCls3WZkD6SkVbkWxc0pvy1XysE
 256CoKdgQMD6FUYqO2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187



On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> The issue happens because the destroy functions are called unconditionally
> in cleanup paths, but the hash tables are only initialized late in their
> respective init functions. If the device was never fully started or if the
> init functions failed before initializing the hash tables, the pointers
> will be NULL. The issues are always reproducible from a VM because the MSI
> addressing initialization is failing.
> 
> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>   RIP: irq_work_sync+0x1e/0x70
>   rhashtable_destroy+0x12/0x60
>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>   ath12k_core_stop+0xe/0x80 [ath12k]
>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>   ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>   RIP: irq_work_sync+0x1e/0x70
>   rhashtable_destroy+0x12/0x60
>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>   ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Fix this by adding NULL checks before calling rhashtable_destroy() in
> both destroy functions.
> 
> The NULL check approach was chosen because the rhashtable pointer
> serves as the initialization state indicator. The init can fail at
> various points, leaving some components uninitialized. Checking the
> pointer directly is simpler than adding separate state flags that
> would need synchronization.
> 
> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

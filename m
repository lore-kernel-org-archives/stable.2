Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554C46D57D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117178; cv=none; b=AtL312jeduQOQmvoIhmBZfIJWjVDjhycEbFlTX67tQXlb+ZJZjpyQRR4Ql9qKauARtWBNfAxeVZ8K7dy64+OXntQPxvR5GPARh6h0DHWZz0vbMrf3DvMETnfqReEC7WqHaaScOD+ReArwBhcz+lenqQqLmd4y5aMTHQAow8mD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117178; c=relaxed/simple;
	bh=GdVKiMCQghSY1NieJgI71129C8QrU5oIWcv3bmolLJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FurL19SzFPicvFrPMhzQfMV48kNM4HR7mtsAmU8qIJeu5ADTZtJ27P2luRA8avILU0+63Bj+O9kNGcs/WDOLtuAlfnwTygNwUpSbF3bCDW6tMi5fERdHPYtd9zMmwHrHB1ElxdaeITe8hW+ldMXydelEmr0YPnnJ7LHq1Os+10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bAK2Qd4D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6l68L/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAK2Qd4D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6l68L/i"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRhN5642020
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 15:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCRWjh1yZDl8I8dIWG38FEvpFTulB4/sCRQjieQKxAk=; b=bAK2Qd4DlymE7U38
	WUHXfSxWgwQt9R3qkCujwKqXKkIONZwYaSmuoxGrEeCpK4SWAdpPvKtBbZuAXF4O
	sp4hL2gJx77QXsc++9UIAHuZ7zwur4Q+uzYOhhPO3StaCdWeJIZmQab7gzhvJIue
	sI5qn5cjbH0Pdww8G5RtPulpxx8/rU8nclmxGjYawXAwHs34JXywmE/eFx1z5dDQ
	+t7+F4y+M3pRQRo0/O5Alfde2XEA03TZTBt7mj5P3D/efQeeBo7W9sYhxwDBZgKq
	7wRvkaIZN8LgNG2ADmTf0HWdmcc8A7OAxrq4Y47uSalb1KgPKXXB0AoGJfYxbNKx
	1L9/tQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu252b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:39:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so2100690a91.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786117176; x=1786721976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCRWjh1yZDl8I8dIWG38FEvpFTulB4/sCRQjieQKxAk=;
        b=L6l68L/iFp3pJ6NueVOStQQcZgS906n7MLntXj4KRkmzldNopeFkqmaML6Kt/kEBvo
         cJdcJXHQa/HfaUxEOzJwlZCtEPsr/h/WrgoT/4nzkJC68CZV/fM5Mb+2oOqwS0injfQo
         eNjw4/iMhf/KbQMfVbxkMOoAn0kWGmVRTqG4h244teF8moi7g4V6b1MJV55xd2wXrTDg
         8BC2w5ByaFqXHBZx46oZeGppVLpYQD2xBjUQVakk6FXtLbU4wTfzwkJgE1neMm4DKZbj
         KE6hsjx4a3wQ2OO74XiXa+vTXCBnxLCOdw4XDGt3mVf+IGOR073orjbkRsNilxihSPxd
         SeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117176; x=1786721976;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCRWjh1yZDl8I8dIWG38FEvpFTulB4/sCRQjieQKxAk=;
        b=UfdLGGgw5BhsXkrmC8581yZsVwIfeK+SbCLGHB/+oE6gFmzFMtuDQD73EJYeBYnp9+
         u+CbVQvrDlItBq7cJo+qJ1HH09mkndOCQ/QhQFfHm21Xho+SMp9OZY01pvstx/YZC9jp
         ivIrTgWDydZthHt0vW/vkJ/1Z9eJuI7Jp3VE1pghV9oxK0dwP0a3NIF00wh/ghqBoq3q
         hg6+KWwuefTWcWpWd+ooJMCBeF4zcKFdBNolXUQ3fGEy/yVA9rI2uODmXRjMK9WRskHH
         E5qcieYO22/Lw5OWnAcQI+7n+cqFA41DKCDWd3ZMAyBRqVWULUof5WnzZcpBPMLMvV+t
         ENFA==
X-Forwarded-Encrypted: i=1; AHgh+Rp61hCP1h7kAIn4p2PVXPMNoNnqHhhblqUYW/J2CiGoOFhActfAHGjgSiiQgHg8SfM3X5rTiJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfl6G4VHWSNQM0Pn3SPl09vQTKz36Z87sVEwT6a6RQKDczwj+V
	LYKHcKTzItu9+hLme4QFQotEBboCp1CMTnJbSvXPd5LrzzJLB0pHKPphjJCSF3ORHWl2dHLZgSu
	MdSa2a+cF67OGFheIEBzOC9LXiVJXCQTDdS2Nw9uQocOQJzUt9khd3NXsjzA=
X-Gm-Gg: AR+sD11TFe5nLjUHtVItzGc2aHPHvVhnh1qb8N/aNVcMj3M1BJYH/H+GoBcWoUTQms5
	iifB/A2KOWNbThSoeeeUnQ/krgPHcaEDkXzzKiZWVSl8OY99v/Vwjr6Oi4TL3e7MUOz4+hzTItN
	DPvhrAUYX08nxvg1zk3EiZBzsi/NC9PBXsMrmdZmjMXI9SWd0Rv4wcT5b3C9o+fDSnplLGvSKst
	Lmps3hsW/Fhu6f2LGbA6vFioVPPqN1ORE79yko5f3ga5LiTNMEZU6VTxIdgpeaRxYgFcpSa8bAq
	FhMOr4ZiDcLDLNlY5la9jFuFfB+usZMU9aXWLvtVIBIyVKmh4hIuwd1G26EZ7bjXEkf9/XJ2EbK
	jaSDNng4eKzDCowt/WqWbt7RyTqQt856USb2bZtDtBMk3XuyRtQuo1v5Mfoqn
X-Received: by 2002:a17:90b:4c89:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3928221e3d3mr341642a91.4.1786117175548;
        Fri, 07 Aug 2026 08:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4c89:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3928221e3d3mr341595a91.4.1786117174898;
        Fri, 07 Aug 2026 08:39:34 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm9696021eec.23.2026.08.07.08.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 08:39:34 -0700 (PDT)
Message-ID: <8a152b94-d6c4-4d51-8362-1047ef311c70@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 08:39:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: run ahb shutdown() teardown only on WCN6750
To: =?UTF-8?Q?Andr=C3=A9_Valentin?= <avalentin@marcant.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@kernel.org>, stable@vger.kernel.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
References: <20260807094858.1548216-1-avalentin@marcant.net>
 <79444a54-8500-43df-b0c6-f6a98c230dea@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79444a54-8500-43df-b0c6-f6a98c230dea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dzUiyGeeReQJzhqFK0zTDb5jzR_ktYPM
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a75fc38 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=7bAZdoCWAAAA:8 a=EUspDBNiAAAA:8
 a=sz1l3bY0xy_xST6I20UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22 a=7DsIbQzYVz3x35o7bboS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyMiBTYWx0ZWRfX6h2a1WGgnl4p
 bApW/lmsDRU/JyQzoovmNcHyoAvegEGApnWNV99roh0kbmgFYxB6meGrTtFNxIBsyHrmsj0npyt
 hYiu3tF0UnVrNfSflx8HvUC5vXPBsOI=
X-Proofpoint-GUID: dzUiyGeeReQJzhqFK0zTDb5jzR_ktYPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyMiBTYWx0ZWRfX6f6ao4lIe6S/
 QhnXcgMpdj1L8fXSxJkChWaVsDErH5p1q057KI4w1VY9a5Ym09Pn5qoPQaOXekOBUQXMswmzM9p
 7AVJgESv37nHj6oxXq48TbXCZZTRnkN2BAEs6rU186dgVsU4tyFmk6ZEAWvrxkUz0R7XyyuZMBl
 8GMdtXmOKaIb8yCKHdIDgIrpIjVsn6xtZ3hRxS2Ysh6B1IJKWWvc70hA4aqTcZa00ehub5a0oja
 4+V/3fBS+9KB6sH9xF0VltGz1oBBNk0s1xdCp082YXgK9Y+3axj0nuosN/yRkygys7Pt2Aq0KiE
 UpDKDqV2+A3+/BmBGKYWvJFfIObJmZgSz+PSvIDkRBUEniTMxlN6+oT46YC8lU82cB6hgKixa/f
 yrvwdOd5Ama2het4tLfCNp92Y7LKOep8gwhYKkb1FdY3a6+2Axg9Gji3GxfRdjrGd6piN3f+YrJ
 HauGnhUNO5uSSZU1Zig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070122

On 8/7/2026 8:34 AM, Jeff Johnson wrote:
> On 8/7/2026 2:48 AM, André Valentin wrote:
>> The AHB shutdown() callback was introduced solely for WCN6750, which has
>> to stop DMA before the SMMU is torn down at system reboot/shutdown. It
>> was registered unconditionally in the shared ath11k_ahb_driver, so it also
>> runs on the IPQ AHB targets (IPQ8074/IPQ6018/IPQ5018), which never had a
>> shutdown() handler before and have no such SMMU requirement.
>>
>> On IPQ6018 the shutdown teardown stops the WCSS Q6 remote processor
>> firmware. Stopping the Q6 firmware leaves shared WCSS state such that the
>> boot ROM (SBL1) hangs during DDR training on the following warm reset;
>> only a cold (power-on) reset recovers. A plain reboot therefore never
>> comes back and needs a physical power cycle.
>>
>> This was pinned by bisecting the teardown at reboot: skipping
>> ath11k_qmi_firmware_stop() (i.e. not stopping the Q6) is what lets the
>> warm reset train DDR and boot normally, whereas none of the q6v5 power,
>> reset or clock steps reproduce it on their own.
>>
>> Restrict the shutdown() teardown to WCN6750, restoring the pre-regression
>> behaviour for the IPQ AHB targets. On reboot/shutdown the whole SoC is
>> reset by the boot chain, which re-initializes the WCSS from scratch, so no
>> teardown is needed there. Module removal (rmmod / remove()) is unchanged.
>>
>> Verified on a MikroTik Chateau 5G R17 ax (IPQ6018): before, a plain reboot
>> froze in SBL1 at "sbl1_ddr_set_params"; after, SBL1 reaches "SBL1, End",
>> trains DDR and boots the kernel across repeated reboots.
>>
>> Fixes: ac41c2b642b1 ("wifi: ath11k: Register shutdown handler for WCN6750")
>> Cc: stable@vger.kernel.org
>> Cc: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> Signed-off-by: André Valentin <avalentin@marcant.net>
>> ---
>>  drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>> index 1e1dea4..749d8bf 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -1288,6 +1288,18 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
>>  	 * remove() is invoked during rmmod & shutdown() during
>>  	 * system reboot/shutdown.
>>  	 */
>> +
>> +	/* The shutdown() callback was added for WCN6750, which has to stop DMA
>> +	 * before the SMMU is torn down. The other AHB targets (IPQ8074/IPQ6018/
>> +	 * IPQ5018) have no such requirement, and running the teardown here stops
>> +	 * the WCSS Q6 firmware, which leaves shared state that hangs the boot ROM
>> +	 * (SBL1) during DDR training on the following warm reset -- only a cold
>> +	 * (power-on) reset recovers. Skip it on those targets; the SoC reset
>> +	 * re-initializes the WCSS from scratch.
>> +	 */
>> +	if (ab->hw_rev != ATH11K_HW_WCN6750_HW10)
>> +		return;
> 
> this is not the correct approach per the driver architecture.
> all hardware-specific operations should be driven via the hw_params structure.
> 
> /jeff

+ Mani's current e-mail address @oss.qualcomm.com

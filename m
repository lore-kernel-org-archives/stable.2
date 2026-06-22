Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79C13959D
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095700; cv=none; b=M+dLLvIWz1k4zwlBUEz5tqcgV+PZO6NsiZ0mXQ24Y1ruIPNzLdNHXlpI9JdLxVkaVoweYnqDQeXV3V34WSl4gmXVQgpO4+nJatpJnkAzsF6gDiypEDcvPYhFh/klG6D9ZIfCE/WEgvazwjUQ0HIcZQYBGQMWEzgs4o8sB00BEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095700; c=relaxed/simple;
	bh=D3lstHqvZc+YIkAbeAvbLFuWSdIDPtorhTDx2hkeOXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2LrUgyP70nqqjZMOYB2iYMThpJOsIymX/nCz/OEe9P9CZRjDxmqWlPTlokr68QgLicr9geJ4Xi2IX15HjZ9H9Jr6wpfS0OSJzuoRKyOy+HY+IFoNdcF4YHXEsfQUlSwCBXbXFPJoMEmVt2J6vMrkXYqoKaGrVMVZF5dKT4yQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKjPbXj/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJvdcxdb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKjPbXj/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJvdcxdb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LDugU81925763
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 02:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mne0GUEz6OpNmdcltfl71SAzLPubQMY8lVt3p1/pCoQ=; b=AKjPbXj/9BMGB865
	mpHTwuwchzIjg1p+rJXRumhGgRDytkJkNuL3rBUK0Yg/CseGy4cDZJHv4AoVTs9Y
	eL0ko11qcKMbhAkkXBH8GGMpn9wstSzOH/X8hOMUKaxkBNQgRa0jWC4D+E5XAROk
	39GVFqvHBipgbG7GVh3le3zZB6to9hn0/r0fO+tj+PgGX2OE/X4YU+Kjbi5LZuma
	1eXtw3Yh3hrrj0EMKYstS3lHFe2mL2eNnGtK9NozOJ1EKGOE3VwrAO9KO7h/2Of5
	zmkjfp4Z0BV8QExvXSs0nMZMKZnSbZB/fYmwGMgekr0dRiXHtR21gwb58pR4U1bP
	9ALMGw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewkmec9th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 02:34:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2524549b3a.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782095697; x=1782700497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mne0GUEz6OpNmdcltfl71SAzLPubQMY8lVt3p1/pCoQ=;
        b=LJvdcxdbU3b5cWYFRPhvGBruBcGmwS12ueuB5GEMg+5H5PsL72k3nqSQUAhb7L05vD
         oixCFS5sWnR+2xBDc2IQETMiOynoSvzusbknaSTASyM522ax13MJUTM2PL2/PTkdqMzN
         wTJMK49SxsNol3MAlwvWUFsnQg3Iv/DQIiYB064n925VCfj9hImzRd+ioXaSpY2KbXfZ
         Z5s+HihNbhbbl0pwdmhBGRItOu9OUSfWDKJnSQkVRquDSZ9Baw4tNz+Q7Gef6ygafb+T
         pkA3c9EU7Bfu1wATxLrWH24/pymKIIKnjdaFRibtx7x+s2DSi1/MfjeHYLPEcRupQ45J
         wJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782095697; x=1782700497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mne0GUEz6OpNmdcltfl71SAzLPubQMY8lVt3p1/pCoQ=;
        b=ZwcgoQ6Kd7tC90yQpg03AvECxA7H7EM1qD24U4ZXLiRdMl6fxxz1X+YChYUdaQYmPG
         QrtIxHm7EgxQbzXj48i1foXUae3CtTcpidOKMjeipdTV6aP2By11OUGxB/qNHoCZCiTU
         PQKZwi8qQ41L+f6Ev/rNkhFWmnQ+9JmszV2FqTDqR7vPZTs6N/H+xMPkJgXHhsywloji
         nQ7jUUmrSRNZ6cxloceUUYaqbiErJEx5YzJFZbuPCDt9Dk8fAH7vlVRxw5h90zawsTxg
         lWwUqebG/fyn1gb68mAR1bJqzsrgnsDtsG3c/puY+jisigHzf5m/OGHNcnAcgcEDMU9z
         vvEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tJtkhkahfqTlxV/1SNNgWzXF4lmzI8J4KSK7B9zLDlQI/yPho6mCfLq6I6yGVwYLYLF6RYPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eSkRDIahO4JxpWK0cz+UxRA34MbEy4GMiRxPi7TjQrwGA50U
	/hSgZWtFJtg75nLs01oouMOCwcE4vPjPgs+9piZ0O6cvLqZiM6+6zZczJNiwlpn/Ovgnt6mCqOM
	I0NX/cqIdAdZPjNKJl2vXMjUL5IRgZIh324tCZbxQvVEwHsvnrfHyGTzXmMI=
X-Gm-Gg: AfdE7clD/OoUIyl8eU+3kT4V7xH/dOUlwH8Fv2eDoaSzyb569wVX6UDELMsVf0M96Nu
	HD1iq/zDdw4y6MkVXyc1YcTGYgtjKtKXMgw1sSptbOeqcR5WMWBX1GQNCHLzFyd2uMG6Sthw9J8
	06vDA4Z4aLSoZlSX557HVXoFdNIZfbp747zCIBcVJSFSFDhN8/Vv09iDQ/rabLmbUy9h0T2++se
	iNTMX4SO6FXQme1zykMuDZL9PHgnTmgIKqFLzeHW3SS0pc3ZuTf8PyDyIGr7id7jPdMQRHUOhnU
	hwquuIptdVU2kBu7258H61GNEGDKqoQVJzwHtBTjaN5xpikoNfANIk+eDQ1v2V536jgmk6ArxXm
	1en8SJv8v4PCR0s/Ye+NhbWzIfS2WtA/MMAlNsoj/2D/9m4Nu4tH+NE5Pnmw9DC/wOOpoPSZ8dC
	AJ4K6MYhQ=
X-Received: by 2002:a05:6a00:4c9c:b0:842:5da3:9b8b with SMTP id d2e1a72fcca58-84562560d43mr8523435b3a.36.1782095697362;
        Sun, 21 Jun 2026 19:34:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c9c:b0:842:5da3:9b8b with SMTP id d2e1a72fcca58-84562560d43mr8523405b3a.36.1782095696888;
        Sun, 21 Jun 2026 19:34:56 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7465csm5478175b3a.32.2026.06.21.19.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 19:34:56 -0700 (PDT)
Message-ID: <fb19d1f9-6e36-45d6-a892-0c72b795c790@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:34:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the
 adjust_perf path
To: Christian Loehle <christian.loehle@arm.com>,
        Hongyan Xia <hongyan.xia@transsion.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
 <mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        zhongqiu.han@oss.qualcomm.com
References: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
 <8d3ddc27-5024-4b9f-ac84-f3d92f35246a@transsion.com>
 <0767a224-d988-46d9-a535-2b490d990287@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <0767a224-d988-46d9-a535-2b490d990287@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAyNCBTYWx0ZWRfX7rr8smVvRYSo
 pGssgJm+Jngxmc2SQrGj6GjUwvQJxZAh2ly7bGwIYA+ess+ccLSdhJS+dgCRifOzkyVgApAj4Ym
 5PI48oWMn3AtKxId+XS/+HJ0HXDkJhOxRtWmHdhlHBkz9dn2BsQtTmKqcAhFdrD9a374xpbuXty
 vzFJ0dtPaEFU0/mUJ4wYLuDgYxwOVI2h/BnMsXZPhA3T1SM2y0UmGC9y7llCIcrqwBCf+51B9k1
 bMPhBd8drFALiYbN35VhHM8X8NdkrbQHmIFdBeYZDE3CBY+GBnOtfE7AVrCl5BF74j+uLi58tq7
 VG7WN2ds4LPAI/HBxdmsh1PV0lGOgh3nHxB8PPgqhwhP7Mr6La+h7kUph2lqIUe0XgvWT6IJFQT
 hJVscoeBBhI0e08BlSf59oMbz3ggHRAkKkl2Is16TxS5Md9C0eckErqidNCUc65IGZoVxqVAPtm
 F/Jhsf0Jq9CcR8eUCLg==
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a389f52 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=syyFGKjPf3kOnwka_wwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: s_bPBILboHxnvRWZk7TKZlqEoj87z4DQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAyNCBTYWx0ZWRfX59/EqYoK3KuL
 grmJ3HO1E0nFjFs1gBsMH1MukwnV6WLui5SUQTQtKGSH+xZeoJGYtBtqchKiuaPNW9J3mj1LjLy
 xZSlWZzliHWqkLtPzXsMunzj4r0L3F4=
X-Proofpoint-ORIG-GUID: s_bPBILboHxnvRWZk7TKZlqEoj87z4DQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220024

On 6/17/2026 3:27 PM, Christian Loehle wrote:
> On 6/17/26 05:06, Hongyan Xia wrote:
>> On 6/16/2026 11:47 PM, Zhongqiu Han wrote:
>>> The need_freq_update flag makes sugov_should_update_freq() return true
>>> regardless of the rate_limit_us throttling, and is cleared in
>>> sugov_update_next_freq(). sugov_update_single_freq() and
>>> sugov_update_shared() go through that helper, so the flag does not
>>> persist there.
>>>
>>> However, sugov_update_single_perf() (used by drivers implementing the
>>> ->adjust_perf() callback, e.g. intel_pstate or amd-pstate in passive mode)
>>> calls cpufreq_driver_adjust_perf() directly and never goes through
>>> sugov_update_next_freq(), so the need_freq_update flag is not cleared in
>>> that path.
>>>
>>> Before commit 75da043d8f88 ("cpufreq/sched: Set need_freq_update in
>>> ignore_dl_rate_limit()"), this was effectively harmless because
>>> sugov_should_update_freq() still honoured the rate limit even when
>>> need_freq_update was set. After that change, the flag forces
>>> sugov_should_update_freq() to always return true, so once set, it stays
>>> effective indefinitely on the adjust_perf path.
>>>
>>> As a result, cpufreq_driver_adjust_perf() gets called on every scheduler
>>> utilization update (with the runqueue lock held) rather than being
>>> throttled by rate_limit_us, even if the driver itself may skip redundant
>>> hardware updates.
>>>
>>> Clear need_freq_update at the end of the adjust_perf path as well.
>>>
>>> Fixes: 75da043d8f88 ("cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>>> ---
>>>    kernel/sched/cpufreq_schedutil.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>> index ae9fd211cec1..a4e689eefdfb 100644
>>> --- a/kernel/sched/cpufreq_schedutil.c
>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>> @@ -486,6 +486,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>>>    	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>>>    				   sg_cpu->util, max_cap);
>>>    
>>> +	sg_policy->need_freq_update = false;
>>>    	sg_policy->last_freq_update_time = time;
>>
>> Nice catch. Thanks.
>>
>> It does seem to me that setting last_freq_update_time should then assert
>> !need_freq_update, otherwise it doesn't make sense, but that's a
>> different topic.
> +1, feel free to submit that too.

Thanks Hongyan and Christian for the review and suggestions. I'll look
into it.

> 
> For $SUBJECT:
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>


-- 
Thx and BRs,
Zhongqiu Han

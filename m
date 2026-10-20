Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478254;
	b=Q4zXNPnt8X99AzVsPF/IaSmWbYzKkMLZjrI/1K662Lckv6NvkGmTETYJx6HggD3kfwSS
	 1Pzsmf7gmAMArV+wN6VjLBr2rMZkf83a6ozaZaYujZVjY4FohJ7IOn3h+VZh3DZu5MNbz
	 uqkX69sHNiATKxXfibg/setw9ae001QvnuxHGRh6nxwk40umiruCdC2EVJ1oKBiWAAsko
	 Z1dMLCi7593z8nOq6zM6LCoNWRWwxU9KF59ZZB9Te3NEmy50iPZd5pKm+rsrvQ+1cdgcU
	 p0obtOC/15Xijw6tIodK+ILzOFpSoN9O99i5KLUxWFGU1htTFrq/SfPzZs+lu/LxKcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dkeJ+qlF3OdyfA6H4VacvMWg7dys6I2xj2MZMgj3Yc8=;
	b=5FuhDPB0qnhM98WT/AGUPreK4czPo1kW3IfrOl/mZU+Al0oudtmHyWrdBWbAqwkxiHKm
	 xDDn+46cYl4E9yNd//MhoExOOZh8pb25vpSXq5v2MQc7hcqauURgsYTEwR2ZUf0t5T/RZ
	 5zB/rx/+lav5Lpuj1jBg8BKg2ihF4LkOHlrdTvALjr6tCoqiwvECSeTvNhJZ+9EiDwYwI
	 uDKda7fgnk4yD2ibS+X/d5nKsSqQeQso34w93ERQTC4YH2bTTPJg1NbLYPzMMPc/Y4xyv
	 wpgYA5aD/H93GwThWGWhDFupUfWLlnIPoiljZCDt8GOcA5Pp/PFsdAjA+GEQLzKpZIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Hc/kPQ22";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISrY7ec8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462960A260C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0462960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hc/kPQ22;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISrY7ec8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tHKO620268
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dkeJ+qlF3OdyfA6H4VacvMWg7dys6I2xj2MZMgj3Yc8=; b=Hc/kPQ22WkzNYqHX
	LUSP2d3mZ2SIDMy+h1KWfkj6ZYX2dIo0iHTATXCu3cTut1qM7lyyzMjL1ArhMPkm
	D1MVX+yObTqSzih8zfFqsEoNmwnm1GfWWe7yj5gHYHdKH2C6vmsNXLD3TdYF8LME
	Yo0Rnwl0MmJGyuCcmTibxasGLKFVmcQrszrTeoLRMBiGRCh29wzf62WujLhVJmiE
	IwzZHPEnn4eOMNp22CaFkf47tMtQr5wuisDykYXNE6S2TDU8E+FOby3txGI454pI
	4A1t6I0u+qnxUiTcPo7brWpA90qxOAjbBr9b/LR+Z2SuF+/kaP6x5WJN7mkKsKH7
	8MD2Qw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ns5ca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:37:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f26dd2165so980915285a.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792478247; x=1793083047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkeJ+qlF3OdyfA6H4VacvMWg7dys6I2xj2MZMgj3Yc8=;
        b=ISrY7ec8LxQiWuc2N9xovB5OGQG2N6beSz+y336Ff6ZG1Ld1iLM7oJxTJtonSii7j6
         rGHb5+xZRlLCrx3OSCk6yZIgpoGn0twE4/WXn8eAFQqzZHpc5Mv1uKkEZKcGPsUo3gdS
         vUZWtjgmB6tZlBOgMP66h09voRlqxZX+pNRF5qtNrkjMsJgtzWAgqYbGP2ywfRGsHsv3
         I5B+FIXOAs+PwDeZxzpYTA201MwNn0QgxRMhGkdnhk+75IwaMh29wTNT9miI1d1CLqY4
         KxAjSW0Fp0V7uamjsIuL2QeHMWaUxrSZ1yBuQjEdGVqLnzgRxeksVfuHEs4qIs1mpRni
         4k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478247; x=1793083047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkeJ+qlF3OdyfA6H4VacvMWg7dys6I2xj2MZMgj3Yc8=;
        b=Hrw3FNFR/JhwXgROhCnvysZSJ3/8/i8HlFthCmLuktSliPzaf9Bs48bJVUPkMJpdAA
         k3NXLeIilmizy76aDTzuVu6ALRLGvrSdeneH2P36SZmzGhx3JNt9mspwB688xAJgpGf6
         duT1ZsWPtNjyQp4u7YEXqUhFc5cp5/JFarNR1UkBf4/bSXJiY7GfDhtX8sBOFibtUE/A
         k4cpZczk9VjbXU+C3e6N5kWGuR8DsyCDq4b2STawe9oIYCUKe+PtVUUhgqA3XtWks7H4
         sFSdZGUJ931ndhagJZBvt+CGlM1/VLpuuSU+0koJdVEfo+ihC+xSsfrBfG0xHoicCrTM
         wBsA==
X-Forwarded-Encrypted: i=1; AKwUvBxs1EuN9o7LoEb5nOKtYEHUOMkUxm/0M/xc0pYPBSt9oIewNG+JOZ4tFfm6wRehWhOGM2RVC3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbNzWenB/QaXlm1HgucVMqSi9QozIBiVMJrWZvkN4ee6QRDiRl
	uqEnPpD05fFv6iJrzZIVDavIKMSCqGEdE2WAEMpFlcenHv0l7KtewvQsPBi9/mFuEQcJnwdSYjX
	drhTt5O7sCCzGbtn0IuPwQxxiQzgTgcXEu5bi3F14/QrLpSOnlgkbUP5Bpls=
X-Gm-Gg: AYBFou21/n+z8VHd/RGs9EBiWRfB21c/TB11d96nqvcpHbhqUZT9VbNTT83XWV3Tgyo
	68ppUsYJJWoucAo3Z4Q7r6unNtzgUNTT2JIkuEqa6H1hA5qszGJhDqrUPMnI4G/zJByGjSzZRtJ
	AKEI7pnJgH7lfN+cnF3DBp96WwJzp5+HRM/Q1QPgfEbKrZ3sQpq6n/RRimRFMe+a+IwYTVdW6z0
	WN1FC9FYLKm2hcPerzxm4YdRg27Tgc0HyEqZ1ABz9BiaBQjP3tr0QF12I0aXKvq6brv5jdwXd2E
	/8Bk+PLEf1cYMK4akUaDZRETv+PdtmYctkBdKHLbeVD4msclpOXFWFPG+OTnhxhKHTPhfHcFUdJ
	drakhjlLwxe7zURyoZaMIZvWjzw==
X-Received: by 2002:a05:620a:1a0b:b0:93f:1af1:7951 with SMTP id af79cd13be357-93f29dad0efmr1717290885a.66.1792478247239;
        Mon, 19 Oct 2026 23:37:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:93f:1af1:7951 with SMTP id af79cd13be357-93f29dad0efmr1717288985a.66.1792478246827;
        Mon, 19 Oct 2026 23:37:26 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm4079204f8f.16.2026.10.19.23.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:37:26 -0700 (PDT)
Message-ID: <5ace1d37-f480-463e-8705-e52ad7f34b0e@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 07:37:25 +0100
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
Subject: Re: [PATCH 2/4] ASoC: SDCA: enable pm_runtime before taking the
 initial reference
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela
 <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261018192359.287987-3-srinivas.kandagatla@oss.qualcomm.com>
 <atXXQv+d+AGd2VIO@opensource.cirrus.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <atXXQv+d+AGd2VIO@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNiBTYWx0ZWRfXwFAsmAIVm4PQ
 uChtU4CD+d616Lc6gPAk6i3FJo1xCT+h7dJ0hGhrXwjYj4R1rU9QhCfwT56wm9ndexhL3pIEgL3
 D38pdYak6sOeBvIIE7Yp95t45z5ci5w=
X-Proofpoint-GUID: qq0wXVe9naEmOPnbJ0LdpWsWCGZk9khH
X-Proofpoint-ORIG-GUID: qq0wXVe9naEmOPnbJ0LdpWsWCGZk9khH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNiBTYWx0ZWRfXzb0c6lWXIy0u
 Oy5dcj9k62xHOlA4A9k338/RNxT27JSOv7+wml19UGx4ZD3FWSN2f18PrSOFTDR10f/wOVChPbw
 mcjdrCYwwclT/TW0duU6SfyFug29eziJ80GejiXjC2YKQ7zLIC8SsLnYF16cTazrhAdB3bYdhUT
 FKSaszLqzzj+oSbJf8FRdNuwT5v9e8ucM6coFd8VYpj9b+YgZH/a6Np06wzPh5Zz5PAtb2hdWVx
 d7QMQiu1ZmyHthBimhIcVnCIUrjnQwRxR1RCf3vze6oEKqOS2TT8CqWefVdPX9vuvw+fI7+Gtz1
 CGZLWklrW4IpWp2Us0sTj+vONn4KkOnEJfwP6agkX7m3g5FYzKqgDnwWy99YaPnpqcm09DrzbM5
 2UQxlX+uEcP9cXaJ07wkftJATyPtXWggn8/AKS3twCODeTrAmUGqogEfw5ydMyH2Jb+lfEP1Iva
 ogKoiEBa6d4RyP/rEZA==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad70c27 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cEVFgFB53M-sojWUyRkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200026

On 10/19/26 9:39 AM, Charles Keepax wrote:
> On Sun, Oct 18, 2026 at 08:23:57PM +0100, Srinivas Kandagatla wrote:
>> If devm_pm_runtime_enable() failed, the usage count taken earlier by
>> pm_runtime_get_noresume() was never dropped. Reorder so the get only
>> happens once enable has succeeded.
>>
>> Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/sdca/sdca_class.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
>> index bcc660aeb739..3361db188046 100644
>> --- a/sound/soc/sdca/sdca_class.c
>> +++ b/sound/soc/sdca/sdca_class.c
>> @@ -194,12 +194,13 @@ int sdca_class_probe(struct sdw_slave *sdw,
>>  	pm_runtime_set_autosuspend_delay(dev, 250);
>>  	pm_runtime_use_autosuspend(dev);
>>  	pm_runtime_set_active(dev);
>> -	pm_runtime_get_noresume(dev);
>>  
>>  	ret = devm_pm_runtime_enable(dev);
>>  	if (ret)
>>  		return ret;
>>  
>> +	pm_runtime_get_noresume(dev);
> 
> I think it would be better to drop the reference on the error
> path. Doing it this way round there is a very small chance that
> the device auto-suspends between the enable and get_noresume.
> The intention was to keep everything powered on until bring up
> was complete.
Understood, will fix that in v2.

--srini
> 
> Thanks,
> Charles


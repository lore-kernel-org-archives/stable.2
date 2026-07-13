Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E960342CA7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917918; cv=none; b=FZQZy6podwAy8JeTQ51clZNdba8ScqZwcZhWYqnX/w7+3kULbdag/x5D+b/PsDhQtGoBavofa8LBGV0PNtN5W0vUmD9jbuosZNuOVzoo9biAqjmqIf3VCEKCNAnMaA04XsZCN+vs0GcAmxgdiMYkLWls+dMi3JMy6FUBhjgiPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917918; c=relaxed/simple;
	bh=a0O70fTMiX0lv2uderbiHypRwrKj2qGNtYj3JtGh//Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiK7+AFzjtEQOk44hik05VUl9GOK0Q4IX24tW0CUxw1TJWf0iNyIsSWNOwCgsXabmmPx8KsBq3yCJ+h8vfT7JKlirivTS8VkjuvIzYSAx2FHX5/SHmt8SLeFMRccF18/wXBJowsAH1mZLq6ZAalNn2FqVytA37eOqv9uds4GRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mypC5aUr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mypC5aUr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3COks1243380;
	Mon, 13 Jul 2026 04:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t1bPnr
	PdFm3GOj+MnumA5XkkXc8/jDiS9e168VY2wsw=; b=mypC5aUrGIn40SXl6+2jJa
	ph9pGsJ3g9pH2hc98Cdlnk7AvvYbycJIGJB1D+Z380cTbmbuSq1qa7quCe5I3NMk
	xNd9XKtsh9wFGf3MGn4SM6KNn4iYrJwAF3AXt9qEDgpjj8LVyzHvKM01d8JQ5F/o
	HY9oZPpkX6vg2/HbFB2LpN2G0JQWeAlf8Mk/UrmPUwF0vvWcZvJ7q/th7yx1zl6Q
	ESTq3svA2+h8bO3cT7yydFBqCROJLU3KULHC3dUOwAoApD3FspTbbOXy5ChRZtWP
	1s7YJ0NgyR8zO+YfgzFgw2rG/ZecVNNjOEEIdGP46y5+w0qUTYCvczvJ8ZrwlJbw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexweec3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:45:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4YaTd009975;
	Mon, 13 Jul 2026 04:45:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pv8cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:45:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4iwa316777682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:44:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C79C620049;
	Mon, 13 Jul 2026 04:44:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37DE420040;
	Mon, 13 Jul 2026 04:44:56 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:44:55 +0000 (GMT)
Message-ID: <6b75342a-73e3-424f-9c03-de1695877287@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:14:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powerpc/pseries: Handle and log pseries-wdt
 registration failures
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
 <qzl7v7eh.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <qzl7v7eh.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IES4AFfdGA1cxWH9i-ZZDrYEMVIRfhXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfXxo4kpDUj/mq7
 5nj40/abLlW+nhSFvB5Y7X5beUwJjq2mvXK2n022hFr9m0FB/KxngtYAYVFIjOgFaUM/zqRTPRx
 6N/IUr3osuO6XdnemNrwZJxPz2u4pRgEZ3U/LBF5iHzizFA0iIjrL+l/X0labw/6Y1ew5Nv0zJN
 yfBZ9B1TfjpnRb0LOWWibsc3ho5K1cKFfIyoYGksJEsLNLO0UvV4z6PaeNYnt9US6Do+GhgHGuT
 SrKpcLkIGQN3QFAbv6HFNIHDwS+hTuR/XsTXFquNUed3csmKQsdP3GAUeU+e6u++163hHL6uzUn
 4BDG4jXhmcbF7Z1YUxuda8t6/8yk5zqCB7E60QU2c6+PpkVZSFbWW7GMwAmqbtKmuEx5IxXRXnO
 uyRKUd03DmU9yys0warKUnVcInMiMt0vGxXEIgYrDa6Kv7T7spbBXfX6lAKffbzP5lKTavVJvFJ
 9f2jYrvC3AdnzI5Si1A==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a546d50 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=yc9vGXn6jqAjeDJYmugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xOouCz80I5fO431FTomxxNZ_PEcIWeke
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfX1i9UhOLJOg8t
 eR+oVU4jGfLlOl6N7/lnXCCS9slA/ANkg1jN8XgYga+vVUfK198SmlMH263MecaEUv37ssAvWdD
 MIrZCetuOOvd4co5AQavouIz7Ajsg7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130045



On 13/07/26 09:59, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The pseries watchdog initialization registers the pseries-wdt platform
>> device using platform_device_register_simple(), but currently ignores
>> its return value.
>>
>> Check the returned pointer for errors, log a descriptive error message
>> when registration fails, and propagate the failure code to the caller.
>> This avoids silently ignoring platform device registration failures.
>>
> Fair enough.
>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 1223dc961242..bbb2813f8ede 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
>>    */
>>   static __init int pseries_wdt_init(void)
>>   {
>> -	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
>> -		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
>> +	struct platform_device *pseries_wdt_dev;
> minor nit: we should rename this to pdev, since it is already under
> pseries_wdt_init(). That is generally how all platform drivers use it
> unless it requires more than one platform device.
>
> But either ways the patch looks good to me:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for the review. I will rename the variable in next version.

- Sourabh Jain

>
>> +
>> +	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
>> +		return 0;
>> +
>> +	pseries_wdt_dev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
>> +
>> +	if (IS_ERR(pseries_wdt_dev)) {
>> +		pr_err("Failed to register pseries-wdt platform device\n");
>> +		return PTR_ERR(pseries_wdt_dev);
>> +	}
>> +
>>   	return 0;
>>   }
>>   machine_subsys_initcall(pseries, pseries_wdt_init);
>> -- 
>> 2.52.0


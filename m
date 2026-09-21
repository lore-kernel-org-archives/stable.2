Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9701493D46
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983243; cv=none; b=KONK3uQ6an9GCAiAwugwYyDm+Q/V8+ycZ87zvt62Uve871+iSNhKlRwluQGy2mBON3G7yvbmp3MklBaz4LmjC0DjfmiR3HT4zAsnSVu7H/q3RlxegvX9MnpESIokgFUki5/EBDyUEkKEfZiHVyoIk416lZLuz+UzkC1NIbR5PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983243; c=relaxed/simple;
	bh=0J1b4Nzf5ZJ1sGsLzkFbqHO/xtQTjulT6PuhEg+Eyuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnofNEu8y6kwyWPm+YnW3wBrjjfJXqCgJH6/gcFG8MD1UtHwodfdTCcbVTpTugOJxdLos2iFvbwKaiU29s6A0XaXFlartgGGiHz7W7rvVeSO/fpurgqqVAvwzA10VpGz9L+nuTL6JXhF492hAHkQpss7Key8agquFR/LdQ4E4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbZyFTb2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hOogYvaG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbZyFTb2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hOogYvaG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ARgv3351661
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PtvOL14YM3nT3vmMLJC7ZnwiIKwt3L317gMzSlbLMW8=; b=SbZyFTb2kS7NKCNU
	kLYx/JCkdxkuvWkf9rlXjWW5yO/aLeYME/9hWFOw0THtXuGDhl78tCjzQmOLkWMw
	dL6TTbrVNmyCXtUX13Fl1zNJezQbt3ewoVlrPhC9puwPYK8gvgyQxj7gyzAdkt6u
	ft8nBORkps2gNc5s+s349dBvzM3UCHQ4j3bfPSWfg/jiuhT72UpGgifyUroIsPJ5
	KnHecinBNLa00ov2Q5MZ6BG5ZOVLcj7j3yGPcnFBsuFtpt1ZVIvflONIEU3CkqYE
	St5COCheswdDIToETIeCMB3l8MqLOD0KP9sie+mkvS4ohMb09VTeb6j6/oeZ3Y9r
	YjRIQA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq799yq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:34:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7348bd56fso1957792a12.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983240; x=1790588040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PtvOL14YM3nT3vmMLJC7ZnwiIKwt3L317gMzSlbLMW8=;
        b=hOogYvaGz7qQFivY1N0qZD5a069y66sAZij3SYSFPcPJcXJaIvn+hCUSmniWOnw17K
         yEu+lObeqfbz+yEkZmLsgTMxDlnG9d34qVklhh0aQwmdDGL1yC0aS/CDpj/XV0/SKxJo
         tRbc8rriPvQz8swT5S31a7hrQTfMm9gNaVIHoVse7LFRPd2tqZlyq4HxHrm+HLejLJxA
         ykZ+XeCycWMNC5tihh0miiKVhbz7o9wQtCt+zFzu0FooZ6Q2lM3de8u6PwZRL9F5e31u
         mDZ+pmyM69/neEI+bFS5xzqcCEsWAMXC9qUcg1AW/Hw8vU63cEVlA706l9djAPfZj+af
         3aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983240; x=1790588040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtvOL14YM3nT3vmMLJC7ZnwiIKwt3L317gMzSlbLMW8=;
        b=PSx2BXEhLklR6IA+jyKK3UVZ1rP6/57D/MF/xxI57PWkjRt7PZfugmbkNMPWbOb+sB
         HOUz3zbW0SimfW8G7bUXQX5fvYF8h9rltDZ5GCHRm0nP91iX04JBkS0wwRqT+9QBOH5Q
         U/3u11oGriQulyb57HFozw+MxmRylKZn1UMGJiixPp04wI0G53E4coeRfKTw/mADU/DA
         nR6GbemLyBY8tHgnW01Ey6LI0qe7CrhiSVJh+g6LK5lgTNZO1IL84J2CTyWnj8ZGO/nW
         uVfuUbDC9EUJB88eLXo0GhKIbHxemnWMlItk3fM7BPUlzBkGlKRVjGsUKTe0cixl6Qy4
         WMVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwLgz1keq5SWLHMqg5vXa6rml1Azj1FTRW7fOobKKH53XDwokBO2Hm0xBYanTPKbR6zAWivwY=@vger.kernel.org
X-Gm-Message-State: AFuF++npidVtqCVeLODkXTQqQYWLOphYNckWZNJdjAE8BipaV7pUkvZx
	pY954rGzYMr2MgxGRrBSfsDAOUCynbUxjXvfXLjDTfBhTEbJAJXhd+pEv1h932+Owp4PFh+bpOi
	BWwO3bI8ZidnrGYH+fu9gz4mQ1KF+xCtxqojS0J8Ozz4wzwKC+7507ZniLWc=
X-Gm-Gg: AYBFou2eFVwAIWvbGVHsnMBnUoG7q7NykYnGCoB+yAVYtayf3N7ngdjuhxhYwn/DTaL
	FUKRCWQ6ugjKSgKy6pBAFtUifVU0vjfPkdBrpEbjcgvcnVRS/rafcd7E9tKeuxBjcT14Itt4UOj
	BLJ/9PDyZ8w/MmMpapd19CUAKCzsloB+4ZsY4dUDIRbLPZAvdS0HKvxbk35q346u3JFN7uTsv5G
	M+Bjy35ZwVYcNEAPTcutQ0BIzStg8eBc4C/yamMG9i/uQhZ5eVIs6FxPmNqgtYSeZeMsjW5Pxko
	w9nJ0VqozcDaG/j7GNlLXd0ZpZG2v1hFG8Xd4YegBLy8+2eJ9vpM5fXaAUlQP0N93y0XuloIYD5
	/SCs2iwWVFvDpjlQkdHlDzm416TQRjA==
X-Received: by 2002:a17:90b:57e8:b0:39e:4c7f:8b19 with SMTP id 98e67ed59e1d1-39e54d458b7mr16314379a91.30.1789983240044;
        Mon, 21 Sep 2026 02:34:00 -0700 (PDT)
X-Received: by 2002:a17:90b:57e8:b0:39e:4c7f:8b19 with SMTP id 98e67ed59e1d1-39e54d458b7mr16314346a91.30.1789983239541;
        Mon, 21 Sep 2026 02:33:59 -0700 (PDT)
Received: from [10.217.219.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144e16a7f71sm8005661c88.8.2026.09.21.02.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:33:59 -0700 (PDT)
Message-ID: <81666138-d6b4-460d-90fa-3b372e9da99c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:03:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: ucsi: Get the connector fwnode based on reg
 value
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260916042808.2879079-1-prashanth.k@oss.qualcomm.com>
 <aq0B1fbrqk5_ppsv@black.igk.intel.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <aq0B1fbrqk5_ppsv@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ab0fa08 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=KtO3Uq3HwnMQzyJ4:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=x3d6ePvnTooygXxn4toA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX4Q3AD8sMzmJy
 uA+Qsb68o9jzNayr8Wd7bgXDw5Imv/D8VzC38gpGTV+hRrDL6lKEc94oxES+tJEboEIs7oLptTC
 txnXAvhNsJodsk7Q7KNe1FGYCBhYrRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX8LXLBJVAdkcQ
 gGHVeDMs0gfsQWYIYmwMK523W44IoEbChwdernHKEUxJYd3YUPWrT7Hiy0ZJlT9scKqdrRma/VK
 NZY3CkLMuIXVtw9uJ5Xwqe8Ulh5Akpe2nje9sL/IjFFpHT+VnTSC1v9XQl42lpNLcNJZO+ajjO1
 yf5MqUsRCuAU/DK/pKcomT80t7+DUU8fwBr3t7qHRL/QibZlCYt16DMQSkiwJkp9vEug72CzGh8
 dM1oAxEmlFR1mQUe1sWEArcf04Xeyx19zMKHzYDrB5dFz0l4ra30HJAPkk4ed7iPp+rIRR0VxoR
 vIxs7TtIEfsywJD3WVonGdj3BV3aqmY6as3zhyEQaSx+TEWmXOsXxDj1mv1XDeXFgYDlJmD5qIr
 gOawqihVEFg5EWyySTfjECrdxdyVSBrHGkkkoofoN5pANzs7iMo9JsQ2jJqVQZZqLn9r4+F0dXW
 Cv+ijO8lERWC9t0aHxQ==
X-Proofpoint-ORIG-GUID: y_Zw84lGg5qMPjpuWbD134q3an5ql9Is
X-Proofpoint-GUID: y_Zw84lGg5qMPjpuWbD134q3an5ql9Is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210136



On 9/18/2026 2:48 PM, Heikki Krogerus wrote:
> On Wed, Sep 16, 2026 at 09:58:08AM +0530, Prashanth K wrote:
>> ucsi_find_fwnode() currently maps UCSI connectors to Device tree
>> connector nodes based on the order in which connector child nodes
>> are described in DT.
>>
>> This can fail because the ordering of child nodes isn't guaranteed
>> in Device-tree. For example, DTB may contain connector@1 before
>> connector@0, causing connector numbers to be associated with the wrong
>> fwnode. As a result, role switch and Type-C notifications can be
>> delivered to the wrong remote endpoints.
>>
>> Fix this by using the "reg" property of each connector to match
>> its corresponding fwnode. While at it, if the reg property isn't
>> present, then fall back to the old method.
>>
>> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> 
> That commit does not yet include any kind of support for DT.
> 

I understand DT wasn't added at the point where this commit was
authored. But this is the base commit where the bug was introduced,
that's why I added it in fixes tag. Do you have any other suggestion ?

The patch simply distinguishes connectors with and without <reg>
property and uses different logics, hence it should work for all targets.

Regards,
Prashanth K

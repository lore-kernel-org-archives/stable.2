Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910179;
	b=onD6jEHlLbKKCImHcG2AEv6ooRJggSMhxLyBq0lhrYNDI4/OR3/xqtE/UbzJqOK4G7aE
	 p0xN7V1HrrYG9MNC7FYr1lpdG0BJchAFdkVWbGLcXYGdZwUaKqaLbIpD8tpasiLwWdZRJ
	 mvrwHDT1ruaTUMeo10Qw1h+ZAiWauZ6KmFKmFiZOsu0VEP6SLdlkk1mjkAfeYvLjUnxt6
	 mRprYboFNo0WiO1iOXPgnPXq+CCMkTMsogRdfW7z8WMKu4XiJpFSelGQxUh/1FdEV6FdW
	 0p/tEjOWfTuaJ7IjZ/33R5HZpGkxPvJozgwf6YaaquPh4rR4400lqAGyXBTvBmI5csw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nL6T7aHUaT5pIG87xtlBIVGdVXeITIPxNhed8tYutnQ=;
	b=dAJQEDUPmQZ7mg4voNOoqeSZwRybzyojD/Jj4Ui6O91Wb0CkZGH6CBkSTmq8lLf8ealW
	 pffjgXV1vJziYh0/cYeXplJyjstgzL8WQdXiGRqSmD26bY34Het/K3EPZUbm7ZSEk8356
	 r6z5QHZeI1nPjm3KXyG9pxcXxunq9/adGUJH5EwhGRUXch5GTvAqhRFrup8AnprTLDX4I
	 AorCh6l38vpaY/93+hPwEB+ZceyB3Xey01TMpqTbHNMRXKu8o/HGuJtkRQQlxcCnP9BQE
	 umNc7iwLMaxGK7Hzfk0FpjWjhY1wY8QCxi5QeS7Gi5uFAX1vXACBMv2mZ5G+DulkBvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="J8gAWX/q";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=R5nrVZj6;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83203606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83203606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=J8gAWX/q;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=R5nrVZj6
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Jh3KN3851485
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 15:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nL6T
	7aHUaT5pIG87xtlBIVGdVXeITIPxNhed8tYutnQ=; b=J8gAWX/qKIU7Gl3tPbK/
	UrmzeUpYTospSb8zM1H79k1RVFBW1tImzs87FZXgiawZ98Xq1oVN71Ff/ZuVKLMc
	OdODjzDE7RNlHJhRapGxye/172NVMfDeGMBkHzPpkkSBaqt1uygQVIkhbrsGlLJ+
	P1PQV7c4YFMpQfvSJDFgPQPj1dQE70yDebWjrC3kb5qJdd1a+ck37V1SBtP3PE0U
	pQfX6EI3Bf+LBnkrM+NlvGQvZz49W0ho/hFjgtQ+gHIWGMUq601vo7IH8/YsdbCc
	nTWGB7I1TeL1pm26pUmFjJxVVrqNwkA/g4+549rFN/CEr4Zxe0F05sn7QnVjW7X1
	AA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hrs0hcste-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:22:52 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so473055785a.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793910171; x=1794514971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nL6T7aHUaT5pIG87xtlBIVGdVXeITIPxNhed8tYutnQ=;
        b=R5nrVZj6r7FKesvHw7VoZnQBLrZK8ANZg7sf2F4iMlAzFSN8mmJ6LcBtMiIzp1A934
         wsJtDtmaaTqEDzQrHHzwQ5M19DlBeuSm0IuiPhfB+LCo3ebQWXKUpdR0m5G6vz1HSLef
         8FOiFZmiA2cJHVIxzv70x0x/CZ8rom4CtH1a/kiAmgN/tPyWGRrnwX8r78KN+KGfLzXa
         JAyepgxG5xmczzSSMWh3PCTRhKe7+Jplw5n4btCuG2me4mjLpwCzIx2mQvUHUFJcnBOY
         AgXc3eTvH5DdR3j8Y75lyzo9yLT8IDIkl+XsNg0QpzfmAfrxv/qsmxCtumnCFb2PeZ6k
         wE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910171; x=1794514971;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nL6T7aHUaT5pIG87xtlBIVGdVXeITIPxNhed8tYutnQ=;
        b=Kg+PsHE1sM0xkcRgqySN2c7x/tSjQxKGlOx0f4D/JxEeM4ZhlB5GIEWuE2t+vwqsPw
         FgTRTpnYtQtccI0P7NWKwBe6jIyz49a3vQT3Udy5yakNvU1RO21zPZAKVd0p5nXnS5Ww
         LVTTVVgUwBGcFGYaKB6QCgFhGLwDes80lGFeB/FzvQwm0FQd2e7XHoyzenJZN7LOBfti
         xqIvzuBpuRhYn9FhZ2TMQUJ+3msiUfKlPouinvOOrjDGUcPmdlstpoz81WmvSrufGMAn
         RIm79yebdNaAxKftNLzXqS/0UldcuKD8P4Qz8e+wdVeLZjBfiewDmcxHbHnV9JPdMDPn
         LG/w==
X-Forwarded-Encrypted: i=1; AKwUvBxUk601cE7SqQVrOSzdjVFTp5jVa4JeLl9chX1Lzk3cHvfLnFtSijdeeIarzElVCNxP9BJERPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LO9KDa+gm4Ouwt8FCQdlJgFHBdRmsgAF3IgQprX3zSvxANg5u
	D9jP3PItecFsvroT0jYunPRJvytqqdlxaSr9gcqq2jSQ1M8pjzijT4NErU/9vLERqDFYgtRO4pU
	tJDQ8YiI+NKailE+6V894awFDQ8KswM87M/U7px8NZ34W5129Ntt7cA==
X-Gm-Gg: AYBFou1TxQvCgw5kYMpNw+Ch4iBo4tJuYO2yHGqyGUitWcnbHnMYXtD3w9+zg7DulVI
	5c7VgzVq5dIXsBToEcIHoyL/tSiyLte2P+FJV5syJogNRWoA9dMioB5P0lq+SlxmGuJY08G/1iV
	tYISa52Kg8N9m5nb6AL8kVtibrRXLwGVUd8pxgg+PS5UoKTAEYU2WWKZOcQTa19gcfUt5EHk0T8
	yJAQ9PtQGPpN2+NTU+GRVYJuFXtuqohKfNDUootmAzgYO09WdAoB5tjwPmeQNZHS9eG7omDshsX
	PLHgjRWx1U1+WW5KG05pOwk0t+1KvqcweNRxrmzd2dRqKh7oKeif5BI14Da/KRp1R2+GeOtM88N
	ydeAr3zKExK6toNppVuaemNcd+537bifUd/qyxctDy4uromyEsSnRQv20gzOfT7IgPJKT2drrQ5
	nnKRgwCTrcyuCa9DvhK1RnCU7CgvBQaBK0nLlr1uEux8Fjv7ca5VZ6Dyv/67YLUjWa9v0ar2Ae2
	Qo2lEEyaavOE2JqdAVjv9e4i48dgYTEtVyf6EGUr6/1c9tKV3hDACXQlfkzbSaC
X-Received: by 2002:a05:620a:880c:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-945f360071cmr27402585a.64.1793910171190;
        Thu, 05 Nov 2026 12:22:51 -0800 (PST)
X-Received: by 2002:a05:620a:880c:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-945f360071cmr27399585a.64.1793910170744;
        Thu, 05 Nov 2026 12:22:50 -0800 (PST)
Received: from [10.206.221.57] ([129.236.229.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945ead40470sm133396385a.18.2026.11.05.12.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 12:22:50 -0800 (PST)
Message-ID: <d16c6038-f03a-4e1b-9691-1ae36650f39c@columbia.edu>
Date: Thu, 5 Nov 2026 15:22:49 -0500
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
Subject: Re: [PATCH] clocksource: Use the clocksource under test for the skew
 check timeout
To: Thomas Gleixner <tglx@kernel.org>,
        Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
        John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
        Srikanth Aithal <Srikanth.Aithal@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
        tz2294@columbia.edu, stable@vger.kernel.org
References: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
 <878q39y8da.ffs@fw13>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <878q39y8da.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MSBTYWx0ZWRfX1Y1ZDy8TVA6C
 DtKEgI3y8oTQeD93+f+l0Nbw/VFlbrV2AOxtdYu0RGYEV/samsFhRpYVDqO1p6Wyt4T0iG1kpvO
 T2dPGSgTnx2lh7VHV71GSQnVAPWW+rUGrwxmhxGzdsefMQHxd0THCxZqJAW/Y904BJBRr7mMK0i
 25Vo0GABk5xUNAyyiQfRIvJggqJwWs3sORFdmng+iIvBE2vwAMr7lz1anCkFIvq+6hRH0oCm2Wx
 tIIY9/3t9hcaHcIsLruvPANrxKv9IC7PsOaFX+f6hjFradCrQMb86/cSVyAtlTawq+tBB8KC16E
 VTpTmxexk7d4mw2N+kUy4bQyP3u38/nhqOJdwNmJnpn++gj5+Datgis3fqn4/5ZLHVPmsrua4/P
 U8QMDLt22TwJ/UUFnwu5VVcer85wIHAUyS+eCQC3yom32zMvzSjmTwQZgyGxdW/SFLLMfZ6O9Rw
 Qf1rlPmmR4VXPxrjnCg==
X-Proofpoint-GUID: 0eu8qvGZQ-hdAvTAnjLumZK_UmMy2uJS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MSBTYWx0ZWRfXzeuDHC6Kg5sB
 AqdPP9y84gkdgF6HNJ3TSsXU98SAZjM+MuPdrVxSS3HSbhJje4BGfvWSZz19K57DoAWhtHe5dS/
 1Lc5nUKzADbbkbtEq7SJWj/IV5SMw//7eBpsOqVmDscFjOPTW7XC
X-Proofpoint-ORIG-GUID: 0eu8qvGZQ-hdAvTAnjLumZK_UmMy2uJS
X-Authority-Analysis: v=2.4 cv=R6GWitRX c=1 sm=1 tr=0 ts=6aece59c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JerxfvFqMz+qeRdZ4jtV1Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=6JKDXS4o0tL8RmaW0nQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=10 bulkscore=10
 clxscore=1015 adultscore=0 impostorscore=10 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050081

On 11/3/26 3:20 PM, Thomas Gleixner wrote:
> The above explanation is enough. No need for this backtrace.
> 


Ok, I'll drop it in v2.

> So your reproducer does:
> 
>    while true; do echo 0 >/sys/devices/system/cpu/cpu1/online; echo 1 >/sys/devices/system/cpu/cpu1/online; done
> 
> right?
> 


Yes, but on a kernel booted with clocksource=jiffies.

> Can you and Srikanth please run that on top to validate that we don't
> end up with that?
I ran my patch with your delta in the same guest and it holds up well.
No hang and no "stalled" warning (even though the remote read timed out
a lot during the loop).

Do you want the delta in v2? I can carry it as a separate patch from you
or fold it into mine, whatever you prefer.

Thanks!
Mani

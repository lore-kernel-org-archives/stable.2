Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA93A4F58
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713333; cv=none; b=INSBsFHXjUnNkVSyVJce4sqhGtphW1tcs2OVNdp9/d2cXJzAwvPBmlABxntQGQhdl8lL+kppGR4lokkpUEhtHnQSiYzPnlb6K4hahTFsrCGwNKIQR/lOP7aRL3WjUZXDz0i/na7bd6SLt6OzomICe2A5jhmzUhWBAuiXWA1LGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713333; c=relaxed/simple;
	bh=16QhA+eyRwLX1gDXK+tZ3CaEzpv5ZYu1QoOxtI7v2yA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=symIOGb4X+dThxMiZ63QeOS5hm/oeWf7A4u3vlM8tw2ATa6CrotfzR6Sma79j9lLG9UAhX4POVOQbEHBNer2phmG6l33LPMpAexvT7NK+amq2SwYrzveujjeRUJOcg/g2MNsPv1zw//tZW7zUVPCvXVHRUNWxlkdq90h/eWhCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (91.78.6.248) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 29 Sep
 2026 23:22:04 +0300
Message-ID: <b8916768-87cc-4489-9460-725f2dd438f9@omp.ru>
Date: Tue, 29 Sep 2026 23:22:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 2/7] net: ravb: Switch to
 SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Paolo Abeni <pabeni@redhat.com>
References: <2026090333-maroon-numerate-89b5@gregkh>
 <20260909171431.3234845-1-sashal@kernel.org>
 <20260909171431.3234845-2-sashal@kernel.org>
 <c365b590-0691-461e-a566-fc546c533e56@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <c365b590-0691-461e-a566-fc546c533e56@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/29/2026 20:12:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 206323 [Sep 29 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 125 0.3.125
 408a76d0ab6a6a06c054d212c38932c1e9d7db86
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {diag_burst_silent}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 91.78.6.248
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2026 20:15:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/29/2026 7:14:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/29/26 11:01 PM, Sergey Shtylyov wrote:
> On 9/9/26 8:14 PM, Sasha Levin wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> [ Upstream commit 6ccc22a5afcbac46d55866d72eaba22f43491c00 ]
>>
>> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
>> and require __maybe_unused protection against unused function warnings.
>> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
>> the compiler to see the functions, thus suppressing the warning. Thus
>> drop the __maybe_unused markings.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
> 
>    Hm, not exactly obvious how that commit requires this patch... :-)

   Ah, seeing now: you pulled it in to not to have to modify the next one
in the series. Still doesn't seem necessary, but oh well... :-) 
>> Signed-off-by: Sasha Levin <sashal@kernel.org>

> [...]

MBR, Sergey

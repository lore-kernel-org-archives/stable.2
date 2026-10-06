Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21D3E40EF;
	Tue,  6 Oct 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302940; cv=none; b=na9kzQio63jF8HJ5kt0XDllfYm17BcKcWZQZVCbt8shceUVRGuPdVlUXE8TToJrF19T4Ez9aujJbAWjlFhRbbCZRJc+bGvAZcUrou9PbFfDC48mzD8bCsP5+xipCE9UFt7uhik+BwNYmKRiVLKVe3nU4n6nWNH1+LLa+yPXv8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302940; c=relaxed/simple;
	bh=a+jfnn4EpxUTdTpHVi2Jp0n2tIf21E2mpQIDZSU7dVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFgSNy3ZcIydZb4UHuCKLdB4jPYyiderNvlB2Q9Funfm5G6g42oI0q2WehQzUFkdt4Dsq/dm/HpCh0heZqvHLE65lnV/qBzj0CsF0juZhWP2VEpbwCIIBhai6G7iKIlwnBM1iMGBqnESympWMrlZWAAqiM35vIwGZR76hJAO55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (91.79.33.31) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 6 Oct
 2026 19:08:34 +0300
Message-ID: <01c2f59d-8e22-434a-9f5b-b69608c3eae2@omp.ru>
Date: Tue, 6 Oct 2026 19:08:33 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
To: jiale yao <19888972804@163.com>
CC: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Paul
 Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mitsuhiro Kimura
	<mitsuhiro.kimura.kc@renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-7-yaojiale02@163.com>
 <3b43b4fb-8479-4eb2-be58-1df6f0f747b9@omp.ru>
 <12190bf2.18c1.1a0f004c539.Coremail.19888972804@163.com>
 <b85d8dc9-b787-40e0-bbaf-027df2c3bf49@omp.ru>
 <222db01f.1264.1a101087434.Coremail.19888972804@163.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <222db01f.1264.1a101087434.Coremail.19888972804@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/06/2026 15:56:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 206480 [Oct 06 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 127 0.3.127
 0884f7b061fa529b810563f359267cd65d2ec05c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {diag_burst_silent}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 91.79.33.31 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 91.79.33.31
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/06/2026 15:58:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/6/2026 3:38:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 10/3/26 12:11 PM, jiale yao wrote:

[...]

>> On 9/30/26 4:53 AM, jiale yao wrote:
>>
>> [...]
>>
>>> Thanks for your review.
>>
>>   Top-posting on the kernel MLs is a bad idea... :-)
>>
>>> You're right — I'll split this into two patches:
>>> One patch for the IRQ/netdev ordering issue.
>>> One patch for the runtime PM resume failure handling.
>>> I'll use --no-git-fallback next time, sorry for this.
> 
> v3 in https://lore.kernel.org/all/20261003085940.493951-7-yaojiale02@163.com/
> It only addresses the IRQ/netdev teardown ordering issue. The runtime
> PM resume failure handling has been left unchanged.

   Too bad you forgot to address Niklas' comment this time... :-)

> I plan to submit the runtime PM fix separately after the patch above
> has been applied, to avoid conflicts between the two changes, or any
> other suggestion?

   Yeah, it seems a good idea to address the broken commits in the
chronological order... However, the fixes seem pretty much orthogonal
to each other?

[...]

MBR, Sergey


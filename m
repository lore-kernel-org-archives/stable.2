Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5B3C3F5B;
	Fri,  2 Oct 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944946; cv=none; b=E8xFO39+0YByShWPsaeuShoC+AUNjFy21ZdDI/TFY5p6Lbx0b49e1wBRp8cRccokJV+mN5c9LCXRH4x78SLuwLoQ9kHBpulU1ZuCzKNUXPwOpt/oSeGl10TqidIVsLRUf4KoQsqCpE8jfzG84z+RgQAKzAr9hiFmc7XKZEzVr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944946; c=relaxed/simple;
	bh=BUvGnO8eWtouUwHbHDEFYxG26lLSXXH2AiXVXDmuLOg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WB9MYHpJVjR7b4wNW1N7sabXXm9S5Hf4cKLvjbONLozI0r3euQ9yw440Odaxan7ev9NLCnMVReip/BpGpo1t0w0liiNX49l9fCjN5KBjpXJbJSbi3R4B8wYIpKzXWOMxDKKtoaxkhc5DW2Tg9bW/Glzckc7FK3ryBFc53fyMI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=CxJCeGeU; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="CxJCeGeU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KEVK9YQmzSm9E/MrvY2/8/mh6jtCC21hZIG9NdLI7oU=; b=CxJCeGeUNSKcJh8spXxf7e4Epj
	m5l0QawMToo/N8qImBuCKL36bTXYG8v54dzCbs0/zK2zrH3PWdvHBdoiUcWb8cJErepcx0BaT2fSH
	1aoQaG75gqBxNYQGXMPeM2iJhf/dgB9nCPZpPM1pxKxaZ3vb8hvsLq41DzK17v2s3VWlyi5tdnx6m
	1o5sfKaqSoqIvZjSqLh1uzbzXRs4Tq9NYyZ0HNTZE6m2Te8MqR7w/MEEWB1eGCKh5sMuslFGFw1Vf
	AxacBwv1SQxkpESPx33UsCa9cxRZjUb6ddUwdSsEfp+BBIhFgbWvp8RlOiHfaeP4qMjm+z0Cwvbhr
	Uij9QR5w==;
Received: from [::1] (port=55916 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCcao-00000000Mnc-2bwt;
	Fri, 02 Oct 2026 14:42:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 14:42:22 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jon Maloy
 <jmaloy@redhat.com>
Subject: Re: [PATCH net] tipc: protect received keys from concurrent flush
In-Reply-To: <DU4P189MB37502D602C60A78B58AFDDA1C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DU4P189MB37502D602C60A78B58AFDDA1C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <df6d6c550f8e7ed7bad690ae9c581645@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-02 14:09, Tung Quang Nguyen wrote:
>> Subject: [PATCH net] tipc: protect received keys from concurrent flush
>> 
>> tipc_crypto_key_synch() can queue the RX worker again while it is 
>> still using rx-
>>> skey. If tipc_crypto_key_flush() cancels that queued work, it frees 
>>> the key
>> without waiting for the running worker. The worker can then read freed
>> memory or free the key a second time. Racing key exchange with key 
>> flush
>> triggers KASAN:
>> 
>>  [   12.986077] BUG: KASAN: double-free in
>> tipc_crypto_key_flush+0x401/0x530
>>  [   12.987937] Free of addr ff11000002268080 by task peer/112
>>  ...
>>  [   12.991938]  kfree+0x163/0x430
>>  ...
>>  [   12.991983]  tipc_crypto_key_flush+0x401/0x530
>>  ...
>>  [   12.992152]  tipc_nl_node_flush_key+0x174/0x210
>> 
> Please update your changelog with decoded stack trace.

You mean the full trace including the parts I snipped?

> Do you have a reproducer ?

Yes, I have.

Jérémy

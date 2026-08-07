Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DB37C927
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089947; cv=pass; b=knUA/FjdsgGUfsAc+ejDxJ2z0siVJlwgxrLD2MVx4psrKIfShcUkH2BqBtWJHFV0Tq2gevJeZ24zow42AeO7g2fKdKNE5jHiklmpETz4E8I9rGTOfT/0sSFMREhLeo+wJshdOR51JuTcX1g6b/GyfKXPkEdNMH/D+CeiF7CBjDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089947; c=relaxed/simple;
	bh=MEKzmeRf6UZpKX2ALM0WH1zFz4+p/xtPLFT5XGP+qLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTvzNSLM/nEPq3s8R4JAuxc6qFOaSGk4rS/9bFOIQbLtYeMy3SVrPV2zlTwpDQChOdVIOTcUTvts68mvjTSF8Ji/XYp895y8R01SnFgA1rjTNzeZ2RsZ4ufj67XsHQ4a99wlo3ESmr99gLofxTpPjOvzD2GCURoYodhUk+F4YRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=C82B2Dod; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kQ29C8kE; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="C82B2Dod";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kQ29C8kE"
ARC-Seal: i=1; a=rsa-sha256; t=1786089942; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=im65zZy+jJjKIbzdS0k29Xwsy3ohCLTHzx2/Q4XPyWYg/R5Xx0mqeBMr6gFh1KBXMS
    S/+IfxggdgdyuWz4z32cYb+iQUiDc6lXPHUVgYxs18cyex7n4YioefaIFQ/yL5w8ZlmD
    fFN4ge9rgndiT2MUmyvekI7bpxN9pXCgJSex1yPf2cw20oxoU4neN4/MGgsK45UD/c6F
    o0L8vBlyxom0C0zHtgHeu+s3c67bCxjck634UbrK6n5a9Q5PPQy51litTRcVNs6kJOd/
    t4m7V/N0iLpH7WJDbHP0PHY06QHFoHH9S2oXS1fTeCpJ562MqK1rIBIiZb6eogjcCJ3n
    15YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786089942;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Y3FRPzJX5lX88iSURcicZ2oNPInrlvLVzdjBLGBlWXY=;
    b=qsUwgSnSmyd3x0jZVDIUOh6SRWZqN5/7r/udMsn2kBLaBsByQHFA9I7/PoceXWvzAV
    xQzYnMAzilvkUQGYMNc2F3IDS5RW0q7Jkyc2OVJsVeSJhVob5E1LYnS5VFXpMc6K0b81
    RqetOme8a0w+ldDP0hy4rv9ibIUPLqo5vBCuMgWeFJ/5HiGEYo8xUBiDXY5SZGXHV325
    RcJQ13/Tx/rw0TYueYSg3qMHIuA48THET8EqZ+mCo+ep+AYk1oekCm0GSI9Q5r7pV/NK
    QB+iaGR2nuXXxd2iL+Rt8c0VWY3Asri8+OfAWqTPV0K/zjS93Zz4BPzNstmzhXQw7Q1m
    4BTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786089942;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Y3FRPzJX5lX88iSURcicZ2oNPInrlvLVzdjBLGBlWXY=;
    b=C82B2Dod+jY87FhE+P3RbUaomIOIgjOAcVEGHULezREb7FDNkTEwECuIF/DTO8q1uL
    pymANoj1Kv6tYL4J3ebhCXvvzawMp6kEu79tuCYBfQkY8wBkM1Fru7fneDsihCyCMglO
    gDHnTfqp8y2ijpgtVM62lqcMsEwQsjdp/4+tXiKNbtURH+jt36/87yWwa7+Gl3K6Wyfo
    oa1yzIGIU3u85TnNPsEo1fDHYeddE6L51iyiq0+tD+2ZpsP6+CRNa2VlzzLz6lgyEkR9
    4Fv/wYYqRCEpiDx5l37O3ObQSTgwsH/3EjCsGtK4niCJFPeCENVza/X311n36nmxT6mI
    uodw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786089942;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Y3FRPzJX5lX88iSURcicZ2oNPInrlvLVzdjBLGBlWXY=;
    b=kQ29C8kE/IDNlY+prCc2RKAcJkCtPq5Nay/awg1DIyz+fi8aBamdYLB80ibRrddGSP
    t9SMWs53GhNbHbapj0Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.111]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281927785gFio
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Aug 2026 10:05:42 +0200 (CEST)
Message-ID: <ccc28652-1d35-48d2-9171-2e3749b38604@hartkopp.net>
Date: Fri, 7 Aug 2026 10:05:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260805125414.30592-1-socketcan@hartkopp.net>
 <20260806021809.0018-sashal@kernel.org>
 <6596e764-a9d8-4557-99e5-585bd680c3ef@hartkopp.net> <anTHCfIquCTzW52G@laps>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <anTHCfIquCTzW52G@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06.08.26 19:40, Sasha Levin wrote:
> On Thu, Aug 06, 2026 at 02:09:36PM +0200, Oliver Hartkopp wrote:
>>
>>
>> On 06.08.26 13:36, Sasha Levin wrote:
>>> The skb->hash echo tag doesn't work here.  isotp_set_skb_uid() is only
>>> called from the TX paths, never from isotp_send_fc(), so FC loopback
>>> echoes arrive with skb->hash == 0 and alias the so->cfecho == 0 "nothing
>>> pending" sentinel.  Upstream is fine because d4fb6514ff8e stamps the UID
>>> in can_receive(), but that commit isn't on 6.18.
>>>
>>
>> Ouch! Thanks for catching this!!
>>
>> I just focused on isotp.c - my bad.
>>
>> What would be your suggestion to solve this issue?
>>
>> 1. create a 2-patch series which applies d4fb6514ff8e first?
>> 2. turn it back to the original if (so->cfecho != *(u32 *)cf->data) code?
>>
>> The latter was tagged by sashiko-bot to be not safe enough.
> 
> I think that just a 2 patch series would make the most sense. Thanks!
> 

I just posted the v2 patch series for 6.6.y , 6.12.y and 6.18.y

Btw. I double checked that the former integration would have been 
working too, as we have a special case for those echo skbs, that get 
their uid already in isotp.c and not in can_receive() to detect the echo 
of self generated skbs.

Anyway the solution with two patches is much better as it makes the 
isotp.c code more look like the mainline HEAD for ongoing maintenance.

I'll start the work for 5.10.y 5.15.y 6.1.y too - looking forward to the 
FAIL email to get the --in-reply-to Tag ;-)

Many thanks and best regards,
Oliver

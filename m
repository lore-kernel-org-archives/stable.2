Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615882;
	b=q2PqwMUNZLD/HSnLioue2Xrn3+GixzR6VDByJMLTgtBh2MotIRHWW8JLrCcd4hiODv1F
	 9BCBU3CmqlkOmVfQ2VrygoJGGhIF6zh/4ip3dKJhd+bID8jPrJPWFVPfGpylHi4GiLuuF
	 esYlwqSuz1ZO/EEQXIaIZvfb+RjuJWWRg5p1ZLDZq0JeSbJvire1mMJiKzidiNLCpKWYl
	 mn9eTRf8uWvETQ/Iz1BcIVJtYFLU1SVRZO+yVkW1hHN3O8StufqtDdMesi0fwK/n/1Qci
	 G01upeArGiQZ3UIq3Escho/UJZfIlmMuq6iEcUv82TdjApsb4R3WOb1uqUtpKYtbMYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615882;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GOI4XUcInlwlj/yKAuRWPheNsNrEL0lu0d2jyhaTLrw=;
	b=M8g7tvK4zZQY0w78qBgOJlmEimJwaMh6cqwubWe+NxjqpVzJxKpRA8RMvk3np0PbDMtv
	 YfU14FK3wHF5hktquhOocsZmcuH5AU3FAoJ1j+Xbl9p3UIQyv5Q0NcEPI5EB9A0r6c98o
	 Hp7baJtMyZxQZ+yjcEvXn8UZfSctK4mxMeIj2/5vLxEDHalWr4skg3ImbwJt8tku9HTn7
	 7rYcJxkVwInxcPCaznl2v38s5mvPwC6tU8lksFcpyTASZe+3ADtjsgW4wD+OHTU4oBv4l
	 dVQ1SBVSzUFD61D/pl3RVSdeDjaqCQ4RlzCM/LqeYJ5w6c6cpnTA+EFgzvXSucRSTEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GCxszM0i;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lUEVA81y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC31606A68E;
	Wed, 25 Nov 2026 14:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC31606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GCxszM0i;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lUEVA81y
ARC-Seal: i=1; a=rsa-sha256; t=1795615875; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YPqfqNPwHdchRqWNLp9+np4h6olf22ag6CwhHpy/AthGQ5NeHsy5uJ8jqR72G0SGxN
    47/jAyTuvgYPws2x8+QRWpuLivI5ntFjgQxGcA+6ud/sj8JxBN+nyJew66DNJWtlrMGh
    8ZmmQKKPUfJvbzNEJMsMLIroQb8Ft+/oum7k/1BSCX54i1ZSYdHXlPiiIXMLJedjSuIu
    deQfsL/D1R66mz7+V4m5vpPXztp9p0fOnYMPiwjZFseluXNUSWTVnbpwdsiMDmebtQH2
    UBRm0RJvJOSd0e9lAeTY6hi4p1RxXfzfH3z8jptgqrEBoGzlAuQJqyQgWbvlZBCDkRTx
    u6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795615875;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GOI4XUcInlwlj/yKAuRWPheNsNrEL0lu0d2jyhaTLrw=;
    b=k5bImQBDtMRhcxV56Fb4yq0nvg81HoQKQicDW5Z2pmGE5WBoAuPqP16j6VFyXyZzug
    F9iivtd+NuRoMAdo3RToe2ZdOI1NjOP3OtqHn31y5Td6G/0CVo2TaIdBOi5HMjtsTSgA
    QwuFZXEMvZK1i4gmK5ewSQGQDQO0DHYRnUThhZhHM/UPnWsyJZWkD596FXnBpsSx+B80
    IpIvHItU4MW56uA+lGHI471e9I1uCtVsndLcbENOlp6h9hUrWyiwWafijKfO2v3BvwNK
    KQHq7tzIAlNSpqx637h4XKLCNJ64Z65MdtORv1Al2tZl+b39ow6Kst8b1HDl15YiT5if
    iR9g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795615875;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GOI4XUcInlwlj/yKAuRWPheNsNrEL0lu0d2jyhaTLrw=;
    b=GCxszM0iLix2Oe+mwPU5REdaBKH3DRz8gRYa+bSF0iSBK1GLkBomQKRp/x7yGCpqqv
    EwNnq1Sc3jxkthORQDsWIh43dmqF6O5vX3CMhRo0d4bF9i69FnPrnabVfo2VhV5Vg+oH
    nTRiOTOrVPqhofozhrM2H0ugJvvAk7VhaFoKLdy5QteJmz908JP9ROt5U55VUDyXoynX
    QlvwJt+VLcFNb0UlVIMO3QjGLZKysTe1zgwyWSHeMVG2fKTWVWpyF3tG5xFMbB3Sr9+t
    pgXHHbAhhFvC/YElSfnehvEyVEnFRdf2+Q4UVOScfwAskNc5X89qlwlxHJIgPtADxRUl
    T3rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795615875;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GOI4XUcInlwlj/yKAuRWPheNsNrEL0lu0d2jyhaTLrw=;
    b=lUEVA81yFhsxoGeZbImLI7VMKzcSOpi4CRGmgLDp066QMrpBQaz3VerzLOYEEoDjU3
    puheeCGvKEbJBEuyl4Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.3 SBL|AUTH)
    with ESMTPSA id Kfdf2a2APEBDnDG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 15:11:13 +0100 (CET)
Message-ID: <a582ed1d-67c6-461e-b82d-4fa13f31888d@hartkopp.net>
Date: Wed, 25 Nov 2026 15:11:08 +0100
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
Subject: Re: [PATCH net 01/12] can: bcm: copy the CAN frames outside of
 lock_sock()
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org
References: <20261124085757.1093632-1-mkl@pengutronix.de>
 <20261124085757.1093632-2-mkl@pengutronix.de>
 <179551104023.3294.3966794215800671203@kernel.org>
 <20261125-lavender-pig-of-imagination-fe91b5-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261125-lavender-pig-of-imagination-fe91b5-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.11.26 15:01, Marc Kleine-Budde wrote:
> On 24.11.2026 09:04:00, netdev-bot+sinfo@kernel.org wrote:
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
> 
> The issues in the CAN protocols BCM, RAW and ISOTP fixed in patches
> #1...#7 were found by LLM review. They can lead to block the RTNL by an
> unprivileged user, but have not been observed in the wild.

Just a nitpick: We had no user feedback on those now solved RTNL lags.
But to check the implementations of these patches, some locking stress 
tests were created that proved we had a problem here.

Best regards,
Oliver

> 
> Patch #8 fixes problem with configuration of certain classes of older
> CAN-FD hardware, found by LLM, not observed in the wild.
> 
> Patches #9...10 fix problems with the netlink attribute sizing, found by
> LLM, not observed in the wild.
> 
> Patch #11 fixes a information leak of up to 8 bytes of kernel memory to
> out USB URBs, found by LLM.
> 
> Patch #12 fixes a probe failure on of a driver on m68k/coldfire, found
> by human review, not observed in the wild.
> 
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by LLM and not proven at runtime). If it was triggered
>>     please include the symptoms, like the stack trace or kernel messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account.
>>
>> *IMPORTANT*: If you do repost (for other reasons) - please include
>> the relevant info in the cover letter or commit messages.
> 
> regards,
> Marc
> 


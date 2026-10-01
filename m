Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F758415B7A;
	Thu,  1 Oct 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855589; cv=none; b=jEwmcg7uC4MinVsxACW6F/sY0+MxM2DUgyErGsYTyApHJ0m/LN/2Je0gyKh3mPhsuIJjC8lopTsKHbko+bYfE66rdZUukge5NqFS4jwmhB55YmwRpaJ8U3k6RwqtC1W22EppmXZGK6+95+gX4pIL69LtFDjrUJhKVroSKKz3ZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855589; c=relaxed/simple;
	bh=/MeYwWAno8CpfEDhsFWr7jC7TB2rGwtw4uMGiMznHAc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nOUrrR1SIdALXADDyeznlvYuUiKivkJvnNPdQJk7O7IwkhPOtUWQHuQyv9NcV7BN9oGIiDhSLpL8D/fbpuE3dBrFblXte8UeBOqlex3kShc5RrrL8CVPGlfUMGci8FrO0Sl7zZHvtRMQ+0nDu9hEsbeqR0DN3jzdO8UU9kD49ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=iKLRp+Dj; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="iKLRp+Dj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WSOPmc/JO0F9Zz7WYgsjL67SSKvNTuJ4SVKgHj3z2YA=; b=iKLRp+DjfaXjRvICvXRZKElIgf
	kMrwMZF5QJXToClRfcl15Xe2/QlpJh2ckZ0FhryhrE1oz9q40Xx9WF+xxazG4vSlh1/NwXDDSUAd6
	Bos8kGbdPiQcFLifxTqXWotsSqlIjLN7vHx/t4MEihSKsdNFJqQQ7xewFxFmA3ehp6/JlrXvBxIpO
	p9Xar42BU1WyogsythEoLUszfDB1vs5oYWu22nVMrPleM66OqF2/jkGW5Q/L0h6ktpXFY++DqLyTf
	8N3EjsrcUivlaTkM0mqgTtbpyg9D45IJOEBZY5BcY92WdXVhjETOyuraWYWtmzAA01Dre1kXJu2H1
	lPPboFiw==;
Received: from [::1] (port=58640 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCF6s-00000009fBA-3Nfh;
	Thu, 01 Oct 2026 13:37:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2026 13:37:54 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 7/7] xfrm: leave the sequence counter unchanged on
 ESN overflow
In-Reply-To: <ar5C8DDMwWn-30iV@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5C8DDMwWn-30iV@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <69f80ed58e34f787305f85b12eb3ecdb@oss.cyber.gouv.fr>
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

Hello Sabrina,

On 2026-10-01 13:24, Sabrina Dubroca wrote:
> 2026-09-30, 14:45:24 +0000, Jérémy Jean wrote:
>> When the 64-bit ESN counter overflows, 
>> xfrm_replay_overflow_offload_esn()
>> rejects the packet and rolls back the stored counter. It decrements
>> replay_esn->oseq even though only the local oseq has advanced, which
>> can later induce a reuse of the last sequence number and the
>> corresponding AES-GCM nonce. Both IPv4 and IPv6 are affected, yet,
>> processing about 2^64 packets under a single key is required to
>> trigger this bug, which is highly unlikely in regular use cases.
>> 
>> Leave the stored low word unchanged on overflow. The high word still
>> needs to be restored because it was already incremented.
> 
> nit: using "low word" and "high word" instead of the actual variable
> names doesn't help the readability of your commit messages

Right, I could specify that. How do you suggest I do that? Should I send
a v2 for this single 7/7 patch, resend a v2 for the full 7-patch series
(possibly in a couple of days in case there are some other public
comments), or another option? Thanks.

>> Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for 
>> offloading")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  net/xfrm/xfrm_replay.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> I ran into that one as well while I was reviewing your previous
> patches, but didn't get around to posting a patch.

Good, thanks for letting me know.

> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

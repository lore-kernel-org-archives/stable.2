Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70D535FD8;
	Thu,  1 Oct 2026 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888882; cv=none; b=lB9MmefOF0JrkuF7vTn3gu8IAWr64NiexV+jRl6NS70jkZ6VFBZ5RvpqZScSwuoB8inKsO6bGH4vxL6WJqN/Ge+zcd7EAawO6dSTnsewx4GrI4TXaV3pc+e6/p6pcj6Tf6sXdu/+o6gQHYCrxjltmNIIv1BLa2wiPBnDajGAc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888882; c=relaxed/simple;
	bh=o7J+1HITYJXRtiyoUuIb6cauJmcw2IANlDCioGDkRmk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GkBeMzAGVlfZhIkc7Glqb3HJ11tq1OAo0jA1+VAOIQPH45Uw8AHgVXOlmEvKldpsZi78+sKYFc+ALWfpk2YNUKDBe87VJadleM1rdZDU+J9LC2Vu0dWjyFq//lrIb6DENfnu5Nfjibb6gfgucEBt7W/fhhVGD9LWxd4BIAV428Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=crWAkHdC; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="crWAkHdC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5Qdx8zkOLPSDGJyfa+Ayr9i/OP3panEu3HPgytGYE+Q=; b=crWAkHdCd96jdy06ctaKtuSJHU
	kNanaL7kSuqM1iR7CLTKOh3ZDcbI4XuxsK6sPS3/qVtPbx/yuO20njO6sgYqvYVM7pDmXUMnAc0eC
	wCovceWP8OVVQ2X7lxF1ZR2aGkfCOYKkiYfOHVLbSt6LO/KbfJZ/yjphzOOjkd65T+w/e9aJ4Dmn2
	tIPX2A+bDXeUsW1h3i4EnAnwAGCV8qomUTnl1zft838m98r9zpUzsGg8vW56hcQLv4/QqXljrM6Em
	sRxzIPQHK3PKhm44QoiqGyh3q/3E8T4NYKTc16miplsjKH02iMmc3nghgud4nK2dv/z+ucx4VVnc3
	DI3K9oSg==;
Received: from [::1] (port=59626 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCO0U-00000001oDZ-2JXv;
	Thu, 01 Oct 2026 23:07:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2026 23:07:55 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early
 GSO
In-Reply-To: <ar5gnDR81WsA0TBg@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5gnDR81WsA0TBg@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <c24271382cde79f3b043908ae52c41cf@oss.cyber.gouv.fr>
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

On 2026-10-01 15:31, Sabrina Dubroca wrote:
> 2026-09-30, 14:45:21 +0000, Jérémy Jean wrote:
>> In the software ESP offload path, xfrm_output_gso() leaves its 
>> segments
>> sharing a secpath extension. Each segment gets its own ESP sequence
>> number, but stores it in the same xo->seq field for IV generation.
>> 
>> If encryption is delayed, later segments overwrite the value needed by
>> earlier ones: esp*_xmit() can then encrypt several packets with the 
>> same
>> AES-GCM nonce, despite their distinct ESP sequence numbers.
> 
> Here again, your commit message could describe much more precisely
> what actually happens.
> 
> I'm guessing you mean something that starts like
> 
> xfrm_output_gso
>   segs = skb0,skb1... all with the same xo
>   ...
>   xfrm_output_one(skb0)
>     xfrm_replay_overflow(skb0) xo->seq = N
>   xfrm_output_one(skb1)
>     xfrm_replay_overflow(skb1) xo->seq = N+1
>   ...
> 
> [and then some more stuff happens that gives them the right
> esph->seq_no but wrong 64b seqno used for the IV]
> 
> But please help reviewers trace the codepath you've already gone down,
> without having to guess what you mean. You don't need to give the full
> call graph with the state of each variable, but there needs to be more
> than just the very beginning and the very end.

Here is a more verbose changelog I wrote for that patch:

---
With software ESP offload, xfrm_output() attaches a secpath before
calling xfrm_output_gso() for an encapsulated GSO packet, but
skb_gso_segment() leaves the splitted skbs sharing the same secpath,
including xo->seq.

For the i-th splitted segment, xfrm_output_gso() reaches
xfrm_replay_overflow() through xfrm_output_one(), which allocates
sequence number N+i to that segment, and then incorrectly overwrites
the shared xo->seq with N+i. If encryption is delayed until all t
segments have been processed, xo->seq ends up with value N+t-1 for all
segments. When validate_xmit_xfrm() calls esp*_xmit() for each
segment, the IV is constructed from the same value N+t-1, causing
nonce reuse in AES-GCM. Yet, each ESP header correctly keeps using
value N+i from its private XFRM_SKB_CB.

Call secpath_set() for each offloaded segment before xfrm_output2(),
so sequence allocation writes to private metadata that cannot be
overwritten by later segments.
---

Regards,
Jérémy

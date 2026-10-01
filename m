Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FA3BAD84;
	Thu,  1 Oct 2026 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883246; cv=none; b=tHEg/1JBCJrEzxmeoH9lunTCMpkJ6Lc6a2KgJXYCh15rvFHzIYAgLGti3ioXRSSHnDzauCDTqoe1QmX3+ZdJAJcYPAAKUhj0+OOgythdazVwe3vnPvny5PxlRQqbXYUwEfCgGMPTh+rm/PBGUZ4vIzlRR/ih4QmFYH9eIlCTXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883246; c=relaxed/simple;
	bh=c81TYKhJAs9PBH7ZLrk/8t41TX7w3LQEEH+/TApgJpg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r1Dnch2lcignOD29YX7AJWeuykHtwGxUWrc0e0n8CzsvALooq7m0UsQsdO7K1Aoj/JaYseJwkKZB5ueZDAQne2qudpc2maXih0/6mjTAz62f+MZ19u9zrSxYRB3r5vXLaljO6NS7bTQYvfiz3DeIjPj9JITPKZPs7PsYgJqMjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=orOkmQC0; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="orOkmQC0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8vWqiUcdt+XZtt7UPLn/tp6YO+2y60eUymFUZjfeYcM=; b=orOkmQC0vxnbJd6wc4hEsS9dqx
	zkUbY0M4cXCPH33wjfJaZsleGRfTuJ7AsMuRy7L1XLpx2+yAEx4Pt9z+l9dHldElnjwYBu+WutzU6
	ISZNIfps53N7PiPpP0jgSTWV0ntQxS1VFQIHBAxdBaZ9HSCDlqyiX2Ax12QaEcavoFuKN8wIro54k
	LiHObo4UM3ftbZt4SicyKjbdFNcWKPKH0b6VPWQz/Gmaf40ZY49jbLBbp5tA/Ykc/V/ICtXZxKjmP
	7MLzvwBrN2teCS8A4J6h++NRsUWRocnI9TWGug60g+O1XHcs38QWXXndT1iL28AESepss/8oRkR08
	EnYlMfig==;
Received: from [::1] (port=48406 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCMXc-00000000Nej-2eer;
	Thu, 01 Oct 2026 21:34:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2026 21:33:59 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
In-Reply-To: <ar5HLrGSiwbmr-pR@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5HLrGSiwbmr-pR@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <e0ac362442c0da923036075102dbe8f2@oss.cyber.gouv.fr>
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

On 2026-10-01 13:42, Sabrina Dubroca wrote:
> 2026-09-30, 14:45:22 +0000, Jérémy Jean wrote:
>> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
>> on the SA's current output counter. The metadata already contains the
> 
> And doing a check based on x->replay_esn->oseq, which may not match
> the value for this packet, seems really weird.
> 
> 
>> -	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
>> -		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - 
>> skb_shinfo(skb)->gso_segs))) {
>> -		seq_hi = xo->seq.hi - 1;
>> -	} else {
>> -		seq_hi = xo->seq.hi;
>> -	}
> 
> I guess this is trying to solve the same thing as 4b549ccce941 ("xfrm:
> replay: Fix ESN wrap around for GSO")?

Yes, it seems so.

FWIW, another related commit to this fix is c05c5e5aa163 ("xfrm: replay:
Fix the update of replay_esn->oseq_hi for GSO").

>>  	/* Place the SN in the IV field */
>> -	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
>> +	seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
> 
> This is starting to feel like we should have a helper to compose the
> 64b PN, and maybe give a name to the (low,hi) pair struct to pass it
> to that helper.

I don't have a strong opinion about this, but I'd say introducung a 
helper
to replace a oneliner is maybe not required?

Jérémy

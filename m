Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F147CC9C;
	Mon,  5 Oct 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208254; cv=none; b=IBpKrGjm8mqUbCH0cxUuxBtAOdaA53BqUb12iYRunXW6FxoKNiezEqGT3mHRewATvi8NgtEM+wqlZjGxZum7/QPNgFkbWQvEIZvgdpwky3ucahpnsCULZWzSwr/AsjX2g/O9pGLUrUri86vCwBw4LXS2pbmM+VoYYqSGB8turUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208254; c=relaxed/simple;
	bh=P2HrkQZ2sl1tN4cca8woQtTrPRAMHEdBkUvlO4o0SE0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hh5CwnpTJzro8hOpjxxtvsg1jZ7NvDbZHO6obiXtIFUiSweh9s0MadLt3IkylCao3m0AWCDipuCI1xBsNP3z/62Etnuy6NJHyLxKH/Tkqa0wE1HWfAWpEPzro6vMXmrZuCoUL4e0DaXGHUHPabKiOMAITMeKteG0FTdxEgOSrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=K/ijqDvm; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="K/ijqDvm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pBlMe3HxPYd41DWoFSdBeNc+DeqejnU+YvHQEHppLAY=; b=K/ijqDvm+zcUu+LiOzTjafpZNm
	7H040+gA2EvnRPri5K6xpu6a52f1BIMH2mYN0MVzoOFQj1BrIeIgZaIq5MVvSVNmahyDcICuMKSXX
	rNs0ey7azOqk7QoX8ezBsn6TgcDhiFFZiReHwpjwsT95Li7/1oHGatsI2WLk3xzQ/pRSvQ8Df7o/Q
	bNOgBGbnKGPwPXTIFSp6oESOXh675OM/KxO82ICgY986NBVIx8G4WD9sGShGQt4OQnSt0CAGx34ji
	OWXJmD0qWGHe6niuddGjew+HDhbmMC32fRqRBz6gfvlLOq4k3dLlzq+PNeuzUnddDPbs7K8tQj93W
	nQNKB8yQ==;
Received: from [::1] (port=45052 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xDj5d-00000008MA0-31Xi;
	Mon, 05 Oct 2026 15:50:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 15:50:47 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
In-Reply-To: <f50caced-1810-4f33-99bf-cc69a0851c08@nvidia.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
 <f50caced-1810-4f33-99bf-cc69a0851c08@nvidia.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <af8f1e51975cb74188f645a8fd20a6cd@oss.cyber.gouv.fr>
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

Hello Tariq,

On 2026-10-05 15:06, Tariq Toukan wrote:
> On 30/09/2026 17:45, Jérémy Jean wrote:
>> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
>> on the SA's current output counter. The metadata already contains the
>> high word for the first packet, so this can produce the wrong IV.
>> 
>> For a three-segment GSO skb starting at (H, 0), oseq is 2 and
>> oseq - gso_segs wraps to 0xffffffff. The helper then uses (H-1, 0)
>> for the IV instead of (H, 0). This can create a situation where GCM
>> reuses a nonce.
>> 
>> Remove the high-word adjustment and use xo->seq directly to generate
>> the IV.
>> 
>> Fixes: cb01008390bb ("net/mlx5: IPSec, Add support for ESN")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c         | 12 
>> +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>> 
>> diff --git 
>> a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>> index 6056106edcc6..4aa9f9c52f57 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>> @@ -153,21 +153,11 @@ static void mlx5e_ipsec_set_swp(struct sk_buff 
>> *skb,
>>   void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state 
>> *x,
>>   			    struct xfrm_offload *xo)
>>   {
>> -	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
>> -	__u32 oseq = replay_esn->oseq;
>>   	int iv_offset;
>>   	__be64 seqno;
>> -	u32 seq_hi;
>> -
>> -	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
>> -		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - 
>> skb_shinfo(skb)->gso_segs))) {
>> -		seq_hi = xo->seq.hi - 1;
>> -	} else {
>> -		seq_hi = xo->seq.hi;
>> -	}
>>     	/* Place the SN in the IV field */
>> -	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
>> +	seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
>>   	iv_offset = skb_transport_offset(skb) + sizeof(struct ip_esp_hdr);
>>   	skb_store_bits(skb, iv_offset, &seqno, 8);
>>   }
> 
> Thanks for your patch.
> 
> Doesn't this make mlx5e_ipsec_set_iv_esn() identical to 
> mlx5e_ipsec_set_iv()?
> 
> I wouldn't keep both copies then..

Good point: after a quick check, indeed you are probably right.
I will look to simplify this in a new version of the patch series.

Jérémy

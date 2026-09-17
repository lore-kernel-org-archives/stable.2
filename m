Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98C4E0200
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666649; cv=none; b=XaYwNgCbnj75fStOElJAH6W0BRqPnr9sLcZVLuyil4O0vNvKrQtQgQMmAzXJ15l8t/zZV9yAhXFlh4oi8awLge9Qi+sYlosR1oP1slrcmqoslH5mjzvCYw0hMTVnA0avXhJAZ9TGrWwv0tWZG9TLusP7W5GQdIpI2C8gQPURWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666649; c=relaxed/simple;
	bh=CFR6F3l6/mnlppDqwqUSLKoZh+cM5zXJZV5KJ+UriLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyHzn4avJG1qDPdMj8pEof0Y8SHOBcfoETGqbRIGNH0Dd8FEtt+fgcaRcFmWkHlopa74WmVcM1lfWz1Jqpx74WFIHRCTeDqwl4NDjx2Ipoj77Oj7QI2gD5P7CX240ShDSf690RUks9mQGUc+5c7COJ4G+r1tuSgUWQPZGtoGZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQvbYjww; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=giuPnKC/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQvbYjww";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="giuPnKC/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5SHP1600982
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RiLUTK8pLQQMWX+C1g6PNvcB
	iveJnZkCvbZEp3/30IM=; b=HQvbYjwwjk5GaVNODVw65EvnkLxnC3BJy5uItFuJ
	bCHneyKtmUfJQyIILksEEKd38z9MGhNeFMOG23lPRXd2v/AFwGdwBGzFHMQXfB22
	/Iz7boVtV6fDdBZMdnVFqxf3Y+aKr3T+6YdgugsxppcV30yNfqmEIa6BoSKW6+9B
	48rTUSGlHs0U8kKqgLHnQNhCsb7QtRt5gGuuwCCKGjPrZAiSXslrAFWHyg2znvBI
	Y7W3DVny5KEq+GW7BXcbZEGBcQxqpSD5HZ6Gw4/Dm+j04Zp8pmdX8gWTOa9z099/
	MZETRN0NOSASY2QfZkCVHRJHcLa6hGvu5m3SYI43TP6/fw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw3h66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:37:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0312937eso139747785a.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789666645; x=1790271445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiLUTK8pLQQMWX+C1g6PNvcBiveJnZkCvbZEp3/30IM=;
        b=giuPnKC/2kz6KOM/H0VYGrGeF9z/yKD1RRF/J0IqqvUlZEZiypBR9EcOC/xY+VVhnu
         vhpcTmgilxcb15Z1wW8o9R8xPCAgVcmwM0Jcg8HspwWefvbnSZJn/rH5FQmAzCk/p2OO
         SvZW5zTG6ttc+lGBbWy69OsM5gN0d5Au+rD7EU3B26XMBl7x6n/zixwALyiDoTizK5T0
         pGYRTMmXd2EPPmRr/ElfANPG76HAcey5ho15RuQap/k6XA+yxUMX7hFoJCaKgsrteAMv
         LGefVmstsqXgDUg7nFEYndJdyXuB4Yua3IhpagK41dE48UWfNUfm/PCYy7ALWRTGP8Ik
         GtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666645; x=1790271445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiLUTK8pLQQMWX+C1g6PNvcBiveJnZkCvbZEp3/30IM=;
        b=u4Pudeh9vPLgcApF62wfo/BWILoewikrtqPXc0vx6xZvo5v9YHDzuS6RcLJdvybjgK
         Se9liy8BjzIzcjxh4f5ab9FI40DsVbmSlHh4dM+qnqGs/ivdcGeDiemF8lgQCnkmNFPS
         wySEdbOL+s/Y0Z4lX2mrpbN0BvSsa+rR/pDsHPzFEf5SQSK+ZoyJZFKpnenjsGgPS9+o
         b2ZRncyeQInhsLYqPxZ3Vzwn4Zv1UG8sX++QSQ48iwuHywaHf89LUz9SJl81fs/SpDKm
         HTYFdEqUDEDMyeIeuzMTZ+Yxb9ekQfpXKzUm3b8sxBRUO6IsQ/zQWpZR+x3VQhwgw8ww
         C4fQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXmGdVmy8tpiaI77lEJTweVVwyBvHkPVbSX7eLE6Nm+I5u9pYEBwtsEqyX8B368U+5FRBeZgw=@vger.kernel.org
X-Gm-Message-State: AFuF++kBIFcnoBlQHl51NPkcukbl9/O1pqn9CEPOEGvi9Ox9qTF0K9j6
	G0Y4IYXv28MmOmAU79YuON3VPdF3VN3UfAJulSzAQLMdV1lZXX9VFJwRLRFP8aYXxibUurBwUYH
	ejsMo3J/2GDX0gAAGCK4s701CJOZdTA3ITUjdYs9jhuLE0XPRNWpgYEfxh04=
X-Gm-Gg: AYBFou3jqHO9oQVAkZNbadlNUrPGJKcgxY5+a2lsm5PLtiZSdohDOopAi32wOSScvMJ
	hYLSn6qjz4qtHCoSKz+km9TwLJ+jDnWf2Te23rLrRALVSF6fuTaMPWS0Q9hHphgrv8GuesAXKxn
	YqVAmiymhvAqMAkVsYSHyAkfhLMSTqpfbB0st6H3CdUxEeepb0tbxm3clZJQfmDzYhnoXZuHiPx
	oqxObbeFezYRQW48hKFN3FIUUM/MxAnQj2pCAUTyTCJsgcmd04GjzBXiZSEdtlAiKGMlJorJ8cu
	jdJeTRnGpGFCc/nUildqa90wRtwkgJx3Lo0LCRPqFainzSga5ARqGW48KaREGeRLRZYeoGq0TC2
	/b1z/mHgIxTIEzcppwY7DnLwLYe/zEeCggrik
X-Received: by 2002:a05:620a:6488:b0:937:7e90:ecc with SMTP id af79cd13be357-93bb791a336mr1166927685a.25.1789666645055;
        Thu, 17 Sep 2026 10:37:25 -0700 (PDT)
X-Received: by 2002:a05:620a:6488:b0:937:7e90:ecc with SMTP id af79cd13be357-93bb791a336mr1166920285a.25.1789666644423;
        Thu, 17 Sep 2026 10:37:24 -0700 (PDT)
Received: from localhost (77-32-99-124.dyn.eolo.it. [77.32.99.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27df9sm17600420f8f.19.2026.09.17.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:37:23 -0700 (PDT)
Date: Thu, 17 Sep 2026 19:37:21 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: do not cache the new TSO MSS before it
 reaches the DMA
Message-ID: <aqwlUWN3rAXfcaWr@lore-qca>
References: <20260917124234.1348673-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zK4cZSasZmlQ8lcH"
Content-Disposition: inline
In-Reply-To: <20260917124234.1348673-1-xiaolinkui@126.com>
X-Proofpoint-ORIG-GUID: d8WtAV0jZT9gSvkbcW2lXkFVOvQcHQXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MSBTYWx0ZWRfXycSlVeyRy84H
 1kqsdzU8Nfh/LEOYuEEZFGRFk/KLIEZ+aVXuIx79j/Q9Ag0SzdAMIIhTHhSNbAOb1jvVdUG4chY
 NnGvqI5S4WTqDYehMO7x3Ymdu1qbqUX82y3SjxMJcf2dpb3vlqJ+399upJMS+2BSVng6PIpHnVD
 uqICUqSCoTzQ6mrkmPpfNV+Blk0/w4YarNc3HlVBrWrV4W5DTxASxDFZAPksfZo6t1CLkIGkIUN
 +Zd0E7I5oWhoegIl32izsWfO6IhXR5G/4TE0MXpxXKNetQicEjHjPfqBBd9gHQLv2FeRA4AhDZH
 INRHLjqpzluAZVj5RjKcwCGXPGZuKheCt8Jfo8vs6nKcOlUF3TzFTG+JZA0VYtZ4haa1t8dJhj6
 V15htczCsRPmwVHCYaqCCfGssf/hV7BzZba4qTDIHbl+S2G89NFgpuUEKFE4YaudqpU/3/Xj2NR
 dV0w4z9Sqfno6BpZD/A==
X-Proofpoint-GUID: d8WtAV0jZT9gSvkbcW2lXkFVOvQcHQXO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MSBTYWx0ZWRfX2ZPJUP9t2vGF
 FO2exXTaXJ9dMomUzqTUVCQynocoh6LGZAQjYJiGvHhGnloekBRmgn7f8xVFm7rhPAD/piAEqiC
 PX3SzpRJIC6rlxUe7ENUhwhiHLy6R8M=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aac2556 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oN7owVyBLNHHe3W6XE6vpg==:17
 a=K11jTO6jPfkTDgbD:21 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=TAmxZOqScj0W_Gg8AvoA:9 a=CjuIK1q_8ugA:10
 a=wOP-5i2p18UGaVo_UgQA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170251

--zK4cZSasZmlQ8lcH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> stmmac_tso_xmit() fills the MSS context descriptor and stores the new
> MSS in tx_q->mss right away, but the descriptor only gets its OWN bit
> much later, right before the frame is handed to the DMA. Every error
> path in between - the dma_map_single() of the linear part and the
> skb_frag_dma_map() of each fragment - returns with tx_q->mss already
> updated while the MAC is still programmed with the previous MSS; the
> abandoned context descriptor is later reclaimed by stmmac_tx_clean().
>=20
> The next skb carrying the same MSS then compares equal to the cached
> value, so no context descriptor is emitted and the hardware segments
> the TCP stream with a stale MSS, generating frames whose payload size
> does not match what the stack accounted for.
>=20
> Only update tx_q->mss once the context descriptor has been given to the
> DMA so that the cached value always describes what the hardware is
> actually programmed with.
>=20
> Fixes: f748be531d70 ("stmmac: support new GMAC4")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index af2d38a2bb3d..a8f94cd6abb4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4563,7 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  			mss_desc =3D &tx_q->dma_tx[tx_q->cur_tx];
> =20
>  		stmmac_set_mss(priv, mss_desc, mss);
> -		tx_q->mss =3D mss;
>  		tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(tx_q->cur_tx,
>  						priv->dma_conf.dma_tx_size);
>  		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
> @@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  		 */
>  		dma_wmb();
>  		stmmac_set_tx_owner(priv, mss_desc);
> +		tx_q->mss =3D mss;

I think the issue is real. A couple of comments:
- do you think we should run stmmac_release_tx_desc() on mss descritpr in o=
rder
  to clean it up?
- I guess we should use the same approach used for data descriptor and adva=
nce
  tx_q->cur_tx when there are no other possible error condition. What do you
  think?

Regards,
Lorenzo

>  	}
> =20
>  	if (netif_msg_pktdata(priv)) {
> --=20
> 2.25.1
>=20
>=20

--zK4cZSasZmlQ8lcH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqwlUQAKCRA6cBh0uS2t
rG/tAQCSC+2RVhkLKndRbYfTihT9iTa12YhuEwvfzDeB1cr3DwD/TRnCLF4KT631
skR5J9p37gUdnEYuDX9/wAnd5jh0hwM=
=X0mQ
-----END PGP SIGNATURE-----

--zK4cZSasZmlQ8lcH--

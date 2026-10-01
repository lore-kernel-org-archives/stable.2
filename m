Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F351AFEF;
	Thu,  1 Oct 2026 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867319; cv=none; b=XC2tRylw7HNU8DP58WQSL/QU1slowbnVF5e6fHHSz40MVyDt5s/0h1svqXTZ8R+/P+kUpNr1TV5qWzmR1n11KhAq3gafvldH7fppM15vFtOikmoVOLWTH4IHQE87fp7dpcOWtFKyBJg/N86NP1Nk64MyNTAPFckThKHZrIL3SRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867319; c=relaxed/simple;
	bh=dx0VsHqSKwvfkdOsDBBxJGk73ABKwkUKE6axkb3Tg6M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sAKZPphUok08vmUgDrxqYdHCIrff0WQTCsEss7JHbagqvbQqkHSDIq2LWVIlcN6jc8oNnrjnjFnIC7915ZrWvXBq4aX7FDsjDbfaPZPaFUxG3oShhhXbIJrBBvhGipFq/93y/IRacgNPP9H72NOhGvbZHja/aEtYH0NYQbMYqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=XNa8Rj9y; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="XNa8Rj9y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FIXFlLBoXy9rmffDFo5ENEhrptsOAJ3yCww57BZ/IpQ=; b=XNa8Rj9yPqpd8AcTiiCcXWoFQH
	b+fNypptwau0herwmJVIkN1uv3WJMe3MT5EBNAFglYm8n4O8flaFfsLA/rS0yd3/D07AaVQ1MAvl4
	F/VQUgod0gzf/Bz+6md39YG8umG0lWS0dipNnLEn71dmAXhNZZrWocGGCV/tWGZcOr7fSY6bCyNcg
	tgIPOSwXko7Z7M5aD6bwiJIZCkQ7dLAUpPFNzhTYsNBWMfvd2FsoPMKLTJk3qK3eDR3HBMdbEinIU
	as2ffr4gAc1TnPnuhcVRwJue8OCeL5uDgd3lNBhg9bCwRRL/GsDFLJeiI2lBqTnnqShpdg7CXoxAR
	w5yTjcdw==;
Received: from [::1] (port=38004 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCIOe-0000000DVTt-3NgJ;
	Thu, 01 Oct 2026 17:08:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2026 17:08:29 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
In-Reply-To: <ar4rKxYd7Csm6l2t@krikkit>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar4rKxYd7Csm6l2t@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <864ee7d8f719deea74ff3e5aba1bc949@oss.cyber.gouv.fr>
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

On 2026-10-01 11:43, Sabrina Dubroca wrote:
> 2026-09-30, 20:33:33 +0000, Jérémy Jean wrote:
>> When MACsec uses 32-bit packet numbers, 0xffffffff is the last valid
>> packet number
> 
> This makes it sound like it's only a problem for 32b packet numbers,
> but I think it affects both? Sure it's unlikely with 64b unless we
> start from a large offset, but a well-behaved userspace should also
> rekey and switch SAs before we ever wrap to avoid losing packets while
> the rekey completes (but yes, "losing packets" is not as bad as
> "breaking crypto").
> 
>> and after allocating it, MACsec deactivates the
>> transmit SA and wraps the next packet number to zero. Packets already
>> in flight can still be processed after that.
> 
> So this is more of a race condition than a full "forever" bug. I think
> commit messages should be clear about that (and that doesn't mean it's
> not bad or not worth patching, but it's worth mentioning).
> 
> Once TX operations hit macsec_encrypt -> macsec_txsa_get and see
> !sa->active, packets will be dropped and nonce reuse stops.
> 
> 
>> The first late packet gets packet number zero and is dropped, but
>> tx_sa_update_pn() has already advanced the stored counter to one 
>> before
>> macsec_encrypt() drops it. A second late packet can then be sent with
>> packet number one again, reusing the AES-GCM nonce from the start of 
>> the
>> SA.
>> 
>> Keep next_pn at zero after wrap so all late packets are dropped.
> 
> "late packet" is defined on the RX side, but it doesn't make sense on
> the TX path.
> 
> The diff looks good to me.

Below is suggestion of a hopefully better description.

---

After allocating the last valid packet number, MACsec wraps next_pn to
zero and deactivates the transmit SA. This happens for both 32- and
64-bit types of packet numbers (at values 0xffffffff and
0xffffffffffffffff, respectively).

TX packets that were still getting processed during deactivation keep
being processed and then receive packet numbers. The first gets 0 and
is correctly dropped, but next_pn is incremented to 1, which makes the
next packet take number 1. It then does not get dropped and may induce
a reuse of the AES-GCM nonce corresponding to value 1.

This race only affects TX packets that have already passed the SA
activity check: new packets after deactivation are correctly dropped.
Keep next_pn at 0 after wrap and return early so that the packets that
finishes getting processed are dropped.

---

I can send a v2 if needed.

Jérémy

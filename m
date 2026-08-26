Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79C44AB9B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759474; cv=pass; b=B9lelb1SwYd6znF9uWU+DAsMxPkNej6TO0RTn70sOBrFRvUWfpd9KOTVmUqpMNKHh9nzPAgp8GIH43MNBEudsPCmnwxiz9PQyIaxpcZc6hjtWUHrIVtyZnfSAkFRs0U/bsPt7tbguqmaMlS0z8kCMzRgqfxXgQ4jjO6ksOaOeaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759474; c=relaxed/simple;
	bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHfx0JfOAqSya26ds/xhGpwQ2PxdwVHj1PdJU8jcLuhLfgPTZJzA8ZK8bTu4wK7m7Lo1Om2UYoIi1tpdK4aDmWeJh1ZtLOEYJzdosBKTjaSQvzZPAEt6cn6nhx8inUtamDkiWFdmeN1YFFjWBh80rvP5wZeSGgQodfESjbCOfkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qswtbPl1; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qswtbPl1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0ecfaee7so8151541cf.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759460; cv=none;
        d=google.com; s=arc-20260327;
        b=NqYL0OHpNQjagwTyTbtWJopefvi8On4W8lc4SAo4fO40db3SmRTcngxBpF75gUmyMn
         9Jtbwwb0CXTr2qTkhX69duUNXkD1tjYAaNCV23Tkrkbj72XzRsEdbY5O/Y5gNsJN1krf
         KQfXEfGDNlHILxsso6835WgEqDDofrGkqdMLM6kgleS3uVVEBKHj7YwU5Q/M+hh2M95u
         U8o+Ztq1lusZc8Ubbxhp2lvx2v2LFUJOjVmcBrLml1qWdjrXqY7tdY+rqiz/W1+ZHccN
         BzFy2C/TmAqUbEi75Fjfo9a22c6sHzgK/CdZ05PFRUlyOFdrOGZiObnqViR9NZXqFdrT
         IX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        fh=QDTRgpvP+8YvugsB2tqe8B8p6CCQR5qjb173D7RrVQU=;
        b=grtEIzsnWaFzud90s3oQ+Qw/HBnN6fJ4Pu/2QhiwVqaZRvN4tE/zc2HwtcB4WoF2mk
         +mo0PBjyjfQMJACz2Vu1gbggpaT/+rnCm9Sv9EkZVSVK+GLCNFL5lKI3j2dG+enhxFAR
         e70tt+GsdITjpeLYMCoixRKvF1atyq0WNvm6in6xoOuzq4LRPH5cuYjDptmKAi3vUqVB
         OG/jcboUgr64BQqg543JplBFXsieWereCy0KjH+hjmt9WV1On5CS5wrisX2Hp1ZwMVEH
         ZduDtosiw7zJU02jww+PUCfCig1K6pZCik/1luEnWSuuu85Cb+ClwKKAzcQEg/18dus4
         Emlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759460; x=1788364260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        b=qswtbPl1fgclFZNoy/X9lj7r0Cbue6TVtMWwHEqk1ocUJb0LkU4a4D4XlHWGwD+47o
         3pc7MCNUbN+NWQMWf/Gkfwa6bEZCXKaQQPXgA8r4lntTDdo1EzBGqalvXOPivCgdaGhb
         rEqYCaTDHco2WEMT+k03HeIrJeYSjsSgPLlpxlERjY7DdHLrqvpsrhhuHw51fOJuzZJF
         Rnk51ItKTWPU1xIA8Ty3uJB/BYkNM+nWHFbWaDOfsheCtcK2lVpxzEG6eP40o2fYqIws
         TZ3WCve+lo9G1i/Fm3l+puW84/gUsWMsOfpUB3Mh/dnqiNKBE5EcbUQ/bhzN2m7LOvC2
         B7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759460; x=1788364260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbAhmQcrtJPJTwHPCbEtPc8UDLx4vHfC+fBE/2k3MPg=;
        b=ktsoB0/cdypYwOn/VqZSpU1hQ3L0I2mbsWRWDOOuulyKNxXG2Y0IljPUcKClgxqADC
         wQvO+0RS3zL0tFf7Pt7T+N9fkwrgpZNCIiyT0srAhoepDul46rNVIuChhOoHhK7QzI0n
         jSw1fU6ZNtVdBuaWAwlX1YMxyOnsm25XaC2y7GzZxKXdFqBE5B/kIArSoK35Ey50CFnt
         S3ephxYmpHKspFjXRtQRLnMRwlcsfdshghbHdtlIgAQJWwU4R7PcI9uHEhXFHXJImU2s
         86V3NjgRV76LtsLxhJJkkU0Oigs1CvQD+R+CWJ7kyF3ELcOUE1GiFRKcc/tPSs9hKMsR
         /9oA==
X-Forwarded-Encrypted: i=1; AHgh+RoIhk9qJ8rF+90bMLWedN2z5WMy9sS+VZ9Df3B1AEi03f6s+rYk+xu9yzx0+bDNAkSjGvGE6Bw=@vger.kernel.org
X-Gm-Message-State: AFuF++kN9bXRU+pkOxmm/cDSky0uLxtne45h/FMUKufohktthyKPYhFB
	JX9PQpdQa1c65Zf8zL6OOuREimRdwaC1a+RiREq1ngbptQ58x6ZhtI8/85PPiDLqDncwaDhaXvv
	HyypAyVqe1eMgZVkjJiUCiVaFF5Q5OA3ffhhnEUJm
X-Gm-Gg: AR+sD12aG4JUwubh9Pgszm1p6aHBYKcbouewu1FDeyUBxJ4RhFBm6BNX7WUjQjGfXkp
	kx/mDPbe+HpDyo7iq2N1MPvHPHaJwAFfvQHbabSmT/R1eWagjkKMbHgK2FX6U9fa63XuTXlfz5b
	A1ELVZ/exfrl88jV25X1+iUwyaM6qVPApGyPj///ZITOJyweYh7b0ykxEIcCVLjcl5tzun1IBjX
	dG5PpvdiXMBIZh5NZWQ3oNtebPNNccnzcFyzblw3bNSn/6mLugr/hlknBCILqhr0nw537AzQf6r
	h6sNjpJwyh8jTTfv8dBWRHdFL9OvkifixNp1n3ZplsFXQgC3//vQRXEGJiiOxXyHf4ZKShAm4i/
	nH8qOkBG1DOjrApfEXKr8DiOlnkQxHSHJREvquJCITp2JMTYczqiv03KljJc=
X-Received: by 2002:a05:622a:4289:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52e422b9d6emr89018121cf.16.1787759459102; Wed, 26 Aug 2026
 08:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826143735.1819315-1-idosch@nvidia.com> <20260826143735.1819315-3-idosch@nvidia.com>
In-Reply-To: <20260826143735.1819315-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:50:47 +0200
X-Gm-Features: AcwNN1XKVmsq9qlIneXAq_oVYgYQ9kV0wMAFA4-E2BElxjRMp04X_87507aK5qk
Message-ID: <CANn89iLumDBStvkh3f3V3ApBNw2PKKgpAioeYMi8xrcxsMme3g@mail.gmail.com>
Subject: Re: [PATCH net 2/4] ipv4: udp: Create exceptions when socket matching failed
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com, 
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Currently, when ICMP Fragmentation Needed and Redirect Message packets
> are locally delivered and quote a UDP packet, a FIB nexthop exception
> (FNHE) is created only if the kernel can match the UDP packet to an
> existing socket.
>
> This behavior allows off-path attackers to conduct a side-channel attack
> on the FNHE cache in order to discover the ephemeral port used by a
> connected UDP socket.
>
> Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
> less predictible") tried to mitigate such attacks by making it harder
> for attackers to discover hash collisions in the FNHE cache and by
> randomizing the number of exceptions a hash bucket can hold,
> respectively. Unfortunately, both of the mitigations can be bypassed.
>
> Instead, mitigate such attacks by always creating a FNHE, even if socket
> matching failed. Do that by calling ipv4_update_pmtu() and
> ipv4_redirect(), the helpers used when the quoted packet did not
> originate from a socket. The resulting FNHE is indistinguishable from
> the one created when socket matching succeeded, both in terms of cache
> occupancy and in terms of its contents.
>
> Pass an oif of 0, in a similar fashion to icmp_err().
>
> Note that this does not allow attackers to create FNHEs that they could
> not create before, as both helpers can already be reached with little to
> no validation. For example, by sending an ICMP error that quotes an ICMP
> Echo Reply or one that quotes a UDP source port that matches a wildcard
> socket.
>
> Also create a FNHE when a socket does not wish to accept PMTU updates
> (e.g., by setting 'IP_PMTUDISC_OMIT'). Otherwise, the fact that a FNHE
> was not created can indicate to an off-path attacker that a socket
> exists. This applies to all ipv4_sk_update_pmtu() callers, so ping and
> raw sockets that decline PMTU updates will now create a FNHE as well.
> Such sockets are not affected by it, as ip_skb_dst_mtu() uses the MTU of
> the device for them.
>
> Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

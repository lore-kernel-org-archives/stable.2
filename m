Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73550AC39
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541778; cv=none; b=XC7xlrcJm8ysvx/YxeL4845IvPd+PEPG7ZQBXNDsZ/zx/d0acbh54qVh9iIrLoZEvVX/4AtUsXxseIWgZ1dOS+nzl1HEvNJjJ88W2yK1VH+XfS2rQmorxjn+d/P75IUkh8Vl/e8w9F4NbzFKha9zMCkYA9HlJ3mffiZDvkeyxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541778; c=relaxed/simple;
	bh=VpUBv6NqPuaxAaa2PFMzt142Sfp50UkMNvLa8BRM+cE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE0f2qUUZScIjLbrnkCPa+uPpTz7XTMnARR9/XCiXJ+EuPWD2IzSaoQaieciqLh0AsoE4kvXRTxXi+Vb3J1vbtixhcSKEfCoyS3G8OAgsiXsyrwAcVGHbbv5dUrQnHZk09DfeYp/jpK9ZA7/dL7DEnXV+K49668wl4Y6/Bt1NjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRlBWt6L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nBU8lYkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRlBWt6L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nBU8lYkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788541776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
	b=FRlBWt6LLeIKfDygTBtxWtMOqII3IFxpGDhtt5Ka7YsrIdhmyJcfVAEjpvmblnJ3hVqi6T
	SP2GhKDQ/M2ToQ57cHGJ667VwOSToBgEkSBVMqhRMbR00MguYV4rBmy8ylIjO1bWr2HHv0
	uKvMO19pFpNCqzpZyIC+Yau2sJkzmFw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-JGaM4YW0P3W-moNh4f4IKg-1; Fri, 04 Sep 2026 13:09:34 -0400
X-MC-Unique: JGaM4YW0P3W-moNh4f4IKg-1
X-Mimecast-MFC-AGG-ID: JGaM4YW0P3W-moNh4f4IKg_1788541774
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8563c2a53dbso26431757b3.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788541774; x=1789146574; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
        b=nBU8lYkH68tvvtjzIqDz3i9eXOqoyOs+NRBjZkLiOeI8ndTIHAqY6CcawkS0/s6bbK
         J6Y0f0Hl8VWeX7VEbQaT6gi5GU+2J2NYfRZ9dib44P93+AT3Y1BCa9uLKaiAlTyitSzL
         lGlS4tHsDnYmmT9A0YPtwHf/QxLMB0932L3OwUdellopOTjC3JDBvl5rKIbA2oC44Tde
         Oc7Gip30ysaaC+cPSjf3lUQHlJlcCI/gic7oKgeU5KUw7mPbe5FP64I8/1v4ZwCZcSNG
         Q5XylA8v9DSf5GVcUMH0f0SLr8QuunSxh3zIzQ+6Ww8Vr35Heba0XHGAgqB8jAQWbwRQ
         8k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541774; x=1789146574;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M0mhCecfkd0CiyLlUKZRl2yAWss2xveqdG1CcOWYKi8=;
        b=ml3KUi9vJxWcdMOt4xz24CE4YBnr/XcuLY7HrhDZWHAnRue1mysP9WS3KP2MzIftXR
         La9U46o1UkDebTgrjX3LDvTlWS5W6ZCREQKXKOKxBky1sBt7QSbN1G1CJDj01dlzkdMO
         T1foY+LDi7tJufeMCt8RloLaWktlerBRwiFdaHi7My/T6CjiCdwCU97tPoZI8L5iLgT2
         llOnZpJxU++kT0FbtpeXuF8Zk5Z5Jn7y2T5nZWJ4KX+U6wKxvZSZ97KbSbFvQnD0E0qd
         UNKW9YgDg0bBn+VJof7nSFn6r73MK6iKXqVpBZW4+ho1vAVXicjyr8CWzbMKGH+VqFiJ
         gkdA==
X-Forwarded-Encrypted: i=1; AKwUvBwc7lR3qr72i7rE1LDYK/VUGuAeQlBNYI+l1DwVTe8SrdAGuglOdqCSscxrwJ3UjcTpLb3V+Kg=@vger.kernel.org
X-Gm-Message-State: AFuF++kpp4+HVG7dRLrVawBHjJZEm2SulzA4ovsRwJzXANURbE57gwP9
	LDZ9w3ZvIYXpoSzT6U3C0y3BbZ4XdmBDsUlL6GMnyPrICNAWz4ApfOwzIq9X8t4PzSKMaTHqjuy
	sS+VWp/+Qy2zWrVRCLRSi5v9VdeihumSMyS2tq6Ml7lU2UYuopQnXaO9pIrBeXF4npqKKgxASbl
	NTUFY2uSMrkfQWS5JG4j7P81GMrhErQvSWzT1l76S4S78=
X-Gm-Gg: AYBFou2rdk1zdJLxNgNpb5aeKVZ/K3vRXxMf30ZTmlZqyFPcptzjRyWeMV7wbQv22FO
	crQ+SWF73NQrszjtxSkA+pB2u87NGtEkPdR9YFUyUDO2l/Ej5O0WpBjhqxT6yZNas7ghPntPFhB
	CY4+W+xUIxpQBDKzofE4MOG0IO354UPHNnwZqgHKi30fVMSOALyabOdu4irIM68VcR0vx7N+Fu6
	aPqITqb/y/EI4spI1AOG9OKon598dJ43n9MgPpvSS3SjpvuU0jJh1sTBvT2l+Brj6sQ3QoGu5OI
	kn9MRfSB4cQQ+ec8sJZK9aZ+Fo7b9IxAMH4CodCA7J5jpkBMRHfH7LMJIvZQWUQ/fdcgPUPVpoL
	OyACYcA+o520fqQf1lTSZEzR8bKUh
X-Received: by 2002:a05:690c:c501:b0:873:5c6b:a2fc with SMTP id 00721157ae682-8735c6ba821mr10953947b3.42.1788541774175;
        Fri, 04 Sep 2026 10:09:34 -0700 (PDT)
X-Received: by 2002:a05:690c:c501:b0:873:5c6b:a2fc with SMTP id 00721157ae682-8735c6ba821mr10953157b3.42.1788541773402;
        Fri, 04 Sep 2026 10:09:33 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93988e9f80dsm122480885a.24.2026.09.04.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:09:32 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  kuba@kernel.org,
  pabeni@redhat.com,  edumazet@google.com,  dsahern@kernel.org,
  horms@kernel.org,  sbrivio@redhat.com,  gnault@redhat.com,
  laikabcprice@gmail.com,  aroslavdudkov622@gmail.com,
  rough.rock3059@datachamp.fr,  stable@vger.kernel.org
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com> (Ido Schimmel's
	message of "Wed, 2 Sep 2026 22:01:12 +0300")
References: <20260902190112.4126199-1-idosch@nvidia.com>
Date: Fri, 04 Sep 2026 13:09:31 -0400
Message-ID: <f7t1pb9j644.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ido Schimmel <idosch@nvidia.com> writes:

> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
>
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.
>
> Prior to the blamed commit this could not happen, as
> skb_tunnel_check_pmtu() did not build ICMP errors for PACKET_HOST
> packets. Such packets were instead encapsulated and, unless the DF bit
> was set in the outer header, fragmented by the underlay.
>
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.
>
> Adjust the bridged PMTU exception selftests accordingly. When the
> local sender in ns_a pings the overlay destination with a deadline
> (-w), ping exits on the first socket error before any reply is
> received and returns a non-zero exit code. The test therefore only
> passed because the ICMP error was never delivered. Use a packet count
> (-c) like the ns_c line above it, so that the ICMP error counts
> against the packet budget and the exit code depends on whether echo
> replies were received. This passes with and without the fix.
>
> Fixes: 8930424777e4 ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().")
> Cc: stable@vger.kernel.org
> Reported-by: Laika Price <laikabcprice@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260614-master-v3-1-9f5060ba1ed1@gmail.com/
> Reported-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260901081825.287173-1-aroslavdudkov622@gmail.com/
> Reported-by: Charles Bordet <rough.rock3059@datachamp.fr>
> Closes: https://lore.kernel.org/netdev/aHVhQLPJIhq-SYPM@eldamar.lan/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Thanks for the detailed analysis.  As noted, it was a very obscure and
subtle issue.

Reviewed-by: Aaron Conole <aconole@redhat.com>


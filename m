Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D7249EB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422160; cv=none; b=Q0WKhRX/hh625n7V7BtVjqvSzzyB7FyIzq3/iGPw+7FVmFtiJ5WaDex1m1KR3zUr1M5DMzOOImN4+s2WQusZS4MJld5xmF1hC/h/595izPmlEq6sOXBr/ygXUoYENbqQAjIIKzbXwbMns43yxRaLBTCQWrIluO2mI5ztQ4CJh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422160; c=relaxed/simple;
	bh=eEN+V3cQexCgSmzmNCM5zv7ejVDZO+umGBGR3h1Tc3k=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=CI+WRXy/l2To+PaRUznGz0SxpG3yuSi0JdrjlsuvsXbboKwLF9Z/4qkh9p1N5yjG9yZu1AhOieGHKhL+SxOa69UmzooFNl7uprwnmYzkq7U1an0igRk7OpzA5hrv+WeFrKtTWJkys+rcHvI8FEAY3YF4Cy27o/L1JxqsIdrYOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2Ej59G+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbCD7s7u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2Ej59G+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbCD7s7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788422156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
	b=X2Ej59G+zmdb/GSR+Yshh6fZVvSw/MVB8ammZ/FAcmL2NoPGlOkwmTDs02eMk2t8PbaTXH
	fCC3wlMsc99cjQAB+t3hERXQzpWUvNBqqEdDZm5IZBjoowmj3lu2W2iQ+DDB8Lo2Iem8G4
	8eKfnugyVoWjU1YdNsELRbWKHURseYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xG6o5-dSP0-aC6Rpan9GjQ-1; Thu, 03 Sep 2026 03:55:55 -0400
X-MC-Unique: xG6o5-dSP0-aC6Rpan9GjQ-1
X-Mimecast-MFC-AGG-ID: xG6o5-dSP0-aC6Rpan9GjQ_1788422155
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482ea386bf6so939981f8f.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788422155; x=1789026955; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
        b=LbCD7s7u/6BxOxqKdkJw9PB/5c8WUBX7618TqEBqc3C5JkUR/O3kUc8zoS5KsB7/TI
         0ji2jHVVzfFwFPHwAKjmo5Gf8ssmbgK7OXbM1hl7bic8IIz18tmPnQMAC/XatAc5Scs4
         JtLXXex7kJ7lBFu0Rr3GtE8XwCrnarg4Cv16qHm12xXO3166V+D2Ay8r6S1UVQT4iiTP
         hQaFMT7QjmjZN99/cNT4JC840sOOZRUOX+4eX3sLAzVnOlcQ8GKBwdB4C3j50zKmwmiv
         lmVGiT4iFt29lg81mefQ973IPlYqXSQYTfdPzizc2y8gQ/0fa7bWW62lX6HCrJK61JAK
         JUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422155; x=1789026955;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
        b=LH05mWkldFIQO58mhAp6rKgRSyHk+mrAvu0kk3nHa2arEIoYbmi0OSZD0y+BgZT45S
         PAj1qnuoFNG7nKz6ZnF4ZbwlGZslZD/W5h9AlT3yehB1ehDtClBS4Gav6g+NgZnyi9Et
         E1uPyWEtCLRYnb4iaFw6gnkbCRyhUEH9dZBxRfvSUepkzOseHfNOtZ6MhTavs0bb8me9
         0DHpacNj2klRLQVzoPnDdDGK+vSBvrJWfQUs3ORVVB/0arUxoVlI9xWndl3gGojljoHQ
         efEQKR9iUN6IprrnBbiOeDJMNrZ7fDotHB9hiRttnBJ9iVjYitumaEJYEIPMWQ6wX41F
         1aKw==
X-Forwarded-Encrypted: i=1; AKwUvBw0C3Z+L+APiMim5t5iyoWcBOEnlanE+5ll5qEjmqF51WBctknAp1UnpIyvoKvgqYwJw8cP2Do=@vger.kernel.org
X-Gm-Message-State: AFuF++k6J8ztr2kwaJbhPeaeJVnlqgaJF/HSYepGMpFZGS8IXaAV4m25
	NEACqcNemulk/gl27Yh96Ne/XhCNBNqawUfaAtwnz6Rx/9N/0MHT6f8iesJnTBnEO2X+EiQZDJ4
	sLPDwrFs6dIu2oQFx+fgPc2OCJxriAIeDtXvtkdEngRUrfu2hkokWmbniFA==
X-Gm-Gg: AYBFou1M1RvudBY2WbByjy9mKhrs2clU1FmFYvupZMCR0RC8l9lGA1wG1ehNJulfgr4
	WIx8kXZYjPRXf32Y7OjpHKMI7AzA6kbPwAzgbcS6g18SMxbF5VB1la4N0r3lZ78xg9dIoRzCfVF
	dzmZJ0HKQFpuMsv0w+8PUY+PA4PUJIRBIZxqNogYPXmBu6CDJ1Uzh9Q0JL0fiOaV8UeyH+cTaPe
	gfZgvJViNgULMjoe6oQJgaSiwkNdYWpht9vzHK8RUI+ldwk/IMA78O846oHZ6pDBqgg5u3GprTL
	PRW0/hPLC38R/Fg9F0ZteX5XLUAxIBHE9CMAvwPVBshiqyVceLZQ0YrTUMoyGoCIUs+OuRhfu//
	1UhQ2ZTv4GXQ=
X-Received: by 2002:a05:6000:1449:b0:482:ea9b:962c with SMTP id ffacd0b85a97d-48488f23cb6mr19279129f8f.22.1788422154530;
        Thu, 03 Sep 2026 00:55:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1449:b0:482:ea9b:962c with SMTP id ffacd0b85a97d-48488f23cb6mr19279015f8f.22.1788422153950;
        Thu, 03 Sep 2026 00:55:53 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea96csm9953344f8f.29.2026.09.03.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:55:53 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 horms@kernel.org, aconole@redhat.com, gnault@redhat.com,
 laikabcprice@gmail.com, aroslavdudkov622@gmail.com,
 rough.rock3059@datachamp.fr, stable@vger.kernel.org
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
Message-ID: <20260903095552.273dc06f@elisabeth>
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
References: <20260902190112.4126199-1-idosch@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Sep 2026 09:55:52 +0200 (CEST)

On Wed,  2 Sep 2026 22:01:12 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

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

Thanks for fixing this and for the clear explanation! It was a rather
subtle and obscure issue.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


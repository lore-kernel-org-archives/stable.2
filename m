Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049331;
	b=q/1WgtNsbDq26NUhtdPPmh6W7Jq/XtAE25kFHpGKCcX3BoJIkqa7wE9/35ke4xROgkQ+
	 6zTDlrxoRSeygh6fY4S6G30hNEzWDkxVEKbVBIxga8mlU5beZcEoo08HxlPqNPA7rvpwY
	 zMv/I3jHW9AD3E7lIwthT73pOD/j6IRPvEKiklvxeOIVLXncpC1eLy7j0sppATu8bsPf/
	 9CpsMkOnUJ9gPkrxwFHih0l3xPFEhG9DZlAiJd3fmTVGBIJVsHCTBAXoml81l9gzwePbC
	 uq9wr+2xiMRc26NdzXmWOTaO8+ni0y6NGiUCe/uxqkV/uEVMuv0egPCaCbMCRjyCNng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049331;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=4UH4MuHKqQSdHfWzmTuo+LVB7QPfsbG6UhR9RvJMQ7U=;
	b=l8lbaZsnty3CyQ1xWXUxAQu7LznW5LWjFB/Kp75TtZphj7A91ahI9S9U9kYr9UvT7Wfm
	 H7HAymcBoaWh3anIyODeFdRMLuUIxpW8uAEscglLrJinTFZpU1ql8JAWR0pn4NWuSWSQ4
	 jCqnj8hdj4ke0jU0fGGLK90wfP3rmF0O+cx65oh6bABTsJVNHtW4mpUj19SuM/37DU1RW
	 7TZLAvmp6UkxknTYBh2xz1UhiycLtxKm6kgQKWCTJ8shBvR89seGWInl8069jgtHWOexr
	 8k+g4JYYTikI+V++m4S8kWsB/vyf0sMvZtJYdkFpSke/qwSXE1tXwlcYQxhhP8IP7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rq4ig2Iq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gOcSuuYb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58560A2603
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA58560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rq4ig2Iq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gOcSuuYb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795049329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4UH4MuHKqQSdHfWzmTuo+LVB7QPfsbG6UhR9RvJMQ7U=;
	b=Rq4ig2IqXBN5XKSJH9BsTHm3faDM0V6z7nYZyzX+AomEocAZesmcxEghD6rS/RTX1pwsb2
	fwds2dqBoXjpjCnEUi6tDzPxAiMopvo9ypFnxqodo1Mjd9x/A6Qqv/+kIXQISaKc/+OqSe
	skYsPBOTC2EWvGIPXu6UhHF2Qv8yGmE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-sUaSeTkAOGaQUZsVP1-k_w-1; Wed, 18 Nov 2026 19:48:48 -0500
X-MC-Unique: sUaSeTkAOGaQUZsVP1-k_w-1
X-Mimecast-MFC-AGG-ID: sUaSeTkAOGaQUZsVP1-k_w_1795049328
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0461e040so1252366f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795049327; x=1795654127; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4UH4MuHKqQSdHfWzmTuo+LVB7QPfsbG6UhR9RvJMQ7U=;
        b=gOcSuuYbWRF+WCIPDw53q1IwgfBu1II6cdW9d0LYp5XnthmvC/wH4/1K+tNFDTGYQt
         BKxNKJ+XokiVmNp9nr4uNkZr/LXm8mIwqOmuTuFUIMJ2t69P8pDkZfYTb5b6RdMY8YXf
         JC/uaywl84FaS/EqHmkk4HYyWoiQp7zMmNNC4bgpdW4F5kqdyXcVUVBIeP/FKjm7jNSz
         BDhs+NI8YzcbAfXNzUHoIlkC9E63dr5N93/P7Ur9w8qeIz4xam0tkPkHOSwMsAOiuIk6
         PCv2Rloo2sL1yTpIKrNTzYbk6PbJdwAVN1o81qzB7LKy2P/4e05tSN36ZkYoK1WyLfHv
         M7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049327; x=1795654127;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4UH4MuHKqQSdHfWzmTuo+LVB7QPfsbG6UhR9RvJMQ7U=;
        b=Re8dcgDT8BWU+H6JHYfmm6ePNEJVRZJwyPl63YqaJ7mdcMp0eHEh9uQiKCNy0QvpK0
         WoUiRW2pUw1wiVOiUSAFP8aMfllXsaW/LJHknrmb/Ltl75ZHsRQ4lHn3SSyix5z/qg6e
         iV8PwCzwZkiTkAcmHH17iegQSXscHIq2LZKdCymx/ksvTt7QxFBaEqmk2STJD/X4UzFn
         8b7O7kashnAc2L7ZcJKoCoS24ghsWmEnz2YthIpplt/mhYSV4hcx+I+7XzvsTg6bsDJW
         ZNIAcwySAkFuh3+g1dDdrVYFZSCLRzbVZAE+7lAZtET7VCq9vAGmn0F5i/BKH462Y8VD
         chRg==
X-Forwarded-Encrypted: i=1; AL+hErHw0IrP5+wlm1bI4Zdi8XK9qICE7gCL8nctNhcqykx+Nz0DUJBbwLjXEgf5KBFXoXsDrxpLWuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jmOak7Immc6/62OA1sIRsPT2pBym8UEWfl2LrUw68mwAMzXSF
	5xrUFnl7CSuja/YGbvUdi9uKFGxvXN5CpJYi+YNsGyXkGNsMviL5d9Fio/ItpOJL1OI6h3/aDXA
	2E6WXTixcMZkBTMMCrk5NIFO23uaHZEm11Q0xTrNlls6TjqfG/YGrMWT1ioAw/gjFMkMqhl4N1l
	LsDKBjG7mOsV6b34fRbpk0pqAt8iLprQPGZzMRcNgr
X-Gm-Gg: AYBFou1jn18F+EgYTRiVESygS3FIxg2pHyJUn3BlndYdI4Imq+RdGoj7bcfIhJfRPik
	5W1b43jVKL+th7+obPdWJiV/aBJDG0CqsFB9/SiAisF6pJwBhum7fcgXspoI9Yfl+FHVAn0ZmJC
	YXrhjjUbOR3Hd8ZF/M/MZHA4CSkVSPEX3xsQhT1PUL9vWYvWAF9xBeFwtS7p1hOD5q6yrjwPrYj
	/k902TqAbsxAN4F6DaDOsvL5E8vpTimbcB4kjg70nPRESSe9Cau2BjzKrUid7/H01g51MwChqNR
	rg9u940iUu2aXaunbN6/s0o/8xwMlOjbulr+aINEVORrBKJbrrcYk98Qw+EeZwwaw27L197J+xP
	t6MkKJ8IJjK1XNQY0bnnsFAE52c7Wm1msWLJeKEDgtmwylF2qTYxzSted5WMkDJ/5FBJyk+BTcy
	j4jdE=
X-Received: by 2002:a05:600c:4e93:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb7da138f5mr88386275e9.5.1795049327641;
        Wed, 18 Nov 2026 16:48:47 -0800 (PST)
X-Received: by 2002:a05:600c:4e93:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb7da138f5mr88385915e9.5.1795049327215;
        Wed, 18 Nov 2026 16:48:47 -0800 (PST)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8450fa2csm10785465e9.7.2026.11.18.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:48:46 -0800 (PST)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  David Ahern <dsahern@kernel.org>,  Ido Schimmel
 <idosch@nvidia.com>,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,  Xin Long
 <lucien.xin@gmail.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Justin Iurman <justin.iurman@gmail.com>,  Linus =?utf-8?Q?L=C3=BCssing?=
 <linus.luessing@c0d3.blue>,  Sabrina Dubroca <sd@queasysnail.net>,
  Stefano Brivio <sbrivio@redhat.com>,  Hyunwoo Kim <imv4bel@gmail.com>,
  netdev@vger.kernel.org,  linux-sctp@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 3/5] net: openvswitch: use
 skb_set_transport_header_careful() in parse_ipv6hdr()
In-Reply-To: <20261113124625.4010206-4-edumazet@kernel.org> (Eric Dumazet's
	message of "Fri, 13 Nov 2026 13:46:23 +0100")
References: <20261113124625.4010206-1-edumazet@kernel.org>
	<20261113124625.4010206-4-edumazet@kernel.org>
Date: Wed, 18 Nov 2026 19:48:42 -0500
Message-ID: <f7th5hdk5n9.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@kernel.org> writes:

> skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
> reserved as the "not set" value. skb_set_transport_header() silently
> truncates an offset that does not fit.
>
> parse_ipv6hdr() stores the payload offset found by ipv6_find_hdr(),
> which depends on the extension headers found in the packet. Should the
> value be truncated, key_extract_l3l4() would parse the L4 header at the
> wrong place.
>
> Since commit 3744b0964d52 ("ipv6: Implement limits on extension header
> parsing") a single chain is bounded to IP6_MAX_EXT_HDRS_CNT headers
> (24576 bytes), so this needs a large skb->data - skb->head on top of it,
> for instance after several nested decapsulations, each of them possibly
> pulling its own extension header chain. No reproducer was written,
> this is hardening.
>
> Use skb_set_transport_header_careful() and return -EPROTO if the offset
> can not be stored. As for other ipv6_find_hdr() failures, the caller
> then sets the transport header to the network header and does not
> parse L4. While at it, use payload_ofs directly, since
> nh_ofs + nh_len == payload_ofs.
>
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


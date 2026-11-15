Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753631;
	b=Xe9hOanK1pYZn8t53sNKXDRBKe3qttqA0FIKD3aS964hw8CH1W4TW2JWt/hI79YA4KZq
	 QchlNJ4zs0gZDX2xCpQ9sT2za5uDCyc6HQa1861Q31y+nsch3CmbmRyl3oSq70Td1Egs1
	 0IcDQTWpw9BZAmsb08hEobzNXRJftSUOL82bVJ6vfFucMtx6uxrAiGPSJvorho2Zm66qU
	 qXhbUCvKmI2EFLuJvgvHKUOOv5nldsjbe5QZ7lwFniuLhGrcUfppANKGbOW4X+DBT/Mgz
	 L2TvSLyLT0DlRyNOOhJohj1pj3RL4u3CCisUFV/X25TVv5RoYCE3/gmhasWBxDrldwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753631;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date;
	bh=1bihxelyVft2t/5mQ9f11F3fi1jsaO8+e8OfSOmmVx4=;
	b=aCVuphJSzzltdXqYHgxvK8y5uCk/0SMNSorGtr1STb0D0vzoiofU/cwXZJOgE5xxxoYp
	 jxpNplR6/J5QZMLbfMapVQtglTX3eW6MsgqlMxiWot7M7+KQpGnnJyVLBXI1c/ny4u9US
	 25f+0Hx6y6j81Hdi7dcdwusiqSM3rRERih5pQ2x/fC4utdBfXed/FkEExfsUFFc48vGR6
	 tNFjtFLV2U5awiNNbFkJn3zATd+6LUZQpMXzA12l4f2TItg19+qwN7vHZyLO2Ul2QyrOc
	 +GPMa4jUQA503NVTXeBVtkqAQien7EvoUgO69mVQbmMjM4FS5eLIrWmd4GYZxVNTwzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+sEoWtI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tnD2earF;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA2606A336
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCA2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+sEoWtI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tnD2earF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794753629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bihxelyVft2t/5mQ9f11F3fi1jsaO8+e8OfSOmmVx4=;
	b=b+sEoWtI3YPxeWc19Rqv41UMQds3/kBhw9qdmFvnCBeEf8+zYq2o+fbalp9KTjc46UgLIv
	RwIFmUY8vjH+vjgttgKiiNYdve9PqNG2cJuDpAuR/M8XukvZ4dHj6pf2yZpY3SA5KdCRLo
	d6RwFrWykbHbM3rt9012N/Zh5A/huig=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Lp3p2mA9P-6MaZ8a_vaF7w-1; Sun, 15 Nov 2026 09:40:28 -0500
X-MC-Unique: Lp3p2mA9P-6MaZ8a_vaF7w-1
X-Mimecast-MFC-AGG-ID: Lp3p2mA9P-6MaZ8a_vaF7w_1794753627
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so5537095e9.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794753627; x=1795358427; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1bihxelyVft2t/5mQ9f11F3fi1jsaO8+e8OfSOmmVx4=;
        b=tnD2earFINlcIWCgQkIzOvnuIK459bfYDLms9bXlJ8uCqxXDEN6G9D0zzS7mje1dQo
         mLOiLv0RLzLtixdajFswa6K3k2r3agMpSZlJ+guHHm0id9/TeeBsBvtEWEeTSxjxR2cQ
         BMysyxeOkHz6oA53uRws3Mg9pvQDHd/tS3JhqfCnFTQYAHj8N+inMMzAUCXipdx55XKc
         +ZwVSvViRsFvJyRtnKm6FiEA7a+IuGKJ9aaSWVU0IcSS2mSi00yyCa5mrYepPsbg/GUs
         UixNqaLbNjxS5qBWsnET7dH4tde7ttWo9E3pr4qvBJEaDV34x+mvgVs3Mbo2Csy5j/UT
         qmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794753627; x=1795358427;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1bihxelyVft2t/5mQ9f11F3fi1jsaO8+e8OfSOmmVx4=;
        b=Fpmlc/6NCeb4sCoZqoda1p9Il5JWkuT+Fync/ILTnuHfS9nYTAXLcFEK2cBF4tFzpB
         gl75ygKMyg2uN48x1NduLJ9aB5JG7Q2wqFHt7DMBXSyelIWHYvTv8wPYF2gHwv8Ozg9h
         wqRAWt7U+bwIAoF24EZ7K5flBLMpB1lP8mdkB5OAUxOVYa6CYeG4JkjTtVhmWhIkW/zE
         PFqIqi6czMV7HrJF1fFuJszYLytNwwS8KJlzcVcGvjp21Q6mkHESbkR8/5sicamyDNLx
         9omJzNzIv2VCOKk8OpXkWZdupXDOGv996jmEAWcC2xY0NIcv+AvacHt2eWy5elUtrq4o
         p3jw==
X-Forwarded-Encrypted: i=1; AL+hErE+KU6cZaRiKxVwiWxgksh9eRhoamjEAHXxco9nqV0akHW139sZ7y9OL2lcEpzfWh/JaRhYMMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZlXg+uoPGMLMN67aPyMGLVYahtwEueA6PM4SmMAotTTbnkfmt
	Rt5RvaOmcUHZVpWvWKO7J2WZTErFTKVoX/m/7DjmmYG7uY1bsD0DIk+zfTy43EJ81PqJY3P/xM0
	+iQjGTRzMmGiPSQf0DOKsziAq8OywNE+0AH34Vq7lTLleQfBaSt9iloKetQ==
X-Gm-Gg: AYBFou1qQG0GPaRf7jWnGnnDcli3Z6KCbrBc7Mwtom/oVLTQHpPb8Pfcce301MmGpo8
	Iv5LdAXt8Di1O+s+bwY+Gvgp2eSCaG9r/CIBuFSr1KkikwYVrEy0SDEzP5ZB4m9MbUscFSiD7pQ
	lygIxIwllcQbNjea2B2PJzIEAAYSkh+38Q9CfCC9AI+GFRkMzhuSgLVoo8yZaOyojo03OOj1dU6
	f95RGYeCS5j1ZS8l6va87ENlUYWYG8lOBSiSwbTvTs1hnhIgm5Wdcv+EM+pGoz6aZq+r6wNs81v
	VHIpybBj+2KdI14PuQdZlm4UdUOfgX7FNbLaXLt6c3edUoakJIGyw1kf7dq1YghNlRmfyEXr7qO
	wdQQSg5ok+AyHMdpD+ucuT1HjRyYSaXRY59HfcNttv0zhfshT0zIcZOumfhG8RoJbylU=
X-Received: by 2002:a05:600c:2784:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb4e2918b1mr215622715e9.2.1794753626906;
        Sun, 15 Nov 2026 06:40:26 -0800 (PST)
X-Received: by 2002:a05:600c:2784:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb4e2918b1mr215622085e9.2.1794753626265;
        Sun, 15 Nov 2026 06:40:26 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223b21sm18628968f8f.2.2026.11.15.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:40:25 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Justin Iurman <justin.iurman@gmail.com>, Linus
 =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>, Sabrina Dubroca
 <sd@queasysnail.net>, Hyunwoo Kim <imv4bel@gmail.com>,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org, dev@openvswitch.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] udp: use skb_set_transport_header_careful() in
 __udp6_lib_err_encap()
Message-ID: <20261115154023.41187779@elisabeth>
In-Reply-To: <20261113124625.4010206-6-edumazet@kernel.org>
References: <20261113124625.4010206-1-edumazet@kernel.org>
	<20261113124625.4010206-6-edumazet@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Nov 2026 15:40:24 +0100 (CET)

On Fri, 13 Nov 2026 13:46:25 +0100
Eric Dumazet <edumazet@kernel.org> wrote:

> skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
> reserved as the "not set" value. skb_set_transport_header() silently
> truncates an offset that does not fit.
> 
> __udp6_lib_err_encap() stores @offset, computed by icmpv6_notify() from
> the extension headers of the packet embedded in an ICMPv6 error. Should
> the value be truncated, the tunnel encap_err_lookup() and err_handler()
> callbacks would read the UDP header at the wrong place.
> 
> Since commit 3744b0964d52 ("ipv6: Implement limits on extension header
> parsing") a single chain is bounded to IP6_MAX_EXT_HDRS_CNT headers
> (24576 bytes), so this needs a large skb->data - skb->head on top of it,
> for instance after several nested decapsulations, each of them possibly
> pulling its own extension header chain, since @offset is relative to
> the IPv6 header embedded in the ICMPv6 error. No reproducer was written,
> this is hardening.
> 
> Use skb_set_transport_header_careful() and return an error if the
> offset can not be stored, in which case udpv6_err() ignores the
> ICMPv6 error. Do this before changing the network header, so that
> nothing has to be restored on failure.

Right, we can't call __udp6_lib_err_encap_no_sk() anyway in that case.

> Fixes: a36e185e8c85 ("udp: Handle ICMP errors for tunnels with same destination port on both endpoints")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Thanks for fixing this.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


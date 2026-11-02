Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631870;
	b=4QiiFQEwv8xTaoJJCpf5BsIopeY0zFESXvyXYcaud72TlBrZ31lVwVtcq1Cufv2RHeAr
	 JAqDIfK6Ldk3EhqkYVkVRx3FdAqV6VlYVhbaz+9YO6Wvhx/U1nhg5gkHJpqvrIDoE22HU
	 JG0wcInZFJXH9gwhkRXAfkVPSAydoJi+/hJ9xogcjr3HS2nkdalYFT/hSVcQny04+iNVj
	 iMr3zmRk33BdX8s66npKxZsLvVtVwwmjcqjF1xFcJheEfRkIkZ6hFsc2zQhjJlNdRO+8k
	 Oh79h+Mnf72FjZR1UR0DEE6jb7BkqUL6PX0FWu1hxrsaa5X5IIrba3+X7b9GUJNbvgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631870;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
	b=XXiazx/MkLz7jOstQvWMNzofkVMzmv7wlnrs4bGacS5qWBXwOgvRXav7PPS4Gyflsq/V
	 J3xghc2PcGojgdohRdALb4ov6Gt8I5doGrXIV7EzPd+Qv06lH7WCXmgX3nI/t4/uMIVMe
	 yu57+uN9PqQYaMBWuZjJ9HEB/Nuhv4OrJITawI3uKxspXCchc2DyAlKu4VxOC6tAOvnSb
	 YB7oboeqosivi3dmddB+pWI91GCIWWYgKj7HrwduuLvEkp4JVNazm07ZOUkyU/rY1Mmtq
	 Xm45V9pqvyRPgkqup6IKWhnhyY9a3jJUQEtEg0zLHQz8Uw8K1flXrbM4sFTyhy6NWfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdxKNWOQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAXFWBPi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AA606AB97
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518AA606AB97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdxKNWOQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAXFWBPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793631869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
	b=gdxKNWOQEk++S4/1bXtMi507dNZmHMapgdaILo1y7p4sXk39Udy2F++uT3a3D5kre1xrpD
	1bRjMfIfNzSKS7gVAoIyMd7UJgCGpIAaJADw8BI+uCD8Cib/NtQJ2907zNE+EQHZiVv3Az
	Ois4/7SyB4i8xy94WrBsQxuo2/mOE/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Pft7vHccMZ-0iATAzDL2sg-1; Mon, 02 Nov 2026 10:04:27 -0500
X-MC-Unique: Pft7vHccMZ-0iATAzDL2sg-1
X-Mimecast-MFC-AGG-ID: Pft7vHccMZ-0iATAzDL2sg_1793631867
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49febef74e3so28290185e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793631867; x=1794236667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
        b=KAXFWBPiPvK1zdlOSD7Y6+WhcMNsSPF8TEk90tpnyjlVD1yLrHRLF1ID5BeVYevEsN
         WS5uyoS3SyJcL1bA5Ojx5M+DHmPCBxIkPqQBf6wGSvelyHORsY/wRNoTeWvfrotXJy5P
         YnznCVQ7eoSIpBm3BCPwiRakjb+wAOlRQsou2orIRniLZzaa10zvQJpOGPP6IylEkhGD
         PNA6rG/Oi3zBwqp4ZD7ftqV5HU5+daEZtGZpszMjRsvgCj1u3kj27z64meTN3LcupcEL
         HVLR1NEKVoZdaWUy0EaNYKjK5TqlhfME1dGoS3VUmGyOM2OvfS0/MsEAVqUFz+Wx7Ly2
         NZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631867; x=1794236667;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fA008cerU78BCHAofvMFL2hjDxFpzl/8zUGrxds54c=;
        b=0NhcB5TqbSIgTkYyspommQ+Oq7HkpEUj26U63lNMNCGNsb4yHVpPBze/29rCPI9uOL
         lhqeBxfejqxutSIZliMbJ8P96BDubFXshlR2sUHV6POSdjeyTNtPYr4aiNZ9oswXXwLr
         IXKbtqKbrh2aWF9PGYKlSi43wmxXa0G8rH5R+LvZROqOanxmR/SX3kq4BM0lZikxs1xQ
         lU0Pxkqc4jDZfdVCwh56IbzWaLr0ieYd+cA+mXy1d/O5S8bhb/9u1eKY/cKHQQ9XGwyU
         PjULD2wh79ho5e21xWRjOJG7GAdRk7EWgMXj79Gb7VdYrqaIY79Dzy5TJK3l0kFMKBPn
         HxXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyiwIo8y/1zClOEyau9XFrZxJlqaoQm5aNofXF6x0PY3WOzjnYUfX28q3B66WpKV570bmCpBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/yLn5sAW0Jf4wSqjBOpG5gO05kADLCZI2yaSswzModdXx90/i
	2hs4bb/qGN7SCtMe8/TBieksufhrZuxzHhO0UBB0yyd6RMoz/PYCY5ps2GHoVegH2EFnjdgRsPw
	ckcRjAe8fqnraN8SXkZpmWA7yOqR7UFrzB/gM/65lTBhhUuIelcbzUSeLkw==
X-Gm-Gg: AYBFou14SY/L2jVODRY7aWayWZ+g7JDXDcObiLZGLQhrM2FIVR0pZXRZiu32eOA2l1Z
	Imb3kXOnJAmyCcc/A7q84MoHxrJKOeXvs+MqdNx/qoinFb4rafZGQIjWITL+FwnxY/oLN6JrUgB
	YMJklM9pCDJcqosf5LPxteFxv8fHBxIXMXVXqj90mvl4twry41dWzlctyhkMuKWheoYTszYW9MA
	gYdske+Rmux09nkD8BVsRBoFT6/uDYCHF40qQjgi223oz8WQzUTS0YgkpOe88PVquG6K+zPIat6
	vVcID2nI88Bivxh7830P3GqJESEmhbIabNfgGC4LDYxiv9PbBKy5/juEiuAkj3HYrty5Vkgtu90
	ZOV2Ylkkl0PL5W/oNmfkencyFUp0oFwl1RHX9A2eI4kcCZRbxfoVZbGChtf5PQKjwaCWDmoa9/2
	Hy+BurWu9s9ywF7cB3T+dpyrDqIsBCr5GkgSMZTWrCSWg=
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr228615045e9.11.1793631866694;
        Mon, 02 Nov 2026 07:04:26 -0800 (PST)
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr228613495e9.11.1793631865501;
        Mon, 02 Nov 2026 07:04:25 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm279340495e9.5.2026.11.02.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:04:25 -0800 (PST)
Message-ID: <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
Date: Mon, 2 Nov 2026 16:04:23 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly
 queue
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 Florian Westphal <fw@strlen.de>
References: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 09:12, Eric Dumazet wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> 
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
> 
> This can be triggered from an unprivileged user/network namespace,
> raising ipfrag_high_thresh and using padded TUN packets, which keep
> a large truesize after being trimmed by ip_rcv_core().

Clasiko infers a similar scenario is still reachable using multiple
concurrent frag queues:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030081225.2575462-1-edumazet@kernel.org

I'm unsure if that should be dealt with separately?!?

Thanks,

Paolo


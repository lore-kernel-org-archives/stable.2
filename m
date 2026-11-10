Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329852;
	b=a4DaMW2sFNUYTQOPekTguKqoX0o+BNZFOYIHOoTHIHawXTQhNXlAEwnvJt8wERsZ5Xtn
	 n1MKOm+5ETIzBBwwVFSWLxV3O6btl+21h9khRqipx3ftDTDm2bkbXGEZEo3FDRaLnosZ5
	 QpQqm0BBlAdPmJNxlBK4PpCrJD5KZeB3tecGG2qH0YEUok7Z/NBqZ01VjqZ6NA+qDDLOm
	 x+OPQLSOU3x0FG53O3FRReovgpXqnqFGaLl+JZAyPY8CXJ5oJFIloKplrVvl8TVAXN59P
	 PEEUL33S2H9UwPSnZmaFRp/pOIMnsL+n4d8aL0jEx0xkyB4cIYfjYqhYp3K9tcJPz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329852;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
	b=o/efK5yZv+5cSca0/wbooDlvE7+y0TBh2fPbDk1kI3zE3bE6Z0RQXQmOQDvWnz4j6NXd
	 KcjAmmxuQkC83eIK0k0UXUV9So2XoQJDo2m2lqQ8lp6ZF0vr3DSi+cG7gN0crs0PgJMFR
	 M1K0mboU0+FynPLNJkeLWtgX60HKLZ5Hj1sDG92r9vF6IaXA0yZq36+P5np4iErRZ6RYO
	 PPfrc/4x3IJgW9CLGUYV2pr4/GEit5Q4B292ISE1hr1aiFUsNLJGEwh2CvvF0n0eNL4vT
	 addb4B4r07TwV/eMuFHSb0pGDZzopszpl3dj+zI0/qPIdsqjBLrSawY41qDq17d/smQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=igskeO0d;
	arc=none smtp.remote-ip=74.125.82.230
Received: from mail-dy1-f230.google.com (mail-dy1-f230.google.com [74.125.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D3606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=igskeO0d
Received: by mail-dy1-f230.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so4437796eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329851; x=1794934651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
        b=eMFQ4RXdtewFPWFDhSdPOK2IiWQ7lcvprE4WU5f0y4e/aEnV/7cv44e1B9cQNjZC3z
         gmc3zZOhrZA+/AlVrhbMsPEt0DRdlOto7zfqIhgsIjSOENQejP/a/AWr6GgHsEW24ylz
         1j9K/+4Q/oujv7E/1/Jkq+rcPLI1Gy+XCTTZfx0nv5haOQ5FFcfGCfMFtKqXzi4WCnOI
         b+T05JBWeDPOSzh+nESom313bNfjSNFk8Z8er/mZP3SFUdL08YrXnMF0e++4l7ykRUnp
         kLZehqO72dz4UWtTiMehVLV3KP31wdgUGRo54PPgbbjmkYsmXKxNdM7NAky2wsSLkGlK
         BmUg==
X-Forwarded-Encrypted: i=1; AL+hErHlM2vEqndrCfq2vdUvdcEyek/IWdVo7gvh/6YkUA4KQnO9D03ocmVxsf79w3m5SUahl5jkEZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MkQLWpnlwfHK643gbCgEBKYHH/vGaETrtnGaqsXZIFWjPlhKN
	2scBY+V3qQ6sq+HVDFw5zuWXfcntZvoHgI1CcTfZXbLsKMBEhj6yujiaycoMIP7nRQCExS7R+bZ
	z62Qf4M9yDQBzJyY55DKx7jV+hz2a5aGc7QyQuAw=
X-Gm-Gg: AYBFou3dVnCUsv4oc10njO3ilzVic2OUOBlhUmYpNXovb8qXUAmYFDPZJBXUEdFwYwO
	/ublgY8Xm7dwWohSBTYMCmpv2WdC4Ua7PkpCJU7rwRPFtks4xczXTicyMvERP8p5CRGPB3nUL+k
	GxaHkMZmW92np3wEUuF4cX0jSKfzfuKFpx9Gz33ri4xWL3DAiW8C44CYps5tQrIKk5WL1ai9wVj
	5gfmwQH19yAbMZp+0HcLqJXDx2DAiIsVOL7ZsSYNv6C58qxefiflCd9J7Eybb4okiw9JoeV4wYG
	2zaMfsj1SzOtJVpKY5WGWvxuTkENI+LrBsuRHMhPKLxYVtreEcUHXIy794m3ImfdLueQbFkpRLg
	LYg==
X-Received: by 2002:a05:693c:8357:b0:36e:c07a:426f with SMTP id 5a478bee46e88-37520218a2dmr3752045eec.39.1794329851138;
        Tue, 10 Nov 2026 08:57:31 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3751fc3a433sm26539eec.9.2026.11.10.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:57:31 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSVjfbOy+6Li8/mrEmgfTAZk9pjE0e6I6pX2kMrymD0=;
	b=igskeO0dU3czlXFLU3ba5Ctyixi/3mpmhqAyoR0afH1i5cZtn9wxirqKTypweqxdarSCf0
	nm+3JYM7Npe+xc+vRZSGXIqiuK/nnDRDiONzihYmVdv+yteq6kdi3HIfWWkoB2UwyhP5tR
	ek4m/meE/BlTy3JjB9lznpSNB9RYcpU=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 919b48b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:57:28 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:57:25 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Ildiyarov <alex@badcode.im>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
Message-ID: <avNM9dfdW1uULJUf@zx2c4.com>
References: <20261105141006.95083-1-alex@badcode.im>
 <20261105141006.95083-2-alex@badcode.im>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105141006.95083-2-alex@badcode.im>

On Thu, Nov 05, 2026 at 05:10:05PM +0300, Alexander Ildiyarov wrote:
> Peers, allowed IP trie nodes, the per-peer dst_cache and the per-device
> hashtables are all allocated in the context of the process that
> configures the device over netlink, but none of these allocations are
> charged to that process's memory cgroup: the wg_peer and allowedips_node
> caches are created without SLAB_ACCOUNT, and the hashtables and
> dst_cache use plain GFP_KERNEL.
> 
> The amount of memory is bounded only by MAX_PEERS_PER_DEVICE (2^20) per
> device, with no limit on the number of devices or on the number of
> allowed IPs per peer. Since WG_CMD_SET_DEVICE uses GENL_UNS_ADMIN_PERM,
> any user who can create a user and network namespace can do this, and
> thereby escape the memory limits of the cgroup it runs in.
> 
> For example, a process in a cgroup with memory.max=64M that adds 100000
> peers with 20 /128 allowed IPs each grows Slab by ~790 MiB, yet the
> cgroup's memory.current stays below 1 MiB and its memory limit is never
> hit.
> 
> Fix this by creating the two caches with SLAB_ACCOUNT and using
> GFP_KERNEL_ACCOUNT for the hashtables and the dst_cache. The keypair
> allocations are left alone, as they happen from the handshake worker and
> are bounded to three per peer.
 
I wasn't aware of this trick, I think mostly because most drivers don't
use this. Does any other part of the networking stack do this? Is this a
normal thing?

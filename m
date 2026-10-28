Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213268;
	b=l+cuvftR2vK0GYFE+5p00JclZp8XkoYX4vT8vEP7A1s5AjL0DZeY83j12n9Ro6OT1pMy
	 dLoBRE8gcAzKWCaOdAq7RTRSBFnNxnh44HXf5qLcJYQh/RbOdaMrUaiv5vV/bsvRZ+Smo
	 89VG5QFwVf48MEsOpseTiiqvA+neP8mlZZ3ZNO6C3Ao0CQ6/EQvPvfsREEzwlMe6bU+LZ
	 gYdwN/nEfhLd6dRSOjtPSlI0kMtq8UTO2z7Cm6Aj0F4Hr+8HzmkRN7GK1JTgi4/Pt3PCT
	 3oKUZqbB1U/6/H/s7C2ueZONv4RpZVzD7nni+ho9dTrZM1RIjMsQuUyXL4RtsRoqV4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
	b=MthEFOsDXGq6OR/urxJ7xcrN88aaHCdTlRWpmvW00DGDvgfaFJHNDBQ72YZdynXPkdZT
	 ZevX6yCd0uL2PX9x79/N65iErBXGTf5D5dDRibBu+1tOh4BMunJoR3jfXyrfziF6e3x50
	 C3m1T9fMOwhMVgWo+zL4fnG44TPEMizSoavMM6WPuFr7EB19kXT6VIfKCQgImxKoWkFtD
	 dD90ky60nEkU/c8+sjGlIP0mKIUBToqDTKzNBWxfsjwvEPxDotP7DB2FBwEHml2ycCWFZ
	 BBF88eDh5zzs9SiQlEqQ2Zt1+K47NSsFIsVjkAo8uOHcpdHoh4m/2HmQifEdoHQy5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxASVbqK;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA6606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BA6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxASVbqK
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-675676afc3cso1590167d50.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793213266; x=1793818066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
        b=XxASVbqKrfkGzLbOIsdd5WJ7B4uFlWZIN3QwO7ecCrTSK8F8HfC3Ct+49DU2Ldzeb2
         zZGAZvpELJtGhPnlkukpFSJmZrjQMvffaA6dI3ZrOgl5z+eUBb2vIi+A8s6tgiptqoEv
         NUNzSBpGerZn6aXtY88hgUXfca7H1MNPPjWQYrfKc6zkUqnRNw/Jsbciyn/qg+VMJpH/
         2CtWvQimfVfsQlyWBpxYwkOzl/LWgSIExJKmEvQFe4EzYg/pUZmX+BzadlLjpwSOW9aP
         A0t3blPnotgtT9O8R5dG3xd4HDF+0/2LO7ibR1QKDZSqUeqe7WSwHqXdu8WeyvjYYXKg
         YMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213266; x=1793818066;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VJjp0Yd9E1hslhB48A2qpjBkuVbx4yz5XzIE+9Cd0A=;
        b=rIde5Tdb1uKtXX9UTi1fgo4fnjKPKd/9NVvfzVsz7QKTJJCnCxnRpYtbOBpEE6/uOW
         hkpocX+sbKZH/mC30YnFlP+9brwLLmV0PsPK0Kmb8Ld3ggolww12RfzQ+bGjHjuWsqme
         9LuJYC4CR0w7zJi9reA/ia0FWCu5gq7ufRE94KlqMKkl9+cB7VRnYTmwH6QZwUUnIT4J
         b1FC2reQ9+WIFO0+AZ6rI/JRNvT75SI0L2C5C0WZhnmNGEUjealpIsj90IbwZJx80GbI
         KXDPO1tdQHCoEB+/twPpyCRupfvSB4P92V+4WeIK0xNHSeCzycoM3AELSX2Dk1k9c297
         Ya4g==
X-Forwarded-Encrypted: i=1; AKwUvBzrxYakjrQ+6U52vTEqWP+dSQgA3OwNNjb1DP1597YW0jzvximBfiOT7Oo+X5DdAoZYPg9x6MU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYUSa0Q9o500NUxsW9O34HvfvxU14moRV+D1TI9oSR1T2/9sA7
	hnT/zNIqAYzFpyPYWVS0k5f2iRfRMgWqorwFBvKupZNV/Z8BTQEfDjT4
X-Gm-Gg: AYBFou3YiPffhJU+tafgaF7Q+C5gR2Ag3E25HD9TyvyYayoihghwt0kOJ8YsHGZO3qC
	h+k4C7UdEP9LUUzHfymTHS7tKG6b90oMMU06UE+4hP0Rj3gYAlKqcLECB7p9Vo9GyeCkKAC9X8T
	JhHJKgPNjmuvI4LsVmHTaA6hfKGcSVMpDZU4FWFxRxX88u2SG7i1Bi/q1Zri6QCJXSQAgUxzv+P
	sQPCwAc0hqtQeCY0ISvo6r4Stu/Xu2xbBihVfZoSfHYk/DGBeiWWwqiZx9Eyygigpvh+fcyqo6e
	YrN8RroAIUoeMcEPVBEf+7WorhSIGIONZyJoB/xhRyzkuMdO+RofdYUnMdDapGXbKbPuJfsgCTS
	8usVTTHuOzHHZqZKucEwYVrxiQBs9yN5Gks8OGd5cLlTJhV7sb4PIQT9jZGTW7kZMmANF8WjpK0
	ImRHwYYgy9s0DEjzrnE5HcIjp/y33C2Q1uyx0vh1b5lozDbvni4nunTdgVp15d4p1gwmZBebQK7
	kEisnnC0jgvvQsYQBxhTXwcYv8zIYGAQ3guEC5mwIaCpr05RJ5pb6/TOzGarivg7xx4SfiFPpbU
	fyHpcbtSfo+H0jDoKbescjkgT83gC+ONR1ZHgjIHck86BcDA1bG7ezAGqQE48hz1aoleAB00ljm
	IrClAZaZT7xYGATHIjo8M5qFY9vTLhL9HfFCkQo4Q6by1G6ZUAA1XQL5tH3T63TrPrTcG
X-Received: by 2002:a05:690e:13ce:b0:679:8c43:a140 with SMTP id 956f58d0204a3-67a7bbf9a0cmr2723125d50.31.1793213265901;
        Wed, 28 Oct 2026 11:47:45 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a19b1d8sm2196764d50.22.2026.10.28.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:47:44 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:47:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Kyle Zeng <kylebot@openai.com>, 
 stable@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.139c2c63190ce@gmail.com>
In-Reply-To: <20261028181450.2221013-1-edumazet@kernel.org>
References: <20261028181450.2221013-1-edumazet@kernel.org>
Subject: Re: [PATCH net] net/packet: check TX_RING fragments before memory
 accounting
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tpacket_fill_skb() adds the full non-linear payload length to
> skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
> PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
> greatly exceeds the device MTU.
> 
> A near-INT_MAX frame can saturate sk_wmem_alloc before the fragment
> loop rejects it. A subsequent refcount_add(0x40000001) can temporarily
> turn REFCOUNT_SATURATED into 1. A concurrent TX completion can then
> drop that apparent last reference and free the still-live packet
> socket before refcount_warn_saturate() restores the counter.
> 
> Check that the remaining payload fits in MAX_SKB_FRAGS pages before
> accounting it. Include the initial page offset in the calculation,
> and move the existing -EFAULT handling out of the fragment loop.
> This preserves the accepted packet sizes and error code while
> preventing an invalid frame from injecting an oversized byte charge.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: use net_warn_ratelimited() instead of pr_err(), add a Fixes: tag]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

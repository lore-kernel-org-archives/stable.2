Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26455616A4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000384; cv=none; b=OBcR30nT9YfoVpSCAz0lcSxkfB9tcK9YBuDqjQvSB58AUwFMVvYduV3uSiCOgpWDYadPiMmY+Rf4Yw3E4FH52UghZdxCKtWmrRkR8ro9aZqmigSxk1gwohp5xSer+UiqkCdITimyXprg+2zenOpMoaZ4RCuh1Tt6VAIvdFiVCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000384; c=relaxed/simple;
	bh=+xRfdEstPEoB/0nLtXWtVVOiZOJPtIXTR+WV6k2Yt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJUwoqTLhZIsRhp111JyIcNPER4ArM7IeXA5LZyF9VSMoRVGMV+LH05O6GOXUdS2Ew26v3d+ez1XIpZPmjGoh9d6Yz7NBP8aGfBBIEvuMly3KF0bYJhzDd+EmP4bt26niz3qjwW//IGD2dUsDjfLilB2o3J4o/2BfqEDuWI4rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=IHdhk+8T; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="IHdhk+8T"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-918f75a68f0so71116076d6.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792000381; x=1792605181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zsq92fxVdxK45zQgeZwO9L+7uNriDQM/IAKXxnDi/WI=;
        b=IHdhk+8TbZ9+MHOja1L3hCQI5WRVs8ODzT+XBsVN9WxfTbjQjv6YviNSZuKqOunIGh
         b8550FvIYq2uokyw0bE+b7UM2gbjiwN3Zu9N4Em4VUZVwIBOYsr7+NKj4ja5KJTd/aZW
         gajfntqizqiRuWOw4AB56z7IlQg6IXBIHUplTjUu4NiGXuxmm4cOIpKmdHS0ZIJBqTYz
         a0iYz22yw3JmaP2GXxtveI46YtDHYsK/VNZWDLd6Pz9VSj6rH8kCuS+aM8ywi4CeDs0C
         Z1uqImcdTHDtAr/vLEqE64o0Y74XQlHATveWFoecArb+zLr9KVIezzhleSXxEff7iSf8
         nwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000381; x=1792605181;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsq92fxVdxK45zQgeZwO9L+7uNriDQM/IAKXxnDi/WI=;
        b=RT1VL/PAoAbBDyeXpGO5t2/DPqGhaOsWUu/g8gaam8xZO1O67HQCCxC+tYdvVT3SAM
         bwFLwFf66pTXZRk2CARta95N+cBuHewGl+3yrA8d9q90pwWq86f67AIbKf60/dMKPMCn
         vHvZ0QiLdQgjDBfZj4HF9pYo+VU7a2HqpIHuWGZW7sWw9uulCJjdP8Zksp4/nYN1AU6t
         mKXE0H4SqifB5L62K7npmo3Ett0hcOaSXgptE87pdWC9hkkQ3aXOjJXFXebb429KGOmS
         VRp0E5EdAfi7XyCiU/qRXaebBYuWJrNNhPGA6zXdzWLALi51DVJijiU5t6Cu8LHsLPlb
         VZ0g==
X-Forwarded-Encrypted: i=1; AKwUvByo4x6oGssy2q1s3pb5IiJ4wW4+qgjAwFGS/e+X9F5UtSmeQ6TGcbU9DLE6tv3eldyopXZ45oE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYojUZh8lC0Y3zjEfL5D9TJcNg8FqMYxGKUS9rQJuZmzCaDHsJ
	cTdjx8ta3HqzKIUpxVG/NTktSkJCfRWVWAd2yxF1O2vqPYV5ZcnUW+LlsQkri3j4X/8=
X-Gm-Gg: AYBFou1ZcYXNkgKXgpwjcdy69TjvsG2jJiILWabA4gbt0JKxixyM17yeELEQ9nvnqJh
	IGO5L12o6mGHFKXu/FkWjyUQdcIaGE/mXzDhzfaYaSyFAHmWAaN5gTpFR9PSADnYzyMK1r/fcs4
	LvQoVGncnDDinfdvGuYGOJWVKS6VCyzmehXxLAOSYEZyheNA2WZxzRJ6vS4Kqq91X18L/yFyuIJ
	odHqjQlAnb0veVRB+qiPeLTRlqeF0flvetAY57Mm1nRmwx9MfwFZNGPfZMBXkCggUHa0wWbEoTv
	n97VIFi00DE1mKZqTdikexdQDDu1COZ5SUsEaf7xJcrV2RX4ZxiW5E8IWPBxN86gSV5D804tYGO
	k/XRL7dbkXud9Oul7glo5Qwsl/tPn8jYZQel7BBg7ymO2vn5zm7es+1aGAV7zyIbVW0+A9nchtK
	rwtQkThxBU6yZUOmvL1y0N5YRHRq11KV5T0cC5MlPbU9oC8uHbRxOMU4M1wDkVlgoMTge5KZaBn
	9KGdShcu1oCyh8i
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:f13b with SMTP id af79cd13be357-93ec12d085amr2683326985a.69.1792000381143;
        Wed, 14 Oct 2026 10:53:01 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm58301296d6.12.2026.10.14.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:53:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
Date: Wed, 14 Oct 2026 17:27:18 +0000
Message-ID: <179199883858343.2.17884063473154560573@toxicpanda.com>
In-Reply-To: <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <20261014135154.05de968e@pumpkin>
 <179198668564919.2.10323410751655182155@toxicpanda.com>
 <20261014173042.0a74a25d@pumpkin>
 <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 14, 2026 at 12:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
> ...ERR_PTR would be fine too? I'm arguing for explicit return values,
> not "0 means failure". But I don't care enough to argue, I'm
> respinning. Thanks,

I respun it with the sum starting from ~0, and it changes what goes on
the wire, so I was wrong above about ~0 not changing the folded result.

csum_add(~0, 0) stays ~0, and csum_fold(~0) is 0x0000 where
csum_fold(0) is 0xffff.  No other 32 bit value folds to 0xffff, so
there's no non-zero value that can stand in for a zero sum.  ICMPv4
folds the raw sum with no pseudo-header, so an echo request with id 0,
seq 0 and an all-zero payload gets a reply with a checksum of 0x0000
instead of 0xffff, and the sender drops it.  I checked that on
loopback: the reply has 0xffff with v2 and 0x0000 with the ~0 seed.

So 0 can't mean failure here without changing checksums, and v3 will
keep the explicit error return from v2.

Thanks,
Josef

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A969F37B01F;
	Fri, 16 Oct 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194280; cv=none; b=ZMjdbKd244pYDgHvnlmuUvW1nEJRKhFH5zKMI8lI6ne66iaTKENjmqs7wqbOKwXF0TrHa2SgsBKb5yk97W3+itidb3PfTTGvFz38xj/Q+EWqENRVrPymJVKpFHvZjs6HwRwSbiRUI3h/WFBYFGyrwSXa9HkAeqd+n/iMUnqXL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194280; c=relaxed/simple;
	bh=5VCwJfE4Z/P9x23klDvOwkAvTc0A6r6We9QB5Bn+eqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpVRzQ9xjVl69M1FPeKz/X9ILkknVMZ6ewuo4P5mDSGS1ifChdf/tmk5VkO6iAVuZ//RrZhuuZeE17mURO5ffz1mYZv2Lw+6uzk7r0tyNSjUKGeCuOvX6oGWI8jrI/itFCKqrMBAt1Yb9Bf/AcLhzVvmdov/SxxaohmwR+TdVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMw0PVOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMw0PVOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E9E1F000C4;
	Fri, 16 Oct 2026 23:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792194279;
	bh=5VCwJfE4Z/P9x23klDvOwkAvTc0A6r6We9QB5Bn+eqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lMw0PVOeK8HtNUkVEqJ0JVSxC+8ZXyibSi6zKJWE2EOtw/qy/D9gkRJ0GDdGEtrih
	 QtHD9JBNbWWUBQ0VsT86MqXHLRlhpiUA5u88311aPdXyYLWri2R60Lpdrrcm9ovQKC
	 t1WK/y7z1R8GGyGK7jUsCncaFY7De/TqPo4shFwZh6ImJAxELGDW+pYlKMfDs0ddUr
	 h/ISGHO5Z7OROetmqhcuSs6sa8nLWT/P+upPhoxCwV/1fN+fDqWYfX2Bw6a2G7wVUz
	 BUFUk6LpRv2fy5w0dYTEP21VUIdbBxEpV0i8cRa/0YZqZqTXlz4XHaDXeanQxRFy/e
	 C3kWmWFVAsprQ==
Date: Fri, 16 Oct 2026 16:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
Message-ID: <20261016164438.36b334d6@kernel.org>
In-Reply-To: <aslESokQPvYCWarH@devvm20253.cco0.facebook.com>
References: <20261008191114.3736826-1-joe@dama.to>
	<20261008191114.3736826-3-joe@dama.to>
	<CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com>
	<asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com>
	<CACKFLiksRwZm+Zy74G_u59yEpY5BK+xRv=r6f9Wpo6WgT_TwDQ@mail.gmail.com>
	<aslESokQPvYCWarH@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Oct 2026 12:45:14 -0700 Joe Damato wrote:
> I could be wrong (and if so I am happy to drop this if statement from the
> code), but IIUC generic XDP runs from __netif_receive_skb_core() after
> software GRO, so the packet it sees can be a GRO'd UDP packet with
> SKB_GSO_UDP_L4 set (because maybe the socket had UDP_GRO set?).

FWIW indeed, generic XDP may see GRO'd packets today, but that's a hole
that should be plugged. Real XDP can't deal with super-frames neither
should the SW mistake^w I mean emulation. I started sending some patches
a couple of weeks ago to plug up the holes but got bogged down in the
bonding interactions :/

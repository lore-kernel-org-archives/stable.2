Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222082;
	b=AzdeLQIsDGju+QIoJh6PS2xfBKTJS7ClcFKivMQv1mVlyxPVPj2bdydQRB6t+PRUGjSm
	 yXTx8VnYUFyQVlVigKScjGgTSEgxxAvsskZ1VPtsOP0OF/i7NALBMqmZGflNzcfYPcWhH
	 je4Jqq9oHOEJvuXq+OB3t4yxl9Ux+2j2BWE3AyKBPRMldC4dSI0sd61WN6esTQHds+BYr
	 VhrElX3hhZ0aSYxfcArZ3COxFKWAUskpp2EAIao5pKZ1IyorNMO3k28MBpR3vCK0GkXCo
	 Kk2KfG0ptec0KBjDVbwhzb/DCJLpz7wFS/F1ca0WlghJDtdjOUiwKTb8YKqkQbqleWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cBNynnd5zqGP6W8jWML05LhU3hMAEMMow9kN5eJ4T90=;
	b=TrlPJX/jbwNldzwThhH7VcLaM+STVmpVaVD26RyLtIlcrgu8Fr8NPWIMuz/7tAeY9P4z
	 N3va2KCQSFpNogTE7j3uWSgTBBuB6sKwbhHkirsJvtVLT+I9ynqTJHr9ioqxg48VdmnEd
	 kf32urOzPZnJmAaKGOcFPMMvs6aof4vi1Xc3m6P3b5Q/OdqikymoOgUgVYhqEtfmY7UJn
	 AJb4r3Oi3ThA7TyLDQ6TdruEPUk+3L191kBuhn6WyODIjF0AjYS9d2Eck49jg3uXaZyT1
	 qHskQZrfaCL5ikh2RjXjk+VMIUdnncXSaaqvkRry5N4moUcIQvCD3U+nRH2IEkdvIBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHtF+QpI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CB606A697
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHtF+QpI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AE61F000C4;
	Sat, 21 Nov 2026 00:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795222081;
	bh=cBNynnd5zqGP6W8jWML05LhU3hMAEMMow9kN5eJ4T90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gHtF+QpIhNIM5CUpjcr05/i4zd3ftTePLBLVeKrM675G25prhXRlw9wJv6COexrAY
	 TMHyK6h8i9NVKoQpPB12V/Hv6i9qNrJsW9DtRZybb02ZhgRCSgQa21lNDBUZHhUgMb
	 E0UXfnAaZUfClFkf7BFE/xF8p01dCVxyeB3Z2tParUW6exnM2Ym25aKjWx/sURXZDA
	 wnnK+DTK3hk8Ao1Sl5D5Q04kfmfadAXROjJTcbRrfFP8FHZFUln0JVXKnKCrLL3f1C
	 NFADM31upgsDv6ZOCQFegSrXfcFCeJi9gtWfOE8exlx3rASzOIjtkC8q0WvtmDAvfY
	 3e3o/MkzMIohA==
From: SJ Park <sj@kernel.org>
To: kaleshsingh@google.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	kernel-team@android.com,
	android-mm@google.com,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: swap: make swap_header badpages a flexible array
Date: Fri, 20 Nov 2026 16:47:52 -0800
Message-ID: <20261121004753.83107-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120061750.2973004-1-kaleshsingh@google.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Nov 2026 06:17:49 +0000 kaleshsingh@google.com wrote:

> From: Kalesh Singh <kaleshsingh@google.com>
> 
> The swap header declares its list of bad pages as a one-element array,
> even though the list can fill the rest of the header page. Since the
> kernel is built with -fstrict-flex-arrays=3, the compiler takes that
> size literally, so with UBSAN bounds checking, swapon() of a swap area
> with two or more bad pages reports an out-of-bounds access:
> 
>   UBSAN: array-index-out-of-bounds in mm/swapfile.c:3674:26
>   index 1 is out of range for type '__u32[1]' (aka 'unsigned int[1]')
> 
> Kernels that trap on UBSAN reports and panic on oops, such as Android
> GKI kernels, crash instead.
> 
> Declare the list as a flexible array. The layout of the swap header
> does not change.

Makes sense to me.

> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org # 6.6.y, 6.12.y, 6.18.y
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

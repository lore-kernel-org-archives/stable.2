Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275365;
	b=05+oIt5d53vYoy+P1WGPCA68kqUjIT6QZ0SG2x77FeB+q3Rdsvwmd8P1GD0kHnCKKjYZ
	 51AkTohJh5mUcqe3K73SoOxUcgMNgp8Qd0XzzJ5Kp9xJMyaljV3FGxaoGz51MWJk3Eq57
	 hTat8Rj3/j0kzfToU6LT2lwHIQcr2hmuHF4afWeNF8LcbBiI9UQsickfoJTvGs6XiHFxV
	 L6sXULTM73YGGxGoMRdzytVoPxhHi46v02E3MXe29QxGJ3Bf00iTaLna9fSeqmYkUSDYV
	 RSuBgqMZRFnGiegrHA4kmd4Xev3nsNViOO6xzgF66KaegprC9TWE7g+dIJv6/TL/PSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275365;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=dGP3oQkxG3O8JCUGO0KxGDQL8mkVh24OfjeHZDaL43g=;
	b=A8uvJX20iv0QjmssCqyB3TSgOrOGjUe4xMiUR7nFgqB3IpYRG9etJHHFEytoLQVSWUl3
	 z8/TFRnO+A8H/uGvd4CHy77MSXm1adYgb901CXjT3TfGPt2NQ9yGKaXI6krU8ZhUwI4vp
	 ACZGta2nUFsI65637O59Drd2xgvOw69wsAj7yERtb2sx6vU8TOmzI9H9LGbdm6voK6+eb
	 c0TNnwXbevB8mR3XkGY2bVJ4qv7+kEFfvOFVrba73uKAZIKUpa95yZmLfa4b45s3TcrPA
	 PMe0IN1DUB58AGsaaX+qp4OmwzLKQdd04sH/AuWKMsC9ZAYyFCOyvqTewyn3w0ZFmKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=E3LOkK27;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D9606A321;
	Tue, 10 Nov 2026 01:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=E3LOkK27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794275364;
	bh=7OfvsyWkqHG1aqQLcvzobdPCzMSRDAQfKu/eu5xKdxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=E3LOkK27gn5eHFSrMZGs+cczhqLC6805mjcsN8xtgdjPeEK39Tyh6Pui2Eni6eJYt
	 er/7/IDmt3Kr2ehckzAsUPgnbhD+/0YW3U+gagGWKiNjr5GmPoeFhsPznVX/S5Mjcz
	 RjyzV2yPPBqYqrTs13Y1J+bOw2nJxNxMd1pwXDOw=
Received: by gentwo.org (Postfix, from userid 1007)
	id 0122F402BC; Mon, 09 Nov 2026 17:49:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F29EF402AB;
	Mon, 09 Nov 2026 17:49:23 -0800 (PST)
Date: Mon, 9 Nov 2026 17:49:23 -0800 (PST)
From: Shubhang <sh@gentwo.org>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Uladzislau Rezki <urezki@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmalloc: reject overflowing vm_map_ram page
 counts
In-Reply-To: <20261101201659.c6c07375429df81081ce8b0f@linux-foundation.org>
Message-ID: <d6fe4283-0d6c-5fec-2252-af68b2c46b83@gentwo.org>
References: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org> <20261101201659.c6c07375429df81081ce8b0f@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Andrew,

On Sun, 1 Nov 2026, Andrew Morton wrote:
>
> Is there a case where userspace can actually hit this, or is it a
> theoretical case which can't actually be encountered, or something else?
>

Reaching vm_map_ram() with an overflowing count from userspace is real
(as noted in the udmabuf path earlier), but actually hitting an oops or
corruption remains theoretical because in-tree callers don't access
beyond the truncated size.

The changelog described what happens if a caller does access the full
requested range. I can send a v3 clarifying that the failure mode 
is theoretical if you'd prefer.

Thanks,
Shubhang Kaushik

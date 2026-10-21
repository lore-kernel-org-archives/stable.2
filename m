Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591363;
	b=V8IeRUofyuT51wqxpnsPBfQ5CXs4fngAKwr3iUGGwxcslGe/86FpRt/2jDjvp+WL3a9T
	 xBP0iC8Hv4CXymK3CHQIbCg9JIVjMOe+43HrKJsRl8NVBn5U7Vc9y9ikwpyC6D8UuwvrH
	 90YqaumIdo7KKdoIFLaICMXFHI7fZMrY2KEckQGeEFJxuTPI3ja2tNH/0tJ9tCRQOHWeP
	 7W44bLt1y95nBZyirdMTWwPaXo2sztuPAXkAIRFs/p6uqr4ql5D2PR9Ru4ul+T5Tv1Zan
	 rhGpZk1g6/XAOMJel3+hLRyqBT7F3Bnmw3EIqhIVVcKlgMY/v8Ow8BVQCBwdXFLRI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i+sA7ukfPfjD0qmbK6dckJqDn7Cek/Mg6lo2porw7DA=;
	b=iqanG/JrXsFQg4cx+ljqRwuzE2OSEtTWy6bIb07d8A8Dn2SQK8o38wYhidV48eRvNAp3
	 +BLyyTOtGTawXmqKFZwlZcDBVkr7VYPbLJfs23ICbjvvi+YMrMvbTMWNSjfpFr7EIX6lI
	 afeycwt5zdeGb72iDcMLvW3QPHwEEJsLZ6YH8G+G+g8jhx4O2aanmF0e2varMdvruVx/C
	 GJF5n5e24ad/LaJs1Y1yXr1K5USxeEW7kN8JE3JYmKSSxRSy+uxdr4sTHQCP57xZyzTWy
	 ggCNV4bxfjOu8iyXMO/TprKzvspqCsGQigZNKRSyWJhV2egIc/CFAmn8U52OLlXPp0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h6p0hCnq;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91B606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC91B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h6p0hCnq
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so6521965e9.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591361; x=1793196161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+sA7ukfPfjD0qmbK6dckJqDn7Cek/Mg6lo2porw7DA=;
        b=h6p0hCnqdn51jmybMmwZkhu34yX8gHJIAp1vbiZPzdHJjGvyPlMOpJAlrtx8cezUF4
         ldNehgGB1QK0gn4uMVrAetTcxTAwVCd5nNHyCF3+9m+sSeCj8XjycGn/Z3BwC94UqGEZ
         +93WiXmGtoJb7DrRltHDtLZWTmsHdPlEFDuhkwbcCNzkOxoeqt1zoLm/ph5M+4bZMmn1
         muukZh9lglyyhyc7EQc03bhTjBiAxief+o6CZA8MlE7ccKMWcgB/JKqL2ZQqdKWVoRZM
         vov7BypJQOw1+7lfnHScMAB41IquXrjYXEAwptP8Ynkuu7W0C6F4JnLRuxJUgbGNEq0t
         yDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591361; x=1793196161;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+sA7ukfPfjD0qmbK6dckJqDn7Cek/Mg6lo2porw7DA=;
        b=HdR0koCoONGwncV0ugG0ODDwMR/nZyhpa+4xESjvbYQ3R1n9a/Tjm4g3WAKRtFi37M
         6rttWz9jL2BlPDrwo0DpN5AZdV/8eKcxpqztD4uzABKVbc+XAwM6Wx+sqjg+eJ5/B9HJ
         GA9tr8fjpwbLZ7+TiZ7Xgzld9JpJM8Xp09up1TlHVpuxN5moYTX3+DFvKs/vlLDmYm9l
         Dx/ChkTeAmocLGmXr1+BLbz0MqB8ndmTz0taNntMJwwYzQxVUKEXDubMXFUt8Mn4+Nph
         12RwOOLG7q63d4UI05gfbAj+u7Oh9LYBA0LpdMkbZCZwX8i9/seqX/oGAlP8R2x9YLHE
         Whmw==
X-Forwarded-Encrypted: i=1; AKwUvBzHZZUQsy1rJle+4Uz1RXfBXyQ2Jvg2AbBmk0hPJrRMbkv+DzjVStA7//vBgv+2M2essrzR19o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7xMtjJ9IvMdyEMhLQel46Q62yv/nikZ24+ZHoQy5bNKDVy1Jq
	IcrVFzzDRDDkQEmVs9HNlm48EIexAghpLe+CHmdwCaz8xH45dNEfvKyJ
X-Gm-Gg: AYBFou02AHeQcVoh0DGojAl9RZqK5d85RDK4QB1fbEJIV/XEXvHx5HUHZtAuRKVD3KQ
	9NGczEQt0RFkV3rvTThFzu1l4TqBZ6kNI0N0X+AZvgw6FqSA87n1bzFoWRnubyWrNWqcMWHNlbk
	zYRSAxuRJuVQnjO9vBJx3UlxVA4oeXJjYELrO4MKqaePxhdTGRPr6i4iOQPeFOqVRDv/DmhJHVN
	lMrdPQXkRuHiF+IODuHiHDtsp+lOiTeT1fP4NMJNE9ja0t0IN8gOTK+5fHDnFE491Zw6FQpVGle
	pIy0J7vugFsVlTiG/vOCiAX3n9KkWWebhSvsW9dCfEVyDSl92y+3sgZXT/r+ImPlghfVd7Zg2HL
	4Ebr9DhnzeSXqqoRhx008hIWn6FYOFSigAezUdY3AmGaGYan61ROvr1hUhWG5/iIYuPpHtwDMZJ
	RVjWmuNtVyKF7i+AfslG+JsHeaurJfIPz/yasAJk4DYWcycM6dc44A+7Mbx9STGF6av3Sht60kE
	FW9sEYXjXQ02spcqAOfANDCeer7vobKrhOi1OjTqE0/dVUxqTknRoTILCuNTE0o2cbRIYDqZsfy
	LiWM+CdJlWkA60kRo4CTomxRY+5755y9IcrrpcjT4ln1KTgg+wDfxNeXKbqb
X-Received: by 2002:a05:600c:3507:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a1fd8cd9e8mr46111525e9.1.1792591360723;
        Wed, 21 Oct 2026 07:02:40 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([150.251.170.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc10de99sm50954045e9.1.2026.10.21.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:02:40 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:02:37 +0100
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
	mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net,
	roman.gushchin@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atjF_eRnuzH1IZ2_@C422HJQPQG-Fractile>
References: <20261019185002.3428594-1-gourry@gourry.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>

On Mon, Oct 19, 2026 at 02:50:02PM -0400, Gregory Price (Meta) wrote:
> user_proactive_reclaim() limits per-node reclaim to
> gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
> allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
> folio, so writing to /sys/devices/system/node/nodeN/reclaim never
> reclaims a node's movable memory. A movable-only node, such as dax/kmem
> or hotplugged memory onlined movable, reclaims nothing and fails with
> -EAGAIN.
> 
> To reproduce, fill a movable-only node with clean page cache and write
> 200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
> cache stays. The same write to a ZONE_NORMAL node frees 200MB.
> 
> Scan every zone, as memory.reclaim does.
> 
> Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Makes sense.

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>

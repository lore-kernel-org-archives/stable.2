Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413194;
	b=cuez90MW/9GQlOMX38auHyAg3nBtOSHEzWVrPFBEJE6fOg4TMAaV5f3cxoAYF8wIp0/W
	 oi+owaOU1HnpS3gXGMgmb3V+ZFHEN278bA5uKyALpB2Fcq84P886pydDpJnn8mJco9YFK
	 qp4YOSmg2Nb0Yxb5FWKeI4LNwRe5FEteVXbi+QPxQT4sUFMEoN4W7KwtgSV2C91DuF679
	 IwOtCcZp6eZwfekDgMYnTcFauU212xLR64A7sattqC+gQKmANIscwGPoXBJNLV+ShOYdK
	 JLCBSNoxFK1qBERB6l7dntJ8qHS1A5/sFmjgeikyzmOKOf/RWTHWfiTl0+nrmDHwGvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
	b=zrRRjWJ/YzdtjLwp5FR0GnDHUgRG9jufTpgchUuB9zVMm1cfUPk9WXkSRus2hjYBxuGy
	 tqb98uTG7oIfICUieaEErynPE/ydr4AfH9LwU84oNGnQICbUA0DfxRPm8GkqLsUAicci0
	 LiRuJws7D4llWcljdrjdNx+kMyQIiaM8HOF7qdbWr1eV672g1ALAohLx9SgZP55DZSRk0
	 ocEdUMHl8sKIZjhcdPJ/n9yWIMrufnC+Q8yYw1X2Pcje9vCbbeHwUDu7oNCh9ytFlr4Xk
	 cMm9CxN53/HKNEe1JnmzD+pTmlMf5g3G0UjHBXm3l2mAxHKks1PKuVJ7I7hY2TLhmtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kegsq8uh;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A7606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B3A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kegsq8uh
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b3402105b9so19013337b3.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795413193; x=1796017993; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
        b=kegsq8uhmtxjR/pJOhtAujkXAVHKSFRBNZ5lrlH8efJHm2VcBfXxdujDKKMzi5Mipr
         SfZAkGi5sRSP+SBD+2v7+dgCYbevza04Rs72gGs6ihAO9KvLXlkEoHv3/sb+u215IWoK
         T4VxePiP3BCDMF9LUIJVizvgJEpFQ3Q5wjM0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413193; x=1796017993;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
        b=bvWUi/XEGfQR4rrqOfuUoBy4i3g5o79LiOXI1rS7gKzby5Qthkc0ABqQ1IucEvrFU/
         gDK0GXWoD5N+OMcvfe63+r/Hq0O7aW4yYVwcKkqPS3y1KdenQ798tZfhiwL0+9oST5Qn
         LPi5Bwfnctp4wg76EqK/VyuZ1u3sunLQ2J8ku0ukNUzkplssELXSb42i1Ppg7xTNXvTe
         jzoycU6X6RhW/Z+uL5FN/MwMZs7bg2PnBqGVyBpxhS0ptKpoen7vGaWaXTT6hOoiEBDp
         6ncrwY5uf4sY/5/HS1qQ4ZZ/XMVS4Z2thCf6wjJTBAkU8BPGRm6blL8CjlkBolanzZ+M
         wOCQ==
X-Forwarded-Encrypted: i=1; AL+hErH1KYeV+VVKIwLqFK4SZAhz+VkEms0riPGqCxPrA3da115jij2scoqqVKWHtmf6zwf3MkWvnKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nLLJWsY8bBe6XQblciFKyyD+FK90Dze4+Cfrjy4Tkukb4Fm50
	d/yip0kgs58ZFn0/57oPquuvBL4q29nmoFtoSFPJUMaOrGhksPrkb+w0X4Pql2NzNHI=
X-Gm-Gg: AZFdTZf4IU8u9SWqDKc2Vs1r4fxX8LSNcePvjLiyVna0tPYrQFwIJoZudRbRqhWxVGZ
	zzdQcntMjHY79OgYsmcBoihfZTcKTymGvY+LoZXzB/4+KLW5dmYyW2nK4OrfCDx4nM4wjn+aLFd
	kD25zLaF5EKPVTyJBzjgF1fuevdndjNRKvWFlKVa2dHIU6TZxsFGG3wjHHSQxywakSiAylrWudI
	p2w5GoKtQS9RAYzO/uoAA1i+7399tmq0Wz50BM1SmWEDgX2nUOVSUv3tvZnEdOCU7hDep5lCj0x
	6PS4U4gHitSXKF6Lp4vsCW2m0HxGTs82sBY41YKFP5IMUNvNeDysdoOQgzSYneVFOyO3cLqTIeN
	0ka+3TKZIrKJRAYq8EXnn5jVX9jvmbJU5RH3ZSy9k0t/hkfItd4/gOywtxo+2hAmyWVUoZsxTa7
	Lurwk1xrvUAShML6BxYAd07G7uqkP9ieXUUfsUmVF0yQ3znQy+HlBThI7Y1HlQpNfi22Vs6LLoa
	daol/DzXYNQrCQ/7eVNzk8mlwbUXlL45T2+tDNOlUDCIytvYVBYoIhrCvkq6hKfriZTMpjYFP40
	cYTQpXMh8cKLBLo84KXXQPlm1zt5hzACTnrxXdBS1t6LyGnqE6vU2KLRXY7h89l5+3R3QT5W6R4
	N+xOcx+zBvuNHmgo99iBWT20O/gAJ4PXcXSdAGUbltmqCSJ7tZ9sWhfdAkislBTI1/BlmY/ggpC
	u1dRQnQbuGM+ugV1wyJL2iSMF1Aq506e975xTtIGuQ+OUVXIO6ip91FmRvnl8S2UOk6G4b/RBXx
	TtWFdp3ROPo+sc3lBbqNahcMuq4MrPra4Me6G7i6EMNa47gFghrL6QxYXt7WK+3cg==
X-Received: by 2002:a05:690c:630f:b0:8b4:dfc2:be60 with SMTP id 00721157ae682-8b520528bc4mr36338177b3.107.1795413193110;
        Sun, 22 Nov 2026 21:53:13 -0800 (PST)
Received: from [172.20.0.3] (static-host-74-205-137-217.epbinternet.com. [74.205.137.217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202dd36dsm41031237b3.26.2026.11.22.21.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:53:11 -0800 (PST)
Date: Sun, 22 Nov 2026 21:53:09 -0800
From: Chris Down <chris@chrisdown.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 0/2] mm: fix deadlock on the folio lock due to inode
	eviction
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <awPUxY7eDWuo_5qP@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi David,

Thanks, this looks good. I exercised that in a VM:

- with the series applied, migrate_pages() on a virtiofs file mapping
   no longer allocates destination folios while it holds folios from
   the batch locked
- splitting a file THP no longer passes __GFP_FS to the XArray node
   allocations
- and the migration and split_huge_page selftests still pass

That said, I didn't manage to practically trigger the deadlock with a
virtiofs mbind() migration racing an unmap before this patch. It might
just be that I am unlucky though, and the code looks correct.

Given that for the whole series:

Reviewed-by: Chris Down <chris@chrisdown.name>

Chris

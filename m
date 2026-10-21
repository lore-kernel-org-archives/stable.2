Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590144;
	b=zu5zX7xghmtYQBPAR43fjExuJ+FnxEuqeJEct0WLMM8QvIzXtuJLC2bsP0s5TBr5hyRy
	 fwrperH9Yvvm8DmkCRhcCrFbni81qWJv7rcqF4oZdGnIp2/Q8oH3OXPu7NgD6/cy1jE6I
	 r5bql0q3/6dc6TrrVn+e/gOf8zRJ+ZQgMOXY5jv3tU3pqAqFfDPQqIL7s4ZBNYXyHpakJ
	 o5ZZZlZHH64UJ+cX9szl4C+WFECjCBDbpont1ukwamFJPFMJZ9ErwB8Vgz0mAt3KP7byU
	 ZyjZWgxrpRQhV83rGKqyovxnB3x88cUfhHVJlRd86v2UhmzLuios2mVCScFctUjRLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bibqzip471YCJrx0iwEaAHwRkbbTyOfLVqUM8nPUu1Y=;
	b=lKBlVUVTRjnVnRlfpcnNuP4Xajaaso6TmsDT3/izYCpS2xSBTJ8KyzVkm35DARdBErlr
	 o3nC54jr7vDbapFgmCDh/nvm0wR3JG7zWs/VddohWNZspH9Sa4tEvhvq4RgNwgQfUSch6
	 8jG5SH1nVlV9i1DbPPE2Ces9KAWJv6d5t48tIQi3Hy+JITDe4FrVtMaHztQlm9r4kDGQ4
	 kLMp0Sk6D3PhLXst2YzKzjSVgUcjEMGKauccNu94JeD4yo65KOP8QTDDAZuqKpFS7E6Pd
	 XCENC5VjnD+Db8gt8kv55D56dALhDho+RU8M1AHUUeTHsjEM5ezijuSPpTL0gdEi8Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="pVRsPr/S";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFA606A32F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AFA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=pVRsPr/S
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f20b304c0so84926985a.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792590143; x=1793194943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bibqzip471YCJrx0iwEaAHwRkbbTyOfLVqUM8nPUu1Y=;
        b=pVRsPr/SNXWMmrBQxtPCmJxpck4LeHByjYHSq4uHVvUdCe88al1vC/o8KhlNEoffjM
         nGFr7IVVatcuMQBcHw7B9gV7PyzmT/wGJ1WplkWIT0N3rNRvn88qKaV0ixufB3nOXnUo
         jZb1monFelSeWTxVK4n7Z8Cv4FQEw6V0ssk2AYkk+5eecOPL0/AOLrIsQ4U1lEeIgnw+
         6icZPn+UZKSj9GcYUXWalUQEm6GDK5XuvFPpNbDIK2DKQQy93lBMS5R8oHlW+P4Grafc
         uo6+gZbZI0WB/Uptifu0W5OXkx4qIlpHVuBe6adRciqelRoNliwLMMhA4/79F404xsZd
         n9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590143; x=1793194943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bibqzip471YCJrx0iwEaAHwRkbbTyOfLVqUM8nPUu1Y=;
        b=JordfsWhQOSbBW0AJ22UAp5WyS5gtHbK/4mAt+00TGl6WQBYN0WieVGmZUOfO+7j2c
         ViDABjCxI2BSUs7Wl7YQ6HeF+ZsVXNy4N8jjRTEaL60xQ3oahTwcdGhIW5yWuc4wRy/f
         vMtudmggdN/cWpqd7DuaP7E1kLSAtT2TDibGzPqRiQsD9VoKvsG0pMKh8DVvB/C1ofGZ
         8Ayu/Tx4l0U/R9d0pZFLgEZWlNUlgPLpHGSUCZJUDW0/IBmMYf5maXSLR2cQzMg0xZ88
         Vv2V0MxVFta7Uc5AmJ9IqAkNOfRRyRbAI04L1UTJfsh3bTNyH+/hqDanFUMDYwLx0N3l
         +jSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXHcDR4+/VSvtfS12E5FTiUOERBPbSTsP6vZI8Jx/wdeRhxi2iEm0ExlMCW+ivkhYZxDs719Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpOzPiuvQBwMQoKWSw+yi1RuDuaf885xdeAW3xYXCbYdQ3X6SG
	38QCOTSe/Ea4nTCf7WSkf45ItJxT/NsWtXtxEV9jrLupgAj44vaGuKB8n9ujxiJ4OF4=
X-Gm-Gg: AYBFou0tJ4jKympkgibJIPFG8CpdVX1Y8Ddaf4xx43BqxVje8mkZm3dWcRa3vtUAfva
	BSUrv6WzuPKuenGK3mPoRvR2exyH7NVW3ndVWk+tbVe0147ySpyJiiF6rDpcJLDaE3yT7SpyX22
	bPtWa8et6GDbshImi5jHyxSP7RdwNSVxH/2UWvxRAiHOeDWx8uibN0qkvWH0VxMi/L3Il+g4JFn
	I7SAViIs33lXCBjjp5yScIND9oJLAyFBP7cabBPU1mebCjgaBELAOMQG6n2tDmiI9dfQ5pPuWIL
	av5h6AGJTj3IkJbHREhIpCHRvHjWA6R+K6oF1sdOZeEsKYevMOtCu2Nlb2BrcHcrtQ6FGLOJBME
	IW7FjYz1V11us33aaEC1839o1WrTuwtdWUJdsZLglWPgszbcmd4Ummtb5aBlTnOekNYuuebfuM8
	JUsiFPXr1oz65V3kDmSmZn2gdh5j8xoSsEKO9szLCsd3kod/SJIp2REVYmxSSUxtvRPJsbsr9hq
	E/z+iF4K20Ab77vmn/wiuFUQvIhet96e5I0q+Z8VQ9wJOhiI3FOY5Fvhdg9wFfIY4f5jZIJ0h8/
	OyYVeoq6EL5eIj9pPDOeJ8dofRD4rW/j9tML
X-Received: by 2002:a05:620a:2556:b0:93f:258e:502d with SMTP id af79cd13be357-93f57f5eeaemr425264585a.63.1792590142562;
        Wed, 21 Oct 2026 06:42:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c6ef4dsm261445385a.3.2026.10.21.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:42:22 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:42:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atjA_SOLnihm1TmT@gourry-fedora-PF4VCD3F>
References: <20261019185002.3428594-1-gourry@gourry.net>
 <atiwhEIudhnK0pmQ@gremlin>
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
In-Reply-To: <atiwhEIudhnK0pmQ@gremlin>

On Wed, Oct 21, 2026 at 01:31:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Oct 19, 2026 at 02:50:02PM -0400, Gregory Price (Meta) wrote:
> > user_proactive_reclaim() limits per-node reclaim to
> > gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
> > allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
> > folio, so writing to /sys/devices/system/node/nodeN/reclaim never
> > reclaims a node's movable memory. A movable-only node, such as dax/kmem
> > or hotplugged memory onlined movable, reclaims nothing and fails with
> > -EAGAIN.
> >
> > To reproduce, fill a movable-only node with clean page cache and write
> > 200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
> > cache stays. The same write to a ZONE_NORMAL node frees 200MB.
> >
> > Scan every zone, as memory.reclaim does.
> >
> > Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Seems sensible to me, and since it's become the review of the ages (TM) let's
> try and get some kind of tag record here :P
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

1 line change
20 acks

This is the way.

~Gregory

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456614;
	b=QSgdE9dqXhyr2xfxGzaJRqcHvK6eWF6hA2q15kK13uYReEBnHbybbvnAiAz3uxPb8Lz7
	 +obAmRwCxiKiMJl7NfEUGODsmvxDUKBnzBjYPYNzUtOOzN3fZp0KmpkzKV2HwE4vJUQpJ
	 cAOrZhWMix4zwqsaq0vEYD3yYtN1MlNUoX1joApuozb2KgUuRTC856U4+9uM44r0+SKh1
	 UfC7amx6okbetwA10lnljLCnhBvXuwzHk64QBlJGd+mMmrrARrV4Rz4XEGO+OJPdtNQqu
	 wzaIjZS61wsD1ey1FD0rRMTOCUzVlmW3IH+roqK1YhJEL5nHlYrvJPU4XT6HxhQKd+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tYLzgEFMLbU+10QLZBwGrlpV/UdgmwvgieWaGFdOtj0=;
	b=uTbhEnRwdAFtucdm1sHIrewwKlf5BE77cnjH3rC0lZYNP5GZ9jClSgEpVGWi5X9Sh0sz
	 9gHQqLMlBOT7fezLvPQJgeH0zQ6Q5Y6eNZhH/BiCvTa24hL+fhLSJaitEPsbiCGLfUEp2
	 9RKnBvCWHqLsy0vX2zadhjo0nVcaH+EMY8c3xTgIN30ZD78EvYUzlpNezvG3R2ub7OFKR
	 e4goYjxghKdYoOzdBKSv18wLRY/3XMkwGo0Doj/UGCKGJbxWLD/7HntDwF5htGW56JlAa
	 aEqC5fGPDaAcQQc0gMfAD/vmwh0uU75qCtnRKbggdI0+awA4DQEWiLro9v+agz8zU3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otZInzdJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303A606A319;
	Tue, 20 Oct 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otZInzdJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D3C1F000C6;
	Tue, 20 Oct 2026 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456614;
	bh=tYLzgEFMLbU+10QLZBwGrlpV/UdgmwvgieWaGFdOtj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otZInzdJ0WqqGTrJUKQhZw7pVa7NMN17igKQC+9rr6tbJdzP51fDgHCFkWSl9LtZ8
	 fM8YmPLMMJ1yKftyPi2B8nEG2QZVpyCxJ/Pq9nXCGH3W377WSFxbn5KLkEAbz4vzX9
	 FMIVuIbgRapHFExU9ZkKgfor7qZLd4s862FaHTb7Vl71owzqXEJsDd+tmMmko5jv0s
	 H3IqK7C/hb3UEMRTu6t+JZbgh2U2VLdm0U+L370MeF4WXqHxh9I452ZMUaXSSY3Ah3
	 m7xrHUpoiXZ2nxhGQ8MCQGfRhzAULebfxudD25lHj1z4C2H8GVrZliOyF0uPKa5LI+
	 TWRMqqWS8u2lA==
From: SJ Park <sj@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	ljs@kernel.org,
	dave@stgolabs.net,
	roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive reclaim
Date: Mon, 19 Oct 2026 17:36:45 -0700
Message-ID: <20261020003646.105993-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>
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

On Mon, 19 Oct 2026 14:50:02 -0400 "Gregory Price (Meta)" <gourry@gourry.net> wrote:

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

Both the issue description and the fix make sense to me.

> 
> Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

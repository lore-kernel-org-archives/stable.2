Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222377;
	b=s2vxzZFE3C3P6cgkoF7Lw2WpLxZ+YSUhzOa+u0NmF8xgf1f0cW4njH9GB/t023BeN2Gf
	 JnnI9DFmhEg2C4SJU2B7qmgwJsw30bezUtc0Ih5o66wtTPyILtPCRSHWW7+FWn0ZzDUwd
	 4NH8qDrBMugMWBYu15xV2PYnPGLztIr3BtAER8Wmw/pOaDDLnzBS7ASRUAVKl23xjJNb2
	 6ZWuzX5lBDCGLGt4DnGvoOY4T6LD8eGIl2ehMO3ry8sw1PBaxRSXJ4HBROtJr+2I1wTff
	 H91AFQUftxRMRQEq8C7hNDYMntzh63v4cSXy0kdb36+brVAQ8AEKHXJeRvfzftj54cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PNVblBHL+6qDLjWQDk2wT/AjEGUD/LVbbIDhYzYguRI=;
	b=OeTqdvVr45nAMpujznDEx8OmVQaAAkFJhwkSmn23qm6W+vlS1pWeutFeAyGfBcfmlDKz
	 sFaRv17T6462sJLDH6cBTSbK2pMMOgr9+h+ApVmiA23uWPOgDiirpYgWfYrvGWAVtf4Rn
	 u0SRdttYwUN+b1J5LVE9l+RGxflsZkp2HCFj1nwPI8Gk1xulQ+3dm6SNcuHRxsbP1VkwG
	 d/Zv5lORfXP2WYFVZ6uoHFghGKQdx5PVwXX2hzgV8YHQxrw6d2mmoG+4zCNsYqxM/lnQX
	 eWwAiRi8Oq/tYelAe/3CYd8fEW7khbOZN5yuhSIUakPaqVPN9mt5ubKttbCYg4WZpxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzU32Fgy;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB04606A325
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB04606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzU32Fgy
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365d26ccbdso19306621cf.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222376; x=1793827176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNVblBHL+6qDLjWQDk2wT/AjEGUD/LVbbIDhYzYguRI=;
        b=EzU32Fgyn9m+vjrhYLpr0nTYWcdrW/2pw3szh9TumHoA+fskhE22xGAHn+OvSu7L/I
         YqTA2qA3O28e903prE3UMIvrpp7A9YZnUf7pxmsegfKQdPPh30v5i/J30FwglhSKlJBt
         4Q1E8zsNbsfX6bmU+6w4aBeoORx12zVFRjpoue7xaE72RbcBFPzndWTCa8fdmWDYR6zu
         hEwPyHxuB1FbxbBJ1ASOtJ8BthHmLFM5BhO5C3eAbfFokMmnA2Qcok5xoEcdk2NZ6WIp
         YdVQ0RDLupxrAImbjLzE1xiInSHet62tRsz6K9viwBxmF4UkzQRLuRkN1IOy8cWKENUo
         IIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222376; x=1793827176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PNVblBHL+6qDLjWQDk2wT/AjEGUD/LVbbIDhYzYguRI=;
        b=Njfy0lXarCQkMYwVAHuOdC2LNTLgWAN0iVHuyaQmZQAOg8iYWk3Mgkt/Uw49sRYAqL
         qGKCNB6c9BaZ5kw74MCqXY+OSEjFUT7/uDQXbLXVYhkxcbIuVrv687Ds/0FN+7qdYEb7
         n5LzWqarzfX3QQfG/bZdYKhebbZJMKXawXsTqANJ04ZO/vTufexchpXJE2fB+Ji42KyG
         gPqb+8G9Mf6/ZwlnSpwnpMSyMm5j1eJytns4MSUu/wDzELgMKMr2F4dacYpzcL1v3zpf
         hi5Z7/l/iox8BZ8m02UAzWUfAdh2ibqTVkU23D+O6+274/7OoZdwAvDbqOf/LTcXsn0E
         Nx+g==
X-Forwarded-Encrypted: i=1; AKwUvBxWtYS/ESV/Fnrj3t9hQD3Leh57aiM/f7RljkFBcsZhROvr56EWQRjPD2mRgtG/lvgyVaXjskI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgjE8aYUn4Z8XzoI87ylGKIM2XZePO2Vx3JN3WjOKfeNWaWdn8
	w5Qxrzx42/Nz3vPT6tVFD0NZ72l90ok4xTCicKzefUQYsxMawfUY29NUQLrQFEDm/1Q=
X-Gm-Gg: AYBFou1YOi9KV5Ta81r+pDqVtr494K07R5K6rl4E4f9Z/8HIx13F209Nq/a33PD/7ZR
	c5cVFGTZiLSXHq6q+DtKdPzfCRK2HhT8ElJrj1Gjctn9mJXrBIiNagq9VhzwMqWGPQ6uQfC4WPd
	Uo4yxfSZ7eXi20qNapOUtvlVJv/ShyI7BBqTXT0OwlDDsBzhHPuqEotGLwnN1GFrURAXUiMH1qm
	kWFi1FAwcv8EGHwmeSCmR1009ByZNtC5PC2LCVGwXNBlsMm6z/309ia7ZBTdDOTIeuzA6pJhHpg
	KHaNd99CRDcyqQUf6vzs2GfH+AZ/SXkIdzM03ZcXOiAhBvULEmY2HZXt3UHJ/AZSMGwUhH3PZ/V
	kZYVK8eTyOwZxH7hytLWmqhukDoCIyLeDtqQVxoyml7eQx777l8Hf6DFBxBj/QZOu8QaTH9j7xy
	2MsotewApoKNeT4Jl2b3HXKDgv7VjQ7sXzLeaE5qnM9rDzCKC6cmg4xGQacslqXZ/KcKo+IwGvA
	tuFJzUGhD8B1e10zoP9iLepFDBll0IQxde6LGo2Bk6zn0STN24vM66MqUV435aY0nRlGnYlimF6
	d59l9rWg7oanZjTwq/zSWyrsziLww0KlDRwJVe3Fx6y7puanj1a1v+okxdcb0LL7vZ8PlK9dWDU
	NHTkRTiK2g3vMBLQ=
X-Received: by 2002:a05:622a:1a97:b0:536:1f7a:610e with SMTP id d75a77b69052e-53fc8ac8719mr64026671cf.6.1793222375961;
        Wed, 28 Oct 2026 14:19:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:35 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v4 2/8] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Wed, 28 Oct 2026 17:19:24 -0400
Message-ID: <20261028211930.3504634-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028211930.3504634-1-gourry@gourry.net>
References: <20261028211930.3504634-1-gourry@gourry.net>
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

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 78569ac6f2d9..52533992ea16 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.56.0


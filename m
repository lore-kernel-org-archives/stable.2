Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550387;
	b=TQiQon3FEhRn9zkP1ipqMT2921muF6cXlgl3HkfssXuVPe5HxdNzMiGgyeD7mCJMiXq/
	 uW21Lvuk/HmzmGyacDzHULNUngkcbP45JnePXy4LMM8TsEtI/V1lxaN8e4OHNLTTmsdDo
	 T6TpS2Kau/KlvM1+KL+aqDblRhpGMFYrMh63PpftjVKh+PzfSr6GzMvPWtFfLwiwNvwqs
	 R7EnexvcFOhZc+TLIKut/LQs6pkDuEEpP85MoobXFHioSjT1xqIZLvgOWjpgy0tZ8esgP
	 VpefLz1IfK7DQZGzXT3M1/rgCixHD5SK3QY15IjIku0uBfWawIaeWgAtTqMIL4XLS2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
	b=sj2uaZzJ7aEWQ9qu4JXwrDcPjCWaLNuQ0FQKDwfIqvMJKzRuSqOYRH+Qr9zl6sTX9lz1
	 ApE9/v0oIoekAyCeUAw12/q5H33twxhYf54RSLGxBABx+iD6JzdQnCdFhYQDanmoSVLjC
	 LQ0lWRPfVwfoIFlbWW/294sP4LpkT0Un72xqztr5v3qfLRoovWbQ78gqjTUf+mJMqjU/o
	 kKM/yURuOb0rlKEAVnAXhR1HGI7HiOVgqOCZvuNlJIVU8SKWPocJ+vsT8X45MyBZgCRKq
	 YKnBjrclIubj2YaK+Ufx/3stO0U4ReNh/QozewM4tvA5z+G+iFdX458KTcOEEGSIoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DlBQVqmd;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18687606A324
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18687606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DlBQVqmd
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917aca1aee5so3150536d6.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550386; x=1793155186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=DlBQVqmdggJzMLtVctYMORoaOfmN3U64fiq356uSAOANZVzdQ9oXHdCA96fpkln0YW
         jbjerg8i3RIUGPPHhNsiTruLigBMA7zORq/KYkzeEoJT6eBDrJAZZNDq/deZQlW3u4cq
         ceHB1ClEmbYMlBds20UE8TCR0KAU+T6PttWRFREuWdJXvHGJf93DduBoT/ObaZC3l5vj
         VVaj5po5s1U6oo9fftDJoRDKJGY24THmSDgk9gldIp3GI4HTLEFmCwRVonUcJcdQrO5x
         BSM6CXIQAYjRrdEUu4h4jfl6bUB4gcqeFIl7UkXuDmxnrVCW8UPWgEBjSMHA5u9l6/1P
         K8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550386; x=1793155186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=kccavIPHmW7Na/8mnRStZBgEWjx1Vr5uANA4j3GN2nzYtSUxJ2AY/aF9M7qOoPTBvZ
         h05YFfhWx6swUFuAGQZvyPQZuGtPkDXb54IrfF/ZcArFHbDKqKM2e0ccuoSXp1illMmd
         2vNipJZ4pOi5i7F7qvL2m3tu41JXxccRCaTkv4qnPh4kNqgoXu8Xj2qvqXYEInQ79ea9
         f0BmxvcQ7l17DY1/0RIFZqyWPLNoACS0UVOh7nxizuMpItEmb5mMxp0bR7GVv2Baxi64
         dIkmhl2JnRoYVxO6bL9Zt7gUkVO49t83h/Z4IEDy5dNqPB/J1wf0mvn2m+YsfJ4e6r2X
         Xu5w==
X-Forwarded-Encrypted: i=1; AKwUvBw3HWau3iwxUd2KAOTYXZhBHtsirMCaLbt6wPf2KGQT3bS3oIhoTULY+5xYrxA3iQCG0PTSLmg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLIrkW485XQ4snL41eG5DDN63+Iwfz/MjKfiOxWq7RVFuzOoD6
	+A9ln5lr4kMdFjuovOBPXV3enEz5pxM6WX5SGZRI15d7tpryqz8EHk8Oh68aTLUk0oY=
X-Gm-Gg: AYBFou1J++CPVpo6Q/8KWZwWXdQFbVve2UKUDbHQ2LFgASQ8eL+zHPz+9ORx3P2sjq7
	6Z9BSJJPEJRs5T33IFAOiz664KtWFcVQKP1BUIM+I/JXmTYy95GowuIH/tHxN9iag9X+IhP6TkO
	SYWNksowwOOhTmUBDfPSWqWx5Ua2nGSyobO7lQZd8D5FSzbTQmZGhoBPHfQG4Lnu25msRH0PEbZ
	NKV3QZxSKR0yCDSlXTaDqknN+wd+UetejEWyULcT5QxiWz2mVDML0ZbVGLiqoBickGZO6wLnMQc
	UHQU8ESeIfawBQsQl+cWAzq1RflAk6Gfn+DqHkc2pK/rID+/UFWTb+sK5oClnYMc2u29kd9u7BM
	oeWoYrBE/WPk3P5kUT3zkDGG4FGIZ68i0mWHcXHcU2oeFWronYpE793pwElBaB2PBnQ9HEuGDs1
	9UUAGkUIB8uota1dE7AmjSEF43wp3woGK9iNi9Qnv/OBNTeHAWeHAXxJzknR040k0ho2310IThj
	AxZ+PvufLaJYVPJvyttLl8VtmyL1BiwMJXVxbd5UjjlSUi9TTlaPt3RMT9gEL4KaKn33RlT6HKG
	AwnOCDAccBJF4VPVJFj3kYdL+gzSFZ0bx0kKp59slw==
X-Received: by 2002:ad4:5aaf:0:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91c12ed7e09mr12120496d6.25.1792550385953;
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Tue, 20 Oct 2026 22:39:33 -0400
Message-ID: <20261021023940.1940971-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
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
index 2daf358269ae7..c7125f6693574 100644
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
2.53.0-Meta


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499260;
	b=1eiyvYmR3FqV4hXebQIc8JMDWFPRTEVg3Vd5VAfORFczf8qD9Vp72TIAuB496ix/QNMC
	 e+OwteNxw21XlTjTwmqWpsMv9NRuggVX+K2d5HEYagFtJklexMuRuwm9gKefrOYts3hfZ
	 lvOx31zD0sixEJjmhx4zHefr2zKwiFbN0U3MYlG6C4mhzYdo51/wqvhfEXHE5lRFvoGYp
	 JAmWRqRq0gD1IwXpi27mzy1pKHUAOcY07O/m7xyT1gg8gE39KzwpMI6STMWntyFdUJ8xK
	 B5iwVU+PaG4py5azoamDWQ9TOKH1ANqmg2YLMLcgT6z8KHYNm7/qPvSTE0MyU3YQZ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
	b=XFbrnfMXfayZ9G/3hxt2EalN3rcsgWrj01xg5bvc+Kv++4D0E2pw37EJTwd6M0d0ptOM
	 qctgPTRXPUI/+AeLaesIVqAMWtDxv4zQEq4ej1QoDqyizEaFR3E6IV59nY/Y7l/40jXKV
	 aL9+/iiPRe1P1vTYS7sc5fO4s/jSNcYkBOCsJSfaVqphLQ0lGfDFeY6XChxpgWTQlSrbq
	 r5u+YI/5aSUl5fLf4XsDTYljTyxF9TrDasVvNWP+w4OZbetEq/hZL2K0rl3qi99oEIyx3
	 1NuuOWcuzGWbzjpFjmvz/LAwiyYF/MnstLQO1tXKJA6r5HFYeigwznXMb0uXQs2us6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AzOaBy+w;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DC60A3806
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644DC60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AzOaBy+w
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c791d5460so22677256d6.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499244; x=1794104044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
        b=AzOaBy+wXqRr8uIup48uh0Vv3TO8Fm5iXAP9snRlRlGmnu+TAArLNbKPlr5gpbEBFQ
         rrCEkejGfBRUxhtLmAmLYeFW8Q/EqO53nWjzD4VQZ89n8QR5S0VJPHQborLwEMHL6vQh
         clbfasTLXFUx665vSN7Jsa7abyRuPAj0ELIcsB1e3M1I+/uR3YkclI2UISYfcj/4nuCT
         uLtGlIKZzR6Bbmz347AwTaSHAwhHp174M6jwe2j7kBRV0WIq00cmBKOTWyTLz3MZqcLN
         WZr8gz9h2JDLi+P2DmgIyMDSGtKgVQikRmFgs6onTlGAiw/MaZ7PlZAnuejz26DSjoY8
         vGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499244; x=1794104044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
        b=DN8Ugjv++yvMXue1n6GNWlZukgelISEy8knbe0GBpbJ8MPVrf2iwz6PkdwMdNGq33I
         53+sM0opKiraK5p9dTzVEj0v1yzFihZ9dIIAwple2m+i424fVXvlH/2VatnZJpJrwRla
         iG5zZZUkJtPGbcrfTHh4FOAAkpRKQH9DgBNCrQCWGosNxkbUR5y1d+gJYO6sQQXEJa6E
         cskiofaqBUH1ury1zQJRew1WbiG0qQTPXG+orMW6Lmifzn9Tg3/P+CRhRIPakHRXO32f
         sSz1ldqDWneZurs2zov3csBPjBiduBfq+U39oPPhYRHy9dH/VNZLMe8Zb9hEzQLwpRVv
         TFHw==
X-Forwarded-Encrypted: i=1; AKwUvBxrRTEjPanJ/8rDBYf1LIDVygepbUqKaqsoRbZFbdpTnPOoxBUfUSTEebFXOInKSjUAVrLw4hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKk6IPBbyEHlRMIX/E5fLUtyCbyqFDjx55e6NPaU5OaUhJwX7K
	fSOcDrAqecGzU/GujQYZChUxS2a5af22QmnOD1FJ0Ruf17hj22d/WD6bGWQuG6BiLPM=
X-Gm-Gg: AYBFou0MiZ6F6/m3JUaZYqJ4mxPWWsTtQFYFtHFfsonZVp5XdRrQt9h0ZRf3WtxqhTC
	T0Jm2A6Q7ZeBrzaWwpzNdo2Ce8qmuwIiRT8sLVVwzuIXCCi2O2ubj+JlqHMh8kFpR7Kp4qySVaV
	f/p2SFm80GkEfmzreOLntx2HyFCOYtid02OA3Au0OCNf0OJHw7/0wztRSxzIXRQwh0vNB1qwTfq
	XNt3XdeHioeRf8Zle1FUZYXbkkcYikEW0i8xuiMH85ZlUpvNuwfZC9jhiqk3UtIW9TxHJv0ZQns
	kImywtRaKOLoZS0LLQSHvrXYh5OoeEQMfrVzRXo+mH3BirGDfeLrXMRMSo9ucsgZQVaMHwCEqtZ
	KiJJ1MXsMyN1OhSrmQU+vdgWhH2sxDmpsXXUHJhqGu4yzoxg/aQA5RDNo+f2dQfAnYk13rx8ymP
	vm/HYqRE/Ka4IuKJ56Cp0TNHMuNRGdwi8fpIFYUB22G8idTVRlx/sf6V5QZNbFnLH0wMx/8e4DE
	QqYGDdR4a9AJysK9VDMFlgYmA55YTdiI57yOHzf8ZcSoVvp3sBwL8JTGj069ZCCMvCHpmoTpKjj
	8UAIHlAVNWKxYgeawtYAjHSIgS1gSBe0q8jgw6NV3hQdOTw80BdR9+Kh0yG+UrdqxkG3u3eWlqF
	jFNZny/yw+A==
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr1124363485a.72.1793499244292;
        Sat, 31 Oct 2026 19:14:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:03 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 11/12] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Sat, 31 Oct 2026 22:13:39 -0400
Message-ID: <20261101021340.2251928-12-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

For a bind or preferred-many policy, mempolicy_slab_node() tests the
first matching slot's zone for NULL, then reads the slot again to look
up the zone's node. Offlining a zone's last block rebuilds the
zonelists in place, so the second read can return the terminator:

  CPU 0                             CPU 1
  mempolicy_slab_node()
    zonelist_zone(slot 4)
      = node 2 NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        slot 4 = NULL
    zonelist_node_idx(slot 4)
      zone_to_nid(NULL)

Current GCC merges the two reads, but nothing requires it. With
mm/mempolicy.o built with -fno-inline -fno-ipa-sra, holding a bound
task's slab_strict_numa allocation between the reads while a movable
block earlier in the zonelist goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   kmem_cache_alloc_noprof+0x294/0x610
   do_getname+0x34/0x230

mempolicy_slab_node() and zonelist_node_idx() are tail calls here, so
neither appears in the trace.

Read the slot once and use that zone.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..cd63c3e2c029 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2176,6 +2176,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -2186,7 +2187,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 	case MPOL_LOCAL:
 		return node;
-- 
2.56.0


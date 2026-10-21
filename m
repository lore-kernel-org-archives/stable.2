Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550391;
	b=IMoZTGNMFpfhM+gXJN3oTkNzOf9JBA1cRovDhmUjNycsR3BNo+kkicCaqdUJvX/wtOD2
	 Hrid3QjAL3ri1K4zhhn7+ZMtCwP+enWHsI7cmt+3/4KTF7onkIeh0gnGk1r6QnvNAZE6F
	 3BgMk8WJC0l0nqrm/F7d8Wj3IZUqnf1X4OYoNCSB4bpETDFDNwwNH3Pbwqm7jtVwtax/S
	 RWzKqeMAB7aazKNKLYMms9TzgqV48ftua6bSojDHirWntp3FEN0cBVPWAQYmR8cAZzMdx
	 zRSmLPCNhpfEmxS+dB5Z9xiHp//kMOWOIDZjJOBCStargzvvVd5Fq2WqB/tCZHp4ORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
	b=XMs3oy8Kcg83WQd8scdLBX0YG2fQhMfQdrROT1HaxAO3rysmYCr1vIp2JoB1uLe2v4oo
	 iABPxu9WY279OffRoDbm+HuEhK50NXUihNSedViQGLNZGLU1QWhYbOaDSwilIKJAQcPE7
	 O0LClwJgvU/VDozYCLGCAT5cACwNYEP8CHTAIwPu6l/duFnXpNcdUG8siHCtdiRDnHfZl
	 xOuWsH+rGGPfDEDz0BsNewXBNMPc5rUhiIlyMgYIwYMGwPCWsECwuhE6tlsTriRrvnd9Y
	 rWwBwZg5wTwbQL/f9Z3ITG6l59UYgiMmf1E3H0xsmMsrglglhE8AiUw2U/wPjydENCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Z+c8Pivy;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84B606A332
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C84B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Z+c8Pivy
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b8306b9f8so4263136d6.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550389; x=1793155189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
        b=Z+c8PivyqpvgjCDG61uG+b1oJUFl8jlRLYRiKNl5r0nL1M+EAf2m26idpzWnMkf7Z0
         LYjgekDDzbnghMWUDHOQPVMG8s/Kk0QIxOo1DzydpFF5utcE+M6fipAQWfUKFhB9vac2
         Oo4VQdXYZ4xwqXJ+urW8ZwDFwNheUeugO5s3IDWYeTA4poneNSuxVW7e0SssT2/CjiWd
         Gu5y+k8Mdcutzf0gyb4Ejfpq9K7t/w7egvokp3BuZkO3QfjKDtoPpjDrafZtd1XDdJJ0
         308LLW2SAq8NolRT7LVC6rUL6axanuXjBLWPlMRqo23yP08dexNMCMwuDImrKpu/9WGy
         wlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550389; x=1793155189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
        b=LpPUHwrgY2oKe/Xhr4hBIJg62mGMBCOEj/fguNcNfw7vkRccrIS3qAvHut5uioZC9J
         ltZV10j/tBnDx900YTJkkGOSP3Yvt1mDrXo28ZWwBmQ7GBRWw8QBZZ9se91v9A3yRKN7
         evIGNrPGfDClMXuFEi3ZIBeODv3USH/6ee65TKWZQMFaMSRn/9KlzvEgf1AmMgVqHaBj
         alPMTw1MqQAVNxGSwgZFw8aCqdvVQ44FeVJ55JDTR6JC4++PfO265Vtff2mE5R4JmQ9G
         U0EXvQC4wqkQMXboIM9J2Atyx4YQ3b6kEgByrIkWHSYzLQInjyR2TEOl0wNJQY1ezrw8
         KphA==
X-Forwarded-Encrypted: i=1; AKwUvBy+JRz9ykICu+GAIzWgTI9p7lpoE7RGcWgG0K+WWbBeOKHBKHlvzK+twOc+3I4qZytPSrQbVZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpQp1VKUQEAXoDUVcz34sScnmeP5vdbU39+esPlBDkXIY1q2j4
	dqWVZWQaUAqGfPG5C1bKYbEC1EKDUwtyyF91Xg70uOGAArZKrEwylhR7VQNc+YK7MUo=
X-Gm-Gg: AYBFou30gg6NXMWI4IKypNbM4t9lBRFoY9BJe4ekCFmYvK7jt3M5zFjBDJ76hEmhuI+
	iaLm4Y9ILtQ6ROFiLmW8tzZO/x4CO4Txzs96yTd1Cfrlat77rZPIapvIS8pclqvaY2TA0EMYUhE
	crjtiI7PYg/k+aC+y8Vs6Dj52KMCIIkkqgmvtyafFGtmF0eSJHdHZc6K3c/+dz/EzwrrHrhaIt2
	kbIkcwEvdbshpvzhmG1LH+v56Fc7gDnBALOHK7DJnJ2W4IPtEYeb9pDBRi8XRSfpf7othaPni/S
	MK7s1R0DS+mbKqZLpuURokYUkwNS77FUIEm7qtmUpA/1ssxflPrJGNo+QqrySBb7Odo7vvzw5Co
	uoR21PM3RA20O2hu6xYc5jD6TudkoY/W2SAsiYr+LFw6QBq27qSANMdunznWdHXdQLFFxP4csh0
	GVhgAlXaxQGKuuYIGhUQ00vnsSZk1Su+2qaoD6TLQPHikjTJripKQK1EjrsI8+y+22RphTc5NV+
	AtMI3UMsEBj98NXd6q6qvqSiJCXELI9lBnFKp+4iVcLvyI8DpekSfSjk6L1KIftmG8TdnTwU8hr
	52xFYz/4N1UC5vMxIM0KyxbFO9L115D3KUXAcTnPAw==
X-Received: by 2002:a05:620a:3913:b0:93e:66e6:fa4 with SMTP id af79cd13be357-93f57f05079mr224040885a.16.1792550389393;
        Tue, 20 Oct 2026 19:39:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:48 -0700 (PDT)
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
Subject: [PATCH v3 3/8] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Tue, 20 Oct 2026 22:39:35 -0400
Message-ID: <20261021023940.1940971-4-gourry@gourry.net>
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

__next_zones_zonelist() tests a slot's zone for NULL, then reads the
slot again to look up the zone's node. Offlining a zone's last block
rebuilds the zonelists in place, so the second read can return the
terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it. With
mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a nodemask
allocation between the reads while the node's last movable block goes
offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mmzone.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580d..009f1dd75dde8 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(READ_ONCE(z->zone), nodes))
 			z++;
 
 	return z;
-- 
2.53.0-Meta


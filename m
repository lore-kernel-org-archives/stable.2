Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551994;
	b=BytSr+KuL66i1BDP5K/aQb76dD6Kq2arV2/kSR7dugAWzMd42NlcO892W4nVSCCVDCoZ
	 4UjgU+T6Xk9bap//JeDzrq9KWSH2F+l43AOfH3v+cx1PH1ZAVwon7Pu72pvxFB/EG6Qyr
	 MQf+lglfxIfuuEWUcBONYqH70D3fYPs/siEZris6tt6LgSLusTrQY/y3dzJ8fV5yk5426
	 o62x9B2AGQaqrKeG/s01UpG1ab7NWXj3nTxacBqyRKWP7J/FdIm2O3XCX70R01BZPJ262
	 zNBIyf/uxGqWMqJtBgd9mBeWlqeCWxuEbr321Ln7n2UJbehRsHHrV6lGnZvDLE2M2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ktH5TAE21QJzLreEKi040qitJNuzD7hMryn67Jdt2Vw=;
	b=amvj9ZMJP5keplFhJkt3VC9WdJUJFtSPsjLLOTr0HT0G3g0H1zis9yCdlnNLvbolAtk/
	 kU9sZD6vpB4azu7j5U3ZpzmRwKW2FrURY6TWzQD+B04GCzmezn4RYlNFaYOyl0sv3pVdL
	 L/8Nx6KPd0whgx9YfK0mWfqqsBvhmbxwL2LCM6Sjp+e9w7odJRJo0o1YyK3q5SUIiaBq3
	 HFm3473ZoqVnT3pH16KtME4j/m4KFwbuGGjvZiMBW8BHi1WR4FqiBDbytdmEq7md1z41G
	 /eXMITXzsumBrWCReRtYCELCxwFf2sn1MUMWhHtMJADk+2QqUpDcizZ5wh7LCdjOKIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCbFrZSC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AA606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCbFrZSC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AD81F000CA;
	Tue, 24 Nov 2026 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551993;
	bh=ktH5TAE21QJzLreEKi040qitJNuzD7hMryn67Jdt2Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCbFrZSCLnsCJW4ItnTARMwlKZJ8S/S+qd/cAbeB+khBU+XMNaGYripMAnl7ooqiB
	 kGUosFZEl0K+A4ol9z3LgSMweJb0CMRZR+5Ghh2Xm0muQ4mB+DuOhb4V/bWrEGl3pi
	 bqDsgMd6GCBWA/Er4hqBbedFi7/U3lQ/51VSl3yiyUvdyw3bs9ab7z4NcK3PmbaAVY
	 Z3ImdoxS1xjCGDIDCCVycw9U51mOoxqXJggH+lnyHFjk2/weZlx8Ggtf9K6nNFdNeB
	 ONHeM33ty0sUuveVJzRpvo3jF4lTk+S/5beUWxHXpJtSlcHR8gvOOuOOpfW69uDX9r
	 4Sn44mZGYmT1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Tue, 24 Nov 2026 15:26:31 -0500
Message-ID: <20261124202622.2579917-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112405-defuse-expectant-b8c2@gregkh>
References: <2026112405-defuse-expectant-b8c2@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit 4cc1bcdf2e4ebcd319005ce2ea132489f6155139 ]

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
Link: https://patch.msgid.link/20261101021340.2251928-12-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261124194508.2505154-1-sashal@kernel.org>

 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 928d0ccbb8931..6dc743d35238c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1838,6 +1838,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -1848,7 +1849,8 @@ unsigned int mempolicy_slab_node(void)
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
2.53.0


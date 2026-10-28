Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222380;
	b=eUAGgz6scXqTXosxHsB5aSNU0ONlWL/iB9QZOQvT0lCNg3cqfuLOf0pI26Q38I3NMD+I
	 JwoUbxmCRqwoLfcJo3VVt6utl/irGFBDyI+JRXwhNseywTlPyU+ILcrvcc5m82k3WfD5h
	 ioCnmAu41paSv+CZMoY2UvscY9/Bf8Cxtt6YorS+344dYRErwA7dH/a6HoRbb6Ffp+dLs
	 98SFz5M9zyKD263fhMQSCTY/dzAmPEKn0VOvic6Zc2XoOziRc+GTtiWXLE0WGnC+NxlxW
	 CBxfb5Z5Ijy5xdTnfF9aYAbggHclGVeW3pSsfsR18+fn90Rtf1RgQGKfGi4p881xSpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=woeAztA9ioPxkj5kTODOYAAuCzoQVvGCjxTGUXdVMNE=;
	b=IiatZ2afuAtB57yeKIzd6fn+skzBFjVKCgyKN2g3OT3liAdgZ5GNqk/X4HW19Lz+1v+8
	 cQkjtFP2Kwum+LQi4nKM00zLhW8lWfq5DhCSya3/AZD12QnWp4zAswuMnuso0ye9qDOcF
	 CVymMVX+32tHqsp0o1dxoQkCsRoeBwSyGrr/oP8Uh22C/Pqa0I9i0T1DFgX78y2wWu/x5
	 2Gbah0+LKdD2fWr82FOxAgIytbLhL2p78vjIXxR7FRmUwEw9D6ijrw7T4I0Q9rKAkAdfP
	 cNt4WjHRd+fO/kCt0jZNE0ZqzWMNdIPhFGOiQxr08EKnt3ayuV63Z5I/RBhqxh4amdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=miZVMHoT;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985A60A2613
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D985A60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=miZVMHoT
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c7b00a75fso16471456d6.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222379; x=1793827179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=woeAztA9ioPxkj5kTODOYAAuCzoQVvGCjxTGUXdVMNE=;
        b=miZVMHoTwh4kj5fkiBd0hF0gK7UL5cNKpnWcb8G2K2IKG0Czjpj7c6+PNIRW4bXEH+
         3405nazlipTweXHSRLoleeiXgf/SQhyA9RycHVfblUcAv81Y+AFBQ6nFI3QiP3fnpDlL
         wZC506klRTbePLDZ7gtusLwkT31N/kymze5E2lcCPtsIf+dDcypiIqNOUgwupUG78AOa
         8RsG26eN53nvj3byhhxqyxYdUx+oAEHm74FNMA+wHBWhJyvnIkt9B70ObzM3+pgXPmV1
         5RhBo/c1Y0KvDCvqiXuyRE7GxaItHIXeQ696vMr6/zqsW/UQy4WKhmKQ8VAafySdNu9O
         R52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222379; x=1793827179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=woeAztA9ioPxkj5kTODOYAAuCzoQVvGCjxTGUXdVMNE=;
        b=rvcT2THXKK9JvjxoW1z5XWGK/qcIjytjhGXnDgG+5Hr7I2LSEV3IzsQg1lxDL0h4p3
         BSOr1435ZU+cA4UA3CASxOLvFQFwsYw88RnJgY3CJzLQaPeAQ0LVAj2Clw/LszGCwJpC
         naupbIh0Y9dDnPd3hnbZetaWAPRJwmxuCCiUBn+pn0mfdw7DEcYP7fXdhLj1O3zSfhgu
         SLNYIxazuptQichCpiVlvPbQcKsMeZBeYwvqkU9T54DApOxMTo4ETUs+zKrFIdpnAjvI
         jLgRh+2yzB9MbSx5e20NPw2Ukg9BJs6OlF5Y1bgOK6dUja01q3mJh83C8jhBMhNUVqlD
         7XXw==
X-Forwarded-Encrypted: i=1; AKwUvBw4vSLRoYjecsGAVf/IC8WDyu8nsIqPNPnngIHSwjiiOhqkAhLHsv5p8LrBtXX9OpyYjsQmIjE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIElsLx708O9a9b2UwX9ThztYbV+xi5mCZgjfWfGUNTlh5y3LoK
	UfFkeRu9QLp0lMmo5GHlTeHM1q6Y/WM8QF8D8PYFDvFIt0JPp62IRvkjPTA4v7cLG5Y=
X-Gm-Gg: AYBFou1Dar6iDGin2Fw1vVHRr//sDRHW+1b8Jx3YvV1Yp6YY+AUICVXzcgKe4tP82nH
	UdNkDYGhuwYZIquOcE2FmRdZex781qwKtbM3TnUAbp3WOMKN/j2EmzPkZOYasb4ZwnOZy00vQK6
	dPHULiZ5ddlDxCusvlK9Gib0q0GxKm477FUHnDZK7x5gmyB8ao0WX/tXj8mI26mZEVl4bk5n7ea
	LLorF9peprUgVIlzqlNBTCSIm4zuxlmH8dGF7vcos/CJiKFWdZmI0F3Qh+wTcuwvpu9zsSJ0VIl
	Qb6IhYiMchcEEzM3q5sJncrKfHTPmocd8uFi4tpwX3fGC3WkMOFSGKGRqj3cn04g/ipcK+RaCHh
	hr3GrtozrlZef6a729Ahn9lMWhsmBWD1yV1xg2jYQumAojnCQl17oWVgpgm0xkD6lD0NeHiOSIO
	cClrhlZkmv9GxWaipqQY0l5+kPMhwQjJG7C0WU0KvZkqi8/vvYi6+jxjirU5G7aifIYV+x5h/Ie
	Sed971vPCLbh1eWbeE9P6dt7vGQpSh21+vxG8nFYr70jVjhaTvrBhy08pP2oPcAzCvHsAaWbN29
	EW+gnsyTJkCo7vW+Ib6EAtRSMlCgq/N6Yh1yv2zidK7thIZzefONOv5cilNqUzopGsrUtA1+cv1
	q1/6jZkWLy/221zY=
X-Received: by 2002:a05:6214:501e:b0:919:5a24:d77c with SMTP id 6a1803df08f44-91c7cf99ea6mr58383016d6.31.1793222378818;
        Wed, 28 Oct 2026 14:19:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:38 -0700 (PDT)
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
Subject: [PATCH v4 4/8] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Wed, 28 Oct 2026 17:19:26 -0400
Message-ID: <20261028211930.3504634-5-gourry@gourry.net>
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

Current GCC and clang merge the two reads, but nothing requires it.
With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
nodemask allocation between the reads while the node's last movable
block goes offline oopses every time:

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
index 9cc9ef588580..009f1dd75dde 100644
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
2.56.0

